#include <YSI\y_hooks>

hook OnPlayerConnect(playerid)
{
    RemoveBuildingForPlayer(playerid, 5551, 2140.5156, -1735.1406, 15.8906, 0.25);
	RemoveBuildingForPlayer(playerid, 5410, 2140.5156, -1735.1406, 15.8906, 0.25);
    RemoveBuildingForPlayer(playerid, 1308, 2110.699, -1742.579, 12.703, 0.250);
    return 1;
}

hook OnGameModeInit()
{
    new tmpobjid;
    tmpobjid = CreateObject(5410, 2140.515625, -1735.140625, 15.890600, 0.000000, 0.000000, 0.000000, 450.00); 
    SetObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetObjectMaterial(tmpobjid, 1, 7088, "casinoshops1", "vgsn_yelwall", 0x00000000);
    SetObjectMaterial(tmpobjid, 5, 7088, "casinoshops1", "vgsn_yelwall", 0xFFFAFAFA);
    // SetObjectMaterial(tmpobjid, 4, 7088, "casinoshops1", "vgsn_yelwall", 0x00000000);


    tmpobjid = CreateDynamicObject(10149, 2126.514160, -1734.739624, 14.031153, 0.499998, 0.000000, 89.999954, -1, -1, -1, 330.00, 330.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10778, "airportcpark_sfse", "ws_doubledoor1", 0x00000000);
    tmpobjid = CreateDynamicObject(19367, 2115.767822, -1742.126342, 14.062497, 0.000000, 0.000000, 90.000000, -1, -1, -1, 330.00, 330.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 13364, "cetown3cs_t", "sw_wind18", 0x00000000);
    tmpobjid = CreateDynamicObject(19367, 2112.570068, -1742.126342, 14.062497, 0.000000, 0.000000, 90.000000, -1, -1, -1, 330.00, 330.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 13364, "cetown3cs_t", "sw_door18", 0x00000000);
    tmpobjid = CreateDynamicObject(19377, 2113.942871, -1742.101318, 10.776246, 0.000000, 0.000000, 90.000000, -1, -1, -1, 330.00, 330.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 7088, "casinoshops1", "vgsn_yelwall", 0x00000000);

    tmpobjid = CreateDynamicObject(1372, 2127.090820, -1738.175781, 12.676728, 0.000000, 0.000000, 88.000000);
    tmpobjid = CreateDynamicObject(1372, 2127.026855, -1740.045166, 12.676728, 0.000000, 0.000000, 88.000000);
    tmpobjid = CreateDynamicObject(1440, 2127.175048, -1730.987792, 13.045541, 0.000000, 0.000000, 89.199966);
    tmpobjid = CreateDynamicObject(2670, 2127.132812, -1735.800903, 12.633355, 0.000000, 0.000000, 0.000000);
    tmpobjid = CreateDynamicObject(1308, 2109.057128, -1742.690063, 12.572503, 0.000000, 0.000000, 0.000000);
    return 1;
}
