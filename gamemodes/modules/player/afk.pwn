#include <YSI_Coding\y_hooks>

static 
    player_AFKTime[MAX_PLAYERS];

ptask CHECK_AFK[60000](playerid)
{
    if(PlayerInfo[playerid][pIsApproved] && !HaveAdminPermission(playerid, "IgnoreAFKKicker"))
    {
        sd_CheckAfk(playerid);
    }
}

static sd_CheckAfk(playerid)
{
    if(IsPlayerAFK(playerid))
    {
        if( (PlayerInfo[playerid][pDonator] <= 1 && player_AFKTime[playerid] > MAX_AFK_TIME_NO_DONATOR) || 
            (PlayerInfo[playerid][pDonator] == DONATOR_SILVER && player_AFKTime[playerid] > MAX_AFK_TIME_SILVER_USER) || 
            (PlayerInfo[playerid][pDonator] == DONATOR_GOLD && player_AFKTime[playerid] > MAX_AFK_TIME_GOLD_USER))
        {
            return KickPlayer(playerid, "Sistema", "AFK");
        }
        else player_AFKTime[playerid] ++;
	}
	else player_AFKTime[playerid] = 0;
}

hook OnPlayerConnect(playerid)
{
    player_AFKTime[playerid] = 0;
    return 1;
}