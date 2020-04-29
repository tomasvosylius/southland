/*
 *
 * SAN ANDREAS MULTIPLAYER INVENTORY.PWN BY TOMAS TORKQ VOSYLIUS
 * ALL RIGHTS RESERVED
 * 2016
 *
 */
#define INVENTORY_AMOUNT_GREATER_EQUAL 	1
#define INVENTORY_AMOUNT_LESS_EQUAL 	2
#define INVENTORY_AMOUNT_EQUAL 			3
#define INVENTORY_AMOUNT_GREATER 		4
#define INVENTORY_AMOUNT_LESS 			5

stock IsPlayerInventorySlotClear(playerid, slotid)
{
	if(InventoryInfo[playerid][slotid][invId] <= 0 && InventoryInfo[playerid][slotid][invAmount] <= 0) return true;
	return false;
}

stock IsVehicleInventorySlotClear(vehicleid, slotid)
{
	if(VehicleInventory[vehicleid][slotid][invId] <= 0 && VehicleInventory[vehicleid][slotid][invAmount] <= 0) return true;
	return false;
}

stock GetVehicleFreeSlotsCounts(vehicleid)
{
	new count;
	for(new slotid = 0; slotid < MAX_VEHICLE_INVENTORY_SLOTS; slotid++)
	{
		if(VehicleInventory[vehicleid][slotid][invId] <= 0 && VehicleInventory[vehicleid][slotid][invAmount] <= 0)
		{
			count++;
		}
	}
	return count;
}

stock IsHouseInventorySlotClear(houseid, slotid)
{
	if(HouseInventory[houseid][slotid][invId] <= 0 && HouseInventory[houseid][slotid][invAmount] <= 0) return true;
	return false;
}

stock IsInventorySlotClear(playerid, slotid)
{
	if(InventoryInfo[playerid][slotid][invId] <= 0 && InventoryInfo[playerid][slotid][invAmount] <= 0) return true;
	return false;
}

stock IsDealerHouseInventorySlotClear(houseid, slotid)
{
	if(DealerHouseInventory[houseid][slotid][invId] <= 0 && DealerHouseInventory[houseid][slotid][invAmount] <= 0) return true;
	return false;
}

stock GetDealerHouseFreeSlotsCount(houseid)
{
	new count;
	for(new slotid = 0; slotid < MAX_DEALER_HOUSE_INVENTORY_SLOTS; slotid++)
	{
		if(DealerHouseInventory[houseid][slotid][invId] <= 0 && DealerHouseInventory[houseid][slotid][invAmount] <= 0)
		{
			count++;
		}
	}
	return count;
}

stock IsBusinessInventorySlotClear(businessid, slotid)
{
	if(BusinessInventory[businessid][slotid][invId] <= 0 && BusinessInventory[businessid][slotid][invAmount] <= 0) return true;
	return false;
}

stock GetItemSlotInPlayerInventory(playerid, itemid, con = -1, con_value = 0, skip_slot = -1)
{
	for(new i = 0; i < MAX_INVENTORY_SLOTS; i++)
	{
		if(skip_slot != -1 && i == skip_slot) { continue; }
		if(InventoryInfo[playerid][i][invId] == itemid)
		{
			if(con == -1)
			{
				return i;
			}
			else
			{
				switch(con)
				{
					case INVENTORY_AMOUNT_LESS: if(InventoryInfo[playerid][i][invAmount] < con_value) return i;
					case INVENTORY_AMOUNT_GREATER: if(InventoryInfo[playerid][i][invAmount] > con_value) return i;
					case INVENTORY_AMOUNT_LESS_EQUAL: if(InventoryInfo[playerid][i][invAmount] <= con_value) return i;
					case INVENTORY_AMOUNT_GREATER_EQUAL: if(InventoryInfo[playerid][i][invAmount] >= con_value) return i;
					case INVENTORY_AMOUNT_EQUAL: if(InventoryInfo[playerid][i][invAmount] == con_value) return i;
				}
			}
		}
	}
	return -1;
}

stock IsItemInPlayerInventory(playerid, itemid, con = -1, con_value = 0)
{
	for(new i = 0; i < MAX_INVENTORY_SLOTS; i++)
	{
		if(InventoryInfo[playerid][i][invId] == itemid)
		{
			if(con == -1)
			{
				return true;
			}
			else
			{
				switch(con)
				{
					case INVENTORY_AMOUNT_LESS: if(InventoryInfo[playerid][i][invAmount] < con_value) return true;
					case INVENTORY_AMOUNT_GREATER: if(InventoryInfo[playerid][i][invAmount] > con_value) return true;
					case INVENTORY_AMOUNT_LESS_EQUAL: if(InventoryInfo[playerid][i][invAmount] <= con_value) return true;
					case INVENTORY_AMOUNT_GREATER_EQUAL: if(InventoryInfo[playerid][i][invAmount] >= con_value) return true;
					case INVENTORY_AMOUNT_EQUAL: if(InventoryInfo[playerid][i][invAmount] == con_value) return true;
				}
			}
		}
	}
	return false;
}

stock GetItemSlotInVehicleInventory(vehicleid, itemid)
{
	for(new i = 0; i < MAX_VEHICLE_INVENTORY_SLOTS; i++)
	{
		if(VehicleInventory[vehicleid][i][invId] == itemid) return i;
	}
	return -1;
}

stock IsItemInVehicleInventory(vehicleid, itemid)
{
	for(new i = 0; i < MAX_VEHICLE_INVENTORY_SLOTS; i++)
	{
		if(VehicleInventory[vehicleid][i][invId] == itemid) return true;
	}
	return false;
}

stock GetItemSlotInHouseInventory(houseid, itemid)
{
	for(new i = 0; i < MAX_HOUSE_INVENTORY_SLOTS; i++)
	{
		if(HouseInventory[houseid][i][invId] == itemid) return i;
	}
	return -1;
}

stock IsItemInHouseInventory(houseid, itemid)
{
	for(new i = 0; i < MAX_HOUSE_INVENTORY_SLOTS; i++)
	{
		if(HouseInventory[houseid][i][invId] == itemid) return true;
	}
	return false;
}

stock GetItemSlotInBusinessInventory(businessid, itemid)
{
	for(new i = 0; i < MAX_BUSINESS_INVENTORY_SLOTS; i++)
	{
		if(BusinessInventory[businessid][i][invId] == itemid) return i;
	}
	return -1;
}

stock IsItemInBusinessInventory(businessid, itemid)
{
	for(new i = 0; i < MAX_BUSINESS_INVENTORY_SLOTS; i++)
	{
		if(BusinessInventory[businessid][i][invId] == itemid) return true;
	}
	return false;
}

stock GivePlayerInventoryItem(playerid, itemid, amount, extraid = 0, slotid = -1)
{
	if(slotid == -1) slotid = GetPlayerFreeInventorySlot(playerid);
	if(slotid != -1)
	{
		InventoryInfo[playerid][slotid][invId] = itemid;
		InventoryInfo[playerid][slotid][invAmount] = amount;
		InventoryInfo[playerid][slotid][invExtraId] = extraid;
		if(itemid == ITEM_PHONE)
		{
			PlayerInfo[playerid][pPhoneNumber] = (PHONE_DEFAULT_NUMBER + PlayerInfo[playerid][pId]) + (1503);
		}
		return true;
	}
	else return false;
}

stock GiveVehicleInventoryItem(vehicleid, itemid, amount, extraid = 0, slotid = -1)
{
	if(slotid == -1) slotid = GetVehicleFreeInventorySlot(vehicleid);
	if(slotid != -1)
	{
		VehicleInventory[vehicleid][slotid][invId] = itemid;
		VehicleInventory[vehicleid][slotid][invAmount] = amount;
		VehicleInventory[vehicleid][slotid][invExtraId] = extraid;
		return true;
	}
	else return false;
}

stock GiveDealerHouseInventoryItem(houseid, itemid, amount, extraid = 0, slotid = -1)
{
	if(slotid == -1) slotid = GetDealerHouseFreeInventorySlot(houseid);
	if(slotid != -1)
	{
		DealerHouseInventory[houseid][slotid][invId] = itemid;
		DealerHouseInventory[houseid][slotid][invAmount] = amount;
		DealerHouseInventory[houseid][slotid][invExtraId] = extraid;
		return true;
	}
	else return false;
}

stock GiveHouseInventoryItem(houseid, itemid, amount, extraid = 0, slotid = -1)
{
	if(slotid == -1) slotid = GetHouseFreeInventorySlot(houseid);
	if(slotid != -1)
	{
		HouseInventory[houseid][slotid][invId] = itemid;
		HouseInventory[houseid][slotid][invAmount] = amount;
		HouseInventory[houseid][slotid][invExtraId] = extraid;
		return true;
	}
	else return false;
}

stock GetUniqueNumber(itemid, extraid, playerid)
{
	new unique[15];
	switch(itemid)
	{
		case 0..49:
		{
			if(extraid == 0) format(unique, sizeof unique, "NUTRINTAS");
			else format(unique, sizeof unique, ""#DEFAULT_WEAPON_UNIQUE_ID_PREFIX"%d", extraid);
		}
		case ITEM_PHONE: if(playerid != INVALID_PLAYER_ID) format(unique, sizeof unique, "%d", PlayerInfo[playerid][pPhoneNumber]);
		case ITEM_SHELLS: format(unique, sizeof unique, "Nezinomas");
		default:
		{
			if(extraid != 0) format(unique, sizeof unique, "%d", extraid);
			else format(unique, sizeof unique, "Nera");
		}
	}

	return unique;
}

stock GiveBusinessInventoryItem(businessid, itemid, amount, extraid = 0, slotid = -1)
{
	if(slotid == -1) slotid = GetBusinessFreeInventorySlot(businessid);
	if(slotid != -1)
	{
		BusinessInventory[businessid][slotid][invId] = itemid;
		BusinessInventory[businessid][slotid][invAmount] = amount;
		BusinessInventory[businessid][slotid][invExtraId] = extraid;
		return true;
	}
	else return false;
}

stock ClearPlayerInventorySlot(playerid, slotid)
{
	InventoryInfo[playerid][slotid][invId] = 0;
	InventoryInfo[playerid][slotid][invAmount] = 0;
	InventoryInfo[playerid][slotid][invExtraId] = 0;
	return 1;
}

stock ClearVehicleInventorySlot(vehicleid, slotid)
{
	VehicleInventory[vehicleid][slotid][invId] = 0;
	VehicleInventory[vehicleid][slotid][invAmount] = 0;
	VehicleInventory[vehicleid][slotid][invExtraId] = 0;
	return 1;
}

stock ClearHouseInventorySlot(houseid, slotid)
{
	HouseInventory[houseid][slotid][invId] = 0;
	HouseInventory[houseid][slotid][invAmount] = 0;
	HouseInventory[houseid][slotid][invExtraId] = 0;
	return 1;
}

stock ClearDealerHouseInventorySlot(houseid, slotid)
{
	DealerHouseInventory[houseid][slotid][invId] = 0;
	DealerHouseInventory[houseid][slotid][invAmount] = 0;
	DealerHouseInventory[houseid][slotid][invExtraId] = 0;
	return 1;
}

stock ClearBusinessInventorySlot(businessid, slotid)
{
	BusinessInventory[businessid][slotid][invId] = 0;
	BusinessInventory[businessid][slotid][invAmount] = 0;
	BusinessInventory[businessid][slotid][invExtraId] = 0;
	return 1;
}

stock ResetPlayerInventory(playerid)
{
	for(new slot = 0; slot < MAX_INVENTORY_SLOTS; slot++)
	{
		ClearPlayerInventorySlot(playerid, slot);
	}
	return 1;
}

stock GetPlayerFreeInventorySlot(playerid)
{
	for(new i = 0; i < MAX_INVENTORY_SLOTS; i++)
	{
		if(IsPlayerInventorySlotClear(playerid, i))
		{
			return i;
		}
	}
	return -1;
}

stock GetVehicleFreeInventorySlot(vehicleid)
{
	for(new i = 0; i < MAX_VEHICLE_INVENTORY_SLOTS; i++)
	{
		if(IsVehicleInventorySlotClear(vehicleid, i))
		{
			return i;
		}
	}
	return -1;
}

stock GetDealerHouseFreeInventorySlot(houseid)
{
	for(new i = 0; i < MAX_DEALER_HOUSE_INVENTORY_SLOTS; i++)
	{
		if(IsDealerHouseInventorySlotClear(houseid, i))
		{
			return i;
		}
	}
	return -1;
}

stock GetHouseFreeInventorySlot(houseid)
{
	for(new i = 0; i < MAX_HOUSE_INVENTORY_SLOTS; i++)
	{
		if(IsHouseInventorySlotClear(houseid, i))
		{
			return i;
		}
	}
	return -1;
}

stock GetBusinessFreeInventorySlot(businessid)
{
	for(new i = 0; i < MAX_BUSINESS_INVENTORY_SLOTS; i++)
	{
		if(IsBusinessInventorySlotClear(businessid, i))
		{
			return i;
		}
	}
	return -1;
}


stock GetInventoryItemName(itemid)
{
	new name[24];
	switch(itemid)
	{
		case 0..46: 
		{
			format(name, sizeof name, "%s", WeaponNames[itemid]);
		}
		case ITEM_PHONE: name = "Mob. telefonas";
		case ITEM_CIGARETTE: name = "Cigaretës";
		case ITEM_RADIO: name = "Racija";
		case ITEM_LIGHTER: name = "Þiebtuvëlis";
		case ITEM_COCAINE: name = "Kokainas";
		case ITEM_HEROINE: name = "Heroinas";
		case ITEM_MARIJUANA: name = "Kanapës";
		case ITEM_MDMA: name = "Ekstazi";
		case ITEM_CRACK: name = "Krekas";
		case ITEM_METHAMPHETAMINE: name = "Metamfetaminas";
		case ITEM_GUM: name = "Kramtomoji guma";
		case ITEM_SHELLS: name = "Gilzës";
		case ITEM_WOOL: name = "Vata";
		case ITEM_SYRINGE: name = "Ðvirkðtas";
		case ITEM_DICE: name = "Kauliukai";
		case ITEM_SPRUNK: name = "Sprunk";
		case ITEM_WINE: name = "Vynas";
		case ITEM_BEER: name = "Alus";
		case ITEM_MASK: name = "Veido kaukë";
		case ITEM_CAR_AUDIO: name = "Auto magnetola";
		case ITEM_HOUSE_AUDIO: name = "Audio aparatûra";
		case ITEM_ROD: name = "Meðkerë";
		case ITEM_BAIT: name = "Masalas";
		case ITEM_XANAX: name = "Xanax";
		case ITEM_FUEL: name = "Degalø bakelis";
		case ITEM_TOOLBOX: name = "Árankiø dëþutë";
		default: name[0] = EOS;
	}
	return name;
}

stock SetPlayerInventoryItemAmount(playerid, slot, amount)
{
	InventoryInfo[playerid][slot][invAmount] = amount;
	if(InventoryInfo[playerid][slot][invAmount] <= 0) ClearPlayerInventorySlot(playerid, slot);
	return 1;
}

stock GetInventoryItemObject(itemid)
{
	switch(itemid)
	{
		case 0..46: return WeaponObjects[itemid];
		case ITEM_PHONE: return 18868;
		case ITEM_CIGARETTE: return 19896;
		case ITEM_LIGHTER: return 19998;
		case ITEM_RADIO: return 19942;
		case ITEM_COCAINE: return 1575;
		case ITEM_HEROINE: return 1580;
		case ITEM_MARIJUANA: return 1578;
		case ITEM_MDMA: return 1579;
		case ITEM_CRACK: return 1577;
		case ITEM_METHAMPHETAMINE: return 1576;
		case ITEM_GUM: return 19567;
		//case ITEM_SHELLS: return ;
		case ITEM_WOOL: return 327;
		case ITEM_SYRINGE: return 18644;
		case ITEM_DICE: return 1851;
		case ITEM_SPRUNK: return 2601;
		case ITEM_WINE: return 1664;
		case ITEM_BEER: return 1509;
		case ITEM_MASK: return 19801;
		case ITEM_CAR_AUDIO: return 2226;
		case ITEM_HOUSE_AUDIO: return 2103;
		case ITEM_ROD: return 18632;
		case ITEM_BAIT: return 2038;
		case ITEM_XANAX: return 11748;
		case ITEM_FUEL: return 1650;
		case ITEM_TOOLBOX: return 11748;
		default: return 18631;
	}
	return 0;
}

stock GetInventoryItemUnique(itemid, uniqueid)
{
	new string[56];
	switch(itemid)
	{
		case ITEM_PHONE: format(string, sizeof string, "%d", uniqueid);
	}
	return string;
}

stock Vehicle_DropItem(playerid, vehicleid, slotid, bool:addDrop)
{
	new droppeditemsidx = Iter_Free(DroppedItem);
	if(droppeditemsidx != MAX_DROPPED_ITEMS && addDrop)
	{
		new itemid = VehicleInventory[vehicleid][slotid][invId];
		if(itemid == ITEM_PHONE) return ClearPlayerInventorySlot(playerid, slotid);
		new Float:x, 
			Float:y, 
			Float:z;
		GetPlayerPos(playerid, x, y, z);

		if(IsValidDynamicObject(DroppedItems[droppeditemsidx][droppedItemObject]))
		{
			DestroyDynamicObject(DroppedItems[droppeditemsidx][droppedItemObject]);
		}
		if(CreateItem(x, y, z, GetInventoryItemObject(itemid), DroppedItems[droppeditemsidx][droppedItemObject], playerid, .addrotationx = (itemid <= 46 ? 96.0 : 0.0), .addrotationy = (itemid <= 46 ? 112.9 : 0.0)))
		{
			DroppedItems[droppeditemsidx][droppedItemX] = x;
			DroppedItems[droppeditemsidx][droppedItemY] = y;
			DroppedItems[droppeditemsidx][droppedItemZ] = z;
		}
		else
		{
			DroppedItems[droppeditemsidx][droppedItemObject] = CreateDynamicObject(GetInventoryItemObject(itemid), x, y, z-0.65, (itemid <= 46 ? 96.0 : 0.0), (itemid <= 46 ? 112.9 : 0.0), 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1, 30.0, 30.0);
			DroppedItems[droppeditemsidx][droppedItemX] = x;
			DroppedItems[droppeditemsidx][droppedItemY] = y;
			DroppedItems[droppeditemsidx][droppedItemZ] = z-0.5;
		}
		DroppedItems[droppeditemsidx][droppedItemId] = itemid;
		DroppedItems[droppeditemsidx][droppedItemAmount] = VehicleInventory[vehicleid][slotid][invAmount];
		DroppedItems[droppeditemsidx][droppedItemExtraId] = VehicleInventory[vehicleid][slotid][invExtraId];
		DroppedItems[droppeditemsidx][droppedItemPlayerId] = PlayerInfo[playerid][pId];
		DroppedItems[droppeditemsidx][droppedItemTime] = gettime();
		if(GetGVarInt("EnabledDroppedItemsSaving", SERVER_VARS_ID))
		{
			new string[256];
			mysql_format(chandler, string, sizeof string, "INSERT INTO `drops_data` (PlayerId,Unix,ItemId,ItemAmount,ItemExtraId,X,Y,Z,Valid,Interior,VW) VALUES ('%d','%d','%d','%d','%d','%f','%f','%f','1','%d','%d')", PlayerInfo[playerid][pId], gettime(), itemid, VehicleInventory[vehicleid][slotid][invAmount], VehicleInventory[vehicleid][slotid][invExtraId], x, y, z, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
			mysql_tquery(chandler, string, "DroppedItemAdded", "d", droppeditemsidx);
		}
		Iter_Add(DroppedItem, droppeditemsidx);
	}
	ClearVehicleInventorySlot(vehicleid, slotid);
	return 1;
}

stock Player_DropItem(playerid, slotid, bool:addDrop)
{
	new droppeditemsidx = Iter_Free(DroppedItem);
	if(droppeditemsidx != MAX_DROPPED_ITEMS && addDrop)
	{
		new itemid = InventoryInfo[playerid][slotid][invId];
		if(itemid == ITEM_PHONE) return ClearPlayerInventorySlot(playerid, slotid);
		new Float:x,
			Float:y,
			Float:z;
		GetPlayerPos(playerid, x, y, z);

		if(IsValidDynamicObject(DroppedItems[droppeditemsidx][droppedItemObject]))
		{
			DestroyDynamicObject(DroppedItems[droppeditemsidx][droppedItemObject]);
		}
		if(CreateItem(x, y, z, GetInventoryItemObject(itemid), DroppedItems[droppeditemsidx][droppedItemObject], playerid, .addrotationx = (itemid <= 46 ? 96.0 : 0.0), .addrotationy = (itemid <= 46 ? 112.9 : 0.0)))
		{
			DroppedItems[droppeditemsidx][droppedItemX] = x;
			DroppedItems[droppeditemsidx][droppedItemY] = y;
			DroppedItems[droppeditemsidx][droppedItemZ] = z;
		}
		else
		{
			DroppedItems[droppeditemsidx][droppedItemObject] = CreateDynamicObject(GetInventoryItemObject(itemid), x, y, z-0.79, (itemid <= 46 ? 96.0 : 0.0), (itemid <= 46 ? 112.9 : 0.0), 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1, 30.0, 30.0);
			DroppedItems[droppeditemsidx][droppedItemX] = x;
			DroppedItems[droppeditemsidx][droppedItemY] = y;
			DroppedItems[droppeditemsidx][droppedItemZ] = z-0.5;
		}
		DroppedItems[droppeditemsidx][droppedItemId] = itemid;
		DroppedItems[droppeditemsidx][droppedItemAmount] = InventoryInfo[playerid][slotid][invAmount];
		DroppedItems[droppeditemsidx][droppedItemExtraId] = InventoryInfo[playerid][slotid][invExtraId];
		DroppedItems[droppeditemsidx][droppedItemPlayerId] = PlayerInfo[playerid][pId];
		DroppedItems[droppeditemsidx][droppedItemTime] = gettime();
		if(GetGVarInt("EnabledDroppedItemsSaving", SERVER_VARS_ID))
		{
			new string[256];
			mysql_format(chandler, string, sizeof string, "INSERT INTO `drops_data` (PlayerId,Unix,ItemId,ItemAmount,ItemExtraId,X,Y,Z,Valid,Interior,VW) VALUES ('%d','%d','%d','%d','%d','%f','%f','%f','1','%d','%d')", PlayerInfo[playerid][pId], gettime(), itemid, InventoryInfo[playerid][slotid][invAmount], InventoryInfo[playerid][slotid][invExtraId], x, y, z, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
			mysql_tquery(chandler, string, "DroppedItemAdded", "d", droppeditemsidx);
		}
		Iter_Add(DroppedItem, droppeditemsidx);
	}
	ClearPlayerInventorySlot(playerid, slotid);
	return 1;
}

forward DroppedItemAdded(itter);
public DroppedItemAdded(itter)
{
	DroppedItems[itter][droppedItemMysqlId] = cache_insert_id();
	return 1;
}

enum E_EXTRA_INFORMATION 
{ 
	extraItemId,
	extraString[126]
};

new ExtraItemInformation[][E_EXTRA_INFORMATION] = 
{
	{1, "ÐALTASIS GINKLAS"},
	{4, "ÐALTASIS GINKLAS"},
	{8, "ÐALTASIS GINKLAS"},
	{22, "KALIBRAS: 9mm"},
	{23, "KALIBRAS: 9mm"},
	{24, "KALIBRAS: .50AE"},
	{25, "KALIBRAS: 12 gauge"},
	{26, "KALIBRAS: 15.6mm"},
	{27, "KALIBRAS: 12 gauge"},
	{28, "KALIBRAS: 9mm"},
	{29, "KALIBRAS: 9mm"},
	{30, "KALIBRAS: 7,62x39 mm"},
	{31, "KALIBRAS: 5.56x45mm NATO"},
	{32, "KALIBRAS: 9mm"},
	{33, "KALIBRAS: .22"},
	{34, "KALIBRAS: .308"},
	{38, "KALIBRAS: 7.62x51mm NATO"},
	{ITEM_SHELLS, "Ginklo ðoviniø gilzës. Norëdami jas iðtirti, vykite á komisariatà ir panaudokite jas."}
};

stock ItemHaveAnyExtraInformation(itemid)
{
	for(new i = 0; i < sizeof ExtraItemInformation; i++)
	{
		if(ExtraItemInformation[i][extraItemId] == itemid) return true;
	}
	return false;
}

stock GetItemExtraInformation(itemid)
{
	new extra[126] = " ";
	for(new i = 0; i < sizeof ExtraItemInformation; i++)
	{
		if(ExtraItemInformation[i][extraItemId] == itemid)
		{
			format(extra, sizeof extra, ExtraItemInformation[i][extraString]);
			break;
		}
	}
	return extra;
}