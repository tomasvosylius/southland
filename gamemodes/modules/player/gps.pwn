#define ENABLE_GPS true

static enum E_PLACES_LIST
{
    placeName[32],
    Float:placeX,
    Float:placeY,
    Float:placeZ
};
static Places[][E_PLACES_LIST] = {
    {"Mechanikai", 0.0, 0.0, 0.0},
    {"Krovini� i�ve�iotojai", 0.0, 0.0, 0.0},
    {"�vejybos vieta", 2864.02, -1966.27, 11.11},
    {"Vairavimo mokykla", 2058.3345,-1923.9935,13.5469},
    {"Tr. priemoni� parduotuv�", 2132.10, -1147.88, 24.44},
    {"Pigus transportas", 1921.7295,-1865.4683,13.56},
    {"Bankas", 1459.83, -1266.29, 13.55}
};

#if defined ENABLE_GPS
	CMD:gps(playerid, params[])
	{
        dialog_Clear();
        for(new p = 0; p < sizeof Places; p++)
        {
            dialog_AddOption("�", Places[p][placeName]);
        }
        inline gps(response, listitem)
        {
            if(response)
            {
                if(isequal(Places[listitem][placeName], "Mechanikai", true))
                {
                    for(new i = 0; i < sizeof Jobs; i++)
                    {
                        if(Jobs[i][jobId] == JOB_MECHANIC)
                        {
                            SetPlayerCheckpointEx(playerid, 0, Jobs[i][jobX], Jobs[i][jobY], Jobs[i][jobZ], 4.0);
                            break;
                        }
                    }
                    
                }
                else if(isequal(Places[listitem][placeName], "Krovini� i�ve�iotojai", true))
                {
                    for(new i = 0; i < sizeof Jobs; i++)
                    {
                        if(Jobs[i][jobId] == JOB_TRUCKER)
                        {
                            SetPlayerCheckpointEx(playerid, 0, Jobs[i][jobX], Jobs[i][jobY], Jobs[i][jobZ], 4.0);
                            break;
                        }
                    }
                }
                else 
                {
                    SetPlayerCheckpointEx(playerid, 0, 
                        Places[listitem][placeX],
                        Places[listitem][placeY],
                        Places[listitem][placeZ], 4.0);
                }
                SendClientMessage(playerid, 0xbababaff, "Vieta pa�ym�ta.");
            }
        }
        dialog_Show(playerid, using inline gps, DIALOG_STYLE_LIST, "GPS", "Pa�ym�ti", "At�aukti");
		return 1;
	}
#endif

hook OnPlayerSpawnFirstTime(playerid)
{
    #if defined ENABLE_GPS
        SendFormat(playerid, 0xFF7300FF, "* {FFAD69}D�l ma�esn�s apkrovos administratoriams, serverio startavimo metu naudokit�s komanda /gps");
    #endif
    return 1;
}