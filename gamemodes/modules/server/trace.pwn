#include <YSI\y_hooks>

#define MIN_BIAS 50.0
#define MAX_BIAS 300.0

static
	player_Trace_IsTracing[MAX_PLAYERS],
	player_Trace_Timer_ID[MAX_PLAYERS],
	player_Trace_GangZone_ID[MAX_PLAYERS];

enum e_towers
{
	twName[64],
	Float:twPositionX,
	Float:twPositionY,
	Float:twPositionZ
};

stock Float:Trace_GetBiasByDistance(Float:distance)
{
	new 
		Float:bias;
	switch(floatround(distance))
	{
		case 0 .. 150: bias = 20.0;
		case 151 .. 300: bias = 35.0;
		case 301 .. 600: bias = 50.0;
		case 601 .. 900: bias = 75.0;
		default: bias -= 90.0;
	}
	return bias;
}

static Towers[][e_towers] = {
		{"Idlewood", 2089.1458,-1744.0972,22.2687}, // idlewood
		{"El Corona", 1947.6989,-2053.3586,22.2687}, // elcorona
		{"Downtown", 1818.0216,-1735.1622,16.6050}, // downtown
		{"Downtown", 1712.6396,-1275.1716,19.6714}, // md
		{"Temple", 1371.9189,-1024.6663,29.2204}, // temple
		{"Market", 1123.6351,-1564.8896,27.4207}, // market
		{"Verona Beach", 981.3230,-1770.3632,14.0582}, // verona beach
		{"Marina", 749.3230,-1459.3632,8.7577}, // marina
		{"Rodeo", 637.3230,-1669.3632,15.1456}, // rodeo
		{"Market Station", 805.3230,-1349.3632,13.5469}, // market station
		{"Mulholland", 1303.0439,-835.5519,81.7457}, // mullholand
		{"Vinewood", 848.2466,-1222.6951,16.5625}, // vinewood
		{"Richman", 346.8332,-1219.2738,86.1529}, // richman
		{"Mulholland intersection", 1528.7551,-970.6957,36.7583}, // mullholand intersectin
		{"Glenpark", 1981.7551,-1254.6957,23.8203}, // glenpark
		{"Jefferson", 2261.7551,-1268.6957,23.9766}, // jefferson
		{"East Los Santos", 2398.0000,-1614.6957,10.6014}, // east ls
		{"East Los Santos", 2720.0000,-1344.4927,45.8138}, // east ls 2
		{"Willowfield", 2300.0422,-1975.4637,25.7036}, // willowfield
		{"LS Airport", 1707.8158,-2283.0627,-1.2390}, // airport
		{"Docks", 2378.2031,-2270.5940,25.8461}, // docs
		{"Verdant Bluffs", 1163.4063,-2025.5940,69.0006}, // verdant bluffs
		{"Santa Marina Beach", 303.4063,-1762.4221,7.6797}, // santa marina beach
		{"Los Santos", -109.1875,-1178.0159,2.8906}, // ls fuel
		{"Flint County", -280.1875,-958.0159,40.5855}, // flint county
		{"Angel Pine", -2136.2344,-2387.0471,30.6250}, // angel pine
		//{"Angel Pine Farms", -1437.8673,-1505.5383,101.7375}, // ap farms
		{"San Fierro Commerce", -1980.5234, -865.2883, 32.1738}, // sf commerce
		{"Missionary", -2330.5234,-669.2883,113.5097}, // missionary
		{"SF Airport", -1472.9063,-191.6477,14.1484}, // sf airport
		{"Easter Basin", -1717.9883,-10.3546,3.5776}, // easter basin
		{"San Fierro Downtown", -1690.2070,591.6454,33.7098}, // sf downtown
		{"San Fierro Center", -2012.2070,927.6454,45.2969}, // sf center
		{"Calton Heights", -2012.2070,927.6454,45.2969}, // calton heights
		{"Juniper Hill", -2362.2070,997.6454,50.7029}, // juniper hollow
		{"City Hall SF", -2689.5938,427.1766,22.5625}, // city hall sf
		{"Ocean flats", -2678.0000,43.1766,4.1797}, // ocean flats
		{"Kings", -2244.0000,488.9155,73.7422}, // sf kings
		{"Queens", -2548.6094,362.9155,20.2810}, // queens
		{"Doherty", -2016.6094,194.9155,27.6875}, // doherty
		{"North San Fierro", -2060.6174,1282.6000,7.5961}, // north sf
		{"Gant Bridge", -2678.0000,1873.9438,68.5095}, // gant bridge
		{"Bayside", -2486.1563,2321.9438,4.9844}, // bayside
		{"El Quebrados", -1497.6099,2603.7981,60.9659}, // el quebridos
		{"Sherma Dam", -1198.9978,1787.6664,41.4886}, // sherma dam
		{"Las Barrancas", -807.0283,1535.6953,26.9609}, // las barrancas
		{"Fort Carson hill", -317.0283,1528.4766,75.3594}, // fc kalnas
		{"Fort Carson", -157.0908,1134.5859,19.7422}, // FC
		{"Area 51", 201.8467,1910.6953,17.6406}, // area51
		{"Las Paysadas", -220.7627,2687.6953,62.6678}, // las paysadas
		{"Julius Thruway West", 1214.0051,2019.0142,6.7344}, // julius thruway west
		{"Redsands West", 1424.0051,2019.0142,10.8203}, // redsands west
		{"LV airport", 1418.9110,1579.1476,10.8203}, // lv airport
		{"LV commerce", 1656.9110,734.1476,18.8625}, // LV commerce
		{"LV houses", 2272.9111,729.1476,10.8203}, // lv houses
		{"Rockshore east", 2804.0000,924.7078,10.7500}, // rockshore east lol bv
		{"Come-a-lot", 2524.0000,1060.7078,10.6719}, // come-a-lot
		{"Las Venturas downtown", 2226.9375,1528.7078,10.6719}, // lv downtown
		{"Caligulas Palace", 2394.9375,1612.7078,10.6719}, // caligulas palace
		{"Starfish casino", 2538.0000,1950.7078,10.6719}, // starfish casino
		{"Harry Gold parkway", 1838.0000,2202.7078,10.8203}, // harry gold parkway
		{"Prickle Pine", 1544.0000,2710.7546,10.8304}, // prickle pine
		{"Roca Escalante", 2804.0000,2118.5469,10.7990}, // roca escalante
		{"Creek", 2804.0000,2118.5469,10.7990}, // creek
		{"Linden Station", 2804.0000,1474.7813,10.8419}, // linden station
		{"Blueberry", 219.3594,-128.5313,1.5780}, // blueberry
		{"Dillimore", 697.3594,-535.0625,16.1906}, // dillimore
		{"Palomino Creek", 2339.3594,25.9375,26.3359}, // palomino
		{"Montgomery", 1304.3962,291.1212,19.4063}
}; // montgomery

CMD:canceltrace(playerid, params[])
{
	if(!player_Trace_IsTracing[playerid]) return SendError(playerid, "Jûs nieko nesekate!");

	if(player_Trace_GangZone_ID[playerid] != -1) SendClientMessage(playerid, -1, "Vieta þemëlapyje buvo iðtrinta.");
	else SendClientMessage(playerid, -1, "Sekimas buvo nutrauktas.");

	Trace_Reset(playerid);

	return 1;
}

CMD:tracenumber(playerid, params[])
{
	new number,
		targetid = INVALID_PLAYER_ID,
		factionid = GetFactionArrayIndexById(PlayerInfo[playerid][pFaction]);
	if(FactionInfo[factionid][fType] != FACTION_TYPE_POLICE || factionid == -1) return SendError(playerid, "Jûsø frakcija ðios funkcijos neturi.");
	if(sscanf(params,"d",number)) return SendUsage(playerid, "/tracenumber [numeris]");

	new bool:allowed;
	if(IsPlayerInAnyVehicle(playerid))
	{
		new v_factionid = GetFactionArrayIndexById(VehicleInfo[GetPlayerVehicleID(playerid)][vFaction]);
		
		if(v_factionid != -1)
		{
			if(FactionInfo[v_factionid][fType] == FACTION_TYPE_POLICE) allowed = true;
		}
	}
	else if(IsPlayerInPD(playerid) || IsPlayerInRangeOfPoint(playerid, 100.0, 410.36, 1445.06, 1844.09) || IsPlayerInRangeOfPoint(playerid, 100.0, 359.22, 1426.68, 1519.27)) allowed = true;
	if(allowed)
	{
		targetid = GetPlayerByNumber(number);
		if(targetid == INVALID_PLAYER_ID || !IsPhoneEnabled(targetid)) return SendWarning(playerid, "Telefonas yra iðjungtas arba numeris neteisingas.");
		if(GetPlayerVirtualWorld(targetid) != 0 || GetPlayerInterior(targetid) != 0) return SendWarning(playerid, "Numeris yra pastate.");

		if(player_Trace_IsTracing[playerid] && player_Trace_GangZone_ID[playerid] != -1) GangZoneDestroy(player_Trace_GangZone_ID[playerid]);

		player_Trace_IsTracing[playerid] = true;
		player_Trace_Timer_ID[playerid] = SetTimerEx("T_TraceTimer", 3000 + random(3000), false, "ddd", playerid, targetid, 0); // 4000 + random(2500)

		Player_Trace_ShowTracing(playerid, 0, targetid, number);
	}
	else SendWarning(playerid, "Turite bûti policijos departamente arba maðinoje.");	
	return 1;
}

forward T_TraceTimer(playerid, targetid, index);
public T_TraceTimer(playerid, targetid, index)
{
	if(!IsPlayerConnected(targetid) || !IsPlayerConnected(playerid) || !IsPhoneEnabled(targetid))
	{
		Trace_Reset(playerid);
		SendWarning(playerid, "Signalas nutrûko.");
		return 1;
	}	
	if(player_Trace_IsTracing[playerid])
	{
		Player_Trace_ShowTracing(playerid, index + 1, targetid);
		if(index < 4) player_Trace_Timer_ID[playerid] = SetTimerEx("T_TraceTimer", 3000 + random(3000), false, "ddd", playerid, targetid, index + 1); // 4000 + random(2500)
	}
	return 1;
}

stock Player_Trace_ShowTracing(playerid, index, targetid, number = 0)
{
	static 
		string[MAX_PLAYERS][512],
		towers_saved[MAX_PLAYERS][4],
		best_tower[MAX_PLAYERS],
		Float:best_distance[MAX_PLAYERS];

	new 
		line[126];

	if(index == 0) 
	{
		for(new i = 0; i < 4; i++) towers_saved[playerid][i] = -1;
		best_tower[playerid] = -1;
		best_distance[playerid] = -1.0;
		format(string[playerid], 512, "{ba804d}Numerio %d susekimas pradëtas!\n", number);
	}
	else
	{
		index -- ;
		if(index < 4)
		{
			new Float:distance;
			Trace_GetClosestTower(targetid, towers_saved[playerid][index], distance, 800.0, towers_saved[playerid][0], towers_saved[playerid][1], towers_saved[playerid][2], towers_saved[playerid][3]);

			if(towers_saved[playerid][index] == -1)
			{
				if(index <= 0)
				{
					Trace_Reset(playerid);
					format(line, sizeof line, "\n{ff0000}Negauta jokio signalo...");
				}
				else format(line, sizeof line, "\n{ff0000}Signalas neaptiktas...");
			}
			else
			{
				if(distance < best_distance[playerid] || best_distance[playerid] <= -1.0)
				{
					best_tower[playerid] = towers_saved[playerid][index];
					best_distance[playerid] = distance;
				}
				format(line, sizeof line, "\n{bababa}Gautas signalas ið {eccf75}%s{bababa}: {f1c745}%s", Towers[towers_saved[playerid][index]][twName], Trace_GetStrenghtNameByDistance(distance));
			}
			strcat(string[playerid], line);
		}
		else
		{
			if(best_tower[playerid] != -1)
			{
				format(line, sizeof line, "\n{89c245}Numeris susektas, jo apytikslë vieta paþymëta þemëlapyje.");
				strcat(string[playerid], line);

				Trace_ShowGangZone(playerid, targetid, best_tower[playerid], best_distance[playerid]);
			}
			else return SendWarning(playerid, "{e03241}Numerio susekti nepavyko.");
		}
	}
	Dialog_Show(playerid, D_Trace, DIALOG_STYLE_MSGBOX, "Numerio sekimas", string[playerid], "Gerai", "");
	//ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Numerio sekimas", string[playerid], "Gerai", "");
	return 1;
}

stock Trace_ShowGangZone(playerid, targetid, towerid, Float:distance)
{
	#pragma unused towerid
	new 
		Float:bias = Trace_GetBiasByDistance(distance),
		Float:x, Float:y, Float:z,
		randomInt;

	GetPlayerPos(targetid, x, y, z);
	randomInt = floatround(bias / 4) + random(floatround(bias - bias / 2));
	if(random(2)) randomInt *= -1;


	player_Trace_GangZone_ID[playerid] = GangZoneCreate(x - floatround(bias) - randomInt, y - floatround(bias) - randomInt, x + floatround(bias) - randomInt, y + floatround(bias) - randomInt);
	GangZoneShowForPlayer(playerid, player_Trace_GangZone_ID[playerid], 0xFF000099);

	SendClientMessage(playerid, -1, "Susektas nurodytas numeris! Apytikslë vieta paþymëta þemëlapyje.");
	SendClientMessage(playerid, -1, "Norëdami uþbaigti esamà sekimà raðykite /canceltrace.");
	return 1;
}

stock Trace_GetClosestTower(targetid, &index, &Float:distance, Float:maxrange, ...)
{
	new 
		// Temp
		Float:temp_distance,
		// Last
		Float:last_distance = maxrange;

	for(new tower = 0; tower < sizeof Towers; tower++)
	{
		new bool:skip;
		if((temp_distance = GetPlayerDistanceFromPoint(targetid, Towers[tower][twPositionX], Towers[tower][twPositionY], Towers[tower][twPositionZ])) <= last_distance)
		{
			for(new arg = 4, max_args = numargs(); arg < max_args; arg++)
			{
				if(getarg(arg) == tower && getarg(arg) != -1)
				{
					// ar yra exceptions liste
					skip = true;
				}
			}
			if(!skip)
			{
				index = tower;
				distance = temp_distance;
				last_distance = temp_distance;
			}
		}
	}
	return true;
}


stock Trace_GetStrenghtNameByDistance(Float:distance)
{
	new 
		signal[16];
	switch(floatround(distance))
	{
		case 0 .. 150: strcat(signal, "Puikus");
		case 151 .. 300: strcat(signal, "Geras");
		case 301 .. 600: strcat(signal, "Vidutinis");
		case 601 .. 900: strcat(signal, "Silpnas");
		default: strcat(signal, "Labai silpnas");
	}
	return signal;
}

stock Trace_Reset(playerid)
{
	player_Trace_Timer_ID[playerid] = -1;
	player_Trace_IsTracing[playerid] = false;
	if(player_Trace_GangZone_ID[playerid] != -1)
	{
		GangZoneDestroy(player_Trace_GangZone_ID[playerid]);
	}
	player_Trace_GangZone_ID[playerid] = -1;
	return 1;
}

hook OnPlayerConnect(playerid)
{
	Trace_Reset(playerid);
	return 1;
}

