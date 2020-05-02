#include <YSI\y_hooks>

new 
	vehicle_Taxi_Object[MAX_VEHICLES],
	vehicle_Taxi_Price[MAX_VEHICLES],

	bool:vehicle_Taxi_IsFree[MAX_VEHICLES],
	bool:vehicle_Taxi_Duty[MAX_VEHICLES],
	Float:vehicle_Taxi_KM[MAX_VEHICLES],

	player_Taxi_Vehicle[MAX_PLAYERS],
	player_Taxi_Duty[MAX_PLAYERS],
	bool:player_Taxi_First[MAX_PLAYERS];

hook OnGameModeInit()
{
	printf("[debug] Taxi module enabled");

	SetTimer("T_TaxiTimer", 2500, true);
}

forward T_TaxiTimer();
public T_TaxiTimer()
{
	new 
		vehicleid,
		fee,
		string[25];
	foreach(new playerid : Player)
	{
		if(player_Taxi_First[playerid])
		{
			vehicleid = GetPlayerVehicleID(playerid);
			if(vehicleid != INVALID_VEHICLE_ID)
			{
				fee = floatround((VehicleInfo[vehicleid][vKM] - vehicle_Taxi_KM[vehicleid]) * vehicle_Taxi_Price[vehicleid]);
				format(string, sizeof string, "Taksometras:_%d$", fee);
				PlayerTextDrawSetString(playerid, TaxometerTD[playerid], string);
			}
		}
	}
	return 1;
}



/*
new Float:attInfo[212] =
{
	0.85,
	0.8,
	0.79,
	2.15,
	-1.0,
	0.73,
	-1.0,
	-1.0,
	-1.0,
	0.8,
	0.899999,
	0.699999,
	0.699999,
	1.149999,
	2.4,
	0.61,
	-1.0,
	-1.0,
	1.1,
	0.699999,
	-1.0,
	0.699999,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	0.85,
	-1.0,
	1.6,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	0.8,
	-1.0,
	0.8,
	-1.0,
	-1.0,
	-1.0,
	1.269999,
	-1.0,
	0.92,
	-1.0,
	-1.0,
	0.86,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	0.569999,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	0.759999,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	0.86,
	0.86,
	-1.0,
	-1.0,
	1.1,
	-1.0,
	-1.0,
	-1.0,
	0.839999,
	0.699999,
	-1.0,
	0.699999,
	-1.0,
	1.0,
	-1.0,
	-1.0,
	1.0,
	1.049999,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	1.1,
	-1.0,
	0.699999,
	0.87,
	-1.0,
	0.74,
	1.039999,
	0.839999,
	-1.0,
	-1.0,
	-1.0,
	1.0,
	-1.0,
	-1.0,
	-1.0,
	0.899999,
	-1.0,
	-1.0,
	0.81,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	1.549999,
	1.47,
	0.86,
	0.86,
	0.699999,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	0.68,
	0.85,
	1.1,
	0.92,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	0.649999,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	0.73,
	0.639999,
	0.85,
	-1.0,
	-1.0,
	0.769999,
	0.85,
	0.899999,
	-1.0,
	0.709999,
	0.74,
	0.899999,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	0.87,
	0.759999,
	0.87,
	0.87,
	0.8,
	-1.0,
	-1.0,
	0.699999,
	0.85,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	0.899999,
	-1.0,
	-1.0,
	1.24,
	1.059999,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	1.0,
	-1.0,
	0.73,
	-1.0,
	1.1,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	0.709999,
	0.68,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	-1.0,
	-1.0
};*/

new VehicleSeats[] = {
	4,2,2,2,4,4,1,2,2,4,2,2,2,4,2,2,4,2,4,2,4,4,2,2,2,1,4,4,4,2,1,500,1,2,2,0,2,500,4,2,4,1,2,2,2,4,1,2,
	1,0,0,2,1,1,1,2,2,2,4,4,2,2,2,2,1,1,4,4,2,2,4,2,1,1,2,2,1,2,2,4,2,1,4,3,1,1,1,4,2,2,4,2,4,1,2,2,2,4,
	4,2,2,1,2,2,2,2,2,4,2,1,1,2,1,1,2,2,4,2,2,1,1,2,2,2,2,2,2,2,2,4,1,1,1,2,2,2,2,500,500,1,4,2,2,2,2,2,
	4,4,2,2,4,4,2,1,2,2,2,2,2,2,4,4,2,2,1,2,4,4,1,0,0,1,1,2,1,2,2,1,2,4,4,2,4,1,0,4,2,2,2,2,0,0,500,2,2,
	1,4,4,4,2,2,2,2,2,4,2,0,0,0,4,0,0
};
stock GetVehicleMaxSeats(vehicleid)
{
	#if !defined J@ // Y_YSI default bibliotekoje globalus temp kintamasis, apie kuri nedaug kas zino
        new J@;
    #endif
 	return ((400 <= (J@ = GetVehicleModel(vehicleid)) <= 612) ? VehicleSeats[J@-400] : 0);
}

hook OnPlayerConnect(playerid)
{
	player_Taxi_First[playerid] = false;
	player_Taxi_Duty[playerid] = INVALID_VEHICLE_ID;
	player_Taxi_Vehicle[playerid] = INVALID_VEHICLE_ID;
	return 1;
}

hook OnPlayerDisconnect(playerid)
{
	if(player_Taxi_First[playerid])
	{
		new 
			vehicleid = OldVehicle[playerid];
		if(IsValidVehicle(vehicleid) && vehicle_Taxi_Duty[vehicleid])
		{
			new 
				new_payer = Taxi_LookForNewPayer(vehicleid);
			vehicle_Taxi_IsFree[vehicleid] = true;
			if(IsPlayerConnected(new_payer)) Taxi_Player_ShowAccept(new_payer, vehicleid);
		}
	}
	if(player_Taxi_Duty[playerid] != INVALID_VEHICLE_ID)
	{
		new 
			vehicleid = player_Taxi_Duty[playerid];
		if(IsValidVehicle(vehicleid))
		{
			if(vehicle_Taxi_Duty[vehicleid])
			{
				if(IsValidDynamicObject(vehicle_Taxi_Object[vehicleid]))
				{
					DestroyDynamicObject(vehicle_Taxi_Object[vehicleid]);
					vehicle_Taxi_Object[vehicleid] = -1;
				}
				vehicle_Taxi_Duty[vehicleid] = false;
				vehicle_Taxi_Price[vehicleid] = 0;
				vehicle_Taxi_IsFree[vehicleid] = true;
			}		
		}
	}
	return 1;
}

hook OnVehicleSpawn(vehicleid)
{
	if(IsValidDynamicObject(vehicle_Taxi_Object[vehicleid]))
	{
		DestroyDynamicObject(vehicle_Taxi_Object[vehicleid]);
		vehicle_Taxi_Object[vehicleid] = -1;
	}
	vehicle_Taxi_Duty[vehicleid] = false;
	vehicle_Taxi_Price[vehicleid] = 0;
	vehicle_Taxi_IsFree[vehicleid] = true;

	foreach(new playerid : Player)
	{
		if(player_Taxi_Duty[playerid] == vehicleid)
		{
			player_Taxi_Duty[playerid] = INVALID_VEHICLE_ID;
		}
	}

	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_PASSENGER)
	{
		new 
			vehicleid = GetPlayerVehicleID(playerid);	
		if(IsValidVehicle(vehicleid) && GetVehicleDriverID(vehicleid) != INVALID_PLAYER_ID && vehicle_Taxi_Duty[vehicleid])
		{
			if(vehicle_Taxi_IsFree[vehicleid])
			{
				Taxi_Player_ShowAccept(playerid, vehicleid);
			}
			else player_Taxi_First[playerid] = false;
		}
	}
	if(oldstate == PLAYER_STATE_PASSENGER)
	{
		if(player_Taxi_First[playerid])
		{
			new 
				vehicleid = player_Taxi_Vehicle[playerid];
			if(IsValidVehicle(vehicleid))
			{
				new fee = floatround((VehicleInfo[vehicleid][vKM] - vehicle_Taxi_KM[vehicleid]) * vehicle_Taxi_Price[vehicleid]);
				SendFormat(playerid, 0xbababaff, "Sumokëjote $%d uþ kelionæ.", fee);
				GivePlayerMoney(playerid, -fee);
				GivePlayerMoney(GetVehicleDriverID(vehicleid), fee);

				PlayerTextDrawHide(playerid, TaxometerTD[playerid]);

				player_Taxi_First[playerid] = false;
				vehicle_Taxi_IsFree[vehicleid] = true;
				new 
					new_payer;
				if((new_payer = Taxi_LookForNewPayer(vehicleid)) != INVALID_PLAYER_ID)
				{
					// Islipo tas, kuris pats pirmas ilipo ir sumokejo uz visus.
					// Ieskom naujo, kuris sumokes uz viska.
					Taxi_Player_ShowAccept(new_payer, vehicleid);
				}
			}
		}
	}
	return 1;
}

stock Taxi_Player_ShowAccept(playerid, vehicleid)
{
	new 
		string[256];
	format(string, sizeof string, "{ffffff}Taksi kilometro kaina: $%d\nAr norite pradëti kelionæ?", vehicle_Taxi_Price[vehicleid]);
	Dialog_Show(playerid, DialogTaxiStart, DIALOG_STYLE_MSGBOX, "Taksi", string, "Taip", "Ne");
	return 1;
}



Dialog:DialogTaxiStart(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new 
			vehicleid = GetPlayerVehicleID(playerid),
			driverid = GetVehicleDriverID(vehicleid);

		if(vehicle_Taxi_Duty[vehicleid])
		{
			if(IsPlayerConnected(driverid))
			{
				vehicle_Taxi_IsFree[vehicleid] = false;
				vehicle_Taxi_KM[vehicleid] = VehicleInfo[vehicleid][vKM];
				player_Taxi_First[playerid] = true;
				player_Taxi_Vehicle[playerid] = vehicleid;


				SendFormat(playerid, -1, "Pradëjote kelionæ. Uþ kilometrà mokësite $%d/km", vehicle_Taxi_Price[vehicleid]);
				SendFormat(playerid, -1, "Jei norite patikrinti, kiek turësite mokëti naudokite /taxifee");
				SendFormat(driverid, -1, "Þaidëjas sutiko pradëti kelionæ.");


				PlayerTextDrawShow(playerid, TaxometerTD[playerid]);
				PlayerTextDrawSetString(playerid, TaxometerTD[playerid], "Taksometras:_0$");

				rp_me(driverid, _, "ájungia taksometrà.");
			}
		}
	}
	else
	{
		new 
			vehicleid = GetPlayerVehicleID(playerid);

		if(IsValidVehicle(vehicleid))
		{
			new 
				driverid = GetVehicleDriverID(vehicleid),
				new_payer;

			RemovePlayerFromVehicle(playerid);
			SendFormat(driverid, -1, "Þaidëjas nesutiko pradëti kelionës.");

			vehicle_Taxi_IsFree[vehicleid] = true;
			if((new_payer = Taxi_LookForNewPayer(vehicleid)) != INVALID_PLAYER_ID)
			{
				// Islipo tas, kuris pats pirmas ilipo ir sumokejo uz visus.
				// Ieskom naujo, kuris sumokes uz viska.
				Taxi_Player_ShowAccept(new_payer, vehicleid);
			}
		}
	}
}

stock Taxi_LookForNewPayer(vehicleid)
{
	foreach(new playerid : Player)
	{
		if(GetPlayerVehicleID(playerid) == vehicleid && GetPlayerVehicleSeat(playerid) != 0)
		{
			return playerid;
		}
	}
	return INVALID_PLAYER_ID;
}

stock GetVehicleDriverID(vehicleid)
{
	foreach(new playerid : Player)
	{
		if(GetPlayerVehicleID(playerid) == vehicleid && GetPlayerVehicleSeat(playerid) == 0 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			return playerid;
		}
	}
	return INVALID_PLAYER_ID;
}



CMD:taxiprice(playerid, params[])
{
	if(PlayerInfo[playerid][pTaxiLic] <= 0) return SendError(playerid, "Neturite taksisto licencijos (/taxilicense)");
	new 
		vehicleid = GetPlayerVehicleID(playerid),
		price;
	if(!IsValidVehicle(vehicleid)) return InfoBox(playerid, IB_NOT_IN_VEHICLE);
	if(sscanf(params, "d", price) || !(0 <= price <= 30)) return SendUsage(playerid, "/taxiprice [kaina 1-30]");
	if(!vehicle_Taxi_Duty[vehicleid] || !vehicle_Taxi_IsFree[vehicleid]) return SendError(playerid, "Nepradëjote darbo (/taxiduty) arba jau kaþkà veþate.");

	vehicle_Taxi_Price[vehicleid] = price;
	SendFormat(playerid, -1, "Kilometro kaina buvo pakeista á $%d/km.", price);
	return 1;
}

CMD:taxilicense(playerid, params[])
{
	if(PlayerInfo[playerid][pTaxiLic] >= 1) return SendError(playerid, "Licencijà jau turite.");
	else if(sd_GetPlayerMoney(playerid) < DEFAULT_TAXI_LICENCE_PRICE) return SendError(playerid, "Taksi licencija kainuoja $"#DEFAULT_TAXI_LICENCE_PRICE"");

	PlayerInfo[playerid][pTaxiLic] = 1;
	SaveAccountIntEx(playerid, "TaxiLic", 1);
	GivePlayerMoney(playerid, -DEFAULT_TAXI_LICENCE_PRICE);

	MsgSuccess(playerid, "TAXI", "Nusipirkote taksi licencijà.");
	return 1;
}



CMD:taxiduty(playerid, params[])
{
	if(PlayerInfo[playerid][pTaxiLic] <= 0) return SendError(playerid, "Neturite taksisto licencijos (/taxilicense)");

	if(player_Taxi_Duty[playerid] != INVALID_VEHICLE_ID)
	{
		new 
			vehicleid = player_Taxi_Duty[playerid];
		if(vehicle_Taxi_Duty[vehicleid] && IsValidVehicle(vehicleid))
		{
			if(IsValidDynamicObject(vehicle_Taxi_Object[vehicleid]))
			{
				DestroyDynamicObject(vehicle_Taxi_Object[vehicleid]);
				vehicle_Taxi_Object[vehicleid] = -1;
			}
			vehicle_Taxi_Duty[vehicleid] = false;
			vehicle_Taxi_Price[vehicleid] = 0;
			vehicle_Taxi_IsFree[vehicleid] = true;
		}

		player_Taxi_Duty[playerid] = INVALID_PLAYER_ID;
		SendFormat(playerid, -1, "Baigëte taksi darbà.");
	}
	else
	{
		new 
			vehicleid = GetPlayerVehicleID(playerid),
			model;
		if(!IsValidVehicle(vehicleid)) return InfoBox(playerid, IB_NOT_IN_VEHICLE);
		if(!HaveVehicleKey(playerid, vehicleid, false, false, false)) return SendWarning(playerid, "Neturite ðios tr. priemonës rakteliø.");
		if(sscanf(params, "d", model) || !(1 <= model <= 4)) return SendUsage(playerid, "/taxiduty [objektas 1-4]");
		if(GetVehicleMaxSeats(vehicleid) < 4) return SendWarning(playerid, "Tr. priemonë privalo turëti maþiausiai 4 sëdimas vietas!");

		switch(GetVehicleModel(vehicleid))
		{
			case 420, 438: model = -1;
			default:
			{
				switch(model) 
				{
					case 1: model = 19308;
					case 2: model = 19309;
					case 3: model = 19310;
					case 4: model = 19311;
					default: model = 19308;
				}
			}
		}

		if(model != -1)
		{
			vehicle_Taxi_Object[vehicleid] = CreateDynamicObject(model, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
			new Float:X, Float:Y, Float:Z;
			GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, X, Y, Z);

			AttachDynamicObjectToVehicle(vehicle_Taxi_Object[vehicleid], vehicleid, -0.0, -0.39, Z, 0.0, 0.0, 0.0);
		}
		else vehicle_Taxi_Object[vehicleid] = -1;

		vehicle_Taxi_Duty[vehicleid] = true;
		vehicle_Taxi_IsFree[vehicleid] = true;
		player_Taxi_Duty[playerid] = vehicleid;

		SendFormat(playerid, -1, "Redagavimas baigtas. Sëkmingai pradëjote darbà.");
		SendFormat(playerid, -1, "Nepamirðkite nustatyti kilometro kainos naudodami komandà /taxiprice [kaina uþ kilometrà].");
	}
	return 1;
}