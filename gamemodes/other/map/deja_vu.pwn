#include <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
	//Objects////////////////////////////////////////////////////////////////////////////////////////////////////////
	new tmpobjid;
	tmpobjid = CreateDynamicObject(1536,410.427,-1729.704,8.392,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 3241, "conhooses", "trail_door", 0x00000000);
	tmpobjid = CreateDynamicObject(1536,413.437,-1729.704,8.392,0.000,-0.000,179.999,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 3241, "conhooses", "trail_door", 0x00000000);
	tmpobjid = CreateDynamicObject(19325,408.947,-1729.515,11.042,0.000,0.000,270.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterialText(tmpobjid, 0, "DEJA VU", 130, "Segoe Keycaps", 50, 1, 0xFFFF00FF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19325,409.257,-1729.515,10.412,0.000,0.000,270.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterialText(tmpobjid, 0, "STRIP", 130, "Segoe Keycaps", 50, 1, 0xFFFF00FF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19325,408.517,-1729.515,9.852,0.000,0.000,270.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterialText(tmpobjid, 0, "CLUB", 130, "Segoe Keycaps", 50, 1, 0xFFFF00FF, 0x00000000, 1);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	tmpobjid = CreateDynamicObject(1549,413.782,-1729.390,8.317,0.000,0.000,-42.099,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(2588,414.289,-1729.476,10.948,0.000,0.000,180.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(2587,414.993,-1729.471,10.121,0.000,0.000,180.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(2588,415.859,-1729.476,10.318,0.000,0.000,180.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(18651,417.959,-1730.019,11.899,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(18651,411.939,-1729.929,11.899,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	tmpobjid = CreateDynamicObject(18651,405.749,-1729.879,11.899,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);

}