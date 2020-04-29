#define CELL_DEFAULT_NUMBER 100
#define CELL_FLOOR_BOTTOM 	1
#define CELL_FLOOR_TOP		2

enum E_CELL_ARRAY_DATA
{
	cellName[15],
	Float:cellSpawnX,
	Float:cellSpawnY,
	Float:cellSpawnZ,
	Float:cellDoorX,
	Float:cellDoorY,
	Float:cellDoorZ,
	Float:cellDoorRX,
	Float:cellDoorRY,
	Float:cellDoorRZ,
	Float:cellPlateX,
	Float:cellPlateY,
	Float:cellPlateZ,
	Float:cellPlateRX,
	Float:cellPlateRY,
	Float:cellPlateRZ,
	cellFloor,
	bool:cellDoorOpened,
	cellDoorObject,
	cellPlateObject
};

new const PrisonCells[][E_CELL_ARRAY_DATA] = 
{
	// apatines
	{"HU-101", 415.0766,1466.4982,1844.0863,   414.40231, 1464.53442, 1844.31091, 0.00000, 0.00000, 0.00000, 	415.56750, 1464.53064, 1845.79858,   0.00000, 0.00000, 0.00000, CELL_FLOOR_BOTTOM},
	{"HU-102", 417.5526,1466.9200,1844.0863,   416.78000, 1464.53442, 1844.31091, 0.00000, 0.00000, 0.00000, 	417.07379, 1464.53064, 1845.79858,   0.00000, 0.00000, 0.00000, CELL_FLOOR_BOTTOM},
	{"HU-103", 422.2077,1461.6948,1844.0863,   420.73560, 1460.62061, 1844.31091, 0.00000, 0.00000, 90.00000, 	420.72690, 1460.95349, 1845.79858,   0.00000, 0.00000, -90.00000, CELL_FLOOR_BOTTOM},
	{"HU-104", 423.0945,1458.7200,1844.0863,   420.73560, 1458.24146, 1844.31091, 0.00000, 0.00000, 90.00000, 	420.72690, 1459.44824, 1845.79858,   0.00000, 0.00000, -90.00000, CELL_FLOOR_BOTTOM},
	{"HU-105", 422.5809,1454.6676,1844.0863,   420.73560, 1453.42664, 1844.31091, 0.00000, 0.00000, 90.00000,	420.72690, 1453.75500, 1845.79858,   0.00000, 0.00000, -90.00000, CELL_FLOOR_BOTTOM},
	{"HU-106", 422.1860,1451.4102,1844.0863,   420.73560, 1451.04846, 1844.31091, 0.00000, 0.00000, 90.00000,	420.72690, 1452.25598, 1845.79858,   0.00000, 0.00000, -90.00000, CELL_FLOOR_BOTTOM},
	{"HU-107", 422.3324,1446.9059,1844.0863,   420.73560, 1446.23450, 1844.31091, 0.00000, 0.00000, 90.00000, 	420.72690, 1446.56604, 1845.79858,   0.00000, 0.00000, -90.00000, CELL_FLOOR_BOTTOM},
	{"HU-108", 422.2580,1444.4579,1844.0863,   420.73560, 1443.85706, 1844.31091, 0.00000, 0.00000, 90.00000, 	420.72690, 1445.06458, 1845.79858,   0.00000, 0.00000, -90.00000, CELL_FLOOR_BOTTOM},
	{"HU-109", 422.6324,1439.7294,1844.0863,   420.73560, 1439.04553, 1844.31091, 0.00000, 0.00000, 90.00000, 	420.72690, 1439.37903, 1845.79858,   0.00000, 0.00000, -90.00000, CELL_FLOOR_BOTTOM},
	{"HU-110", 422.7115,1437.3833,1844.0863,   420.73560, 1436.66699, 1844.31091, 0.00000, 0.00000, 90.00000, 	420.72690, 1437.87451, 1845.79858,   0.00000, 0.00000, -90.00000, CELL_FLOOR_BOTTOM},
	{"HU-111", 417.8156,1432.6361,1844.0863,   416.78000, 1434.20972, 1844.31091, 0.00000, 0.00000, 0.00000, 	417.11179, 1434.21838, 1845.79858,   0.00000, 0.00000, 180.00000, CELL_FLOOR_BOTTOM},
	{"HU-112", 414.8893,1433.1735,1844.0863,   414.40231, 1434.20972, 1844.31091, 0.00000, 0.00000, 0.00000, 	415.61151, 1434.21838, 1845.79858,   0.00000, 0.00000, 180.00000, CELL_FLOOR_BOTTOM},
	{"HU-113", 410.5483,1432.6565,1844.0863,   409.58578, 1434.20972, 1844.31091, 0.00000, 0.00000, 0.00000, 	409.91769, 1434.21838, 1845.79858,   0.00000, 0.00000, 180.00000, CELL_FLOOR_BOTTOM},
	{"HU-114", 407.7510,1432.3228,1844.0863,   407.21030, 1434.20972, 1844.31091, 0.00000, 0.00000, 0.00000, 	408.41931, 1434.21838, 1845.79858,   0.00000, 0.00000, 180.00000, CELL_FLOOR_BOTTOM},
	{"HU-115", 403.1058,1432.2332,1844.0863,   402.39441, 1434.20972, 1844.31091, 0.00000, 0.00000, 0.00000, 	402.72580, 1434.21838, 1845.79858,   0.00000, 0.00000, 180.00000, CELL_FLOOR_BOTTOM},
	{"HU-116", 400.8392,1432.5504,1844.0863,   400.02029, 1434.20972, 1844.31091, 0.00000, 0.00000, 0.00000, 	401.22870, 1434.21838, 1845.79858,   0.00000, 0.00000, 180.00000, CELL_FLOOR_BOTTOM},
	{"HU-117", 395.8774,1432.5298,1844.0863,   395.20520, 1434.20972, 1844.31091, 0.00000, 0.00000, 0.00000, 	395.53381, 1434.21838, 1845.79858,   0.00000, 0.00000, 180.00000, CELL_FLOOR_BOTTOM},
	{"HU-118", 393.2970,1432.6812,1844.0863,   392.83200, 1434.20972, 1844.31091, 0.00000, 0.00000, 0.00000, 	394.03949, 1434.21838, 1845.79858,   0.00000, 0.00000, 180.00000, CELL_FLOOR_BOTTOM},
	{"HU-119", 388.7722,1437.1094,1844.0863,   390.41101, 1436.66699, 1844.31091, 0.00000, 0.00000, 90.00000, 	390.42010, 1437.83655, 1845.79858,   0.00000, 0.00000, 90.00000, CELL_FLOOR_BOTTOM},
	{"HU-120", 388.4416,1440.0070,1844.0863,   390.41101, 1439.04553, 1844.31091, 0.00000, 0.00000, 90.00000,	390.42010, 1439.33899, 1845.79858,   0.00000, 0.00000, 90.00000, CELL_FLOOR_BOTTOM},
	{"HU-201", 414.8512,1465.8267,1847.6753,   414.40231, 1464.53442, 1847.89624, 0.00000, 0.00000, 0.00000,	415.56750, 1464.53064, 1849.38354,   0.00000, 0.00000, 0.00000, CELL_FLOOR_TOP},
	{"HU-202", 417.3202,1466.3015,1847.6753,   416.78000, 1464.53442, 1847.89624, 0.00000, 0.00000, 0.00000, 	417.07379, 1464.53064, 1849.38354,   0.00000, 0.00000, 0.00000, CELL_FLOOR_TOP},
	{"HU-203", 422.6153,1461.6266,1847.6753,   420.73560, 1460.62061, 1847.89624, 0.00000, 0.00000, 90.00000, 	420.72690, 1460.95349, 1849.38354,   0.00000, 0.00000, -90.00000, CELL_FLOOR_TOP},
	{"HU-204", 422.3738,1458.7736,1847.6753,   420.73560, 1458.24146, 1847.89624, 0.00000, 0.00000, 90.00000, 	420.72690, 1459.44824, 1849.38354,   0.00000, 0.00000, -90.00000, CELL_FLOOR_TOP},
	{"HU-205", 422.7255,1454.3802,1847.6753,   420.73560, 1453.42664, 1847.89624, 0.00000, 0.00000, 90.00000, 	420.72690, 1453.75500, 1849.38354,   0.00000, 0.00000, -90.00000, CELL_FLOOR_TOP},
	{"HU-206", 422.4999,1451.8722,1847.6753,   420.73560, 1451.04846, 1847.89624, 0.00000, 0.00000, 90.00000, 	420.72690, 1452.25598, 1849.38354,   0.00000, 0.00000, -90.00000, CELL_FLOOR_TOP},
	{"HU-207", 422.1534,1447.3229,1847.6753,   420.73560, 1446.23450, 1847.89624, 0.00000, 0.00000, 90.00000, 	420.72690, 1446.56604, 1849.38354,   0.00000, 0.00000, -90.00000, CELL_FLOOR_TOP},
	{"HU-208", 422.9740,1444.2010,1847.6753,   420.73560, 1443.85706, 1847.89624, 0.00000, 0.00000, 90.00000, 	420.72690, 1445.06458, 1849.38354,   0.00000, 0.00000, -90.00000, CELL_FLOOR_TOP},
	{"HU-209", 422.6920,1439.8160,1847.6753,   420.73560, 1439.04553, 1847.89624, 0.00000, 0.00000, 90.00000, 	420.72690, 1439.37903, 1849.38354,   0.00000, 0.00000, -90.00000, CELL_FLOOR_TOP},
	{"HU-210", 422.9332,1437.1792,1847.6753,   420.73560, 1436.66699, 1847.89624, 0.00000, 0.00000, 90.00000, 	420.72690, 1437.87451, 1849.38354,   0.00000, 0.00000, -90.00000, CELL_FLOOR_TOP},
	{"HU-211", 417.8388,1432.4163,1847.6753,   416.78000, 1434.20972, 1847.89624, 0.00000, 0.00000, 0.00000, 	417.11179, 1434.21838, 1849.38354,   0.00000, 0.00000, 180.00000, CELL_FLOOR_TOP},
	{"HU-212", 414.7089,1432.9713,1847.6753,   414.40231, 1434.20972, 1847.89624, 0.00000, 0.00000, 0.00000, 	415.61151, 1434.21838, 1849.38354,   0.00000, 0.00000, 180.00000, CELL_FLOOR_TOP},
	{"HU-213", 410.5144,1432.1282,1847.6753,   409.58578, 1434.20972, 1847.89624, 0.00000, 0.00000, 0.00000, 	409.91769, 1434.21838, 1849.38354,   0.00000, 0.00000, 180.00000, CELL_FLOOR_TOP},
	{"HU-214", 407.9324,1432.4597,1847.6753,   407.21030, 1434.20972, 1847.89624, 0.00000, 0.00000, 0.00000, 	408.41931, 1434.21838, 1849.38354,   0.00000, 0.00000, 180.00000, CELL_FLOOR_TOP},
	{"HU-215", 403.3003,1432.3353,1847.6753,   402.39441, 1434.20972, 1847.89624, 0.00000, 0.00000, 0.00000, 	402.72580, 1434.21838, 1849.38354,   0.00000, 0.00000, 180.00000, CELL_FLOOR_TOP},
	{"HU-216", 400.4995,1432.8501,1847.6753,   400.02029, 1434.20972, 1847.89624, 0.00000, 0.00000, 0.00000, 	401.22870, 1434.21838, 1849.38354,   0.00000, 0.00000, 180.00000, CELL_FLOOR_TOP},
	{"HU-217", 396.2876,1432.1959,1847.6753,   395.20520, 1434.20972, 1847.89624, 0.00000, 0.00000, 0.00000, 	395.53381, 1434.21838, 1849.38354,   0.00000, 0.00000, 180.00000, CELL_FLOOR_TOP},
	{"HU-218", 393.6728,1431.9301,1847.6753,   392.83200, 1434.20972, 1847.89624, 0.00000, 0.00000, 0.00000, 	394.03949, 1434.21838, 1849.38354,   0.00000, 0.00000, 180.00000, CELL_FLOOR_TOP},
	{"HU-219", 388.9469,1437.3435,1847.6753,   390.41101, 1436.66699, 1847.89624, 0.00000, 0.00000, 90.00000, 	390.42010, 1437.83655, 1849.38354,   0.00000, 0.00000, 90.00000, CELL_FLOOR_TOP},
	{"HU-220", 388.5820,1439.8441,1847.6753,   390.41101, 1439.04553, 1847.89624, 0.00000, 0.00000, 90.00000, 	390.42010, 1439.33899, 1849.38354,   0.00000, 0.00000, 90.00000, CELL_FLOOR_TOP}
};

enum E_POLICE_DOOR_DATA
{
	policeDoorModel,
	Float:policeDoorDist,
	Float:policeDoorX,
	Float:policeDoorY,
	Float:policeDoorZ,
	Float:policeDoorRX,
	Float:policeDoorRY,
	Float:policeDoorRZ,
	Float:policeDoorCloseX,
	Float:policeDoorCloseY,
	Float:policeDoorCloseZ,
	Float:policeDoorCloseRX,
	Float:policeDoorCloseRY,
	Float:policeDoorCloseRZ,
	Float:policeDoorSD,
	Float:policeDoorVD,
	bool:policeDoorComboNext,
	policeDoorTxt1Index,
	policeDoorTxt1Model,
	policeDoorTxt1Txd[22],
	policeDoorTxt1Txt[22],
	policeDoorTxt2Index,
	policeDoorTxt2Model,
	policeDoorTxt2Txd[22],
	policeDoorTxt2Txt[22],
	bool:policeDoorOpened,
	policeDoorObject
}

new const PoliceDoors[][E_POLICE_DOOR_DATA] = {

	// pd garazas priekinis
	// Object  		DIST C X	 		C Y				C Z			C RX 	C RY 	C RZ  	O X 	 	O Y 			O Z 		O RX  	O RY 	O RZ 	SD 		VD
	{3037, 			7.0, 1397.979,		-1624.395,		9.379, 		0.000,	0.000, 	60.0, 	1397.979, 	-1624.395, 		-15.379,	0.000,	0.0, 	60.0, 	150.0, 	150.0, 	false, 	0, 9514, "711_sfw", "sw_sheddoor2", 0, 0, "", ""},
	{968,			7.0, 1419.287,		-1608.824,		13.345,		0.000,	-90.0,	90.000, 1419.287,	-1608.824,		13.345,		0.000,	0.000,	90.000, 80.0,	80.0,	false, 	0, 0, "", "", 0, 0, "", ""}, // pd slagbaumas priekinis
	{968,			7.0, 1391.743,		-1721.417,		13.345,		0.000,	-90.0,	0.000, 	1391.743,	-1721.417,		13.345,		0.000,	0.000,	0.000, 	80.0, 	80.0,	false, 	0, 0, "", "", 0, 0, "", ""}, // pd slagbaumas galinis
	{3055, 			7.0, 1343.12561,	-1665.39331, 	7.11100,   	0.0000,	0.000, 	0.000, 	1335.1871, 	-1666.0160, 	7.1110,   	0.0000, 0.000, 	0.000, 	90.0, 	90.0, 	false, 	0, 0, "", "", 0, 0, "", ""}, // galiniai garazo vgartai


	{3089, 			3.5, 406.61499, 	1451.79932, 	1844.20264, 0.0, 	0.0, 	45.0, 	406.61499, 	1451.79932, 	1800.20264, 0.0, 	0.0, 	45.0,	150.0, 	150.0, 	false, 1, 5774, "garag3_lawn", "bluestucco1", 2, 5774, "garag3_lawn", "bluestucco1"},
	{1495, 			3.5, 374.06091, 	1421.99329, 	1518.22192, 0.0, 	0.0, 	0.0, 	374.06091, 	1421.99329, 	1500.22192, 0.0, 	0.0, 	0.0, 	150.00, 150.00, false, 0, 0, "", "", 0, 0, "", ""},
	{1495, 			3.5, 369.41989, 	1428.32471, 	1518.22192, 0.0, 	0.0, 	0.0, 	369.41989, 	1428.32471, 	1500.22192, 0.0, 	0.0, 	0.0, 	150.00, 150.00, false, 0, 0, "", "", 0, 0, "", ""},
	{1495, 			3.5, 362.77328, 	1440.34363, 	1518.22192, 0.0, 	0.0, 	90.0, 	362.77328, 	1440.34363, 	1500.22192, 0.0, 	0.0, 	90.0, 	150.00, 150.00,	false, 0, 0, "", "", 0, 0, "", ""},
	{1495, 			3.5, 357.20999, 	1430.73767, 	1518.22192, 0.0, 	0.0, 	90.0, 	357.20999, 	1430.73767, 	1500.22192, 0.0, 	0.0, 	90.0, 	150.00, 150.00,	false, 0, 0, "", "", 0, 0, "", ""},
	{1495, 			3.5, 368.52310, 	1430.73767, 	1518.22192, 0.0, 	0.0, 	90.0, 	368.52310, 	1430.73767, 	1500.22192, 0.0, 	0.0, 	90.0, 	150.00, 150.00,	false, 0, 0, "", "", 0, 0, "", ""},
	{19302, 		3.5, 380.91681, 	1419.81006, 	1519.50854, 0.0, 	0.0, 	90.0,	380.91681, 	1419.81006, 	1500.50854, 0.0, 	0.0, 	90.0, 	150.00,	150.00,	false, 0, 0, "", "", 0, 0, "", ""},
	{3089, 			3.5, 354.82181, 	1428.34070, 	1519.35474, 0.0, 	0.0, 	0.0,	354.82181, 	1428.34070, 	1500.35474, 0.0, 	0.0, 	0.0, 	150.00,	150.00,	false, 1, 1675, "wshxrefhse", "greygreensubuild_128", 	2, 1675, "wshxrefhse", "duskyblue_128"},
	{3089, 			3.5, 368.50711, 	1419.67456, 	1519.35474, 0.0, 	0.0, 	90.0,	368.50711, 	1419.67456, 	1500.35474, 0.0, 	0.0, 	90.0, 	150.00,	150.00,	false, 1, 1675, "wshxrefhse", "greygreensubuild_128", 	2, 1675, "wshxrefhse", "duskyblue_128"},

	{19795, 		5.0, 262.54111, 	1416.14856, 	11.03530, 	0.0, 	0.0, 	180.0,	262.54111, 	1416.14856, 	7.03530, 	0.0, 	0.0, 	180.0, 	200.00, 200.00,	true, 	0, 0, "", "", 0, 0, "", ""},
	{19795, 		5.0, 262.54111, 	1422.63916, 	11.03530, 	0.0, 	0.0, 	0.0,	262.54111, 	1422.63916, 	7.03530, 	0.0, 	0.0, 	0.0, 	200.00, 200.00,	false, 	0, 0, "", "", 0, 0, "", ""},
	{19795, 		5.0, 287.03229, 	1414.86450, 	11.02030, 	0.0, 	0.0, 	0.0,	287.03229, 	1414.86450, 	7.02030, 	0.0, 	0.0, 	0.0, 	200.00, 200.00,	true, 	0, 0, "", "", 0, 0, "", ""},
	{19795, 		5.0, 287.03229, 	1408.36670, 	11.02030, 	0.0, 	0.0, 	180.0,	287.03229, 	1408.36670, 	7.02030, 	0.0, 	0.0, 	180.0, 	200.00, 200.00,	false, 	0, 0, "", "", 0, 0, "", ""},

	{1495, 			4.5, 245.66096, 	72.44231, 		1002.64075, 0.0, 	0.0, 	0.0, 	245.66096, 	72.44231, 		902.64075, 0.0, 	0.0, 	0.0,	50.0, 50.0, 	false, 	0, 0, "", "", 	0, 0, "", ""},
	{19302, 		4.5, 405.00641, 	1449.97314, 	1844.33325, 0.0, 	0.0, 	45.0, 	405.00641, 	1449.97314, 	1820.33325, 0.0, 	0.0, 	45.0,	150.00, 150.00,	false, 	0, 0, "", "", 	0, 0, "", ""},

	// QUEL PD mape
	{1495, 			3.0, 2260.996,	-70.112,		1022.942,	0.0,	0.0,	0.0, 		2260.996,	-70.112,		1010.942,	0.0,	0.0,	0.0,	50.0, 50.0, 	false, 0, 0, "", "", 	0, 0, "", ""},//1, 18027, "cj_barb2", "interiordoor1_256"},
	{1495, 			3.0, 2273.498,	-67.532,		1022.942, 	0.000,	0.000,	0.000, 		2273.498,	-67.532,		1010.942, 	0.000,	0.000,	0.000,	50.0, 50.0, 	false, 0, 0, "", "", 	0, 0, "", ""},//1, 13007, "sw_bankint", "woodfloor1"},
	{1495, 			3.0, 2271.080,	-66.863,		1022.942, 	0.000,	0.000,	90.000,		2271.080,	-66.863,		1010.942, 	0.000,	0.000,	90.0,		50.0, 50.0, 	false, 0, 0, "", "", 	0, 0, "", ""},//1, 18027, "cj_barb2", "interiordoor1_256"},
	{1495, 			3.0, 2273.489,	-45.712,		1024.343, 	0.000,	0.000,	0.000, 		2273.489,	-45.712,		1010.343, 	0.000,	0.000,	0.000,	50.0, 50.0, 	false, 0, 0, "", "", 	0, 0, "", ""},//1, 13007, "sw_bankint", "woodfloor1"},
	{1495, 			3.0, 2271.345,	-45.808,		1024.343, 	0.000,	0.000,	180.000,	2271.345,	-45.808,		1010.343, 	0.000,	0.000,	180.0,	50.0, 50.0, 	false, 0, 0, "", "", 	0, 0, "", ""},//1, 13007, "sw_bankint", "woodfloor1"},

	// Mody PD mape
	{1495, 			3.0, 2005.9344, 2920.8188, 		6007.1201, 	0.0, 	0.0, 	0.0,		2005.9344, 	2920.8188, 		5990.1201, 	0.0, 	0.0, 	0.0, 	50.0, 50.0, 	false, 0, 0, "", "", 	0, 0, "", ""},
	{1495, 			3.0, 2041.2537, 2945.6885, 		6000.1245, 	0.0, 	0.0, 	90.0,		2041.2537, 2945.6885, 		5990.1245, 	0.0, 	0.0, 	0.0, 	50.0, 50.0, 	false, 0, 0, "", "", 	0, 0, "", ""}
};

/*saspHU = CreateDynamicObject(3089, 406.61499, 1451.79932, 1844.20264,   0.00000, 0.00000, 45.00000, -1, -1, -1, 150.00, 150.00);
SetDynamicObjectMaterial(saspHU, 1, 5774, "garag3_lawn", "bluestucco1");
SetDynamicObjectMaterial(saspHU, 2, 5774, "garag3_lawn", "bluestucco1");

saspMBreception = CreateDynamicObject(1495, 374.06091, 1421.99329, 1518.22192,   0.00000, 0.00000, 0.00000, -1, -1, -1, 150.00, 150.00);
saspMBreception = CreateDynamicObject(1495, 369.41989, 1428.32471, 1518.22192,   0.00000, 0.00000, 0.00000, -1, -1, -1, 150.00, 150.00);
saspMBreception = CreateDynamicObject(1495, 362.77328, 1440.34363, 1518.22192,   0.00000, 0.00000, 90.00000, -1, -1, -1, 150.00, 150.00);
saspMBreception = CreateDynamicObject(1495, 357.20999, 1430.73767, 1518.22192,   0.00000, 0.00000, 90.00000, -1, -1, -1, 150.00, 150.00);
saspMBreception = CreateDynamicObject(1495, 368.52310, 1430.73767, 1518.22192,   0.00000, 0.00000, 90.00000, -1, -1, -1, 150.00, 150.00);

saspMBreception = CreateDynamicObject(19302, 380.91681, 1419.81006, 1519.50854,   0.00000, 0.00000, 90.00000, -1, -1, -1, 150.00, 150.00);

saspMBreception = CreateDynamicObject(3089, 354.82181, 1428.34070, 1519.35474,   0.00000, 0.00000, 0.00000, -1, -1, -1, 150.00, 150.00);
SetDynamicObjectMaterial(saspMBreception, 1, 1675, "wshxrefhse", "greygreensubuild_128");
SetDynamicObjectMaterial(saspMBreception, 2, 1675, "wshxrefhse", "duskyblue_128");
saspMBreception = CreateDynamicObject(3089, 368.50711, 1419.67456, 1519.35474,   0.00000, 0.00000, 90.00000, -1, -1, -1, 150.00, 150.00);
SetDynamicObjectMaterial(saspMBreception, 1, 1675, "wshxrefhse", "greygreensubuild_128");
SetDynamicObjectMaterial(saspMBreception, 2, 1675, "wshxrefhse", "duskyblue_128");*/

stock Police_Doors()
{
	new object;
	for(new door = 0; door < sizeof PoliceDoors; door++)
	{
		object = PoliceDoors[door][policeDoorObject] = CreateDynamicObject(PoliceDoors[door][policeDoorModel], 
																	PoliceDoors[door][policeDoorX], PoliceDoors[door][policeDoorY], PoliceDoors[door][policeDoorZ], 
																	PoliceDoors[door][policeDoorRX], PoliceDoors[door][policeDoorRY], PoliceDoors[door][policeDoorRZ],
																	-1, -1, -1,
																	PoliceDoors[door][policeDoorSD], PoliceDoors[door][policeDoorVD]);
		printf("[%d]: (%d) %d, %d, %s, %s", door, PoliceDoors[door][policeDoorModel], PoliceDoors[door][policeDoorTxt1Index], PoliceDoors[door][policeDoorTxt1Model], PoliceDoors[door][policeDoorTxt1Txd], PoliceDoors[door][policeDoorTxt1Txt]);
		if(!(PoliceDoors[door][policeDoorTxt1Index] == 0 && PoliceDoors[door][policeDoorTxt1Model] == 0))
		{
			printf("[%d]: Setting 1txd", door);
			SetDynamicObjectMaterial(object, PoliceDoors[door][policeDoorTxt1Index], PoliceDoors[door][policeDoorTxt1Model], PoliceDoors[door][policeDoorTxt1Txd], PoliceDoors[door][policeDoorTxt1Txt], 0x00000000);
		}
		if(!(PoliceDoors[door][policeDoorTxt2Index] == 0 && PoliceDoors[door][policeDoorTxt2Model] == 0))
		{
			printf("[%d]: Setting 2txd", door);
			SetDynamicObjectMaterial(object, PoliceDoors[door][policeDoorTxt2Index], PoliceDoors[door][policeDoorTxt2Model], PoliceDoors[door][policeDoorTxt2Txd], PoliceDoors[door][policeDoorTxt2Txt], 0x00000000);
		}
	}
}

stock Police_Door_Open(playerid, door)
{
	// atidarom
	PoliceDoors[door][policeDoorOpened] = true;
	MoveDynamicObject(PoliceDoors[door][policeDoorObject], PoliceDoors[door][policeDoorCloseX], PoliceDoors[door][policeDoorCloseY], PoliceDoors[door][policeDoorCloseZ], 5000.0, PoliceDoors[door][policeDoorCloseRX], PoliceDoors[door][policeDoorCloseRY], PoliceDoors[door][policeDoorCloseRZ]);
				
	// atidarom salia, jei yra nustatyta combo
	if(PoliceDoors[door][policeDoorComboNext])
	{
		PoliceDoors[door+1][policeDoorOpened] = true;
		MoveDynamicObject(PoliceDoors[door+1][policeDoorObject], PoliceDoors[door+1][policeDoorCloseX], PoliceDoors[door+1][policeDoorY], PoliceDoors[door+1][policeDoorCloseZ], 5000.0, PoliceDoors[door+1][policeDoorCloseRX], PoliceDoors[door+1][policeDoorCloseRY], PoliceDoors[door+1][policeDoorCloseRZ]);
	}
	else if(door != 0)
	{
		if(PoliceDoors[door-1][policeDoorComboNext])
		{
			PoliceDoors[door-1][policeDoorOpened] = true;
			MoveDynamicObject(PoliceDoors[door-1][policeDoorObject], PoliceDoors[door-1][policeDoorCloseX], PoliceDoors[door-1][policeDoorCloseY], PoliceDoors[door-1][policeDoorCloseZ], 5000.0, PoliceDoors[door-1][policeDoorCloseRX], PoliceDoors[door-1][policeDoorCloseRY], PoliceDoors[door-1][policeDoorCloseRZ]);
		}
	}
	SetTimerEx("ClosePoliceDoor", 5000, false, "d", door);
	GameTextForPlayer(playerid, "~w~DURYS UZSIDARYS~n~~y~AUTOMATISKAI", 3000, 4);
	return 1;
}

stock Prison_Cell_Plates()
{
	for(new cell = 0; cell < sizeof PrisonCells; cell++)
	{	
		PrisonCells[cell][cellPlateObject] = CreateDynamicObject(2660, PrisonCells[cell][cellPlateX], PrisonCells[cell][cellPlateY], PrisonCells[cell][cellPlateZ], PrisonCells[cell][cellPlateRX], PrisonCells[cell][cellPlateRY], PrisonCells[cell][cellPlateRZ], -1, -1, -1, 150.00, 150.00);
		SetDynamicObjectMaterialText(PrisonCells[cell][cellPlateObject], 0, PrisonCells[cell][cellName], 100, "Arial", 60, 1, 0xFFFFFFFF, 0, 1);
	}

}

stock Prison_Cell_Doors()
{
	for(new cell = 0; cell < sizeof PrisonCells; cell++)
	{
		PrisonCells[cell][cellDoorObject] = CreateDynamicObject(19857, PrisonCells[cell][cellDoorX], PrisonCells[cell][cellDoorY], PrisonCells[cell][cellDoorZ], PrisonCells[cell][cellDoorRX], PrisonCells[cell][cellDoorRY], PrisonCells[cell][cellDoorRZ], -1, -1, -1, 150.0, 150.0);
		SetDynamicObjectMaterial(PrisonCells[cell][cellDoorObject], 0, 5774, "garag3_lawn", "bluestucco1", 0xFF72B0DF);
	}
}


stock Cell_Open(cell)
{
	if(cell >= 0 && cell < sizeof PrisonCells)
	{
		MoveDynamicObject(PrisonCells[cell][cellDoorObject], PrisonCells[cell][cellDoorX], PrisonCells[cell][cellDoorY], (PrisonCells[cell][cellFloor] == CELL_FLOOR_TOP ? PrisonCells[cell][cellDoorZ] + 5.0 : PrisonCells[cell][cellDoorZ] - 5.0), 5000.0);
		PrisonCells[cell][cellDoorOpened] = true;
		return true;
	}
	return false;
}

stock Cell_Close(cell)
{
	if(cell >= 0 && cell < sizeof PrisonCells)
	{
		MoveDynamicObject(PrisonCells[cell][cellDoorObject], PrisonCells[cell][cellDoorX], PrisonCells[cell][cellDoorY], PrisonCells[cell][cellDoorZ], 5000.0);
		PrisonCells[cell][cellDoorOpened] = false;
		return true;
	}
	return false;
}