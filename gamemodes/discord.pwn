#include <a_samp>
#include <a_mysql>
#include <discord-connector>

static 
    DCC_Channel:reports_ch,
    MySQL:chandler;

public OnFilterScriptInit()
{
    chandler = mysql_connect("localhost", "root", "", "southland");
    reports_ch = DCC_FindChannelById("705791066892140644");

    printf("Discord connectors FS loaded. Reports channel: %d", _:reports_ch);
    return 1;
}

forward OnReportAdded(playerid, playerUser, cheaterid, cheaterUser, reason[]);
public OnReportAdded(playerid, playerUser, cheaterid, cheaterUser, reason[])
{
    new
        string[256];
    printf("From FS: %d about %d: %s", playerid, cheaterid, reason);
    
    format(string, sizeof string, "SELECT `DiscordUser`,`id` FROM `users_data` WHERE id = '%d' OR id = '%d'", playerUser, cheaterUser);
    mysql_tquery(chandler, string, "OnUsersIDSLoad", "dds", playerUser, cheaterUser, reason);
    return 1;
}

forward OnUsersIDSLoad(playerUser, cheaterUser, reason[]);
public OnUsersIDSLoad(playerUser, cheaterUser, reason[])
{
    // format(string, sizeof string, "ID %d reportinio ID %d. Prieþastis: %s", playerid, cheaterid, reason);
    // DCC_SendChannelMessage(reports_ch, string, "", "");

    new 
        playerDiscord[32],
        cheaterDiscord[32],
        string[256];

    for(new r = 0, rows = cache_num_rows(); r < rows; r++)
    {
        new userid;
        cache_get_value_name_int(r, "id", userid);

        if(userid == playerUser) 
        {
            (strlen(playerDiscord) <= 0) && cache_get_value_name(r, "DiscordUser", playerDiscord);
        }
        if(userid == cheaterUser)
        {
            (strlen(cheaterDiscord) <= 0) && cache_get_value_name(r, "DiscordUser", cheaterDiscord);
        }
    }

    format(string, sizeof string, "<@%s> reportino <@%s>. Priezastis: `%s`", playerDiscord, cheaterDiscord, reason);
    print(string);

    DCC_SendChannelMessage(reports_ch, string, "", "");
    return 1;
}