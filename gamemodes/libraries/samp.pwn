
stock SendChatMessage(playerid, color, const text[]) return SendClientMessage(playerid, color, text);
stock SendChatMessageToAll(color, const text[]) return SendClientMessageToAll(color, text);

stock sd_DestroyDynamicObject(STREAMER_TAG_OBJECT objectid, called[] = "default", extra[] = "")
{
	#pragma unused called, extra
	#if SERVER_DEBUG_LEVEL >= 5
		//printf("[destroy] DestroyDynamicObject(%d, %d, %s[%s])", objectid, GetDynamicObjectModel(objectid), called, extra);
		for(new i = 0; i < sizeof __furnitureObjects; i++)
		{
			if(__furnitureObjects[i] == objectid)
			{
				printf("[destroy] %d is on furniture! %s", objectid, !isequal(called, "furniture") ? ("not furniture function!") : (""));
				__furnitureObjects[i] = 0;
				break;
			}
		}
	#endif
	return DestroyDynamicObject(objectid);
}

#if defined _ALS_DestroyDynamicObject
	#undef DestroyDynamicObject
#else 
	#define _ALS_DestroyDynamicObject
#endif 
#define DestroyDynamicObject sd_DestroyDynamicObject

stock STREAMER_TAG_OBJECT sd_CreateDynamicObject(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = STREAMER_OBJECT_SD, Float:drawdistance = STREAMER_OBJECT_DD, STREAMER_TAG_AREA areaid = STREAMER_TAG_AREA -1, priority = 0, called[] = "default", extra[] = "")
{
	new STREAMER_TAG_OBJECT id = CreateDynamicObject(modelid, x, y, z, rx, ry, rz, worldid, interiorid, playerid, streamdistance, drawdistance, areaid, priority);
	#pragma unused called, extra
	#if SERVER_DEBUG_LEVEL >= 5
		if(isequal(called, "furniture"))
		{
			for(new i = 0; i < sizeof __furnitureObjects; i++)
			{
				if(__furnitureObjects[i] <= 0)
				{
					__furnitureObjects[i] = id;
					break;
				}
			}
		}
		//printf("[create] CreateDynamicObject(%d, %d, %s[%s])", id, modelid, called, extra);
	#endif
	return id;
}

#if defined _ALS_CreateDynamicObject
	#undef CreateDynamicObject
#else 
	#define _ALS_CreateDynamicObject
#endif 
#define CreateDynamicObject sd_CreateDynamicObject


stock Float:GetDistanceBetweenPoints3D(Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2)
{
	/*
	 * Sampas neturi tokios funkcijos
	 * Atstumtas tarp 2 tasku
	 */
    return VectorSize(x1-x2,y1-y2,z1-z2);
}


stock SendToAllExept(color, string[], ...)
{
	new
		args = numargs();
	foreach(Player, playerid)
	{
		for(new i = 3; i <= args; i++) if(i == playerid) { continue; }
		SendClientMessage(playerid, color, string);
	}
	return 1;
}
#define toupper(%0) (((%0) >= 'a' && (%0) <= 'z') ? ((%0) & ~0x20) : (%0))
#define tolower(%0) (((%0) >= 'A' && (%0) <= 'Z') ? ((%0) | 0x20) : (%0))
stock strtoupper(string[])
{
	new upperString[256];
	for (new character = 0; character < strlen(string); character++)
	{
		upperString[character] = toupper(string[character]);
	}
	return upperString;
}
stock strtolower(string[])
{
	new lowerString[256];
	for (new character = 0; character < strlen(string); character++)
	{
		lowerString[character] = tolower(string[character]);
	}
	return lowerString;
}
