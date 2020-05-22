	/*


	=========================================================================
	Server anti-cheat include
	Credits: 
		f0cus
	Thanks:
		Emmet, Y_Less, RyDeR`, JernejL
	=========================================================================

	   ____        _   _                 
	  / __ \      | | (_)                
	 | |  | |_ __ | |_ _  ___  _ __  ___ 
	 | |  | | '_ \| __| |/ _ \| '_ \/ __|
	 | |__| | |_) | |_| | (_) | | | \__ \ 
	  \____/| .__/ \__|_|\___/|_| |_|___/
	        | |                          
	        |_|                          
	
	AC_WEAPONS_CHECK_ALWAYS 		 			true/false
	[true] 	ginklø/ammo cheat bus tikrinamas nuolatos (pagal timerio intervalà.);
	[false] bus tikrinamas cheat tik pakeitus (prascrollinus)/gavus/praradus ginklà (naudojama maþiau serverio resursø);

	AC_ENABLE_WEAPONS 							true/false 
	[true] 	ájungiamas ginklø ir ammo anticheatas
	[false] ginklø ir ammo anticheatas iðjungtas

	AC_ENABLE_MONEY 							true/false
	[true] 	server-sided pinigø anticheatas ájungtas. Sucheatinti pinigai bus graþinami á normalià reikðmæ;
	[false] pinigø anticheat atjungtas


	AC_ENABLE_AIRBREAK 							true/false
	[true]	apsauga nuo air-break cheatinimo
	[false] apsauga iðjungta


	AC_ENABLE_HEALTH 							true/false
	[true]	þaidëjo ir tr. priemoniø gyvybiø, bei ðarvø anticheat
	[false] apsauga iðjungta


	AC_ENABLE_SPEED 							true/false
	[true]	þaidëjo tr. priemonëje speedhack apsauga
	[false] apsauga iðjungta


	AC_ENABLE_INV 								true/false
	[true]	apsauga nuo nemirtingumo
	[false] apsauga iðjungta

	AC_ENABLE_JETPACK 							true/false
	[true]	apsauga nuo jet-pack
	[false] apsauga iðjungta

	// Pridetos V2:

	AC_ENABLE_DIALOGS 							true/false
	[true] 	apsauga nuo fake dialog ijungta
	[false] apsauga isjungta

	AC_ENABLE_FLOOD 							true/false
	[true] 	apsauga nuo ddos floodo
	[false] apsauga isjungta

	AC_ENABLE_NPC 								true/false
	[true] 	apsauga nuo NPC botu prijungimo
	[false] apsauga isjungta

	AC_ENABLE_FAKEKILL 							true/false
	[true] 	apsauga nuo fake-kill ijungta
	[false] apsauga isjungta

	AC_ENABLE_RAPIDFIRE 						true/false
	[true] 	apsauga nuo rapid-fire ijungta
	[false] apsauga isjungta

	AC_ENABLE_AIMBOT 							true/false
	[true] 	apsauga nuo aimbot ijungta
	[false] apsauga isjungta

	AC_ENABLE_WARP_INTO_CAR 					true/false
	[true] 	apsauga nuo car warp ijungta
	[false] apsauga isjungta

	AC_ENABLE_TROLLBOSS 						true/false
	[true] 	apsauga nuo trollboss ijungta
	[false] apsauga isjungta

	#define AC_AIRBREAK_MAX_WARNINGS 			[1-NaN]
	po keliø pasikartotinø airbreak iðkvieèiamas OnPlayerAirbreak(playerid) callbackas
	(rekomenduojama 2/3)

	#define AC_FAKE_KILL_MAX_WARNINGS 			[1-NaN]
	po kiek cheat aptikimø pilnai iðkvieèiamas OnPlayerFakeKillCheat(playerid) callbackas
	(rekomenduojama 2/3)


	#define AC_INV_MAX_WARNINGS 				[1-Nan]
	po kiek cheat aptikimø pilnai iðkvieèiamas OnPlayerInvulnerable(playerid) callbackas
	(rekomenduojama: 5/6)

	#define AC_HIGH_PING_MARK					[1-300]
	(rekomenduojama 250-300)


	  ______                _   _                 
	 |  ____|              | | (_)                
	 | |__ _   _ _ __   ___| |_ _  ___  _ __  ___ 
	 |  __| | | | '_ \ / __| __| |/ _ \| '_ \/ __|
	 | |  | |_| | | | | (__| |_| | (_) | | | \__ \ 
	 |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
	                                              

	// V1:                                  	            
	forward OnPlayerWeaponCheat(playerid, weaponid, ammo);
	forward OnPlayerMoneyCheat(playerid, amount);
	forward OnPlayerAirbreak(playerid);
	forward OnPlayerVehicleHealthCheat(playerid, vehicleid);
	forward OnPlayerSpeedCheat(playerid, vehicleid);
	forward OnPlayerFakeKillCheat(playerid);
	forward OnPlayerInvulnerable(playerid);
	forward OnPlayerHealthCheat(playerid);
	forward OnPlayerArmourCheat(playerid);
	forward OnPlayerJetpackCheat(playerid);
	stock FAC_IsAfk(playerid); 

	// Pridetos V2:
	forward OnPlayerDialogCheat(playerid);
	forward OnPlayerRapidFire(playerid);
	forward OnPlayerWarpIntoCar(playerid, vehicleid);
	forward OnPlayerCarWarp(playerid, vehicleid);
	forward OnPlayerAimbot(playerid);

	// V3 Updates	
	Pridetos:
			forward OnPlayerTrollBoss(playerid);
	Isimta: 
			forward OnPlayerCarWarp(playerid, vehicleid);
	
	// V4
	forward OnPlayerModCheat(playerid, vehicleid, componentid);

	// V5
	Isimta:
		stock FAC_IsAfk(playerid); 

	Prideta:
		IsPlayerAFK(playerid);
		IsPlayerControllable(playerid);
		Patobulintas anti-godmode(inv) aptikimas
		forward OnPlayerHighPing(playerid, count);
		AC_HIGH_PING_MARK

	// V6
	Prideta:
		AC_ENABLE_PARACHUTE_DAMAGE
		AC_ENABLE_GOGGLES_FIX
	Bus atimtas parasiutas, jei daromas damage masinai (samp bug).
	Night vision veiks tik zaidejui.

	// version 1.6.1:
	OnPlayerSeatChangerCheat
	OnPlayerCarChangerCheat
	Improved Warp into car(prideta CancelEnterVehicle)
	Config: AC_IGNORE_PAYNSPRAY_VEHICLE_HP
	WarpIntoCar turetu but aptinkamas ir paspaudus HOME is kitos masinos.

	// 1.6.2
	WarpIntoCar negaudydavo, jei i uzrakinta nuteleportina su G mygtuku (samp bug)

*/
 
#if !defined AC_DONT_USE_YSI
	#tryinclude <YSI_Coding\y_hooks>
	#define _INC_y_hooks
#else 
	#if defined _INC_y_hooks
		#undef _INC_y_hooks
	#endif
#endif

#define AC_MAJOR			1
#define AC_MINOR			6	
#define AC_REVISION 		2
#define AC_SHAKE 			d62f0c
#define AC_FULL_VERSION		#AC_MAJOR"."#AC_MINOR"."#AC_REVISION"."#AC_SHAKE

#if defined _fc_ac_included
	#endinput
#endif
#define _fc_ac_included

#if !defined IsValidVehicle
    native IsValidVehicle(vehicleid);
#endif

#define AC_playerloop(%0) 					foreach(new %0 : Player) //for(new %0 = 0, __player_limit = GetPlayerPoolSize(); %0 <= __player_limit; %0++) 	 arba foreach(new vehicleid : Vehicle) arba foreach(Vehicle, vehicleid)
#define AC_vehicleloop(%0)					foreach(new %0 : Vehicle) //for(new %0 = 1, __vehicle_limit = GetVehiclePoolSize(); %0 <= __vehicle_limit; %0++) arba foreach(new playerid : Player) arba foreach(Player, playerid)

// Nustatymai
#define AC_WEAPONS_TIME 					500 	
#define AC_MONEY_TIME 						450 	
#define AC_AIRBREAK_TIME 					200 
#define AC_HEALTH_TIME 						800
#define AC_SPEED_TIME 						250
#define AC_TELEPORTER_TIME					350
#define AC_MISC_TIME 						1500
#define AC_AFK_MAX_TIME						1600 // Po kiek laiko zaidejas fiksuojamas AFK							

#define FAC_INVALID_OBJECT_ID				65535
#define FAC_INVALID_VEHICLE_ID				65535

/*
***************************
Enables/disables
***************************
*/
#if !defined AC_ENABLE_WEAPONS 
	#define AC_ENABLE_WEAPONS 					true
#endif
#if !defined AC_ENABLE_MONEY
	#define AC_ENABLE_MONEY 					true
#endif
#if !defined AC_ENABLE_AIRBREAK
	#define AC_ENABLE_AIRBREAK 					true
#endif
#if !defined AC_ENABLE_HEALTH
	#define AC_ENABLE_HEALTH 					true
#endif
#if !defined AC_ENABLE_SPEED
	#define AC_ENABLE_SPEED 					true
#endif
#if !defined AC_ENABLE_INV
	#define AC_ENABLE_INV 						true
#endif
#if !defined AC_ENABLE_JETPACK
	#define AC_ENABLE_JETPACK 					true
#endif
#if !defined AC_ENABLE_DIALOGS
	#define AC_ENABLE_DIALOGS 					true
#endif
#if !defined AC_ENABLE_FLOOD
	#define AC_ENABLE_FLOOD 					true
#endif
#if !defined AC_ENABLE_NPC
	#define AC_ENABLE_NPC 						true
#endif
#if !defined AC_ENABLE_FAKEKILL
	#define AC_ENABLE_FAKEKILL 					true
#endif
#if !defined AC_ENABLE_RAPIDFIRE 				
    #define AC_ENABLE_RAPIDFIRE 				true
#endif
#if !defined AC_ENABLE_WARP_INTO_CAR 					
    #define AC_ENABLE_WARP_INTO_CAR 			true 
#endif 
#if !defined AC_ENABLE_AIMBOT 
    #define AC_ENABLE_AIMBOT 					true
#endif
#if !defined AC_ENABLE_TROLLBOSS
	#define AC_ENABLE_TROLLBOSS 				true 
#endif
#if !defined AC_ENABLE_ANTIMOD	
	#define AC_ENABLE_ANTIMOD					true
#endif
#if !defined AC_ENABLE_PARACHUTE_DAMAGE
	#define AC_ENABLE_PARACHUTE_DAMAGE			true
#endif
#if !defined AC_ENABLE_GOGGLES_FIX
	#define AC_ENABLE_GOGGLES_FIX				true
#endif 
#if !defined AC_ENABLE_SEAT_CHANGER
	#define AC_ENABLE_SEAT_CHANGER				true
#endif 
#if !defined AC_ENABLE_CAR_CHANGER
	#define AC_ENABLE_CAR_CHANGER				true
#endif 
#if !defined AC_ENABLE_PICKUP_TELEPORT
	#define AC_ENABLE_PICKUP_TELEPORT			true
#endif 
#if !defined AC_ENABLE_TELEPORTER
	#define AC_ENABLE_TELEPORTER				true
#endif 
#if !defined AC_ENABLE_VW_INT
	#define AC_ENABLE_VW_INT					true
#endif 
/* 
****************************
Settings 
****************************
*/
#if !defined AC_WEAPONS_CHECK_ALWAYS
	#define AC_WEAPONS_CHECK_ALWAYS 		 	true
#endif
#if !defined AC_WEAPONS_SKIP_MULTIPLE_BANS
	#define AC_WEAPONS_SKIP_MULTIPLE_BANS 		true
#endif
#if !defined AC_AIRBREAK_MAX_WARNINGS
	#define AC_AIRBREAK_MAX_WARNINGS 			2
#endif
#if !defined AC_FAKE_KILL_MAX_WARNINGS
	#define AC_FAKE_KILL_MAX_WARNINGS 			2
#endif
#if !defined AC_INV_MAX_WARNINGS
	#define AC_INV_MAX_WARNINGS 				4
#endif
#if !defined AC_HIGH_PING_MARK
	#define AC_HIGH_PING_MARK					300				
#endif
#if !defined AC_IGNORE_PAYNSPRAY_VEHICLE_HP
	#define AC_IGNORE_PAYNSPRAY_VEHICLE_HP		false
#endif
/* Airbrk */
#define AC_AIRBRK_ON_FOOT_DISTANCE				75.0
#define AC_AIRBRK_IN_VEHICLE_DISTANCE			50.0
/* Aim */
#if !defined AC_AIM_MAX_PACKET_LOSS
	#define AC_AIM_MAX_PACKET_LOSS 5
#endif
#if !defined AC_AIM_MAX_PING
	#define AC_AIM_MAX_PING 600
#endif
#if !defined AC_AIM_MAX_CONTINIOUS_SHOT_PRB
	#define AC_AIM_MAX_CONTINIOUS_SHOT_PRB 10
#endif
#if !defined AC_AIM_MAX_TELEPORT_SHOT_PRB
	#define AC_AIM_MAX_TELEPORT_SHOT_PRB 3
#endif
#if !defined AC_AIM_MAX_OOF_SHOTS_PRB
	#define AC_AIM_MAX_OOF_SHOTS_PRB 2
#endif
#if !defined AC_AIM_MAX_RANDOM_SHOT_PRBG
	#define AC_AIM_MAX_RANDOM_SHOT_PRBG 5
#endif
#if !defined AC_MIN_DIST_FOR_AIM_CHECKS
	#define AC_MIN_DIST_FOR_AIM_CHECKS 10
#endif
#if !defined AC_AIM_SPHERE_RADIUS
	#define AC_AIM_SPHERE_RADIUS 3
#endif
/** Car changer */
#if !defined AC_CAR_CHANGER_MAX_WARNS
	#define AC_CAR_CHANGER_MAX_WARNS 3
#endif
/** Teleporter */
#if !defined AC_TELEPORT_DISTANCE_IN_CAR
	#define AC_TELEPORT_DISTANCE_IN_CAR 40.0
#endif
#if !defined AC_TELEPORT_DISTANCE_ON_FOOT
	#define AC_TELEPORT_DISTANCE_ON_FOOT 22.0
#endif
#if !defined AC_TELEPORT_DISTANCE_INSTA_KICK
	#define AC_TELEPORT_DISTANCE_INSTA_KICK 100.0
#endif
#if !defined AC_TELEPORT_WARNINGS
	#define AC_TELEPORT_WARNINGS 3
#endif


enum 
{
	CHEAT_WEAPON 		= 1,
	CHEAT_MONEY 		= 2,
	CHEAT_AIRBRK		= 3,
	CHEAT_VEH_HEALTH	= 4,
	CHEAT_VEH_SPEED		= 5,
	CHEAT_FAKE_KILL		= 6,
	CHEAT_GODMODE		= 7,
	CHEAT_HEALTH 		= 8,
	CHEAT_ARMOUR 		= 9,
	CHEAT_JETPACK		= 10,
	CHEAT_WARP_TO_CAR	= 11,
	CHEAT_AIMBOT		= 12,
	CHEAT_TROLLBOSS		= 13,
	CHEAT_DIALOG_CHEAT	= 14,
	CHEAT_RAPID_FIRE	= 15,
	CHEAT_VEH_MODS		= 16,
	CHEAT_HIGH_PING		= 17,
	CHEAT_PICKUP_TP		= 18,
	CHEAT_SEAT_CHANGER	= 19,
	CHEAT_CAR_CHANGER	= 20,
	CHEAT_TELEPORTER	= 21,
	CHEAT_VW_INT		= 22,
	CHEAT_NOPS			= 100
};

enum 
{
	NOP_REMOVE_FROM_VEHICLE 	= 1
}

// Forwards
forward OnPlayerCheat(playerid, code, extra_id_1, extra_id_2);

#define ALS_DO_VehicleDestroyed<%0> %0<VehicleDestroyed,i>(end:vehicleid)
#define ALS_DO_VehicleCreated<%0> %0<VehicleCreated,i>(end:vehicleid)

// Local forwards
forward FAC_OnPlayerWeaponChanged(playerid, newweapon, oldweapon);

// Kintamieji
enum E_AC_WEAPONS
{
	e_ac_WeaponId,
	e_ac_WeaponAmmo
};

enum E_AC_AIRBREAK
{
	Float:e_ac_AirBrkX,
	Float:e_ac_AirBrkY,
	Float:e_ac_AirBrkZ,
	e_ac_AirBrkImmune,
	e_ac_AirBrkDetected,
	e_ac_AirBrkLast,
	e_ac_AirBrkLastChk
};

enum E_AC_JOINS
{
	e_ac_JoinIP,
	e_ac_JoinTimeStamp
};


enum (<<=1)
{
	WARNING_OUT_OF_RANGE_SHOT=1,
	WARNING_PROAIM_TELEPORT,
	WARNING_RANDOM_AIM,
	WARNING_CONTINOUS_SHOTS
};

enum (<<=1)
{
	PREVIOUS_SHOT_DID_DAMAGE=1,
};

enum (<<=1)
{
	AC_AFLAG_CHK_CONTINOUS_SHOTS=1,
	AC_AFLAG_CHK_PROAIM_TELEPORT,
	AC_AFLAG_CHK_RANDOM_SHOTS,
	AC_AFLAG_CHK_OOF_SHOTS,
	IGNORE_PLAYER
};



static const Float:BustAim_g_WeaponRange[] =
{
	45.0, 45.0, 45.0, 50.0, 45.0, 50.0, 45.0, 55.0, 100.0, 120.0, 45.0, 110.0, 320.0, 0.0, 0.0, 0.0, 85.0
};


static 
	ac__PlayerWeapons[MAX_PLAYERS][13][E_AC_WEAPONS],
	ac__LastWeapon[MAX_PLAYERS],
	ac__IgnoreWeapons[MAX_PLAYERS],
	
	ac__PlayerMoney[MAX_PLAYERS],
	ac__IgnoreMoney[MAX_PLAYERS],

	ac__AirBreak[MAX_PLAYERS][E_AC_AIRBREAK],
	
	ac__Joins[30][E_AC_JOINS],

	ac__LastDeath[MAX_PLAYERS],
	ac__DeathSpam[MAX_PLAYERS],

	ac__Dialog[MAX_PLAYERS],

	ac__InnerHighPingWarnings[MAX_PLAYERS],
	ac__HighPingWarnings[MAX_PLAYERS],

	bool:ac__UsingJetpack[MAX_PLAYERS],
	bool:ac__JetpackGiven[MAX_PLAYERS],

	bool:ac__Spawned[MAX_PLAYERS],
	bool:ac__ReturnState[MAX_PLAYERS],
	ac__InvWarnings[MAX_PLAYERS],

	ac__SpecialAction[MAX_PLAYERS],

	ac__Aim_PlayerSettings[MAX_PLAYERS char],
	ac__Aim_LastWeapon[MAX_PLAYERS char],
	ac__Aim_InternalSettings[MAX_PLAYERS char],
	ac__Aim_ContiniousShots[MAX_PLAYERS char],
	ac__Aim_RandomShots[MAX_PLAYERS char],
	ac__Aim_TeleportShots[MAX_PLAYERS char],
	ac__Aim_OutOfRangeShots[MAX_PLAYERS char],

	ac__LastShot[MAX_PLAYERS],
	ac__ShotCount[MAX_PLAYERS],

	/** Naudojamas warp into car */
	ac__EnteringVehicle[MAX_PLAYERS],
	ac__LastVehicle[MAX_PLAYERS],

	/** Naudojamas su car changer */
	ac__CurrentVehicle[MAX_PLAYERS],
	ac__VehicleChangeTime[MAX_PLAYERS],
	ac__CarChangerWarns[MAX_PLAYERS],

	/** Naudojamas su seat changer */
	ac__LastDriveState[MAX_PLAYERS],

	/** Position changer / Teleporter */
	Float:ac__TpPosX[MAX_PLAYERS],
	Float:ac__TpPosY[MAX_PLAYERS],
	Float:ac__TpPosZ[MAX_PLAYERS],
	bool:ac__TeleportFreshly[MAX_PLAYERS],
	ac__TeleportWarns[MAX_PLAYERS],

	/** VW/interior */
	ac__PlayerInt[MAX_PLAYERS],
	ac__PlayerVW[MAX_PLAYERS],

	/** Health/armour cheatai */
	Float:ac__VehicleHealth[MAX_VEHICLES],
	Float:ac__PlayerHealth[MAX_PLAYERS],
	Float:ac__PlayerArmour[MAX_PLAYERS],
	Float:ac__IgnoreAfkArmour[MAX_PLAYERS],
	Float:ac__IgnoreAfkHealth[MAX_PLAYERS],
	Float:ac__LastHit[MAX_PLAYERS],

	ac__TakenShots[MAX_PLAYERS],
	ac__RespondShots[MAX_PLAYERS],
	ac__LastAFKTick[MAX_PLAYERS],
	ac__PlayerControllable[MAX_PLAYERS];

static const
	ac__TopSpeeds[212] = {
				157, 147, 186, 110, 133, 164, 110, 148, 100, 158, 129, 221, 168, 110, 105, 192, 154, 270,
   				115, 149, 145, 154, 140, 99, 135, 270, 173, 165, 157, 201, 190, 130, 94, 110, 167, 0, 149,
   				158, 142, 168, 136, 145, 139, 126, 110, 164, 270, 270, 111, 0, 0, 193, 270, 60, 135, 157,
   				106, 95, 157, 136, 270, 160, 111, 142, 145, 145, 147, 140, 144, 270, 157, 110, 190, 190,
   				149, 173, 270, 186, 117, 140, 184, 73, 156, 122, 190, 99, 64, 270, 270, 139, 157, 149, 140,
   				270, 214, 176, 162, 270, 108, 123, 140, 145, 216, 216, 173, 140, 179, 166, 108, 79, 101, 270,
   				270, 270, 120, 142, 157, 157, 164, 270, 270, 160, 176, 151, 130, 160, 158, 149, 176, 149, 60,
   				70, 110, 167, 168, 158, 173, 0, 0, 270, 149, 203, 164, 151, 150, 147, 149, 142, 270, 153, 145,
   				157, 121, 270, 144, 158, 113, 113, 156, 178, 169, 154, 178, 270, 145, 165, 160, 173, 146, 0, 0,
   				93, 60, 110, 60, 158, 158, 270, 130, 158, 153, 151, 136, 85, 0, 153, 142, 165, 108, 162, 0, 0,
   				270, 270, 130, 190, 175, 175, 175, 158, 151, 110, 169, 171, 148, 152, 0, 0, 0, 108, 0
};
stock FAC_GetModelMaxSpeed(model)
{
	if(400 <= model <= 611) return ac__TopSpeeds[model-400];
	return 0;
}

static _FAC_CheatDetected(playerid, code, extra_id_1 = 0, extra_id_2 = 0)
{
	if(funcidx("OnPlayerCheat") != -1)
		CallLocalFunction("OnPlayerCheat", "dddd", playerid, code, extra_id_1, extra_id_2);
	return 1;
}

#if defined _INC_y_hooks
	hook OnGameModeInit()
#else 
	public OnGameModeInit()
#endif
{
	/* 
		Timeriai yra (repeat = false), taip isitikinsim, kad padarem viska ka reikejo ir naujas timeris neveiktu, kol nesibaige sitas. 
	*/
	#if AC_ENABLE_WEAPONS
		SetTimer("t_ac__WeaponsTimer", AC_WEAPONS_TIME, false);
	#endif

	#if AC_ENABLE_MONEY
		SetTimer("t_ac__MoneyTimer", AC_MONEY_TIME, false);
	#endif

	#if AC_ENABLE_AIRBREAK
		SetTimer("t_ac__AirBreak", AC_AIRBREAK_TIME, false);
	#endif

	#if AC_ENABLE_HEALTH
		SetTimer("t_ac__Health", AC_HEALTH_TIME, false);
	#endif

	#if AC_ENABLE_SPEED
		SetTimer("t_ac__Speed", AC_SPEED_TIME, false);
	#endif

	#if AC_ENABLE_TELEPORTER
		SetTimer("t_ac__Teleporter", AC_TELEPORTER_TIME, false);
	#endif
	SetTimer("t_ac__Misc", AC_MISC_TIME, false);


	printf("f0cus anticheat initialized. Version: "#AC_FULL_VERSION);

	#if !defined _INC_y_hooks
		#if defined FAC_OnGameModeInit
			return FAC_OnGameModeInit();
		#else
			return 1;
		#endif
	#else 	
		return 1;
	#endif
}
#if defined _INC_y_hooks
	hook OnPlayerConnect(playerid)
#else 
	public OnPlayerConnect(playerid)
#endif
{
	#if AC_ENABLE_FLOOD
		new now = gettime();
		static 
			joinIndex,
			joinArray[19];
		GetPlayerIp(playerid, joinArray, sizeof joinArray);

		ac__Joins[joinIndex][e_ac_JoinIP] = joinArray[0] = FAC_IpToInt(joinArray);
		ac__Joins[joinIndex][e_ac_JoinTimeStamp] = now;

		joinIndex = ++joinIndex % 30;
		joinArray[1] = joinArray[2] = 0;

		for(new i = 0; i < 29; i++)
		{
			if(ac__Joins[i][e_ac_JoinIP] != joinArray[0]) { continue; }
			joinArray[3] = now;

			if(floatround(floatabs(joinArray[3] - ac__Joins[joinIndex][e_ac_JoinTimeStamp])) < 3)
			{
				if(floatround(floatabs(joinArray[3] - ac__Joins[i + 1][e_ac_JoinTimeStamp])) < 3)
				{
					joinArray[1] ++; // count
					joinArray[2] += floatround(floatabs(ac__Joins[i][e_ac_JoinTimeStamp] - ac__Joins[i + 1][e_ac_JoinTimeStamp])); // time
				}
			}
		}
		if(joinArray[1] > 3 && joinArray[2] < 3) BanEx(playerid, "IP_Flood");
	#endif
	#if AC_ENABLE_NPC
		if(IsPlayerNPC(playerid))
		{
			new IP_NPC[64+1],
				IP_Server[64+1];
		    GetServerVarAsString("bind", IP_Server, 64);
		    GetPlayerIp(playerid, IP_NPC, 64);
			if(!strlen(IP_Server)) format(IP_Server, 10, "127.0.0.1"); // localhost
			if(strcmp(IP_NPC, IP_Server, true) != 0)
			{
				// remote botas
				GetPlayerName(playerid, IP_Server, 32);
				printf("NPC TRIED CONNECTION: %s\nIP: %s", IP_Server, IP_NPC);
			    Kick(playerid);
				
				format(IP_Server, sizeof IP_Server, "banip %s", IP_NPC);
        		SendRconCommand(IP_Server);
			    return 0;
			}
		}
	#endif
	
	FAC_Reset(playerid);
	FAC_ResetPlayerMoney(playerid);

	#if !defined _INC_y_hooks
		#if defined FAC_OnPlayerConnect
			return FAC_OnPlayerConnect(playerid);
		#else 
			return 1;
		#endif
	#else 
		return 1;
	#endif
}



#if defined _INC_y_hooks
	hook OnPlayerDisconnect(playerid, reason)
#else
	public OnPlayerDisconnect(playerid, reason)
#endif
{
	FAC_Reset(playerid);
	
	#if !defined _INC_y_hooks
		#if defined FAC_OnPlayerDisconnect
			return FAC_OnPlayerDisconnect(playerid, reason);
		#else 
			return 1;
		#endif
	#else 
		return 1;
	#endif 
}

stock FAC_SpawnPlayer(playerid)
{
	ac__ReturnState[playerid] = true;
	ac__IgnoreAfkHealth[playerid] = 
	ac__PlayerHealth[playerid] = 100.0;
	ac__AirBreak[playerid][e_ac_AirBrkImmune] = gettime() + 4;
	return SpawnPlayer(playerid);
}

stock FAC_GetAnticheatVersion()
{
	new string[25];
	format(string, sizeof string, AC_FULL_VERSION);
	return string;
}

stock FAC_Reset(playerid)
{
	FAC_ResetPlayerWeapons(playerid);

	new 
		reset__AirBreak[E_AC_AIRBREAK];

	ac__TakenShots[playerid] = ac__RespondShots[playerid] = 0;
	ac__PlayerControllable[playerid] = false;
	ac__AirBreak[playerid] = reset__AirBreak;
	ac__IgnoreWeapons[playerid] =
	ac__LastDeath[playerid] =
	ac__InvWarnings[playerid] = 
	ac__DeathSpam[playerid] = 0;
	ac__PlayerArmour[playerid] = 
	ac__IgnoreAfkArmour[playerid] =
	ac__LastHit[playerid] = 0.0;

	ac__TpPosX[playerid] = ac__TpPosY[playerid] = ac__TpPosZ[playerid] = 0.0;
	ac__TeleportFreshly[playerid] = false;
	ac__TeleportWarns[playerid] = 0;

	ac__Dialog[playerid] = 
	ac__InnerHighPingWarnings[playerid] = 
	ac__HighPingWarnings[playerid] = 0;

	ac__UsingJetpack[playerid] = 
	ac__JetpackGiven[playerid] = 
	ac__Spawned[playerid] = false;

	ac__LastShot[playerid] = 
	ac__ShotCount[playerid] = 0;

	ac__CurrentVehicle[playerid] = 
	ac__LastVehicle[playerid] = 
	ac__EnteringVehicle[playerid] = FAC_INVALID_VEHICLE_ID;

	ac__PlayerHealth[playerid] = 100.0;
	ac__IgnoreAfkHealth[playerid] = 999.0;
	ac__ReturnState[playerid] = true;

	ac__Aim_PlayerSettings{playerid} = (AC_AFLAG_CHK_CONTINOUS_SHOTS | AC_AFLAG_CHK_PROAIM_TELEPORT | AC_AFLAG_CHK_RANDOM_SHOTS | AC_AFLAG_CHK_OOF_SHOTS);
	ac__Aim_InternalSettings{playerid} =
	ac__Aim_ContiniousShots{playerid} =
	ac__Aim_RandomShots{playerid} =
	ac__Aim_TeleportShots{playerid} =
	ac__Aim_OutOfRangeShots{playerid} = 0;
	return 1;
}

#if defined _INC_y_hooks
	hook OnPlayerPickUpDynPickup(playerid, STREAMER_TAG_PICKUP pickupid)
#else 
	public OnPlayerPickUpDynamicPickup(playerid, STREAMER_TAG_PICKUP pickupid)
#endif
{
	new 
		Float:__pick_x, Float:__pick_y, Float:__pick_z;
	
	#if AC_ENABLE_PICKUP_TELEPORT
		Streamer_GetFloatData(STREAMER_TYPE_PICKUP, pickupid, E_STREAMER_X, __pick_x);
		Streamer_GetFloatData(STREAMER_TYPE_PICKUP, pickupid, E_STREAMER_Y, __pick_y);
		Streamer_GetFloatData(STREAMER_TYPE_PICKUP, pickupid, E_STREAMER_Z, __pick_z);	
		
		if(!IsPlayerInRangeOfPoint(playerid, 3.0, __pick_x, __pick_y, __pick_z))
		{
			_FAC_CheatDetected(playerid, CHEAT_PICKUP_TP, pickupid);
			#if defined _INC_y_hooks
				return Y_HOOKS_BREAK_RETURN_0; 
			#else 
				return 0;
			#endif
		}
	#endif

	#if !defined _INC_y_hooks
		#if defined FAC_OnPlayerPickUpDynamicPickup
			return FAC_OnPlayerPickUpDynamicPickup(playerid, pickupid);
		#else
			return 1;
		#endif
	#else 
		return 1;
	#endif 
}

#if defined _INC_y_hooks
	hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
#else 
	public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
#endif
{
	#if AC_ENABLE_DIALOGS
		if(ac__Dialog[playerid] != dialogid)
		{
			_FAC_CheatDetected(playerid, CHEAT_DIALOG_CHEAT, dialogid);
			return 1;
		}
		else ac__Dialog[playerid] = 0;
	#endif

	#if !defined _INC_y_hooks
		#if defined FAC_OnDialogResponse
			return FAC_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
		#else
			return 0;
		#endif
	#else 
		return 0;
	#endif 
}

stock FAC_ShowPlayerDialog(playerid, dialogid, style, caption[], info[], button1[], button2[])
{
	ac__Dialog[playerid] = dialogid;
	return ShowPlayerDialog(playerid, dialogid, style, caption, info, button1, button2);
}

forward t_ac__Teleporter();
public t_ac__Teleporter()
{

	#if AC_ENABLE_TELEPORTER
		new now = gettime(),
			Float:dist = 0.0;
		AC_playerloop(playerid)
		{
			if(	now > ac__AirBreak[playerid][e_ac_AirBrkImmune] &&
				!IsPlayerAFK(playerid) &&
				_FAC_IsPlayerStatePlaying(playerid) &&
				(
					(
						!IsPlayerInAnyVehicle(playerid) && 
						!_FAC_IsPlayerLeavingCar(playerid) &&
						!_FAC_IsPlayerSurfing(playerid) &&
						(dist = GetPlayerDistanceFromPoint(playerid,	
								ac__TpPosX[playerid],
								ac__TpPosY[playerid],
								ac__TpPosZ[playerid])) >= AC_TELEPORT_DISTANCE_ON_FOOT
					)
					||
					(
						GetPlayerState(playerid) == PLAYER_STATE_DRIVER &&
						(dist = GetPlayerDistanceFromPoint(playerid,	
								ac__TpPosX[playerid],
								ac__TpPosY[playerid],
								ac__TpPosZ[playerid])) >= AC_TELEPORT_DISTANCE_IN_CAR
					)
					|| 
					(
						(dist = GetPlayerDistanceFromPoint(playerid,
								ac__TpPosX[playerid],
								ac__TpPosY[playerid],
								ac__TpPosZ[playerid])) >= AC_TELEPORT_DISTANCE_INSTA_KICK
					)
				)
			)
			{
				if(IsPlayerInAnyVehicle(playerid))
				{
					new Float:unused_f, Float:vel_z;
					GetVehicleVelocity(GetPlayerVehicleID(playerid), unused_f, unused_f, vel_z);
					if(	(vel_z <= -0.4 && dist < AC_TELEPORT_DISTANCE_INSTA_KICK)
						||
						(vel_z <= -0.8 && dist < AC_TELEPORT_DISTANCE_INSTA_KICK * 2.25)
						||
						(vel_z <= -1.2 && dist < AC_TELEPORT_DISTANCE_INSTA_KICK * 3.5)
						||
						(vel_z <= -2.0 && dist < AC_TELEPORT_DISTANCE_INSTA_KICK * 5.5)) continue;
				}

				ac__TeleportFreshly[playerid] = true;
				if(	(ac__TeleportWarns[playerid]++) >= AC_TELEPORT_WARNINGS || 
					(dist >= AC_TELEPORT_DISTANCE_INSTA_KICK) )
				{
					_FAC_CheatDetected(playerid, CHEAT_TELEPORTER, ac__AirBreak[playerid][e_ac_AirBrkImmune], floatround(dist));
				}
			}
			GetPlayerPos(playerid, ac__TpPosX[playerid], ac__TpPosY[playerid], ac__TpPosZ[playerid]);
		}
	#endif

	SetTimer("t_ac__Teleporter", AC_TELEPORTER_TIME, false);
	return 1;
}

static _FAC_IsPlayerStateVehicle(playerid)
{
	return (GetPlayerState(playerid) == PLAYER_STATE_DRIVER ||
			GetPlayerState(playerid) == PLAYER_STATE_PASSENGER);
}
static _FAC_IsPlayerLeavingCar(playerid)
{
	return (GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_ENTER_VEHICLE ||	
			GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_EXIT_VEHICLE);
}
static _FAC_IsPlayerSurfing(playerid)
{
	return (GetPlayerSurfingObjectID(playerid) != FAC_INVALID_OBJECT_ID ||
			GetPlayerSurfingVehicleID(playerid) != FAC_INVALID_VEHICLE_ID);
}

static _FAC_IsPlayerStatePlaying(playerid)
{
	switch(GetPlayerState(playerid))
	{
		case PLAYER_STATE_SPAWNED, PLAYER_STATE_DRIVER, PLAYER_STATE_ONFOOT, PLAYER_STATE_PASSENGER:
			return true;
	}
	return false;
}


forward t_ac__Misc();
public t_ac__Misc()
{
	#if AC_ENABLE_JETPACK
		AC_playerloop(playerid)
		{
			if(!ac__UsingJetpack[playerid] && GetPlayerSpecialAction(playerid) == 2)
			{
				if(!ac__JetpackGiven[playerid]) 
				{
					SetPlayerSpecialAction(playerid, 0);
					
					_FAC_CheatDetected(playerid, CHEAT_JETPACK);
				}
				else
				{
					ac__UsingJetpack[playerid] = true;
				}
			}
			else if(ac__UsingJetpack[playerid] && GetPlayerSpecialAction(playerid) != 2) 
			{
				ac__UsingJetpack[playerid] = false;
			}

			#if AC_ENABLE_CAR_CHANGER
				if(FAC_GetTickDiff(GetTickCount(), ac__VehicleChangeTime[playerid]) >= 2000) {
					ac__CarChangerWarns[playerid] = 0;
				}
			#endif
		}	
	#endif
	#if AC_ENABLE_VW_INT
		AC_playerloop(playerid)
		{
			if(	GetPlayerVirtualWorld(playerid) != ac__PlayerVW[playerid] ||
				GetPlayerInterior(playerid) 	!= ac__PlayerInt[playerid])
			{
				_FAC_CheatDetected(playerid, CHEAT_VW_INT, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
			}

		}
	#endif
	#if AC_ENABLE_TELEPORTER
		AC_playerloop(playerid)
		{
			if(ac__TeleportWarns[playerid] > 0)
			{
				if(ac__TeleportFreshly[playerid]) ac__TeleportFreshly[playerid] = false;
				else 
				{
					ac__TeleportWarns[playerid]--;
				}
			}
		}
	#endif
	AC_playerloop(playerid)
	{
		new 
			ping = GetPlayerPing(playerid);
		if(ping >= AC_HIGH_PING_MARK || ping >= 65535)
		{
			ac__InnerHighPingWarnings[playerid] ++ ;
			if(ac__InnerHighPingWarnings[playerid] >= 5)
			{			
				ac__InnerHighPingWarnings[playerid] = 0;
				ac__HighPingWarnings[playerid] ++ ;

				_FAC_CheatDetected(playerid, CHEAT_HIGH_PING, ping, ac__HighPingWarnings[playerid]);
			}
		}
	}

	SetTimer("t_ac__Misc", AC_MISC_TIME, false);
	return 1;
}

stock FAC_SetPlayerSpecialAction(playerid, action)
{
	if(action == 2)	ac__JetpackGiven[playerid] = true;
	else if(action != 2) ac__JetpackGiven[playerid] = false;

	ac__SpecialAction[playerid] = action;
	return SetPlayerSpecialAction(playerid, action);
}


#if defined _INC_y_hooks
	hook OnUncpVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z)
#else
	public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z)
#endif
{
	// printf("%s -> UNNOCUPPIED: %d, %d, [POS:%0.1f, %0.1f, %0.1f, VEL:%0.1f, %0.1f, %0.1f]", GetPlayerNameEx(playerid), vehicleid, passenger_seat, new_x, new_y, new_z, vel_x, vel_y, vel_z);	

	#if AC_ENABLE_TROLLBOSS
		if(	(!vel_x && !vel_y && vel_z == 400.000000) ||
			(new_x != new_x || new_y != new_y || new_z != new_z)
		)
		{	
			_FAC_CheatDetected(playerid, CHEAT_TROLLBOSS);
			return 0;
		}
	#endif
	#if !defined _INC_y_hooks
		#if defined FAC_OnUnoccupiedVehicleUpdate
			return FAC_OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, new_x, new_y, new_z, vel_x, vel_y, vel_z);
		#else
			return 1;
		#endif
	#else 
		return 1;
	#endif
}

#if defined _INC_y_hooks
	hook OnVehicleSpawn(vehicleid)
#else 
	public OnVehicleSpawn(vehicleid)
#endif
{
	ac__VehicleHealth[vehicleid] = 1000.0;
	#if !defined _INC_y_hooks
		#if defined FAC_OnVehicleSpawn
			return FAC_OnVehicleSpawn(vehicleid);
		#else 
			return 1;
		#endif
	#else 
		return 1;
	#endif
}

#if defined _INC_y_hooks
	hook OnVehicleDeath(vehicleid, killerid)
#else 
	public OnVehicleDeath(vehicleid, killerid)
#endif
{
	#if !defined _INC_y_hooks
		#if defined FAC_OnVehicleDeath
			return FAC_OnVehicleDeath(vehicleid, killerid);
		#else
			return 1;
		#endif
	#else 
		return 1;
	#endif
}

#if defined _INC_y_hooks
	hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
#else 
	public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
#endif
{
	new unused, doors;
	GetVehicleParamsEx(vehicleid, unused, unused, unused, doors, unused, unused, unused);
	// printf("%s -> ENTER_VEHICLE(%d, %d, doors: %d)", GetPlayerNameEx(playerid), vehicleid, ispassenger, doors);

	if(doors == 1)
	{
		/** SAMP BUG: G teleportuoja i vidu masinos, kai ji nutolsta, net jei uzrakinta. */
		FAC_CancelVehicleEnter(playerid);
	}
	else ac__EnteringVehicle[playerid] = vehicleid;

	#if AC_ENABLE_WEAPONS
		FAC_IsModelPlane(GetVehicleModel(vehicleid)) && FAC_GivePlayerWeapon(playerid, WEAPON_PARACHUTE, 1);
	#endif

	#if !defined _INC_y_hooks
		#if defined FAC_OnPlayerEnterVehicle
			return FAC_OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);
		#else 
			return 1;
		#endif
	#else 
		return 1;
	#endif 	
}

stock FAC_IsModelPlane(model)
{ 
	switch(model)
	{
		case 	487, 488, 469, 497, 460, 476, 511, 512, 
				513, 519, 520, 553, 577, 592, 593: return true;
	}
	return false;
}

forward t_ac__Speed();
public t_ac__Speed()
{
	AC_vehicleloop(vehicleid)
	{
		if(!IsValidVehicle(vehicleid)) continue;
		new 
			speed = FAC_VehicleSpeed(vehicleid),
			model,
			Float:unused_f, Float:vel_z;
		if(400 <= (model = GetVehicleModel(vehicleid)) <= 611)
		{
			new 
				topspeed = ac__TopSpeeds[model-400];
			GetVehicleVelocity(vehicleid, unused_f, unused_f, vel_z);

			#if defined Vehicle_GetMaxSpeedBoost
				new boost = Vehicle_GetMaxSpeedBoost(vehicleid);
				if(boost > topspeed) topspeed = boost;
			#endif

			if(topspeed + 25 >= 260 || vel_z <= -0.4) { /*printf("t_ac__Speed():  Vehicle[%d] top_speed >= 250, skip", vehicleid);*/ continue; }
			else if((speed > topspeed + 20 || speed > topspeed * 2) && topspeed > 0)
			{
				AC_playerloop(playerid)
				{
					// printf("t_ac__Speed():  Vehicle[%d] speed cheat detected", vehicleid);
					if(	IsPlayerInVehicle(playerid, vehicleid) && 
						GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
					{
						// printf("t_ac__Speed():  Vehicle[%d] calling master", vehicleid);
						_FAC_CheatDetected(playerid, CHEAT_VEH_SPEED, vehicleid);
					}
				}
			}
		}
	}
	SetTimer("t_ac__Speed", AC_SPEED_TIME, false);
	return 1;
}

forward t_ac__Health();
public t_ac__Health()
{
	AC_playerloop(playerid)
	{
		if(!IsPlayerConnected(playerid) || !ac__Spawned[playerid]) continue;
		if(!IsPlayerAFK(playerid))
		{
			FAC_CheckPlayerHealth(playerid);
		}
	}
	AC_vehicleloop(vehicleid)
	{
		if(!IsValidVehicle(vehicleid)) continue;
		FAC_CheckVehicleHealth(vehicleid);
	}
	SetTimer("t_ac__Health", AC_HEALTH_TIME, false);
	return 1;
}

#if defined _INC_y_hooks
	hook OnPlayerText(playerid, text[])
#else 
	public OnPlayerText(playerid, text[])
#endif
{
	ac__LastAFKTick[playerid] = GetTickCount();
	#if !defined _INC_y_hooks
		#if defined FAC_OnPlayerText
			return FAC_OnPlayerText(playerid, text);
		#else 
			return 1;
		#endif
	#else 
		return 1;
	#endif
}
#if defined _INC_y_hooks
	hook OnPlayerCommandText(playerid, cmdtext[])
#else 
	public OnPlayerCommandText(playerid, cmdtext[])
#endif
{
	ac__LastAFKTick[playerid] = GetTickCount();
	// #if !defined _INC_y_hooks
	// 	#if defined FAC_OnPlayerCommandText
	// 		return FAC_OnPlayerCommandText(playerid, cmdtext);
	// 	#else 
	// 		return 1;
	// 	#endif
	// #else 
	// 	return 1;
	// #endif
}

#if defined _INC_y_hooks
	hook OnPlayerUpdate(playerid)
#else 
	public OnPlayerUpdate(playerid)
#endif
{
	new 
		tick = GetTickCount();

	ac__LastAFKTick[playerid] = tick;

	new current_vehicle = GetPlayerVehicleID(playerid);
	if(	current_vehicle != 0 &&
		current_vehicle != ac__CurrentVehicle[playerid])
	{
		// pasikeite masina
		// printf("%s -> CHANGE_VEHICLE: %d, %d", GetPlayerNameEx(playerid), current_vehicle, ac__CurrentVehicle[playerid]);

		#if AC_ENABLE_CAR_CHANGER
			if(FAC_GetTickDiff(tick, ac__VehicleChangeTime[playerid]) <= 400)
			{
				/** Labai greitai keicia transporta. */
				if((ac__CarChangerWarns[playerid]++) >= AC_CAR_CHANGER_MAX_WARNS)
				{
					_FAC_CheatDetected(playerid, CHEAT_CAR_CHANGER);
				}
			}
		#endif
		#if AC_ENABLE_WARP_INTO_CAR
			if(	ac__LastVehicle[playerid] != current_vehicle && 
				ac__LastVehicle[playerid] != FAC_INVALID_VEHICLE_ID)
			{
				// Warp into car is kitos transporto priemones.
				_FAC_CheatDetected(playerid, CHEAT_WARP_TO_CAR, current_vehicle);
			}
		#endif
		/**/
		ac__CurrentVehicle[playerid]	= current_vehicle;
		ac__VehicleChangeTime[playerid] = tick;


	}

	#if AC_ENABLE_GOGGLES_FIX
		switch(GetPlayerWeapon(playerid))
		{
			case 44, 45:
			{
				new keys, unused;
				GetPlayerKeys(playerid, keys, unused, unused);
				if((keys & KEY_FIRE) && !IsPlayerInAnyVehicle(playerid)) return 0;
			}
		}
	#endif

	#if !defined _INC_y_hooks
		#if defined FAC_OnPlayerUpdate
			FAC_OnPlayerUpdate(playerid);
			return 1;
		#else 
			return 1;
		#endif
	#else 
		return 1;
	#endif
}

#if defined _INC_y_hooks
	hook OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
#else	
	public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
#endif
{
	if(IsPlayerControllable(playerid) && !IsPlayerAFK(playerid))
	{
		ac__RespondShots[playerid] ++ ;
	}
	else ac__RespondShots[playerid] = ac__TakenShots[playerid] = 0;

	#if !defined _INC_y_hooks
		#if defined FAC_OnPlayerTakeDamage
			return FAC_OnPlayerTakeDamage(playerid, issuerid, amount, weaponid, bodypart);
		#else 
			return 1;
		#endif
	#else 
		return 1;
	#endif
}



#if defined _INC_y_hooks
	hook OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid)
#else
	public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid)
#endif
{
	#if AC_ENABLE_INV
		if(!IsPlayerAFK(playerid) && !IsPlayerAFK(damagedid) && weaponid != WEAPON_UZI)
		{
			new 
				Float:health,
				Float:armour,
				Float:points;

			GetPlayerHealth(damagedid, health);
			GetPlayerArmour(damagedid, armour);
			points = health + armour;
	
			if(ac__LastHit[damagedid] < points) ac__InvWarnings[damagedid] ++ ;
			else ac__InvWarnings[damagedid] = 0;
	
			if(ac__InvWarnings[damagedid] > AC_INV_MAX_WARNINGS)
			{
				_FAC_CheatDetected(damagedid, CHEAT_GODMODE);
			}
			ac__LastHit[damagedid] = points - amount;
		}
	#endif

	#if !defined _INC_y_hooks
		#if defined FAC_OnPlayerGiveDamage
			return FAC_OnPlayerGiveDamage(playerid, damagedid, amount, weaponid);
		#else 
			return 1;
		#endif
	#else 
		return 1;
	#endif
}

// forward OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ);
/*#if defined _INC_y_hooks
	hook OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
#else
	public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
#endif
{
	if(!(21 < weaponid < 39))
	{
		return 0;
	}

	#if AC_ENABLE_INV
		if(	IsPlayerConnected(playerid) && hittype == BULLET_HIT_TYPE_PLAYER &&
			IsPlayerConnected(hitid)	&& !IsPlayerNPC(hitid))
		{
			if(IsPlayerControllable(hitid) && !IsPlayerAFK(hitid))
			{
				// ac__TakenShots[hitid] ++ ;
				// if(ac__TakenShots[hitid] - ac__RespondShots[hitid] > AC_INV_MAX_WARNINGS)
				// {
				//	_FAC_CheatDetected(hitid, CHEAT_GODMODE);
				// }
			}
		}
	#endif

	#if AC_ENABLE_RAPIDFIRE
		if(!IsPlayerAFK(playerid))
		{
			if(weaponid != 38)
			{
				new 
					max_count,
					max_allowed_diff,

					tick = GetTickCount(),
					diff = FAC_GetTickDiff(tick, ac__LastShot[playerid]);
				
				switch(weaponid)
				{
					case 22: max_allowed_diff = 180;
					case 23: max_allowed_diff = 350;
					case 24: max_allowed_diff = 170;
					case 25: max_allowed_diff = 750;
					case 26: max_allowed_diff = 130;
					case 27: max_allowed_diff = 300;
					case 28: max_allowed_diff = 40;
					case 29: max_allowed_diff = 85;
					case 30, 31: max_allowed_diff = 100;
					case 32: max_allowed_diff = 45;
					case 33: max_allowed_diff = 950;
					case 34: max_allowed_diff = 950;
				}

				switch(weaponid)
				{
					case 28, 32: max_count = 16;
					default: max_count = 10;
				}

				if(diff <= max_allowed_diff) ac__ShotCount[playerid]++;
				else ac__ShotCount[playerid] = 0;

				if(ac__ShotCount[playerid] > max_count)
				{
					_FAC_CheatDetected(playerid, CHEAT_RAPID_FIRE);
				}
				ac__LastShot[playerid] = tick;
			}
		}
	#endif
	#if AC_ENABLE_AIMBOT
	    if(!(4 <= hittype < 4))
	    {
			#if !defined _INC_y_hooks
				#if defined FAC_OnPlayerWeaponShot
					FAC_OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, fX, fY, fZ);
					return 1;
				#else 
					return 1;
				#endif
			#else 
				return 1;
			#endif
			// ((funcidx("FAC_OnPlayerWeaponShot") != -1) && CallLocalFunction("FAC_OnPlayerWeaponShot", "ddddfff", playerid, weaponid, hittype, hitid, fX, fY, fZ));
			// return 1;
	    }
	    static Float:pX,Float:pY,Float:pZ,Float:hX,Float:hY,Float:hZ,Float:cX,Float:cY,Float:cZ;
	    if(hittype == BULLET_HIT_TYPE_NONE)
	    {
	    	if(floatabs(fX) > 20000.0 || floatabs(fY) > 20000.0 || floatabs(fZ) > 20000.0)
	    	{
				#if !defined _INC_y_hooks
					#if defined FAC_OnPlayerWeaponShot
						FAC_OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, fX, fY, fZ);
						return 1;
					#else 
						return 1;
					#endif
				#else 
					return 1;
				#endif
				// return ((funcidx("FAC_OnPlayerWeaponShot") != -1) && CallLocalFunction("FAC_OnPlayerWeaponShot", "ddddfff", playerid, weaponid, hittype, hitid, fX, fY, fZ));
	    	}
	    } 
	    else
	    {
	        if(floatabs(fX) > 1500.0 || floatabs(fY) > 1500.0 || floatabs(fZ) > 1500.0)
	    	{
				#if !defined _INC_y_hooks
					#if defined FAC_OnPlayerWeaponShot
						FAC_OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, fX, fY, fZ);
						return 1;
					#else 
						return 1;
					#endif
				#else 
					return 1;
				#endif
	            // return ((funcidx("FAC_OnPlayerWeaponShot") != -1) && CallLocalFunction("FAC_OnPlayerWeaponShot", "ddddfff", playerid, weaponid, hittype, hitid, fX, fY, fZ));
	        }
	    }
	   	if(hittype == BULLET_HIT_TYPE_PLAYER)
	    {
			if(ac__Aim_PlayerSettings{playerid} & IGNORE_PLAYER)
			{
				#if !defined _INC_y_hooks
					#if defined FAC_OnPlayerWeaponShot
						FAC_OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, fX, fY, fZ);
						return 1;
					#else 
						return 1;
					#endif
				#else 
					return 1;
				#endif
	        	// return ((funcidx("FAC_OnPlayerWeaponShot") != -1) && CallLocalFunction("FAC_OnPlayerWeaponShot", "ddddfff", playerid, weaponid, hittype, hitid, fX, fY, fZ));
			}

			if(ac__Aim_LastWeapon{playerid} != weaponid)
			{
			    ac__Aim_ContiniousShots{playerid} =
				ac__Aim_RandomShots{playerid} =
				ac__Aim_TeleportShots{playerid} =
				ac__Aim_OutOfRangeShots{playerid} = 0;
			    ac__Aim_LastWeapon{playerid} = weaponid;
			}

	        if(IsPlayerNPC(hitid) || 
	        	NetStats_PacketLossPercent(playerid) > AC_AIM_MAX_PACKET_LOSS ||
				NetStats_PacketLossPercent(hitid) > AC_AIM_MAX_PACKET_LOSS || 
	        	GetPlayerPing(playerid) > AC_AIM_MAX_PING ||
				GetPlayerPing(hitid) > AC_AIM_MAX_PING || 
	        	IsPlayerInAnyVehicle(playerid) ||
				IsPlayerInAnyVehicle(hitid) ||
				_FAC_IsPlayerSurfing(playerid) ||
				_FAC_IsPlayerSurfing(hitid) ||
				weaponid == 38)
			{
				#if !defined _INC_y_hooks
					#if defined FAC_OnPlayerWeaponShot
						FAC_OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, fX, fY, fZ);
						return 1;
					#else 
						return 1;
					#endif
				#else 
					return 1;
				#endif
				// return ((funcidx("FAC_OnPlayerWeaponShot") != -1) && CallLocalFunction("FAC_OnPlayerWeaponShot", "ddddfff", playerid, weaponid, hittype, hitid, fX, fY, fZ));
			}
			
	        new warning = 0;

		    GetPlayerVelocity(hitid,pX,pY,pZ);

		    if(ac__Aim_PlayerSettings{playerid} & AC_AFLAG_CHK_CONTINOUS_SHOTS)
			    if((pX*pX + pY*pY + pZ*pZ) > 0.01)
			        if(!(++ac__Aim_ContiniousShots{playerid} % AC_AIM_MAX_CONTINIOUS_SHOT_PRB))
						warning |= WARNING_CONTINOUS_SHOTS;

			GetPlayerPos(hitid,hX,hY,hZ);
			GetPlayerLastShotVectors(playerid,pX,pY,pZ,cX,cY,cZ);

			new Float:S2V_dist = VectorSize(pX-hX,pY-hY,pZ-hZ); //Approximate Shooter to Victim Distance

			if(ac__Aim_PlayerSettings{playerid} & AC_AFLAG_CHK_OOF_SHOTS)
			{
				if(S2V_dist > BustAim_g_WeaponRange[weaponid-22])
				{
					
					if(ac__Aim_InternalSettings{playerid} & PREVIOUS_SHOT_DID_DAMAGE)
					{
						if(++ac__Aim_OutOfRangeShots{playerid} > AC_AIM_MAX_OOF_SHOTS_PRB)
						{
							ac__Aim_OutOfRangeShots{playerid} = 0;
							
							warning |= WARNING_OUT_OF_RANGE_SHOT;
						}
						ac__Aim_InternalSettings{playerid} &= ~PREVIOUS_SHOT_DID_DAMAGE;
					}
				}
			}

	        if(ac__Aim_PlayerSettings{playerid} & AC_AFLAG_CHK_PROAIM_TELEPORT)
				if(VectorSize(cX-hX,cY-hY,cZ-hZ) > 15)
				{
					
				    if(++ac__Aim_TeleportShots{playerid} > AC_AIM_MAX_TELEPORT_SHOT_PRB)
					{
					    ac__Aim_TeleportShots{playerid} = 0;
					    
						warning |= WARNING_PROAIM_TELEPORT;
					}
				}

			

	        if(ac__Aim_PlayerSettings{playerid} & AC_AFLAG_CHK_RANDOM_SHOTS)
				if(S2V_dist > AC_MIN_DIST_FOR_AIM_CHECKS)
				{
				    GetPlayerCameraFrontVector(playerid,pX,pY,pZ);
					GetPlayerCameraPos(playerid,cX,cY,cZ);
					if(!FAC_aimInt_IsCameraAimingAt(weaponid,hX,hY,hZ,pX,pY,pZ,cX,cY,cZ,AC_AIM_SPHERE_RADIUS))
					{
					    
		                if(++ac__Aim_RandomShots{playerid} > AC_AIM_MAX_RANDOM_SHOT_PRBG)
		                {
		                    ac__Aim_RandomShots{playerid} = 0;
							warning |= WARNING_RANDOM_AIM;
		                }
					}
				}
			if(warning)
			{
				_FAC_CheatDetected(playerid, CHEAT_AIMBOT);
			}
		}
		else
		{
		    
		    ac__Aim_ContiniousShots{playerid} =
			ac__Aim_RandomShots{playerid} =
			ac__Aim_TeleportShots{playerid} =
			ac__Aim_OutOfRangeShots{playerid} = 0;
		}
	#endif
	#if !defined _INC_y_hooks
		#if defined FAC_OnPlayerWeaponShot
			FAC_OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, fX, fY, fZ);
			return 1;
		#else
			return 1;
		#endif
	#else 
		return 1;
	#endif
}
*/

#if defined _INC_y_hooks
	hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
#else 
	public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
#endif
{
	#if AC_ENABLE_PARACHUTE_DAMAGE
		if(	(newkeys & KEY_SECONDARY_ATTACK) || (newkeys & KEY_FIRE) && 
			GetPlayerWeapon(playerid) == WEAPON_PARACHUTE && 
			!IsPlayerInAnyVehicle(playerid))
		{
			AC_vehicleloop(vehicleid)
			{
				new Float:x,Float:y,Float:z;
				GetVehiclePos(vehicleid, x, y, z);
				if(IsPlayerInRangeOfPoint(playerid, 7.0, x, y, z))
				{
					RemovePlayerWeaponInSlot(playerid, 11);
					break;
				}
			}
		}
	#endif
	#if !defined _INC_y_hooks
		#if defined FAC_OnPlayerKeyStateChange
			return FAC_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
		#else 
			return 1;
		#endif
	#else 
		return 1;
	#endif
}


#if defined _INC_y_hooks
	hook OnPlayerStateChange(playerid, newstate, oldstate)
#else 
	public OnPlayerStateChange(playerid, newstate, oldstate)
#endif
{
	// printf("%s -> STATE_CHANGE: %d, %d (%d)", GetPlayerNameEx(playerid), newstate, oldstate, GetPlayerVehicleID(playerid));

	if(IsPlayerNPC(playerid)) return 1;

	new 
		now = gettime(),
		tick = GetTickCount();

	#if AC_ENABLE_AIRBREAK
		if((
				(newstate != PLAYER_STATE_DRIVER && newstate != PLAYER_STATE_PASSENGER) && 
				(oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER)
			)
			|| 
			(
				(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER))
			)
		{
			ac__AirBreak[playerid][e_ac_AirBrkImmune] = now + 2;
		}
	#endif
	#if AC_ENABLE_SEAT_CHANGER
		if(newstate == PLAYER_STATE_DRIVER)
		{
			ac__LastDriveState[playerid] = tick;
		}
		else if(oldstate == PLAYER_STATE_DRIVER &&
				FAC_GetTickDiff(tick, ac__LastDriveState[playerid]) <= 20 &&
				ac__LastVehicle[playerid] != FAC_INVALID_VEHICLE_ID)
		{
			/** Keicia savo state per greitai 
				Sugebejo islipt is masinos per 200ms
			*/
			_FAC_CheatDetected(playerid, CHEAT_SEAT_CHANGER, ac__LastVehicle[playerid]);
		}
	#endif

	#if AC_ENABLE_WARP_INTO_CAR 
		if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
		{
			new current_vehicle = GetPlayerVehicleID(playerid);
			printf("%s ?==? warp (cur:%d,enter:%d,last:%d)", GetPlayerNameEx(playerid), current_vehicle, ac__EnteringVehicle[playerid], ac__LastVehicle[playerid]);
			if(	(
					/** Nelipa i jokia masina, arba ne i sita. */
					ac__EnteringVehicle[playerid] == FAC_INVALID_VEHICLE_ID || 	
					ac__EnteringVehicle[playerid] != current_vehicle
				)
				|| 
				(	
					/** Is kitos masinos paspaude HOME mygtuka. */
					ac__LastVehicle[playerid] != FAC_INVALID_VEHICLE_ID &&
					ac__EnteringVehicle[playerid] != current_vehicle &&
					ac__LastVehicle[playerid] != current_vehicle
				)
			)
			{
				_FAC_CheatDetected(playerid, CHEAT_WARP_TO_CAR, current_vehicle);
			}
			ac__EnteringVehicle[playerid] 	= FAC_INVALID_VEHICLE_ID;
			ac__LastVehicle[playerid] 		= current_vehicle;
		}
	#endif

	if(newstate != PLAYER_STATE_DRIVER && newstate != PLAYER_STATE_PASSENGER && ac__LastVehicle[playerid] != FAC_INVALID_VEHICLE_ID)
	{
		ac__LastVehicle[playerid] = FAC_INVALID_VEHICLE_ID;
	}

	#if !defined _INC_y_hooks
		#if defined FAC_OnPlayerStateChange
			return FAC_OnPlayerStateChange(playerid, newstate, oldstate);
		#else 
			return 1;
		#endif
	#else 
		return 1;
	#endif
}

#if defined _INC_y_hooks
	hook OnVehicleMod(playerid, vehicleid, componentid)
#else 
	public OnVehicleMod(playerid, vehicleid, componentid)
#endif
{
	if(!(1000 <= componentid <= 1193)) return 0;
	#if AC_ENABLE_ANTIMOD 
		_FAC_CheatDetected(playerid, CHEAT_VEH_MODS, vehicleid, componentid);
	#endif
	#if !defined _INC_y_hooks
		#if defined FAC_OnVehicleMod
			return FAC_OnVehicleMod(playerid, vehicleid, componentid);
		#else 
			return 1;
		#endif
	#else 
		return 1;
	#endif
}

#if defined _INC_y_hooks
	hook OnPlayerDeath(playerid, killerid, reason)
#else 
	public OnPlayerDeath(playerid, killerid, reason)
#endif
{
	printf("FAC_OnPlayerDeath");
	#if AC_ENABLE_FAKEKILL 
		new 
			now = gettime();
		if(0 <= now - ac__LastDeath[playerid] <= 3)
		{
			ac__DeathSpam[playerid] ++;
			if(ac__DeathSpam[playerid] >= AC_FAKE_KILL_MAX_WARNINGS)
			{
				_FAC_CheatDetected(playerid, CHEAT_FAKE_KILL);
			}
		}
		else ac__DeathSpam[playerid] = 0;
		ac__LastDeath[playerid] = now;
	#endif
	
	ac__PlayerHealth[playerid] = 100.0;
	FAC_ResetPlayerWeapons(playerid);

	#if !defined _INC_y_hooks
		#if defined FAC_OnPlayerDeath
			return FAC_OnPlayerDeath(playerid, killerid, reason);
		#else 
			return 1;
		#endif
	#else 
		return 1;
	#endif
}

#if defined _INC_y_hooks
	hook OnPlayerSpawn(playerid)
#else 
	public OnPlayerSpawn(playerid)
#endif
{
	ac__PlayerHealth[playerid] = 100.0;
	ac__PlayerArmour[playerid] = 0.0;
	ac__InvWarnings[playerid] = 0;
	ac__Spawned[playerid] = true;
	ac__LastAFKTick[playerid] = GetTickCount();
	ac__PlayerControllable[playerid] = true;
	#if !defined _INC_y_hooks
		#if defined FAC_OnPlayerSpawn
			return FAC_OnPlayerSpawn(playerid);
		#else 
			return 1;
		#endif
	#else 
		return 1;
	#endif
}


stock IsPlayerAFK(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(FAC_GetTickDiff(GetTickCount(), ac__LastAFKTick[playerid]) > AC_AFK_MAX_TIME) return true;
	}
	return false;
}


stock FAC_TogglePlayerSpectating(playerid, toggle)
{
	ac__AirBreak[playerid][e_ac_AirBrkImmune] = gettime() + 4;
	return TogglePlayerSpectating(playerid, toggle);
}

stock IsPlayerControllable(playerid) return ac__PlayerControllable[playerid];

stock FAC_TogglePlayerControllable(playerid, toggle)
{
	ac__PlayerControllable[playerid] = toggle;
	return TogglePlayerControllable(playerid, toggle);
}

stock FAC_PutPlayerInVehicle(playerid, vehicleid, seatid)
{
	if(	IsValidVehicle(vehicleid) && 
		GetVehicleVirtualWorld(vehicleid) == GetPlayerVirtualWorld(playerid))
	{
		ac__EnteringVehicle[playerid] = vehicleid;
		ac__LastVehicle[playerid] = vehicleid;
		return PutPlayerInVehicle(playerid, vehicleid, seatid);
	}
	return 0;
}

stock FAC_SetPlayerHealth(playerid, Float:health)
{
	if(IsPlayerAFK(playerid))
	{
		ac__IgnoreAfkHealth[playerid] += health;
	}
	if(health >= 0.0)
	{
		ac__PlayerHealth[playerid] = health;
	}
	else ac__PlayerHealth[playerid] = 0.0000000;
	return SetPlayerHealth(playerid, health);
}

stock FAC_SetPlayerArmour(playerid, Float:armour)
{
	if(IsPlayerAFK(playerid))
	{
		ac__IgnoreAfkArmour[playerid] += armour;
	}
	if(armour >= 0.0)
	{
		ac__PlayerArmour[playerid] = armour;
	}
	else ac__PlayerArmour[playerid] = 0.0;
	return SetPlayerArmour(playerid, armour);
}

stock FAC_GetPlayerHealth(playerid, &Float:health)
{
	#if AC_ENABLE_HEALTH
		health = ac__PlayerHealth[playerid];
	#else 
		GetPlayerHealth(playerid, health);
	#endif
	return 1;
}

stock FAC_GetPlayerArmour(playerid, &Float:armour)
{
	#if AC_ENABLE_HEALTH
		armour = ac__PlayerArmour[playerid];
	#else 
		GetPlayerArmour(playerid, armour);
	#endif
	return 1;
}

stock FAC_CheckPlayerHealth(playerid)
{
	new 
		Float:health,
		Float:armour,
		Float:diff;
	GetPlayerHealth(playerid, health);
	GetPlayerArmour(playerid, armour);
	if(health > ac__PlayerHealth[playerid] && health > 0.0)
	{
		diff = floatround(health, floatround_floor) - floatround(ac__PlayerHealth[playerid]);
		if((diff > ac__IgnoreAfkHealth[playerid] && (ac__ReturnState[playerid] || IsPlayerAFK(playerid))) || (diff > 0.0 && !IsPlayerAFK(playerid) && !ac__ReturnState[playerid]))
		{
			FAC_ResetHealthIgnore(playerid);
			SetPlayerHealth(playerid, ac__PlayerHealth[playerid]);
			
			_FAC_CheatDetected(playerid, CHEAT_HEALTH, floatround(diff));
			return 1;
		}
		else
		{
			FAC_ResetHealthIgnore(playerid);
			ac__PlayerHealth[playerid] = health;
		}
	}
	else
	{
		ac__PlayerHealth[playerid] = health;
	}

	if(armour > ac__PlayerArmour[playerid] && armour > 0.0)
	{
		diff = floatround(armour, floatround_floor) - floatround(ac__PlayerArmour[playerid]);
		if((diff > ac__IgnoreAfkArmour[playerid] && (ac__ReturnState[playerid] || IsPlayerAFK(playerid))) || (diff > 0.0 && !IsPlayerAFK(playerid) && !ac__ReturnState[playerid]))
		{
			FAC_ResetArmourIgnore(playerid);
			SetPlayerArmour(playerid, ac__PlayerArmour[playerid]);
			
			_FAC_CheatDetected(playerid, CHEAT_ARMOUR, floatround(diff));
			return 1;
		}
		else
		{
			FAC_ResetArmourIgnore(playerid);
			ac__PlayerArmour[playerid] = armour;
		}
	}
	else 
	{
		ac__PlayerArmour[playerid] = armour;
	}
	return 1;
}

stock FAC_ResetHealthIgnore(playerid)
{
	ac__ReturnState[playerid] = false;
	ac__IgnoreAfkHealth[playerid] = 0.0;
	return 1;
}

stock FAC_ResetArmourIgnore(playerid)
{
	ac__ReturnState[playerid] = false;
	ac__IgnoreAfkArmour[playerid] = 0.0;
	return 1;
}

stock FAC_CheckVehicleHealth(vehicleid)
{
	new 
		Float:health;
	GetVehicleHealth(vehicleid, health);
	if(health > ac__VehicleHealth[vehicleid])
	{
		SetVehicleHealth(vehicleid, ac__VehicleHealth[vehicleid]);
		#if AC_IGNORE_PAYNSPRAY_VEHICLE_HP
			if(GetVehicleDistanceFromPoint(vehicleid, 1026, -1029.48, 31.7) <= 30.0 || GetVehicleDistanceFromPoint(vehicleid, 1043, -1026, 31.8) <= 30.0 ||	
				GetVehicleDistanceFromPoint(vehicleid, 2071.6001, -1831.8, 13) <= 30.0 || GetVehicleDistanceFromPoint(vehicleid, -100.1, 1111.46, 21.1) <= 30.0 ||
				GetVehicleDistanceFromPoint(vehicleid, -361, 1194.2, 18.245) <= 30.0 || GetVehicleDistanceFromPoint(vehicleid, 2386.1001, 1043.4, 10) <= 30.0 ||	
				GetVehicleDistanceFromPoint(vehicleid, -1904.6, 277.70001, 43) <= 30.0 || GetVehicleDistanceFromPoint(vehicleid, -1935.5, 239.2, 33.7) <= 30.0 ||	
				GetVehicleDistanceFromPoint(vehicleid, -2716.1001, 216.8, 3.8) <= 30.0)
				{
					return 1;
				}
		#endif

		AC_playerloop(playerid)
		{
			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsPlayerInVehicle(playerid, vehicleid))
			{
				_FAC_CheatDetected(playerid, CHEAT_VEH_HEALTH, vehicleid);
				break;
			}
		}
	}
	else if(ac__VehicleHealth[vehicleid] > health)
	{
		ac__VehicleHealth[vehicleid] = health;
	}
	return 1;
}
static 
    vehicle_Colors[MAX_VEHICLES][2];
stock FAC_CreateVehicle(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay, addsiren=0)
{
	static const 
        l_randomColorsList[] = {1, 2, 7, 8, 9, 10, 11, 12, 13, 16, 21, 22, 24, 25, 26, 53, 30, 31, 68, 69, 75, 45, 64, 44};

    if(color1 == -1) color1 = l_randomColorsList[random(sizeof l_randomColorsList)];
    if(color2 == -1) color2 = l_randomColorsList[random(sizeof l_randomColorsList)];

	new vehicleid = CreateVehicle(vehicletype, x, y, z, rotation, color1, color2, respawn_delay, addsiren);
	if(vehicleid != FAC_INVALID_VEHICLE_ID)
	{
		ac__VehicleHealth[vehicleid] = 1000.0000000000000000000000000;
		vehicle_Colors[vehicleid][0] = color1;
        vehicle_Colors[vehicleid][1] = color2;
		#if defined _INC_y_hooks
			call OnVehicleCreated(vehicleid);
		#endif
	}
	return vehicleid;
}
stock FAC_DestroyVehicle(vehicleid)
{
	if(IsValidVehicle(vehicleid))
	{
		#if defined _INC_y_hooks
			call OnVehicleDestroyed(vehicleid);
		#endif
		return DestroyVehicle(vehicleid);
	}
	return false;
}

stock GetVehicleColor(vehicleid, &color1, &color2)
{
	color1 = vehicle_Colors[vehicleid][0];
	color2 = vehicle_Colors[vehicleid][1];
}

stock FAC_ChangeVehicleColor(vehicleid, color1, color2)
{
	vehicle_Colors[vehicleid][0] = color1;
    vehicle_Colors[vehicleid][1] = color2;
	return ChangeVehicleColor(vehicleid, color1, color2);
}


stock FAC_SetVehicleToRespawn(vehicleid)
{
	ac__VehicleHealth[vehicleid] = 1000.0;
	return SetVehicleToRespawn(vehicleid);
}


stock FAC_RepairVehicle(vehicleid)
{
	ac__VehicleHealth[vehicleid] = 1000.0;
	return RepairVehicle(vehicleid);
}

stock FAC_SetVehicleHealth(vehicleid, Float:health)
{
	ac__VehicleHealth[vehicleid] = health;
	return SetVehicleHealth(vehicleid, health);
}

stock FAC_CancelVehicleEnter(playerid)
{
	ac__EnteringVehicle[playerid] = FAC_INVALID_VEHICLE_ID;
	return CancelVehicleEnter(playerid);
}

stock FAC_RemovePlayerFromVehicle(playerid)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	defer PT_CheckIfStillInCar[2000](playerid, vehicleid);

	ac__LastVehicle[playerid] = 
	ac__EnteringVehicle[playerid] = FAC_INVALID_VEHICLE_ID;
	return RemovePlayerFromVehicle(playerid);
}

timer PT_CheckIfStillInCar[2000](playerid, vehicleid)
{
	if(IsPlayerAFK(playerid))
	{
		defer PT_CheckIfStillInCar[1000](playerid, vehicleid);
		return;
	}
	else if(IsPlayerInAnyVehicle(playerid) &&
			GetPlayerVehicleID(playerid) == vehicleid)
	{
		_FAC_CheatDetected(playerid, CHEAT_NOPS, NOP_REMOVE_FROM_VEHICLE, vehicleid);
	}
}

stock FAC_DetachTrailerFromVehicle(vehicleid)
{
	return DetachTrailerFromVehicle(vehicleid);
}

stock FAC_AttachTrailerToVehicle(trailerid, vehicleid)
{
	return AttachTrailerToVehicle(trailerid, vehicleid);
}

forward t_ac__WeaponsTimer();
public t_ac__WeaponsTimer()
{
	new 
		playerWeapon;
	AC_playerloop(playerid)
	{
		if(!IsPlayerConnected(playerid) || 
			!_FAC_IsPlayerStatePlaying(playerid)) continue; 
			
		if(ac__IgnoreWeapons[playerid] > 0)
		{
			if((ac__IgnoreWeapons[playerid] -= 1) > 0) continue; 
		}

		#if AC_WEAPONS_CHECK_ALWAYS
			#pragma unused playerWeapon
			for(new slot = 0; slot < 13; slot++)
			{
				if(FAC_CheckWeaponCheat(playerid, slot, true, __line))
				{
					#if AC_WEAPONS_SKIP_MULTIPLE_BANS
						break; // cheata radom, breakinam, kad nespamintu apie tolimesnisu cheatintus ginklus.
					#endif
				}
			}
		#else
			if((playerWeapon = GetPlayerWeapon(playerid)) != ac__LastWeapon[playerid])
			{
				FAC_OnPlayerWeaponChanged(playerid, playerWeapon, ac__LastWeapon[playerid]);
			}
		#endif
	}
	SetTimer("t_ac__WeaponsTimer", AC_WEAPONS_TIME, false);
	return 1;
}

public FAC_OnPlayerWeaponChanged(playerid, newweapon, oldweapon)
{
	if(newweapon != 0) FAC_CheckWeaponCheat(playerid, newweapon, false, __line);
	else if(oldweapon != 0)
	{
		new 
			slot;
		if((slot = FAC_GetWeaponSlot(oldweapon)) != 0xFFFF)
		{
			new 
				l_data[2];
			GetPlayerWeaponData(playerid, slot, l_data[0], l_data[1]);
			if(l_data[0] <= 0 || l_data[1] <= 0)
			{
				FAC_ResetPlayerWeaponSlotData(playerid, slot);
			}
			else
			{
				FAC_CheckWeaponCheat(playerid, slot, true, __line);
			}
		}
	}
	ac__LastWeapon[playerid] = newweapon;
	return 1;
}

stock FAC_CheckWeaponCheat(playerid, id, bool:byslot, line = 0)
{
	new 
		slot;
	if(ac__IgnoreWeapons[playerid] > 0) return false;
	if(((slot = id) && byslot) || (((slot = FAC_GetWeaponSlot(id)) != 0xFFFF) && !byslot))
	{
		new 
			l_data[2];
		GetPlayerWeaponData(playerid, slot, l_data[0], l_data[1]);
		if(	(ac__PlayerWeapons[playerid][slot][e_ac_WeaponId] != l_data[0] && l_data[0] != 0 && l_data[1] > 0) || 
			(ac__PlayerWeapons[playerid][slot][e_ac_WeaponAmmo] < l_data[1] && l_data[1] > 0 && l_data[0] > 0))
		{
			printf("FAC_CheckWeaponCheat(%d, id: %d, byslot: %d) .pwn:%d", playerid, id, _:byslot, line);
			printf("CHEAT: cln[%d]:[%d] 	  srv[%d]:[%d]", 
				l_data[0], l_data[1],
				ac__PlayerWeapons[playerid][slot][e_ac_WeaponId], ac__PlayerWeapons[playerid][slot][e_ac_WeaponAmmo]
			);

			FAC_ResetPlayerWeapons(playerid);

			_FAC_CheatDetected(playerid, CHEAT_WEAPON, l_data[0], l_data[1]);
			return true;
		}
		else if(l_data[1] <= 0 && l_data[0] > 0)
		{
			FAC_ResetPlayerWeaponSlotData(playerid, slot);
		}
		else 
		{
			ac__PlayerWeapons[playerid][slot][e_ac_WeaponAmmo] = l_data[1];
		}
	}
	return false;
}


stock FAC_ResetPlayerWeaponSlotData(playerid, slot)
{
	new 
		reset[E_AC_WEAPONS];
	return (ac__PlayerWeapons[playerid][slot] = reset);
}

stock FAC_ResetPlayerWeapons(playerid)
{
	printf("FAC_ResetPlayerWeapons(%d)", playerid);
	for(new slot = 0; slot < 13; slot++)
	{
		ac__PlayerWeapons[playerid][slot][e_ac_WeaponId] = 
		ac__PlayerWeapons[playerid][slot][e_ac_WeaponAmmo] = 0;
	}
	ac__IgnoreWeapons[playerid] = 6;
	ac__LastWeapon[playerid] = 0;
	return ResetPlayerWeapons(playerid);
}

stock RemovePlayerWeapon(playerid, weapon)
{
	new curWeapon, curAmmo, slot;
	GetPlayerWeaponData(playerid, (slot = FAC_GetWeaponSlot(weapon)), curWeapon, curAmmo);
	if(curWeapon == weapon)
	{
		RemovePlayerWeaponInSlot(playerid, slot);
		return true;
	}
	return false;
}

stock PlayerHasWeaponInSlot(playerid, slot)
{
	new data[2];
	GetPlayerWeaponData(playerid, slot, data[0], data[1]);
	if(data[0] != 0 && data[1] > 0)
	{
		return data[0];
	}
	return 0;
}

stock RemovePlayerWeaponInSlot(playerid, remove)
{
	printf("RemovePlayerWeaponInSlot: %d [slot: %d]", playerid, remove);
	/**
		Removing su SetPlayerAmmo,
		o veliau timeryje tikrint, jei ammo = 0, bet weaponid > 0, nustatyti WeaponId=0.
	*/

	new 	
		data[2];

	GetPlayerWeaponData(playerid, remove, data[0], data[1]);
	return FAC_SetPlayerAmmo(playerid, data[0], 0);
/*	for(new slot = 0; slot < 13; slot++)
	{
		if(slot != remove) GetPlayerWeaponData(playerid, slot, data[slot][0], data[slot][1]);
	}

	FAC_ResetPlayerWeapons(playerid);

	for(new slot = 0; slot < 13; slot++)
	{
		if(slot != remove) FAC_GivePlayerWeapon(playerid, data[slot][0], data[slot][1]);
	}
	return 1;*/
}

stock FAC_GetWeaponSlot(weaponid)
{
	switch(weaponid) 
    { 
        case 1: return 0; 
        case 2..9: return 1; 
        case 22..24: return 2; 
        case 25..27: return 3; 
        case 28, 29, 32: return 4; 
        case 30, 31: return 5; 
        case 33, 34: return 6; 
        case 35..38: return 7; 
        case 16..18, 39: return 8; 
        case 41..43: return 9; 
        case 10..15: return 10; 
        case 44..46: return 11; 
        case 40: return 12; 
    } 
    return 0xFFFF; 
}

stock FAC_SetPlayerAmmo(playerid, weaponid, ammo)
{
	printf("FAC_SetPlayerAmmo: %d, [wep:%d, ammo:%d]", playerid, weaponid, ammo);
	new 
		result = SetPlayerAmmo(playerid, weaponid, ammo),
		slot;
	if((slot = FAC_GetWeaponSlot(weaponid)) != 0xFFFF)
	{
		if(ammo <= 0)
		{
			ac__PlayerWeapons[playerid][slot][e_ac_WeaponAmmo] = 
			ac__PlayerWeapons[playerid][slot][e_ac_WeaponId] = 0;
		}
		else
		{
			ac__PlayerWeapons[playerid][slot][e_ac_WeaponAmmo] += ammo;
		}
		ac__IgnoreWeapons[playerid] = 4;
	}
	return result;
}

stock FAC_GivePlayerWeapon(playerid, weaponid, ammo)
{
	new 
		slot;
	if((slot = FAC_GetWeaponSlot(weaponid)) != 0xFFFF && weaponid != 0)
	{	
		if(ac__PlayerWeapons[playerid][slot][e_ac_WeaponId] != 0) // == weaponid
		{
			if(ac__PlayerWeapons[playerid][slot][e_ac_WeaponAmmo] > 0)
			{
				ac__PlayerWeapons[playerid][slot][e_ac_WeaponAmmo] += ammo;
			}
			else ac__PlayerWeapons[playerid][slot][e_ac_WeaponAmmo] = ammo;
		}
		else
		{
			ac__PlayerWeapons[playerid][slot][e_ac_WeaponAmmo] = ammo;
		}
		ac__PlayerWeapons[playerid][slot][e_ac_WeaponId] = weaponid;
		ac__IgnoreWeapons[playerid] = 4;
		new ret = GivePlayerWeapon(playerid, weaponid, ammo);
		return ret;
	}
	return false;
}

forward t_ac__MoneyTimer();
public t_ac__MoneyTimer()
{
	AC_playerloop(playerid)
	{
		if(ac__IgnoreMoney[playerid] > 0)
		{
			ac__IgnoreMoney[playerid]--;
			continue;
		}
		new currentMoney = GetPlayerMoney(playerid);
		if(currentMoney != ac__PlayerMoney[playerid])
		{
			_FAC_CheatDetected(playerid, CHEAT_MONEY, currentMoney - ac__PlayerMoney[playerid]);

			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid, ac__PlayerMoney[playerid]);
		}
	}
	SetTimer("t_ac__MoneyTimer", AC_MONEY_TIME, false);
	return 1;
}

stock FAC_ResetPlayerMoney(playerid)
{
	ac__PlayerMoney[playerid] = 0;
	return ResetPlayerMoney(playerid);
}

stock FAC_GetPlayerMoney(playerid)
{
	return ac__PlayerMoney[playerid];
}

stock FAC_GivePlayerMoney(playerid, amount)
{
	ac__IgnoreMoney[playerid] = 2;
	ac__PlayerMoney[playerid] += amount;
	return GivePlayerMoney(playerid, amount);
}

stock FAC_SetPlayerVirtualWorld(playerid, worldid)
{
	ac__PlayerVW[playerid] = worldid;
	ac__AirBreak[playerid][e_ac_AirBrkImmune] = gettime() + 2;
	return SetPlayerVirtualWorld(playerid, worldid);
}
stock FAC_SetPlayerInterior(playerid, interiorid)
{
	ac__PlayerInt[playerid] = interiorid;
	ac__AirBreak[playerid][e_ac_AirBrkImmune] = gettime() + 2;
	return SetPlayerInterior(playerid, interiorid);
}

stock FAC_SetPlayerPos(playerid, Float:x, Float:y, Float:z)
{
	ac__AirBreak[playerid][e_ac_AirBrkImmune] = gettime() + 3;
	ac__EnteringVehicle[playerid] = FAC_INVALID_VEHICLE_ID;
	return SetPlayerPos(playerid, x, y, z);
}

stock FAC_SetVehiclePos(vehicleid, Float:x, Float:y, Float:z)
{
	AC_playerloop(playerid)
	{
		if(GetPlayerVehicleID(playerid) == vehicleid)
		{
			ac__AirBreak[playerid][e_ac_AirBrkImmune] = gettime() + 5;
		}
	}
	return SetVehiclePos(vehicleid, x, y, z);
}

forward t_ac__AirBreak();
public t_ac__AirBreak()
{
	new 
		vehicleid,
		playerstate,
		Float:x, 
		Float:y,
		Float:z,
		Float:distance,
		now = gettime();

	AC_playerloop(playerid)
	{
		if(!IsPlayerConnected(playerid) || IsPlayerNPC(playerid)) continue;
		
		/* Sanity checks */
		GetPlayerPos(playerid, x, y, z);
		if(x > 0xdbb9f || y > 0xdbb9f || z > 0xdbb9f)
		{
			FAC_SetPlayerPos(playerid, 	ac__AirBreak[playerid][e_ac_AirBrkX],
										ac__AirBreak[playerid][e_ac_AirBrkY],
										ac__AirBreak[playerid][e_ac_AirBrkZ]);
		}

		if(now <= ac__AirBreak[playerid][e_ac_AirBrkLastChk]) continue;

		/* AirBreak check */
		else if(now > ac__AirBreak[playerid][e_ac_AirBrkImmune] && 
				!_FAC_IsPlayerSurfing(playerid) &&
				!_FAC_IsPlayerLeavingCar(playerid))
		{
			vehicleid = GetPlayerVehicleID(playerid);
			distance = GetPlayerDistanceFromPoint(playerid, ac__AirBreak[playerid][e_ac_AirBrkX], ac__AirBreak[playerid][e_ac_AirBrkY], ac__AirBreak[playerid][e_ac_AirBrkZ]);
			switch((playerstate = GetPlayerState(playerid)))
			{
				case PLAYER_STATE_ONFOOT:
				{
					GetPlayerPos(playerid, x, y, z);
					if((floatabs(ac__AirBreak[playerid][e_ac_AirBrkZ] - z) < 1.0 && floatabs(distance) >= AC_AIRBRK_ON_FOOT_DISTANCE) && // Nekrenta ir distancija labai pasikeitus
						(floatabs(ac__AirBreak[playerid][e_ac_AirBrkX] - x) >= 50.0 || floatabs(ac__AirBreak[playerid][e_ac_AirBrkY] - y) >= 50.0))
					{
						_FAC_AirbreakDetected(playerid);
					}
				}
				case PLAYER_STATE_DRIVER:
				{
					GetVehiclePos(vehicleid, x, y, z);
					if((!_FAC_IsVehicleMoving(vehicleid) && floatabs(distance) >= AC_AIRBRK_IN_VEHICLE_DISTANCE) &&
						(floatabs(ac__AirBreak[playerid][e_ac_AirBrkX] - x) >= 40.0 || floatabs(ac__AirBreak[playerid][e_ac_AirBrkY] - y) >= 40.0))
					{
						_FAC_AirbreakDetected(playerid);
					}
				}
			}
		}
		switch(playerstate)
		{
			case PLAYER_STATE_ONFOOT:
			{
				GetPlayerPos(playerid, 	ac__AirBreak[playerid][e_ac_AirBrkX], 
										ac__AirBreak[playerid][e_ac_AirBrkY],
										ac__AirBreak[playerid][e_ac_AirBrkZ]);
			}
			case PLAYER_STATE_DRIVER:
			{
				GetVehiclePos(vehicleid,ac__AirBreak[playerid][e_ac_AirBrkX],
										ac__AirBreak[playerid][e_ac_AirBrkY],
										ac__AirBreak[playerid][e_ac_AirBrkZ]);
			}
		}

		ac__AirBreak[playerid][e_ac_AirBrkLastChk] = now;
	}	
	SetTimer("t_ac__AirBreak", AC_AIRBREAK_TIME, false);
	return 1;
}

static _FAC_AirbreakDetected(playerid)
{
	new 
		now = gettime();
	if(	(ac__AirBreak[playerid][e_ac_AirBrkDetected] += 1) >= AC_AIRBREAK_MAX_WARNINGS && 
		(now - ac__AirBreak[playerid][e_ac_AirBrkLast]) < 10)
	{
		_FAC_CheatDetected(playerid, CHEAT_AIRBRK);
		ac__AirBreak[playerid][e_ac_AirBrkImmune] = now + 3;
	}
	ac__AirBreak[playerid][e_ac_AirBrkLast] = now;
	return 1;
}

static _FAC_IsVehicleMoving(vehicleid)
{
	// Emmet
	new
	    Float:x,
	    Float:y,
	    Float:z;
	GetVehicleVelocity(vehicleid, x, y, z);
	return (!(floatabs(x) <= 0.001 && floatabs(y) <= 0.001 && floatabs(z) <= 0.005));
}

stock FAC_VehicleSpeed(vehicleid)
{
	static 
		Float:Vx,
		Float:Vy,
		Float:Vz
	;
	GetVehicleVelocity(vehicleid, Vx, Vy, Vz);
	return floatround((floatsqroot((Vx * Vx) + (Vy * Vy) + (Vz * Vz)) * 136.666667));
}


static Float:FAC_aimInt_DCTTL(Float:CamX, Float:CamY, Float:CamZ, Float:ObjX, Float:ObjY, Float:ObjZ, Float:FrX, Float:FrY, Float:FrZ)
{
   	static Float:TGTDistance,Float:tmpX, Float:tmpY, Float:tmpZ;
    TGTDistance = floatsqroot((CamX - ObjX) * (CamX - ObjX) + (CamY - ObjY) * (CamY - ObjY) + (CamZ - ObjZ) * (CamZ - ObjZ));

    tmpX = FrX * TGTDistance + CamX;
    tmpY = FrY * TGTDistance + CamY;
    tmpZ = FrZ * TGTDistance + CamZ;

    return floatsqroot((tmpX - ObjX) * (tmpX - ObjX) + (tmpY - ObjY) * (tmpY - ObjY) + (tmpZ - ObjZ) * (tmpZ - ObjZ));
}
static Float:FAC_aimInt_GPATP(Float:l_x2, Float:l_y2, Float:X, Float:Y)
{
	static Float:DX, Float:DY,Float:angle;

	DX = floatabs(floatsub(l_x2,X));
	DY = floatabs(floatsub(l_y2,Y));

  	if (DY == 0.0 || DX == 0.0)
  	{
		if((DY == 0 && DX > 0) || (DY == 0 && DX == 0)) angle = 0.0;
    	else if(DY == 0 && DX < 0) angle = 180.0;
    	else if(DY > 0 && DX == 0) angle = 90.0;
    	else if(DY < 0 && DX == 0) angle = 270.0;
  	}
  	else
	{
    	angle = atan(DX/DY);

    	if(X > l_x2 && Y <= l_y2) angle += 90.0;
    	else if(X <= l_x2 && Y < l_y2) angle = floatsub(90.0, angle);
    	else if(X < l_x2 && Y >= l_y2) angle -= 90.0;
    	else if(X >= l_x2 && Y > l_y2) angle = floatsub(270.0, angle);
  	}
  	return floatadd(angle, 90.0);
}
static FAC_aimInt_GXYIFOP(&Float:x, &Float:y, Float:angle, Float:distance)
{
	x += (distance * floatsin(-angle, degrees));
	y += (distance * floatcos(-angle, degrees));
}
static FAC_aimInt_IsCameraAimingAt(weaponid,Float:x, Float:y, Float:z,Float:vector_x,Float:vector_y,Float:vector_z,Float:camera_x,Float:camera_y,Float:camera_z,Float:radius)
{
   	static Float:vertical, Float:horizontal;
    switch (weaponid)
    {
		case 34,35,36:
		{
			if (FAC_aimInt_DCTTL(camera_x, camera_y, camera_z, x, y, z, vector_x, vector_y, vector_z) < radius) return true;
			return false;
        }
        case 30,31: {vertical = 4.0; horizontal = -1.6;}
        case 33: {vertical = 2.7; horizontal = -1.0;}
        default: {vertical = 6.0; horizontal = -2.2;}
	}
	new Float:angle = FAC_aimInt_GPATP(0, 0, floatsqroot(vector_x*vector_x+vector_y*vector_y), vector_z) - 270.0;
	new Float:resize_x, Float:resize_y, Float:resize_z = floatsin(angle+vertical, degrees);

	FAC_aimInt_GXYIFOP(resize_x, resize_y, FAC_aimInt_GPATP(0, 0, vector_x, vector_y)+horizontal, floatcos(angle+vertical, degrees));

	if (FAC_aimInt_DCTTL(camera_x, camera_y, camera_z, x, y, z, resize_x, resize_y, resize_z) < radius) return true;
	return false;
}

stock FAC_IpToInt(const ip[])
{
	new 
		bytes[1],
		pos = 0;

	bytes{0} = strval(ip[pos]);
	while(pos < 15 && ip[pos++] != '.') {}
    bytes{1} = strval(ip[pos]);
    while(pos < 15 && ip[pos++] != '.') {}
    bytes{2} = strval(ip[pos]);
    while(pos < 15 && ip[pos++] != '.') {}
    bytes{3} = strval(ip[pos]);
   
    return bytes[0];
}

stock FAC_GetTickDiff(newtick, oldtick)
{
	if (oldtick < 0 && newtick >= 0) {
		return newtick - oldtick;
	} else if (oldtick >= 0 && newtick < 0 || oldtick > newtick) {
		return (cellmax - oldtick + 1) - (cellmin - newtick);
	}
	return newtick - oldtick;
}

// Rehooks
// Callbacks
#if !defined _INC_y_hooks
	#if defined _ALS_OnGameModeInit
		#undef OnGameModeInit
	#else
		#define _ALS_OnGameModeInit
	#endif
	#define OnGameModeInit FAC_OnGameModeInit
	#if defined FAC_OnGameModeInit
		forward FAC_OnGameModeInit();
	#endif

	#if defined _ALS_OnDialogResponse
		#undef OnDialogResponse
	#else
		#define _ALS_OnDialogResponse
	#endif
	#define OnDialogResponse FAC_OnDialogResponse
	#if defined FAC_OnDialogResponse
		forward FAC_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
	#endif
	

	#if defined _ALS_OnPlayerPickUpDynamicPickup
		#undef OnPlayerPickUpDynamicPickup
	#else
		#define _ALS_OnPlayerPickUpDynamicPickup
	#endif
	#define OnPlayerPickUpDynamicPickup FAC_OnPlayerPickUpDynamicPickup
	#if defined FAC_OnPlayerPickUpDynamicPickup
		forward FAC_OnPlayerPickUpDynamicPickup(playerid, STREAMER_TAG_PICKUP pickupid);
	#endif

	#if defined _ALS_OnPlayerEnterVehicle
		#undef OnPlayerEnterVehicle
	#else
		#define _ALS_OnPlayerEnterVehicle
	#endif
	#define OnPlayerEnterVehicle FAC_OnPlayerEnterVehicle
	#if defined FAC_OnPlayerEnterVehicle
		forward FAC_OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);
	#endif


	#if defined _ALS_OnPlayerConnect
		#undef OnPlayerConnect
	#else
		#define _ALS_OnPlayerConnect
	#endif
	#define OnPlayerConnect FAC_OnPlayerConnect
	#if defined FAC_OnPlayerConnect
		forward FAC_OnPlayerConnect(playerid);
	#endif

	#if defined _ALS_OnPlayerDisconnect
		#undef OnPlayerDisconnect
	#else 
		#define _ALS_OnPlayerDisconnect
	#endif
	#define OnPlayerDisconnect FAC_OnPlayerDisconnect
	#if defined FAC_OnPlayerDisconnect
		forward FAC_OnPlayerDisconnect(playerid, reason);
	#endif

	#if defined _ALS_OnVehicleSpawn
		#undef OnVehicleSpawn
	#else
		#define _ALS_OnVehicleSpawn
	#endif
	#define OnVehicleSpawn FAC_OnVehicleSpawn
	#if defined FAC_OnVehicleSpawn
		forward FAC_OnVehicleSpawn(vehicleid);
	#endif

	#if defined _ALS_OnUnoccupiedVehicleUpdate
		#undef OnUnoccupiedVehicleUpdate
	#else
		#define _ALS_OnUnoccupiedVehicleUpdate
	#endif
	#define OnUnoccupiedVehicleUpdate FAC_OnUnoccupiedVehicleUpdate
	#if defined FAC_OnUnoccupiedVehicleUpdate
		forward FAC_OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z);
	#endif

	#if defined _ALS_OnVehicleDeath
		#undef OnVehicleDeath
	#else
		#define _ALS_OnVehicleDeath
	#endif
	#define OnVehicleDeath FAC_OnVehicleDeath
	#if defined FAC_OnVehicleDeath
		forward FAC_OnVehicleDeath(vehicleid, killerid);
	#endif

	#if defined _ALS_OnVehicleMod
		#undef OnVehicleMod
	#else
		#define _ALS_OnVehicleMod
	#endif
	#define OnVehicleMod FAC_OnVehicleMod
	#if defined FAC_OnVehicleMod
		forward FAC_OnVehicleMod(playerid, vehicleid, componentid);
	#endif

	#if defined _ALS_OnPlayerDeath
		#undef OnPlayerDeath
	#else
		#define _ALS_OnPlayerDeath
	#endif
	#define OnPlayerDeath FAC_OnPlayerDeath
	#if defined FAC_OnPlayerDeath
		forward FAC_OnPlayerDeath(playerid, killerid, reason);
	#endif

	#if defined _ALS_OnPlayerStateChange
		#undef OnPlayerStateChange
	#else
		#define _ALS_OnPlayerStateChange
	#endif
	#define OnPlayerStateChange FAC_OnPlayerStateChange
	#if defined FAC_OnPlayerStateChange
		forward FAC_OnPlayerStateChange(playerid, newstate, oldstate);
	#endif

	#if defined _ALS_OnPlayerKeyStateChange
		#undef OnPlayerKeyStateChange
	#else
		#define _ALS_OnPlayerKeyStateChange
	#endif
	#define OnPlayerKeyStateChange FAC_OnPlayerKeyStateChange
	#if defined FAC_OnPlayerKeyStateChange
		forward FAC_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	#endif

	#if defined _ALS_OnPlayerWeaponShot
		#undef OnPlayerWeaponShot
	#else 
		#define _ALS_OnPlayerWeaponShot
	#endif
	#define OnPlayerWeaponShot FAC_OnPlayerWeaponShot
	#if defined FAC_OnPlayerWeaponShot
		forward FAC_OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ);
	#endif
	
	#if defined _ALS_OnPlayerTakeDamage
		#undef OnPlayerTakeDamage
	#else 
		#define _ALS_OnPlayerTakeDamage
	#endif
	#define OnPlayerTakeDamage FAC_OnPlayerTakeDamage
	#if defined FAC_OnPlayerTakeDamage
		forward FAC_OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart);
	#endif


	#if defined _ALS_OnPlayerSpawn
		#undef OnPlayerSpawn
	#else
		#define _ALS_OnPlayerSpawn
	#endif
	#define OnPlayerSpawn FAC_OnPlayerSpawn
	#if defined FAC_OnPlayerSpawn
		forward FAC_OnPlayerSpawn(playerid);
	#endif

	#if defined _ALS_OnPlayerGiveDamage
		#undef OnPlayerGiveDamage
	#else
		#define _ALS_OnPlayerGiveDamage
	#endif
	#define OnPlayerGiveDamage FAC_OnPlayerGiveDamage
	#if defined FAC_OnPlayerGiveDamage
		forward FAC_OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid);
	#endif

	#if defined _ALS_OnPlayerUpdate
		#undef OnPlayerUpdate
	#else
		#define _ALS_OnPlayerUpdate
	#endif
	#define OnPlayerUpdate FAC_OnPlayerUpdate
	#if defined FAC_OnPlayerUpdate
		forward FAC_OnPlayerUpdate(playerid);
	#endif

	#if defined _ALS_OnPlayerText
		#undef OnPlayerText
	#else
		#define _ALS_OnPlayerText
	#endif
	#define OnPlayerText FAC_OnPlayerText
	#if defined FAC_OnPlayerText
		forward FAC_OnPlayerText(playerid, text[]);
	#endif

	#if defined _ALS_OnPlayerCommandText
		#undef OnPlayerCommandText
	#else
		#define _ALS_OnPlayerCommandText
	#endif
	#define OnPlayerCommandText FAC_OnPlayerCommandText
	#if defined FAC_OnPlayerCommandText
		forward FAC_OnPlayerCommandText(playerid, cmdtext[]);
	#endif
#endif

// Functions
#if defined _ALS_GivePlayerWeapon 
	#undef GivePlayerWeapon
#else
	#define _ALS_GivePlayerWeapon
#endif
#define GivePlayerWeapon FAC_GivePlayerWeapon

#if defined _ALS_SetPlayerAmmo
	#undef SetPlayerAmmo
#else 
	#define _ALS_SetPlayerAmmo
#endif
#define SetPlayerAmmo FAC_SetPlayerAmmo

#if defined _ALS_ResetPlayerWeapons
	#undef ResetPlayerWeapons
#else
	#define _ALS_ResetPlayerWeapons
#endif
#define ResetPlayerWeapons FAC_ResetPlayerWeapons

#if defined _ALS_ResetPlayerMoney
	#undef ResetPlayerMoney
#else
	#define _ALS_ResetPlayerMoney
#endif
#define ResetPlayerMoney FAC_ResetPlayerMoney

#if defined _ALS_GivePlayerMoney
	#undef GivePlayerMoney
#else
	#define _ALS_GivePlayerMoney
#endif
#define GivePlayerMoney FAC_GivePlayerMoney

#if defined _ALS_GetPlayerMoney
	#undef GetPlayerMoney
#else
	#define _ALS_GetPlayerMoney
#endif
#define GetPlayerMoney FAC_GetPlayerMoney

#if defined _ALS_RepairVehicle
	#undef RepairVehicle
#else
	#define _ALS_RepairVehicle
#endif
#define RepairVehicle FAC_RepairVehicle	

#if defined _ALS_SetVehicleToRespawn
	#undef SetVehicleToRespawn
#else
	#define _ALS_SetVehicleToRespawn
#endif
#define SetVehicleToRespawn FAC_SetVehicleToRespawn	

#if defined _ALS_ChangeVehicleColor
	#undef ChangeVehicleColor
#else
	#define _ALS_ChangeVehicleColor
#endif
#define ChangeVehicleColor FAC_ChangeVehicleColor	



#if defined _ALS_CreateVehicle
	#undef CreateVehicle
#else
	#define _ALS_CreateVehicle
#endif
#define CreateVehicle FAC_CreateVehicle	

#if defined _ALS_PutPlayerInVehicle
	#undef PutPlayerInVehicle
#else
	#define _ALS_PutPlayerInVehicle
#endif
#define PutPlayerInVehicle FAC_PutPlayerInVehicle	

#if defined _ALS_TogglePlayerControllable
	#undef TogglePlayerControllable
#else
	#define _ALS_TogglePlayerControllable
#endif
#define TogglePlayerControllable FAC_TogglePlayerControllable	

#if defined _ALS_TogglePlayerSpectating
	#undef TogglePlayerSpectating
#else
	#define _ALS_TogglePlayerSpectating
#endif
#define TogglePlayerSpectating FAC_TogglePlayerSpectating	


#if defined _ALS_SetVehicleHealth
	#undef SetVehicleHealth
#else
	#define _ALS_SetVehicleHealth
#endif
#define SetVehicleHealth FAC_SetVehicleHealth

#if defined _ALS_SetPlayerHealth
	#undef SetPlayerHealth
#else
	#define _ALS_SetPlayerHealth
#endif
#define SetPlayerHealth FAC_SetPlayerHealth

#if defined _ALS_SetPlayerArmour
	#undef SetPlayerArmour
#else
	#define _ALS_SetPlayerArmour
#endif
#define SetPlayerArmour FAC_SetPlayerArmour

#if defined _ALS_GetPlayerHealth
	#undef GetPlayerHealth
#else
	#define _ALS_GetPlayerHealth
#endif
#define GetPlayerHealth FAC_GetPlayerHealth

#if defined _ALS_GetPlayerArmour
	#undef GetPlayerArmour
#else
	#define _ALS_GetPlayerArmour
#endif
#define GetPlayerArmour FAC_GetPlayerArmour

#if defined _ALS_ShowPlayerDialog
	#undef ShowPlayerDialog
#else 
	#define _ALS_ShowPlayerDialog
#endif 
#define ShowPlayerDialog FAC_ShowPlayerDialog

#if defined _ALS_SetPlayerSpecialAction
	#undef SetPlayerSpecialAction
#else 
	#define _ALS_SetPlayerSpecialAction
#endif
#define SetPlayerSpecialAction FAC_SetPlayerSpecialAction

#if defined _ALS_SetPlayerPos 
	#undef SetPlayerPos 
#else 
	#define _ALS_SetPlayerPos
#endif
#define SetPlayerPos FAC_SetPlayerPos

#if defined _ALS_SetPlayerVirtualWorld 
	#undef SetPlayerVirtualWorld 
#else 
	#define _ALS_SetPlayerVirtualWorld
#endif
#define SetPlayerVirtualWorld FAC_SetPlayerVirtualWorld

#if defined _ALS_SetPlayerInterior 
	#undef SetPlayerInterior 
#else 
	#define _ALS_SetPlayerInterior
#endif
#define SetPlayerInterior FAC_SetPlayerInterior

#if defined _ALS_SpawnPlayer
	#undef SpawnPlayer
#else 
	#define _ALS_SpawnPlayer
#endif 
#define SpawnPlayer FAC_SpawnPlayer

#if defined _ALS_SetVehiclePos
	#undef SetVehiclePos
#else 
	#define _ALS_SetVehiclePos
#endif 
#define SetVehiclePos FAC_SetVehiclePos

#if defined _ALS_RemovePlayerFromVehicle
	#undef RemovePlayerFromVehicle
#else 
	#define _ALS_RemovePlayerFromVehicle
#endif 
#define RemovePlayerFromVehicle FAC_RemovePlayerFromVehicle

#if defined _ALS_CancelVehicleEnter
	#undef CancelVehicleEnter
#else 
	#define _ALS_CancelVehicleEnter
#endif 
#define CancelVehicleEnter FAC_CancelVehicleEnter

#undef AC_playerloop
#undef AC_vehicleloop
#undef AC_MAJOR
#undef AC_MINOR
#undef AC_REVISION
#undef AC_SHAKE
#undef AC_FULL_VERSION

#pragma unused 	BustAim_g_WeaponRange, FAC_aimInt_DCTTL, FAC_aimInt_GXYIFOP, FAC_aimInt_IsCameraAimingAt,\
				_FAC_IsPlayerStatePlaying, _FAC_IsPlayerStateVehicle, ac__Aim_LastWeapon, ac__Joins