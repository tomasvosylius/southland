#include <YSI\y_hooks>

static 
	server_SAMP_Time 	= 0,
	server_SAMP_Weather = 1;

static 	
	bool:player_Immune[MAX_PLAYERS];

// Functions
stock SetPlayerWorldImmuneToVW(playerid, bool:set)
{
	// Zaidejo game weather ir laiko nepakeis neitakos SetPlayerVirtualWorld, jei sitas nustatytas á true.
	return (player_Immune[playerid] = set);
}

static _Player_EnableInteriorLight(playerid, bool:enable)
{
	if(enable)
	{
		SetPlayerWeather(playerid, 0);
		SetPlayerTime(playerid, 12, 0);
	}
	else 
	{
		SetPlayerWeather(playerid, GetWorldWeather());
		SetPlayerTime(playerid, GetWorldTime(), 0);
	}
	return 1;
}

hook OnPlayerConnect(playerid)
{
	player_Immune[playerid] = false;
}

// Server weather
stock GetWorldWeather() return server_SAMP_Weather;
stock WT_SetWeather(weatherid)
{
	server_SAMP_Weather = weatherid;
	return SetWeather(weatherid);
}
#if defined _ALS_SetWeather
	#undef SetWeather
#else 
	#define _ALS_SetWeather
#endif 
#define SetWeather WT_SetWeather

// Server time
stock GetWorldTime() return server_SAMP_Time;

stock WT_SetWorldTime(time)
{
	server_SAMP_Time = time;
	return SetWorldTime(time);
}
#if defined _ALS_SetWorldTime
	#undef SetWorldTime
#else 
	#define _ALS_SetWorldTime
#endif 
#define SetWorldTime WT_SetWorldTime


// World
stock WT_SetPlayerVirtualWorld(playerid, set)
{
	_Player_EnableInteriorLight(playerid, (set != 0));	
	return SetPlayerVirtualWorld(playerid, set);
}
#if defined _ALS_SetPlayerVirtualWorld
	#undef SetPlayerVirtualWorld
#else 
	#define _ALS_SetPlayerVirtualWorld
#endif 
#define SetPlayerVirtualWorld WT_SetPlayerVirtualWorld

// Interjerai
stock WT_SetPlayerInterior(playerid, set)
{
	_Player_EnableInteriorLight(playerid, (set != 0));
	return SetPlayerInterior(playerid, set);
}

#if defined _ALS_SetPlayerInterior
	#undef SetPlayerInterior
#else 
	#define _ALS_SetPlayerInterior
#endif 
#define SetPlayerInterior WT_SetPlayerInterior

