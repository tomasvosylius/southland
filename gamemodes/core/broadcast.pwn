#include <YSI\y_hooks>
#define SendToBroadcasters(%0,%1);		foreach(new __internalPlayerid : Player) {\
											if(player_Broadcast[__internalPlayerid]) {\
												SendFormat(__internalPlayerid,%0,%1);\
											}\
										}					
#define SendBroadcast(%0,%1); 			foreach(new __internalPlayerid : Player) {\
											if(!ChatsOff[__internalPlayerid][BroadcastChat]) {\
												SendChatMessage(__internalPlayerid,%0,%1);\
											}\
										}

#define MAX_DISTANCE_BETWEEN_BROADCASTERS 	15.0

new 
	broadcast_Status,
	broadcast_Owner,
	broadcast_Timer;
new 
	bool:player_Broadcast[MAX_PLAYERS],
	bool:player_InviteToBroadcast[MAX_PLAYERS],
	player_BroadcastRole[MAX_PLAYERS],
	player_BroadcastAnonimousStr[MAX_PLAYERS][3],
	bool:player_BroadcastAnonimous[MAX_PLAYERS];

new 
	BroadcastRoles[][32] = {
		{" "},
		{"Pa�nekovas"},
		{"Kalbintojas"}
};

CMD:br(playerid, params[])
{
	if(!player_Broadcast[playerid]) return SendError(playerid, "Nesate pakviestas � transliacij�.");
	if(broadcast_Status != 2) return SendError(playerid, "Transliacija dar neprad�ta.");
	if(strlen(params) <= 0) return SendUsage(playerid, "/br [tekstas � eter�]");
	// siunciam visiems
	new 
		string[256],
		name[25];
	if(player_BroadcastAnonimous[playerid])
	{
		format(name, sizeof name, "Anonimas %s", player_BroadcastAnonimousStr[playerid]);
	}
	else 
	{
		format(name, sizeof name, "%s", GetPlayerNameEx(playerid, true, true));
	}
	format(string, sizeof string, "*%s %s: %s", BroadcastRoles[player_BroadcastRole[playerid]], name, params);
	SendBroadcast(0xDEF373FF, string);
	return 1;
}

CMD:createbroadcast(playerid, params[])
{
	if(broadcast_Status != 0) return SendError(playerid, "Transliacij� jau yra ruo�iama arba prad�ta (%s)", GetPlayerNameEx(broadcast_Owner));
	broadcast_Status = 1;
	broadcast_Owner = playerid;
	MsgInfo(playerid, "Transliacija", "Suk�r�te transliacij�. Kai b�site pasiruo��, prad�kite transliacij� naudodami /startbroadcast");
	return 1;
}

CMD:endbroadcast(playerid, params[])
{	
	SendBroadcast(0xC4DE44FF, "* Radijo transliacija baig�si");
	EndBroadcast();
	return 1;
}

CMD:invitetobroadcast(playerid, params[])
{
	if(broadcast_Status == 0) return SendError(playerid, "Transliacija nesukurta. Suk�rimui naudokite /createbroadcast");
	if(broadcast_Owner != playerid) return SendError(playerid, "� transliacij� pa�nekovus gali kviesti tik transliacijos �k�r�jas.");
	new
		receiverid;
	if(sscanf(params,"u",receiverid)) return SendUsage(playerid, "/invitetobroadcast [�aid�jas]");
	if(!IsPlayerInRangeOfPlayer(playerid, receiverid, MAX_DISTANCE_BETWEEN_BROADCASTERS) || !CheckPlayerid(receiverid) || playerid == receiverid) return InfoBox(playerid, IB_NOT_CLOSE_PLAYER);
	if(player_Broadcast[receiverid] || player_InviteToBroadcast[receiverid]) return SendError(playerid, "�aid�jas jau yra transliacijoje arba jau yra pakviestas.");
	player_InviteToBroadcast[receiverid] = true;
	MsgSuccess(playerid, "Transliacija", "Pakvietimas � transliacij� i�si�stas �aid�jui %s.", GetPlayerNameEx(receiverid));
	MsgImportant(receiverid, "Transliacija", "J�s esate kvie�iamas � radijo transliacij�. Naudokite /acceptbroadcast");
	return 1;
}

CMD:kickfrombroadcast(playerid, params[])
{
	if(broadcast_Status == 0) return SendError(playerid, "Transliacija nesukurta. Suk�rimui naudokite /createbroadcast");
	if(broadcast_Owner != playerid) return SendError(playerid, "I� transliacijos pa�nekovus i�mesti gali tik transliacijos �k�r�jas.");
	new
		receiverid;
	if(sscanf(params,"u",receiverid)) return SendUsage(playerid, "/kickfrombroadcast [�aid�jas]");
	if(!IsPlayerInRangeOfPlayer(playerid, receiverid, MAX_DISTANCE_BETWEEN_BROADCASTERS) || !CheckPlayerid(receiverid) || playerid == receiverid) return InfoBox(playerid, IB_NOT_CLOSE_PLAYER);
	if(!player_Broadcast[receiverid] && !player_InviteToBroadcast[receiverid]) return SendError(playerid, "�aid�jas n�ra pakviestas � transliacij�.");
	
	KickFromBroadcast(receiverid);

	MsgSuccess(playerid, "Transliacija", "Pakvietimas � transliacij� �aid�jui %s buvo at�auktas.", GetPlayerNameEx(receiverid));
	MsgImportant(receiverid, "Transliacija", "J�s� kvietimas � radijo transliacij� buvo at�auktas.");
	return 1;
}

CMD:startbroadcast(playerid, params[])
{	
	// tikrinam ar galim startint
	if(broadcast_Status != 1) return SendError(playerid, "Transliacija dar nesukurta arba jau prad�ta.");
	if(broadcast_Owner != playerid) return SendError(playerid, "Radijo transliacij� prad�ti gali tik jos �k�r�jas.");
	broadcast_Status = 2;
	SendToBroadcasters(0xEC2121FF, "[STUDIJA]: Radijo transliacij buvo prad�ta!");
	SendChatMessageToAll(0xC4DE44FF, "* Prasid�jo radijo transliacija ((i�jungti galite naudodami /togglebroadcast))")
	return 1;
}
CMD:togglebroadcast(playerid, params[])
{
	if(player_Broadcast[playerid]) return SendError(playerid, "J�s dalyvaujate transliacijoje, tod�l jos i�jungti negalite.");
	ChatsOff[playerid][BroadcastChat] = !ChatsOff[playerid][BroadcastChat];
	MsgSuccess(playerid, "Transliacija", "%s radijo transliacijos rodym�.", ChatsOff[playerid][BroadcastChat] ? ("�jung�te") : ("I�jung�te"));
	return 1;
}
CMD:setbroadcastrole(playerid, params[])
{	
	if(broadcast_Status != 1) return SendError(playerid, "Transliacija turi b�ti sukurta, ta�iau neprad�ta.");
	if(broadcast_Owner != playerid) return SendError(playerid, "�iuos nustatymus gali keisti tik transliacijos �k�r�jas.");
	new 
		receiverid, roleid;
	if(sscanf(params,"ud",receiverid,roleid) || !(1 <= roleid < sizeof BroadcastRoles))
	{
		SendUsage(playerid, "/setbroadcastanonimous [�aid�jas] [rol� (1-%d)]", sizeof BroadcastRoles - 1);
		SendFormat(playerid, 0xB3B3B3FF, "Galimos rol�s:");
		for(new i = 1; i < sizeof BroadcastRoles; i++)
		{	
			SendFormat(playerid, 0xB3B3B3FF, "%d. %s", i, BroadcastRoles[i]);
		}
		return 1;
	}
	if(!IsPlayerInRangeOfPlayer(playerid, receiverid, MAX_DISTANCE_BETWEEN_BROADCASTERS) || !CheckPlayerid(receiverid) || playerid == receiverid) return InfoBox(playerid, IB_NOT_CLOSE_PLAYER);
	if(!player_Broadcast[receiverid]) return SendError(playerid, "�aid�jas n�ra prisijung�s � transliacij�.");
	player_BroadcastRole[receiverid] = roleid;
	MsgSuccess(playerid, "Transliacija", "Nustat�te �aid�jo %s rol� �: %s", GetPlayerNameEx(receiverid), BroadcastRoles[i]);
	MsgInfo(receiverid, "Transliacija", "J�s� transliacijos rol� nustatyta �: %s", BroadcastRoles[i]);
	return 1;
}

CMD:setbroadcastanonimous(playerid, params[])
{
	if(broadcast_Status != 1) return SendError(playerid, "Transliacija turi b�ti sukurta, ta�iau neprad�ta.");
	if(broadcast_Owner != playerid) return SendError(playerid, "�iuos nustatymus gali keisti tik transliacijos �k�r�jas.");
	new 
		receiverid, chars[3];
	if(sscanf(params,"us[3]",receiverid,chars) || strlen(chars) > 2) return SendUsage(playerid, "/setbroadcastanonimous [�aid�jas] [2 simboli� inicialai]");
	if(!IsPlayerInRangeOfPlayer(playerid, receiverid, MAX_DISTANCE_BETWEEN_BROADCASTERS) || !CheckPlayerid(receiverid) || playerid == receiverid) return InfoBox(playerid, IB_NOT_CLOSE_PLAYER);
	if(!player_Broadcast[receiverid]) return SendError(playerid, "�aid�jas n�ra prisijung�s � transliacij�.");
	if(!player_BroadcastAnonimous[receiverid])
	{
		format(player_BroadcastAnonimousStr[receiverid], 3, chars);
		player_BroadcastAnonimous[receiverid] = true;
		MsgSuccess(playerid, "Transliacija", "�aid�jui %s suteiktas anonimi�kumas, inicialai: %s.", GetPlayerNameEx(receiverid), chars);
		MsgInfo(receiverid, "Transliacija", "Jums suteiktas anonimi�kumas transliacijoje. Duoti inicialai: %s", chars);
	}
	else
	{
		player_BroadcastAnonimous[receiverid] = false;
		MsgSuccess(playerid, "Transliacija", "�aid�jui %s anonimi�kumas pa�alintas.", GetPlayerNameEx(receiverid));
		MsgInfo(receiverid, "Transliacija", "J�s� anonimi�kumas transliacijoje panaikintas.");
	}
	return 1;
}

CMD:acceptbroadcast(playerid, params[])
{
	if(!player_InviteToBroadcast[playerid]) return SendWarning(playerid, "J�s nesate pakviestas � transliacij� arba transliacija nebevyksta.");
	player_InviteToBroadcast[playerid] = false;
	player_Broadcast[playerid] = true;
	player_BroadcastRole[playerid] = 1;
	MsgSuccess(playerid, "Transliacija", "Prisijung�te � transliacij�.");
	SendToBroadcasters(0xE9F57EFF, "[STUDIJA]: %s prisijung� � transliacij�.", GetPlayerNameEx(playerid));
	return 1;
}

hook OnResetPlayerData(playerid)
{
	if(broadcast_Status != 0)
	{
		if(broadcast_Owner == playerid)
		{
			EndBroadcast();
		}
		else
		{
			SendToBroadcasters(0xD98364FF, "[STUDIJA]: %s atsijung� nuo pokalbio.", GetPlayerNameEx(playerid));
		}
		KickFromBroadcast(playerid);
	}
	return 1;
}

stock StartBroadcast()
{
	broadcast_Timer = SetTimer("BroadcastTimer", 2000, false);
}

forward BroadcastTimer();
public BroadcastTimer()
{
	new 
		Float:owner_x, Float:owner_y, Float:owner_z;
	GetPlayerPos(broadcast_Owner, owner_x, owner_y, owner_z);
	foreach(new playerid : Player)
	{
		if(player_Broadcast[playerid])
		{
			if(GetPlayerDistanceFromPoint(playerid, owner_x, owner_y, owner_z) > MAX_DISTANCE_BETWEEN_BROADCASTERS)
			{
				SendToBroadcasters(0xD98364FF, "[STUDIJA]: %s atsijung� nuo pokalbio.", GetPlayerNameEx(playerid));
				KickFromBroadcast(playerid);
			}
		}
	}
	return 1;
}

stock EndBroadcast()
{
	KillTimer(broadcast_Timer);
	broadcast_Status = 0;
	foreach(new playerid : Player)
	{
		if(player_Broadcast[playerid])
		{
			KickFromBroadcast(playerid);
		}
		if(player_InviteToBroadcast[playerid])
		{
			player_InviteToBroadcast[playerid] = false;
		}
	}
	return 1;
}

stock KickFromBroadcast(playerid)
{
	player_Broadcast[playerid] = false;
	player_BroadcastAnonimous[playerid] = false;
	player_BroadcastRole[playerid] = 0;
	player_InviteToBroadcast[receiverid] = false;
	format(player_BroadcastAnonimousStr[playerid], 1, "");
	return 1;
}