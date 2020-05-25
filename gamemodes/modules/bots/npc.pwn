#include <YSI_Coding\y_hooks>

static 
    planeVehicle = INVALID_VEHICLE_ID,
    metroVehicle = INVALID_VEHICLE_ID;

hook OnGameModeInit()
{
    defer T_JoinNPCS();
    return 1;
}

timer T_JoinNPCS[5000]()
{
    ConnectNPC("Lektuvas_1", "at400_ls");
    // ConnectNPC("Traukinys_1", "train_ls");
}

hook OnPlayerConnect(playerid)
{
    if(IsPlayerNPC(playerid))
    {
        new IP_NPC[64+1],
            IP_Server[64+1];
        GetServerVarAsString("bind", IP_Server, 64);
        GetPlayerIp(playerid, IP_NPC, 64);
        if(!strlen(IP_Server)) format(IP_Server, 10, "127.0.0.1"); // localhost
        if(strcmp(IP_NPC, IP_Server, true) != 0)
        {
            // remote botas
            printf("[NPC] Kicking bot %s", IP_NPC);
            Kick(playerid);
            return 0;
        }
    }
    return 1;
}

hook OnPlayerSpawn(playerid)
{
    if(IsPlayerNPC(playerid))
    {

        new ip[32],
            server_ip[64+1];
	    GetServerVarAsString("bind", server_ip, 64);
        GetPlayerIp(playerid, ip, sizeof ip);

        if(!strlen(server_ip)) format(server_ip, sizeof server_ip, "127.0.0.1");

        if(!isequal(ip, server_ip, true))
        {
            printf("NPC from IP %s tried spawning", ip);
            Kick(playerid);
        }
        else 
        {
            SetPlayerColor(playerid, 0xffffffff);
            if(strfind(ret_GetPlayerName(playerid), "Lektuvas_1") != -1)
            {
                SetPlayerSkin(playerid, 61);
                planeVehicle = CreateVehicle(577, 0.0, 0.0, 7.0, 0.0, -1, -1, 0);
                PutPlayerInVehicle(playerid, planeVehicle, 0);
                return 1;
            }
            /*else if(strfind(ret_GetPlayerName(playerid), "Traukinys_1") != -1)
            {
                SetPlayerSkin(playerid, 7);
                metroVehicle = AddStaticVehicleEx(538, 0.0, 0.0, 7.0, 0.0, 1, 1, 0);
                PutPlayerInVehicle(playerid, metroVehicle, 0);
                return 1;
            }*/
        }
    }
    return 1;
}
