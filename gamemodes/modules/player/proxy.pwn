/*
    VPN checking
*/
#include <YSI_Coding\y_hooks>

static 
    RequestsClient:API_client;
static 
    Request:player_RequestId[MAX_PLAYERS];

forward OnProxyResult(index, result);

hook OnGameModeInit()
{
    API_client = RequestsClient("https://blackbox.ipinfo.app/lookup/");
}

hook OnPlayerConnect(playerid)
{
    player_RequestId[playerid] = Request:NONE;

    new 
        ip[32],
        string[256];
    GetPlayerIp(playerid, ip, sizeof ip);
    if(!strlen(ip))
    {
        KickEx(playerid);
        return 1;
    }

    inline check_ip_blacklist()
    {
        if(cache_num_rows())
        {
            _Proxy_SendResult(playerid, 1, .add_to_blacklist =  false);
            return 1;
        }
        
        printf("%s sending HTTP_OnProxyCheck", GetPlayerNameEx(playerid));
        player_RequestId[playerid] = Request(.id       = API_client,
                                            .path     = ip,
                                            .method   = HTTP_METHOD_GET,
                                            .callback = "HTTP_OnProxyCheck",
                                            .body     = "",
                                            .headers  = RequestHeaders());
        // https://blackbox.ipinfo.app/lookup/131.174.113.235
        return 1;
    }
    mysql_format(chandler, string, sizeof string, "\
        SELECT NULL FROM `ip_blacklist` WHERE IP = '%e'", ip);
    mysql_tquery_inline(chandler, string, using inline check_ip_blacklist, "");
    return 1;
}

forward HTTP_OnProxyCheck(Request:id, E_HTTP_STATUS:status, data[], dataLen);
public HTTP_OnProxyCheck(Request:id, E_HTTP_STATUS:status, data[], dataLen)
{
    printf("HTTP_OnProxyCheck: Status: %d, data: %s", _:status, data);
    new 
        result = 0;
    if(status == HTTP_STATUS_OK)
    {
        switch(data[0])
        {
            case 'Y': result = 1;
            default: result = 0;
        }
    }
    foreach(new playerid : Player)
    {
        if(player_RequestId[playerid] == id)
        {
            _Proxy_SendResult(playerid, result, .add_to_blacklist = true);
            break;
        }
    }
    return 1;
}

static _Proxy_SendResult(index, result, bool:add_to_blacklist)
{
    new 
        string[256];
    CallLocalFunction("OnProxyResult", "dd", index, result);

    if(result == 1 && add_to_blacklist)
    {
        new 
            ip[32];
        GetPlayerIp(index, ip, sizeof ip);
        inline insertion()
        {
            printf("IP %s added to blacklist", ip);
            return 1;
        }
        mysql_format(chandler, string, sizeof string, "INSERT INTO `ip_blacklist` (`IP`,`Reason`) VALUES ('%e', 'VPN')", ip);
        mysql_tquery_inline(chandler, string, using inline insertion, "d");
    }
    return 1;
}

// proxy.mind-media.com/block/proxycheck.php?ip=%s