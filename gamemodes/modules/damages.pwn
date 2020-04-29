#include <YSI\y_hooks>


new BodyPartName[10][20] =
{
	"?","?","?","Torso","Groin","Left Arm","Right Arm","Left Leg","Right Leg","Head"
};

stock GetBodyPartName(bodypart)
{
	return BodyPartName[bodypart];
}


enum E_PLAYERDAMAGES
{
	pd_issuerid,
	Float:pd_amount,
	pd_weaponid,
	pd_bodypart,
	pd_time
}

static
	Iterator:PlayerDamages[MAX_PLAYERS]<20>,
	PlayerDamages[MAX_PLAYERS][20][E_PLAYERDAMAGES];

static
	Player_Damages_IsDead[MAX_PLAYERS],
	Float:Player_Damages_DeathPosition[MAX_PLAYERS][3],
	Player_Damages_TextLabel_Active[MAX_PLAYERS],
	Text3D:Player_Damages_TextLabel_ID[MAX_PLAYERS];

hook OnGameModeInit()
{
	Iter_Init(PlayerDamages);
	return 1;
}

hook OnPlayerConnect(playerid)
{
	Player_Damages_IsDead[playerid] = false;
	return 1;
}

hook OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	AddDamageRecord(playerid, issuerid, amount, weaponid, bodypart);
	return 1;
}

stock AddDamageRecord(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	new
		index = Iter_Free(PlayerDamages[playerid]);

	if(index == ITER_NONE) return 1;

	PlayerDamages[playerid][index][pd_issuerid] = issuerid;
	PlayerDamages[playerid][index][pd_amount] = amount;
	PlayerDamages[playerid][index][pd_weaponid] = weaponid;
	PlayerDamages[playerid][index][pd_bodypart] = bodypart;
	PlayerDamages[playerid][index][pd_time] = gettime();

	Iter_Add(PlayerDamages[playerid], index);
	return 1;
}

hook OnPlayerDeath(playerid)
{
	if(!Player_Damages_IsDead[playerid])
	{
		new
			Float:deathPos[3];

		GetPlayerPos(playerid, deathPos[0], deathPos[1], deathPos[2]);

		Player_Damages_IsDead[playerid] = true;
		Player_Damages_DeathPosition[playerid][0] = deathPos[0];
		Player_Damages_DeathPosition[playerid][1] = deathPos[1];
		Player_Damages_DeathPosition[playerid][2] = deathPos[2];
	}
	else
	{
		Player_Damages_IsDead[playerid] = false;
		SendClientMessage(playerid, -1, "Pabudote ið komos (iðtrintas visas /damages log'as)");
		Iter_Clear(PlayerDamages[playerid]);
		print("IÐVALOM ITER OPD");
	}
	return 1;
}

hook OnPlayerSpawn(playerid)
{
	if(Player_Damages_IsDead[playerid])
	{
		SetTimerEx("SpawnAfterDeath", 500, false, "d", playerid);
	}
}

stock UpdateDamagesLabel(playerid)
{
	new
		text[64];

	format(text, sizeof(text), "(( Suþalojimø kiekis: %d | /damages %d ))", Iter_Count(PlayerDamages[playerid]), playerid);

	if(Player_Damages_IsDead[playerid])
	{
		print("Player_Damages_IsDead[playerid] == true");
		if(Player_Damages_TextLabel_Active[playerid])
		{
			print("Player_Damages_TextLabel_Active[playerid] == true");
			if(IsValidDynamic3DTextLabel(Player_Damages_TextLabel_ID[playerid]))
				UpdateDynamic3DTextLabelText(Player_Damages_TextLabel_ID[playerid], DAMAGES_TEXT_LABEL_COLOR, text);
		}
		else
		{
			print("Player_Damages_TextLabel_Active[playerid] == false");
			if(IsValidDynamic3DTextLabel(Player_Damages_TextLabel_ID[playerid]))
				DestroyDynamic3DTextLabel(Player_Damages_TextLabel_ID[playerid]);

			Player_Damages_TextLabel_ID[playerid] = CreateDynamic3DTextLabel(text, DAMAGES_TEXT_LABEL_COLOR, 0, 0, 0, DAMAGES_TEXT_LABEL_DRAW_DIST, playerid);

			Player_Damages_TextLabel_Active[playerid] = true;
		}
	}
	else
	{
		print("Player_Damages_IsDead[playerid] == false");
		if(IsValidDynamic3DTextLabel(Player_Damages_TextLabel_ID[playerid]))
			DestroyDynamic3DTextLabel(Player_Damages_TextLabel_ID[playerid]);
	}
}

CMD:damages(playerid, params[])
{
	new
		targetid;

	if(sscanf(params, "d", targetid)) return SendUsage(playerid, "/damages [þaidëjo id]");
	if(!IsPlayerNearAnotherPlayer(playerid, targetid)) return SendError(playerid, "Jûs nesate ðalia þaidëjo.");
	//if(!Player_Damages_IsDead[targetid]) return SendError(playerid, "Þaidëjas nëra komos bûsenoje.");

	new
		content[1024] = "Suþalojimø nëra",
		tempString[64];

	foreach(new i : PlayerDamages[targetid])
	{
		if(i != 0)
			strcat(content, "\n");

		format(tempString, sizeof(tempString), "%0.0f þalos ið %s á %s prieð %d sek.", PlayerDamages[targetid][i][pd_amount], GetWeaponNameEx(PlayerDamages[targetid][i][pd_weaponid]), GetBodyPartName(PlayerDamages[targetid][i][pd_bodypart]), gettime() - PlayerDamages[targetid][i][pd_time]);
		strcat(content, tempString);
		print(tempString);
	}

	Dialog_Show(playerid, NONE, DIALOG_STYLE_LIST, "Þaidëjo suþalojimai", content, "Uþdaryti", "");

	return 1;
}

//--

stock IsPlayerNearAnotherPlayer(playerid, targetid)
{
	#pragma unused playerid, targetid
	return 1;
}

forward SpawnAfterDeath(playerid);
public SpawnAfterDeath(playerid)
{
	SetPlayerPos(playerid, Player_Damages_DeathPosition[playerid][0], Player_Damages_DeathPosition[playerid][1], Player_Damages_DeathPosition[playerid][2]);
	ApplyAnimation(playerid, "PED", "KO_shot_front",4.1,0,1,1,1,1);

	return 1;
}