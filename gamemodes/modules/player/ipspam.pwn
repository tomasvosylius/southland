#include <YSI_Coding\y_hooks>

#if !defined MAX_JOIN_LOGS
        #define MAX_JOIN_LOGS (30)
#endif
 
#if !defined MAX_THRESHOLD
        #define MAX_THRESHOLD (8000) // The amount of time in which all joins are valid and counted
#endif
 
enum e_JoinLog {
    e_iIP,
    e_iTimeStamp
};
 
static stock
	g_eaJoinLog[MAX_JOIN_LOGS][e_JoinLog]
;

static stock IpToInt(const s_szIP[]) {
    new
            aiBytes[1],
            iPos = 0
    ;
    aiBytes{0} = strval(s_szIP[iPos]);
    while(iPos < 15 && s_szIP[iPos++] != '.') {}
    aiBytes{1} = strval(s_szIP[iPos]);
    while(iPos < 15 && s_szIP[iPos++] != '.') {}
    aiBytes{2} = strval(s_szIP[iPos]);
    while(iPos < 15 && s_szIP[iPos++] != '.') {}
    aiBytes{3} = strval(s_szIP[iPos]);
    return aiBytes[0];
}

static
    joinIndex,
    joinArray[16]
;

hook OnPlayerConnect(playerid)
{
    GetPlayerIp(playerid, joinArray, sizeof(joinArray));
   
    g_eaJoinLog[joinIndex][e_iIP] = joinArray[0] = IpToInt(joinArray);
    g_eaJoinLog[joinIndex][e_iTimeStamp] = GetTickCount();
   
    joinIndex = ++joinIndex % MAX_JOIN_LOGS;
   
    joinArray[1] = joinArray[2] = 0;
   
    for(new i = 0; i < (MAX_JOIN_LOGS - 1); ++i) 
    {
            if(g_eaJoinLog[i][e_iIP] != joinArray[0]) 
            {
                    continue;
            }
            joinArray[3] = GetTickCount();

            if(floatround(floatabs(joinArray[3] - g_eaJoinLog[i][e_iTimeStamp])) < MAX_THRESHOLD) 
            {
                    if(floatround(floatabs(joinArray[3] - g_eaJoinLog[i + 1][e_iTimeStamp])) < MAX_THRESHOLD) 
                    {
                           	joinArray[1] ++;
                            joinArray[2] += floatround(floatabs(g_eaJoinLog[i][e_iTimeStamp] - g_eaJoinLog[i + 1][e_iTimeStamp]));
                    }
            }
    }

	if(joinArray[1] >= 2 && joinArray[2] <= 8000)
	{
        new name[MAX_PLAYER_NAME + 1];
        GetPlayerName(playerid, name, sizeof name);

		printf("%s banned: IP_FLOOD", name);
		BanEx(playerid, "IP_Flood");
		Kick(playerid);
		return 1;
	}
    return 1;
}