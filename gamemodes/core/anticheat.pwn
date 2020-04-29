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
enum E_AC_WEAPONS
{
	e_ac_WeaponId,
	e_ac_WeaponAmmo,
	e_ac_WeaponGiveType,
	e_ac_WeaponUniqueId
};
new ac__PlayerWeapons[MAX_PLAYERS][13][E_AC_WEAPONS];
new ac__LastWeapon[MAX_PLAYERS];
new ac__PlayerIgnoreWeaponAC[MAX_PLAYERS];


enum VEHICLE_DATA
{
	Float:VehicleHealth
};
new AcVehicleData[MAX_VEHICLES][VEHICLE_DATA];

forward OnPlayerWeaponCheat(playerid, weaponid, ammo);

/*
	Weapons 
*/
hook OnPlayerConnect(playerid)
{
	sd_ResetPlayerWeapons(playerid);
	return 1;
}

hook OnPlayerDeath(playerid, reason, killerid)
{
	ac__PlayerIgnoreWeaponAC[playerid] = 4;
	sd_ResetPlayerWeapons(playerid);
	return 1;
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

	new 
		old;

	if(GetPlayerCustomSkin(playerid) != 0) old = GetPlayerCustomSkin(playerid);
	else old = GetPlayerSkin(playerid);

	new ret = SetPlayerSkin(playerid, skinid);
	
	if(!(0 <= skinid <= 312))
	{
		if(GetPlayerCustomSkin(playerid) == 0)
		{
			if(save_to_var) PlayerInfo[playerid][pSkin] = old;
			return SetPlayerSkin(playerid, old);
		}
	}
	if(save_to_var) PlayerInfo[playerid][pSkin] = skinid;
	return ret;
}

stock sd_GetPlayerSkin(playerid)
{
	new skin = 1;
	if(GetPlayerCustomSkin(playerid) != 0) skin = GetPlayerCustomSkin(playerid);
	else skin = GetPlayerSkin(playerid);
	return skin;
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
	if(!IsPlayerConnected(playerid)) return 1;
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
	    if(PlayerExtra[playerid][peAFKTime] > 13)
	    {
    		if(!HaveAdminPermission(playerid, "IgnoreAFKKicker") && PlayerInfo[playerid][pIsApproved])
			{
				if(PlayerInfo[playerid][pDonator] <= 1 && PlayerExtra[playerid][peAFKTime] > 13)
				{
    				return KickPlayer(playerid, "Sistema", "AFK");
    			}
    			else if(PlayerInfo[playerid][pDonator] == DONATOR_SILVER && PlayerExtra[playerid][peAFKTime] > 180)
				{
    				return KickPlayer(playerid, "Sistema", "AFK");
    			}
    			else if(PlayerInfo[playerid][pDonator] >= DONATOR_GOLD && PlayerExtra[playerid][peAFKTime] > 720)
				{
    				return KickPlayer(playerid, "Sistema", "AFK");
    			}
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
	SetTimer("ac_WeaponsTimer", 400, false);
	return 1;
}



forward ac_WeaponsTimer();
public ac_WeaponsTimer()
{
	new 
		playerWeapon;
	foreach(new playerid : Player)
	{
		if(!IsPlayerConnected(playerid)) continue; 
		if((playerWeapon = GetPlayerWeapon(playerid)) != ac__LastWeapon[playerid])
		{
			sd_OnPlayerWeaponChanged(playerid, playerWeapon, ac__LastWeapon[playerid]);
		}
		if(ac__PlayerIgnoreWeaponAC[playerid] > 0)
		{
			ac__PlayerIgnoreWeaponAC[playerid] -- ;
		}
	}
	SetTimer("ac_WeaponsTimer", 400, false);
	return 1;
}

forward sd_OnPlayerWeaponChanged(playerid, newweapon, oldweapon);
public sd_OnPlayerWeaponChanged(playerid, newweapon, oldweapon)
{
	if(newweapon != 0) sd_CheckWeaponCheat(playerid, newweapon, false);
	else if(oldweapon != 0)
	{
		new 
			oldslot;
		if((oldslot = sd_GetWeaponSlot(oldweapon)) != 0xFFFF)
		{
			new 
				l_data[2];
			GetPlayerWeaponData(playerid, oldslot, l_data[0], l_data[1]);
			if(l_data[0] <= 0 || l_data[0] <= 1)
			{
				sd_ResetPlayerWeaponSlotData(playerid, oldslot);
				if(oldslot != 0xFFFF)
				{
					if( ac__PlayerWeapons[playerid][oldslot][e_ac_WeaponId] == 23 && 
						ac__PlayerWeapons[playerid][oldslot][e_ac_WeaponGiveType] == WEAPON_GIVE_TYPE_NO_INVENTORY &&
						PlayerExtra[playerid][peTazer] >= 1)
					{
						PlayerExtra[playerid][peTazer] = 0;
						//SendFormat(playerid, -1, "%d %d", PlayerExtra[playerid][peBeforeTazerWeaponId], PlayerExtra[playerid][peBeforeTazerWeaponAmmo]);
						if(PlayerExtra[playerid][peBeforeTazerWeaponId] != 0 && PlayerExtra[playerid][peBeforeTazerWeaponAmmo] > 0)
						{
							sd_GivePlayerWeapon(playerid, PlayerExtra[playerid][peBeforeTazerWeaponId], PlayerExtra[playerid][peBeforeTazerWeaponAmmo], WEAPON_GIVE_TYPE_NO_INVENTORY, 0);
							PlayerExtra[playerid][peBeforeTazerWeaponId] = 
							PlayerExtra[playerid][peBeforeTazerWeaponAmmo] = 0;
						}
					}
				}
			}
			else
			{
				sd_CheckWeaponCheat(playerid, oldslot, true);
			}
		}
	}
	ac__LastWeapon[playerid] = newweapon;
	return 1;
}

stock sd_CheckWeaponCheat(playerid, id, bool:byslot)
{
	new 
		slot;
	if(ac__PlayerIgnoreWeaponAC[playerid] > 0) return false;
	if(((slot = id) && byslot) || (((slot = sd_GetWeaponSlot(id)) != 0xFFFF) && !byslot))
	{
		new 
			l_data[2];
		GetPlayerWeaponData(playerid, slot, l_data[0], l_data[1]);
		if((ac__PlayerWeapons[playerid][slot][e_ac_WeaponId] != l_data[0] && l_data[0] != 0 && l_data[1] > 0) || (ac__PlayerWeapons[playerid][slot][e_ac_WeaponAmmo] < l_data[1] && l_data[1] > 0 && l_data[0] > 0))
		{
			ac__PlayerIgnoreWeaponAC[playerid] = 4;
			sd_ResetPlayerWeapons(playerid);
			(funcidx("OnPlayerWeaponCheat") != -1) && CallLocalFunction("OnPlayerWeaponCheat", "ddd", playerid, l_data[0], l_data[1]);
			return true;
		}
		ac__PlayerWeapons[playerid][slot][e_ac_WeaponAmmo] = l_data[1];
	}
	return false;
}

stock sd_ResetPlayerWeaponSlotData(playerid, slot)
{
	new 
		reset[E_AC_WEAPONS];
	ac__PlayerWeapons[playerid][slot][e_ac_WeaponId] = 0;
	ac__PlayerWeapons[playerid][slot][e_ac_WeaponAmmo] = 0;
	return (ac__PlayerWeapons[playerid][slot] = reset);
}

stock sd_ResetPlayerWeapons(playerid)
{
	new 
		reset[E_AC_WEAPONS];
	for(new slot = 0; slot < 13; slot++)
	{
		ac__PlayerWeapons[playerid][slot] = reset;
	}
	ac__LastWeapon[playerid] = 0;
	return ResetPlayerWeapons(playerid);
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

stock sd_SetPlayerAmmo(playerid, weaponid, ammo)
{
	if(!IsPlayerConnected(playerid)) return 1;
	new 
		slot;
	if((slot = sd_GetWeaponSlot(weaponid)) != 0xFFFF)
	{
		if(ammo <= 0)
		{
			ac__PlayerWeapons[playerid][slot][e_ac_WeaponAmmo] = 
			ac__PlayerWeapons[playerid][slot][e_ac_WeaponId] = 0;
		}
		else
		{
			ac__PlayerWeapons[playerid][slot][e_ac_WeaponAmmo] += ammo;
		}
	}
	return SetPlayerAmmo(playerid, weaponid, ammo);
}


stock sd_GivePlayerWeapon(playerid, weaponid, ammo, givetype = WEAPON_GIVE_TYPE_NORMAL, uniqueid = 0)
{
	if(!IsPlayerConnected(playerid)) return 1;
	new 
		slot,
		return_result;
	if((slot = sd_GetWeaponSlot(weaponid)) != 0xFFFF)
	{	
		if(weaponid != 0)
		{
			if(ac__PlayerWeapons[playerid][slot][e_ac_WeaponId] == weaponid)
			{
				if(ac__PlayerWeapons[playerid][slot][e_ac_WeaponAmmo] >= 0)
				{
					ac__PlayerWeapons[playerid][slot][e_ac_WeaponAmmo] += ammo;
				}
				else ac__PlayerWeapons[playerid][slot][e_ac_WeaponAmmo] = ammo;
			}
			else
			{
				ac__PlayerWeapons[playerid][slot][e_ac_WeaponAmmo] = ammo;
			}
			ac__PlayerWeapons[playerid][slot][e_ac_WeaponId] = weaponid;
		}
	}
	else
	{
		return false;
	}

	if(weaponid == 39) ac__PlayerWeapons[playerid][12][e_ac_WeaponId] = WEAPON_BOMB, ac__PlayerWeapons[playerid][12][e_ac_WeaponAmmo] = 1;
	ac__PlayerWeapons[playerid][slot][e_ac_WeaponGiveType] = givetype;

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
			ac__PlayerWeapons[playerid][slot][e_ac_WeaponUniqueId] = cache_insert_id();
			return_result = GivePlayerWeapon(playerid, weaponid, ammo);
			cache_delete(result);
		}
	}
	else 
	{
		ac__PlayerWeapons[playerid][slot][e_ac_WeaponUniqueId] = uniqueid;
		return_result = GivePlayerWeapon(playerid, weaponid, ammo);
	}
	return return_result;
}

stock sd_ClearWeaponSlot(playerid, slot)
{
	if(!IsPlayerConnected(playerid)) return 1;
	new
		weapondata[13][4];
	ac__PlayerIgnoreWeaponAC[playerid] = 4;

	for(new i = 0; i < 13; i++)
	{
		if(i != slot)
		{
			sd_GetPlayerWeaponData(playerid, i, weapondata[i][0], weapondata[i][1]);
			weapondata[i][2] = ac__PlayerWeapons[playerid][i][e_ac_WeaponGiveType];
			weapondata[i][3] = ac__PlayerWeapons[playerid][i][e_ac_WeaponUniqueId];
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
	return ac__PlayerWeapons[playerid][slot][e_ac_WeaponUniqueId];
}

stock sd_GetSlotWeaponType(playerid, slot)
{
	return ac__PlayerWeapons[playerid][slot][e_ac_WeaponGiveType];
}

stock sd_GetWeaponType(playerid, weaponid)
{
	new slot = sd_GetWeaponSlot(weaponid);
	return ac__PlayerWeapons[playerid][slot][e_ac_WeaponGiveType];
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


/*
stock sd_GetWeaponData(playerid, slot, &weaponid, &ammo)
{
	weaponid = ac__PlayerWeapons[playerid][slot][e_ac_WeaponId];
	ammo = ac__PlayerWeapons[playerid][slot][e_ac_WeaponAmmo];
	return 1;
}*/

stock sd_GetPlayerWeaponData(playerid, slotid, &weaponid, &ammo)
{
	weaponid = ac__PlayerWeapons[playerid][slotid][e_ac_WeaponId];
	ammo = ac__PlayerWeapons[playerid][slotid][e_ac_WeaponAmmo];
	return 1;
}
stock sd_CheckIfSlotUsed(playerid, slotid)
{
	new weaponid, ammo;
	sd_GetPlayerWeaponData(playerid, slotid, weaponid, ammo);
	if(weaponid != 0 && ammo > 0)
	{
		return weaponid;
	}
	return 0;
}