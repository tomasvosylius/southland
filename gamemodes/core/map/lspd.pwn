#include <YSI\y_hooks>

hook OnGameModeInit()
{
	new tmpobjid;

	// uztaisymas tuneliu
	tmpobjid = CreateDynamicObject(19377, 1580.54199, -1756.60144, 6.63979,   0.00000, 0.00000, 0.48000, -1, -1, -1, 100.0, 100.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 3673, "xrf_refineryla", "steel256128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19377, 1580.51587, -1747.82666, 6.63979,   0.00000, 0.00000, -0.66000, -1, -1, -1, 100.0, 100.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 3673, "xrf_refineryla", "steel256128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19377, 1365.39563, -1592.27661, 7.04448,   0.00000, 0.00000, 79.49998, -1, -1, -1, 100.0, 100.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 3673, "xrf_refineryla", "steel256128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19377, 1356.01941, -1590.47400, 7.04448,   0.00000, 0.00000, 79.49998, -1, -1, -1, 100.0, 100.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 3673, "xrf_refineryla", "steel256128", 0xFFFFFFFF);


	// main building desinej
	tmpobjid = CreateObject(7009,1378.513,-1632.846,26.456,0.000,0.000,90.000,300.0);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);

	// main building kairej
	tmpobjid = CreateObject(7184,1351.090,-1708.381,14.607,0.000,0.000,-180.000,300.0);
	
	// parking
	tmpobjid = CreateObject(7244,1379.017,-1690.834,3.388,0.000,0.000,90.000,300.0);

	// ivaziavimas i pozemini
	tmpobjid = CreateObject(7010,1409.911,-1616.010,14.102,0.000,0.000,90.000,300.0);
	SetObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);

	tmpobjid = CreateObject(19378, 1414.38245, -1649.47327, 12.45360,   0.00000, 90.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0xFFFFFFFF);
	tmpobjid = CreateObject(19378, 1414.38745, -1659.07495, 12.45360,   0.00000, 90.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0xFFFFFFFF);
	tmpobjid = CreateObject(19378, 1414.50085, -1668.66882, 12.45360,   0.00000, 90.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0xFFFFFFFF);
	tmpobjid = CreateObject(19378, 1414.50757, -1678.28479, 12.45360,   0.00000, 90.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0xFFFFFFFF);
	tmpobjid = CreateObject(19378, 1414.35266, -1687.92212, 12.45360,   0.00000, 90.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0xFFFFFFFF);
	tmpobjid = CreateObject(19378, 1414.98438, -1697.51465, 12.45360,   0.00000, 90.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0xFFFFFFFF);
	tmpobjid = CreateObject(19378, 1415.93311, -1707.86511, 12.45360,   0.00000, 90.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0xFFFFFFFF);
	tmpobjid = CreateObject(19378, 1416.58997, -1717.47498, 12.45360,   0.00000, 90.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0xFFFFFFFF);
	tmpobjid = CreateObject(19378, 1415.22668, -1700.16467, 12.44960,   0.00000, 90.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0xFFFFFFFF);
	tmpobjid = CreateObject(19378, 1354.77588, -1709.39709, 12.46690,   0.00000, 90.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0xFFFFFFFF);
	tmpobjid = CreateObject(19378, 1403.88843, -1654.32935, 12.45360,   0.00000, 90.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0xFFFFFFFF);
	tmpobjid = CreateObject(19378, 1403.89038, -1644.70081, 12.45360,   0.00000, 90.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0xFFFFFFFF);
	tmpobjid = CreateObject(19378, 1397.17883, -1635.84204, 12.44960,   0.00000, 90.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0xFFFFFFFF);
	tmpobjid = CreateObject(19378, 1386.67786, -1635.85413, 12.44960,   0.00000, 90.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0xFFFFFFFF);
	tmpobjid = CreateObject(19378, 1376.18628, -1635.86780, 12.44960,   0.00000, 90.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0xFFFFFFFF);
	tmpobjid = CreateObject(19378, 1393.40112, -1644.71765, 12.45360,   0.00000, 90.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0xFFFFFFFF);
	tmpobjid = CreateObject(19378, 1382.92737, -1644.71191, 12.45360,   0.00000, 90.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0xFFFFFFFF);
	tmpobjid = CreateObject(19378, 1393.40320, -1654.33765, 12.45360,   0.00000, 90.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0xFFFFFFFF);
	tmpobjid = CreateObject(19378, 1382.90198, -1654.33301, 12.45360,   0.00000, 90.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0xFFFFFFFF);
	
	// smulkesnis pagrindas is plytu
	tmpobjid = CreateObject(19862, 1421.43201, -1606.77600, 12.51700,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1417.08801, -1604.30505, 12.51900,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1411.79004, -1604.30505, 12.51700,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1406.56702, -1604.30505, 12.51900,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1401.32104, -1604.30505, 12.51700,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1396.06494, -1604.30505, 12.51900,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1390.76404, -1604.30505, 12.51700,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1385.46497, -1604.30505, 12.51900,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1380.24500, -1604.30505, 12.51700,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1374.94800, -1604.30505, 12.51900,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1369.64795, -1604.30505, 12.51700,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1364.39294, -1604.30505, 12.51900,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1359.59399, -1604.30505, 12.51700,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1380.24500, -1606.79504, 12.51700,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1374.94800, -1606.79504, 12.51900,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1369.64795, -1606.79504, 12.51700,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1364.39294, -1606.79504, 12.51900,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1359.59399, -1601.81104, 12.51700,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1359.59399, -1599.31604, 12.51700,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1359.59399, -1596.82300, 12.51700,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1359.59399, -1594.33398, 12.51700,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1359.59399, -1591.83997, 12.51700,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1364.39294, -1601.81104, 12.51900,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1364.39600, -1599.33606, 12.51900,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1364.39600, -1596.84497, 12.51900,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1364.39600, -1594.34998, 12.51900,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1369.64795, -1601.81104, 12.51700,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1369.64795, -1599.33606, 12.51700,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1369.64795, -1596.84497, 12.51700,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1369.64795, -1594.35400, 12.51700,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1374.94800, -1601.81104, 12.51900,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1369.64795, -1601.81104, 12.51700,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1374.94800, -1599.33606, 12.51900,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1374.94800, -1596.84497, 12.51900,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1380.24500, -1601.81104, 12.51700,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1380.24500, -1599.33606, 12.51700,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1380.24500, -1596.84497, 12.51700,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1385.46497, -1601.81104, 12.51900,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1385.46497, -1599.33606, 12.51900,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1390.76404, -1601.81104, 12.51700,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1390.76404, -1599.33606, 12.51700,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1396.06494, -1601.81104, 12.51900,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1401.32104, -1601.81104, 12.51700,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1403.29504, -1638.54297, 12.50900,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1398.00403, -1636.08301, 12.51900,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1392.70605, -1636.08301, 12.51900,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1387.40198, -1636.08301, 12.51900,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 11382.09961, -1645.88599, 12.51900,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);
	tmpobjid = CreateObject(19862, 1382.09998, -1636.08301, 12.51900,   90.00000, 0.00000, 0.0, 220.00000);
	SetObjectMaterial(tmpobjid, 0, 17508, "barrio1_lae2", "brickred", 0x00000000);

	tmpobjid = CreateDynamicObject(19862,1421.432,-1618.331,12.519,90.000,0.000,0.000,-1,-1,-1,100.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	tmpobjid = CreateDynamicObject(19862,1421.432,-1615.882,12.517,90.000,0.000,0.000,-1,-1,-1,100.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	tmpobjid = CreateDynamicObject(19862,1421.432,-1613.419,12.519,90.000,0.000,0.000,-1,-1,-1,100.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	tmpobjid = CreateDynamicObject(19862,1421.432,-1610.990,12.517,90.000,0.000,0.000,-1,-1,-1,100.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	tmpobjid = CreateDynamicObject(19862,1421.432,-1608.998,12.519,90.000,0.000,0.000,-1,-1,-1,100.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);

	// Pilki uz pastato pagrindai
	tmpobjid = CreateObject(8661,1383.473,-1704.260,12.528,0.000,0.000,0.000,250.0);
	SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
	tmpobjid = CreateObject(8661,1383.473,-1684.320,12.528,0.000,0.000,0.000,250.0);
	SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
	tmpobjid = CreateObject(8661,1383.473,-1671.751,12.528,0.000,0.000,0.000,250.0);
	SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
	tmpobjid = CreateObject(8661,1370.218,-1682.130,12.528,0.000,0.000,90.000,250.0);
	SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
	tmpobjid = CreateObject(8661,1368.355,-1694.260,12.528,0.000,0.000,90.000,250.0);
	SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
	tmpobjid = CreateObject(8661,1428.255,-1618.578,12.372,0.000,0.000,90.000,250.0);
	SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);

	// pagrindas prie darbuotoju masinu
	tmpobjid = CreateObject(16773,1407.273,-1719.572,12.427,90.000,0.000,90.000,250.0);
	SetObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	tmpobjid = CreateObject(16773,1399.275,-1719.572,12.425,90.000,0.000,90.000,250.0);
	SetObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	tmpobjid = CreateObject(16773,1391.363,-1719.572,12.427,90.000,0.000,90.000,250.0);
	SetObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	tmpobjid = CreateObject(16773,1383.413,-1719.572,12.425,90.000,0.000,90.000,250.0);
	SetObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	tmpobjid = CreateObject(16773,1375.495,-1719.572,12.427,90.000,0.000,90.000,250.0);
	SetObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	tmpobjid = CreateObject(16773,1367.557,-1719.552,12.425,90.000,0.000,90.000,250.0);
	SetObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	tmpobjid = CreateObject(16773,1359.575,-1719.572,12.427,90.000,0.000,90.000,250.0);
	SetObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	tmpobjid = CreateObject(16773,1351.654,-1718.161,12.425,90.000,0.000,90.000,250.0);
	SetObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	tmpobjid = CreateObject(16773,1343.725,-1718.161,12.427,90.000,0.000,90.000,250.0);
	SetObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	tmpobjid = CreateObject(16773,1343.251,-1718.161,12.425,90.000,0.000,90.000,250.0);
	SetObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);

	tmpobjid = CreateDynamicObject(8661,1329.224,-1702.614,12.542,0.000,0.000,90.000,-1,-1,-1,100.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
	tmpobjid = CreateDynamicObject(8661,1329.224,-1662.671,12.540,0.000,0.000,90.000,-1,-1,-1,100.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
	tmpobjid = CreateDynamicObject(8661,1329.224,-1627.750,12.542,0.000,0.000,90.000,-1,-1,-1,100.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
	tmpobjid = CreateDynamicObject(8661,1347.038,-1606.799,12.426,0.000,0.000,90.000,-1,-1,-1,100.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
	tmpobjid = CreateDynamicObject(8661,1331.584,-1602.323,12.424,0.000,0.000,90.000,-1,-1,-1,100.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
	tmpobjid = CreateDynamicObject(9339,1335.938,-1722.208,12.680,0.000,0.000,90.000,-1,-1,-1,100.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "ab_blind", 0x00000000);
	tmpobjid = CreateDynamicObject(9339,1323.000,-1709.291,12.678,0.000,0.000,0.000,-1,-1,-1,100.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "ab_blind", 0x00000000);
	tmpobjid = CreateDynamicObject(9339,1323.000,-1683.168,12.678,0.000,0.000,0.000,-1,-1,-1,100.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "ab_blind", 0x00000000);
	tmpobjid = CreateDynamicObject(9339,1322.998,-1657.066,12.675,0.000,0.000,0.000,-1,-1,-1,100.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "ab_blind", 0x00000000);
	tmpobjid = CreateDynamicObject(9339,1322.996,-1631.003,12.673,0.000,0.000,0.000,-1,-1,-1,100.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "ab_blind", 0x00000000);
	tmpobjid = CreateDynamicObject(9339,1322.769,-1604.922,12.671,0.000,0.000,1.000,-1,-1,-1,100.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "ab_blind", 0x00000000);
	tmpobjid = CreateDynamicObject(9339,1322.601,-1595.257,12.670,0.000,0.000,1.000,-1,-1,-1,100.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "ab_blind", 0x00000000);
	tmpobjid = CreateDynamicObject(9339,1334.974,-1585.102,12.670,0.000,0.000,77.000,-1,-1,-1,100.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "ab_blind", 0x00000000);
	tmpobjid = CreateDynamicObject(9339,1344.430,-1587.270,12.670,0.000,0.000,77.000,-1,-1,-1,100.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "ab_blind", 0x00000000);
	tmpobjid = CreateDynamicObject(9339,1357.111,-1603.157,12.673,0.000,0.000,0.000,-1,-1,-1,100.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "ab_blind", 0x00000000);
	tmpobjid = CreateDynamicObject(19864,1357.049,-1605.558,12.816,71.000,0.000,90.000,-1,-1,-1,100.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
	tmpobjid = CreateDynamicObject(19864,1357.049,-1600.340,12.814,71.000,0.000,90.000,-1,-1,-1,100.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
	tmpobjid = CreateDynamicObject(19864,1357.049,-1595.134,12.816,71.000,0.000,90.000,-1,-1,-1,100.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
	tmpobjid = CreateDynamicObject(19864,1357.049,-1592.901,12.814,71.000,0.000,90.000,-1,-1,-1,100.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
	tmpobjid = CreateDynamicObject(19864,1354.419,-1589.627,12.814,71.000,0.000,167.000,-1,-1,-1,100.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
	tmpobjid = CreateDynamicObject(19864,1349.264,-1588.449,12.814,71.000,0.000,167.000,-1,-1,-1,100.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
	tmpobjid = CreateDynamicObject(19864,1344.116,-1587.246,12.814,71.000,0.000,167.000,-1,-1,-1,100.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
	tmpobjid = CreateDynamicObject(19864,1338.970,-1586.061,12.814,71.000,0.000,167.000,-1,-1,-1,100.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
	tmpobjid = CreateDynamicObject(19864,1333.823,-1584.871,12.814,71.000,0.000,167.000,-1,-1,-1,100.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
	tmpobjid = CreateDynamicObject(19864,1328.737,-1583.717,12.814,71.000,0.000,167.000,-1,-1,-1,100.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
	tmpobjid = CreateDynamicObject(19864,1325.091,-1582.862,12.814,71.000,0.000,167.000,-1,-1,-1,100.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
	
	// garazas is priekio
	// sita naudot atidarymui:
	//tmpobjid = CreateDynamicObject(3037,1397.979,-1624.395,9.379,0.000,0.000,60.000,-1,-1,-1,50.0);
	//SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "sw_sheddoor2", 0x00000000);

	tmpobjid = CreateDynamicObject(3037,1397.979,-1624.395,13.783,0.000,0.000,60.000,-1,-1,-1,50.0);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "sw_sheddoor2", 0x00000000);

	// langai
	tmpobjid = CreateDynamicObject(7333,1384.577,-1659.296,34.116,0.000,0.000,180.000,-1,-1,-1,250.0);
	
	// veliavos
	tmpobjid = CreateDynamicObject(4003,1383.718,-1620.086,30.047,0.000,0.000,-90.000,-1,-1,-1,170.0); 
	tmpobjid = CreateDynamicObject(7092,1397.774,-1714.316,27.497,0.000,0.000,90.000,-1,-1,-1,170.0);

	tmpobjid = CreateDynamicObject(10250,1372.605,-1620.326,52.372,0.000,0.000,90.000,-1,-1,-1,100.0); // bokstas
	tmpobjid = CreateDynamicObject(966,1419.247,-1608.969,12.498,0.000,0.000,90.000,-1,-1,-1,30.0); // slagbaumo laikiklis

	// konteineriai
	tmpobjid = CreateDynamicObject(1372,1409.793,-1714.752,12.653,0.000,0.000,0.000,-1,-1,-1,30.0);
	tmpobjid = CreateDynamicObject(1372,1407.772,-1714.752,12.653,0.000,0.000,0.000,-1,-1,-1,30.0);
	
	// speedbump
	tmpobjid = CreateDynamicObject(19425,1347.732,-1711.294,12.525,0.000,0.000,0.000,-1,-1,-1,30.0);
	tmpobjid = CreateDynamicObject(19425,1344.470,-1711.294,12.523,0.000,0.000,0.000,-1,-1,-1,30.0);
	tmpobjid = CreateDynamicObject(19425,1341.174,-1711.294,12.525,0.000,0.000,0.000,-1,-1,-1,30.0);

	// sviestuvai
	tmpobjid = CreateDynamicObject(1226,1425.104,-1689.988,16.405,0.000,0.000,180.000,-1,-1,-1,90.0);
	tmpobjid = CreateDynamicObject(1226,1425.104,-1666.290,16.405,0.000,0.000,180.000,-1,-1,-1,90.0);
	tmpobjid = CreateDynamicObject(1226,1425.104,-1626.786,16.405,0.000,0.000,180.000,-1,-1,-1,90.0);

	// tvoros isdauziamos
	tmpobjid = CreateDynamicObject(1412,1366.306,-1714.191,13.750,0.000,0.000,0.000,-1,-1,-1,55.0);
	tmpobjid = CreateDynamicObject(1412,1380.616,-1714.191,13.750,0.000,0.000,0.000,-1,-1,-1,55.0);
	tmpobjid = CreateDynamicObject(1412,1361.037,-1714.191,13.750,0.000,0.000,0.000,-1,-1,-1,55.0);
	tmpobjid = CreateDynamicObject(1412,1397.434,-1714.191,13.750,0.000,0.000,0.000,-1,-1,-1,55.0);
	tmpobjid = CreateDynamicObject(1412,1383.956,-1714.193,13.750,0.000,0.000,0.000,-1,-1,-1,55.0);
	tmpobjid = CreateDynamicObject(1412,1402.717,-1714.191,13.750,0.000,0.000,0.000,-1,-1,-1,55.0);

	// suoliukai
	tmpobjid = CreateDynamicObject(1256,1387.824,-1656.930,13.184,0.000,0.000,-90.000,-1,-1,-1,100.0);
	tmpobjid = CreateDynamicObject(1256,1393.243,-1656.930,13.184,0.000,0.000,-90.000,-1,-1,-1,100.0);
	tmpobjid = CreateDynamicObject(1256,1407.356,-1657.858,13.184,0.000,0.000,-90.000,-1,-1,-1,100.0);
	tmpobjid = CreateDynamicObject(1256,1400.845,-1657.858,13.184,0.000,0.000,-90.000,-1,-1,-1,100.0);
	tmpobjid = CreateDynamicObject(1256,1408.658,-1647.317,13.184,0.000,0.000,57.000,-1,-1,-1,100.0);
	tmpobjid = CreateDynamicObject(1256,1404.301,-1643.277,13.184,0.000,0.000,41.000,-1,-1,-1,100.0);
	tmpobjid = CreateDynamicObject(1256,1400.708,-1638.520,13.184,0.000,0.000,34.000,-1,-1,-1,100.0);
	tmpobjid = CreateDynamicObject(1256,1417.428,-1684.102,13.184,0.000,0.000,180.000,-1,-1,-1,100.0);
	tmpobjid = CreateDynamicObject(1256,1417.428,-1676.750,13.184,0.000,0.000,180.000,-1,-1,-1,100.0);
	// durys
	tmpobjid = CreateDynamicObject(1533,1409.201,-1673.372,12.518,0.000,0.000,90.000,-1,-1,-1,80.0);
	tmpobjid = CreateDynamicObject(1533,1354.944,-1710.799,12.723,0.000,0.000,0.000,-1,-1,-1,80.0);
	tmpobjid = CreateDynamicObject(1533,1356.456,-1710.805,13.093,0.000,0.000,180.000,-1,-1,-1,80.0);
	tmpobjid = CreateDynamicObject(1533,1347.588,-1665.731,4.933,0.000,0.000,0.000,-1,-1,-1,80.0);
	tmpobjid = CreateDynamicObject(1533,1349.076,-1665.747,7.400,0.000,0.000,180.000,-1,-1,-1,80.0);
	tmpobjid = CreateDynamicObject(1533,1384.248,-1674.012,40.378,0.000,0.000,-90.000,-1,-1,-1,80.0);
	// heli
	tmpobjid = CreateDynamicObject(3934,1369.097,-1669.760,40.380,0.000,0.000,0.000,-1,-1,-1,150.0);
	tmpobjid = CreateDynamicObject(3934,1369.097,-1691.773,40.380,0.000,0.000,0.000,-1,-1,-1,150.0);
	// siukslines
	tmpobjid = CreateDynamicObject(1359,1417.428,-1680.503,13.199,0.000,0.000,0.000,-1,-1,-1,80.0);
	tmpobjid = CreateDynamicObject(1359,1404.175,-1657.858,13.199,0.000,0.000,0.000,-1,-1,-1,80.0);
	tmpobjid = CreateDynamicObject(1359,1390.490,-1656.930,13.199,0.000,0.000,0.000,-1,-1,-1,80.0);
	tmpobjid = CreateDynamicObject(1359,1399.590,-1636.739,13.199,0.000,0.000,0.000,-1,-1,-1,80.0);
	tmpobjid = CreateDynamicObject(1359,1349.915,-1711.369,13.199,0.000,0.000,0.000,-1,-1,-1,80.0);
 	// payphones
 	tmpobjid = CreateDynamicObject(1216,1419.853,-1660.266,13.212,0.000,0.000,90.000,-1,-1,-1,90.0);
	tmpobjid = CreateDynamicObject(1216,1419.853,-1660.866,13.212,0.000,0.000,90.000,-1,-1,-1,90.0);
	tmpobjid = CreateDynamicObject(1216,1419.853,-1661.468,13.212,0.000,0.000,90.000,-1,-1,-1,90.0);
	tmpobjid = CreateDynamicObject(1216,1419.853,-1662.088,13.212,0.000,0.000,90.000,-1,-1,-1,90.0);
	tmpobjid = CreateDynamicObject(1216,1419.853,-1662.708,13.212,0.000,0.000,90.000,-1,-1,-1,90.0);
	tmpobjid = CreateDynamicObject(1216,1384.161,-1675.921,41.058,0.000,0.000,-90.000,-1,-1,-1,90.0);
	// cctv
	tmpobjid = CreateDynamicObject(1622,1383.234,-1714.671,18.481,0.000,0.000,90.000,-1,-1,-1,150.0);
	tmpobjid = CreateDynamicObject(1622,1411.531,-1659.360,19.945,0.000,0.000,180.000,-1,-1,-1,150.0);
	tmpobjid = CreateDynamicObject(1622,1412.690,-1680.442,19.945,0.000,0.000,180.000,-1,-1,-1,150.0);
	tmpobjid = CreateDynamicObject(1622,1383.665,-1634.935,19.945,0.000,0.000,180.000,-1,-1,-1,150.0);
	tmpobjid = CreateDynamicObject(1622,1383.844,-1666.324,46.259,0.000,0.000,0.000,-1,-1,-1,150.0);
	// slagbaumai
	// tmpobjid = CreateDynamicObject(968,1391.743,-1721.417,13.345,0.000,-90.000,0.000,-1,-1,-1,45.0); galinis
	// tmpobjid = CreateDynamicObject(968,1419.287,-1608.824,13.345,0.000,-90.000,90.000,-1,-1,-1,45.0); priekis
	// paprasti medziai
	tmpobjid = CreateDynamicObject(700,1413.690,-1635.365,13.274,0.000,0.000,0.000,-1,-1,-1,130.0);
	tmpobjid = CreateDynamicObject(700,1415.275,-1642.502,12.958,0.000,0.000,0.000,-1,-1,-1,130.0);
	// didesnes palmes
	tmpobjid = CreateDynamicObject(620,1418.036,-1691.099,13.035,0.000,0.000,0.000,-1,-1,-1,130.0);
	tmpobjid = CreateDynamicObject(620,1418.036,-1717.867,13.035,0.000,0.000,0.000,-1,-1,-1,130.0);
	tmpobjid = CreateDynamicObject(620,1418.036,-1709.623,13.035,0.000,0.000,0.000,-1,-1,-1,130.0);
	tmpobjid = CreateDynamicObject(620,1418.036,-1700.435,13.035,0.000,0.000,0.000,-1,-1,-1,130.0);
	tmpobjid = CreateDynamicObject(620,1413.508,-1645.622,13.035,0.000,0.000,0.000,-1,-1,-1,130.0);
	tmpobjid = CreateDynamicObject(620,1402.596,-1629.288,13.035,0.000,0.000,0.000,-1,-1,-1,130.0);
	tmpobjid = CreateDynamicObject(620,1388.942,-1606.591,13.035,0.000,0.000,0.000,-1,-1,-1,130.0);
	tmpobjid = CreateDynamicObject(620,1416.828,-1633.334,12.779,0.000,0.000,0.000,-1,-1,-1,130.0);
	tmpobjid = CreateDynamicObject(620,1409.283,-1606.100,13.449,0.000,0.000,0.000,-1,-1,-1,130.0);
	tmpobjid = CreateDynamicObject(620,1327.648,-1718.882,12.531,0.000,0.000,0.000,-1,-1,-1,130.0);
	tmpobjid = CreateDynamicObject(620,1336.275,-1698.952,12.531,0.000,0.000,0.000,-1,-1,-1,130.0);
	tmpobjid = CreateDynamicObject(620,1330.839,-1679.887,12.531,0.000,0.000,0.000,-1,-1,-1,130.0);
	tmpobjid = CreateDynamicObject(620,1335.836,-1643.773,12.531,0.000,0.000,0.000,-1,-1,-1,130.0);
	tmpobjid = CreateDynamicObject(620,1326.573,-1614.114,12.531,0.000,0.000,0.000,-1,-1,-1,130.0);
	tmpobjid = CreateDynamicObject(620,1346.883,-1605.418,12.531,0.000,0.000,0.000,-1,-1,-1,130.0);
	tmpobjid = CreateDynamicObject(620,1331.197,-1592.548,12.531,0.000,0.000,0.000,-1,-1,-1,130.0);
	// mazesnes palmes
	tmpobjid = CreateDynamicObject(652,1408.121,-1640.241,14.630,0.000,0.000,0.000,-1,-1,-1,130.0);
	tmpobjid = CreateDynamicObject(652,1406.569,-1634.192,14.630,0.000,0.000,-18.000,-1,-1,-1,130.0);
	tmpobjid = CreateDynamicObject(652,1395.657,-1625.693,14.630,0.000,0.000,-18.000,-1,-1,-1,130.0);
	tmpobjid = CreateDynamicObject(652,1400.061,-1631.967,14.630,0.000,0.000,-18.000,-1,-1,-1,130.0);
	tmpobjid = CreateDynamicObject(652,1399.572,-1610.430,14.630,0.000,0.000,-18.000,-1,-1,-1,130.0);
	tmpobjid = CreateDynamicObject(652,1392.883,-1607.927,14.630,0.000,0.000,-18.000,-1,-1,-1,130.0);
	tmpobjid = CreateDynamicObject(652,1416.570,-1627.059,12.592,0.000,0.000,0.000,-1,-1,-1,130.0);
	tmpobjid = CreateDynamicObject(652,1337.195,-1602.087,12.525,0.000,0.000,0.000,-1,-1,-1,130.0);
	tmpobjid = CreateDynamicObject(652,1324.444,-1597.008,12.525,0.000,0.000,0.000,-1,-1,-1,130.0);
	tmpobjid = CreateDynamicObject(652,1334.658,-1625.463,12.525,0.000,0.000,0.000,-1,-1,-1,130.0);
	tmpobjid = CreateDynamicObject(652,1325.777,-1634.992,12.525,0.000,0.000,0.000,-1,-1,-1,130.0);
	tmpobjid = CreateDynamicObject(652,1332.744,-1655.030,12.525,0.000,0.000,0.000,-1,-1,-1,130.0);
	tmpobjid = CreateDynamicObject(652,1325.137,-1673.887,12.525,0.000,0.000,0.000,-1,-1,-1,130.0);
	tmpobjid = CreateDynamicObject(652,1328.597,-1690.173,12.525,0.000,0.000,0.000,-1,-1,-1,130.0);
	tmpobjid = CreateDynamicObject(652,1332.782,-1713.641,12.525,0.000,0.000,0.000,-1,-1,-1,130.0);
	// krumai
	tmpobjid = CreateDynamicObject(647,1417.645,-1693.930,14.346,0.000,0.000,58.000,-1,-1,-1,130.000);
	tmpobjid = CreateDynamicObject(647,1417.336,-1698.093,14.346,0.000,0.000,58.000,-1,-1,-1,130.000);
	tmpobjid = CreateDynamicObject(647,1417.551,-1703.079,14.346,0.000,0.000,58.000,-1,-1,-1,130.000);
	tmpobjid = CreateDynamicObject(647,1417.435,-1707.098,14.346,0.000,0.000,58.000,-1,-1,-1,130.000);
	tmpobjid = CreateDynamicObject(647,1417.463,-1712.107,14.346,0.000,0.000,58.000,-1,-1,-1,130.000);
	tmpobjid = CreateDynamicObject(647,1417.094,-1715.236,14.346,0.000,0.000,58.000,-1,-1,-1,130.000);
	tmpobjid = CreateDynamicObject(647,1414.908,-1638.861,14.205,0.000,0.000,0.000,-1,-1,-1,130.000);
	tmpobjid = CreateDynamicObject(647,1413.484,-1630.116,14.416,0.000,0.000,0.000,-1,-1,-1,130.000);
	tmpobjid = CreateDynamicObject(647,1407.307,-1626.540,17.071,0.000,0.000,0.000,-1,-1,-1,130.000);
	tmpobjid = CreateDynamicObject(647,1408.075,-1635.697,16.028,0.000,0.000,0.000,-1,-1,-1,130.000);
	tmpobjid = CreateDynamicObject(647,1395.957,-1625.501,18.825,0.000,0.000,0.000,-1,-1,-1,130.000);
	tmpobjid = CreateDynamicObject(647,1400.528,-1630.713,19.087,0.000,0.000,0.000,-1,-1,-1,130.000);
	tmpobjid = CreateDynamicObject(647,1399.109,-1627.415,18.696,0.000,0.000,0.000,-1,-1,-1,130.000);
	tmpobjid = CreateDynamicObject(647,1401.885,-1634.516,18.697,0.000,0.000,0.000,-1,-1,-1,130.000);
	tmpobjid = CreateDynamicObject(647,1416.465,-1646.288,14.034,0.000,0.000,0.000,-1,-1,-1,130.000);
	tmpobjid = CreateDynamicObject(647,1415.260,-1623.033,14.250,0.000,0.000,0.000,-1,-1,-1,130.000);
	tmpobjid = CreateDynamicObject(647,1407.397,-1641.998,16.368,0.000,0.000,0.000,-1,-1,-1,130.000);
	tmpobjid = CreateDynamicObject(647,1403.078,-1607.610,16.002,0.000,0.000,0.000,-1,-1,-1,130.000);
	tmpobjid = CreateDynamicObject(647,1397.915,-1608.165,16.894,0.000,0.000,0.000,-1,-1,-1,130.000);
	tmpobjid = CreateDynamicObject(647,1394.796,-1612.991,16.712,0.000,0.000,0.000,-1,-1,-1,130.000);
	tmpobjid = CreateDynamicObject(647,1393.846,-1607.305,18.124,0.000,0.000,0.000,-1,-1,-1,130.000);
	tmpobjid = CreateDynamicObject(647,1389.718,-1606.412,19.089,0.000,0.000,126.000,-1,-1,-1,130.000);
	tmpobjid = CreateDynamicObject(647,1326.607,-1711.895,12.535,0.000,0.000,0.000,-1,-1,-1,130.000);
	tmpobjid = CreateDynamicObject(647,1333.922,-1704.555,12.535,0.000,0.000,0.000,-1,-1,-1,130.000);
	tmpobjid = CreateDynamicObject(647,1327.597,-1695.564,12.535,0.000,0.000,0.000,-1,-1,-1,130.000);
	tmpobjid = CreateDynamicObject(647,1334.159,-1684.005,12.535,0.000,0.000,0.000,-1,-1,-1,130.000);
	tmpobjid = CreateDynamicObject(647,1328.012,-1660.729,12.535,0.000,0.000,0.000,-1,-1,-1,130.000);
	tmpobjid = CreateDynamicObject(647,1332.305,-1644.384,12.535,0.000,0.000,0.000,-1,-1,-1,130.000);
	tmpobjid = CreateDynamicObject(647,1326.259,-1622.163,12.535,0.000,0.000,0.000,-1,-1,-1,130.000);
	tmpobjid = CreateDynamicObject(647,1348.270,-1599.593,12.535,0.000,0.000,0.000,-1,-1,-1,130.000);
	tmpobjid = CreateDynamicObject(647,1340.696,-1591.223,12.535,0.000,0.000,0.000,-1,-1,-1,130.000);
	tmpobjid = CreateDynamicObject(647,1325.765,-1603.115,12.535,0.000,0.000,0.000,-1,-1,-1,130.000);
}


hook OnPlayerConnect(playerid)
{
	RemoveBuildingForPlayer(playerid, 4031, 1460.054, -1725.992, 9.203, 0.250);
	RemoveBuildingForPlayer(playerid, 4052, 1359.328, -1779.968, 9.390, 0.250);
	RemoveBuildingForPlayer(playerid, 4053, 1380.265, -1655.539, 10.804, 0.250);
	RemoveBuildingForPlayer(playerid, 4054, 1402.500, -1682.023, 25.546, 0.250);
	RemoveBuildingForPlayer(playerid, 4055, 1394.359, -1620.664, 32.148, 0.250);
	RemoveBuildingForPlayer(playerid, 4083, 1334.976, -1644.187, 11.789, 0.250);
	RemoveBuildingForPlayer(playerid, 4200, 1352.632, -1647.343, 14.703, 0.250);
	RemoveBuildingForPlayer(playerid, 1530, 1332.132, -1722.304, 14.187, 0.250);
	RemoveBuildingForPlayer(playerid, 4211, 1380.265, -1655.539, 10.804, 0.250);
	RemoveBuildingForPlayer(playerid, 4220, 1370.640, -1643.445, 33.179, 0.250);
	RemoveBuildingForPlayer(playerid, 1266, 1353.640, -1713.570, 19.843, 0.250);
	RemoveBuildingForPlayer(playerid, 4236, 1387.031, -1715.023, 30.414, 0.250);
	RemoveBuildingForPlayer(playerid, 1261, 1413.632, -1721.820, 28.281, 0.250);
	RemoveBuildingForPlayer(playerid, 4109, 1359.328, -1779.968, 9.390, 0.250);
	RemoveBuildingForPlayer(playerid, 1260, 1353.640, -1713.570, 19.843, 0.250);
	RemoveBuildingForPlayer(playerid, 4235, 1387.031, -1715.023, 30.414, 0.250);
	RemoveBuildingForPlayer(playerid, 1267, 1413.632, -1721.820, 28.281, 0.250);
	RemoveBuildingForPlayer(playerid, 3981, 1460.054, -1725.992, 9.203, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1419.328, -1710.234, 11.835, 0.250);
	RemoveBuildingForPlayer(playerid, 4195, 1381.585, -1698.015, 14.671, 0.250);
	RemoveBuildingForPlayer(playerid, 4005, 1402.500, -1682.023, 25.546, 0.250);
	RemoveBuildingForPlayer(playerid, 3978, 1380.265, -1655.539, 10.804, 0.250);
	RemoveBuildingForPlayer(playerid, 4197, 1380.265, -1655.539, 10.804, 0.250);
	RemoveBuildingForPlayer(playerid, 4198, 1380.265, -1655.539, 10.804, 0.250);
	RemoveBuildingForPlayer(playerid, 4106, 1342.968, -1652.265, 15.203, 0.250);
	RemoveBuildingForPlayer(playerid, 4011, 1334.976, -1644.187, 11.789, 0.250);
	RemoveBuildingForPlayer(playerid, 4199, 1352.632, -1647.343, 14.703, 0.250);
	RemoveBuildingForPlayer(playerid, 647, 1378.812, -1623.382, 14.460, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1379.242, -1622.453, 12.867, 0.250);
	RemoveBuildingForPlayer(playerid, 647, 1375.640, -1621.867, 14.585, 0.250);
	RemoveBuildingForPlayer(playerid, 647, 1382.046, -1621.867, 14.484, 0.250);
	RemoveBuildingForPlayer(playerid, 4006, 1394.359, -1620.664, 32.148, 0.250);
	RemoveBuildingForPlayer(playerid, 4121, 1336.015, -1604.734, 25.632, 0.250);
	RemoveBuildingForPlayer(playerid, 4196, 1361.218, -1604.593, 14.937, 0.250);
}

