stock FMenu_Vehicles_Main(playerid, faction)
{
	dialog_Clear();
	dialog_AddLine("Turimos tr. priemonës");
	dialog_AddLine("Tr. priemoniø pirkimas");
	inline select(response, listitem)
	{
		if(response)
		{
			dialog_Row("Turimos tr. priemonës")		return _FMenu_Vehicles_OwnedList(playerid, faction);
			dialog_Row("Tr. priemoniø pirkimas")	return _FMenu_Vehicles_BuyList(playerid, faction);
		}
        else FMenu_Main(playerid, faction);
	}
	dialog_Show(playerid, using inline select, DIALOG_STYLE_LIST, "Frakcijos inventorius", "Tæsti", "Atðaukti");
	return 1;
}

static _FMenu_Vehicles_BuyList(playerid, faction)
{
	// pirkimas
	MsgInfo(playerid, "Frakcija", "Nupirkta transporto priemonë atsiras jûsø pozicijoje!");
	inline loadList()
	{
		new rows = cache_num_rows(),
			price, id, model;

		dialog_Clear();
		dialog_AddLine("Modelis\tKaina");

		for(new i = 0; i < rows; i++)
		{
			cache_get_value_name_int(i, "id", id);
			cache_get_value_name_int(i, "Price", price);
			cache_get_value_name_int(i, "Model", model);
			dialog_AddLine("{FFFFFF}%s\t{449947}$%d", GetModelName(model), price);
		}
		inline select(response, listitem)
		{
			if(response)
			{
				inline buyVehicle()
				{
					cache_get_value_name_int(0, "Price", price);
					cache_get_value_name_int(0, "Model", model);

					if(FactionInfo[faction][fBudget] < price)
					{
						InfoBox(playerid, "NEPAKANKAMAI", "PINIGU BIUDZETE");
						return _FMenu_Vehicles_BuyList(playerid, faction);
					}
					FactionInfo[faction][fBudget] -= price;
					SaveFactionIntEx(faction, "Budget", FactionInfo[faction][fBudget]);

					new Float:x, Float:y, Float:z, Float:a;
					GetPlayerPos(playerid, x, y, z);
					GetPlayerFacingAngle(playerid, a);
					AddServerVehicle(model, faction, -1, playerid, x+1.0, y+1.0, z, a, 32, 32, price, .added_by_admin = false);

					MsgSuccess(playerid, "Frakcija", "Nupirkote %s uþ $%d savo frakcijai.", GetModelName(model), price);

					log_init(true);
					log_set_table("logs_factions");
					log_set_keys("`PlayerId`,`PlayerName`,`FactionId`,`FactionName`,`ActionText`,`ExtraId`,`Amount`");
					log_set_values("'%d','%e','%d','%e','(FM) Nupirko automobili','%d','%d'", LogPlayerId(playerid), LogPlayerName(playerid), GetFactionName(faction, false), FactionInfo[faction][fId], model, price);
					log_commit();
					return 1;
				}
				mysql_tquery_inline(chandler, using inline buyVehicle, "\
					SELECT `Price`,`Model` FROM `sell_vehicles_factions` WHERE FactionType = '%d' LIMIT 1 OFFSET %d", 
					FactionInfo[faction][fType], listitem
				);
			}
			else FMenu_Vehicles_Main(playerid, faction);
		}
		dialog_Show(playerid, using inline select, DIALOG_STYLE_TABLIST_HEADERS, "Frakcijos tr. priemoniø pirkimas", "Pirkti", "Atðaukti");
	}
	mysql_tquery_inline(chandler, using inline loadList, "\
		SELECT `Model`,`Price`,`id` FROM `sell_vehicles_factions` WHERE FactionType = '%d'",
		FactionInfo[faction][fType]
	);
	return 1;
}

static _FMenu_Vehicles_OwnedList(playerid, faction)
{
	new playerfaction = PlayerInfo[playerid][pFaction],
		id;
	dialog_Clear();
	dialog_AddLine("{BABABA}Nr.\t{BABABA}Modelis\t{BABABA}Numeriai");

	foreach(new vehicleid : Vehicle)
	{
		if(VehicleInfo[vehicleid][vFaction] == playerfaction)
		{
			id++;
			dialog_AddLine("%d.\t%s\t%s", id, GetModelName(GetVehicleModel(vehicleid)), VehicleInfo[vehicleid][vNumbers]);
		}
	}
	if(id == 0)
	{
		MsgError(playerid, "Frakcija", "Tr. priemoniø nëra.");
		return 1;
	}
	
	// DIALOG_FM_VEHICLES_LIST
	inline select(response, listitem)
	{
		if(response)
		{
			id = 0;
			foreach(new vehicleid : Vehicle)
			{
				if(VehicleInfo[vehicleid][vFaction] == playerfaction)
				{
					if(id >= listitem) return _FMenu_Vehicles_ShowDetails(playerid, faction, vehicleid);
					id++;
				}
			}
		}
		else FMenu_Vehicles_Main(playerid, faction);
	}
	dialog_Show(playerid, using inline select, DIALOG_STYLE_TABLIST_HEADERS, "Frakcijos tr. priemonës", "Tæsti", "Atðaukti");
	return 1;
}

static _FMenu_Vehicles_ShowDetails(playerid, faction, vehicleid)
{
	if(VehicleInfo[vehicleid][vFaction] != PlayerInfo[playerid][pFaction])
		return _FMenu_Vehicles_OwnedList(playerid, faction);

	if(VehicleInfo[vehicleid][vRequiredLevel] <= 0) VehicleInfo[vehicleid][vRequiredLevel] = 1;

	dialog_Clear();
	dialog_AddLine("{BABABA}Nustatymas\t{BABABA}Dabartinë reikðmë");
	dialog_AddLine("Rida\t{D9EB80}%0.2f", VehicleInfo[vehicleid][vKM]);
	dialog_AddLine("{FFFFFF}Minimalus rangas\t{D9EB80}%s (%d)", FactionRankNames[faction][VehicleInfo[vehicleid][vRequiredLevel]-1], VehicleInfo[vehicleid][vRequiredLevel]);
	dialog_AddLine("{FFFFFF}Ekipaþas\t{D9EB80}%s", VehicleInfo[vehicleid][vUnitText]);
	dialog_AddLine("{FFFFFF}Iðsaugoti pozicijà");
	dialog_AddLine("Perdaþyti");
	dialog_AddLine("{D54B4B}Parduoti tr. priemonæ");

	inline select(response, listitem)
	{
		if(response)
		{
			dialog_Row("Minimalus rangas")	return _FMenu_Vehicles_ChangeRank(playerid, faction, vehicleid);	
			dialog_Row("Ekipaþas")			return _FMenu_Vehicles_ChangeUnit(playerid, faction, vehicleid);
			dialog_Row("Iðsaugoti")			return _FMenu_Vehicles_ChangePos(playerid, faction, vehicleid);
			dialog_Row("Perdaþyti")			return _FMenu_Vehicles_ChangeColor(playerid, faction, vehicleid);
			dialog_Row("Parduoti")			return _FMenu_Vehicles_Sell(playerid, faction, vehicleid);
		}
		else _FMenu_Vehicles_OwnedList(playerid, faction);
	}
	dialog_Show(playerid, using inline select, DIALOG_STYLE_TABLIST_HEADERS, "Frakcijos tr. priemonës", "Tæsti", "Atðaukti");
	return 1;
}

static _FMenu_Vehicles_ChangeRank(playerid, faction, vehicleid)
{
	MsgInfo(playerid, "Frakcija", "Pasirinkite rangà, nuo kurio leisite vairuoti %s", GetModelName(GetVehicleModel(vehicleid)));	
	dialog_Clear();
	for(new i = 0; i < MAX_FACTION_RANKS; i++)
	{
		if(!strlen(FactionRankNames[faction][i])) { break; }
		dialog_AddLine("%s (%d)", FactionRankNames[faction][i], i+1);
	}
	inline select(response, listitem)
	{
		if(response)
		{
			VehicleInfo[vehicleid][vRequiredLevel] = listitem+1;
			SaveServerVehicleIntEx(vehicleid, "RequiredLevel", listitem+1);
			MsgSuccess(playerid, "Frakcija", "Nustatëte minimalø rangà á %s tr. priemonei %s", FactionRankNames[faction][listitem], GetModelName(GetVehicleModel(vehicleid)));
			
			log_init(true);
			log_set_table("logs_factions");
			log_set_keys("`PlayerId`,`PlayerName`,`FactionId`,`FactionName`,`ActionText`,`ExtraId`,`Amount`");
			log_set_values("'%d','%e','%d','%e','Pakeite automobilio ranga','%d','%d'", LogPlayerId(playerid), LogPlayerName(playerid), FactionInfo[faction][fId], GetFactionName(faction, false), VehicleInfo[vehicleid][vId], listitem+1);
			log_commit();
		}
		_FMenu_Vehicles_ShowDetails(playerid, faction, vehicleid);
		return 1;
	}
	dialog_Show(playerid, using inline select, DIALOG_STYLE_LIST, "Frakcijos tr. priemonës", "Tæsti", "Atðaukti");
	return 1;
}

static _FMenu_Vehicles_ChangeUnit(playerid, faction, vehicleid)
{
	if(!(FactionInfo[faction][fType] == FACTION_TYPE_POLICE || FactionInfo[faction][fType] == FACTION_TYPE_FIRE))
	{
		MsgError(playerid, "Frakcija", "Jûsø frakcija ðios funkcijos neturi.");
		_FMenu_Vehicles_ShowDetails(playerid, faction, vehicleid);
		return 1;
	}
	dialog_Clear();
	dialog_AddLine("{E4E4E4}Ávesktite ekipaþo pavadinimà, kurá rodys ant tr. priemonës");
	dialog_AddLine("{B4B4B4}Norëdami iðtrinti esamà, nieko neáveskite.");

	inline input(response, listitem)
	{
		if(response)
		{
			if(IsValidVehicle(vehicleid))
			{
				if(!strlen(dialog_Input()))
				{
					if(strlen(VehicleInfo[vehicleid][vUnitText]))
					{
						// sena istrinam
						log_init(true);
						log_set_table("logs_factions");
						log_set_keys("`PlayerId`,`PlayerName`,`FactionId`,`FactionName`,`ActionText`,`ExtraId`,`ExtraString`");
						log_set_values("'%d','%e','%d','%e','(FM) Pasalino automobilio unit','%d','%e'", LogPlayerId(playerid), LogPlayerName(playerid), PlayerInfo[playerid][pFaction], GetFactionName(PlayerInfo[playerid][pFaction]), VehicleInfo[vehicleid][vId], VehicleInfo[vehicleid][vUnitText]);
						log_commit();

						format(VehicleInfo[vehicleid][vUnitText], 1, "");
						MsgSuccess(playerid, "Frakcija", "Sëkmingai paðalinote ekipaþo pavadinimà.");

						Vehicle_SetUnitLabel(vehicleid, "");

						inline updateUnit()
						{
							return 1;
						}
						mysql_tquery_inline(chandler, using inline updateUnit, "\
							UPDATE `vehicles_server` SET Unit = '' WHERE id = '%d'",
							VehicleInfo[vehicleid][vId]
						);
					}
				}
				else
				{
					// ivede
					Vehicle_SetUnitLabel(vehicleid, dialog_Input());

					log_init(true);
					log_set_table("logs_factions");
					log_set_keys("`PlayerId`,`PlayerName`,`FactionId`,`FactionName`,`ActionText`,`ExtraId`,`ExtraString`");
					log_set_values("'%d','%e','%d','%e','(FM) Pakeite automobilio unit','%d','%e'", LogPlayerId(playerid), LogPlayerName(playerid), PlayerInfo[playerid][pFaction], GetFactionName(PlayerInfo[playerid][pFaction]), VehicleInfo[vehicleid][vId], dialog_Input());
					log_commit();

					inline updateUnit()
					{
						return 1;
					}
					mysql_tquery_inline(chandler, using inline updateUnit, "\
						UPDATE `vehicles_server` SET Unit = '%e' WHERE id = '%d'", 
						dialog_Input(), VehicleInfo[vehicleid][vId]
					);

					MsgSuccess(playerid, "Frakcija", "Sëkmingai atnaujinote ekipaþà: \"%s\"", dialog_Input());
				}
			}
		}
		_FMenu_Vehicles_ShowDetails(playerid, faction, vehicleid);
	}
	dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Frakcijos tr. priemonës", "Tæsti", "Atðaukti");
	return 1;
}

static _FMenu_Vehicles_ChangePos(playerid, faction, vehicleid)
{
	new current = GetPlayerVehicleID(playerid);
	if(!IsPlayerInAnyVehicle(playerid) || current != vehicleid)
	{
		InfoBox(playerid, IB_NOT_IN_VEHICLE);
		return _FMenu_Vehicles_ShowDetails(playerid, faction, vehicleid);
	}
	
	new Float:x, Float:y, Float:z, Float:a, model,
        newvehicleid,
        col1, col2;

    model = GetVehicleModel(vehicleid);
    GetVehiclePos(vehicleid, x, y, z);
    GetVehicleZAngle(vehicleid, a);
    GetVehicleColor(vehicleid, col1, col2);

    
    newvehicleid = CreateVehicle(model, x, y, z, a, col1, col2, VehicleInfo[vehicleid][vRespawnTime], VehicleInfo[vehicleid][vAddSiren]);
    VehicleInfo[newvehicleid] = VehicleInfo[vehicleid];
    PutFactionWeaponsInVehicle(newvehicleid);
    Vehicle_SetServerNumberPlate(newvehicleid);
    Vehicle_SetUnitLabel(newvehicleid, VehicleInfo[vehicleid][vUnitText]);

    SaveServerVehicleFloatEx(newvehicleid, "X", x);
    SaveServerVehicleFloatEx(newvehicleid, "Y", y);
    SaveServerVehicleFloatEx(newvehicleid, "Z", z);
    SaveServerVehicleFloatEx(newvehicleid, "A", a);
	DestroyVehicle(vehicleid);

	MsgSuccess(playerid, "Frakcija", "Tr. priemonës pozicija iðsaugota.");

	log_init(true);
	log_set_table("logs_factions");
	log_set_keys("`PlayerId`,`PlayerName`,`FactionId`,`FactionName`,`ActionText`,`ExtraId`");
	log_set_values("'%d','%e','%d','%e','(FM) Atnaujino automobilio pozicija','%d'", LogPlayerId(playerid), LogPlayerName(playerid), FactionInfo[faction][fId], GetFactionName(faction, false), VehicleInfo[newvehicleid][vId]);
	log_commit();

	_FMenu_Vehicles_ShowDetails(playerid, faction, newvehicleid);
	return 1;
}

static _FMenu_Vehicles_ChangeColor(playerid, faction, vehicleid)
{
	dialog_Clear();
	dialog_AddLine("{E4E4E4}Áveskite tr. priemonës spalvas");
	dialog_AddLine("Pvz.: 0 0, 251 32");

	inline input(response, listitem)
	{
		if(response)
		{
			new col1, col2;
			if(sscanf(dialog_Input(),"dd",col1,col2))
				return _FMenu_Vehicles_ChangeColor(playerid, faction, vehicleid);
				
			if(IsValidVehicle(vehicleid))
			{
				ChangeVehicleColor(vehicleid, col1, col2);
				SaveServerVehicleIntEx(vehicleid, "Color1", col1);
				SaveServerVehicleIntEx(vehicleid, "Color2", col2);

				MsgSuccess(playerid, "Frakcija", "Tr. priemonë perdaþyta.");
			}
			log_init(true);
			log_set_table("logs_factions");
			log_set_keys("`PlayerId`,`PlayerName`,`FactionId`,`FactionName`,`ActionText`,`ExtraId`,`Amount`");
			log_set_values("'%d','%e','%d','%e','Perdaze automobili','%d','%d'", LogPlayerId(playerid), LogPlayerName(playerid), PlayerInfo[playerid][pFaction], GetFactionName(PlayerInfo[playerid][pFaction]), VehicleInfo[vehicleid][vId], col1);
			log_commit();
		}
		_FMenu_Vehicles_ShowDetails(playerid, faction, vehicleid);
	}
	dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Frakcijos tr. priemonës", "Keisti", "Atðaukti");
	return 1;
}

static _FMenu_Vehicles_Sell(playerid, faction, vehicleid)
{
	if(IsValidVehicle(vehicleid) && VehicleInfo[vehicleid][vFaction] == PlayerInfo[playerid][pFaction])
	{
		if(VehicleInfo[vehicleid][vExtraId] == 1)
		{
			// pridejo adminas, negalim parduoti
			MsgError(playerid, "Frakcija", "Ðios tr. priemonës parduoti negalite.");
			return _FMenu_Vehicles_ShowDetails(playerid, faction, vehicleid);
		}

		new money = VehicleInfo[vehicleid][vPrice] - floatround(VehicleInfo[vehicleid][vKM]/200.0);
		if(money < 0) money = 0;

		FactionInfo[faction][fBudget] += money;

		log_init(true);
		log_set_table("logs_factions");
		log_set_keys("`PlayerId`,`PlayerName`,`FactionId`,`FactionName`,`ActionText`,`ExtraId`,`Amount`");
		log_set_values("'%d','%e','%d','%e','(FM) Pardave automobili','%d','%d'", LogPlayerId(playerid), LogPlayerName(playerid), FactionInfo[faction][fId], GetFactionName(faction, false), VehicleInfo[vehicleid][vId], money);
		log_commit();

		inline deleteVeh()
		{
			MsgSuccess(playerid, "Frakcija", "Tr. priemonë parduota, gavote $%d.", money);
			return 1;
		}
		mysql_tquery_inline(chandler, using inline deleteVeh, "\
			DELETE FROM `vehicles_server` WHERE id = '%d'",
			VehicleInfo[vehicleid][vId]
		);
		DestroyVehicle(vehicleid);
	}
	return 1;
}