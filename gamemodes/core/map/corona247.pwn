#include <YSI\y_hooks>

hook OnPlayerConnect(playerid)
{
    RemoveBuildingForPlayer(playerid, 5205, 2111.6563, -1873.3672, 16.3984, 0.25);
    RemoveBuildingForPlayer(playerid, 5183, 2111.6563, -1873.3672, 16.3984, 0.25);
    // RemoveBuildingForPlayer(playerid, 5206, 2163.6719, -1873.6172, 15.8203, 0.25);
    // RemoveBuildingForPlayer(playerid, 5180, 2163.6719, -1873.6172, 15.8203, 0.25);
}
hook OnGameModeInit()
{
    new tmpobjid;
    tmpobjid = CreateObject(5183, 2111.656250, -1873.367187, 16.398399, 0.000000, 0.000000, 0.000000, 330.00); 
    SetObjectMaterial(tmpobjid, 0, 4552, "ammu_lan2", "corporate1", 0x00000000);
    SetObjectMaterial(tmpobjid, 1, 14690, "7_11_posters", "CJ_7_11_POST2", 0x00000000);
    SetObjectMaterial(tmpobjid, 3, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
    SetObjectMaterial(tmpobjid, 5, 10041, "archybuild10", "copshop5", 0x00000000);
    SetObjectMaterial(tmpobjid, 6, 10041, "archybuild10", "copshop3", 0x00000000);
    // tmpobjid = CreateObject(5180, 2163.671875, -1873.617187, 15.820300, 0.000000, 0.000000, 0.000000, 330.00); 
}