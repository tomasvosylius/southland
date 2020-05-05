

stock SetWorldTime(playerid)
{
	
}

stock WT_SetPlayerVirtualWorld(playerid, set)
{
	if(set == 0)
	{

	}
	return SetPlayerVirtualWorld(playerid, set);
}
#if defined _ALS_SetPlayerVirtualWorld
	#undef SetPlayerVirtualWorld
#else 
	#define _ALS_SetPlayerVirtualWorld
#endif 
#define SetPlayerVirtualWorld WT_SetPlayerVirtualWorld



stock WT_SetPlayerInterior(playerid, set)
{
	if(set == 0)
	{
        
	}

	return SetPlayerInterior(playerid, set);
}

#if defined _ALS_SetPlayerInterior
	#undef SetPlayerInterior
#else 
	#define _ALS_SetPlayerInterior
#endif 
#define SetPlayerInterior WT_SetPlayerInterior