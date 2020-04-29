#include <YSI\y_hooks>


stock 
	GIFT_TYPE_DONATOR = 1,
	GIFT_TYPE_NAMECHANGES = 2,
	GIFT_TYPE_VEHICLE = 3,
	GIFT_TYPE_MONEY = 4,
	GIFT_TYPE_STEAM_GIFT = 5;

enum E_CHRISTMAS_GIFTS_DATA 
{ 
	giftId, 
	giftObject, 
	Float:giftX, 
	Float:giftY, 
	Float:giftZ, 
	giftPrizeType,
	giftPrizeValue,
	giftPrizeName[68], 
	giftValid, 
	Text3D:giftLabel 
};
new ChristmasGifts[20][E_CHRISTMAS_GIFTS_DATA],
	ChristmasGiftsCount,
	bool:GiftsEnabled;

flags:togglegifts(CMD_TYPE_ADMIN);
CMD:togglegifts(playerid, params[])
{
	GiftsEnabled = !GiftsEnabled;
	if(GiftsEnabled)
	{
		LoadGifts();
	}
	else 
	{
		for(new i = 0; i < ChristmasGiftsCount; i++)
		{
			if(IsValidDynamic3DTextLabel(ChristmasGifts[i][giftLabel])) DestroyDynamic3DTextLabel(ChristmasGifts[i][giftLabel]);
			if(IsValidDynamicObject(ChristmasGifts[i][giftObject])) DestroyDynamicObject(ChristmasGifts[i][giftObject]);
		
			ChristmasGifts[i][giftId] = 0,
			ChristmasGifts[i][giftValid] = 0,
			ChristmasGifts[i][giftX] = 0.0,
			ChristmasGifts[i][giftX] = 0.0,
			ChristmasGifts[i][giftX] = 0.0;
		}
	}

	SendFormat(playerid, -1, "Dovan� sistema buvo %s", GiftsEnabled ? ("ijungta") : ("isjungta"));
	return 1;
}

static stock LoadGifts()
{
	mysql_tquery(chandler, "SELECT * FROM `gifts`", "OnGiftsLoad", "");
	return 1;
}

CMD:opengift(playerid, params[])
{
	if(AlreadyPickedGift(playerid)) return SendWarning(playerid, "J�s jau esate surad�s dovan�.");
	if(PlayerInfo[playerid][pHoursPlayed] < 2 && PlayerInfo[playerid][pLevel] < 2) return SendWarning(playerid, "J�s nesate pra�aid�s 2 valand�.");
	for(new i = 0; i < ChristmasGiftsCount; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 5.0, ChristmasGifts[i][giftX], ChristmasGifts[i][giftY], ChristmasGifts[i][giftZ]))
		{
			if(ChristmasGifts[i][giftValid] <= 0) return SendWarning(playerid, "�i dovana jau yra atidaryta.");
			printf("[GIFTS] %s picked %d", PlayerInfo[playerid][pId], ChristmasGifts[i][giftId]);

			new 	
				string[512];

			ChristmasGifts[i][giftValid] = 0;

			mysql_format(chandler, string, sizeof string, "UPDATE `gifts` SET Valid = '0', PickedById = '%d', PickedByIp = '%e', PickedByUser = '%d' WHERE id = '%d'", PlayerInfo[playerid][pId], GetPlayerIpEx(playerid), PlayerInfo[playerid][pUserId], ChristmasGifts[i][giftId]);
			mysql_fquery(chandler, string, "GiftSavedEx");

			format(string, sizeof string, "{f9f9f9}Atidar�te kal�din� dovan�!\n\nLaim�jote: {31b51a}%s\n", ChristmasGifts[i][giftPrizeName]);
			if(ChristmasGifts[i][giftPrizeType] == GIFT_TYPE_STEAM_GIFT)
			{
				strcat(string, "{4060c4}* Nor�dami atsiimti dovan�, susisiekite su Old Cases\n");
			}
			else
			{
				if(ChristmasGifts[i][giftPrizeType] == GIFT_TYPE_MONEY)
				{
					sd_GivePlayerMoney(playerid, ChristmasGifts[i][giftPrizeValue]);
				}
				else if(ChristmasGifts[i][giftPrizeType] == GIFT_TYPE_DONATOR)
				{
					PlayerInfo[playerid][pDonator] = ChristmasGifts[i][giftPrizeValue];
				}
				else if(ChristmasGifts[i][giftPrizeType] == GIFT_TYPE_NAMECHANGES)
				{
					PlayerInfo[playerid][pNameChanges] = ChristmasGifts[i][giftPrizeValue];
				}				
				else if(ChristmasGifts[i][giftPrizeType] == GIFT_TYPE_VEHICLE)
				{
					new model = ChristmasGifts[i][giftPrizeValue];

					new 
						query[512];

					mysql_format(chandler, query, sizeof query, "INSERT INTO `vehicles_data` (`Model`,`Salon`,`Owner`,`Name`,`X`,`Y`,`Z`,`A`,`Color1`,`Color2`,`Price`,`Fuel`) VALUES");
					mysql_format(chandler, query, sizeof query, "%s ('%d','-1','%d','%s','1783.01', '-1890.24', '14.39', '0.0','1','1','0','%0.1f','%d')", query, model, PlayerInfo[playerid][pId], GetModelName(model), -1225, float(VehicleFuelCapacityList[model-400]));
					mysql_fquery(chandler, query, "VehicleBoughtEx");

					SendFormat(playerid, 0xFFEB81FF, "Tr. priemon� {F1A829}%s{FFEB81} atsirado j�s� /v list s�ra�e", GetModelName(model));
					SendFormat(playerid, 0xFFEB81FF, "Jos vieta yra Unity Station aik�tel�.");
					if(Checkpoint[playerid] == 0)
					{
						SetPlayerCheckpointEx(playerid, 0, 1783.01, -1890.24, 14.39, 2.3);
						SendFormat(playerid, 0xBABABAFF, "Tr. priemon� atsiras pa�ym�toje vietoje.");	
					}
					PlayerInfo[playerid][pHaveCars]++;
				}
			}
			strcat(string, "\n{d86a27}�ilt� ir gra�i� �ven�i� linki Southland.lt komanda!");

			Dialog_Show(playerid, DialogGiftOpen, DIALOG_STYLE_MSGBOX, "Dovana", string, "Gerai", "");

			SendFormat(playerid, 0xe34a4cff, "Atsi�met� dovan�: %s", ChristmasGifts[i][giftPrizeName]);

			if(IsValidDynamic3DTextLabel(ChristmasGifts[i][giftLabel]))
			{
				format(string, sizeof string, "{23b000}�i� dovan� jau rado kitas �aid�jas!\n{df1f1f}Jis laim�jo: {fcfcfc}%s", ChristmasGifts[i][giftPrizeName]);
				UpdateDynamic3DTextLabelText(ChristmasGifts[i][giftLabel], -1, string);
			}
			return 1;
		}
	}
	SendWarning(playerid, "Nesate arti dovanos.");
	return 1;
}

thread(GiftSavedEx);

static stock AlreadyPickedGift(playerid)
{
	new 
		id = PlayerInfo[playerid][pId],
		string[126];

	mysql_format(chandler, string, sizeof string, "SELECT NULL FROM `gifts` WHERE PickedById = '%d' OR PickedByIp = '%e' OR PickedByUser = '%d'", id, GetPlayerIpEx(playerid), PlayerInfo[playerid][pId]);
	new Cache:result = mysql_query(chandler, string, true);

	if(cache_num_rows())
	{
		cache_delete(result);
		return true;
	}
	cache_delete(result);
	return false;
}

forward OnGiftsLoad();
public OnGiftsLoad()
{
	new 
		string[256];
	ChristmasGiftsCount = cache_num_rows();
	for(new i = 0; i < ChristmasGiftsCount; i++)
	{
		if(i >= sizeof ChristmasGifts) { break; }

		cache_get_value_int(i, "id", ChristmasGifts[i][giftId]);
		cache_get_value_int(i, "Valid", ChristmasGifts[i][giftValid]);

		cache_get_value_int(i, "PrizeType", ChristmasGifts[i][giftPrizeType]);
		cache_get_value_int(i, "PrizeValue", ChristmasGifts[i][giftPrizeValue]);
		cache_get_value_name(i, "PrizeName", ChristmasGifts[i][giftPrizeName], 67);

		cache_get_value_float(i, "X", ChristmasGifts[i][giftX]);
		cache_get_value_float(i, "Y", ChristmasGifts[i][giftY]);
		cache_get_value_float(i, "Z", ChristmasGifts[i][giftZ]);

		if(ChristmasGifts[i][giftValid] >= 1) format(string, sizeof string, "{fcfcfc}DOVANA\n{23b000}Nor�dami atidaryti dovan�, ra�ykite {df1f1f}/opengift");
		else format(string, sizeof string, "{23b000}�i� dovan� jau rado kitas �aid�jas!\n{df1f1f}Jis laim�jo: {fcfcfc}%s", ChristmasGifts[i][giftPrizeName]);

		ChristmasGifts[i][giftLabel] = CreateDynamic3DTextLabel(string, 0xffffffff, ChristmasGifts[i][giftX], ChristmasGifts[i][giftY], ChristmasGifts[i][giftZ] + 0.85, 10.0, .testlos = 1);
		ChristmasGifts[i][giftObject] = CreateDynamicObject(19054, ChristmasGifts[i][giftX], ChristmasGifts[i][giftY], ChristmasGifts[i][giftZ] - 0.2, 0.0, 0.0, 0.0);
	}
	return 1;
}

