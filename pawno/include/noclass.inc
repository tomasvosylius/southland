/*
 *  Disable class selection by Emmet_
 *  Creation date: 05/13/2015 @ 4:38 AM
*/

// Called when a player is fully connected to the server.
forward OnPlayerFullyConnected(playerid);

public OnPlayerRequestClass(playerid, classid)
{
	// Enables spectator mode. This will hide the class selection buttons.
	TogglePlayerSpectating(playerid, true);
	
	// Call a timer to defer the function call. Setting camera info doesn't
	// work after enabling spectator mode.
	SetTimerEx("OnPlayerFullyConnected", 250, false, "i", playerid);

	#if defined CS_OnPlayerRequestClass
	    return CS_OnPlayerRequestClass(playerid, classid);
	#else
	    return 1;
	#endif
}

stock CS_SpawnPlayer(playerid)
{
	if (GetPlayerState(playerid) == PLAYER_STATE_SPECTATING)
	{
	    TogglePlayerSpectating(playerid, false);
	}
	return SpawnPlayer(playerid);
}

#if defined _ALS_OnPlayerRequestClas
	#undef OnPlayerRequestClass
#else
	#define _ALS_OnPlayerRequestClass
#endif

#define OnPlayerRequestClass CS_OnPlayerRequestClass

#if defined _ALS_SpawnPlayer
	#undef SpawnPlayer
#else
	#define _ALS_SpawnPlayer
#endif

#define SpawnPlayer CS_SpawnPlayer

#if defined CS_OnPlayerRequestClass
	forward CS_OnPlayerRequestClass(playerid, classid);
#endif
