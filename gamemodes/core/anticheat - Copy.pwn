/*
 *
 * SAN ANDREAS MULTIPLAYER ANTI-CHEAT BY TOMAS TORKQ VOSYLIUS
 * ALL RIGHTS RESERVED
 * 2016
 *
 */

/* 
	Defines
*/
#define HACK_NEW_WEAPON	1001
#define HACK_NEW_AMMO	1002
#define HACK_OLD_WEAPON	1003
#define HACK_OLD_AMMO	1004
#define HACK_RAM_HACKING 1005
#define HACK_AFTER_CHECK_WEAPON 1006

#define WEAPON_GIVE_TYPE_NORMAL 1
#define WEAPON_GIVE_TYPE_NO_INVENTORY 2

/*
	Enumerators, global variables
*/
enum WEAPON_DATA 
{
	WeaponId,
	WeaponAmmo,
	WeaponGiveType,
	WeaponUniqueId
};
new PlayerWeapons[MAX_PLAYERS][13][WEAPON_DATA];

enum AC_DATA
{
	CurrentWeapon,
	SkipNextWeaponCheatCheck
};
new AcData[MAX_PLAYERS][AC_DATA];

enum VEHICLE_DATA
{
	Float:VehicleHealth
};
new AcVehicleData[MAX_VEHICLES][VEHICLE_DATA];

/*
	Weapons 
*/
hook OnPlayerConnect(playerid)
{
	for(new slot = 0; slot < 13; slot++)
	{
		new _rV_WeaponSlot[WEAPON_DATA];
			PlayerWeapons[playerid][slot] = _rV_WeaponSlot;
		//reset(WeaponSlot, PlayerWeapons[playerid][slot], WEAPON_DATA);		
	}
	return 1;
}

hook OnPlayerUpdate(playerid)
{
	if(GetPlayerWeapon(playerid) != AcData[playerid][CurrentWeapon])
	{
		sd_OnPlayerChangeWeapon(playerid, GetPlayerWeapon(playerid), AcData[playerid][CurrentWeapon]);
	}
	return 1;
}

forward sd_OnPlayerChangeWeapon(playerid, newweapon, oldweapon);
public sd_OnPlayerChangeWeapon(playerid, newweapon, oldweapon)
{
	if(newweapon != 0)
	{
		new
			newslot = sd_GetWeaponSlot(newweapon),
			newammo;
		GetPlayerWeaponData(playerid, newslot, newammo, newammo);
		if(PlayerWeapons[playerid][newslot][WeaponId] != newweapon && newweapon != 0 && newammo > 0)
		{
			//SendFormat(playerid, -1, "WEAPONID: get:%d,data:%d", newweapon, PlayerWeapons[playerid][newslot][WeaponAmmo]);
			BanPlayer(playerid, "Sistema", "Èytino ginklus arba amunicijà ("#HACK_NEW_WEAPON").");
			return 1;
		}
		if(PlayerWeapons[playerid][newslot][WeaponAmmo] < newammo)
		{
			//SendFormat(playerid, -1, "AMMO: get:%d,data:%d", newammo, PlayerWeapons[playerid][newslot][WeaponAmmo]);
			BanPlayer(playerid, "Sistema", "Èytino ginklus arba amunicijà ("#HACK_NEW_AMMO").");
			return 1;
		}
		else if(PlayerWeapons[playerid][newslot][WeaponAmmo] > newammo)
		{
			PlayerWeapons[playerid][newslot][WeaponAmmo] = newammo;
		}
	}
	if(oldweapon != 0)
	{
		new 
			oldammo,
			oldslot = sd_GetWeaponSlot(oldweapon);
		GetPlayerWeaponData(playerid, oldslot, oldammo, oldammo);
		if(oldammo <= 0)
		{
			if( PlayerWeapons[playerid][oldslot][WeaponId] == 23 && 
				PlayerWeapons[playerid][oldslot][WeaponGiveType] == WEAPON_GIVE_TYPE_NO_INVENTORY &&
				PlayerExtra[playerid][peTazer] >= 1
				)
			{
				PlayerExtra[playerid][peTazer] = 0;
				//SendFormat(playerid, -1, "%d %d", PlayerExtra[playerid][peBeforeTazerWeaponId], PlayerExtra[playerid][peBeforeTazerWeaponAmmo]);
				if(PlayerExtra[playerid][peBeforeTazerWeaponId] != 0 && PlayerExtra[playerid][peBeforeTazerWeaponAmmo] > 0)
				{
					sd_ClearWeaponSlot(playerid, oldslot);
					sd_GivePlayerWeapon(playerid, PlayerExtra[playerid][peBeforeTazerWeaponId], PlayerExtra[playerid][peBeforeTazerWeaponAmmo], WEAPON_GIVE_TYPE_NO_INVENTORY, 0);
					PlayerExtra[playerid][peBeforeTazerWeaponId] = 
					PlayerExtra[playerid][peBeforeTazerWeaponAmmo] = 0;
				}
			}
			else
			{
				sd_ClearWeaponSlot(playerid, oldslot);
			}
		}
		else if(PlayerWeapons[playerid][oldslot][WeaponAmmo] > oldammo)
		{
			PlayerWeapons[playerid][oldslot][WeaponAmmo] = oldammo;
		}
	}
	/*if(oldweapon != 0)
	{
		new 
			oldammo,
			oldslot = sd_GetWeaponSlot(oldweapon);
		GetPlayerWeaponData(playerid, oldslot, oldammo, oldammo);
		if((PlayerWeapons[playerid][oldslot][WeaponId] != oldweapon && PlayerWeapons[playerid][oldslot][WeaponId] != 0) && sd_GetWeaponSlot(newweapon) != oldslot)
		{
			SendFormat(playerid, -1, "WEAPONID: oldweapon:%d,data:%d", oldweapon, PlayerWeapons[playerid][oldslot][WeaponId]);
			BanPlayer(playerid, "Sistema", "Èytino ginklus arba amunicijà ("#HACK_OLD_WEAPON").");
			return 1;
		}
		if(oldammo <= 0)
		{
			if(oldweapon == 23)
			{
				// baigesi tazeris
				PlayerExtra[playerid][peTazer] = 0;
			}
			PlayerWeapons[playerid][oldslot][WeaponAmmo] = 0;
			PlayerWeapons[playerid][oldslot][WeaponId] = 0;
			PlayerWeapons[playerid][oldslot][WeaponGiveType] = 0;
			PlayerWeapons[playerid][oldslot][WeaponUniqueId] = 0;
			sd_ClearWeaponSlot(playerid, oldslot);
		}
		if(PlayerWeapons[playerid][oldslot][WeaponAmmo] < oldammo)
		{
			BanPlayer(playerid, "Sistema", "Èytino ginklus arba amunicijà ("#HACK_OLD_AMMO").");
			return 1;
		}
		else if(PlayerWeapons[playerid][oldslot][WeaponAmmo] > oldammo)
		{
			PlayerWeapons[playerid][oldslot][WeaponAmmo] = oldammo;
		}
	}*/
	AcData[playerid][CurrentWeapon] = newweapon;
	return 1;
}

stock sd_CheckVehicleHealth(vehicleid)
{
	new Float:cur_health;
	GetVehicleHealth(vehicleid, cur_health);
	if(cur_health < AcVehicleData[vehicleid][VehicleHealth])
	{
		AcVehicleData[vehicleid][VehicleHealth] = cur_health;
	}
	if(AcVehicleData[vehicleid][VehicleHealth] < cur_health)
	{
		SetVehicleHealth(vehicleid, AcVehicleData[vehicleid][VehicleHealth]);
	}
	return 1;
}

stock sd_GetWeaponData(playerid, slotid, &weaponid, &ammo)
{
	weaponid = PlayerWeapons[playerid][slotid][WeaponId];
	ammo = PlayerWeapons[playerid][slotid][WeaponAmmo];
	return 1;
}

stock sd_CheckIfSlotUsed(playerid, slotid)
{
	new weaponid, ammo;
	sd_GetWeaponData(playerid, slotid, weaponid, ammo);
	if(weaponid != 0 && ammo > 0)
	{
		return weaponid;
	}
	return 0;
}

stock sd_CheckWeaponCheat(playerid, weaponid = -1)
{
	if(weaponid != -1)
	{
		new slot = sd_GetWeaponSlot(weaponid),
			clear, ammo;
		GetPlayerWeaponData(playerid, slot, clear, ammo);
		if(((PlayerWeapons[playerid][slot][WeaponId] != weaponid && weaponid > 0 && ammo > 0) || PlayerWeapons[playerid][slot][WeaponAmmo] < ammo) && (ammo > 0))
		{
			sd_ResetPlayerWeapons(playerid);
			BanPlayer(playerid, "Sistema", "Èytino ginklus arba amunicijà ("#HACK_AFTER_CHECK_WEAPON").");
			//SendFormat(playerid, -1, "Weapondata: get:%d,data:%d    AMMO: get:%d,data:%d", weaponid, PlayerWeapons[playerid][slot][WeaponId], ammo, PlayerWeapons[playerid][slot][WeaponAmmo]);
			return true;
		}
	}
	else
	{
		new data[2];
		for(new i = 0; i < 13; i++)
		{
			GetPlayerWeaponData(playerid, i, data[0], data[1]);
			if(((PlayerWeapons[playerid][i][WeaponId] != data[0] && data[0] > 0 && data[1] > 0) || PlayerWeapons[playerid][i][WeaponAmmo] < data[1]) && (data[1] > 0))
			{
				sd_ResetPlayerWeapons(playerid);
				BanPlayer(playerid, "Sistema", "Èytino ginklus arba amunicijà ("#HACK_AFTER_CHECK_WEAPON").");
				//SendFormat(playerid, -1, "Weapondata: get:%d,data:%d    AMMO: get:%d,data:%d", data[0], PlayerWeapons[playerid][i][WeaponId], data[1], PlayerWeapons[playerid][i][WeaponAmmo]);
				return true;
			}
		}
	}
	return false;
}

stock sd_InsertWeaponId(playerid, weaponid, ammo, givetype)
{
	new 
		string[126],
		Cache:result,
		id;

	mysql_format(chandler, string, sizeof string, "INSERT INTO `weapons_data` (`WeaponModel`,`GiveType`,`GiveAmmo`) VALUES ('%d','%d','%d')", weaponid, givetype, ammo);
	result = mysql_query(chandler, string, true);
	if(mysql_errno() != 0)
	{
		format(string, sizeof string, "%d", mysql_errno());
		SendCriticalError(playerid, "Ginklas jums nebuvo suteiktas dël MySQL klaidos.", string);
		cache_delete(result);
		id = -1;
	}
	else
	{
		id = cache_insert_id();
		cache_delete(result);
	}
	return id;
}

stock sd_GivePlayerWeapon(playerid, weaponid, ammo, givetype = WEAPON_GIVE_TYPE_NORMAL, uniqueid = 0)
{
	new 
		slot = sd_GetWeaponSlot(weaponid);
	if(weaponid < 0 || weaponid > 46 || ammo < 0) return false;
	if(PlayerWeapons[playerid][slot][WeaponId] != weaponid)
	{
		if(PlayerWeapons[playerid][slot][WeaponId] != 0)
		{
			sd_ClearWeaponSlot(playerid, slot);
			AcData[playerid][SkipNextWeaponCheatCheck] = 3;
		}
		PlayerWeapons[playerid][slot][WeaponAmmo] = ammo;
		PlayerWeapons[playerid][slot][WeaponId] = weaponid;
	}
	else if(PlayerWeapons[playerid][slot][WeaponId] == weaponid)
	{
		PlayerWeapons[playerid][slot][WeaponAmmo] += ammo;
	}
	PlayerWeapons[playerid][slot][WeaponGiveType] = givetype;

	if(uniqueid == -1)
	{
		// generate
		new 
			string[126],
			Cache:result;

		mysql_format(chandler, string, sizeof string, "INSERT INTO `weapons_data` (`WeaponModel`,`GiveType`,`GiveAmmo`) VALUES ('%d','%d','%d')", weaponid, givetype, ammo);	
		result = mysql_query(chandler, string, true);
		if(mysql_errno() != 0)
		{
			format(string, 15, "%d", mysql_errno());
			SendCriticalError(playerid, "Ginklas jums nebuvo suteiktas dël MySQL klaidos.", string);
			cache_delete(result);
			return false;
		}
		else
		{
			PlayerWeapons[playerid][slot][WeaponUniqueId] = cache_insert_id();
			cache_delete(result);
		}
	}
	else 
	{
		PlayerWeapons[playerid][slot][WeaponUniqueId] = uniqueid;
	}
	return GivePlayerWeapon(playerid, weaponid, ammo);
}

stock sd_SetVehicleHealth(vehicleid, Float:health)
{
	AcVehicleData[vehicleid][VehicleHealth] = health;
	return SetVehicleHealth(vehicleid, health);
}

stock sd_RepairVehicle(vehicleid)
{
	AcVehicleData[vehicleid][VehicleHealth] = 1000.0;
	return RepairVehicle(vehicleid);
}

stock sd_SetPlayerSkin(playerid, skinid, bool:save_to_var = true)
{
	new _state = GetPlayerAnimationIndex(playerid);
	if(_state == 1044 || _state == 1027) return false;
	if(save_to_var) PlayerInfo[playerid][pSkin] = skinid;
	return SetPlayerSkin(playerid, skinid);
}

stock sd_GetPlayerWeaponData(playerid, slot, &weaponid, &ammo)
{
	weaponid = PlayerWeapons[playerid][slot][WeaponId];
	ammo = PlayerWeapons[playerid][slot][WeaponAmmo];
	return true;
}

stock sd_ResetPlayerWeapons(playerid)
{
	new __reset_Weapon[WEAPON_DATA];
	for(new i = 0; i < 13; i++)
	{	
		PlayerWeapons[playerid][i] = __reset_Weapon;
	}
	return ResetPlayerWeapons(playerid);	
}

stock sd_ClearWeaponSlot(playerid, slot)
{
	new
		weapondata[13][4];
	AcData[playerid][SkipNextWeaponCheatCheck] = 2;
	for(new i = 0; i < 13; i++)
	{
		if(i != slot)
		{
			GetPlayerWeaponData(playerid, i, weapondata[i][0], weapondata[i][1]);
			weapondata[i][2] = PlayerWeapons[playerid][i][WeaponGiveType];
			weapondata[i][3] = PlayerWeapons[playerid][i][WeaponUniqueId];
		}
	}
	sd_ResetPlayerWeapons(playerid);
	for(new i = 0; i < 13; i++)
	{
		if(weapondata[i][0] != 0 && weapondata[i][1] > 0 && i != slot)
		{
			sd_GivePlayerWeapon(playerid, weapondata[i][0], weapondata[i][1], weapondata[i][2], weapondata[i][3]);
		}
	}
	return 1;
}

stock sd_GetWeaponUniqueId(playerid, weaponid)
{
	new slot = sd_GetWeaponSlot(weaponid);
	return PlayerWeapons[playerid][slot][WeaponUniqueId];
}

stock sd_GetSlotWeaponType(playerid, slot)
{
	return PlayerWeapons[playerid][slot][WeaponGiveType];
}

stock sd_GetWeaponType(playerid, weaponid)
{
	new slot = sd_GetWeaponSlot(weaponid);
	return PlayerWeapons[playerid][slot][WeaponGiveType];
}

stock sd_GetWeaponSlot(weaponid) 
{ 
    switch(weaponid) 
    { 
        case 1: return 0; 
        case 2..9: return 1; 
        case 22..24: return 2; 
        case 25..27: return 3; 
        case 28, 29, 32: return 4; 
        case 30, 31: return 5; 
        case 33, 34: return 6; 
        case 35..38: return 7; 
        case 16..18, 39: return 8; 
        case 41..43: return 9; 
        case 10..15: return 10; 
        case 44..46: return 11; 
        case 40: return 12; 
    } 
    return 0xFFFF; 
}

/* 
	Money
*/

stock sd_ResetPlayerMoney(playerid)
{
	PlayerInfo[playerid][pMoney] = 0;
	return ResetPlayerMoney(playerid);
}
stock sd_GivePlayerMoney(playerid, amount)
{
	if(amount < 0)
	{
		if(PlayerInfo[playerid][pMoney]+amount > PlayerInfo[playerid][pMoney])
		{
			// Logs
			BanPlayer(playerid, "Sistema", "Memory hacking ("#HACK_RAM_HACKING")");
			return 0;
		}
	}
	PlayerInfo[playerid][pMoney] += amount;
	return GivePlayerMoney(playerid, amount);
}
stock sd_GetPlayerMoney(playerid) 
{
	return PlayerInfo[playerid][pMoney];
}

stock sd_CheckAfk( playerid )
{
 	static
	    Float:_playerX[MAX_PLAYERS],
	    Float:_playerY[MAX_PLAYERS],
	    Float:_playerZ[MAX_PLAYERS];

	new Float:_newX,
	    Float:_newY,
	    Float:_newZ;

	GetPlayerPos(playerid, _newX, _newY, _newZ);

	if(_playerX[playerid] == _newX && _playerY[playerid] == _newY && (_playerZ[playerid] == _newZ || ((_newZ - 2.0 <= _playerZ[playerid] <= _newZ + 2.0) && IsPlayerInWater(playerid))))
	{
	    if(PlayerExtra[playerid][peAFKTime] > 10)
	    {
    		if(!HaveAdminPermission(playerid, "IgnoreAFKKicker") && PlayerInfo[playerid][pIsApproved])
			{
    			KickPlayer(playerid, "Sistema", "AFK");
    		}
	    }
	    PlayerExtra[playerid][peAFKTime]++;
	}
	else
	    PlayerExtra[playerid][peAFKTime] = 0;

	_playerX[playerid] = _newX;
	_playerY[playerid] = _newY;
	_playerZ[playerid] = _newZ;
	return true;
}




hook OnGameModeInit()
{
	SetTimer("WeaponsTimer", 500, false);
	return 1;
}

forward WeaponsTimer();
public WeaponsTimer()
{
	foreach(new playerid : Player)
	{
		if(!IsPlayerConnected(playerid) || sd_CheckAfk(playerid)) continue; 
		if(ac__PlayerIgnoreWeaponAC[playerid] > 0)
		{
			ac__PlayerIgnoreWeaponAC[playerid] -- ;
			if(ac__PlayerIgnoreWeaponAC[playerid] > 0) continue; 
		}
		for(new slot = 0; slot < 13; slot++)
		{
			if(FAC_CheckWeaponCheat(playerid, slot, true))
			{
				break; // cheata radom, breakinam, kad nespamintu apie tolimesnisu cheatintus ginklus.
			}
		}
	}
	SetTimer("WeaponsTimer", 500, false);
	return 1;
}

stock FAC_CheckWeaponCheat(playerid, id, bool:byslot)
{
	new 
		slot;
	if(((slot = id) && byslot) || (((slot = FAC_GetWeaponSlot(id)) != 0xFFFF) && !byslot))
	{
		new 
			l_data[2];
		GetPlayerWeaponData(playerid, slot, l_data[0], l_data[1]);
		if((ac__PlayerWeapons[playerid][slot][e_ac_WeaponId] != l_data[0] && l_data[0] != 0 && l_data[1] > 0) || (ac__PlayerWeapons[playerid][slot][e_ac_WeaponAmmo] < l_data[1] && l_data[1] > 0 && l_data[0] > 0))
		{
			ac__PlayerIgnoreWeaponAC[playerid] = 4;
			FAC_ResetPlayerWeapons(playerid);
			(funcidx("OnPlayerWeaponCheat") != -1) && CallLocalFunction("OnPlayerWeaponCheat", "ddd", playerid, l_data[0], l_data[1]);
			return true;
		}
	}
	return false;
}