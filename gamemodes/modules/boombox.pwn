#include <YSI\y_hooks>

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
	new 
		string[512];
	strcat(string, "Pakeisti stotá\nPadëti ant þemës\nPaimti nuo þemës");
	Dialog_Show(playerid, BoomboxMain, DIALOG_STYLE_LIST, "Magnetola", string, "Tæsti", "Atðaukti");
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
	SendFormat(playerid, -1, "Iðvalëte artimiausià boomboxà");
	return 1;
}

Dialog:BoomboxMain(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0:
			{
				new string[4084];
				for(new i = 0; i < sizeof RadioStations; i++)
				{
					format(string, sizeof string, "%s%s\n", string, RadioStations[i][stationName]);
				}
				strcat(string, "{BABABA}Ávesti savo stotá");
				Dialog_Show(playerid, BoomboxStation, DIALOG_STYLE_LIST, "Magnetola", string, "Tæsti", "Atðaukti");
			}
			case 1:
			{
				foreach(new receiverid : 3DAudio)
			    {
			    	if(IsPlayerInDynamicArea(playerid, audioInfo[receiverid][aArea])) return SendWarning(playerid, "Ðalia jûsø jau yra pastatyta magnetola.");
				}
				if(audioInfo[playerid][aObject] > 0) return SendError(playerid, "Jûs jau esate padëjæs magnetolà.");
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

				rp_me(playerid, _, "padeda ant þemës magnetolà ir jà ájungia.");
				SendFormat(playerid, 0xbababaff, "Nustatymams naudokite /boombox");
			}
			case 2:
			{
				if(audioInfo[playerid][aObject] > 0)
				{
					ResetBoombox(playerid);
					rp_me(playerid, _, "paima magnetolà nuo þemës.");
					return 1;
				}
				else SendError(playerid, "Jûs nesate pastatæs magnetolos.");
			}
		}
	}
	return 1;
}

Dialog:BoomboxStation(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(audioInfo[playerid][aObject] <= 0) return SendError(playerid, "Jûs nesate pastatæs magnetolos.");
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
			rp_me(playerid, _, "pakeièia magnetolos stotá.");
		}
		else
		{
			// iveda
			Dialog_Show(playerid, BoomboxInput, DIALOG_STYLE_INPUT, "Magnetola", "{FFFFFF}Áveskite stoties adresà:", "Tæsti", "Atðaukti");
		}
	}
	return 1;
}

Dialog:BoomboxInput(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(audioInfo[playerid][aObject] <= 0) return SendError(playerid, "Jûs nesate pastatæs magnetolos.");
		if(strlen(inputtext) > 0)
		{
			// pasirinko stoti
			format(audioInfo[playerid][aLink], 128, inputtext);
			foreach(new receiverid : Player)
			{
				if(IsPlayerInDynamicArea(receiverid, audioInfo[playerid][aArea]))
				{
					if(!IsPlayerInAnyVehicle(receiverid)) SetPlayerRadio(receiverid, inputtext);
				}
			}
			rp_me(playerid, _, "pakeièia magnetolos stotá.");
		}
	}
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