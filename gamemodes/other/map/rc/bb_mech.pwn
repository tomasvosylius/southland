#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid)
{
    RemoveBuildingForPlayer(playerid, 1412, 222.804, -238.945, 1.851, 0.250);
    RemoveBuildingForPlayer(playerid, 1412, 209.570, -271.835, 1.851, 0.250);
    RemoveBuildingForPlayer(playerid, 13295, 207.804, -249.147, 7.093, 0.250);
    RemoveBuildingForPlayer(playerid, 13298, 207.804, -249.147, 7.093, 0.250);
}
hook OnGameModeInit()
{
    new tmpobjid;
    tmpobjid = CreateDynamicObject(13295, 207.804992, -249.147994, 7.093750, 0.000000, 0.000000, 89.999992, -1, -1, -1, 250.00, 250.00); 
    SetDynamicObjectMaterial(tmpobjid, 2, 16640, "a51", "wallgreyred128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 6404, "beafron1_law2", "comptwall30", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00FF0000);
    SetDynamicObjectMaterial(tmpobjid, 8, 18880, "speedcamera1", "metallamppost4", 0x00FF0000);
    SetDynamicObjectMaterial(tmpobjid, 9, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00FF0000);
    tmpobjid = CreateDynamicObject(3498, 221.585067, -257.431457, 0.098124, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.00, 250.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "bluemetal", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 16640, "a51", "bluemetal", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    tmpobjid = CreateDynamicObject(3498, 221.585067, -257.431457, 9.078125, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.00, 250.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "bluemetal", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 16640, "a51", "bluemetal", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    tmpobjid = CreateDynamicObject(3498, 221.585067, -268.811370, 0.098124, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.00, 250.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "bluemetal", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 16640, "a51", "bluemetal", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    tmpobjid = CreateDynamicObject(3498, 221.585067, -268.811370, 9.118123, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.00, 250.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "bluemetal", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 16640, "a51", "bluemetal", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    tmpobjid = CreateDynamicObject(3498, 221.580474, -264.207855, 9.664748, 0.000000, 90.000000, 90.000000, -1, -1, -1, 250.00, 250.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "bluemetal", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 16640, "a51", "bluemetal", 0x00000000);
    tmpobjid = CreateDynamicObject(3498, 221.590469, -261.997955, 9.664748, 0.000000, 90.000000, 90.000000, -1, -1, -1, 250.00, 250.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "bluemetal", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 16640, "a51", "bluemetal", 0x00000000);
    tmpobjid = CreateDynamicObject(3498, 221.590469, -261.727996, 13.514756, 0.000000, 90.000000, 90.000000, -1, -1, -1, 250.00, 250.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "bluemetal", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 16640, "a51", "bluemetal", 0x00000000);
    tmpobjid = CreateDynamicObject(3498, 221.600479, -264.508026, 13.514756, 0.000000, 90.000000, 90.000000, -1, -1, -1, 250.00, 250.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "bluemetal", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 16640, "a51", "bluemetal", 0x00000000);
    tmpobjid = CreateDynamicObject(2949, 193.013122, -227.626388, 0.678618, 0.000000, 0.000000, 360.000000, -1, -1, -1, 250.00, 250.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(3109, 200.582565, -235.265167, 1.948124, 0.000000, 0.000000, -15.200000, -1, -1, -1, 250.00, 250.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(3632, 193.948287, -229.347946, 1.278618, 0.000000, 0.000000, -116.499984, -1, -1, -1, 250.00, 250.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2960, 210.048721, -247.323562, 1.258124, 0.000000, 0.000000, -2.900000, -1, -1, -1, 250.00, 250.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19900, 221.758850, -234.802139, 0.740494, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.00, 250.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19900, 221.758850, -234.802139, 1.590493, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.00, 250.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(3632, 201.877120, -232.876449, 1.278618, 0.000000, 0.000000, -116.499984, -1, -1, -1, 250.00, 250.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1370, 221.542068, -233.982330, 1.278618, 0.000000, 0.000000, 158.299972, -1, -1, -1, 250.00, 250.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFF4F4F4);
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    tmpobjid = CreateDynamicObject(1294, 197.148803, -248.741561, 5.298123, 0.000000, 0.000000, 90.000000, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(1294, 217.808822, -248.741561, 5.298123, 0.000000, 0.000000, 90.000000, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(1713, 198.020675, -230.637741, 0.748618, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(2166, 195.622146, -233.727539, 0.748619, 0.000000, 0.000000, 270.000000, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(2007, 193.943954, -234.752975, 0.778618, 0.000000, 0.000000, 90.000000, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(1808, 200.732833, -231.903244, 0.778618, 0.000000, 0.000000, -86.600006, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(1721, 197.422729, -235.092987, 0.778618, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(1714, 195.400268, -234.773864, 0.778618, 0.000000, 0.000000, 128.500045, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(19893, 195.965820, -233.680221, 1.538618, 0.000000, 0.000000, -16.399997, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(19997, 194.303771, -230.854141, 0.748618, 0.000000, 0.000000, -85.699989, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(2595, 193.979476, -230.652145, 1.938618, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(2855, 194.636932, -231.080474, 1.588618, 0.000000, 0.000000, -5.799999, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(2852, 196.617340, -234.655624, 1.528618, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(2001, 200.549850, -230.638626, 0.778618, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(1665, 194.560974, -230.614135, 1.608618, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(1209, 196.471038, -230.196670, 0.738618, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(1415, 193.455810, -237.882232, 0.678124, 0.000000, 0.000000, 90.000000, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(3035, 220.035736, -222.710372, 1.298124, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(1431, 200.965820, -223.408874, 1.118125, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(19903, 218.598876, -229.835128, 0.758618, 0.000000, 0.000000, -145.599960, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(11709, 200.895904, -224.857910, 1.438618, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(19627, 221.712371, -232.055465, 1.718619, 0.000000, 0.000000, -30.199998, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(1810, 210.099807, -236.975067, 0.548125, 0.000000, 0.000000, 16.600002, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(1810, 211.518905, -237.138885, 0.548125, 0.000000, 0.000000, -19.799997, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(19817, 215.195251, -232.254821, -0.791381, 0.000000, 0.000000, 270.000000, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(19815, 209.757171, -224.416763, 2.558618, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(19899, 218.928237, -224.903671, 0.778618, 0.000000, 0.000000, 270.000000, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(19899, 220.598281, -224.863708, 0.778618, 0.000000, 0.000000, 270.000000, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(19899, 221.678176, -226.663726, 0.778618, 0.000000, 0.000000, 180.000000, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(936, 221.779663, -230.350540, 1.228618, 0.000000, 0.000000, 270.000000, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(936, 221.779663, -232.500564, 1.228618, 0.000000, 0.000000, 270.000000, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(3761, 196.502868, -225.318740, 2.048619, 0.000000, 0.000000, 90.000000, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(18633, 221.790466, -232.694305, 1.728618, 0.000000, 90.000000, -46.699993, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(19921, 221.718414, -230.233337, 1.798618, 0.000000, 0.000000, -35.599998, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(19899, 201.885925, -231.142181, 0.778618, 0.000000, 0.000000, 0.000000, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(19921, 202.136688, -230.557189, 2.118618, 0.000000, 0.000000, 92.600021, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(1358, 213.144470, -250.589920, 1.778125, 0.000000, 0.000000, -20.799999, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(12957, 218.752929, -250.919708, 1.278125, 0.000000, 0.000000, 90.000000, -1, -1, -1, 250.00, 250.00); 
    tmpobjid = CreateDynamicObject(1327, 212.984985, -248.374832, 0.911619, 0.000000, 90.000000, 0.000000, -1, -1, -1, 250.00, 250.00); 
}