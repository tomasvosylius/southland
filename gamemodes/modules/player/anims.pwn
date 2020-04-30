#include <YSI\y_hooks>

static 
    bool:player_UsingLoopAnim[MAX_PLAYERS],
	bool:player_UsingSingleAnim[MAX_PLAYERS],
	player_UsingBackAnim[MAX_PLAYERS];

hook OnPlayerConnect(playerid)
{
	player_UsingBackAnim[playerid] = 0;
    player_UsingLoopAnim[playerid] = 
	player_UsingSingleAnim[playerid] = false;
    return 1;
}

CMD:sup(playerid, params[])
{
	new receiverid, type;
	if(sscanf(params,"ud",receiverid,type) || !(1 <= type <= 3) || playerid == receiverid) return SendUsage(playerid, "/sup [þaidëjas] [1-3]");
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return InfoBox(playerid, IB_GET_OUT_VEHICLE);
	if(!IsPlayerInRangeOfPlayer(playerid, receiverid, 3.5)) return InfoBox(playerid, IB_NOT_CLOSE_PLAYER);
	SendFormat(playerid, 0xFFFFFFFF, "Pasiûlëte pasisveikinimà þaidëjui %s.", GetPlayerNameEx(receiverid, true));
	SendFormat(receiverid, 0xFFFFFFFF, "%s siûlo jums pasisveikinimà. Naudokite /acceptsup", GetPlayerNameEx(playerid, true));
	Offer[receiverid][0] = OFFER_TYPE_SUP;
	Offer[receiverid][1] = playerid;
	Offer[receiverid][3] = type;
	return 1;
}
CMD:acceptsup(playerid, params[])
{
	new owner = Offer[playerid][1],
		type = Offer[playerid][3];
	if(Offer[playerid][0] != OFFER_TYPE_SUP) return SendWarning(playerid, "Jums niekas nesiûlo pasisveikinti.");
	if(!IsPlayerConnected(owner) || !IsPlayerInRangeOfPlayer(playerid, owner, 3.5))
	{
		Offer[playerid][0] = 0;
		return InfoBox(playerid, IB_NOT_CLOSE_PLAYER);
	}
	else
	{
		new Float:x,
			Float:y,
			Float:z,
			Float:a;

		GetPlayerPos(owner, x, y, z);
		GetPlayerFacingAngle(owner, a);

		x += (0.8 * floatsin(-a, degrees));
		y += (0.8 * floatcos(-a, degrees));

		SetPlayerPos(playerid, x, y, z);
		SetPlayerFacingAngle(playerid, a+180);
		switch(type)
		{
			case 1:
			{
		   		ApplyAnimation_Single(owner,"GANGS","hndshkba", 4.0, false, false, false, false, false);
				ApplyAnimation_Single(playerid,"GANGS","hndshkba", 4.0, false, false, false, false, false);
			}
 			case 2:
 			{
 		   		ApplyAnimation_Single(owner,"GANGS","hndshkda", 4.0, false, false, false, false, false);
	 			ApplyAnimation_Single(playerid,"GANGS","hndshkda", 4.0, false, false, false, false, false);
			}
  			case 3:
  			{
  		   		ApplyAnimation_Single(owner,"GANGS","hndshkfa_swt", 4.0, false, false, false, false, false);
		  		ApplyAnimation_Single(playerid,"GANGS","hndshkfa_swt", 4.0, false, false, false, false, false);
			}
		}
		Offer[playerid][0] = 0;
	}
	return 1;
}

alias:stopanim("sa");
CMD:stopanim(playerid, params[])
{
	new specialAction = GetPlayerSpecialAction(playerid);

	if(player_UsingSingleAnim[playerid] == true)
	{
		ClearAnimations(playerid);
		player_UsingSingleAnim[playerid] = false;
	}
	else if(player_UsingLoopAnim[playerid] == true)
	{
		StopLoopAnim(playerid);
	}
	else if(player_UsingBackAnim[playerid] != 0)
	{
		switch(player_UsingBackAnim[playerid])
		{
			case 1:
			{
				ApplyAnimation(playerid,"PED","seat_up",3.0,0,0,0,0,0);
			}
		}
		player_UsingBackAnim[playerid] = 0;
	}

	// Atiduodam cigarete/buteli atgal
	switch(specialAction)
	{
		case 	SPECIAL_ACTION_USECELLPHONE, SPECIAL_ACTION_SMOKE_CIGGY, SPECIAL_ACTION_DRINK_BEER,\
				SPECIAL_ACTION_DRINK_SPRUNK, SPECIAL_ACTION_DRINK_WINE:
		{
			SetPlayerSpecialAction(playerid, specialAction);
		}
	}
	return 1;
}

stock StopLoopAnim(playerid)
{
	ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	player_UsingLoopAnim[playerid] = false;
	return 1;
}

stock ApplyAnimation_Loop(playerid, animlib[], animname[], Float:speed, bool:loop, bool:lockx, bool:locky, bool:freeze, time, forcesync = 1)
{
	ApplyAnimation(playerid, animlib, animname, speed, loop, lockx, locky, freeze, time, forcesync);
	player_UsingLoopAnim[playerid] = true;
	UI_LeftBox_Show(playerid, "Sustabdyti animacija gali parases ~r~/stopanim", .time = 3);
	return 1;
}

stock ApplyAnimation_Single(playerid, animlib[], animname[], Float:speed, bool:loop, bool:lockx, bool:locky, bool:freeze, time, forcesync = 1)
{
	ApplyAnimation(playerid, animlib, animname, speed, loop, lockx, locky, freeze, time, forcesync);
	player_UsingSingleAnim[playerid] = true;
	UI_LeftBox_Show(playerid, "Sustabdyti animacija gali parases ~r~/stopanim", .time = 3);
	return 1;
}

stock ApplyAnimation_Back(playerid, animlib[], animname[], Float:speed, bool:loop, bool:lockx, bool:locky, bool:freeze, time, forcesync = 1, back)
{
	ApplyAnimation(playerid, animlib, animname, speed, loop, lockx, locky, freeze, time, forcesync);
	player_UsingBackAnim[playerid] = back;
	UI_LeftBox_Show(playerid, "Sustabdyti animacija gali parases ~r~/stopanim", .time = 3);
	return 1;
}

hook OnPlayerSpawnFirstTime(playerid)
{
    SendFormat(playerid, -1, "Preloading anims");
    PreloadAnimsForPlayer(playerid);
    return 1;
}

stock PreloadAnimsForPlayer(playerid)
{
	PreloadAnimLib(playerid,"AIRPORT");
	PreloadAnimLib(playerid,"Attractors");
	PreloadAnimLib(playerid,"BAR");
	PreloadAnimLib(playerid,"BASEBALL");
	PreloadAnimLib(playerid,"BD_FIRE");
	PreloadAnimLib(playerid,"BOX");
	PreloadAnimLib(playerid,"BSKTBALL");
	PreloadAnimLib(playerid,"BUDDY");
	PreloadAnimLib(playerid,"BUS");
	PreloadAnimLib(playerid,"CAMERA");
	PreloadAnimLib(playerid,"CAR");
	PreloadAnimLib(playerid,"CAR_CHAT");
	PreloadAnimLib(playerid,"CASINO");
	PreloadAnimLib(playerid,"COACH");
	PreloadAnimLib(playerid,"COLT45");
	PreloadAnimLib(playerid,"DANCING");
	PreloadAnimLib(playerid,"DILDO");
	PreloadAnimLib(playerid,"FAT");
	PreloadAnimLib(playerid,"FIGHT_B");
	PreloadAnimLib(playerid,"FIGHT_C");
	PreloadAnimLib(playerid,"FIGHT_D");
	PreloadAnimLib(playerid,"FIGHT_E");
	PreloadAnimLib(playerid,"FINALE");
	PreloadAnimLib(playerid,"GANGS");
	PreloadAnimLib(playerid,"GHANDS");
	PreloadAnimLib(playerid,"GHETTO_DB");
	PreloadAnimLib(playerid,"GRAFFITI");
	PreloadAnimLib(playerid,"GRAVEYARD");
	PreloadAnimLib(playerid,"GRENADE");
	PreloadAnimLib(playerid,"GYMNASIUM");
	PreloadAnimLib(playerid,"HAIRCUTS");
	PreloadAnimLib(playerid,"INT_HOUSE");
	PreloadAnimLib(playerid,"INT_OFFICE");
	PreloadAnimLib(playerid,"INT_SHOP");
	PreloadAnimLib(playerid,"JST_BUISNESS");
	PreloadAnimLib(playerid,"KISSING");
	PreloadAnimLib(playerid,"KNIFE");
	PreloadAnimLib(playerid,"LOWRIDER");
	PreloadAnimLib(playerid,"MEDIC");
	PreloadAnimLib(playerid,"MISC");
	PreloadAnimLib(playerid,"MUSCULAR");
	PreloadAnimLib(playerid,"OTB");
	PreloadAnimLib(playerid,"PAULNMAC");
	PreloadAnimLib(playerid,"PED");
	PreloadAnimLib(playerid,"PLAYIDLES");
	PreloadAnimLib(playerid,"POLICE");
	PreloadAnimLib(playerid,"RIOT");
	PreloadAnimLib(playerid,"ROB_BANK");
	PreloadAnimLib(playerid,"RYDER");
	PreloadAnimLib(playerid,"SILENCED");
	PreloadAnimLib(playerid,"SPRAYCAN");
	PreloadAnimLib(playerid,"STRIP");
	PreloadAnimLib(playerid,"SWEET");
	PreloadAnimLib(playerid,"SWORD");
	PreloadAnimLib(playerid,"TEC");
	PreloadAnimLib(playerid,"VAN");
	PreloadAnimLib(playerid,"WUZI");
	PreloadAnimLib(playerid,"BOMBER");
	PreloadAnimLib(playerid,"RAPPING");
	PreloadAnimLib(playerid,"SHOP");
	PreloadAnimLib(playerid,"BEACH");
	PreloadAnimLib(playerid,"SMOKING");
	PreloadAnimLib(playerid,"ON_LOOKERS");
	PreloadAnimLib(playerid,"DEALER");
	PreloadAnimLib(playerid,"CRACK");
	PreloadAnimLib(playerid,"CARRY");
	PreloadAnimLib(playerid,"COP_AMBIENT");
	PreloadAnimLib(playerid,"PARK");
	PreloadAnimLib(playerid,"FOOD");
	return 1;
}
stock PreloadAnimLib(playerid, animlib[])
{
    ApplyAnimation(playerid, animlib, "null", 0.0, 0, 0, 0, 0, 0);
}

/*
====================================
ANIMS
====================================
*/

flags:pullout(CMD_TYPE_ANIMATION);
CMD:pullout(playerid, params[])
{
	ApplyAnimation_Single(playerid, "AIRPORT", "THRW_BARL_THRW", 4.1, false, false, false, false, 0, false);
	return 1;
}
flags:giveglass(CMD_TYPE_ANIMATION);
CMD:giveglass(playerid, params[])
{
	ApplyAnimation_Single(playerid, "BAR", "BARSERVE_GIVE", 4.1, false, false, false, false, 0, false);
	return 1;
}
flags:filling(CMD_TYPE_ANIMATION);
CMD:filling(playerid, params[])
{
	ApplyAnimation_Single(playerid, "BAR", "BARSERVE_GLASS", 4.1, false, false, false, false, 0, false);
	return 1;
}
flags:drink(CMD_TYPE_ANIMATION);
CMD:drink(playerid, params[])
{
	ApplyAnimation_Single(playerid, "BAR", "DNK_STNDF_LOOP", 4.1, false, false, false, false, 0, false);
	return 1;
}
flags:start(CMD_TYPE_ANIMATION);
CMD:start(playerid, params[])
{
	ApplyAnimation_Single(playerid, "CAR", "FLAG_DROP", 4.1, false, false, false, false, 0, false);
	return 1;
}
flags:liftup(CMD_TYPE_ANIMATION);
CMD:liftup(playerid, params[])
{
	ApplyAnimation_Single(playerid, "CARRY", "LIFTUP", 4.1, false, true, true, true, 0, false);
	return 1;
}
flags:take(CMD_TYPE_ANIMATION);
CMD:take(playerid, params[])
{
	ApplyAnimation_Single(playerid, "CASINO", "DEALONE", 2.0, false, false, false, false, 0, false);
	return 1;
}
flags:crossarms(CMD_TYPE_ANIMATION);
CMD:crossarms(playerid, params[])
{
	ApplyAnimation_Single(playerid, "COP_AMBIENT", "COPLOOK_LOOP", 4.1, true, false, false, false, 0, 1);
	return 1;
}
flags:think(CMD_TYPE_ANIMATION);
CMD:think(playerid, params[])
{
	ApplyAnimation_Single(playerid, "COP_AMBIENT", "COPLOOK_THINK", 4.1, false, false, false, false, 0, false);
	return 1;
}
flags:paying(CMD_TYPE_ANIMATION);
CMD:paying(playerid, params[])
{
	ApplyAnimation_Single(playerid, "DEALER", "SHOP_PAY", 4.1, false, false, false, false, 0, false);
	return 1;
}
flags:punch(CMD_TYPE_ANIMATION);
CMD:punch(playerid, params[])
{
	ApplyAnimation_Single(playerid, "FIGHT_D", "FIGHTD_M", 4.1, false, false, false, false, 0, false);
	return 1;
}
flags:underbar(CMD_TYPE_ANIMATION);
CMD:underbar(playerid, params[])
{
	ApplyAnimation_Single(playerid, "FINALE", "FIN_COP1_LOOP", 4.1, false, true, true, true, 0, false);
	return 1;
}
flags:rubhands(CMD_TYPE_ANIMATION);
CMD:rubhands(playerid, params[])
{
	ApplyAnimation_Single(playerid, "FREEWEIGHTS", "GYM_FREE_PICKUP", 3.1, false, false, false, false, 0, false);
	return 1;
}
flags:throw(CMD_TYPE_ANIMATION);
CMD:throw(playerid, params[])
{
	ApplyAnimation_Single(playerid, "GRENADE", "WEAPON_THROW", 3.1, false, false, false, false, 0, false);
	return 1;
}
flags:wash(CMD_TYPE_ANIMATION);
CMD:wash(playerid, params[])
{
	ApplyAnimation_Loop(playerid, "INT_HOUSE", "WASH_UP", 4.1, true, false, false, false, 0, 1);
	return 1;
}
flags:backstab(CMD_TYPE_ANIMATION);
CMD:backstab(playerid, params[])
{
	ApplyAnimation_Single(playerid, "KNIFE", "KILL_KNIFE_PLAYER", 4.1, false, false, false, false, 0, false);
	return 1;
}
flags:stab(CMD_TYPE_ANIMATION);
CMD:stab(playerid, params[])
{
	ApplyAnimation_Single(playerid, "KNIFE", "KNIFE_4", 4.1, false, false, false, false, 0, false);
	return 1;
}
flags:saywhat(CMD_TYPE_ANIMATION);
CMD:saywhat(playerid, params[])
{
	ApplyAnimation_Single(playerid, "LOWRIDER", "PRTIAL_GNGTLKH", 4.1, false, false, false, false, 0, false);
	return 1;
}
flags:medic(CMD_TYPE_ANIMATION);
CMD:medic(playerid, params[])
{
	ApplyAnimation_Single(playerid, "MEDIC", "CPR", 4.1, false, false, false, false, 0, false);
	return 1;
}
flags:bitchslap(CMD_TYPE_ANIMATION);
CMD:bitchslap(playerid, params[])
{
	ApplyAnimation_Single(playerid, "MISC", "BITCHSLAP", 3.1, false, false, false, false, 0, false);
	return 1;
}
flags:righthand(CMD_TYPE_ANIMATION);
CMD:righthand(playerid, params[])
{
	ApplyAnimation_Single(playerid, "MISC", "HIKER_POSE", 3.1, false, true, true, true, 0, false);
	return 1;
}
flags:lefthand(CMD_TYPE_ANIMATION);
CMD:lefthand(playerid, params[])
{
	ApplyAnimation_Single(playerid, "MISC", "HIKER_POSE_L", 3.1, false, true, true, true, 0, false);
	return 1;
}
flags:facepalm(CMD_TYPE_ANIMATION);
CMD:facepalm(playerid, params[])
{
	ApplyAnimation_Single(playerid, "MISC", "PLYR_SHKHEAD", 4.1, false, false, false, false, 0, false);
	return 1;
}
flags:scratchballs(CMD_TYPE_ANIMATION);
CMD:scratchballs(playerid, params[])
{
	ApplyAnimation_Single(playerid, "MISC", "SCRATCHBALLS_01", 4.1, false, false, false, false, 0, false);
	return 1;
}
flags:signdocument(CMD_TYPE_ANIMATION);
CMD:signdocument(playerid, params[])
{
	ApplyAnimation_Single(playerid, "OTB", "BETSLP_LKABT", 4.1, false, false, false, false, 0, false);
	return 1;
}
flags:wank(CMD_TYPE_ANIMATION);
CMD:wank(playerid, params[])
{
	ApplyAnimation_Loop(playerid, "PAULNMAC", "wank_loop", 4.1, true, true, true, true, 0, 1);
	return 1;
}
flags:arrestgun(CMD_TYPE_ANIMATION);
CMD:arrestgun(playerid, params[])
{
	ApplyAnimation_Single(playerid, "PED", "ARRESTGUN", 3.0, true, true, true, true, 0, 1);
	return 1;
}
flags:eatgum(CMD_TYPE_ANIMATION);
CMD:eatgum(playerid, params[])
{
	ApplyAnimation_Single(playerid, "PED", "GUM_EAT", 4.1, false, false, false, false, 0, false);
	return 1;
}
flags:slowdown(CMD_TYPE_ANIMATION);
CMD:slowdown(playerid, params[])
{
	ApplyAnimation_Single(playerid, "PED", "HANDSCOWER", 4.1, false, true, true, true, 0, false);
	return 1;
}
flags:seat(CMD_TYPE_ANIMATION);
CMD:seat(playerid, params[])
{
	ApplyAnimation_Loop(playerid, "PED", "SEAT_IDLE", 4.1, true, false, false, false, 0, 1);
	return 1;
}
flags:turnaround(CMD_TYPE_ANIMATION);
CMD:turnaround(playerid, params[])
{
	ApplyAnimation_Single(playerid, "PED", "TURN_180", 3.1, false, true, true, true, 0, false);
	return 1;
}
flags:stretch(CMD_TYPE_ANIMATION);
CMD:stretch(playerid, params[])
{
	ApplyAnimation_Single(playerid, "PLAYIDLES", "STRETCH", 4.1, false, false, false, false, 0, false);
	return 1;
}
flags:watchclock(CMD_TYPE_ANIMATION);
CMD:watchclock(playerid, params[])
{
	ApplyAnimation_Single(playerid, "PLAYIDLES", "TIME", 4.1, false, false, false, false, 0, false);
	return 1;
}
flags:astop(CMD_TYPE_ANIMATION);
CMD:astop(playerid, params[])
{
	ApplyAnimation_Loop(playerid, "POLICE", "COPTRAF_STOP", 4.1, true, false, false, false, 0, 1);
	return 1;
}
flags:laugh(CMD_TYPE_ANIMATION);
CMD:laugh(playerid, params[])
{
	ApplyAnimation_Single(playerid, "RAPPING", "LAUGH_01", 4.1, false, false, false, false, 0, false);
	return 1;
}
flags:gogo(CMD_TYPE_ANIMATION);
CMD:gogo(playerid, params[])
{
	ApplyAnimation_Single(playerid, "RIOT", "RIOT_CHANT", 4.1, false, false, false, false, 0, false);
	return 1;
}
flags:comeatme(CMD_TYPE_ANIMATION);
CMD:comeatme(playerid, params[])
{
	ApplyAnimation_Single(playerid, "RYDER", "RYD_BECKON_02", 4.1, false, false, false, false, 0, false);
	return 1;
}
flags:reloadpistol(CMD_TYPE_ANIMATION);
CMD:reloadpistol(playerid, params[])
{
	ApplyAnimation_Single(playerid, "SILENCED", "SILENCE_RELOAD", 4.1, false, false, false, false, 0, false);
	return 1;
}
flags:lightup(CMD_TYPE_ANIMATION);
CMD:lightup(playerid, params[])
{
	ApplyAnimation_Single(playerid, "SMOKING", "M_SMK_IN", 4.1, false, false, false, false, 0, false);
	return 1;
}
flags:dropashes(CMD_TYPE_ANIMATION);
CMD:dropashes(playerid, params[])
{
	ApplyAnimation_Single(playerid, "SMOKING", "M_SMK_TAP", 4.1, false, false, false, false, 0, false);
	return 1;
}

flags:slapass(CMD_TYPE_ANIMATION);
CMD:slapass(playerid, params[])
{
	ApplyAnimation_Single(playerid, "SWEET", "SWEET_ASS_SLAP", 4.1, false, false, false, false, 0, false);
	return 1;
}
flags:lookthere(CMD_TYPE_ANIMATION);
CMD:lookthere(playerid, params[])
{
	ApplyAnimation_Single(playerid, "TEC", "TEC_FIRE", 2.0, false, true, true, true, 0, false);
	return 1;
}
flags:dead(CMD_TYPE_ANIMATION);
CMD:dead(playerid, params[])
{
	ApplyAnimation_Loop(playerid, "WUZI", "CS_DEAD_GUY", 4.1, true, true, true, true, 0, 1);
	return 1;
}

// angry
flags:angry(CMD_TYPE_ANIMATION);
CMD:angry(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 2) return SendUsage(playerid, "/angry [1-2]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "RIOT", "RIOT_ANGRY", 4.1, false, false, false, false, 0, false);
		case 2: ApplyAnimation_Single(playerid, "RIOT", "RIOT_CHALLENGE", 4.1, false, false, false, false, 0, false);
	}
	return 1;
}

// robbery
flags:robbery(CMD_TYPE_ANIMATION);
CMD:robbery(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 3) return SendUsage(playerid, "/robbery [1-3]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "ROB_BANK", "CAT_SAFE_ROB", 4.1, false, false, false, false, 0, false);
		case 2: ApplyAnimation_Single(playerid, "SHOP", "ROB_LOOP", 4.1, false, true, true, true, 0, false);
		case 3: ApplyAnimation_Single(playerid, "SHOP", "ROB_LOOP_THREAT", 4.1, false, true, true, true, 0, false);
	}
	return 1;
}

// cop
flags:cop(CMD_TYPE_ANIMATION);
CMD:cop(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 2) return SendUsage(playerid, "/cop [1-2]");
	switch(id)
	{
		case 1: ApplyAnimation_Loop(playerid, "POLICE", "COPTRAF_AWAY", 4.1, true, false, false, false, 0, 1);
		case 2: ApplyAnimation_Loop(playerid, "POLICE", "COPTRAF_COME", 4.1, true, false, false, false, 0, 1);
	}
	return 1;
}

// stripclub
flags:stripclub(CMD_TYPE_ANIMATION);
CMD:stripclub(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 2) return SendUsage(playerid, "/stripclub [1-2]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "STRIP", "PLY_CASH", 4.1, false, false, false, false, 0, false);
		case 2: ApplyAnimation_Single(playerid, "STRIP", "PUN_HOLLER", 4.1, false, false, false, false, 0, false);
	}
	return 1;
}
// stripper
flags:stripper(CMD_TYPE_ANIMATION);
CMD:stripper(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 8) return SendUsage(playerid, "/stripper [1-8]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "STRIP", "STRIP_E", 4.1, false, true, true, true, 0, false);
		case 2: ApplyAnimation_Single(playerid, "STRIP", "STRIP_F", 4.1, false, true, true, true, 0, false);
		case 3: ApplyAnimation_Single(playerid, "STRIP", "STRIP_G", 4.1, false, true, true, true, 0, false);
		case 4: ApplyAnimation_Single(playerid, "STRIP", "STR_A2B", 4.1, false, true, true, true, 0, false);
		case 5: ApplyAnimation_Single(playerid, "STRIP", "STR_B2A", 2.0, false, true, true, true, 0, false);
		case 6: ApplyAnimation_Single(playerid, "STRIP", "STR_B2C", 4.1, false, true, true, true, 0, false);
		case 7: ApplyAnimation_Single(playerid, "STRIP", "STR_C1", 4.1, false, true, true, true, 0, false);
		case 8: ApplyAnimation_Single(playerid, "STRIP", "STR_LOOP_A", 4.1, false, true, true, true, 0, false);
	}
	return 1;
}

// sit
flags:sit(CMD_TYPE_ANIMATION);
CMD:sit(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 9) return SendUsage(playerid, "/sit [1-9]");
	switch(id)
	{
		case 1: ApplyAnimation_Back(playerid, "ATTRACTORS", "STEPSIT_LOOP", 4.1, true, false, false, false, 0, 1, 1);
		case 2: ApplyAnimation_Back(playerid, "BEACH", "PARKSIT_M_LOOP", 4.1, true, false, false, false, 0, 1, 1);
		case 3: ApplyAnimation_Back(playerid, "CRACK", "CRCKIDLE1", 4.1, true, false, false, false, 0, 1, 1);
		case 4: ApplyAnimation_Back(playerid, "HAIRCUTS", "BRB_SIT_LOOP", 4.1, true, true, true, true, 0, 1, 1);
		case 5: ApplyAnimation_Back(playerid, "INT_HOUSE", "LOU_LOOP", 4.1, true, false, false, false, 0, 1, 1);
		case 6: ApplyAnimation_Back(playerid, "INT_OFFICE", "OFF_SIT_CRASH", 4.1, true, false, false, false, 0, 1, 1);
		case 7: ApplyAnimation_Back(playerid, "LOWRIDER", "LRGIRL_IDLELOOP", 4.1, true, false, false, false, 0, 1, 1);
		case 8: ApplyAnimation_Back(playerid, "MISC", "SEAT_LR", 4.1, true, false, false, false, 0, 1, 1);
		case 9: ApplyAnimation_Back(playerid, "MISC", "SEAT_TALK_02", 4.1, true, false, false, false, 0, 1, 1);
	}
	return 1;
}
flags:sitdown(CMD_TYPE_ANIMATION);
CMD:sitdown(playerid, params[])
{
	ApplyAnimation_Single(playerid, "PED", "SEAT_DOWN", 4.1, false, true, true, true, 0, 1);
	return 1;
}
flags:situp(CMD_TYPE_ANIMATION);
CMD:situp(playerid, params[])
{
	ApplyAnimation_Single(playerid, "PED", "SEAT_UP", 4.1, false, false, false, false, 0, false);
	return 1;
}


// dancing
flags:dancing(CMD_TYPE_ANIMATION);
CMD:dancing(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 5) return SendUsage(playerid, "/dancing [1-5]");
	switch(id)
	{
		case 1: ApplyAnimation_Loop(playerid, "DANCING", "BD_CLAP", 4.1, true, false, false, false, 0, 1);
		case 2: ApplyAnimation_Loop(playerid, "DANCING", "DAN_DOWN_A", 4.1, true, false, false, false, 0, 1);
		case 3: ApplyAnimation_Loop(playerid, "WOP", "DANCE_LOOP", 4.1, true, false, false, false, 0, 1);
		case 4: ApplyAnimation_Loop(playerid, "GFUNK", "DANCE_LOOP", 4.1, true, false, false, false, 0, 1);
		case 5: ApplyAnimation_Loop(playerid, "RUNNINGMAN", "DANCE_LOOP", 4.1, true, false, false, false, 0, 1);
	}
	return 1;
}

// kata
flags:kata(CMD_TYPE_ANIMATION);
CMD:kata(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 6) return SendUsage(playerid, "/kata [1-6]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "SWORD", "SWORD_1", 4.1, false, true, true, true, 0, false);
		case 2: ApplyAnimation_Single(playerid, "SWORD", "SWORD_2", 4.1, false, true, true, true, 0, false);
		case 3: ApplyAnimation_Single(playerid, "SWORD", "SWORD_3", 4.1, false, true, true, true, 0, false);
		case 4: ApplyAnimation_Single(playerid, "SWORD", "SWORD_4", 4.1, false, false, false, false, 0, false);
		case 5: ApplyAnimation_Single(playerid, "SWORD", "SWORD_PART", 4.1, false, false, false, false, 0, false);
		case 6: ApplyAnimation_Loop(playerid, "SWORD", "SWORD_IDLE", 4.1, true, false, false, false, 0, 1);
	}
	return 1;
}


// lean
flags:lean(CMD_TYPE_ANIMATION);
CMD:lean(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 6) return SendUsage(playerid, "/lean [1-6]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "BAR", "BARMAN_IDLE", 4.1, false, true, true, true, 0, 1);
		case 2: ApplyAnimation_Loop(playerid, "BAR", "BARSERVE_LOOP", 4.1, true, false, false, false, 0, 1);
		case 3: ApplyAnimation_Single(playerid, "BD_FIRE", "BD_PANIC_02", 4.1, false, true, true, true, 0, 1);
		case 4: ApplyAnimation_Single(playerid, "GANGS", "LEANIDLE", 4.1, false, true, true, true, 0, 1);
		case 5: ApplyAnimation_Single(playerid, "JST_BUISNESS", "GIRL_02", 4.1, false, true, true, true, 0, 1);
		case 6: ApplyAnimation_Single(playerid, "MISC", "PLYRLEAN_LOOP", 4.1, false, true, true, true, 0, 1);
	}
	return 1;
}

CMD:charity(playerid, params[])
{
	new amount;
	if(sscanf(params,"d",amount) || amount < 0) return SendUsage(playerid, "/charity [kiekis]");
	if(sd_GetPlayerMoney(playerid) < amount) return InfoBox(playerid, IB_NOT_ENOUGH_MONEY, amount);

	sd_GivePlayerMoney(playerid, -amount);
	SendFormat(playerid, 0xb0df67ff, "Paaukojote $%d", amount);
	return 1;
}

// chat
flags:chat(CMD_TYPE_ANIMATION);
CMD:chat(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 9) return SendUsage(playerid, "/chat [1-9]");
	switch(id)
	{
		case 1: ApplyAnimation_Loop(playerid, "BAR", "BARCUSTOM_ORDER", 4.1, true, false, false, false, 0, 1);
		case 2: ApplyAnimation_Loop(playerid, "GANGS", "PRTIAL_GNGTLKA", 4.1, true, false, false, false, 0, 1);
		case 3: ApplyAnimation_Loop(playerid, "GANGS", "PRTIAL_GNGTLKB", 4.1, true, false, false, false, 0, 1);
		case 4: ApplyAnimation_Loop(playerid, "GANGS", "PRTIAL_GNGTLKC", 4.1, true, false, false, false, 0, 1);
		case 5: ApplyAnimation_Loop(playerid, "GANGS", "PRTIAL_GNGTLKD", 4.1, true, false, false, false, 0, 1);
		case 6: ApplyAnimation_Loop(playerid, "GANGS", "PRTIAL_GNGTLKE", 4.1, true, false, false, false, 0, 1);
		case 7: ApplyAnimation_Loop(playerid, "GANGS", "PRTIAL_GNGTLKF", 4.1, true, false, false, false, 0, 1);
		case 8: ApplyAnimation_Loop(playerid, "GANGS", "PRTIAL_GNGTLKG", 4.1, true, false, false, false, 0, 1);
		case 9: ApplyAnimation_Loop(playerid, "GANGS", "PRTIAL_GNGTLKH", 4.1, true, false, false, false, 0, 1);
	}
	return 1;
}

// takebeer
flags:takebeer(CMD_TYPE_ANIMATION);
CMD:takebeer(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 2) return SendUsage(playerid, "/takebeer [1-2]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "BAR", "BARCUSTOM_GET", 4.1, false, true, true, true, 0, false);
		case 2: ApplyAnimation_Single(playerid, "BAR", "BARSERVE_BOTTLE", 4.1, false, true, true, true, 0, false);
	}
	return 1;
}

// bat
flags:bat(CMD_TYPE_ANIMATION);
CMD:bat(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 6) return SendUsage(playerid, "/bat [1-6]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "BASEBALL", "BAT_1", 4.1, false, true, true, true, 0, false);
		case 2: ApplyAnimation_Single(playerid, "BASEBALL", "BAT_2", 4.1, false, true, true, true, 0, false);
		case 3: ApplyAnimation_Single(playerid, "BASEBALL", "BAT_3", 4.1, false, true, true, true, 0, false);
		case 4: ApplyAnimation_Single(playerid, "BASEBALL", "BAT_4", 4.1, false, true, true, true, 0, false);
		case 5: ApplyAnimation_Single(playerid, "CRACK", "BBALBAT_IDLE_01", 4.1, false, true, true, true, 0, false);
		case 6: ApplyAnimation_Single(playerid, "CRACK", "BBALBAT_IDLE_02", 4.1, false, true, true, true, 0, false);
	}
	return 1;
}

// wave
flags:wave(CMD_TYPE_ANIMATION);
CMD:wave(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 5) return SendUsage(playerid, "/wave [1-5]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "KISSING", "GFWAVE2", 4.1, false, false, false, false, 0, false);
		case 2: ApplyAnimation_Single(playerid, "BD_FIRE", "BD_GF_WAVE", 4.1, false, false, false, false, 0, false);
		case 3: ApplyAnimation_Single(playerid, "BD_FIRE", "BD_PANIC_01", 4.1, false, false, false, false, 0, false);
		case 4: ApplyAnimation_Single(playerid, "BD_FIRE", "BD_PANIC_03", 4.1, false, false, false, false, 0, false);
		case 5: ApplyAnimation_Single(playerid, "ON_LOOKERS", "WAVE_LOOP", 4.1, false, false, false, false, 0, false);
	}
	return 1;
}
// hurt
flags:hurt(CMD_TYPE_ANIMATION);
CMD:hurt(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 5) return SendUsage(playerid, "/hurt [1-5]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "BASEBALL", "BAT_HIT_1", 4.1, false, true, true, false, 0, false);
		case 2: ApplyAnimation_Single(playerid, "BASEBALL", "BAT_HIT_2", 4.1, false, true, true, false, 0, false);
		case 3: ApplyAnimation_Single(playerid, "BASEBALL", "BAT_HIT_3", 4.1, false, true, true, true, 0, false);
		case 4: ApplyAnimation_Single(playerid, "CRACK", "CRCKDETH1", 4.1, false, true, true, true, 0, false);
		case 5: ApplyAnimation_Single(playerid, "SWEET", "SWEET_INJUREDLOOP", 4.1, true, true, true, false, 0, false);
	}
	return 1;
}

// lay
flags:lay(CMD_TYPE_ANIMATION);
CMD:lay(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 5) return SendUsage(playerid, "/lay [1-5]");
	switch(id)
	{
		case 1: ApplyAnimation_Loop(playerid, "BEACH", "BATHER", 4.1, true, false, false, false, 0, 1);
		case 2: ApplyAnimation_Loop(playerid, "BEACH", "LAY_BAC_LOOP", 4.1, true, false, false, false, 0, 1);
		case 3: ApplyAnimation_Loop(playerid, "BEACH", "PARKSIT_W_LOOP", 4.1, true, false, false, false, 0, 1);
		case 4: ApplyAnimation_Loop(playerid, "BEACH", "SITNWAIT_LOOP_W", 4.1, true, false, false, false, 0, 1);
		case 5: ApplyAnimation_Loop(playerid, "CRACK", "CRCKIDLE4", 4.1, true, false, false, false, 0, 1);
	}
	return 1;
}

// smoke
flags:smoke(CMD_TYPE_ANIMATION);
CMD:smoke(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 7) return SendUsage(playerid, "/smoke [1-7]");
	switch(id)
	{
		case 1: ApplyAnimation_Loop(playerid, "BD_FIRE", "M_SMKLEAN_LOOP", 4.1, true, false, false, false, 0, 1);
		case 2: ApplyAnimation_Loop(playerid, "GANGS", "SMKCIG_PRTL", 4.1, true, false, false, false, 0, 1);
		case 3: ApplyAnimation_Loop(playerid, "GANGS", "SMKCIG_PRTL_F", 4.1, true, false, false, false, 0, 1);
		case 4: ApplyAnimation_Loop(playerid, "LOWRIDER", "F_SMKLEAN_LOOP", 4.1, true, true, true, true, 0, 1);
		case 5: ApplyAnimation_Loop(playerid, "LOWRIDER", "M_SMKSTND_LOOP", 4.1, true, false, false, false, 0, 1);
		case 6: ApplyAnimation_Loop(playerid, "LOWRIDER", "M_SMKLEAN_LOOP", 4.1, true, true, true, true, 0, 1);
		case 7: ApplyAnimation_Loop(playerid, "SMOKING", "M_SMK_DRAG", 4.1, true, false, false, false, 0, 1);
	}
	return 1;
}

// muscle
flags:muscle(CMD_TYPE_ANIMATION);
CMD:muscle(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 2) return SendUsage(playerid, "/muscle [1-2]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "BENCHPRESS", "GYM_BP_CELEBRATE", 4.1, false, false, false, false, 0, false);
		case 2: ApplyAnimation_Single(playerid, "FREEWEIGHTS", "GYM_FREE_CELEBRATE", 4.1, false, false, false, false, 0, false);
	}
	return 1;
}

// bomb
flags:bomb(CMD_TYPE_ANIMATION);
CMD:bomb(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 2) return SendUsage(playerid, "/bomb [1-2]");
	switch(id)
	{
		case 1: ApplyAnimation_Loop(playerid, "BOMBER", "BOM_PLANT", 4.1, true, true, true, true, 0, 1);
		case 2: ApplyAnimation_Loop(playerid, "BOMBER", "BOM_PLANT_2IDLE", 2.0, true, true, true, true, 0, 1);
	}
	return 1;
}

// put
flags:put(CMD_TYPE_ANIMATION);
CMD:put(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 2) return SendUsage(playerid, "/put [1-2]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "BOMBER", "BOM_PLANT_CROUCH_IN", 4.1, false, false, false, false, 0, false);
		case 2: ApplyAnimation_Single(playerid, "BOMBER", "BOM_PLANT_CROUCH_OUT", 4.1, false, false, false, false, 0, false);
	}
	return 1;
}

flags:putdown(CMD_TYPE_ANIMATION);
CMD:putdown(playerid, params[])
{
	ApplyAnimation_Single(playerid, "CARRY", "PUTDWN", 4.1, false, false, false, false, 0, false);
	return 1;
}

// takebox
flags:takebox(CMD_TYPE_ANIMATION);
CMD:takebox(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 2) return SendUsage(playerid, "/takebox [1-2]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "BOX", "BOXHIPIN", 4.1, false, false, false, false, 0, false);
		case 2: ApplyAnimation_Single(playerid, "BOX", "BOXHIPUP", 4.1, false, false, false, false, 0, false);
	}
	return 1;
}

// basket
flags:basket(CMD_TYPE_ANIMATION);
CMD:basket(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 3) return SendUsage(playerid, "/basket [1-3]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "BSKTBALL", "BBALL_DEF_JUMP_SHOT", 4.1, false, false, false, false, 0, false);
		case 2: ApplyAnimation_Single(playerid, "BSKTBALL", "BBALL_DEF_LOOP", 4.1, false, false, false, false, 0, false);
		case 3: ApplyAnimation_Single(playerid, "BSKTBALL", "BBALL_DNK", 4.1, false, false, false, false, 0, false);
	}
	return 1;
}

// box
flags:box(CMD_TYPE_ANIMATION);
CMD:box(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 4) return SendUsage(playerid, "/box [1-4]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "BOX", "CATCH_BOX", 2.0, false, true, true, false, 0, false);
		case 2: ApplyAnimation_Loop(playerid, "FIGHT_B", "FIGHTB_1", 4.1, true, true, true, false, 0, 1);
		case 3: ApplyAnimation_Loop(playerid, "FIGHT_B", "FIGHTB_2", 4.1, true, true, true, false, 0, 1);
		case 4: ApplyAnimation_Single(playerid, "GYMNASIUM", "GYMSHADOWBOX", 4.1, true, true, false, false, 0, false);
	}
	return 1;
}

// box
flags:boxstance(CMD_TYPE_ANIMATION);
CMD:boxstance(playerid, params[])
{
	ApplyAnimation_Loop(playerid, "FIGHT_B", "FIGHTB_IDLE", 4.1, true, false, false, false, 0, false);
	return 1;
}

// shotgun
flags:shotgun(CMD_TYPE_ANIMATION);
CMD:shotgun(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 5) return SendUsage(playerid, "/shotgun [1-5]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "BUDDY", "BUDDY_CROUCHFIRE", 4.1, false, true, true, true, 0, false);
		case 2: ApplyAnimation_Single(playerid, "BUDDY", "BUDDY_CROUCHRELOAD", 4.1, false, true, true, true, 0, false);
		case 3: ApplyAnimation_Single(playerid, "BUDDY", "BUDDY_FIRE", 4.1, false, true, true, true, 0, false);
		case 4: ApplyAnimation_Single(playerid, "BUDDY", "BUDDY_FIRE_POOR", 4.1, false, true, true, true, 0, false);
		case 5: ApplyAnimation_Single(playerid, "BUDDY", "BUDDY_RELOAD", 4.1, false, false, false, false, 0, false);
	}
	return 1;
}

// opendoor
flags:opendoor(CMD_TYPE_ANIMATION);
CMD:opendoor(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 5) return SendUsage(playerid, "/opendoor [1-5]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "BUS", "BUS_OPEN_RHS", 4.1, false, false, false, false, 0, 1);
		case 2: ApplyAnimation_Single(playerid, "COACH", "COACH_OPNL", 4.1, false, false, false, false, 0, 1);
		case 3: ApplyAnimation_Single(playerid, "COACH", "COACH_OPNR", 4.1, false, false, false, false, 0, 1);
		case 4: ApplyAnimation_Single(playerid, "PED", "SHOVE_PARTIAL", 4.1, false, false, false, false, 0, 1);
		case 5: ApplyAnimation_Single(playerid, "VAN", "VAN_OPEN_BACK_LHS", 4.1, false, false, false, false, 0, 1);
	}
	return 1;
}

// comeon
flags:comeon(CMD_TYPE_ANIMATION);
CMD:comeon(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 2) return SendUsage(playerid, "/comeon [1-2]");
	switch(id)
	{
		case 1: ApplyAnimation_Loop(playerid, "CAMERA", "CAMCRCH_CMON", 4.1, true, false, false, false, 0, 1);
		case 2: ApplyAnimation_Loop(playerid, "CAMERA", "CAMSTND_CMON", 4.1, true, false, false, false, 0, 1);
	}
	return 1;
}

// knees
flags:knees(CMD_TYPE_ANIMATION);
CMD:knees(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 4) return SendUsage(playerid, "/knees [1-4]");
	switch(id)
	{
		case 1: ApplyAnimation_Loop(playerid, "CAMERA", "PICCRCH_IN", 4.1, true, false, false, false, 0, 1);
		case 2: ApplyAnimation_Loop(playerid, "CAMERA", "PICCRCH_OUT", 4.1, true, false, false, false, 0, 1);
		case 3: ApplyAnimation_Loop(playerid, "CAMERA", "PICCRCH_TAKE", 4.1, true, false, false, false, 0, 1);
		case 4: ApplyAnimation_Loop(playerid, "COP_AMBIENT", "COPBROWSE_IN", 4.1, true, false, false, false, 0, 1);
	}
	return 1;
}

// car
flags:car(CMD_TYPE_ANIMATION);
CMD:car(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 9) return SendUsage(playerid, "/car [1-9]");
	switch(id)
	{
		case 1: ApplyAnimation_Loop(playerid, "CAR", "FIXN_CAR_LOOP", 4.1, true, true, true, true, 0, 1);
		case 2: ApplyAnimation_Loop(playerid, "CAR", "FIXN_CAR_OUT", 4.1, true, true, true, true, 0, 1);
		case 3: ApplyAnimation_Loop(playerid, "CAR", "TAP_HAND", 4.1, true, true, true, true, 0, 1);
		case 4: ApplyAnimation_Loop(playerid, "CAR_CHAT", "CARFONE_IN", 4.1, true, true, true, true, 0, 1);
		case 5: ApplyAnimation_Loop(playerid, "CAR_CHAT", "CARFONE_LOOPA", 4.1, true, true, true, true, 0, 1);
		case 6: ApplyAnimation_Loop(playerid, "CAR_CHAT", "CAR_SC1_BL", 4.1, true, true, true, true, 0, 1);
		case 7: ApplyAnimation_Loop(playerid, "CAR_CHAT", "CAR_SC1_FL", 4.1, true, true, true, true, 0, 1);
		case 8: ApplyAnimation_Loop(playerid, "CAR_CHAT", "CARFONE_LOOPB", 4.1, true, true, true, true, 0, 1);
		case 9: ApplyAnimation_Loop(playerid, "GHETTO_DB", "GDB_CAR2_PLY", 4.1, true, true, true, true, 0, 1);
	}
	return 1;
}

//  getup
flags:getup(CMD_TYPE_ANIMATION);
CMD:getup(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 2) return SendUsage(playerid, "/getup [1-2]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "ATTRACTORS", "STEPSIT_OUT", 4.1, false, false, false, false, 0, 1);
		case 2: ApplyAnimation_Single(playerid, "CAMERA", "CAMCRCH_TO_CAMSTND", 4.1, false, false, false, false, 0, 1);
	}
	return 1;
}

// won
flags:won(CMD_TYPE_ANIMATION);
CMD:won(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 2) return SendUsage(playerid, "/won [1-2]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "CASINO", "MANWINB", 4.1, false, false, false, false, 0, false);
		case 2: ApplyAnimation_Single(playerid, "CASINO", "MANWIND", 4.1, false, false, false, false, 0, false);
	}
	return 1;
}

// colt
flags:colt(CMD_TYPE_ANIMATION);
CMD:colt(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 2) return SendUsage(playerid, "/colt [1-2]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "COLT45", "COLT45_RELOAD", 4.1, false, true, true, true, 0, false);
		case 2: ApplyAnimation_Single(playerid, "COLT45", "COLT45_FIRE", 4.1, false, true, true, true, 0, false);
	}
	return 1;
}

// sawnoff
flags:sawnoff(CMD_TYPE_ANIMATION);
CMD:sawnoff(playerid, params[])
{
	ApplyAnimation_Single(playerid, "COLT45", "SAWNOFF_RELOAD", 4.1, false, false, false, false, 0, false);
	return 1;
}

// knife
flags:knife(CMD_TYPE_ANIMATION);
CMD:knife(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 5) return SendUsage(playerid, "/knife [1-5]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "DILDO", "DILDO_2", 4.1, false, true, true, true, 0, false);
		case 2: ApplyAnimation_Single(playerid, "DILDO", "DILDO_3", 4.1, false, true, true, true, 0, false);
		case 3: ApplyAnimation_Single(playerid, "DILDO", "DILDO_G", 4.1, false, true, true, true, 0, false);
		case 4: ApplyAnimation_Loop(playerid, "DILDO", "DILDO_IDLE", 4.1, true, false, false, false, 0, false);
		case 5: ApplyAnimation_Single(playerid, "KNIFE", "KNIFE_3", 4.1, false, true, true, true, 0, false);
	}
	return 1;
}

// grafiti
flags:spray(CMD_TYPE_ANIMATION);
CMD:spray(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 3) return SendUsage(playerid, "/spray [1-3]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "GRAFFITI", "SPRAYCAN_FIRE", 4.1, false, false, false, false, 0, false);
		case 2: ApplyAnimation_Single(playerid, "GRAFFITI", "GRAFFITI_CHKOUT", 4.1, false, false, false, false, 0, false);
		case 3: ApplyAnimation_Single(playerid, "SPRAYCAN", "SPRAYCAN_FULL", 4.1, false, false, false, false, 0, false);
	}
	return 1;
}

// crack
flags:crack(CMD_TYPE_ANIMATION);
CMD:crack(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 2) return SendUsage(playerid, "/crack [1-2]");
	switch(id)
	{
		case 1: ApplyAnimation_Loop(playerid, "CRACK", "CRCKDETH2", 4.1, true, false, false, false, 0, 1);
		case 2: ApplyAnimation_Loop(playerid, "CRACK", "CRCKDETH3", 4.1, true, false, false, false, 0, 1);
	}
	return 1;
}

// dance
flags:dance(CMD_TYPE_ANIMATION);
CMD:dance(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 6) return SendUsage(playerid, "/dance [1-6]");
	switch(id)
	{
		case 1: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE1);
		case 2: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE2);
		case 3: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE3);
		case 4: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE4);
		case 5: ApplyAnimation_Loop(playerid, "DANCING", "DNCE_M_D", 4.1, true, false, false, false, 0, 1);
		case 6: ApplyAnimation_Loop(playerid, "DANCING", "DNCE_M_E", 4.1, true, false, false, false, 0, 1);
	}
	return 1;
}

// deal
flags:deal(CMD_TYPE_ANIMATION);
CMD:deal(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 5) return SendUsage(playerid, "/deal [1-5]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "DEALER", "DEALER_DEAL", 4.1, false, false, false, false, 0, false);
		case 2: ApplyAnimation_Single(playerid, "DEALER", "DEALER_IDLE_01", 4.1, false, false, false, false, 0, false);
		case 3: ApplyAnimation_Single(playerid, "DEALER", "DEALER_IDLE_02", 4.1, false, false, false, false, 0, false);
		case 4: ApplyAnimation_Single(playerid, "DEALER", "DEALER_IDLE_03", 4.1, false, false, false, false, 0, false);
		case 5: ApplyAnimation_Single(playerid, "DEALER", "DRUGS_BUY", 4.1, false, false, false, false, 0, false);
	}
	return 1;
}

// kiss
flags:kiss(CMD_TYPE_ANIMATION);
CMD:kiss(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 5) return SendUsage(playerid, "/kiss [1-5]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "BD_FIRE", "GRLFRD_KISS_03", 4.1, false, false, false, false, 0, false);
		case 2: ApplyAnimation_Single(playerid, "KISSING", "GRLFRD_KISS_01", 4.1, false, false, false, false, 0, false);
		case 3: ApplyAnimation_Single(playerid, "KISSING", "PLAYA_KISS_01", 4.1, false, true, true, true, 0, false);
		case 4: ApplyAnimation_Single(playerid, "KISSING", "PLAYA_KISS_02", 4.1, false, false, false, false, 0, false);
		case 5: ApplyAnimation_Single(playerid, "KISSING", "PLAYA_KISS_03", 4.1, false, false, false, false, 0, false);
	}
	return 1;
}

// lookaround
flags:lookaround(CMD_TYPE_ANIMATION);
CMD:lookaround(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 3) return SendUsage(playerid, "/lookaround [1-3]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "BD_FIRE", "BD_PANIC_04", 4.1, false, false, false, false, 0, false);
		case 2: ApplyAnimation_Single(playerid, "ON_LOOKERS", "LKAROUND_LOOP", 4.1, false, false, false, false, 0, false);
		case 3: ApplyAnimation_Single(playerid, "PED", "ROADCROSS", 4.1, false, false, false, false, 0, false);
	}
	return 1;
}

// walking
alias:walking("walk");
flags:walking(CMD_TYPE_ANIMATION);
CMD:walking(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 9) return SendUsage(playerid, "/walking [1-9]");
	switch(id)
	{
		case 1: ApplyAnimation_Loop(playerid, "FAT", "FATWALK", 4.1, true, true, true, true, 1, 1);
		case 2: ApplyAnimation_Loop(playerid, "JST_BUISNESS", "GIRL_01", 4.1, true, true, true, true, 1, 1);
		case 3: ApplyAnimation_Loop(playerid, "MUSCULAR", "MUSCLEWALK", 4.1, true, true, true, true, 1, 1);
		case 4: ApplyAnimation_Loop(playerid, "PED", "WALK_DRUNK", 4.1, true, true, true, true, 1, 1);
		case 5: ApplyAnimation_Loop(playerid, "PED", "WALK_GANG1", 4.1, true, true, true, true, 1, 1);
		case 6: ApplyAnimation_Loop(playerid, "PED", "WALK_GANG2", 4.1, true, true, true, true, 1, 1);
		case 7: ApplyAnimation_Loop(playerid, "PED", "WALK_OLD", 4.1, true, true, true, true, 1, 1);
		case 8: ApplyAnimation_Loop(playerid, "PED", "WALK_WUZI", 4.1, true, true, true, true, 1, 1);
	}
	return 1;
}

// tired
flags:tired(CMD_TYPE_ANIMATION);
CMD:tired(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 2) return SendUsage(playerid, "/tired [1-2]");
	switch(id)
	{
		case 1: ApplyAnimation_Loop(playerid, "FAT", "IDLE_TIRED", 4.1, true, false, false, false, 0, 1);
		case 2: ApplyAnimation_Loop(playerid, "PED", "IDLE_TIRED", 4.1, true, false, false, false, 0, 1);
	}
	return 1;
}

// stance
flags:stance(CMD_TYPE_ANIMATION);
CMD:stance(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 9) return SendUsage(playerid, "/stance [1-9]");
	switch(id)
	{
		case 1: ApplyAnimation_Loop(playerid, "FAT", "FATIDLE", 4.1, true, false, false, false, 0, 1);
		case 2: ApplyAnimation_Loop(playerid, "FIGHT_C", "FIGHTC_IDLE", 4.1, true, false, false, false, 0, 1);
		case 3: ApplyAnimation_Loop(playerid, "GRAVEYARD", "MRNM_LOOP", 4.1, true, false, false, false, 0, 1);
		case 4: ApplyAnimation_Loop(playerid, "GRAVEYARD", "PRST_LOOPA", 4.1, true, false, false, false, 0, 1);
		case 5: ApplyAnimation_Loop(playerid, "OTB", "WTCHRACE_LOOP", 4.1, true, false, false, false, 0, 1);
		case 6: ApplyAnimation_Loop(playerid, "PED", "IDLESTANCE_OLD", 4.1, true, false, false, false, 0, 1);
		case 7: ApplyAnimation_Loop(playerid, "PED", "XPRESSSCRATCH", 4.1, true, false, false, false, 0, 1);
		case 8: ApplyAnimation_Loop(playerid, "SMOKING", "M_SMK_LOOP", 4.1, true, false, false, false, 0, 1);
		case 9: ApplyAnimation_Loop(playerid, "DEALER", "DEALER_IDLE", 4.1, true, false, false, false, 0, 1);
	}
	return 1;
}


// kungfu
flags:kungfu(CMD_TYPE_ANIMATION);
CMD:kungfu(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 3) return SendUsage(playerid, "/kungfu [1-3]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "FIGHT_C", "FIGHTC_1", 4.1, false, true, true, true, 0, false);
		case 2: ApplyAnimation_Single(playerid, "FIGHT_C", "FIGHTC_2", 4.1, false, true, true, true, 0, false);
		case 3: ApplyAnimation_Single(playerid, "FIGHT_C", "FIGHTC_3", 4.1, false, true, true, true, 0, false);
	}
	return 1;
}

// kickass
flags:kickass(CMD_TYPE_ANIMATION);
CMD:kickass(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 4) return SendUsage(playerid, "/kickass [1-4]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "FIGHT_D", "FIGHTD_G", 4.1, false, true, true, true, 0, false);
		case 2: ApplyAnimation_Single(playerid, "FIGHT_E", "FIGHTKICK_B", 4.1, false, true, true, true, 0, false);
		case 3: ApplyAnimation_Single(playerid, "GANGS", "SHAKE_CARK", 4.1, false, true, true, true, 0, false);
		case 4: ApplyAnimation_Single(playerid, "POLICE", "DOOR_KICK", 4.1, false, true, true, true, 0, false);
	}
	return 1;
}



// fall
flags:fall(CMD_TYPE_ANIMATION);
CMD:fall(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 2) return SendUsage(playerid, "/fall [1-2]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "FIGHT_E", "HIT_FIGHTKICK_B", 4.1, false, true, true, true, 0, 1);
		case 2: ApplyAnimation_Single(playerid, "PED", "KO_SKID_BACK", 4.1, false, true, true, true, 0, 1);
	}
	return 1;
}

// snacks
flags:snacks(CMD_TYPE_ANIMATION);
CMD:snacks(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 2) return SendUsage(playerid, "/snacks [1-2]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "FOOD", "EAT_BURGER", 4.1, false, false, false, false, 0, false);
		case 2: ApplyAnimation_Single(playerid, "FOOD", "EAT_PIZZA", 4.1, false, false, false, false, 0, false);
	}
	return 1;
}

// vomit
flags:vomit(CMD_TYPE_ANIMATION);
CMD:vomit(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 2) return SendUsage(playerid, "/vomit [1-2]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "FOOD", "EAT_VOMIT_P", 4.1, false, false, false, false, 0, false);
		case 2: ApplyAnimation_Single(playerid, "FOOD", "EAT_VOMIT_SK", 4.1, false, false, false, false, 0, false);
	}
	return 1;
}

// gym
flags:gym(CMD_TYPE_ANIMATION);
CMD:gym(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 2) return SendUsage(playerid, "/gym [1-2]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "FREEWEIGHTS", "GYM_BARBELL", 4.1, true, true, true, false, 0, false);
		case 2: ApplyAnimation_Single(playerid, "FREEWEIGHTS", "GYM_FREE_A", 4.1, false, true, true, true, 0, false);
	}
	return 1;
}

// thug
flags:thug(CMD_TYPE_ANIMATION);
CMD:thug(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 5) return SendUsage(playerid, "/thug [1-5]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "GANGS", "HNDSHKAA", 4.1, false, false, false, false, 0, false);
		case 2: ApplyAnimation_Single(playerid, "GANGS", "HNDSHKCA", 4.1, false, false, false, false, 0, false);
		case 3: ApplyAnimation_Single(playerid, "GANGS", "HNDSHKDA", 4.1, false, false, false, false, 0, false);
		case 4: ApplyAnimation_Single(playerid, "GANGS", "HNDSHKEA", 4.1, false, false, false, false, 0, false);
		case 5: ApplyAnimation_Single(playerid, "GANGS", "HNDSHKFA_SWT", 4.1, false, false, false, false, 0, false);
	}
	return 1;
}

// thugsign
flags:thugsign(CMD_TYPE_ANIMATION);
CMD:thugsign(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 6) return SendUsage(playerid, "/thugsign [1-6]");
	switch(id)
	{
		case 1: ApplyAnimation_Loop(playerid, "GHANDS", "GSIGN1", 4.1, true, false, false, false, 0, 1);
		case 2: ApplyAnimation_Loop(playerid, "GHANDS", "GSIGN1LH", 4.1, true, false, false, false, 0, 1);
		case 3: ApplyAnimation_Loop(playerid, "GHANDS", "GSIGN2", 4.1, true, false, false, false, 0, 1);
		case 4: ApplyAnimation_Loop(playerid, "GHANDS", "GSIGN3", 4.1, true, false, false, false, 0, 1);
		case 5: ApplyAnimation_Loop(playerid, "GHANDS", "GSIGN4", 4.1, true, false, false, false, 0, 1);
		case 6: ApplyAnimation_Loop(playerid, "GHANDS", "GSIGN5", 4.1, true, false, false, false, 0, 1);
	}
	return 1;
}

// no
flags:no(CMD_TYPE_ANIMATION);
CMD:no(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 2) return SendUsage(playerid, "/no [1-2]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "GANGS", "INVITE_NO", 4.1, false, false, false, false, 0, false);
		case 2: ApplyAnimation_Single(playerid, "KISSING", "GF_STREETARGUE_02", 4.1, false, false, false, false, 0, false);
	}
	return 1;
}

// yes
flags:yes(CMD_TYPE_ANIMATION);
CMD:yes(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 2) return SendUsage(playerid, "/yes [1-2]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "GANGS", "INVITE_YES", 4.1, false, false, false, false, 0, false);
		case 2: ApplyAnimation_Single(playerid, "ON_LOOKERS", "LKUP_IN", 4.1, false, false, false, false, 0, false);
	}
	return 1;
}

// push
flags:push(CMD_TYPE_ANIMATION);
CMD:push(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 2) return SendUsage(playerid, "/push [1-2]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "GANGS", "SHAKE_CARA", 4.1, false, false, false, false, 0, false);
		case 2: ApplyAnimation_Single(playerid, "GANGS", "SHAKE_CARSH", 4.1, false, false, false, false, 0, false);
	}
	return 1;
}


// cry
flags:cry(CMD_TYPE_ANIMATION);
CMD:cry(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 2) return SendUsage(playerid, "/cry [1-2]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "GRAVEYARD", "MRNF_LOOP", 4.1, false, false, false, false, 0, false);
		case 2: ApplyAnimation_Single(playerid, "ON_LOOKERS", "PANIC_HIDE", 4.1, false, false, false, false, 0, false);
	}
	return 1;
}

// bed
flags:bed(CMD_TYPE_ANIMATION);
CMD:bed(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 2) return SendUsage(playerid, "/bed [1-2]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "INT_HOUSE", "BED_IN_L", 4.1, false, true, true, true, 0, 1);
		case 2: ApplyAnimation_Single(playerid, "INT_HOUSE", "BED_IN_R", 4.1, false, true, true, true, 0, 1);
	}
	return 1;
}

// computer
flags:computer(CMD_TYPE_ANIMATION);
CMD:computer(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 2) return SendUsage(playerid, "/computer [1-2]");
	switch(id)
	{
		case 1: ApplyAnimation_Loop(playerid, "INT_OFFICE", "OFF_SIT_TYPE_LOOP", 4.1, true, false, false, false, 0, 1);
		case 2: ApplyAnimation_Loop(playerid, "INT_OFFICE", "OFF_SIT_WATCH", 4.1, true, false, false, false, 0, 1);
	}
	return 1;
}

// dj
flags:dj(CMD_TYPE_ANIMATION);
CMD:dj(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 3) return SendUsage(playerid, "/dj [1-3]");
	switch(id)
	{
		case 1: ApplyAnimation_Loop(playerid, "INT_SHOP", "SHOP_CASHIER", 4.1, true, false, false, false, 0, 1);
		case 2: ApplyAnimation_Loop(playerid, "INT_SHOP", "SHOP_IN", 4.1, true, false, false, false, 0, 1);
		case 3: ApplyAnimation_Loop(playerid, "INT_SHOP", "SHOP_SHELF", 4.1, true, false, false, false, 0, 1);
	}
	return 1;
}

// talk
flags:talk(CMD_TYPE_ANIMATION);
CMD:talk(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 2) return SendUsage(playerid, "/talk [1-2]");
	switch(id)
	{
		case 1: ApplyAnimation_Loop(playerid, "KISSING", "GF_STREETARGUE_01", 4.1, true, false, false, false, 0, 1);
		case 2: ApplyAnimation_Loop(playerid, "MISC", "IDLE_CHAT_02", 4.1, true, false, false, false, 0, 1);
	}
	return 1;
}

// gift
flags:gift(CMD_TYPE_ANIMATION);
CMD:gift(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 2) return SendUsage(playerid, "/gift [1-2]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "KISSING", "GIFT_GET", 4.1, false, false, false, false, 0, false);
		case 2: ApplyAnimation_Single(playerid, "KISSING", "GIFT_GIVE", 4.1, false, false, false, false, 0, false);
	}
	return 1;
}

// phone
flags:aphone(CMD_TYPE_ANIMATION);
CMD:aphone(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 3) return SendUsage(playerid, "/aphone [1-3]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "PED", "PHONE_IN", 4.1, false, false, false, false, 0, false);
		case 2: ApplyAnimation_Single(playerid, "PED", "PHONE_OUT", 4.1, false, false, false, false, 0, false);
		case 3: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
	}
	return 1;
}

// rap
flags:rap(CMD_TYPE_ANIMATION);
CMD:rap(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 3) return SendUsage(playerid, "/rap [1-3]");
	switch(id)
	{
		case 1: ApplyAnimation_Loop(playerid, "LOWRIDER", "RAP_A_LOOP", 4.1, true, false, false, false, 0, 1);
		case 2: ApplyAnimation_Loop(playerid, "LOWRIDER", "RAP_B_LOOP", 4.1, true, false, false, false, 0, 1);
		case 3: ApplyAnimation_Loop(playerid, "LOWRIDER", "RAP_C_LOOP", 4.1, true, false, false, false, 0, 1);
	}
	return 1;
}


// snatch
flags:snatch(CMD_TYPE_ANIMATION);
CMD:snatch(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 2) return SendUsage(playerid, "/snatch [1-2]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "MISC", "GRAB_L", 2.0, false, false, false, false, 0, false);
		case 2: ApplyAnimation_Single(playerid, "MISC", "GRAB_R", 2.0, false, false, false, false, 0, false);
	}
	return 1;
}

// holdgun
flags:holdgun(CMD_TYPE_ANIMATION);
CMD:holdgun(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 2) return SendUsage(playerid, "/holdgun [1-2]");
	switch(id)
	{
		case 1: ApplyAnimation_Loop(playerid, "MUSCULAR", "MUSCLEIDLE_ARMED", 4.1, true, false, false, false, 0);
		case 2: ApplyAnimation_Loop(playerid, "MUSCULAR", "MUSCLEIDLE_CSAW", 4.1, true, false, false, false, 0);
	}
	return 1;
}

// shout
flags:ashout(CMD_TYPE_ANIMATION);
CMD:ashout(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 4) return SendUsage(playerid, "/ashout [1-4]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "ON_LOOKERS", "PANIC_SHOUT", 4.1, false, false, false, false, 0, false);
		case 2: ApplyAnimation_Single(playerid, "ON_LOOKERS", "SHOUT_01", 4.1, false, false, false, false, 0, false);
		case 3: ApplyAnimation_Single(playerid, "ON_LOOKERS", "SHOUT_02", 4.1, false, false, false, false, 0, false);
		case 4: ApplyAnimation_Single(playerid, "ON_LOOKERS", "SHOUT_IN", 4.1, false, false, false, false, 0, false);
	}
	return 1;
}


// thisway
flags:thisway(CMD_TYPE_ANIMATION);
CMD:thisway(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 4) return SendUsage(playerid, "/thisway [1-4]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "ON_LOOKERS", "POINTUP_IN", 4.1, false, false, false, false, 0, false);
		case 2: ApplyAnimation_Single(playerid, "ON_LOOKERS", "POINTUP_LOOP", 4.1, false, false, false, false, 0, false);
		case 3: ApplyAnimation_Single(playerid, "ON_LOOKERS", "POINTUP_OUT", 4.1, false, false, false, false, 0, false);
		case 4: ApplyAnimation_Single(playerid, "ON_LOOKERS", "POINT_LOOP", 4.1, false, false, false, false, 0, false);
	}
	return 1;
}

// piss
flags:piss(CMD_TYPE_ANIMATION);
CMD:piss(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 2) return SendUsage(playerid, "/piss [1-2]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "PAULNMAC", "PISS_IN", 4.1, false, false, false, false, 0, false);
		case 2: ApplyAnimation_Single(playerid, "PAULNMAC", "PISS_OUT", 4.1, false, false, false, false, 0, false);
	}
	return 1;
}

// drunk
flags:drunk(CMD_TYPE_ANIMATION);
CMD:drunk(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 2) return SendUsage(playerid, "/drunk [1-2]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "PAULNMAC", "PNM_LOOP_A", 4.1, false, false, false, false, 0, false);
		case 2: ApplyAnimation_Single(playerid, "PAULNMAC", "PNM_LOOP_B", 4.1, false, false, false, false, 0, false);
	}
	return 1;
}

// fuckyou
flags:fuckyou(CMD_TYPE_ANIMATION);
CMD:fuckyou(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 2) return SendUsage(playerid, "/fuckyou [1-2]");
	switch(id)
	{
		case 1: ApplyAnimation_Single(playerid, "PED", "FUCKU", 4.1, false, false, false, false, 0, false);
		case 2: ApplyAnimation_Single(playerid, "RIOT", "RIOT_FUKU", 1.0, false, false, false, false, 0, false);
	}
	return 1;
}

flags:lowrider(CMD_TYPE_ANIMATION);
CMD:lowrider(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid)) return InfoBox(playerid, IB_NOT_IN_VEHICLE);
	if(!IsModelLowrider(GetVehicleModel(GetPlayerVehicleID(playerid)))) return SendWarning(playerid, "Netinkamas tr. priemonës modelis.");
	else
	{
		new id;
		if(sscanf(params, "d", id) || id < 1 || id > 31) return SendUsage(playerid, "/lowrider [1-31]");
		switch(id)
		{
			case 1: ApplyAnimation_Single(playerid, "LOWRIDER", "lrgirl_bdbnce", 4.1, false, true, true, true, true, true);
		    case 2: ApplyAnimation_Single(playerid, "LOWRIDER", "lrgirl_hair", 4.1, false, true, true, true, true, true);
		    case 3: ApplyAnimation_Single(playerid, "LOWRIDER", "lrgirl_hurry", 4.1, false, true, true, true, true, true);
		    case 4: ApplyAnimation_Single(playerid, "LOWRIDER", "lrgirl_idleloop", 4.1, false, true, true, true, true, true);
		    case 5: ApplyAnimation_Single(playerid, "LOWRIDER", "lrgirl_idle_to_l0", 4.1, false, true, true, true, true, true);
		    case 6: ApplyAnimation_Single(playerid, "LOWRIDER", "lrgirl_l0_bnce", 4.1, false, true, true, true, true, true);
		    case 7: ApplyAnimation_Single(playerid, "LOWRIDER", "lrgirl_l0_loop", 4.1, false, true, true, true, true, true);
		    case 8: ApplyAnimation_Single(playerid, "LOWRIDER", "lrgirl_l0_to_l1", 4.1, false, true, true, true, true, true);
		    case 9: ApplyAnimation_Single(playerid, "LOWRIDER", "lrgirl_l12_to_l0", 4.1, false, true, true, true, true, true);
		    case 10: ApplyAnimation_Single(playerid, "LOWRIDER", "lrgirl_l1_bnce", 4.1, false, true, true, true, true, true);
		    case 11: ApplyAnimation_Single(playerid, "LOWRIDER", "lrgirl_l1_loop", 4.1, false, true, true, true, true, true);
		    case 12: ApplyAnimation_Single(playerid, "LOWRIDER", "lrgirl_l1_to_l2", 4.1, false, true, true, true, true, true);
		    case 13: ApplyAnimation_Single(playerid, "LOWRIDER", "lrgirl_l2_bnce", 4.1, false, true, true, true, true, true);
		    case 14: ApplyAnimation_Single(playerid, "LOWRIDER", "lrgirl_l2_loop", 4.1, false, true, true, true, true, true);
		    case 15: ApplyAnimation_Single(playerid, "LOWRIDER", "lrgirl_l2_to_l3", 4.1, false, true, true, true, true, true);
		    case 16: ApplyAnimation_Single(playerid, "LOWRIDER", "lrgirl_l345_to_l1", 4.1, false, true, true, true, true, true);
		    case 17: ApplyAnimation_Single(playerid, "LOWRIDER", "lrgirl_l3_bnce", 4.1, false, true, true, true, true, true);
		    case 18: ApplyAnimation_Single(playerid, "LOWRIDER", "lrgirl_l3_loop", 4.1, false, true, true, true, true, true);
		    case 19: ApplyAnimation_Single(playerid, "LOWRIDER", "lrgirl_l3_to_l4", 4.1, false, true, true, true, true, true);
		    case 20: ApplyAnimation_Single(playerid, "LOWRIDER", "lrgirl_l4_bnce", 4.1, false, true, true, true, true, true);
		    case 21: ApplyAnimation_Single(playerid, "LOWRIDER", "lrgirl_l4_loop", 4.1, false, true, true, true, true, true);
		    case 22: ApplyAnimation_Single(playerid, "LOWRIDER", "lrgirl_l4_to_l5", 4.1, false, true, true, true, true, true);
		    case 23: ApplyAnimation_Single(playerid, "LOWRIDER", "lrgirl_l5_bnce", 4.1, false, true, true, true, true, true);
		    case 24: ApplyAnimation_Single(playerid, "LOWRIDER", "lrgirl_l5_loop", 4.1, false, true, true, true, true, true);
		    case 25: ApplyAnimation_Single(playerid, "LOWRIDER", "prtial_gngtlkB", 4.1, false, true, true, true, true, true);
		    case 26: ApplyAnimation_Single(playerid, "LOWRIDER", "prtial_gngtlkC", 4.1, false, true, true, true, true, true);
		    case 27: ApplyAnimation_Single(playerid, "LOWRIDER", "prtial_gngtlkD", 4.1, false, true, true, true, true, true);
		    case 28: ApplyAnimation_Single(playerid, "LOWRIDER", "prtial_gngtlkE", 4.1, false, true, true, true, true, true);
		    case 29: ApplyAnimation_Single(playerid, "LOWRIDER", "prtial_gngtlkF", 4.1, false, true, true, true, true, true);
		    case 30: ApplyAnimation_Single(playerid, "LOWRIDER", "prtial_gngtlkG", 4.1, false, true, true, true, true, true);
		    case 31: ApplyAnimation_Single(playerid, "LOWRIDER", "prtial_gngtlkH", 4.1, false, true, true, true, true, true);
		}
	}
	return 1;
}

// handsup
flags:handsup(CMD_TYPE_ANIMATION);
CMD:handsup(playerid, params[])
{
	new id;
	if(sscanf(params, "d", id) || id < 1 || id > 3) return SendUsage(playerid, "/handsup [1-3]");
	switch(id)
	{
		case 1: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_HANDSUP);
		case 2: ApplyAnimation_Loop(playerid, "SHOP", "SHP_ROB_GIVECASH", 4.1, true, false, false, false, 0, 1);
		case 3: ApplyAnimation_Loop(playerid, "SHOP", "SHP_ROB_HANDSUP", 4.1, true, false, false, false, 0, 1);
	}
	return 1;
}

flags:anims(CMD_TYPE_ANIMATION);
CMD:anims(playerid, params[])
{
	SendFormat(playerid, 0xF4F4F4FF, "/pullout /giveglass /filling /drink /start /liftup /take /crossarms");
	SendFormat(playerid, 0xF4F4F4FF, "/think /paying /punch /underbar /rubhands /throw /wash");
	SendFormat(playerid, 0xF4F4F4FF, "/backstab /stab /saywhat /medic /bitchslap /righthand /lefthand");
	SendFormat(playerid, 0xF4F4F4FF, "/facepalm /scratchballs /signdocument /wank /arrestgun /eatgum /slowdown");
	SendFormat(playerid, 0xF4F4F4FF, "/seat /turnaround /stretch /watchclock /astop /laugh /gogo /comeatme");
	SendFormat(playerid, 0xF4F4F4FF, "/reloadpistol /lightup /dropashes /slapass /lookthere /dead /angry /robbery ");
	SendFormat(playerid, 0xF4F4F4FF, "/cop /stripclub /stripper /sit /sitdown /situp /dancing /kata");
	SendFormat(playerid, 0xF4F4F4FF, "/lean /chat /takebeer /bat /wave /hurt /lay /smoke /muscle");
	SendFormat(playerid, 0xF4F4F4FF, "/bomb /put /putdown /takebox /box /boxstance /shotgun");
	SendFormat(playerid, 0xF4F4F4FF, "/opendoor /comeon /knees /car /getup /won /colt /sawnoff");
	SendFormat(playerid, 0xF4F4F4FF, "/knife /spray /crack /deal /kiss /lookaround");
	SendFormat(playerid, 0xF4F4F4FF, "/dance /tired /stance /kungfu /kickass /fall /snacks /vomit");
	SendFormat(playerid, 0xF4F4F4FF, "/gym /thug /thugsign /no /yes /push /cry /bed");
	SendFormat(playerid, 0xF4F4F4FF, "/computer /dj /talk /gift /aphone /rap /snatch /lowrider");
	SendFormat(playerid, 0xF4F4F4FF, "/holdgun /ashout /thisway /piss /drunk /fuckyou /handsup");
	return 1;
}