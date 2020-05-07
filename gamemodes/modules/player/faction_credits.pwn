#include <YSI_Coding\y_hooks>

#define MAX_WEAPONS_PER_WEEK    3
#define DAYS_TO_REROLL_WEAPONS  7

static 
    player_FactionCredits[MAX_PLAYERS],
    player_LastSeenMsg[MAX_PLAYERS];

static enum E_DEALER_WEAPONS
{
    dw_WeaponId,
    dw_WeaponAmmo,
    dw_PriceBase,
    dw_PriceRandom,
    dw_PriceCredits,
    dw_Chance
};
static 
    dealer_WeaponsList[][E_DEALER_WEAPONS] = {
        // [Weapon]             [Ammo]  [Base, random] Price, Credits price  [Chance(susideda visi ir pasidalina)]
        {WEAPON_DEAGLE,         30,     5000,  2000,          2,  15},
        {WEAPON_COLT45,         40,     3000,  1200,          1,  20},
        {WEAPON_SHOTGUN,        30,     8000,  2000,          2,  15},
        {WEAPON_BRASSKNUCKLE,   1,      500,   100,           0,  5},
        {WEAPON_AK47,           90,     12000, 3000,          3,  10},
        {WEAPON_MP5,            100,    10000, 2000,          2,  15},
        {WEAPON_TEC9,           120,    9000,  2000,          2,  20}
};

static  dealer_WeaponsSelected[MAX_WEAPONS_PER_WEEK],
        dealer_WeaponsSelected_Price[MAX_WEAPONS_PER_WEEK];

static enum E_DEALER_PLACES
{
    Float:dealerActorPos[4],
    Float:dealerVehiclePos[4]
};
static dealer_Places[][E_DEALER_PLACES] = {
    {
        {1430.1309,217.3752,19.5618,351.0}, {1429.5525,214.2907,19.6808, 167.5178} // MG
    },
    {
        {41.2671,-285.8699,1.9725,348.0}, {40.6633,-288.9288,2.1139,167.0} // BB
    },
    {
        {1321.5529,205.1030,19.5547,114.5618}, {1324.5160,206.2788,19.6767,293.9687}
    },
    {
        {2318.2878,-61.1998,26.4844,189.0906}, {2317.8521,-58.0806,26.6074,6.0171}
    },
    {
        {-81.4395,-1548.2616,2.6107,171.3518}, {-81.0286,-1545.1213,2.7351,354.2431}
    }
};
static
    dealer_PlaceIndex = NONE,
    dealer_Actor = INVALID_ACTOR_ID, dealer_Vehicle = INVALID_VEHICLE_ID;

/* Events */
hook OnServerOptionsLoad()
{  
    _BlackMarket_CheckDays(.add = 0);
}

hook OnNewDay()
{
    _BlackMarket_CheckDays();
    return 1;
}
static _BlackMarket_CheckDays(add = -1)
{
    new days = GetGVarInt("DAYS_REROLL_GUNS", SERVER_VARS_ID) + add;
    if(days <= 0)
    {
        _GunDealer_RerollWeapons();
        days = DAYS_TO_REROLL_WEAPONS;
    }

    SetGVarInt("DAYS_REROLL_GUNS", days, SERVER_VARS_ID);
    SaveServerIntEx("DAYS_REROLL_GUNS", days);

    // new days = GetGVarInt("DAYS_REROLL_GUNS", SERVER_VARS_ID) - 1;

    // if(days <= 0)
    // {
    //     SetGVarInt("DAYS_REROLL_GUNS", 7, SERVER_VARS_ID);
    //     _GunDealer_RerollWeapons(.save = true);
    // }
    // else SetGVarInt("DAYS_REROLL_GUNS", 7, SERVER_VARS_ID);
    return 1;
}


hook OnGameModeInit()
{
    _GunDealer_RerollWeapons();
    _GunDealer_RerollPlace();
    return 1;
}

hook OnFullPayday()
{  
    _GunDealer_RerollPlace();
    return 1;
}

static _GunDealer_RerollPlace()
{
    IsValidActor(dealer_Actor) && DestroyActor(dealer_Actor);
    IsValidVehicle(dealer_Vehicle) && DestroyVehicle(dealer_Vehicle);

    new index = NONE;
    while(index == NONE || index == dealer_PlaceIndex)
    {
        index = random(sizeof dealer_Places);
    }
    dealer_PlaceIndex = index;

    // AddServerVehicle(model, factionid, jobid, addedby, Float:x, Float:y, Float:z, Float:a, color1 = -1, color2 = -1, price, addsiren = 0, respawntime = -1, bool:added_by_admin = true, bool:add_to_mysql = true)

    dealer_Vehicle  = AddServerVehicle(
        482,
        0,
        0,
        0,
        dealer_Places[index][dealerVehiclePos][0],
        dealer_Places[index][dealerVehiclePos][1],
        dealer_Places[index][dealerVehiclePos][2],
        dealer_Places[index][dealerVehiclePos][3],
        70, 70,
        0, 0,
        .added_by_admin = true,
        .add_to_mysql = false
    );

    VehicleInfo[dealer_Vehicle][vFaction] = -999;
    VehicleInfo[dealer_Vehicle][vLocked] = true;
    SetVehicleParamsEx(dealer_Vehicle, 0, 1, 0, 1, 0, 1, 0);

    new panels, doors, lights, tires;
    
    GetVehicleDamageStatus(dealer_Vehicle, panels, doors, lights, tires);
    UpdateVehicleDamageStatus(dealer_Vehicle, panels, 256, lights, tires); // open trunk

    dealer_Actor    = CreateActor(
        242, 
        dealer_Places[index][dealerActorPos][0],
        dealer_Places[index][dealerActorPos][1],
        dealer_Places[index][dealerActorPos][2],
        dealer_Places[index][dealerActorPos][3]
    );
    ApplyActorAnimation(dealer_Actor, "OTB", "WTCHRACE_LOOP", 4.1, 1, 0, 0, 0, 0);
    return 1;
}

static _GunDealer_RerollWeapons()
{
    printf("_GunDealer_RerollWeapons(%d):", GetGVarInt("DAYS_REROLL_GUNS", SERVER_VARS_ID));
    for(new w = 0; w < MAX_WEAPONS_PER_WEEK; w++)
    {
        new index = NONE;
        while(index == NONE || _GunDealer_IsIndexPicked(index))
        {
            index = _GunDealer_SelectRandomIndex();
        }

        dealer_WeaponsSelected[w] = index;

        // Parandomizinam kaina
        dealer_WeaponsSelected_Price[w] = dealer_WeaponsList[index][dw_PriceBase] + random(dealer_WeaponsList[index][dw_PriceRandom]);

        // Suapvaliname kaina, kad nebutu 9123$, o 9100$
        dealer_WeaponsSelected_Price[w] = floatround((dealer_WeaponsSelected_Price[w] / 100.0), floatround_ceil) * 100;

        printf("\tWeapon %d selected: %s, price: %d$",
            w,
            GetInventoryItemName(dealer_WeaponsList[index][dw_WeaponId]),
            dealer_WeaponsSelected_Price[w]
        );
    }
    return 1;
}
static _GunDealer_SelectRandomIndex()
{
    new chance_sum = 0;

    for(new w = 0; w < sizeof dealer_WeaponsList[]; w++) 
    {
        chance_sum += dealer_WeaponsList[w][dw_Chance];
    }

    new selected = random(chance_sum);

    for(new w = 0, interval = 0; w < sizeof dealer_WeaponsList[]; w++)
    {
        interval += dealer_WeaponsList[w][dw_Chance];
        if(selected <= interval) return w;
    }
    return NONE;
}
static _GunDealer_IsIndexPicked(index)
{
    for(new w = 0; w < MAX_WEAPONS_PER_WEEK; w++)
    {
        if(dealer_WeaponsSelected[w] == index && index != NONE)
        {
            return true;
        }
    }  
    return false;
}
static _GunDealer_IsWeaponIdPicked(weaponid)
{
    for(new w = 0; w < MAX_WEAPONS_PER_WEEK; w++)
    {
        if( dealer_WeaponsSelected[w] != NONE &&
            dealer_WeaponsList[dealer_WeaponsSelected[w]][dw_WeaponId] == weaponid)
        {
            return true;   
        }
    }
    return false;
}

/* Player commands */
CMD:factioncredits(playerid, params[])
{
    SendFormat(playerid, -1, "[Turimi frakcijos kreditai: %d] > /orderweapons", player_FactionCredits[playerid]);
    return 1;
}
CMD:orderweapons(playerid, params[])
{
    if(player_FactionCredits[playerid] <= 0) return SendError(playerid, "Neturi nei 1 frakcijos kredito.");

    dialog_Clear();
    dialog_AddLine("{F2F2F2}Ðià savaitæ galiu pasiûlyt:\n");

    for(new w = 0; w < MAX_WEAPONS_PER_WEEK; w++)
    {
        dialog_AddLine("{F2F2F2} - [%s] \t[%d$]  ((+%d f. kred.))",
            GetInventoryItemName(dealer_WeaponsList[dealer_WeaponsSelected[w]][dw_WeaponId]),
            dealer_WeaponsSelected_Price[w],
            dealer_WeaponsList[dealer_WeaponsSelected[w]][dw_PriceCredits]
        );
    }

	Dialog_Show(playerid, ConfirmWeaponsOrder, DIALOG_STYLE_MSGBOX, "Þinutë nuo 5649998:", dialog_GetBody(), "Paþymëti", "Uþdaryti");
    return 1;
}
Dialog:ConfirmWeaponsOrder(playerid, response, listitem, inputtext[])
{
	if(response)
	{
        _GunDealer_MarkCheckpoint(playerid);
	}
	return 1;
}

CMD:buyguns(playerid, params[])
{
    if(IsPlayerInRangeOfPoint(playerid, 3.0,
        dealer_Places[dealer_PlaceIndex][dealerActorPos][0],
        dealer_Places[dealer_PlaceIndex][dealerActorPos][1],
        dealer_Places[dealer_PlaceIndex][dealerActorPos][2]))
    {
        if(player_FactionCredits[playerid] > 0)
        {
            _GunDealer_ShowPurchaseList(playerid);
            return 1;
        }
        else
        {
            switch(random(3))
            {
                case 0:     return SendFormat(playerid, 0xDDDDDDff, "Bandyk kità kartà.");
                case 1:     return SendFormat(playerid, 0xDDDDDDff, "Ginklø tau neturiu.");
                default:    return SendFormat(playerid, 0xDDDDDDff, "Ko èia atvykai?");
            }
        }
    }
    else SendError(playerid, "Esi per toli.");
    return 1;
}

ptask PT_CheckIfNearDealer[1200](playerid)
{
    if(IsPlayerInRangeOfPoint(playerid, 3.0,
        dealer_Places[dealer_PlaceIndex][dealerActorPos][0],
        dealer_Places[dealer_PlaceIndex][dealerActorPos][1],
        dealer_Places[dealer_PlaceIndex][dealerActorPos][2]) && player_FactionCredits[playerid] > 0)
    {
        if(gettime() - player_LastSeenMsg[playerid] >= 120)
        {
            SendFormat(playerid, 0xDDDDDDff, "Norëdamas pirkti ginklus, naudok /buyguns.");  
            player_LastSeenMsg[playerid] = gettime();
        }
    }
    return 1;
}


static _GunDealer_MarkCheckpoint(playerid)
{
    SetPlayerCheckpointEx(playerid, NONE,
        dealer_Places[dealer_PlaceIndex][dealerActorPos][0],
        dealer_Places[dealer_PlaceIndex][dealerActorPos][1],
        dealer_Places[dealer_PlaceIndex][dealerActorPos][2], 2.3);
    
    SendFormat(playerid, 0xbababaff, "> Susitikimo vieta paþymëta.");
    return 1;
}

static _GunDealer_ShowPurchaseList(playerid)
{
    dialog_Clear();

    for(new w = 0; w < MAX_WEAPONS_PER_WEEK; w++)
    {
        dialog_AddLine("{F2F2F2}%s\t[%d$]\t((+%d frakc. kred.))",
            GetInventoryItemName(dealer_WeaponsList[dealer_WeaponsSelected[w]][dw_WeaponId]),
            dealer_WeaponsSelected_Price[w],
            dealer_WeaponsList[dealer_WeaponsSelected[w]][dw_PriceCredits]
        );
    }
	Dialog_Show(playerid, BuyBlackMarketGuns, DIALOG_STYLE_TABLIST, "Black market", dialog_GetBody(), "Pirkti", "Uþdaryti");
    return 1;
}
Dialog:BuyBlackMarketGuns(playerid, response, listitem, inputtext[])
{
	if(response)
	{
        if(0 <= listitem < MAX_WEAPONS_PER_WEEK)
        {
            new 
                weapon = dealer_WeaponsList[dealer_WeaponsSelected[listitem]][dw_WeaponId], 
                ammo = dealer_WeaponsList[dealer_WeaponsSelected[listitem]][dw_WeaponAmmo],
                price = dealer_WeaponsSelected_Price[listitem],
                creds = dealer_WeaponsList[dealer_WeaponsSelected[listitem]][dw_PriceCredits];

            if(player_FactionCredits[playerid] < creds) 
                return SendError(playerid, "Neturi frakc. kreditø.");
            
            if(GetPlayerMoney(playerid) < price) 
                return InfoBox(playerid, IB_NOT_ENOUGH_MONEY, price);

            new 
                slot = -1;

            if((slot = GetPlayerFreeInventorySlot(playerid)) != -1)
            {
                GivePlayerInventoryItem(playerid, weapon, ammo, 0, slot);

                new final[256];
                format(final, sizeof final, "** Kaukëtasis perduoda %s daiktà, kuris atrodo kaip %s.",
                    GetPlayerNameEx(playerid, true), 
                    GetInventoryItemName(weapon)
                );

                ProxDetector(10.0, playerid, final, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA);

                Player_GiveFactionCredits(playerid, -creds);
                GivePlayerMoney(playerid, -price);
            }
            else SendWarning(playerid, "Neturi vietos inventoriuje.");
        }
	}
	return 1;
}


/* Admin commands */
flags:givefactioncredits(CMD_TYPE_ADMIN);
CMD:givefactioncredits(playerid, params[])
{
    new receiverid, amount;
    if(sscanf(params,"ud", receiverid, amount)) return SendUsage(playerid, "/givefactioncredits [Þaidëjas] [Kreditai]");
    if(!CheckPlayerid(receiverid)) return InfoBox(playerid, IB_WRONG_PLAYER);


    Player_GiveFactionCredits(receiverid, amount);

    SendFormat(playerid, 0x7BD8C1ff, "Suteikëte þaidëjui [%s] %d frakcijos kreditø. Dabar þaidëjas turi: %d",
        GetPlayerNameEx(playerid), amount, player_FactionCredits[receiverid]);

    SendFormat(receiverid, 0x7BD8C1ff, "Gavote frakcijos kreditø: %d. Dabar turite: %d",
        amount, player_FactionCredits[receiverid]);


    new string[256];
	format(string, sizeof string, "[AdmCmd] Administratorius %s davë frakc. kreditø %s (%d)", GetPlayerNameEx(playerid), GetPlayerNameEx(receiverid), amount);
	SendAdminMessage(0xFF6347AA, false, string);

	log_init(true);
	log_set_table("logs_admins");
	log_set_keys("`PlayerId`,`PlayerName`,`ReceiverId`,`ReceiverName`,`ActionText`,`Amount`");
	log_set_values("'%d','%e','%d','%e','Dave frakcijos kreditu','%d'", LogPlayerId(playerid), LogPlayerName(playerid), LogPlayerId(receiverid), LogPlayerName(receiverid), amount);
	log_commit();
    return 1;
}

flags:afactioncredits(CMD_TYPE_ADMIN);
CMD:afactioncredits(playerid, params[], help)
{
    new receiverid;
    if(sscanf(params,"u", receiverid)) return SendUsage(playerid, "/afactioncredits [Þaidëjas]");
    if(!CheckPlayerid(receiverid)) return InfoBox(playerid, IB_WRONG_PLAYER);

    SendFormat(playerid, -1, "%s turi %d frakc. kreditø", GetPlayerNameEx(receiverid), player_FactionCredits[receiverid]);
    return 1;
}

/* Functions */
stock Player_GiveFactionCredits(playerid, amount)
{
    player_FactionCredits[playerid] += amount;
    SaveAccountIntEx(playerid, "FactionCredits", player_FactionCredits[playerid]);
    return 1;
}
stock Player_GetFactionCredits(playerid) return player_FactionCredits[playerid];

hook OnPlayerRequestDataLoad(playerid)
{
    inline loadFactionCredits()
    {
        if(cache_num_rows())
        {
            cache_get_value_name_int(0, "FactionCredits", player_FactionCredits[playerid]);
        }
    }
    mysql_tquery_inline(chandler, using inline loadFactionCredits, "\
        SELECT `FactionCredits` FROM `players_data` WHERE id = '%d'", PlayerInfo[playerid][pId]);
    return 1;
}

hook OnPlayerResetVariables(playerid, sql)
{
    player_FactionCredits[playerid] = 0;
    player_LastSeenMsg[playerid] = 0;
    return 1;
}