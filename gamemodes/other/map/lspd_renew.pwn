#include <YSI_Coding\y_hooks>
// author: Tomas "f0cus"
hook OnPlayerConnect(playerid)
{
    RemoveBuildingForPlayer(playerid, 3976, 1571.599, -1675.750, 35.679, 0.250);
    RemoveBuildingForPlayer(playerid, 4064, 1571.599, -1675.750, 35.679, 0.250);
    RemoveBuildingForPlayer(playerid, 3975, 1578.469, -1676.420, 13.070, 0.250);
    RemoveBuildingForPlayer(playerid, 4063, 1578.469, -1676.420, 13.070, 0.250);
}
hook OnGameModeInit()
{
    //Objects////////////////////////////////////////////////////////////////////////////////////////////////////////

    // pastatas
    new tmpobjid;
    tmpobjid = CreateObject(3976, 1571.599975, -1675.750000, 35.679698, 0.000000, 0.000000, 0.000000, 400.00); 
    SetObjectMaterial(tmpobjid, 0, 3979, "civic01_lan", "sl_laglasswall1", 0x00000000);
    SetObjectMaterial(tmpobjid, 4, 3979, "civic01_lan", "sl_concretewall1", 0x00000000);
    SetObjectMaterial(tmpobjid, 5, 3979, "civic01_lan", "sl_concretewall1", 0x00000000);
    SetObjectMaterial(tmpobjid, 6, 3979, "civic01_lan", "sl_concretewall1", 0x00000000);
    SetObjectMaterial(tmpobjid, 7, 3979, "civic01_lan", "sl_laglasswall2", 0x00000000);
    SetObjectMaterial(tmpobjid, 8, 3979, "civic01_lan", "sl_flagstone1", 0x00000000);
    SetObjectMaterial(tmpobjid, 12, 3979, "civic01_lan", "sl_laglasswall1", 0x00000000);
    SetObjectMaterial(tmpobjid, 13, 3979, "civic01_lan", "sl_flagstone1", 0x00000000);
    // aikstele
    tmpobjid = CreateObject(3975, 1578.469970, -1676.420043, 13.070300, 0.000000, 0.000000, 0.000000, 400.0); 
    SetObjectMaterial(tmpobjid, 8, 14577, "casinovault01", "conc_wall_128H", 0x00000000);
    SetObjectMaterial(tmpobjid, 11, 14577, "casinovault01", "conc_wall_128H", 0x00000000);

    // Virsuj langai
    tmpobjid = CreateDynamicObject(19447, 1558.465209, -1673.924804, 46.594650, 90.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3979, "civic01_lan", "sl_laglasswall1", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1558.425170, -1677.395141, 46.594650, 90.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3979, "civic01_lan", "sl_laglasswall1", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1558.455200, -1677.395141, 36.994628, 90.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3979, "civic01_lan", "sl_laglasswall1", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1558.515258, -1673.914916, 36.994628, 90.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3979, "civic01_lan", "sl_laglasswall1", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1558.515258, -1673.914916, 27.364633, 90.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3979, "civic01_lan", "sl_laglasswall1", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1558.485229, -1677.375122, 27.364633, 90.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3979, "civic01_lan", "sl_laglasswall1", 0x00000000);

    // tekstas
    tmpobjid = CreateDynamicObject(19370, 1555.096801, -1675.559204, 24.020654, 0.000000, 0.000000, 0.000000, -1, -1, -1, 150.0, 150.0); 
    SetDynamicObjectMaterialText(tmpobjid, 0, "LOS SANTOS", 130, "Engravers MT", 70, 0, 0xFF615F3D, 0x00000000, 1);
    tmpobjid = CreateDynamicObject(19370, 1555.096801, -1675.559204, 23.080636, 0.000000, 0.000000, 0.000000, -1, -1, -1, 150.0, 150.0); 
    SetDynamicObjectMaterialText(tmpobjid, 0, "POLICE", 130, "Engravers MT", 120, 0, 0xFF615F3D, 0x00000000, 1);
    tmpobjid = CreateDynamicObject(19370, 1555.096801, -1675.559204, 22.110630, 0.000000, 0.000000, 0.000000, -1, -1, -1, 150.0, 150.0); 
    SetDynamicObjectMaterialText(tmpobjid, 0, "DEPARTMENT", 130, "Engravers MT", 63, 0, 0xFF615F3D, 0x00000000, 1);
    


    // kita
    tmpobjid = CreateDynamicObject(19805, 1544.587036, -1620.469360, 13.402812, 0.000000, 0.000000, 90.000000, -1, -1, -1, 200.0, 200.0); 
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19805, 1544.516967, -1620.469360, 13.402811, 0.000000, 0.000000, 270.000000, -1, -1, -1, 200.0, 200.0); 
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "concretegroundl1_256", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19805, 1544.496459, -1620.497070, 13.354550, 0.000000, 0.000000, 270.000000, -1, -1, -1, 200.0, 200.0); 
    SetDynamicObjectMaterialText(tmpobjid, 0, "PERSONNEL\nONLY", 130, "Engravers MT", 60, 1, 0xFF000000, 0x00000000, 1);
    tmpobjid = CreateDynamicObject(18762, 1543.640869, -1634.538330, 10.856856, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.0, 200.0); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3979, "civic01_lan", "sl_concretewall1", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1543.820312, -1637.539428, 13.046871, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.0, 200.0); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
    SetDynamicObjectMaterialText(tmpobjid, 0, "invisiblewall", 10, "Ariel", 20, 0, 0x00000000, 0x00000000, 0);
    
    // slagbm
    // tmpobjid = CreateDynamicObject(2920, 1544.698486, -1630.883178, 13.072809, -90.000000, 0.000000, 0.000000, -1, -1, -1, 200.0, 200.0); 
    // SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    // vartai
    // tmpobjid = CreateDynamicObject(3037, 1589.495483, -1638.534667, 14.352805, 0.000000, 0.000000, 90.000000, -1, -1, -1, 200.0, 200.0); 
    // SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2959, 1584.123291, -1638.130737, 12.350441, 0.000000, 0.000000, 90.000000, -1, -1, -1, 200.0, 200.0); 
    SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", 0xFFFFFFFF);
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    tmpobjid = CreateDynamicObject(1280, 1543.125122, -1658.382446, 12.936879, 0.000000, 0.000000, 0.000000, -1, -1, -1, 180.0, 180.0); 
    tmpobjid = CreateDynamicObject(1280, 1543.125122, -1663.972656, 12.936879, 0.000000, 0.000000, 0.000000, -1, -1, -1, 180.0, 180.0); 
    tmpobjid = CreateDynamicObject(1280, 1543.125122, -1687.164062, 12.936879, 0.000000, 0.000000, 0.000000, -1, -1, -1, 180.0, 180.0); 
    tmpobjid = CreateDynamicObject(1280, 1543.125122, -1693.014038, 12.936879, 0.000000, 0.000000, 0.000000, -1, -1, -1, 180.0, 180.0); 
    tmpobjid = CreateDynamicObject(1226, 1538.559936, -1698.686157, 16.382806, 0.000000, 0.000000, 0.000000, -1, -1, -1, 180.0, 180.0); 
    tmpobjid = CreateDynamicObject(1226, 1538.559936, -1652.154663, 16.382806, 0.000000, 0.000000, 0.000000, -1, -1, -1, 180.0, 180.0); 
    tmpobjid = CreateDynamicObject(1359, 1542.596801, -1661.442993, 13.216876, 0.000000, 0.000000, 0.000000, -1, -1, -1, 150.0, 150.0); 
    tmpobjid = CreateDynamicObject(1359, 1542.596801, -1690.193725, 13.216876, 0.000000, 0.000000, 0.000000, -1, -1, -1, 150.0, 150.0); 
    tmpobjid = CreateDynamicObject(1258, 1546.241333, -1671.357543, 13.136871, 0.000000, 0.000000, 270.000000, -1, -1, -1, 150.0, 150.0); 
    tmpobjid = CreateDynamicObject(1257, 1521.035888, -1676.551757, 13.806874, 0.000000, 0.000000, 180.000000, -1, -1, -1, 200.0, 200.0); 
    tmpobjid = CreateDynamicObject(1537, 1565.885009, -1683.810424, 27.395599, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.0, 200.0); 
    tmpobjid = CreateDynamicObject(9697, 1595.696899, -1606.427246, 12.388662, 0.000000, 0.099999, 0.000000, -1, -1, -1, 200.0, 200.0); 
    tmpobjid = CreateDynamicObject(1342, 1515.667602, -1658.298706, 13.569173, 0.000000, 0.000000, 8.100000, -1, -1, -1, 200.0, 200.0); 
    tmpobjid = CreateDynamicObject(3467, 1544.561279, -1619.715820, 13.236863, 0.000000, 0.000000, 90.000000, -1, -1, -1, 200.0, 200.0); 
    tmpobjid = CreateDynamicObject(3467, 1544.561279, -1620.635742, 13.236863, 0.000000, 0.000000, 90.000000, -1, -1, -1, 200.0, 200.0); 
    tmpobjid = CreateDynamicObject(3467, 1544.561279, -1621.236328, 13.226862, 0.000000, 0.000000, 90.000000, -1, -1, -1, 200.0, 200.0); 
}
