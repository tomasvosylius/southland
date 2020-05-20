#include <YSI_Coding\y_hooks>

// by turbo
hook OnPlayerConnect(playerid)
{
    RemoveBuildingForPlayer(playerid, 4976, 1931.000, -1871.390, 15.843, 0.250);
    RemoveBuildingForPlayer(playerid, 4848, 1931.000, -1871.390, 15.843, 0.250);
    RemoveBuildingForPlayer(playerid, 1226, 1931.875, -1863.460, 16.320, 0.250);
    RemoveBuildingForPlayer(playerid, 1226, 1915.742, -1863.460, 16.320, 0.250);
    return 1;
}
hook OnGameModeInit()
{
    new tmpobjid;
    tmpobjid = CreateDynamicObject(8849, 1904.161132, -1869.065063, 16.255029, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicbrikwall01", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 10101, "2notherbuildsfe", "sl_vicbrikwall01", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 10101, "2notherbuildsfe", "sl_vicbrikwall01", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 17508, "barrio1_lae2", "gangshop10_LAe", 0x00000000);
    tmpobjid = CreateDynamicObject(3467, 1921.564575, -1854.613037, 13.274880, 0.000000, 0.000000, 44.160919, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 7985, "vgsswarehse02c", "wddngchapelsign06_128", 0x00000000);
    tmpobjid = CreateDynamicObject(8408, 1951.015380, -1878.890991, 18.929170, 0.000000, 0.000000, 321.595489, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 1, 7985, "vgsswarehse02c", "wddngchapelsign06_128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 8401, "vgshpground", "parkingsign01_128", 0x00000000);
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    tmpobjid = CreateDynamicObject(1412, 1941.287231, -1879.729248, 13.628729, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1412, 1936.059570, -1879.749267, 13.628729, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1412, 1946.490112, -1879.726928, 13.628729, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1297, 1934.645996, -1856.254028, 15.749300, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1297, 1936.052246, -1878.460693, 15.749300, 0.000000, 0.000000, 269.114257, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1415, 1904.673095, -1853.332885, 12.680990, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    return 1;
}