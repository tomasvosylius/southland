#include <YSI_Coding\y_hooks>

#define ALS_DO_PlayerBoomboxUse<%0> %0<PlayerBoomboxUse,i>(end:playerid)

enum E_PLAYER_AUDIO_INFO
{
	aArea,
	aObject,
	aLink[128],
	Float:aX,
	Float:aY,
	Float:aZ
};
new audioInfo[MAX_PLAYERS][E_PLAYER_AUDIO_INFO];
new Iterator:3DAudio<MAX_PLAYERS>;

hook OnPlayerDisconnect(playerid)
{
	if(audioInfo[playerid][aObject] > 0)
	{
		ResetBoombox(playerid);
	}
	return 1;
}

hook OnPlayerConnect(playerid)
{
	audioInfo[playerid][aObject] = 0;
	return 1;
}

hook OnPlayerDeath(playerid)
{
	if(PlayerInfo[playerid][pCurrentStatus] == PLAYER_STATUS_ALMOST_DEATH)
	{
		if(audioInfo[playerid][aObject] > 0)
		{
			ResetBoombox(playerid);
		}
	}
	return 1;
}

CMD:boombox(playerid, params[])
{
	if(!IsItemInPlayerInventory(playerid, ITEM_HOUSE_AUDIO))
	{
		SendError(playerid, "Neturite magnetolos.");
		return 1;
	}
	call OnPlayerBoomboxUse(playerid);
	return 1;
}
hook OnPlayerBoomboxUse(playerid)
{
	dialog_Clear();
	dialog_AddLine("Pakeisti stot�");
	dialog_AddLine("Pad�ti ant �em�s");
	dialog_AddLine("Paimti nuo �em�s");

	inline boomboxMain(response, listitem)
	{
		if(response)
		{
			dialog_Row("Pakeisti stot�")
			{
				BoomBox_ShowStations(playerid);
			}
			dialog_Row("Pad�ti ant �em�s")
			{
				foreach(new receiverid : 3DAudio)
			    {
			    	if(IsPlayerInDynamicArea(playerid, audioInfo[receiverid][aArea]))
						return SendWarning(playerid, "�alia j�s� jau yra pastatyta magnetola.");
				}
				if(audioInfo[playerid][aObject] > 0) return SendError(playerid, "J�s jau esate pad�j�s magnetol�.");

				new 
					Float:x, 
					Float:y,
					Float:z;
				GetPlayerPos(playerid, x, y, z);
				Iter_Add(3DAudio, playerid);

				format(audioInfo[playerid][aLink], 1, "");
				audioInfo[playerid][aX] = x;
				audioInfo[playerid][aY] = y;
				audioInfo[playerid][aZ] = z;

				audioInfo[playerid][aObject] = CreateDynamicObject(2103, x, y, z-1.0, 0, 0, 0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
				audioInfo[playerid][aArea] = CreateDynamicCircle(x, y, 25.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));

				foreach(new receiverid : Player)
				{
					if(IsPlayerInDynamicArea(receiverid, audioInfo[playerid][aArea]))
					{
						if(!IsPlayerInAnyVehicle(receiverid)) SetPlayerRadio(receiverid, "");
					}
				}

				rp_me(playerid, _, "padeda ant �em�s magnetol� ir j� �jungia.");
				SendFormat(playerid, 0xbababaff, "Nustatymams naudokite /boombox");
			}
			dialog_Row("Paimti nuo �em�s")
			{
				if(audioInfo[playerid][aObject] > 0)
				{
					ResetBoombox(playerid);
					rp_me(playerid, _, "paima magnetol� nuo �em�s.");
					return 1;
				}
				else SendError(playerid, "J�s nesate pastat�s magnetolos.");
			}
		}
	}
	dialog_Show(playerid, using inline boomboxMain, DIALOG_STYLE_LIST, "Magnetola", "T�sti", "At�aukti");
	return 1;
}

flags:clearboombox(CMD_TYPE_ADMIN);
CMD:clearboombox(playerid, params[])
{
	foreach(new audio : 3DAudio)
	{
		if(IsPlayerInDynamicArea(playerid, audioInfo[audio][aArea]))
		{
			ResetBoombox(audio);
			break;
		}
	}
	SendFormat(playerid, -1, "I�val�te artimiausi� boombox�");
	return 1;
}

stock BoomBox_ShowStations(playerid)
{
	
	dialog_Clear();
	for(new i = 0; i < sizeof RadioStations; i++)
	{
		dialog_AddLine(RadioStations[i][stationName]);
	}
	dialog_AddLine("{BABABA}�vesti savo stot�");

	inline stations(response, listitem)
	{
		if(response)
		{
			if(audioInfo[playerid][aObject] <= 0) return SendError(playerid, "J�s nesate pastat�s magnetolos.");
			if(listitem < sizeof RadioStations)
			{
				// pasirinko stoti
				format(audioInfo[playerid][aLink], 128, RadioStations[listitem][stationLink]);
				foreach(new receiverid : Player)
				{
					if(IsPlayerInDynamicArea(receiverid, audioInfo[playerid][aArea]))
					{
						if(!IsPlayerInAnyVehicle(receiverid)) SetPlayerRadio(receiverid, audioInfo[playerid][aLink]);
					}
				}
				rp_me(playerid, _, "pakei�ia magnetolos stot�.");
			}
			else
			{
				BoomBox_ShowInput(playerid);
			}
		}
	}
	dialog_Show(playerid, using inline stations, DIALOG_STYLE_LIST, "Magnetola", "T�sti", "At�aukti");
	return 1;
}

stock BoomBox_ShowInput(playerid)
{
	// iveda
	dialog_Clear();
	dialog_AddLine("{FFFFFF}�veskite stoties adres�:");

	inline boomboxInput(response, listitem)
	{
		if(response)
		{
			if(audioInfo[playerid][aObject] <= 0) return SendError(playerid, "J�s nesate pastat�s magnetolos.");
			if(strlen(dialog_Input()) > 0)
			{
				// pasirinko stoti
				format(audioInfo[playerid][aLink], 128, dialog_Input());
				foreach(new receiverid : Player)
				{
					if(IsPlayerInDynamicArea(receiverid, audioInfo[playerid][aArea]))
					{
						if(!IsPlayerInAnyVehicle(receiverid)) SetPlayerRadio(receiverid, dialog_Input());
					}
				}
				rp_me(playerid, _, "pakei�ia magnetolos stot�.");
			}
		}
	}
	dialog_Show(playerid, using inline boomboxInput, DIALOG_STYLE_INPUT, "Magnetola", "T�sti", "At�aukti");
	return 1;
}


stock ResetBoombox(playerid)
{
	foreach(new receiverid : Player)
	{
		if(IsPlayerInDynamicArea(receiverid, audioInfo[playerid][aArea]))
		{
			StopPlayerRadio(receiverid);
		}
	}

	format(audioInfo[playerid][aLink], 1, "");
	if(IsValidDynamicObject(audioInfo[playerid][aObject]))
	{
		DestroyDynamicObject(audioInfo[playerid][aObject]);
	}
	if(IsValidDynamicArea(audioInfo[playerid][aArea]))
	{
		DestroyDynamicArea(audioInfo[playerid][aArea]);
	}
	audioInfo[playerid][aObject] = 0;
	Iter_Remove(3DAudio, playerid);
}

public OnPlayerEnterDynamicArea(playerid, areaid)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return 1;
	foreach(new audio : 3DAudio)
	{
		if(audioInfo[audio][aArea] == areaid)
		{
			if(!IsPlayerInAnyVehicle(playerid)) SetPlayerRadio(playerid, audioInfo[audio][aLink]);
			break;
		}
	}
	return 1;
}

public OnPlayerLeaveDynamicArea(playerid, areaid)
{
	foreach(new audio : 3DAudio)
	{
		if(audioInfo[audio][aArea] == areaid)
		{
			if(!IsPlayerInAnyVehicle(playerid)) StopPlayerRadio(playerid);
			break;
		}
	}
	return 1;
}