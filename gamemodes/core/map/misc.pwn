#include <YSI\y_hooks>

hook OnPlayerConnect(playerid)
{
	// centuris
	RemoveBuildingForPlayer(playerid, 1308, 2091.3594, -1910.4844, 12.5703, 0.25);

	// turbo mc 
	RemoveBuildingForPlayer(playerid, 17905, 2568.0234, -1098.3203, 59.5391, 0.25);
	RemoveBuildingForPlayer(playerid, 1468, 2610.6953, -1080.1094, 69.8672, 0.25);
	RemoveBuildingForPlayer(playerid, 1468, 2627.2891, -1077.5391, 69.8828, 0.25);
}

hook OnGameModeInit()
{
	new tmpobjid;

	// Degalines nematomi Idlewood aptvarai
	tmpobjid = CreateDynamicObject(19445, 1942.29529, -1774.96631, 14.29397,   0.00000, 0.00000, 0.00000, -1, -1, -1, 25.0, 25.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 0, "none", "none", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1942.27905, -1770.35022, 14.29397,   0.00000, 0.00000, 0.00000, -1, -1, -1, 25.0, 25.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 0, "none", "none", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1941.02747, -1770.39246, 14.29397,   0.00000, 0.00000, 0.00000, -1, -1, -1, 25.0, 25.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 0, "none", "none", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1941.03162, -1775.25244, 14.29397,   0.00000, 0.00000, 0.00000, -1, -1, -1, 25.0, 25.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 0, "none", "none", 0x00000000);

	// turbo mc
	CreateObject(1468, 2609.22559, -1091.73889, 69.86719,   3.13290, 0.00076, -3.05433);
	CreateObject(1468, 2614.52002, -1092.00977, 69.86720,   0.00000, 0.00080, 358.59351);
	CreateObject(1468, 2610.03979, -1074.56213, 69.86720,   0.00000, 0.00080, 3.22692);
	CreateObject(1468, 2615.31714, -1074.26953, 69.86720,   0.00000, 0.00080, 3.22692);
	CreateObject(659, 2674.56934, -996.12659, 68.09375,   3.14159, 0.00000, 2.14675);
	CreateObject(673, 2610.39575, -1076.15930, 65.24219,   356.85840, 0.00000, -1.39626);
	CreateObject(14468, 2629.95581, -1076.78101, 68.92120,   0.00000, 0.00000, 171.56830);
	CreateObject(1432, 2609.79199, -1085.68616, 68.71770,   0.00000, 0.00000, 0.00000);

	// centuris
	CreateDynamicObject(2807, 2091.22339, -1912.25708, 12.95590,   0.00000, 0.00000, 72.40080);
	CreateDynamicObject(2764, 2091.14819, -1909.43811, 12.94850,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2807, 2091.13086, -1908.33789, 12.95590,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2807, 2090.23169, -1909.48157, 12.95590,   0.00000, 0.00000, 173.54398);
	CreateDynamicObject(2764, 2091.15454, -1912.83667, 12.94850,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2807, 2089.98535, -1912.62048, 12.95590,   0.00000, 0.00000, 170.18349);
	CreateDynamicObject(2807, 2091.22900, -1910.54761, 12.95590,   0.00000, 0.00000, 315.94162);
	CreateDynamicObject(2807, 2091.33325, -1913.84900, 12.95590,   0.00000, 0.00000, 295.76483);
	CreateDynamicObject(1510, 2091.11768, -1909.26074, 13.36433,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1510, 2091.34302, -1912.95117, 13.36376,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1486, 2091.35181, -1909.57910, 13.50540,   0.00000, 0.00000, 162.13782);
	CreateDynamicObject(1486, 2091.40063, -1909.47241, 13.50540,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1486, 2091.41724, -1912.70581, 13.50540,   0.00000, 0.00000, 162.13782);

	// quel chinese stalai
	tmpobjid = CreateDynamicObject(2764,2714.790,-1436.092,29.833,0.000,0.000,-33.699,-1,-1,-1,100.000,100.000);
	SetDynamicObjectMaterial(tmpobjid, 1, 19058, "xmasboxes", "wrappingpaper1", 0x00000000);
	tmpobjid = CreateDynamicObject(2764,2714.538,-1432.509,29.833,0.000,0.000,-2.699,-1,-1,-1,100.000,100.000);
	SetDynamicObjectMaterial(tmpobjid, 1, 19058, "xmasboxes", "wrappingpaper1", 0x00000000);
	tmpobjid = CreateDynamicObject(2807,2715.553,-1434.812,29.953,0.000,0.000,61.299,-1,-1,-1,100.000,100.000);
	SetDynamicObjectMaterial(tmpobjid, 1, 19058, "xmasboxes", "wrappingpaper1", 0x00000000);
	tmpobjid = CreateDynamicObject(2807,2713.595,-1435.327,29.953,0.000,0.000,151.299,-1,-1,-1,100.000,100.000);
	SetDynamicObjectMaterial(tmpobjid, 1, 19058, "xmasboxes", "wrappingpaper1", 0x00000000);
	tmpobjid = CreateDynamicObject(2807,2713.926,-1437.242,29.953,0.000,0.000,241.299,-1,-1,-1,100.000,100.000);
	SetDynamicObjectMaterial(tmpobjid, 1, 19058, "xmasboxes", "wrappingpaper1", 0x00000000);
	tmpobjid = CreateDynamicObject(2807,2716.090,-1436.748,29.953,0.000,0.000,331.299,-1,-1,-1,100.000,100.000);
	SetDynamicObjectMaterial(tmpobjid, 1, 19058, "xmasboxes", "wrappingpaper1", 0x00000000);
	tmpobjid = CreateDynamicObject(2807,2716.003,-1432.220,29.953,0.000,0.000,13.099,-1,-1,-1,100.000,100.000);
	SetDynamicObjectMaterial(tmpobjid, 1, 19058, "xmasboxes", "wrappingpaper1", 0x00000000);
	tmpobjid = CreateDynamicObject(2807,2714.673,-1433.957,29.953,0.000,0.000,283.099,-1,-1,-1,100.000,100.000);
	SetDynamicObjectMaterial(tmpobjid, 1, 19058, "xmasboxes", "wrappingpaper1", 0x00000000);
	tmpobjid = CreateDynamicObject(2807,2713.118,-1432.457,29.953,0.000,0.000,179.299,-1,-1,-1,100.000,100.000);
	SetDynamicObjectMaterial(tmpobjid, 1, 19058, "xmasboxes", "wrappingpaper1", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,2712.191,-1435.285,33.421,0.000,90.000,0.000,-1,-1,-1,100.000,100.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "redmetal", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,2712.191,-1444.906,33.421,0.000,90.000,0.000,-1,-1,-1,100.000,100.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "redmetal", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	tmpobjid = CreateDynamicObject(11706,2713.052,-1441.021,29.447,0.000,0.000,270.000,-1,-1,-1,100.000,100.000);
	tmpobjid = CreateDynamicObject(19896,2715.094,-1436.080,30.264,0.000,0.000,-68.399,-1,-1,-1,100.000,100.000);
	tmpobjid = CreateDynamicObject(19896,2714.468,-1436.016,30.264,0.000,0.000,79.900,-1,-1,-1,100.000,100.000);
	tmpobjid = CreateDynamicObject(330,2714.947,-1436.299,30.215,90.000,-100.200,0.000,-1,-1,-1,100.000,100.000);
	tmpobjid = CreateDynamicObject(1665,2714.812,-1436.090,30.275,0.000,0.000,0.000,-1,-1,-1,100.000,100.000);
	tmpobjid = CreateDynamicObject(2858,2714.452,-1432.459,30.253,0.000,0.000,0.000,-1,-1,-1,100.000,100.000);

	// tadziaus vila
	tmpobjid = CreateDynamicObject(19359,1363.614,-847.287,45.327,0.000,0.000,-47.699,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 13699, "cunte2_lahills", "laposhfence3", 0x00000000);
	tmpobjid = CreateDynamicObject(19359,1365.989,-845.127,45.327,0.000,0.000,-47.699,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 13699, "cunte2_lahills", "laposhfence3", 0x00000000);
	tmpobjid = CreateDynamicObject(19359,1361.240,-849.448,44.477,0.000,0.000,-47.699,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 5710, "cemetery_law", "brickgrey", 0x00000000);
	tmpobjid = CreateDynamicObject(19359,1368.363,-842.966,44.477,0.000,0.000,-47.699,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 5710, "cemetery_law", "brickgrey", 0x00000000);
	tmpobjid = CreateDynamicObject(11732,1272.997,-831.082,82.140,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14629, "ab_chande", "ab_goldpipe", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 4833, "airprtrunway_las", "tuntest1las", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1257.043,-766.084,92.466,0.000,0.000,-0.800,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1267.042,-766.224,92.466,0.000,0.000,-0.800,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1277.040,-766.363,92.466,0.000,0.000,-0.800,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1287.029,-766.503,92.466,0.000,0.000,-0.800,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1297.018,-766.642,92.466,0.000,0.000,-0.800,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1305.592,-769.745,92.466,0.000,0.000,-39.100,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1305.592,-769.745,87.486,0.000,0.000,-39.100,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1313.344,-776.045,90.056,0.000,0.000,-39.100,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1313.344,-776.045,85.056,0.000,0.000,-39.100,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1318.559,-783.727,87.506,0.000,0.000,-72.599,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1318.559,-783.727,82.516,0.000,0.000,-72.599,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1319.988,-793.336,85.466,0.000,0.000,-90.500,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1319.988,-793.336,80.466,0.000,0.000,-90.500,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1318.209,-802.824,82.666,0.000,0.000,-110.799,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1318.209,-802.824,77.666,0.000,0.000,-110.799,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateDynamicObject(19463,1315.417,-809.515,78.289,0.000,0.000,-25.299,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 3314, "ce_burbhouse", "sw_wallbrick_06", 0x00000000);
	tmpobjid = CreateDynamicObject(19463,1307.259,-826.774,76.269,0.000,0.000,-25.299,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 3314, "ce_burbhouse", "sw_wallbrick_06", 0x00000000);
	tmpobjid = CreateDynamicObject(19463,1307.259,-826.774,72.769,0.000,0.000,-25.299,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 3314, "ce_burbhouse", "sw_wallbrick_06", 0x00000000);
	tmpobjid = CreateDynamicObject(19463,1301.518,-834.169,72.769,0.000,0.000,-50.300,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 3314, "ce_burbhouse", "sw_wallbrick_06", 0x00000000);
	tmpobjid = CreateDynamicObject(19463,1301.518,-834.169,76.269,0.000,0.000,-50.300,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 3314, "ce_burbhouse", "sw_wallbrick_06", 0x00000000);
	tmpobjid = CreateDynamicObject(19463,1295.133,-833.343,76.269,0.000,0.000,-144.600,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 3314, "ce_burbhouse", "sw_wallbrick_06", 0x00000000);
	tmpobjid = CreateDynamicObject(19463,1295.133,-833.343,72.779,0.000,0.000,-144.600,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 3314, "ce_burbhouse", "sw_wallbrick_06", 0x00000000);
	tmpobjid = CreateDynamicObject(19468,1274.084,-832.196,82.890,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	tmpobjid = CreateDynamicObject(2571,1289.131,-831.228,82.140,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 18065, "ab_sfammumain", "shelf_glas", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14832, "lee_stripclub", "Strip_sofa2", 0x00000000);
	tmpobjid = CreateDynamicObject(19367,1282.114,-829.931,82.430,0.000,90.000,0.000,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_blueceiling", 0x00000000);
	tmpobjid = CreateDynamicObject(19367,1283.934,-829.931,80.960,180.000,180.000,0.000,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14815, "whore_main", "WH_tiles2", 0x00000000);
	tmpobjid = CreateDynamicObject(19367,1282.264,-828.411,81.090,270.000,180.000,90.000,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14815, "whore_main", "WH_tiles2", 0x00000000);
	tmpobjid = CreateDynamicObject(19367,1282.264,-831.451,81.090,270.000,180.000,90.000,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14815, "whore_main", "WH_tiles2", 0x00000000);
	tmpobjid = CreateDynamicObject(19367,1280.433,-829.931,80.960,180.000,180.000,0.000,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14815, "whore_main", "WH_tiles2", 0x00000000);
	tmpobjid = CreateDynamicObject(19367,1282.096,-828.409,81.093,270.000,180.000,90.000,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14815, "whore_main", "WH_tiles2", 0x00000000);
	tmpobjid = CreateDynamicObject(19367,1282.096,-831.449,81.095,270.000,180.000,90.000,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14815, "whore_main", "WH_tiles2", 0x00000000);
	tmpobjid = CreateDynamicObject(1453,1282.165,-830.059,82.880,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14815, "whore_main", "WH_tiles2", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 19426, "all_walls", "officewallsnew1", 0x00000000);
	tmpobjid = CreateDynamicObject(1453,1282.165,-830.059,83.950,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14815, "whore_main", "WH_tiles2", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 19426, "all_walls", "officewallsnew1", 0x00000000);
	tmpobjid = CreateDynamicObject(16101,1282.180,-830.069,84.680,0.000,180.000,0.000,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14815, "whore_main", "WH_tiles2", 0x00000000);
	tmpobjid = CreateDynamicObject(1256,1282.184,-831.984,82.750,0.000,0.000,90.000,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 18800, "mroadhelix1", "concretemanky1", 0x00000000);
	tmpobjid = CreateDynamicObject(1823,1272.494,-798.578,87.275,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 18065, "ab_sfammumain", "shelf_glas", 0x00000000);
	tmpobjid = CreateDynamicObject(1823,1284.995,-798.578,87.275,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 18065, "ab_sfammumain", "shelf_glas", 0x00000000);
	tmpobjid = CreateDynamicObject(19922,1263.915,-798.713,87.292,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	tmpobjid = CreateDynamicObject(19359,1312.656,-815.304,76.647,0.000,0.000,-27.399,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 13699, "cunte2_lahills", "laposhfence3", 0x00000000);
	tmpobjid = CreateDynamicObject(19359,1309.863,-820.929,76.647,0.000,0.000,-21.499,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 13699, "cunte2_lahills", "laposhfence3", 0x00000000);
	tmpobjid = CreateDynamicObject(19359,1309.863,-820.929,73.157,0.000,0.000,-21.499,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 13699, "cunte2_lahills", "laposhfence3", 0x00000000);
	tmpobjid = CreateDynamicObject(19359,1311.179,-818.154,76.647,0.000,0.000,-27.399,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 13699, "cunte2_lahills", "laposhfence3", 0x00000000);
	tmpobjid = CreateDynamicObject(19359,1311.179,-818.154,73.167,0.000,0.000,-27.399,-1,-1,-1,120.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 13699, "cunte2_lahills", "laposhfence3", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	tmpobjid = CreateDynamicObject(616,1314.218,-783.550,82.030,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(673,1313.661,-799.841,77.590,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(673,1313.661,-791.091,79.410,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(673,1311.581,-807.851,77.140,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(19824,1274.082,-832.169,82.934,0.000,-20.500,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(19818,1273.756,-832.343,82.870,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(19818,1274.036,-831.783,82.870,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(2010,1269.652,-821.412,82.130,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(2010,1292.693,-821.412,82.130,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(19822,1290.532,-830.226,82.630,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(1510,1290.689,-830.494,82.640,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(19819,1290.368,-830.675,82.710,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(19819,1290.958,-830.325,82.710,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(2010,1294.483,-833.252,82.130,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(2010,1269.073,-833.252,82.130,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(18720,1282.160,-829.983,82.620,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(615,1232.660,-774.142,85.799,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(615,1212.540,-770.872,88.949,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(673,1230.699,-778.604,85.732,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(673,1216.409,-795.304,81.182,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(673,1205.260,-802.714,80.392,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(1481,1261.155,-809.204,88.002,0.000,0.000,148.399,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(1255,1271.406,-798.370,87.865,0.000,0.000,-75.500,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(1255,1274.532,-798.222,87.865,0.000,0.000,-87.300,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(1255,1287.342,-798.949,87.865,0.000,0.000,-105.500,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(1255,1283.828,-799.156,87.865,0.000,0.000,-69.800,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(1598,1285.542,-806.329,86.727,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(1641,1290.671,-808.082,87.325,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(1642,1293.670,-808.283,87.312,0.000,0.000,-23.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(19859,1282.405,-791.675,88.572,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(19859,1285.405,-791.675,88.572,0.000,0.000,180.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(625,1260.115,-811.500,88.112,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(625,1298.476,-810.859,88.112,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(633,1257.929,-800.735,88.292,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(2636,1266.407,-798.860,87.915,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(2636,1264.586,-796.980,87.915,0.000,0.000,90.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(2636,1263.146,-796.980,87.915,0.000,0.000,90.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(2636,1261.526,-798.770,87.915,0.000,0.000,180.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(1670,1264.101,-798.641,88.092,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(19818,1262.722,-798.517,88.162,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(19818,1263.823,-798.247,88.162,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(19818,1265.023,-798.247,88.162,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(19818,1265.313,-799.037,88.162,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(19823,1263.319,-798.942,88.092,0.000,0.000,17.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(3806,1261.062,-812.294,85.060,0.000,0.000,270.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(3806,1267.273,-812.294,85.060,0.000,0.000,270.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(3806,1293.133,-812.294,85.060,0.000,0.000,270.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(647,1303.085,-821.906,76.572,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(647,1312.015,-808.906,78.022,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(2001,1303.742,-802.842,83.130,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(2001,1303.472,-813.302,83.130,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(2001,1300.262,-818.413,83.130,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(615,1208.750,-793.022,82.019,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(615,1200.870,-820.662,78.229,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
	tmpobjid = CreateDynamicObject(615,1202.360,-780.362,87.569,0.000,0.000,0.000,-1,-1,-1,120.000,120.000);
}