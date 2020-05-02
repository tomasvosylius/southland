#include <YSI\y_hooks>

#define POLICE_NEEDED_TO_THIEF 			2
#define DEFAULT_BREAKIN_DOORS_DAMAGE 	5

#define MAX_CARS_FOR_THIEF_SPOT 		10

#define SIDE_JOB_POS 					2278.7861,-2205.5671,13.5469
#define LEVEL_REQUIRED 					5

#define MAX_STOLEN_CARS_FOR_THIEF 		4

#define CARS_REQUIRED_SIMPLE 			7 // Kiek reikes /cars pakrauti paprastu masinu
#define CARS_REQUIRED_SPECIAL 			3 // Kiek reikes /cars pakrauti brangiu masinu

#if CARS_REQUIRED_SPECIAL + CARS_REQUIRED_SIMPLE != MAX_CARS_FOR_THIEF_SPOT
	#error "CARS_REQUIRED_SIMPLE + CARS_REQUIRED_SIMPLE != MAX_CARS_FOR_THIEF_SPOT"
#endif

enum E_SPOT_INFO
{
	spotName[32],
	spotPlace,
	Text3D:spotLabel,
	spotCars[MAX_CARS_FOR_THIEF_SPOT],
	spotCarsNeed[MAX_CARS_FOR_THIEF_SPOT],
	spotCarsValue[MAX_CARS_FOR_THIEF_SPOT]
};
static 
	thief_Spot[E_SPOT_INFO];

static
	player_WaitTime[MAX_PLAYERS],
	player_Vehicle[MAX_PLAYERS],
	player_VehicleDoorStatus[MAX_PLAYERS],

	Text3D:player_Label[MAX_PLAYERS],

	bool:player_UnscrambleShown[MAX_PLAYERS],
	bool:player_BreakingIn[MAX_PLAYERS],

	player_TimeLeft[MAX_PLAYERS],
	player_UnscrambleWord[MAX_PLAYERS],
	player_WordsNeed[MAX_PLAYERS],
	player_WordsDone[MAX_PLAYERS],
	player_WordsTotal[MAX_PLAYERS],
	player_WordsGuessed[MAX_PLAYERS]; 

new 	
	PlayerText:Thief_TD[MAX_PLAYERS];

enum E_UNSCRAMBLE_WORDS
{
	uwCorrect[56],
	uwRandom[56]
};
static const unscramble_Words[][E_UNSCRAMBLE_WORDS] = {
	{"vanduo", "vuaodn"},
	{"alus", "usla"},
	{"virusas", "assuvir"},
	{"vaistai", "svitiaa"},
	{"marihuana", "nhuraamia"},
	{"kokainas", "ankaisok"},
	{"metaamfetaminas", "taameemfsatniam"},
	{"zolininkas", "zakisnionl"},
	{"sodininkas", "kadnisison"},
	{"voras", "orsav"},
	{"gyvate", "tvegay"},
	{"akmuo", "kmaou"},
	{"narkotikas", "katinroksa"},
	{"vaflis", "ilsfav"}
};

static const Float:thief_Spots_Available[][3] = {
	// Spotai is kurio atrenka servas
	{2669.3660,-2345.3923,13.6328},
	{2197.3584,-2661.7866,13.5469},
	{1858.1594,-1870.6274,13.5132},
	{1612.3083,-1502.9948,13.5459},
	{1164.1951,-1202.9816,19.8016},
	{956.3625,-1531.1366,13.5715},
	{957.0154,-1449.0217,13.5102},
	{2662.9241,-1590.5214,13.9276}
};
























hook OnMysqlEstablished()
{
	CreateDynamic3DTextLabel("Automobiliø vagys\nNaudokite /takesidejob", -1, SIDE_JOB_POS, 10.0);
	Spots_Update();
}

CMD:takesidejob(playerid, params[])
{	
	if(PlayerInfo[playerid][pSideJob] != 0) return SendWarning(playerid, "Jûs jau turite sidejob! /leavesidejob");
	if(IsPlayerInRangeOfPoint(playerid, 3.0, SIDE_JOB_POS))
	{
		if(PlayerInfo[playerid][pLevel] < LEVEL_REQUIRED) return SendWarning(playerid, "Nesate "#LEVEL_REQUIRED" lygio.");
		else
		{
			PlayerInfo[playerid][pSideJob] = SIDE_JOB_THIEF;
			SendFormat(playerid, -1, "Ásidarbinote á automobiliø vagis. Komandos: /help sidejob");
		}
	}
	// SendWarning(playerid, "Komanda iðjungta. Pildykite anketà www.forumas.communityrp.lt");
	return 1;
}

CMD:leavesidejob(playerid, params[])
{
	if(PlayerInfo[playerid][pSideJob] <= 0) return SendWarning(playerid, "Jûs neturite sidejob.");
	PlayerInfo[playerid][pSideJob] = 0;
	SendFormat(playerid, -1, "Palikote sidejob!");
	return 1;
}

hook OnPlayerEngineTurning(playerid, vehicleid, have_permission)
{
	new 
		engine, un;
	GetVehicleParamsEx(vehicleid, engine, un, un, un, un, un, un);
	if(!have_permission && IsItemInPlayerInventory(playerid, ITEM_TOOLBOX) && !engine)
	{
		if(player_UnscrambleShown[playerid]) return SendError(playerid, "Jûs jau pradëjote uþvedimà árankiu dëþute.");
		if(CountDutyPolice() < POLICE_NEEDED_TO_THIEF) return SendWarning(playerid, "Nëra bent "#POLICE_NEEDED_TO_THIEF" prisijungusiø on duty pareigûnø.");
		{
			Thief_Engine_Start(playerid, vehicleid);
		}
	}
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate != PLAYER_STATE_DRIVER)
	{
		if(player_UnscrambleShown[playerid])
		{
			Thief_Engine_End(playerid);
		}
	}
}

CMD:removespotmark(playerid, params[])
{
	RemovePlayerMapIcon(playerid, 99);
	SendFormat(playerid, 0xBABABAFF, "Þymë þemëlapyje panaikinta.");
	return 1;
}

CMD:thiefspots(playerid, params[])
{
	if(PlayerInfo[playerid][pSideJob] != SIDE_JOB_THIEF) return SendError(playerid, "Ði komanda veikia tik vagims.");
	else
	{
		// Tik vagiams yra atskiras spotas
		new 
			spot = thief_Spot[spotPlace];
		SetPlayerMapIcon(playerid, 99, thief_Spots_Available[spot][0], thief_Spots_Available[spot][1], thief_Spots_Available[spot][2], 0, 0x00aaffff, MAPICON_GLOBAL);
		SendFormat(playerid, 0x00aaffff, "Taðkas, prieinamas tik vagims paþymëtas þydra spalva. Ðis taðkas priima tik reikalingus automobilius.");
	}
	SendFormat(playerid, 0xBABABAFF, "Norëdami panaikinti þymæ, naudokite /removespotmark");
	return 1;
}

CMD:thiefcarlist(playerid, params[])
{
	if(PlayerInfo[playerid][pSideJob] != SIDE_JOB_THIEF) return SendError(playerid, "Nesate vagis!");
	new 
		string[256],
		string2[256];
	for(new car = 0; car < MAX_CARS_FOR_THIEF_SPOT; car++)
	{
		if(thief_Spot[spotCars][car] != 0 && thief_Spot[spotCarsValue][car] >= 1 && thief_Spot[spotCarsNeed][car] >= 1)
		{
			format(string, sizeof string, "%s[%dx %s] ", string, thief_Spot[spotCarsNeed][car], GetModelName(thief_Spot[spotCars][car]));
		}
	}
	SendFormat(playerid, 0xc25c43ff, "[SMS]: Dabar labiausiai reikia: %s", string);


	format(string, 1, "");
	for(new car = 0, idx = 0; car < MAX_CARS_FOR_THIEF_SPOT; car++)
	{
		if(thief_Spot[spotCars][car] != 0 && thief_Spot[spotCarsValue][car] <= 0 && thief_Spot[spotCarsNeed][car] >= 1)
		{
			if(idx <= 5) format(string, sizeof string, "%s[%dx %s] ", string, thief_Spot[spotCarsNeed][car], GetModelName(thief_Spot[spotCars][car]));
			else format(string2, sizeof string2, "%s[%dx %s] ", string2, thief_Spot[spotCarsNeed][car], GetModelName(thief_Spot[spotCars][car]));
			idx ++ ;

		}
	}
	SendFormat(playerid, 0xc25c43ff, "[SMS]: Jei turi, gali atveþt ir ðitas: %s", string);
	SendFormat(playerid, 0xc25c43ff, string2);
	return 1;
}

CMD:sellcar(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid)) return InfoBox(playerid, IB_NOT_IN_VEHICLE);
	new 
		vehicleid = GetPlayerVehicleID(playerid),
		model = GetVehicleModel(vehicleid);
	if(IsVehicleServer(vehicleid)) return SendWarning(playerid, "Tr. priemonë priklauso serveriui.");
	if(PlayerInfo[playerid][pSideJob] != SIDE_JOB_THIEF) return SendError(playerid, "Ði komanda veikia tik vagims!");
	if(PlayerInfo[playerid][pStolenCars] >= MAX_STOLEN_CARS_FOR_THIEF)
		{
			SendWarning(playerid, "Ðiandien Jûs jau esate pridavæs %d automobiliø", PlayerInfo[playerid][pStolenCars]);
			return 1;
	}
	new 
		spot = thief_Spot[spotPlace];
	if(IsPlayerInRangeOfPoint(playerid, 4.0, thief_Spots_Available[spot][0], thief_Spots_Available[spot][1], thief_Spots_Available[spot][2]))
	{
		if(PlayerInfo[playerid][pSideJob] == SIDE_JOB_THIEF)
		{
			for(new car = 0; car < MAX_CARS_FOR_THIEF_SPOT; car++)
			{
				new 
					spot_value = thief_Spot[spotCarsValue][car],
					spot_model = thief_Spot[spotCars][car];

				if(model == spot_model)
				{
					if(thief_Spot[spotCarsNeed][car] <= 0)
					{
						SendFormat(playerid, 0xc25c43ff, "[SMS]: Ðitos maðinos nebereikia, pavëlavai.");
					}
					else
					{
						new 
							money = floatround(VehicleInfo[vehicleid][vPrice] * 0.20) + random(3000);

						SendFormat(playerid, 0xc25c43ff, "[SMS]: Labai gerai, kad atveþei reikiamà modelá.");
						if(spot_value >= 1)
						{
							SendFormat(playerid, 0xc25c43ff, "[SMS]: Ðitos labai reikëjo, sumoku papildomai.", money);
							money = floatround(money * 1.15);
						}
						GivePlayerMoney(playerid, money);

						Destroy_Stolen_Vehicle(vehicleid);
						thief_Spot[spotCarsNeed][car] -- ;
						PlayerInfo[playerid][pStolenCars] ++ ;
						SaveAccountIntEx(playerid, "StolenCars", PlayerInfo[playerid][pStolenCars]);
					}
					return 1;
				}
			}
			SendFormat(playerid, 0xc25c43ff, "[SMS]: Ðitos maðinos man net nereikëjo.. Kam jà èia atvilkai? Dink!");
		}
		else SendFormat(playerid, 0xc25c43ff, "[SMS]: Tavæs nepaþástu.. Veþk á roþiná taðkà /thiefspots");
	}
	return 1;
}


stock Destroy_Stolen_Vehicle(vehicleid)
{
	new 
		spawnedby = FindPlayerBySql(VehicleInfo[vehicleid][vSpawnedBy]),
		ownerid = FindPlayerBySql(VehicleInfo[vehicleid][vOwner]);
	if(spawnedby != INVALID_PLAYER_ID)
	{
		PlayerInfo[spawnedby][pCarsSpawned]--;
	}
	if(ownerid != INVALID_PLAYER_ID)
	{
		SendFormat(ownerid, 0xf7ff7bff, "Jûsø transporto priemonë buvo iðardyta/pavogta!");
	}

	VehicleInfo[vehicleid][vInsurance]--;
	if(VehicleInfo[vehicleid][vInsurance] < 0)
	{
		new string[118];
		mysql_format(chandler, string, sizeof string, "DELETE FROM vehicles_data WHERE id = '%d'", VehicleInfo[vehicleid][vId]);
		mysql_fquery(chandler, string, "VehicleDeletedEx");
		if(ownerid != INVALID_PLAYER_ID)
		{
			SendFormat(ownerid, 0xBABABAFF, "Kadangi transporto priemonë neturëjo draudimo, ji sunaikinta negráþtamai.");
			PlayerInfo[ownerid][pHaveCars] -- ;
		}
		else
		{
			format(string, sizeof string, "Jûsø tr. priemonë %s (numeriai: %s) buvo sunaikinta negráþtamai.", 
				GetModelName(GetVehicleModel(vehicleid)), VehicleInfo[vehicleid][vNumbers]);
			AddPlayerLoginNote(VehicleInfo[vehicleid][vOwner], -1, string);
		}
	}
	else
	{
		SaveVehicleIntEx(vehicleid, "Insurance", VehicleInfo[vehicleid][vInsurance]);
		SaveVehicleIntEx(vehicleid, "SpawnedId", 0);
	}
	NullVehicle(vehicleid);
	DestroyVehicle(vehicleid);
	return 1;
}

hook OnNewDay()
{
	mysql_tquery(chandler, "UPDATE `players_data` SET StolenCars = '0'");
	foreach(new playerid : Player)
	{
		PlayerInfo[playerid][pStolenCars] = 0;
		SaveAccountIntEx(playerid, "StolenCars", 0);
	}
}

hook OnFullPayday()
{
	Spots_Update();
}

stock Spots_Update()
{
	new 	
		rand = random(sizeof thief_Spots_Available),
		empty[E_SPOT_INFO],
		string[512];

	thief_Spot = empty;
	thief_Spot[spotPlace] = rand;

	if(IsValidDynamic3DTextLabel(thief_Spot[spotLabel])) DestroyDynamic3DTextLabel(thief_Spot[spotLabel]);
	thief_Spot[spotLabel] = CreateDynamic3DTextLabel("/sellcar", -1, thief_Spots_Available[rand][0], thief_Spots_Available[rand][1], thief_Spots_Available[rand][2], 12.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID);

	mysql_format(chandler, string, sizeof string, "\
		SELECT `Model`,COUNT(`Model`) AS `Count` \
			FROM `vehicles_data` \
				WHERE Model NOT IN (472, 473, 484, 493, 595, 430, 446, 452, 453, 454, 481, 509, 510, 448, 461, 462, \
					463, 468, 471, 521, 522, 523, 581, 586, 487, 488, 497, 460, 476, 511, 512, 513, 519, 520, 553, 577, 592, 593) \
			GROUP BY `Model` ORDER BY `Count` DESC, RAND() \
		LIMIT "#CARS_REQUIRED_SIMPLE" OFFSET %d", random(4));
	mysql_tquery(chandler, string, "Thief_UpdateSimple", ""); 
}

forward Thief_UpdateSimple();
public Thief_UpdateSimple()
{
	new 
		rows = cache_num_rows();
	if(rows)
	{
		printf("SIMPLE CARS [%d free] :", 0);
		new 
			row = 0,
			count;
		for(new car = 0; car < rows; car++)
		{
			cache_get_value_name_int(row, "Model", thief_Spot[spotCars][car]);
			cache_get_value_name_int(row, "Count", count);
			// 								if <= 4 then ATS:1,  else if <= 10 ATS:2    else ATS:3
			thief_Spot[spotCarsNeed][car] = count <= 4 ? 1 : (count <= 10 ? 2 : 3);
			thief_Spot[spotCarsValue][car] = 0;

			printf("thief_Spot[spotCars][%d]: %s [%d] [%d$]", car, GetModelName(thief_Spot[spotCars][car]), thief_Spot[spotCarsNeed][car], thief_Spot[spotCarsValue][car]);
			row ++ ;
		}
	}
	mysql_tquery(chandler, "\
		SELECT `Model`,COUNT(`Model`) AS `Count` \
			FROM `vehicles_data` \
				WHERE Model NOT IN (472, 473, 484, 493, 595, 430, 446, 452, 453, 454, 481, 509, 510, 448, 461, 462, \
					463, 468, 471, 521, 522, 523, 581, 586, 487, 488, 497, 460, 476, 511, 512, 513, 519, 520, 553, 577, 592, 593) \
			GROUP BY `Model` ORDER BY `Price` DESC, RAND(), `Count` DESC \
		LIMIT 15", "Thief_UpdateExpensive", "d", rows); 

	return 1;
}

forward Thief_UpdateExpensive(free_slot_start);
public Thief_UpdateExpensive(free_slot_start)
{
	new 
		rows = cache_num_rows();

	new 
		randomized[CARS_REQUIRED_SPECIAL] = {-1,...},
		collected = 0;

	if(rows < MAX_CARS_FOR_THIEF_SPOT) {
		printf("Not enough personal cars ("#MAX_CARS_FOR_THIEF_SPOT") in server! Not doing Thief_UpdateExpensive(%d) [%d].", free_slot_start, rows);
		return 1;
	}

	new loop_counter = 0;
	while(collected < CARS_REQUIRED_SPECIAL && loop_counter < 5000)
	{
		new 
			idx = random(rows),
			bool:skip = false;
		for(new i = 0; i < CARS_REQUIRED_SPECIAL; i++)
		{
			if(randomized[i] == idx)
			{
				skip = true;
			}
		}
		if(!skip)
		{
			randomized[collected] = idx;
			collected ++ ;
		}
		loop_counter++;
	}
	if(loop_counter >= 4500) {
		printf("Thief_UpdateExpensive almost halted the server! [loops:%d] [rows:%d] [free_slot_start:%d]", loop_counter, rows, free_slot_start);
	}

	if(rows)
	{
		printf("SPECIAL CARS [%d free]:", free_slot_start);
		new 
			row = 0,
			count;
		for(new car = free_slot_start; car < MAX_CARS_FOR_THIEF_SPOT; car++)
		{
			cache_get_value_name_int(randomized[row], "Model", thief_Spot[spotCars][car]);
			cache_get_value_name_int(randomized[row], "Count", count);
			thief_Spot[spotCarsNeed][car] = (1 <= count <= 4) ? 1 : 2;
			thief_Spot[spotCarsValue][car] = 1;

			printf("thief_Spot[spotCars][%d]: %s [%d] [%d$]", car, GetModelName(thief_Spot[spotCars][car]), thief_Spot[spotCarsNeed][car], thief_Spot[spotCarsValue][car]);
			row ++ ;
		}
	}
	return 1;
}


CMD:stopbreakin(playerid, params[])
{
	if(player_Vehicle[playerid] != INVALID_VEHICLE_ID)
	{
		if(IsValidDynamic3DTextLabel(player_Label[playerid])) DestroyDynamic3DTextLabel(player_Label[playerid]);
		player_Vehicle[playerid] = INVALID_VEHICLE_ID;
		player_BreakingIn[playerid] = false;
		player_Label[playerid] = Text3D:-1;
	}
	else if(player_UnscrambleShown[playerid])
	{
		Thief_Engine_End(playerid, false);
	}
	return 1;
}
alias:uns("unscramble");
CMD:uns(playerid, params[])
{
	new 
		vehicleid = GetPlayerVehicleID(playerid);
	if(vehicleid == INVALID_VEHICLE_ID || GetPlayerVehicleSeat(playerid) != 0) return InfoBox(playerid, IB_NOT_IN_VEHICLE);
	if(!player_UnscrambleShown[playerid]) return SendError(playerid, "Nesate pradëjæs uþvedimo (/engine).");
	if(!strlen(params)) return SendUsage(playerid, "/uns(cramble) [þodis]");

	player_WordsGuessed[playerid] ++;
	if(strcmp(params, unscramble_Words[player_UnscrambleWord[playerid]][uwCorrect], true) == 0)
	{
		player_WordsDone[playerid] ++ ;
	}
	else
	{
		// jei turi maziau likusiu nei liko atspet, kam dar test? failed
		if(player_WordsNeed[playerid] - player_WordsDone[playerid] > player_WordsTotal[playerid] - player_WordsGuessed[playerid] || player_WordsTotal[playerid] - player_WordsGuessed[playerid] <= 0)
		{
			// nebeturi spejimu
			Thief_Engine_End(playerid);
			return 1;
		}
	}

	if(player_WordsNeed[playerid] - player_WordsDone[playerid] <= 0)
	{
		// uzveda

		new engine, lights, alarm, doors, bonnet, boot, objective;
		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
		SetVehicleParamsEx(vehicleid, 1, lights, alarm, doors, bonnet, boot, objective);

		// ChangeVehicleEngineStatus

		SendFormat(playerid, 0xd46b6bff, "Uþvedëte transporto priemonæ!");
		// if vagis
		Thief_Engine_End(playerid, false);
		return 1;
	}

	Unscramble_Update(playerid, .time = player_TimeLeft[playerid], .word_index = random(sizeof unscramble_Words), .words_done = player_WordsDone[playerid], .words_total = player_WordsTotal[playerid], .words_need = player_WordsNeed[playerid], .words_guessed = player_WordsGuessed[playerid]);
	return 1;
}

CMD:breakin(playerid, params[])
{
	if(!IsItemInPlayerInventory(playerid, ITEM_TOOLBOX)) return SendWarning(playerid, "Neturite árankiø dëþutës.");
	if(IsPlayerInAnyVehicle(playerid)) return InfoBox(playerid, IB_GET_OUT_VEHICLE);
	new 
		vehicleid = GetClosestVehicle(playerid, 5.0);
	if(vehicleid != INVALID_VEHICLE_ID)
	{
		if(IsVehicleServer(vehicleid)) return SendWarning(playerid, "Tr. priemonë priklauso serveriui.");
		if(!VehicleInfo[vehicleid][vLocked]) return SendWarning(playerid, "Tr. priemonë jau yra atrakinta.");
		if(CountDutyPolice() < POLICE_NEEDED_TO_THIEF) return SendWarning(playerid, "Nëra bent "#POLICE_NEEDED_TO_THIEF" prisijungusiø on duty pareigûnø.");
		Thief_Start(playerid, vehicleid);
		player_Vehicle[playerid] = vehicleid;
		return 1;
	}
	else SendWarning(playerid, "Aplink jus nëra tr. priemoniø.");
	return 1;
}

forward T_Thief(playerid);
public T_Thief(playerid)
{
	if(!IsPlayerConnected(playerid) || IsPlayerNPC(playerid)) return 1;
	if(player_UnscrambleShown[playerid])
	{
		player_TimeLeft[playerid] -- ;
		if(player_TimeLeft[playerid] <= 0)
		{
			Thief_Engine_End(playerid);
		}
		else
		{
			Unscramble_Update(playerid, .time = player_TimeLeft[playerid], .word_index = player_UnscrambleWord[playerid], .words_done = player_WordsDone[playerid], .words_total = player_WordsTotal[playerid], .words_need = player_WordsNeed[playerid], .words_guessed = player_WordsGuessed[playerid]);
			SetTimerEx("T_Thief", 1000, false, "d", playerid);
		}	
	}
	return 1;
}

stock Thief_Engine_End(playerid, bool:msg = true)
{
	msg && SendFormat(playerid, 0xd46b6bff, "Variklio uþvedimas nepavyko. Galite bandyti ið naujo.");
	Unscramble_Hide(playerid);
	return 1;
}

stock Thief_Engine_Start(playerid, vehicleid)
{
	new 
		time,
		total,
		need;
	
	switch(VehicleInfo[vehicleid][vLock])
	{
		case 1:
		{
			time = 90;
			total = 20;
			need = 6;
		}	
		case 2:
		{
			time = 70;
			total = 15;
			need = 8;
		}
		case 3:
		{
			time = 60;
			total = 15;
			need = 9;
		}
		case 4:
		{
			time = 50;
			total = 15;
			need = 10;
		}
		default:
		{
			time = 90;
			total = 20;
			need = 5;
		}
	}

	player_Vehicle[playerid] = vehicleid;

	SendFormat(playerid, 0xd46b6bff, "Norëdami uþvesti transporto priemonæ su árankiø dëþute, turite sudëti þodþius.");
	SendFormat(playerid, 0xd46b6bff, "Per %d sek. teisingai turite sudëti %d þodþiø.", time, need);
	SendFormat(playerid, 0xd46b6bff, "Norëdami atðaukti, naudokite /stopthief");

	Unscramble_Update(playerid, .time = time, .word_index = random(sizeof unscramble_Words), .words_done = 0, .words_total = total, .words_need = need);
	SetTimerEx("T_Thief", 1000, false, "d", playerid);
	return 1;
}

stock Unscramble_Update(playerid, time, word_index, words_done, words_total, words_need, words_guessed = 0)
{
	new 
		string[256];

	player_UnscrambleWord[playerid] = word_index;
	player_WordsGuessed[playerid] = words_guessed;
	player_WordsTotal[playerid] = words_total;
	player_WordsDone[playerid] = words_done;
	player_WordsNeed[playerid] = words_need;
	player_TimeLeft[playerid] = time;
	
	format(string, sizeof string, "\
		Noredami uzvesti automobilio varikli, naudokite ~r~/uns(cramble) [zodis]~n~\
		~w~Sudeliokite zodi: ~y~%s~n~\
		~w~Atspeta zodziu: ~g~%d/%d, ~w~liko spejimu: ~r~%d~n~\
		Liko laiko: ~r~%ds", strtoupper(unscramble_Words[word_index][uwRandom]), words_done, words_need, words_total - words_guessed, time);
	PlayerTextDrawSetString(playerid, Thief_TD[playerid], string);

 	if(!player_UnscrambleShown[playerid])
 	{
 		Unscramble_Show(playerid);
 	}
}

stock Unscramble_Show(playerid)
{
	PlayerTextDrawShow(playerid, Thief_TD[playerid]);
	player_UnscrambleShown[playerid] = true;
}

stock Unscramble_Hide(playerid)
{
	PlayerTextDrawHide(playerid, Thief_TD[playerid]);
	player_UnscrambleShown[playerid] = false;
}


stock Thief_UnlockVehicle(playerid, vehicleid)
{
	if(VehicleInfo[vehicleid][vLocked])
	{
		VehicleInfo[vehicleid][vLocked] = false;

		new engine, lights, alarm, doors, bonnet, boot, objective;
		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
		SetVehicleParamsEx(vehicleid, engine, lights, alarm, false, bonnet, boot, objective);
	}

	new bonnet, boot, driver_door, passenger_door;
	GetVehicleDoors(vehicleid, bonnet, boot, driver_door, passenger_door);
	SetVehicleDoors(vehicleid, bonnet, boot, 2, passenger_door);

	player_BreakingIn[playerid] = false;
	SendFormat(playerid, 0x9bcb46ff, "Durys atrakintos! Álipæ á transporto priemonæ raðykite /engine");

	SetTimerEx("T_ThiefRemoveLabel", 5000, false, "dd", playerid, _:player_Label[playerid]);
	return 1;
}

forward T_ThiefRemoveLabel(playerid, label);
public T_ThiefRemoveLabel(playerid, label)
{
	if(IsValidDynamic3DTextLabel(Text3D:label)) DestroyDynamic3DTextLabel(Text3D:label);
	player_Vehicle[playerid] = INVALID_VEHICLE_ID;
	player_BreakingIn[playerid] = false;
	if(Text3D:label == player_Label[playerid])
	{
		player_Label[playerid] = Text3D:-1;
	}
	return 1;
}

stock Thief_Start(playerid, vehicleid)
{
	new 
		Float:x, Float:y, Float:z,
		string[126];

	if(VehicleInfo[vehicleid][vLock] >= 3)
	{ 
		GetPlayerPos(playerid, tlc_pd[0], tlc_pd[1], tlc_pd[2]);

		GetCoords2DZone(string, 28, tlc_pd[0], tlc_pd[1]);
		format(string, sizeof string, "Gautas iðkvietimas apie automobilio %s[%s] vagystæ! Vieta: %s ((/tlc)):", GetModelName(GetVehicleModel(vehicleid)), VehicleInfo[vehicleid][vNumbers], string);

		new _f;
		foreach(new officer : Player)
		{
			_f = GetFactionArrayIndexById(PlayerInfo[officer][pFaction]);
			if(_f != -1 && FactionInfo[_f][fType] == FACTION_TYPE_POLICE)
			{
				SendClientMessage(officer, 0x468EE6FF, string);
			}
		}

		new 
			ownerid;
		if((ownerid = FindPlayerBySql(VehicleInfo[vehicleid][vOwner])) != INVALID_PLAYER_ID)
		{
			SendFormat(ownerid, -1, "Jûsø transporto priemonë %s yra vogiama!", GetModelName(GetVehicleModel(vehicleid)));
		}
	}

	if(VehicleInfo[vehicleid][vLock] >= 2)
	{
		new engine, lights, alarm, doors, bonnet, boot, objective;
		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
		SetVehicleParamsEx(vehicleid, engine, lights, 1, doors, bonnet, boot, objective);

		SetTimerEx("T_DisableAlarm", 10000, false, "d", vehicleid);
	}

	SendFormat(playerid, 0xffbababa, "Pradëjote ásilauþimà á transporto priemonæ. Sustoti galite /stopbreakin");
	SendFormat(playerid, 0xffbababa, "Dauþykite tr. priemonës duris beisbolo lazda arba rankomis.");

	GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, x, y, z);

	player_Label[playerid] = CreateDynamic3DTextLabel("100%", 0xd46b6bff, (x * -0.4), (y * 0.13), (z * -0.1), 3.0, INVALID_PLAYER_ID, vehicleid);
	player_VehicleDoorStatus[playerid] = 100;
	player_BreakingIn[playerid] = true;

	SetTimerEx("T_ThiefRemoveLabel", 60000, false, "dd", playerid, _:player_Label[playerid]);
	return 1;
}

forward T_DisableAlarm(vehicleid);
public T_DisableAlarm(vehicleid)
{
	new engine, lights, alarm, doors, bonnet, boot, objective;
	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	SetVehicleParamsEx(vehicleid, engine, lights, 0, doors, bonnet, boot, objective);
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	if(IsValidDynamic3DTextLabel(player_Label[playerid])) DestroyDynamic3DTextLabel(player_Label[playerid]);
	return 1;
}

hook OnPlayerConnect(playerid)
{
	player_UnscrambleShown[playerid] = false;
	Thief_TD[playerid] = CreatePlayerTextDraw(playerid, 122.761955, 312.453277, "Bandote_isilauzti_i_automobili!~n~Naudokite_/uns(cramble)_[zodis]~n~~n~Teisingai_sudekite_zodi:_AVSGI");
	PlayerTextDrawLetterSize(playerid, Thief_TD[playerid], 0.255619, 1.194666);
	PlayerTextDrawAlignment(playerid, Thief_TD[playerid], 1);
	PlayerTextDrawColor(playerid, Thief_TD[playerid], -1);
	PlayerTextDrawSetOutline(playerid, Thief_TD[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Thief_TD[playerid], 255);
	PlayerTextDrawFont(playerid, Thief_TD[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Thief_TD[playerid], 1);
	return 1;
}

hook OnUnoccupiedVehicleUpd(vehicleid, playerid, passenger_seat)
{
	if(vehicleid == player_Vehicle[playerid] && player_BreakingIn[playerid])
	{
		new 
			weaponid = GetPlayerWeapon(playerid);
		if((weaponid == WEAPON_BAT || weaponid == 0) && GetPlayerCameraMode(playerid) == 4)
		{
			new 
				keys, un;
			GetPlayerKeys(playerid, keys, un, un);
			if(((keys & KEY_FIRE) || (keys & KEY_SECONDARY_ATTACK)) && GetTickDiff(GetTickCount(), player_WaitTime[playerid]) > 500)
			{
				new 
					string[13],
					color;

				player_VehicleDoorStatus[playerid] -= (weaponid == WEAPON_BAT) ? (Thief_Vehicle_GetDamage(vehicleid)) : (1 + random(2));
				player_WaitTime[playerid] = GetTickCount();

				if(player_VehicleDoorStatus[playerid] <= 0)
				{
					color = 0x46c83dFF;
					format(string, sizeof string, "Atrakinta!");

					Thief_UnlockVehicle(playerid, player_Vehicle[playerid]);
				}
				else
				{
					color = 0xd46b6bff;
					format(string, sizeof string, "%d%", player_VehicleDoorStatus[playerid]);
				}
				UpdateDynamic3DTextLabelText(player_Label[playerid], color, string);
			}
		}
	}
	return 1;
}

stock Thief_Vehicle_GetDamage(vehicleid)
{
	// nuo bytos dmg
	new 
		int;
	switch(VehicleInfo[vehicleid][vLock])
	{
		case 1:
		{
			int = 8 + random(4);
		}
		case 2:
		{
			int = 6 + random(4);
		}
		case 3:
		{
			int = 4 + random(2);
		}
		case 4:
		{	
			int = 3 + random(2);
		}
		default:
		{
			int = 10 + random(5);
		}
	}
	return int;
}

stock GetDoorState(doorStates, Door:door, DoorState:doorState)
	return (doorStates >>> (8 * door)) & doorState;

stock SetDoorState(Door:doorid, DoorState:doorState)
{
	return (8 * door & doorState);
}
