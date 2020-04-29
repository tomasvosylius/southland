#include <YSI\y_hooks>

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
        return 1;
	}
	return 1;
}