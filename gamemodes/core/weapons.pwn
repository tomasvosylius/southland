#include <YSI\y_hooks>
/*
 *
 * SAN ANDREAS MULTIPLAYER WEAPONS.PWN BY TOMAS f0cus VOSYLIUS
 * ALL RIGHTS RESERVED
 * 2016-2020
 *
 */

#define WEAPON_GIVE_TYPE_NO_INVENTORY		0
#define WEAPON_GIVE_TYPE_NORMAL				1

new WeaponObjects[] = {
	0,
	331,
	333,
	334,
	335,
	336,
	337,
	338,
	339,
	341,
	321,
	323,
	323,
	324,
	325,
	326,
	342,
	343,
	344,
	345,
	0,
	370,
	346,
	347,
	348,
	349,
	350,
	351,
	352,
	353,
	355,
	356,
	372,
	357,
	358,
	359,
	360,
	361,
	362,
	363,
	364,
	365,
	366,
	367,
	368,
	369,
	371
};

new WeaponNames[][24] = { // Ginklø pavadinimai
	{"Rankos"},
	{"Kastetas"},
	{"Golfo lazda"},
	{"Bananas"},
	{"Peilis"},
	{"Beisbolo lazda"},
	{"Kastuvas"},
	{"Biliardo lazda"},
	{"Katana"},
	{"Pjuklas"},
	{"Purpurinis vibratorius"},
	{"Baltas vibratorius"},
	{"Baltas vibratorius"},
	{"Sidabrinis vibratorius"},
	{"Geles"},
	{"Lazda"},
	{"Granatos"},
	{"Dujine granata"},
	{"Molotovo kokteilis"},
	{"Vehicle Missile"},
	{"Hydra Flare"},
	{"Jetpack"},
	{"9mm"},
	{"9mm duslintuvas"},
	{"Desert Eagle"},
	{"Shotgun"},
	{"Sawnoff Shotgun"},
	{"Combat Shotgun"},
	{"Micro SMG"},
	{"MP5"},
	{"AK47"},
	{"M4"},
	{"Tec-9"},
	{"Country Rifle"},
	{"Sniper Rifle"},
	{"Rocket Launcher"},
	{"HS Rocket Launcher"},
	{"Ugniasvaidis"},
	{"Minigun"},
	{"Nuotoline bomba"},
	{"Detonator"},
	{"Balionelis"},
	{"Gesintuvas"},
	{"Fotoaparatas"},
	{"Naktiniai akiniai"},
	{"Infrar. akiniai"},
	{"Paraðiutas"}
};

new Float:WeaponDamages[] = { // Zala
	3.0, // Rankos
	7.0, // Kastetas
	9.0, // Golfo lazda
	10.0, // Bananas
	12.0, // Peilis
	11.0, // Beisbolo lazda
	8.0, // Kastuvas
	8.0, // Biliardo lazda
	12.0, // Katana
	0.0, // Pjuklas
	0.0, // Purpurinis vibratorius
	0.0, // Baltas vibratorius
	0.0, // Baltas vibratorius
	0.0, // Sidabrinis vibratorius
	0.0, // Geles
	0.0, // Lazda
	350.0, // Granatos
	1.0, // Dujine granata
	40.0, // Molotovo kokteilis
	0.0, // Vehicle Missile
	0.0, // Hydra Flare
	0.0, // Jetpack
	18.0, // 9mm
	15.0, // 9mm duslintuvas
	34.0, // Desert Eagle
	70.0, // Shotgun
	40.0, // Sawnoff Shotgun
	30.0, // Combat Shotgun
	20.0, // Micro SMG
	20.0, // MP5
	25.0, // AK47
	25.0, // M4
	22.0, // Tec-9
	45.0, // Country Rifle
	250.0, // Sniper Rifle
	1000.0, // Rocket Launcher
	1000.0, // HS Rocket Launcher
	1.0, // Ugniasvaidis
	0.0, // Minigun
	0.0, // Nuotoline bomba
	0.0, // Detonator
	1.0, // Balionelis
	0.0, // Gesintuvas
	0.0, // Fotoaparatas
	0.0, // Naktiniai akiniai
	0.0, // Infrar. akiniai
	0.0 // Paraðiuta
};	


hook OnPlayerConnect(playerid)
{
	ResetPlayerWeapons(playerid);
	return 1;
}

hook OnPlayerDeath(playerid, reason, killerid)
{
	ResetPlayerWeapons(playerid);
	return 1;
}

static 
	weapon_GiveType[MAX_PLAYERS][13],
	weapon_UniqueId[MAX_PLAYERS][13];

stock GetPlayerWeaponExtraData(playerid, slot, &givetype, &uniqueid)
{
	if(0 <= slot < sizeof weapon_GiveType[])
	{
		givetype = weapon_GiveType[playerid][slot];
		uniqueid = weapon_UniqueId[playerid][slot];
		return 1;
	}
	return 0;
}

stock ret_GetSlotWeaponUniqueId(playerid, slot)
{
	return weapon_UniqueId[playerid][slot];
}
stock ret_GetSlotWeaponGiveType(playerid, slot)
{
	return weapon_GiveType[playerid][slot];
}


stock WPS_ResetPlayerWeapons(playerid)
{
	for(new slot = 0; slot < sizeof weapon_GiveType[]; slot++)
	{
		weapon_GiveType[playerid][slot] = 
		weapon_UniqueId[playerid][slot] = 0;	
	}
	return ResetPlayerWeapons(playerid);
}
#if defined _ALS_ResetPlayerWeapons
	#undef ResetPlayerWeapons
#else 
	#define _ALS_ResetPlayerWeapons
#endif 
#define ResetPlayerWeapons WPS_ResetPlayerWeapons

stock WPS_GivePlayerWeapon(playerid, weaponid, ammo, givetype = WEAPON_GIVE_TYPE_NORMAL, uniqueid = 0)
{
	new slot = FAC_GetWeaponSlot(weaponid);
	if(0 <= slot < sizeof weapon_GiveType[])
	{
		weapon_GiveType[playerid][slot] = givetype;
		weapon_UniqueId[playerid][slot] = uniqueid;
	}
	return GivePlayerWeapon(playerid, weaponid, ammo);
}

#if defined _ALS_GivePlayerWeapon
	#undef GivePlayerWeapon
#else 
	#define _ALS_GivePlayerWeapon
#endif 
#define GivePlayerWeapon WPS_GivePlayerWeapon

stock CreateUniqueWeaponId(playerid, weaponid, ammo, givetype)
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