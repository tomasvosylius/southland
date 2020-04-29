/*
 *
 * SAN ANDREAS MULTIPLAYER EFFECTS.PWN BY TOMAS TORKQ VOSYLIUS
 * ALL RIGHTS RESERVED
 * 2016
 *
 */

#include <YSI\y_hooks>

/*
 * Hooks
 */


/*
 * Functions
 */ 

stock CreateBlood(Float:x, Float:y, Float:z, time = 3000, playerid = INVALID_PLAYER_ID)
{
	/* 
		Funkcija, sukurianti kraujo demes objekta.
	*/
	new Float:rx, Float:ry, Float:rz;
	if(CA_RayCastLineAngle(x, y, z, x, y, z-2.0, x, y, z, rx, ry, rz) != 0)
	{
		SetTimerEx("DestroyBlood", time, false, "d", CreateDynamicObject(19836, x, y, z+0.01, rx, ry, rz, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1, 30.0, 30.0, .called = "effects", .extra = "blood"));
		if(playerid != INVALID_PLAYER_ID) Streamer_Update(playerid);
		return 1;
	}
	return 0;
}

stock CreateItem(Float:x, Float:y, Float:z, objectid, &object_return, playerid = INVALID_PLAYER_ID, Float:addrotationx = 0.0, Float:addrotationy = 0.0, Float:addrotationz = 0.0)
{
	new Float:rx, Float:ry, Float:rz;
	if(CA_RayCastLineAngle(x, y, z, x, y, z-3.0, x, y, z, rx, ry, rz) != 0)
	{
		new Float:finalrx = addrotationx+rx, // abu neigiami, paliekam abu
			Float:finalry = addrotationy+ry, // abu neigiami, paliekam abu
			Float:finalrz = addrotationz+rz;

		if(objectid < 400)
		{
			if(rx < -1.0 && ry > 1.0)
			{
				//finalry = addrotationy+ry;
			}
			else if(rx > 1.0 && ry < -1.0)
			{
				finalry = -addrotationy+ry;
			}
		}

		object_return = CreateDynamicObject(objectid, x, y, z+0.01, finalrx, finalry, finalrz, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1, 30.0, 30.0, .called = "drops", .extra = "create");
		if(playerid != INVALID_PLAYER_ID) Streamer_Update(playerid);
		return 1;
	}
	return 0;
}

stock CreateRoadblock(playerid, type)
{
	new 
		free = Iter_Free(Roadblock);
	if(free != MAX_ROADBLOCKS-1)
	{
		new
	    	objectid = 0,
	    	Float:x, Float:y, Float:z, Float:a;
		switch(type)
		{
		    case 1: objectid = 978;
		    case 2: objectid = 981;
		    case 3: objectid = 1228;
		    case 4: objectid = 1423;
		    case 5: objectid = 1251;
		    case 6: objectid = 8548;
		    case 7: objectid = 2599;
			case 8: objectid = 1238;
			case 9: objectid = 19950;
			case 10: objectid = 19966;
			case 11: objectid = 19972;
			case 12: objectid = 2892;
		}
		if(objectid != 0)
		{
			GetPlayerPos(playerid, x, y, z);
			GetPlayerFacingAngle(playerid, a);
			GetXYJudgedByAngle(1.5, x, y, a, x, y);
			Roadblocks[free] = CreateDynamicObject(objectid, x, y, z, 0.0, 0.0, a, .called = "effects", .extra = "roadblock");
			switch(objectid)
			{
				case 2599:
				{
					SetDynamicObjectMaterial(Roadblocks[free], 0, 967, "cj_barr_set_1", "Stop2_64");
				}
				case 8548:
				{
					SetDynamicObjectMaterial(Roadblocks[free], 0, 7184, "vgndwntwn1", "stop2_64");
				}
				case 1251:
				{
					SetDynamicObjectMaterial(Roadblocks[free], 0, 12938, "sw_apartments", "sw_policeline");
				}
			}
			Streamer_Update(playerid);
			EditDynamicObject(playerid, Roadblocks[free]);
			Iter_Add(Roadblock, free);
			return true;
		}
	}
	return false;
}

stock DestroyRoadblock(playerid)
{
	new 
		Float:rb_x, 
		Float:rb_y, 
		Float:rb_z;
	foreach(new rb : Roadblock)
	{
		GetDynamicObjectPos(Roadblocks[rb], rb_x, rb_y, rb_z);
		if(IsPlayerInRangeOfPoint(playerid, 5.0, rb_x, rb_y, rb_z))
		{
			if(IsValidDynamicObject(Roadblocks[rb])) DestroyDynamicObject(Roadblocks[rb], "effects", "roadblock");
			Roadblocks[rb] = INVALID_OBJECT_ID;
			Iter_Remove(Roadblock, rb);
			return true;
		}
	}
	return false;
}
