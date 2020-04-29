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
		{"Paðnekovas"},
		{"Kalbintojas"}
};

CMD:br(playerid, params[])
{
	if(!player_Broadcast[playerid]) return SendError(playerid, "Nesate pakviestas á transliacijà.");
	if(broadcast_Status != 2) return SendError(playerid, "Transliacija dar nepradëta.");
	if(strlen(params) <= 0) return SendUsage(playerid, "/br [tekstas á eterá]");
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
	if(broadcast_Status != 0) return SendError(playerid, "Transliacijà jau yra ruoðiama arba pradëta (%s)", GetPlayerNameEx(broadcast_Owner));
	broadcast_Status = 1;
	broadcast_Owner = playerid;
	MsgInfo(playerid, "Transliacija", "Sukûrëte transliacijà. Kai bûsite pasiruoðæ, pradëkite transliacijà naudodami /startbroadcast");
	return 1;
}

CMD:endbroadcast(playerid, params[])
{	
	SendBroadcast(0xC4DE44FF, "* Radijo transliacija baigësi");
	EndBroadcast();
	return 1;
}

CMD:invitetobroadcast(playerid, params[])
{
	if(broadcast_Status == 0) return SendError(playerid, "Transliacija nesukurta. Sukûrimui naudokite /createbroadcast");
	if(broadcast_Owner != playerid) return SendError(playerid, "Á transliacijà paðnekovus gali kviesti tik transliacijos ákûrëjas.");
	new
		receiverid;
	if(sscanf(params,"u",receiverid)) return SendUsage(playerid, "/invitetobroadcast [þaidëjas]");
	if(!IsPlayerInRangeOfPlayer(playerid, receiverid, MAX_DISTANCE_BETWEEN_BROADCASTERS) || !CheckPlayerid(receiverid) || playerid == receiverid) return InfoBox(playerid, IB_NOT_CLOSE_PLAYER);
	if(player_Broadcast[receiverid] || player_InviteToBroadcast[receiverid]) return SendError(playerid, "Þaidëjas jau yra transliacijoje arba jau yra pakviestas.");
	player_InviteToBroadcast[receiverid] = true;
	MsgSuccess(playerid, "Transliacija", "Pakvietimas á transliacijà iðsiøstas þaidëjui %s.", GetPlayerNameEx(receiverid));
	MsgImportant(receiverid, "Transliacija", "Jûs esate kvieèiamas á radijo transliacijà. Naudokite /acceptbroadcast");
	return 1;
}

CMD:kickfrombroadcast(playerid, params[])
{
	if(broadcast_Status == 0) return SendError(playerid, "Transliacija nesukurta. Sukûrimui naudokite /createbroadcast");
	if(broadcast_Owner != playerid) return SendError(playerid, "Ið transliacijos paðnekovus iðmesti gali tik transliacijos ákûrëjas.");
	new
		receiverid;
	if(sscanf(params,"u",receiverid)) return SendUsage(playerid, "/kickfrombroadcast [þaidëjas]");
	if(!IsPlayerInRangeOfPlayer(playerid, receiverid, MAX_DISTANCE_BETWEEN_BROADCASTERS) || !CheckPlayerid(receiverid) || playerid == receiverid) return InfoBox(playerid, IB_NOT_CLOSE_PLAYER);
	if(!player_Broadcast[receiverid] && !player_InviteToBroadcast[receiverid]) return SendError(playerid, "Þaidëjas nëra pakviestas á transliacijà.");
	
	KickFromBroadcast(receiverid);

	MsgSuccess(playerid, "Transliacija", "Pakvietimas á transliacijà þaidëjui %s buvo atðauktas.", GetPlayerNameEx(receiverid));
	MsgImportant(receiverid, "Transliacija", "Jûsø kvietimas á radijo transliacijà buvo atðauktas.");
	return 1;
}

CMD:startbroadcast(playerid, params[])
{	
	// tikrinam ar galim startint
	if(broadcast_Status != 1) return SendError(playerid, "Transliacija dar nesukurta arba jau pradëta.");
	if(broadcast_Owner != playerid) return SendError(playerid, "Radijo transliacijà pradëti gali tik jos ákûrëjas.");
	broadcast_Status = 2;
	SendToBroadcasters(0xEC2121FF, "[STUDIJA]: Radijo transliacij buvo pradëta!");
	SendChatMessageToAll(0xC4DE44FF, "* Prasidëjo radijo transliacija ((iðjungti galite naudodami /togglebroadcast))")
	return 1;
}
CMD:togglebroadcast(playerid, params[])
{
	if(player_Broadcast[playerid]) return SendError(playerid, "Jûs dalyvaujate transliacijoje, todël jos iðjungti negalite.");
	ChatsOff[playerid][BroadcastChat] = !ChatsOff[playerid][BroadcastChat];
	MsgSuccess(playerid, "Transliacija", "%s radijo transliacijos rodymà.", ChatsOff[playerid][BroadcastChat] ? ("Ájungëte") : ("Iðjungëte"));
	return 1;
}
CMD:setbroadcastrole(playerid, params[])
{	
	if(broadcast_Status != 1) return SendError(playerid, "Transliacija turi bûti sukurta, taèiau nepradëta.");
	if(broadcast_Owner != playerid) return SendError(playerid, "Ðiuos nustatymus gali keisti tik transliacijos ákûrëjas.");
	new 
		receiverid, roleid;
	if(sscanf(params,"ud",receiverid,roleid) || !(1 <= roleid < sizeof BroadcastRoles))
	{
		SendUsage(playerid, "/setbroadcastanonimous [þaidëjas] [rolë (1-%d)]", sizeof BroadcastRoles - 1);
		SendFormat(playerid, 0xB3B3B3FF, "Galimos rolës:");
		for(new i = 1; i < sizeof BroadcastRoles; i++)
		{	
			SendFormat(playerid, 0xB3B3B3FF, "%d. %s", i, BroadcastRoles[i]);
		}
		return 1;
	}
	if(!IsPlayerInRangeOfPlayer(playerid, receiverid, MAX_DISTANCE_BETWEEN_BROADCASTERS) || !CheckPlayerid(receiverid) || playerid == receiverid) return InfoBox(playerid, IB_NOT_CLOSE_PLAYER);
	if(!player_Broadcast[receiverid]) return SendError(playerid, "Þaidëjas nëra prisijungæs á transliacijà.");
	player_BroadcastRole[receiverid] = roleid;
	MsgSuccess(playerid, "Transliacija", "Nustatëte þaidëjo %s rolæ á: %s", GetPlayerNameEx(receiverid), BroadcastRoles[i]);
	MsgInfo(receiverid, "Transliacija", "Jûsø transliacijos rolë nustatyta á: %s", BroadcastRoles[i]);
	return 1;
}

CMD:setbroadcastanonimous(playerid, params[])
{
	if(broadcast_Status != 1) return SendError(playerid, "Transliacija turi bûti sukurta, taèiau nepradëta.");
	if(broadcast_Owner != playerid) return SendError(playerid, "Ðiuos nustatymus gali keisti tik transliacijos ákûrëjas.");
	new 
		receiverid, chars[3];
	if(sscanf(params,"us[3]",receiverid,chars) || strlen(chars) > 2) return SendUsage(playerid, "/setbroadcastanonimous [þaidëjas] [2 simboliø inicialai]");
	if(!IsPlayerInRangeOfPlayer(playerid, receiverid, MAX_DISTANCE_BETWEEN_BROADCASTERS) || !CheckPlayerid(receiverid) || playerid == receiverid) return InfoBox(playerid, IB_NOT_CLOSE_PLAYER);
	if(!player_Broadcast[receiverid]) return SendError(playerid, "Þaidëjas nëra prisijungæs á transliacijà.");
	if(!player_BroadcastAnonimous[receiverid])
	{
		format(player_BroadcastAnonimousStr[receiverid], 3, chars);
		player_BroadcastAnonimous[receiverid] = true;
		MsgSuccess(playerid, "Transliacija", "Þaidëjui %s suteiktas anonimiðkumas, inicialai: %s.", GetPlayerNameEx(receiverid), chars);
		MsgInfo(receiverid, "Transliacija", "Jums suteiktas anonimiðkumas transliacijoje. Duoti inicialai: %s", chars);
	}
	else
	{
		player_BroadcastAnonimous[receiverid] = false;
		MsgSuccess(playerid, "Transliacija", "Þaidëjui %s anonimiðkumas paðalintas.", GetPlayerNameEx(receiverid));
		MsgInfo(receiverid, "Transliacija", "Jûsø anonimiðkumas transliacijoje panaikintas.");
	}
	return 1;
}

CMD:acceptbroadcast(playerid, params[])
{
	if(!player_InviteToBroadcast[playerid]) return SendWarning(playerid, "Jûs nesate pakviestas á transliacijà arba transliacija nebevyksta.");
	player_InviteToBroadcast[playerid] = false;
	player_Broadcast[playerid] = true;
	player_BroadcastRole[playerid] = 1;
	MsgSuccess(playerid, "Transliacija", "Prisijungëte á transliacijà.");
	SendToBroadcasters(0xE9F57EFF, "[STUDIJA]: %s prisijungë á transliacijà.", GetPlayerNameEx(playerid));
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
			SendToBroadcasters(0xD98364FF, "[STUDIJA]: %s atsijungë nuo pokalbio.", GetPlayerNameEx(playerid));
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
				SendToBroadcasters(0xD98364FF, "[STUDIJA]: %s atsijungë nuo pokalbio.", GetPlayerNameEx(playerid));
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