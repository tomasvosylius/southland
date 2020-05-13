#include <YSI_Coding\y_hooks>

static 
    bool:player_EditingFurniture[MAX_PLAYERS],
	player_FurnCat[MAX_PLAYERS],
    player_FurnOwner[MAX_PLAYERS], // [Type]Furniture[<owner>]...
    player_FurnIter[MAX_PLAYERS], // [Type]Furniture[][<iter>]..
    E_FURNITURE_OWNER_TYPE:player_FurnOwnerType[MAX_PLAYERS], // E_FURNITURE_OWNER_TYPE
    E_FURNITURE_PLACE_TYPE:player_FurnPlaceType[MAX_PLAYERS]; // E_FURNITURE_PLACE_TYPE

CMD:furniture(playerid, params[])
{
	new owner = NONE,
        E_FURNITURE_PLACE_TYPE:placeType,
		E_FURNITURE_OWNER_TYPE:ownerType,
		was_inside;

	if( (owner = GetClosestHouse(playerid, 30.0, was_inside, CHECK_TYPE_INSIDE_AND_OUTSIDE)) != NONE && 
        HaveHouseKey(playerid, owner, "P_FurnitureControl"))
	{
		ownerType = furnitureOwner_House;
	}
	/*else if((owner = GetClosestBusiness(playerid, 70.0, CHECK_TYPE_INSIDE)) != INVALID_BUSINESS_ID && 
            HaveBusinessKey(playerid, owner, "P_FurnitureControl"))
	{
		tmpType_Salon[playerid] = 2;
		tmpIter[playerid] = owner;
	}
	else if((owner = GetClosestGarage(playerid, 70.0,   CHECK_TYPE_INSIDE)) != INVALID_GARAGE_ID &&
            GarageInfo[owner][gOwner] == PlayerInfo[playerid][pId])
	{
		tmpType_Salon[playerid] = 3;
		tmpIter[playerid] = owner;
	}*/

	switch(was_inside)
	{	
		case 1: 	/* inside 	*/ placeType = furniturePlace_Inside;
		default:	/* outside 	*/ placeType = furniturePlace_Outside;
	}


	if(owner == NONE) return InfoBox(playerid, "NESATE", "NAME / VERSLE / GARAZE");
	
	_Furniture_Main(playerid, placeType, ownerType, owner);
	return 1;
}
static _Furniture_Main(playerid, E_FURNITURE_PLACE_TYPE:placeType, E_FURNITURE_OWNER_TYPE:ownerType, owner)
{
	dialog_Clear();
	dialog_AddLine("Perþiûrëti esamus baldus");
	dialog_AddLine("Pirkti baldus");

	inline select(response, listitem)
	{
		if(response)
		{
			dialog_Row("Perþiûrëti esamus baldus")	return _Furniture_Owned_ShowList(playerid, placeType, ownerType, owner);
			dialog_Row("Pirkti baldus")				return _Furniture_Buy_ShowCats(playerid, placeType, ownerType, owner);
		}
	}
	dialog_Show(playerid, using inline select, DIALOG_STYLE_LIST, 
		va_return("%s baldai", placeType == furniturePlace_Inside ? ("Vidaus") : ("Lauko")), "Tæsti", "Atðaukti");
	return 1;
}

/** Owned */
static _Furniture_Owned_ShowList(playerid, E_FURNITURE_PLACE_TYPE:placeType, E_FURNITURE_OWNER_TYPE:ownerType, owner)
{
	new bool:found = false;
	dialog_Clear();
	switch(ownerType)
	{
		case furnitureOwner_House:
		{
			foreach(new fur : HouseFurniture[owner])
			{
				if(HouseFurniture[owner][fur][furPlaceType] == placeType)
				{
					found = true;
					dialog_AddLine("%s [objektas: %d]", HouseFurniture[owner][fur][furName], HouseFurniture[owner][fur][furObject]);
				}
			}
		}
		case furnitureOwner_Business:
		{
			foreach(new fur : BusinessFurniture[owner])
			{
				if(BusinessFurniture[owner][fur][furPlaceType] == placeType)
				{
					found = true;
					dialog_AddLine("%s [objektas: %d]", BusinessFurniture[owner][fur][furName], BusinessFurniture[owner][fur][furObject]);
				}
			}
		}
		case furnitureOwner_Garage:
		{
			foreach(new fur : GarageFurniture[owner])
			{
				if(GarageFurniture[owner][fur][furPlaceType] == placeType)
				{
					found = true;
					dialog_AddLine("%s [objektas: %d]", GarageFurniture[owner][fur][furName], GarageFurniture[owner][fur][furObject]);
				}
			}
		}
	}

	if(!found)
	{
		SendError(playerid, "Baldø %s nëra.", placeType == furniturePlace_Inside ? ("viduje") : ("lauke"));
		return _Furniture_Main(playerid, placeType, ownerType, owner);
	}

	inline select(response, listitem)
	{
		if(response)
		{
			new iter = ITER_NONE, count = 0;
			switch(ownerType)
			{
				case furnitureOwner_House:
				{
					foreach(new fur : HouseFurniture[owner])
					{
						if(HouseFurniture[owner][fur][furPlaceType] == placeType)
						{
							if(count >= listitem) { iter = fur; break; }
							count++;
						}
					}
				}
				case furnitureOwner_Business:
				{
					foreach(new fur : BusinessFurniture[owner])
					{
						if(BusinessFurniture[owner][fur][furPlaceType] == placeType)
						{
							if(count >= listitem) { iter = fur; break; }
							count++;
						}
					}
				}
				case furnitureOwner_Garage:
				{
					foreach(new fur : GarageFurniture[owner])
					{
						if(GarageFurniture[owner][fur][furPlaceType] == placeType)
						{
							if(count >= listitem) { iter = fur; break; }
							count++;
						}
					}
				}
			}

			if(iter == ITER_NONE) return SendError(playerid, "Tokio baldo nëra.");
			_Furniture_Owned_ShowDetails(playerid, placeType, ownerType, owner, iter);	
			return 1;
		}
		else _Furniture_Main(playerid, placeType, ownerType, owner);
		return 1;
	}
	dialog_Show(playerid, using inline select, DIALOG_STYLE_LIST, 
		va_return("Turimi %s baldai", placeType == furniturePlace_Inside ? ("vidaus") : ("lauko")), 
		"Rinktis", "Gráþti"
	);
	return 1;
}

static _Furniture_Owned_ShowDetails(playerid, E_FURNITURE_PLACE_TYPE:placeType, E_FURNITURE_OWNER_TYPE:ownerType, owner, iter)
{
	dialog_Clear();
	dialog_AddOption(">", "Keisti pavadinimà");
	dialog_AddOption(">", "Keisti pozicijà");
	dialog_AddOption(">", "{C60000}Parduoti");

	inline select(response, listitem)
	{
		if(response)
		{
			dialog_Row("Keisti pavadinimà")	return _Furniture_Owned_ChangeName(playerid, placeType, ownerType, owner, iter);
			dialog_Row("Keisti pozicijà")	return _Furniture_Owned_ChangePosition(playerid, placeType, ownerType, owner, iter);
			dialog_Row("Parduoti")			return _Furniture_Owned_Sell(playerid, placeType, ownerType, owner, iter);
		}
		else _Furniture_Owned_ShowList(playerid, placeType, ownerType, owner);
	}
	dialog_Show(playerid, using inline select, DIALOG_STYLE_LIST, "Baldo redagavimas", "Tæsti", "Gráþti");
	return 1;
}

static _Furniture_Owned_ChangePosition(playerid, E_FURNITURE_PLACE_TYPE:placeType, E_FURNITURE_OWNER_TYPE:ownerType, owner, iter)
{
	new object = 0;
	switch(ownerType)
	{
		case furnitureOwner_House: 		object = HouseFurniture[owner][iter][furObject];
		case furnitureOwner_Business: 	object = BusinessFurniture[owner][iter][furObject];
		case furnitureOwner_Garage: 	object = GarageFurniture[owner][iter][furObject];
	}

	object && _Furniture_EditObject(playerid, placeType, ownerType, owner, object, iter);
	return 1;
}

static _Furniture_Owned_ChangeName(playerid, E_FURNITURE_PLACE_TYPE:placeType, E_FURNITURE_OWNER_TYPE:ownerType, owner, iter, error[] = "")
{
	dialog_Clear();
	dialog_AddLine("{F1f1f1}Áveskite naujà baldo pavadinimà.");
	dialog_AddLine("{F1f1f1}Ðá pavadinimà matysite tik jûs.");
	dialog_AddErrorLine(error);
	
	inline input(response, listitem)
	{
		if(response)
		{
			if(!(4 <= strlen(dialog_Input()) <= 31))
				return _Furniture_Owned_ChangeName(playerid, placeType, ownerType, owner, iter, .error = "Pavadinimas turi bûti 4-31 simboliø.");
		
			new table[32], furSql;
			switch(ownerType)
			{
				case furnitureOwner_House: { 
					format(table, 32, "houses_furniture");
					furSql = HouseFurniture[owner][iter][furId];
					format(HouseFurniture[owner][iter][furName], 32, dialog_Input());
				}
				case furnitureOwner_Business:{ 
					format(table, 32, "business_furniture");
					furSql = BusinessFurniture[owner][iter][furId];
					format(BusinessFurniture[owner][iter][furName], 32, dialog_Input());
				}
				case furnitureOwner_Garage:{ 
					format(table, 32, "garages_furniture");
					furSql = GarageFurniture[owner][iter][furId];
					format(GarageFurniture[owner][iter][furName], 32, dialog_Input());
				}
			}

			inline updateFurniture()
			{
				MsgSuccess(playerid, "Furniture", "Pavadinimas pakeistas.");
				return 1;
			}
			mysql_tquery_inline(chandler, using inline updateFurniture, "UPDATE `%e` SET `Name`='%e' WHERE id='%d'", table, dialog_Input(), furSql);
		}
		_Furniture_Owned_ShowDetails(playerid, placeType, ownerType, owner, iter);
	}
	dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Baldo redagavimas", "Keisti", "Gráþi");
	return 1;
}

static _Furniture_Owned_Sell(playerid, E_FURNITURE_PLACE_TYPE:placeType, E_FURNITURE_OWNER_TYPE:ownerType, owner, iter)
{
	new price = 0,
		furSql,
		table[32];

	switch(ownerType)
	{
		case furnitureOwner_House: {
			format(table, 32, "houses_furniture");
			furSql = HouseFurniture[owner][iter][furId], price = HouseFurniture[owner][iter][furPrice];
		}
		case furnitureOwner_Business: {
			format(table, 32, "business_furniture");
			furSql = BusinessFurniture[owner][iter][furId], price = BusinessFurniture[owner][iter][furPrice];
		}
		case furnitureOwner_Garage: {
			format(table, 32, "garages_furniture");
			furSql = GarageFurniture[owner][iter][furId], price = GarageFurniture[owner][iter][furPrice];
		}
	}

	dialog_Clear();
	dialog_AddLine("Ar tikrai norite parduoti ðá baldà?");
	dialog_AddLine("Pardavæ gausite $%d", price);

	inline confirm(response, listitem)
	{
		if(response)
		{
			inline deleteFurniture()
			{
				new object;
				switch(ownerType)
				{
					case furnitureOwner_House: {
						object = HouseFurniture[owner][iter][furObject];
						Iter_Remove(HouseFurniture[owner], iter);
					}
					case furnitureOwner_Business: {
						object = BusinessFurniture[owner][iter][furObject];
						Iter_Remove(BusinessFurniture[owner], iter);
					}
					case furnitureOwner_Garage: {
						object = GarageFurniture[owner][iter][furObject];
						Iter_Remove(GarageFurniture[owner], iter);
					}
				}

				IsValidDynamicObject(object) && DestroyDynamicObject(object);

				GivePlayerMoney(playerid, price);
				MsgSuccess(playerid, "Furniture", "Baldas parduotas uþ %d$", price);
				return 1;
			}
			mysql_tquery_inline(chandler, using inline deleteFurniture, "\
				DELETE FROM `%e` WHERE id = '%d'", table, furSql);
		}
		_Furniture_Owned_ShowList(playerid, placeType, ownerType, owner);
	}
	dialog_Show(playerid, using inline confirm, DIALOG_STYLE_MSGBOX, "Baldo pardavimas", "Taip", "Ne");
	return 1;
}

/** Buying */
static _Furniture_Buy_ShowCats(playerid, E_FURNITURE_PLACE_TYPE:placeType, E_FURNITURE_OWNER_TYPE:ownerType, owner)
{
	switch(ownerType)
	{
		case 1:
		{
			// namui
			if( (PlayerInfo[playerid][pDonator] == DONATOR_NONE && House_CountFurniture(owner) >= MAX_HFURNITURE) ||
				(PlayerInfo[playerid][pDonator] == DONATOR_BRONZE && House_CountFurniture(owner) >= MAX_HFURNITURE_BRONZE) ||
				(PlayerInfo[playerid][pDonator] == DONATOR_SILVER && House_CountFurniture(owner) >= MAX_HFURNITURE_SILVER) ||
				(PlayerInfo[playerid][pDonator] == DONATOR_GOLD && House_CountFurniture(owner) >= MAX_HFURNITURE_GOLD))
			{
				SendError(playerid, "Jûs jau esatæ pasiekæs baldø limità. Daugiau apie limitus: www."#PROJECT_NAME"."#PROJECT_DOMAIN"");
				return 1;
			}
		}
		case 2:
		{
			// verslui
			if( (PlayerInfo[playerid][pDonator] == DONATOR_NONE && Business_CountFurniture(owner) >= MAX_BFURNITURE) ||
				(PlayerInfo[playerid][pDonator] == DONATOR_BRONZE && Business_CountFurniture(owner) >= MAX_BFURNITURE_BRONZE) ||
				(PlayerInfo[playerid][pDonator] == DONATOR_SILVER && Business_CountFurniture(owner) >= MAX_BFURNITURE_SILVER) ||
				(PlayerInfo[playerid][pDonator] == DONATOR_GOLD && Business_CountFurniture(owner) >= MAX_BFURNITURE_GOLD))
			{
				SendError(playerid, "Jûs jau esatæ pasiekæs baldø limità. Daugiau apie limitus: www."#PROJECT_NAME"."#PROJECT_DOMAIN"");
				return 1;
			}
		}
		case 3:
		{
			// garazui
			if( (PlayerInfo[playerid][pDonator] == DONATOR_NONE && Garage_CountFurniture(owner) >= MAX_GFURNITURE) ||
				(PlayerInfo[playerid][pDonator] == DONATOR_BRONZE && Garage_CountFurniture(owner) >= MAX_GFURNITURE_BRONZE) ||
				(PlayerInfo[playerid][pDonator] == DONATOR_SILVER && Garage_CountFurniture(owner) >= MAX_GFURNITURE_SILVER) ||
				(PlayerInfo[playerid][pDonator] == DONATOR_GOLD && Garage_CountFurniture(owner) >= MAX_GFURNITURE_GOLD))
			{
				SendError(playerid, "Jûs jau esatæ pasiekæs baldø limità. Daugiau apie limitus: www."#PROJECT_NAME"."#PROJECT_DOMAIN"");
				return 1;
			}
		}
	}

	dialog_Clear();

	switch(placeType)
	{
		case furniturePlace_Inside:
		{
			for(new list = 0; list < sizeof FurnitureListNames_Inside; list++) {
				dialog_AddOption("•", FurnitureListNames_Inside[list]);
			}
		}
		case furniturePlace_Outside:
		{
			new Float:maxRange = FLOAT_NAN;
			switch(ownerType)
			{
				case furnitureOwner_Garage:     maxRange = FLOAT_NAN;
				case furnitureOwner_Business:   maxRange = BusinessInfo[owner][bOutFurnitureRange];
				case furnitureOwner_House:      maxRange = HouseInfo[owner][hOutFurnitureRange];
			}

			if(maxRange != maxRange || maxRange <= 0.0)
				return MsgError(playerid, "Furniture", "Administratorius nëra nustatæs jûsø lauko furniture range.");

			for(new list = 0; list < sizeof FurnitureListNames_Outside; list++) {
				dialog_AddOption("•", FurnitureListNames_Outside[list]);
			}
		}
	}


	inline select(response, listitem)
	{
		if(response)
		{
			_Furniture_Buy_ShowItems(
				playerid,
				placeType, 
				ownerType,
				owner, 
				placeType == furniturePlace_Inside ? (listitem) : (FURNITURE_CATEGORY_OUTSIDE) // hotfix
			);
		}
		else _Furniture_Main(playerid, placeType, ownerType, owner);
	}
	dialog_Show(playerid, using inline select, DIALOG_STYLE_LIST, "Baldø pirkimas", "Tæsti", "Atðaukti");	
	return 1;
}

static _Furniture_Buy_ShowItems(playerid, E_FURNITURE_PLACE_TYPE:placeType, E_FURNITURE_OWNER_TYPE:ownerType, owner, cat)
{
	new items[2048],
		line[86],
		count;

	player_FurnCat[playerid] 		= cat;
	player_FurnOwner[playerid] 		= owner;
	player_FurnOwnerType[playerid] 	= ownerType;
	player_FurnPlaceType[playerid] 	= placeType;

	for(new i = 0; i < sizeof FurnitureList; i++)
	{
		if(FurnitureList[i][furnitureListCategory] == cat)
		{
			format(line, sizeof line, "%i(0.0, 0.0, -45.0, 1.0)\t%s~n~~g~~h~$%d\n", 
				FurnitureList[i][furnitureListModel],
				formatlt(FurnitureList[i][furnitureListName]),
				FurnitureList[i][furnitureListPrice]			
			);
			strcat(items, line);
			count++;
		}
	}

	Prev_ShowPlayerDialog(playerid, 1,
		"Baldu pirkimas",
		items, "Pirkti", "Iseiti"
	);
	return 1;
}

hook OnPreviewModelSelect(playerid, dialogid, response, listitem, inputtext[])
{
	if(response)
	{
		new cat_to_match = player_FurnCat[playerid];
		for(new i = 0, o = 0; i < sizeof FurnitureList; i++)
		{
			if(FurnitureList[i][furnitureListCategory] == cat_to_match)
			{
				if(o >= listitem)
				{
					_Furniture_Buy_ShowDetails(
						playerid, 
						cat_to_match,
						FurnitureList[i][furnitureListModel],
						FurnitureList[i][furnitureListName],
						FurnitureList[i][furnitureListPrice],
						player_FurnPlaceType[playerid],
						player_FurnOwnerType[playerid],
						player_FurnOwner[playerid]
					);
					return 1;
				}
				o++;
			}
		}
	}
	return 1;
}


static _Furniture_Buy_ShowDetails(playerid, category, model, name[], price, E_FURNITURE_PLACE_TYPE:placeType, E_FURNITURE_OWNER_TYPE:ownerType, owner)
{	
	Prev_HidePlayerDialog(playerid);

	dialog_Clear();
	dialog_AddLine("{EFEFEF}Baldo pavadinimas: %s", name);
	dialog_AddLine("{EFEFEF}Baldo kaina: {65CE52}$%d", price);
	dialog_SkipLine();
	if(placeType == furniturePlace_Outside)
	{
		dialog_AddLine("{E97C7C}Bet koks troll objektø sustatymas yra draudþiamas.");
	}
	dialog_AddLine("{9BDF8F}Ar norite pirkti ðá baldà?");
	inline select(response, listitem)
	{
		if(response)
		{
			if(GetPlayerMoney(playerid) < price)
			{
				InfoBox(playerid, IB_NOT_ENOUGH_MONEY, price);
				return _Furniture_Buy_ShowDetails(playerid, category, model, name, price, placeType, ownerType, owner);
			}

			_Furniture_Buy(
				playerid,
				placeType,
				ownerType,
				owner,
				model, 
				price,
				name
			);
			return 1;
		}
		else _Furniture_Buy_ShowItems(playerid, placeType, ownerType, owner, category);
	}
	dialog_Show(playerid, using inline select, DIALOG_STYLE_MSGBOX, "Baldo pirkimas", "Pirkti", "Uþdaryti");
	return 1;
}

static _Furniture_Buy(playerid, E_FURNITURE_PLACE_TYPE:placeType, E_FURNITURE_OWNER_TYPE:ownerType, owner, model, price, name[])
{
	new ownerSql,
        table[32],
		Float:x, Float:y, Float:z,
		vw 	= GetPlayerVirtualWorld(playerid),
		int = GetPlayerInterior(playerid);

	GetPlayerPos(playerid, x, y, z);
	GetXYInFrontOfPlayer(playerid, x, y, .distance = 2.0);

    switch(ownerType)
    {
        case furnitureOwner_House:      format(table, 32, "houses_furniture"),      ownerSql = HouseInfo[owner][hId];
        case furnitureOwner_Business:   format(table, 32, "business_furniture"),    ownerSql = BusinessInfo[owner][bId];
        case furnitureOwner_Garage:     format(table, 32, "garages_furniture"),     ownerSql = GarageInfo[owner][gId];
    }


	inline insertNew()
	{
		if(mysql_errno() == 0)
		{
			new object, iter;
			GivePlayerMoney(playerid, -price);
			MsgSuccess(playerid, "Furniture", "Baldas nupirktas!");

			Furniture_CreateModel(
				.sql 		= cache_insert_id(),
				.ownerType 	= ownerType,
				.owner		= owner,
				.ownerSql	= ownerSql,
				.placeType 	= placeType, 
				.model		= model,
				.name		= name,
				.x			= x,
				.y			= y,
				.z			= z, 
				.rx			= 0.0, 
				.ry			= 0.0, 
				.rz			= 0.0,
				.vw			= vw, 
				.int		= int, 
				.price		= price,
				.ret_iter   = iter,
				.ret_object = object
			);
			_Furniture_EditObject(playerid, placeType, ownerType, owner, object, iter);
		}
		else MsgError(playerid, "Furniture", "Atsirado klaida perkant furniture.");
	}
	ownerSql && mysql_tquery_inline(chandler, using inline insertNew, "\
		INSERT INTO `%e` (`OwnerId`,`Name`,`Price`,`Model`,`PlaceType`,`VW`,`Int`,`X`,`Y`,`Z`,`RX`,`RY`,`RZ`) \
		VALUES \
		('%d','%e','%d','%d','%d','%d','%d','%f','%f','%f','0.0','0.0','0.0')",
		table, 
		ownerSql, name, price, model, _:placeType, vw, int, x, y, z
	);

	return 1;
}

static _Furniture_EditObject(playerid, E_FURNITURE_PLACE_TYPE:placeType, E_FURNITURE_OWNER_TYPE:ownerType, owner, object, iter)
{
	player_EditingFurniture[playerid]	= true;
	player_FurnOwner[playerid]			= owner;
	player_FurnIter[playerid]			= iter;
	player_FurnOwnerType[playerid]		= ownerType;
	player_FurnPlaceType[playerid]		= placeType;
	
	EditDynamicObject(playerid, object);
	SendFormat(playerid, 0xbababaff, "Pastatykite baldà á norimà vietà.");
	return 1;
}

/** Events */
hook OnPlayerEditDynObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
    if(!player_EditingFurniture[playerid]) return 1;
	if(response == EDIT_RESPONSE_FINAL)
	{
		new     
			Float:old_pos[3],
			Float:old_rot[3],
			E_FURNITURE_PLACE_TYPE:place      = player_FurnPlaceType[playerid],
			E_FURNITURE_OWNER_TYPE:ownerType  = player_FurnOwnerType[playerid],
			iter  = player_FurnIter[playerid],
			owner = player_FurnOwner[playerid];

		/* Old cords calc. */
		GetDynamicObjectPos(objectid, old_pos[0], old_pos[1], old_pos[2]);
		GetDynamicObjectRot(objectid, old_rot[0], old_rot[1], old_rot[2]);

		/* Max range calc. */
		new Float:maxRange = FLOAT_NAN;
		switch(place)
		{
			case furniturePlace_Inside:             maxRange = 150.0;
			case furniturePlace_Outside:
			{
				switch(ownerType)
				{
					case furnitureOwner_Garage:     maxRange = FLOAT_NAN;
					case furnitureOwner_Business:   maxRange = BusinessInfo[owner][bOutFurnitureRange];
					case furnitureOwner_House:      maxRange = HouseInfo[owner][hOutFurnitureRange];
				}
			}
		}

		if(GetDistanceBetweenPoints3D(x, y, z, old_pos[0], old_pos[1], old_pos[2]) > maxRange || maxRange != maxRange)
		{
			SetDynamicObjectPos(objectid, old_pos[0], old_pos[1], old_pos[2]);
			SetDynamicObjectRot(objectid, old_rot[0], old_rot[1], old_rot[2]);

			MsgError(playerid, "Furniture", "Baldà pastatei per toli.");
			return 1;
		}
		

		/* Set new coords. */
		new 
			Float:new_pos[3], Float:new_rot[3],
			table[32], furnitureSql = 0;

		new_pos[0] = x, new_pos[1] = y, new_pos[2] = z,
		new_rot[0] = rx, new_rot[1] = ry, new_rot[2] = rz;

		switch(ownerType)
		{
			case furnitureOwner_House: {
				HouseFurniture[owner][iter][furPos] = new_pos,   HouseFurniture[owner][iter][furRot] = new_rot;
				furnitureSql = HouseFurniture[owner][iter][furId], format(table, 32, "houses_furniture");
			}
			case furnitureOwner_Business: {
				BusinessFurniture[owner][iter][furPos] = new_pos,BusinessFurniture[owner][iter][furRot] = new_rot;
				furnitureSql = BusinessFurniture[owner][iter][furId], format(table, 32, "business_furniture");
			}
			case furnitureOwner_Garage: {
				GarageFurniture[owner][iter][furPos] = new_pos,  GarageFurniture[owner][iter][furRot] = new_rot;
				furnitureSql = GarageFurniture[owner][iter][furId], format(table, 32, "garages_furniture");
			}
		}

		SetDynamicObjectPos(objectid, x, y, z);
		SetDynamicObjectRot(objectid, rx, ry, rz);

		inline updateFurniture()
		{
			if(mysql_errno() == 0)
			{
				MsgSuccess(playerid, "Furniture", "Baldas iðsaugotas.");
			}
			else MsgError(playerid, "Furniture", "Atsirado klaida iðsaugant furniture, praneðkite administracijai.");
			return 1;
		}
		strlen(table) && mysql_tquery_inline(chandler, using inline updateFurniture, "\
			UPDATE `%s` SET `X`='%f',`Y`='%f',`Z`='%f',`RX`='%f',`RY`='%f',`RZ`='%f' WHERE id = '%d'",
			table, new_pos[0], new_pos[1], new_pos[2], new_rot[0], new_rot[1], new_rot[2],
			furnitureSql
    	);
	}
    return 1;
}


hook OnPlayerConnect(playerid)
{
	player_FurnCat[playerid] = 0;
	return 1;
}