#include <a_samp>
#include <YSI\y_hooks>
#include <streamer>

enum PayNSprayData {
	Float:pns_x,
	Float:pns_y,
	Float:pns_z,
	Float:pns_range,
	pns_price,
	Text3D:pns_label
};

static PayNSpray[][PayNSprayData] = {
	{ 2073.32764, -1831.70752, 13.50604, 8.0, 900, Text3D:-1 },
	{ 1025.04089, -1030.75000, 31.53709, 8.0, 900, Text3D:-1 },
	{ 488.43179, -1733.85095, 11.58146, 8.0, 900, Text3D:-1 }
};

static 
	player_Point[MAX_PLAYERS],
	bool:player_Fixing[MAX_PLAYERS];

hook OnPlayerConnect(playerid)
{
	player_Point[playerid] = -1;
	player_Fixing[playerid] = false;
	return 1;
}
hook OnGameModeInit()
{
	new 
		string[256];
	for(new i = 0; i < sizeof PayNSpray; i++)
	{
		format(string, sizeof string, "{87b600}Pay 'n' Spray\n{e8e8e8}Kaina: {81df11}$%d\n{e8e8e8}Trukmë: {81df11}15sec\nNaudokite {e35555}/fix", PayNSpray[i][pns_price]);
		PayNSpray[i][pns_label] = CreateDynamic3DTextLabel(string, 0xFFFFFFFF, PayNSpray[i][pns_x], PayNSpray[i][pns_y], PayNSpray[i][pns_z], 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID);
	}
	return 1;
}

CMD:cancelfix(playerid, params[])
{
	if(!player_Fixing[playerid]) return SendWarning(playerid, "Jûs netvarkote savo tr. priemonës!");
	else
	{
		SendFormat(playerid, 0xbababa, "Atðaukëte tr. priemonës tvarkymà. Pinigai negràþinami.");
		StopFixAction(playerid);
	}
	return 1;
}
CMD:fix(playerid, params[])
{
	if(GetPlayerVehicleSeat(playerid) != 0) return SendWarning(playerid, "Turite sedëti vairuotojo vietoje."); 
	for(new i = 0; i < sizeof PayNSpray; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, PayNSpray[i][pns_range], PayNSpray[i][pns_x], PayNSpray[i][pns_y], PayNSpray[i][pns_z]))
		{
			PayNSpray_ShowConfirm(playerid, i);
			return 1;
		}
	}
	SendWarning(playerid, "Nesate Los Santos Pay'n'Spray vietoje!");
	return 1;
}

stock PayNSpray_ShowConfirm(playerid, point)
{
	player_Point[playerid] = point;
	new 
		string[256];
	format(string, sizeof string, "{ffffff}Kaina: $%d\nTrukmë: 15sec\n\nPinigai atðaukus, nutolus ar iðlipus ið maðinos negràþinami.\nAr sutinkate taisyti tr. priemonæ?", PayNSpray[point][pns_price]);
	Dialog_Show(playerid, ConfirmPayNSpray, DIALOG_STYLE_MSGBOX, "Taisymas", string, "Taip", "Ne");
	return 1;
}

Dialog:ConfirmPayNSpray(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new 
			point = player_Point[playerid];
		if(IsPlayerInRangeOfPoint(playerid, PayNSpray[point][pns_range], PayNSpray[point][pns_x], PayNSpray[point][pns_y], PayNSpray[point][pns_z]))
		{
			if(GetPlayerVehicleSeat(playerid) != 0) return SendWarning(playerid, "Turite sedëti vairuotojo vietoje.");
			{
				new 
					vehicleid = GetPlayerVehicleID(playerid),
					factionid = GetFactionArrayIndexById(VehicleInfo[vehicleid][vFaction]);
				if(vehicleid != INVALID_VEHICLE_ID)
				{
					new 
						price = PayNSpray[point][pns_price];
					if(factionid != -1 && (FactionInfo[factionid][fType] == FACTION_TYPE_POLICE || FactionInfo[factionid][fType] == FACTION_TYPE_FIRE))
					{
						SendFormat(playerid, 0xbababaff, "\"%s\" transporto priemonës sutaisymas nemokamas.", GetFactionName(factionid));
					}
					else
					{
						if(sd_GetPlayerMoney(playerid) < price) return InfoBox(playerid, IB_NOT_ENOUGH_MONEY, price);
						sd_GivePlayerMoney(playerid, -price);
					}

					SetTimerEx("T_PayNSpray", 1000, false, "dddd", playerid, vehicleid, point, 15);
					
					player_Fixing[playerid] = true;
					SendFormat(playerid, 0x91e23bFF, "Transporto priemonës tvarkymas prasidëjo! Norëdami atðaukti, raðykite /cancelfix");
					TogglePlayerControllable(playerid, 0);

					printf("[debug] PayNSpray sutiko paint: %s, %d", GetPlayerNameEx(playerid), VehicleInfo[vehicleid][vId]);	
				}
			}
		}
		else SendError(playerid, "Atsitraukëte nuo Pay 'n' Spray taðko!");
	}
	return 1;
}

forward T_PayNSpray(playerid, vehicleid, point, timeleft);
public T_PayNSpray(playerid, vehicleid, point, timeleft)
{
	if(player_Fixing[playerid])
	{
		if(GetPlayerVehicleID(playerid) != vehicleid) return StopFixAction(playerid), SendError(playerid, "Nebesëdite tr. priemonëje, todël tvarkymas atðauktas.");
		if(!IsPlayerInRangeOfPoint(playerid, PayNSpray[point][pns_range], PayNSpray[point][pns_x], PayNSpray[point][pns_y], PayNSpray[point][pns_z])) return StopFixAction(playerid), SendError(playerid, "Atsitraukëte nuo Pay 'n' Spray taðko!");
		if(IsPlayerConnected(playerid))
		{
			if(timeleft <= 0)
			{
				sd_RepairVehicle(vehicleid);
				SendFormat(playerid, 0x91e23bFF, "Sëkmingai sutvarkëte savo transporto priemonæ!");
				StopFixAction(playerid);
			}
			else
			{
				new 
					string[86];
				format(string, sizeof string, "~w~LIKO: ~r~%dS", timeleft);
				GameTextForPlayer(playerid, string, 600, 3);
				SetTimerEx("T_PayNSpray", 1000, false, "dddd", playerid, vehicleid, point, timeleft - 1);
			}
		}
	}
	return 1;
}

static stock StopFixAction(playerid)
{
	// static stock, kad kituose failuose nerodytu sitos f-jos
	TogglePlayerControllable(playerid, 1);
	player_Fixing[playerid] = false;
	return 1;
}