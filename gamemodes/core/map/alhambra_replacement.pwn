#include <YSI\y_hooks>

hook OnGameModeInit()
{
	new alhambrareplacement;
	alhambrareplacement = CreateObject(4858, 1881.90039, -1682.28821, 14.53252,   0.00000, 0.00000, 90.00000, 400.0);
	SetObjectMaterial(alhambrareplacement, 0, 19279, "matlights", "invisible", 0xFFFFFFFF); // billboard removing
	SetObjectMaterial(alhambrareplacement, 3, 5407, "glenpark1x_lae", "sjmscorclawn", 0xFFFFFFFF); // grass
	SetObjectMaterial(alhambrareplacement, 4, 5407, "glenpark1x_lae", "sjmcargr", 0xFFFFFFFF); // alley
	SetObjectMaterial(alhambrareplacement, 5, 5407, "glenpark1x_lae", "sjmcargr", 0xFFFFFFFF); // housing projects garden
	SetObjectMaterial(alhambrareplacement, 11, 5407, "glenpark1x_lae", "sjmcargr", 0xFFFFFFFF); // alley

	alhambrareplacement = CreateObject(10982, 1837.49304, -1720.75720, 18.31740,   0.00000, 0.00000, -90.00000, 400.0);
	SetObjectMaterial(alhambrareplacement, 7, 19279, "matlights", "invisible", 0xFFFFFFFF);
	alhambrareplacement = CreateObject(10982, 1837.65149, -1689.68469, 18.31640,   0.00000, 0.00000, -90.00000, 400.0);
	SetObjectMaterial(alhambrareplacement, 7, 19279, "matlights", "invisible", 0xFFFFFFFF);
	alhambrareplacement = CreateObject(10982, 1866.43762, -1713.05603, 18.31440,   0.00000, 0.00000, 0.00000, 400.0);
	SetObjectMaterial(alhambrareplacement, 7, 19279, "matlights", "invisible", 0xFFFFFFFF);
	alhambrareplacement = CreateObject(10982, 1851.23657, -1694.10779, 18.31540,   0.00000, 0.00000, -90.00000, 400.0);
	SetObjectMaterial(alhambrareplacement, 7, 19279, "matlights", "invisible", 0xFFFFFFFF);
	alhambrareplacement = CreateObject(10982, 1866.43665, -1713.05505, 10.59879,   0.00000, 0.00000, 0.00000, 400.0);
	SetObjectMaterial(alhambrareplacement, 7, 19279, "matlights", "invisible", 0xFFFFFFFF);
	alhambrareplacement = CreateObject(10982, 1847.91907, -1694.10876, 18.29740,   0.00000, 0.00000, -90.00000, 400.0);
	SetObjectMaterial(alhambrareplacement, 7, 19279, "matlights", "invisible", 0xFFFFFFFF);
	alhambrareplacement = CreateObject(10982, 1851.23755, -1694.10901, 10.58996,   0.00000, 0.00000, -90.00000, 400.0);
	SetObjectMaterial(alhambrareplacement, 7, 19279, "matlights", "invisible", 0xFFFFFFFF);
	alhambrareplacement = CreateObject(10982, 1866.43958, -1736.63062, 18.31740,   0.00000, 0.00000, 0.00000, 400.0);
	SetObjectMaterial(alhambrareplacement, 7, 19279, "matlights", "invisible", 0xFFFFFFFF);
	alhambrareplacement = CreateObject(10982, 1866.43860, -1723.66321, 18.31640,   0.00000, 0.00000, 0.00000, 400.0);
	SetObjectMaterial(alhambrareplacement, 7, 19279, "matlights", "invisible", 0xFFFFFFFF);

	// Rampos prie ivaziavimu
	alhambrareplacement = CreateObject(8947, 1895.10852, -1633.88599, 7.41440,   10.00000, 0.00000, 0.00000);
	SetObjectMaterial(alhambrareplacement, 1, 5407, "glenpark1x_lae", "sjmcargr", 0xFFFFFFFF);
	SetObjectMaterial(alhambrareplacement, 2, 5407, "glenpark1x_lae", "sjmcargr", 0xFFFFFFFF);
	alhambrareplacement = CreateObject(8947, 1895.10852, -1730.75842, 7.41440,   -10.00000, 0.00000, 0.00000);
	SetObjectMaterial(alhambrareplacement, 1, 5407, "glenpark1x_lae", "sjmcargr", 0xFFFFFFFF);
	SetObjectMaterial(alhambrareplacement, 2, 5407, "glenpark1x_lae", "sjmcargr", 0xFFFFFFFF);
	// Parde
	//CreateObject(17862, 1848.94617, -1640.26709, 12.53620,   0.00000, 0.00000, 0.00000);
	// BURGER SHOT
	// Siena i ganghouse
	alhambrareplacement = CreateDynamicObject(18981, 1887.40857, -1634.64758, 3.10514,   0.00000, 0.00000, 0.00000, -1, -1, -1, 170.0, 170.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 5134, "wasteland_las2", "ws_sandstone2", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(18981, 1887.38281, -1659.62256, 3.10310,   0.00000, 0.00000, 0.00000, -1, -1, -1, 170.0, 170.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 5134, "wasteland_las2", "ws_sandstone2", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(18981, 1875.38110, -1671.67432, 3.10310,   0.00000, 0.00000, 90.00000, -1, -1, -1, 170.0, 170.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 5134, "wasteland_las2", "ws_sandstone2", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(18981, 1850.40344, -1671.66248, 3.10310,   0.00000, 0.00000, 90.00000, -1, -1, -1, 170.0, 170.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 5134, "wasteland_las2", "ws_sandstone2", 0xFFFFFFFF);
	// pagrindas
	alhambrareplacement = CreateObject(4594, 1869.22998, -1634.31873, -9.80960,   0.00000, 0.00000, -90.00000, 350.0);
	SetObjectMaterial(alhambrareplacement, 2, 6282, "beafron2_law2", "concretenewb256128", 0xFFFFFFFF);
	alhambrareplacement = CreateObject(4594, 1893.91919, -1634.29932, -9.80760,   0.00000, 0.00000, -90.00000, 350.0);
	SetObjectMaterial(alhambrareplacement, 2, 6282, "beafron2_law2", "concretenewb256128", 0xFFFFFFFF);
	alhambrareplacement = CreateObject(4594, 1869.24609, -1658.84058, -9.80960,   0.00000, 0.00000, -90.00000, 350.0);
	SetObjectMaterial(alhambrareplacement, 2, 6282, "beafron2_law2", "concretenewb256128", 0xFFFFFFFF);
	alhambrareplacement = CreateObject(4594, 1893.99963, -1658.77148, -9.80760,   0.00000, 0.00000, -90.00000, 350.0);
	SetObjectMaterial(alhambrareplacement, 2, 6282, "beafron2_law2", "concretenewb256128", 0xFFFFFFFF);
	// Burgershotas
	CreateObject(6010, 1842.62659, -1659.41455, 13.56880,   0.00000, 0.00000, 90.00000, 400.0);
	// Misc, krumai ir pns
	CreateDynamicObject(7943, 1850.50415, -1667.33997, 16.05210,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(760, 1884.95544, -1668.97546, 12.83748,   0.00000, 0.00000, 0.06000);
	CreateDynamicObject(760, 1845.35999, -1670.79468, 12.83748,   0.00000, 0.00000, 0.06000);
	CreateDynamicObject(702, 1885.59497, -1623.43884, 12.95305,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 1833.66870, -1624.14954, 12.63750,   0.00000, 0.00000, 0.06000);
	CreateDynamicObject(8843, 1845.02283, -1661.84265, 12.55800,   0.00000, 0.00000, -90.00000);
	// Sidewalks
	alhambrareplacement = CreateDynamicObject(19456, 1852.95850, -1632.79407, 12.58950,   0.00000, 90.00000, 90.00000, -1, -1, -1, 100.0, 100.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 9908, "smallertxd", "ws_trans_concr", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19456, 1862.40295, -1632.84253, 12.58950,   0.00000, 90.00000, 90.00000, -1, -1, -1, 100.0, 100.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 9908, "smallertxd", "ws_trans_concr", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19456, 1865.46631, -1639.39172, 12.58950,   0.00000, 90.00000, 0.00000, -1, -1, -1, 100.0, 100.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 9908, "smallertxd", "ws_trans_concr", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19456, 1865.44861, -1648.99963, 12.58950,   0.00000, 90.00000, 0.00000, -1, -1, -1, 100.0, 100.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 9908, "smallertxd", "ws_trans_concr", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19456, 1862.38354, -1654.78345, 12.58750,   0.00000, 90.00000, 90.00000, -1, -1, -1, 100.0, 100.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 9908, "smallertxd", "ws_trans_concr", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19456, 1852.88391, -1654.77515, 12.58950,   0.00000, 90.00000, 90.00000, -1, -1, -1, 100.0, 100.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 9908, "smallertxd", "ws_trans_concr", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19456, 1843.86633, -1654.79211, 12.58950,   0.00000, 90.00000, 90.00000, -1, -1, -1, 100.0, 100.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 9908, "smallertxd", "ws_trans_concr", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19456, 1842.59253, -1634.40076, 12.58950,   0.00000, 90.00000, 0.00000, -1, -1, -1, 100.0, 100.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 9908, "smallertxd", "ws_trans_concr", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19456, 1842.61682, -1643.94458, 12.58950,   0.00000, 90.00000, 0.00000, -1, -1, -1, 100.0, 100.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 9908, "smallertxd", "ws_trans_concr", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19456, 1839.14441, -1643.95239, 12.58950,   0.00000, 90.00000, 0.00000, -1, -1, -1, 100.0, 100.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 9908, "smallertxd", "ws_trans_concr", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19437, 1844.79724, -1630.38501, 12.59150,   0.00000, 90.00000, 0.00000, -1, -1, -1, 100.0, 100.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 9908, "smallertxd", "ws_trans_concr", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19437, 1847.35339, -1631.33362, 12.58950,   0.00000, 90.00000, 90.00000, -1, -1, -1, 100.0, 100.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 9908, "smallertxd", "ws_trans_concr", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19437, 1839.13611, -1649.22766, 12.58750,   0.00000, 90.00000, 0.00000, -1, -1, -1, 100.0, 100.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 9908, "smallertxd", "ws_trans_concr", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19437, 1839.85010, -1651.36804, 12.59350,   0.00000, 90.00000, 90.00000, -1, -1, -1, 100.0, 100.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 9908, "smallertxd", "ws_trans_concr", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19437, 1839.11707, -1650.19861, 12.58950,   0.00000, 90.00000, 0.00000, -1, -1, -1, 100.0, 100.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 9908, "smallertxd", "ws_trans_concr", 0xFFFFFFFF);

	// linijos
	CreateDynamicObject(19455, 1888.25659, -1736.45801, 10.68251,   0.00000, 0.00000, 0.00000, -1, -1, -1, 90.0, 90.0);
	CreateDynamicObject(19455, 1888.24805, -1726.96729, 10.68251,   0.00000, 0.00000, 0.00000, -1, -1, -1, 90.0, 90.0);
	CreateDynamicObject(19455, 1888.25916, -1719.77344, 10.68251,   0.00000, 0.00000, 0.00000, -1, -1, -1, 90.0, 90.0);
	CreateDynamicObject(19445, 1881.10828, -1622.69482, 10.81520,   0.00000, 0.00000, 90.00000, -1, -1, -1, 90.0, 90.0);
	CreateDynamicObject(19445, 1881.10828, -1627.69482, 10.81520,   0.00000, 0.00000, 90.00000, -1, -1, -1, 90.0, 90.0);
	CreateDynamicObject(19445, 1881.10828, -1632.69482, 10.81520,   0.00000, 0.00000, 90.00000, -1, -1, -1, 90.0, 90.0);
	CreateDynamicObject(19445, 1881.10828, -1637.69482, 10.81520,   0.00000, 0.00000, 90.00000, -1, -1, -1, 90.0, 90.0);
	CreateDynamicObject(19445, 1880.90869, -1642.69141, 10.81520,   0.00000, 0.00000, 90.00000, -1, -1, -1, 90.0, 90.0);
	CreateDynamicObject(19445, 1880.90869, -1647.69141, 10.81520,   0.00000, 0.00000, 90.00000, -1, -1, -1, 90.0, 90.0);
	CreateDynamicObject(19445, 1880.90869, -1652.69141, 10.81520,   0.00000, 0.00000, 90.00000, -1, -1, -1, 90.0, 90.0);
	CreateDynamicObject(19445, 1880.90869, -1657.69141, 10.81520,   0.00000, 0.00000, 90.00000, -1, -1, -1, 90.0, 90.0);
	CreateDynamicObject(19445, 1880.90869, -1662.69141, 10.81520,   0.00000, 0.00000, 90.00000, -1, -1, -1, 90.0, 90.0);
	CreateDynamicObject(19445, 1880.90869, -1667.69141, 10.81520,   0.00000, 0.00000, 90.00000, -1, -1, -1, 90.0, 90.0);
	CreateDynamicObject(19445, 1883.17639, -1627.42322, 10.81720,   0.00000, 0.00000, 0.00000, -1, -1, -1, 90.0, 90.0);
	CreateDynamicObject(19445, 1883.16907, -1637.03113, 10.81720,   0.00000, 0.00000, 0.00000, -1, -1, -1, 90.0, 90.0);
	CreateDynamicObject(19445, 1883.16956, -1646.63660, 10.81720,   0.00000, 0.00000, 0.00000, -1, -1, -1, 90.0, 90.0);
	CreateDynamicObject(19445, 1883.17468, -1656.24463, 10.81720,   0.00000, 0.00000, 0.00000, -1, -1, -1, 90.0, 90.0);
	CreateDynamicObject(19445, 1883.16101, -1665.78491, 10.81720,   0.00000, 0.00000, 0.00000, -1, -1, -1, 90.0, 90.0);
	CreateDynamicObject(1359, 1839.51807, -1650.56042, 13.29093,   0.00000, 0.00000, 0.00000, -1, -1, -1, 70.0, 70.0); // siuksline
	// suoliukai
	CreateDynamicObject(1280, 1866.08569, -1638.90283, 13.01250,   0.00000, 0.00000, 180.00000, -1, -1, -1, 100.0, 100.0);
	CreateDynamicObject(1280, 1841.89648, -1635.57971, 13.01253,   0.00000, 0.00000, 0.00000, -1, -1, -1, 100.0, 100.0);
	CreateDynamicObject(1280, 1866.01843, -1649.77881, 13.01250,   0.00000, 0.00000, 180.00000, -1, -1, -1, 100.0, 100.0);


	// Apdengt zole
	alhambrareplacement = CreateDynamicObject(19462, 1849.83618, -1668.00061, 11.12204,   0.00000, 0.00000, 90.00000, -1, -1, -1, 200.0, 200.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 3653, "beachapts_lax", "eastwall4_LAe2", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19462, 1859.39648, -1668.00171, 11.12204,   0.00000, 0.00000, 90.00000, -1, -1, -1, 200.0, 200.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 3653, "beachapts_lax", "eastwall4_LAe2", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19462, 1869.01794, -1667.99414, 11.12204,   0.00000, 0.00000, 90.00000, -1, -1, -1, 200.0, 200.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 3653, "beachapts_lax", "eastwall4_LAe2", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19462, 1878.61694, -1667.99719, 11.12204,   0.00000, 0.00000, 90.00000, -1, -1, -1, 200.0, 200.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 3653, "beachapts_lax", "eastwall4_LAe2", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19462, 1883.34912, -1663.15662, 11.12200,   0.00000, 0.00000, 0.00000, -1, -1, -1, 200.0, 200.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 3653, "beachapts_lax", "eastwall4_LAe2", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19462, 1883.33289, -1655.10583, 11.12200,   0.00000, 0.00000, 0.00000, -1, -1, -1, 200.0, 200.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 3653, "beachapts_lax", "eastwall4_LAe2", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19462, 1883.33911, -1645.95557, 11.12200,   0.00000, 0.00000, 0.00000, -1, -1, -1, 200.0, 200.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 3653, "beachapts_lax", "eastwall4_LAe2", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19462, 1883.34131, -1636.39404, 11.12200,   0.00000, 0.00000, 0.00000, -1, -1, -1, 200.0, 200.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 3653, "beachapts_lax", "eastwall4_LAe2", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19462, 1883.35437, -1627.04688, 11.11800,   0.00000, 0.00000, 0.00000, -1, -1, -1, 200.0, 200.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 3653, "beachapts_lax", "eastwall4_LAe2", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19462, 1840.20264, -1667.99207, 11.12204,   0.00000, 0.00000, 90.00000, -1, -1, -1, 200.0, 200.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 3653, "beachapts_lax", "eastwall4_LAe2", 0xFFFFFFFF);

	alhambrareplacement = CreateDynamicObject(19370, 1833.48193, -1631.75427, 11.42002,   90.00000, 0.00000, 90.00000, -1, -1, -1, 200.0, 200.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 3653, "beachapts_lax", "eastwall4_LAe2", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19370, 1841.13318, -1624.06848, 11.42000,   90.00000, 0.00000, 0.00000, -1, -1, -1, 200.0, 200.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 3653, "beachapts_lax", "eastwall4_LAe2", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19370, 1839.44434, -1625.72913, 11.42000,   90.00000, 0.00000, 90.00000, -1, -1, -1, 200.0, 200.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 3653, "beachapts_lax", "eastwall4_LAe2", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19370, 1836.93835, -1625.72156, 11.41800,   90.00000, 0.00000, 90.00000, -1, -1, -1, 200.0, 200.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 3653, "beachapts_lax", "eastwall4_LAe2", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19370, 1835.26318, -1627.38367, 11.42000,   90.00000, 0.00000, 0.00000, -1, -1, -1, 200.0, 200.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 3653, "beachapts_lax", "eastwall4_LAe2", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19370, 1835.27063, -1630.09106, 11.42000,   90.00000, 0.00000, 0.00000, -1, -1, -1, 200.0, 200.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 3653, "beachapts_lax", "eastwall4_LAe2", 0xFFFFFFFF);

	// Zole
	alhambrareplacement = CreateDynamicObject(19463, 1878.63220, -1669.73999, 12.70280,   0.00000, 90.00000, 90.00000, -1, -1, -1, 150.0, 150.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 8463, "vgseland", "Grass_128HV", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19463, 1868.99438, -1669.75317, 12.70280,   0.00000, 90.00000, 90.00000, -1, -1, -1, 150.0, 150.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 8463, "vgseland", "Grass_128HV", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19463, 1859.34814, -1669.82300, 12.70280,   0.00000, 90.00000, 90.00000, -1, -1, -1, 150.0, 150.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 8463, "vgseland", "Grass_128HV", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19463, 1849.74719, -1669.73425, 12.70280,   0.00000, 90.00000, 90.00000, -1, -1, -1, 150.0, 150.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 8463, "vgseland", "Grass_128HV", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19463, 1885.17346, -1666.38965, 12.70280,   0.00000, 90.00000, 0.00000, -1, -1, -1, 150.0, 150.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 8463, "vgseland", "Grass_128HV", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19463, 1840.12354, -1669.76440, 12.70280,   0.00000, 90.00000, 90.00000, -1, -1, -1, 150.0, 150.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 8463, "vgseland", "Grass_128HV", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19463, 1885.16162, -1656.75085, 12.70280,   0.00000, 90.00000, 0.00000, -1, -1, -1, 150.0, 150.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 8463, "vgseland", "Grass_128HV", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19463, 1885.17053, -1647.12537, 12.70280,   0.00000, 90.00000, 0.00000, -1, -1, -1, 150.0, 150.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 8463, "vgseland", "Grass_128HV", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19463, 1885.15149, -1637.49512, 12.70280,   0.00000, 90.00000, 0.00000, -1, -1, -1, 150.0, 150.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 8463, "vgseland", "Grass_128HV", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19463, 1885.16870, -1627.88086, 12.70280,   0.00000, 90.00000, 0.00000, -1, -1, -1, 150.0, 150.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 8463, "vgseland", "Grass_128HV", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19463, 1885.16602, -1627.15515, 12.69680,   0.00000, 90.00000, 0.00000, -1, -1, -1, 150.0, 150.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 8463, "vgseland", "Grass_128HV", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19463, 1833.43335, -1627.01270, 12.70280,   0.00000, 90.00000, 0.00000, -1, -1, -1, 150.0, 150.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 8463, "vgseland", "Grass_128HV", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19463, 1836.3920, -1624.00610, 12.70080,   0.00000, 90.00000, 90.00000, -1, -1, -1, 150.0, 150.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 8463, "vgseland", "Grass_128HV", 0xFFFFFFFF);

	// Tvoros i lauka
	alhambrareplacement = CreateDynamicObject(19450, 1878.25610, -1622.29382, 12.68666,   0.00000, 0.00000, 90.00000, -1, -1, -1, 200.0, 200.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 17545, "burnsground", "newall10_seamless", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19450, 1883.11841, -1622.27661, 12.68370,   0.00000, 0.00000, 90.00000, -1, -1, -1, 200.0, 200.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 17545, "burnsground", "newall10_seamless", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19450, 1836.41064, -1622.27612, 11.77060,   0.00000, 0.00000, 90.00000, -1, -1, -1, 200.0, 200.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 17545, "burnsground", "newall10_seamless", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19450, 1831.66345, -1627.17090, 11.77056,   0.00000, 0.00000, 0.00000, -1, -1, -1, 200.0, 200.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 17545, "burnsground", "newall10_seamless", 0xFFFFFFFF);

	CreateDynamicObject(1500, 1840.33118, -1644.81824, 12.67480,   0.00000, 0.00000, 88.78147);


	// sidewalks
	alhambrareplacement = CreateDynamicObject(8947, 1876.07666, -1710.90356, 9.31100,   0.00000, 0.00000, 90.00000, -1, -1, -1, 150.0, 150.0);
	SetDynamicObjectMaterial(alhambrareplacement, 1, 9908, "smallertxd", "ws_trans_concr", 0xFFFFFFFF);
	SetDynamicObjectMaterial(alhambrareplacement, 2, 9908, "smallertxd", "ws_trans_concr", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(8947, 1851.51306, -1710.90356, 9.30700,   0.00000, 0.00000, 90.00000, -1, -1, -1, 150.0, 150.0);
	SetDynamicObjectMaterial(alhambrareplacement, 1, 9908, "smallertxd", "ws_trans_concr", 0xFFFFFFFF);
	SetDynamicObjectMaterial(alhambrareplacement, 2, 9908, "smallertxd", "ws_trans_concr", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(8947, 1853.38794, -1684.74792, 9.31100,   0.00000, 0.00000, 0.00000, -1, -1, -1, 150.0, 150.0);
	SetDynamicObjectMaterial(alhambrareplacement, 1, 9908, "smallertxd", "ws_trans_concr", 0xFFFFFFFF);
	SetDynamicObjectMaterial(alhambrareplacement, 2, 9908, "smallertxd", "ws_trans_concr", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(8947, 1853.38684, -1697.67786, 9.30900,   0.00000, 0.00000, 0.00000, -1, -1, -1, 150.0, 150.0);
	SetDynamicObjectMaterial(alhambrareplacement, 1, 9908, "smallertxd", "ws_trans_concr", 0xFFFFFFFF);
	SetDynamicObjectMaterial(alhambrareplacement, 2, 9908, "smallertxd", "ws_trans_concr", 0xFFFFFFFF);

	// Court basketball
	alhambrareplacement = CreateDynamicObject(8947, 1872.21216, -1679.86108, 9.31100,   0.00000, 0.00000, 90.00000, -1, -1, -1, 180.0, 180.0);
	SetDynamicObjectMaterial(alhambrareplacement, 1, 17517, "templae2land", "concretemanky", 0xFFFFFFFF);
	SetDynamicObjectMaterial(alhambrareplacement, 2, 17517, "templae2land", "concretemanky", 0xFFFFFFFF);


	// Nameliai
	alhambrareplacement = CreateObject(3646, 1918.22070, -1725.76050, 16.03510,   0.00000, 0.00000, 180.00000, 350.0);
	SetObjectMaterial(alhambrareplacement, 9, 9239, "stuff2_sfn", "sl_whitewood01", 0xFFFFFFFF);
	alhambrareplacement = CreateObject(3655, 1918.22070, -1638.90149, 16.87630,   0.00000, 0.00000, 0.00000, 350.0);
	SetObjectMaterial(alhambrareplacement, 9, 10053, "slapart01sfe", "sl_vicwall02", 0xFFFFFFFF);
	alhambrareplacement = CreateObject(3646, 1918.22070, -1660.74011, 16.05510,   0.00000, 0.00000, 180.00000, 350.0);
	SetObjectMaterial(alhambrareplacement, 9, 9239, "stuff2_sfn", "sl_whitewood01", 0xFFFFFFFF);
	alhambrareplacement = CreateObject(3648, 1918.22070, -1701.96704, 16.64210,   0.00000, 0.00000, 180.00000, 350.0);
	SetObjectMaterial(alhambrareplacement, 1, 10053, "slapart01sfe", "sl_vicwall01", 0xFFFFFFFF);
	alhambrareplacement = CreateObject(3648, 1918.22070, -1680.25488, 16.64210,   0.00000, 0.00000, 180.00000, 350.0);
	SetObjectMaterial(alhambrareplacement, 1, 10053, "slapart01sfe", "sl_vicwall01", 0xFFFFFFFF);

	// Tribuna
	alhambrareplacement = CreateDynamicObject(3819, 1886.59290, -1679.85706, 12.51246,   0.00000, 0.00000, 0.00000, -1, -1, -1, 110.0, 110.0);
	SetDynamicObjectMaterial(alhambrareplacement, 2, 19279, "matlights", "invisible", 0xFFFFFFFF);

	// Stogeliai
	alhambrareplacement = CreateDynamicObject(19435, 1869.93750, -1706.93237, 15.22330,   0.00000, 90.00000, -90.00000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 10357, "tvtower_sfs", "ws_rooftarmac2", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19435, 1857.32849, -1697.60706, 15.22330,   0.00000, 90.00000, 180.00000, -1, -1, -1, 50.0, 50.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 10357, "tvtower_sfs", "ws_rooftarmac2", 0xFFFFFFFF);

	// Zole
	alhambrareplacement = CreateDynamicObject(19435, 1935.85010, -1642.45935, 12.46500,   0.00000, 90.00000, 90.00000, -1, -1, -1, 85.0, 85.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 4807, "lasroads_las", "Grass_dirt_64HV", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19435, 1935.85010, -1654.94788, 12.46500,   0.00000, 90.00000, 90.00000, -1, -1, -1, 85.0, 85.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 4807, "lasroads_las", "Grass_dirt_64HV", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19435, 1935.85010, -1651.44788, 12.46500,   0.00000, 90.00000, 90.00000, -1, -1, -1, 85.0, 85.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 4807, "lasroads_las", "Grass_dirt_64HV", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19435, 1935.85010, -1645.95581, 12.46500,   0.00000, 90.00000, 90.00000, -1, -1, -1, 85.0, 85.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 4807, "lasroads_las", "Grass_dirt_64HV", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19435, 1935.85010, -1648.68665, 12.46400,   0.00000, 90.00000, 90.00000, -1, -1, -1, 85.0, 85.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 4807, "lasroads_las", "Grass_dirt_64HV", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19435, 1935.85010, -1685.67249, 12.46500,   0.00000, 90.00000, 90.00000, -1, -1, -1, 85.0, 85.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 4807, "lasroads_las", "Grass_dirt_64HV", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19435, 1935.85010, -1698.22278, 12.46500,   0.00000, 90.00000, 90.00000, -1, -1, -1, 85.0, 85.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 4807, "lasroads_las", "Grass_dirt_64HV", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19435, 1935.85010, -1694.72351, 12.46500,   0.00000, 90.00000, 90.00000, -1, -1, -1, 85.0, 85.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 4807, "lasroads_las", "Grass_dirt_64HV", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19435, 1935.85010, -1689.17163, 12.46500,   0.00000, 90.00000, 90.00000, -1, -1, -1, 85.0, 85.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 4807, "lasroads_las", "Grass_dirt_64HV", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19435, 1935.85010, -1691.82007, 12.46400,   0.00000, 90.00000, 90.00000, -1, -1, -1, 85.0, 85.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 4807, "lasroads_las", "Grass_dirt_64HV", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19435, 1935.85010, -1729.11890, 12.46500,   0.00000, 90.00000, 90.00000, -1, -1, -1, 85.0, 85.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 4807, "lasroads_las", "Grass_dirt_64HV", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19435, 1935.85010, -1738.08337, 12.46500,   0.00000, 90.00000, 90.00000, -1, -1, -1, 85.0, 85.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 4807, "lasroads_las", "Grass_dirt_64HV", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19435, 1935.85010, -1734.58594, 12.46500,   0.00000, 90.00000, 90.00000, -1, -1, -1, 85.0, 85.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 4807, "lasroads_las", "Grass_dirt_64HV", 0xFFFFFFFF);
	alhambrareplacement = CreateDynamicObject(19435, 1935.85010, -1731.82422, 12.46400,   0.00000, 90.00000, 90.00000, -1, -1, -1, 85.0, 85.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 4807, "lasroads_las", "Grass_dirt_64HV", 0xFFFFFFFF);

	alhambrareplacement = CreateDynamicObject(19815, 1929.22009, -1743.02417, 13.08330,   90.00000, 0.00000, -1.02000, -1, -1, -1, 35.0, 35.0);
	SetDynamicObjectMaterial(alhambrareplacement, 0, 16150, "ufo_bar", "sa_wood07_128", 0xFFFFFFFF);


	CreateDynamicObject(1308, 1888.66199, -1622.07239, 12.78130,   0.00000, 0.00000, 0.00000, -1, -1, -1, 140.0, 140.0);
	CreateDynamicObject(19869, 1889.22290, -1675.14136, 12.12510,   0.00000, 0.00000, -90.00000, -1, -1, -1, 60.0, 60.0);
	CreateDynamicObject(19869, 1889.22290, -1680.39978, 12.12510,   0.00000, 0.00000, -90.00000, -1, -1, -1, 60.0, 60.0);
	CreateDynamicObject(19869, 1889.22290, -1685.66089, 12.12510,   0.00000, 0.00000, -90.00000, -1, -1, -1, 60.0, 60.0);
	CreateDynamicObject(19869, 1860.77136, -1675.14307, 12.34310,   0.00000, 0.00000, 90.00000, -1, -1, -1, 60.0, 60.0);
	CreateDynamicObject(19869, 1860.77136, -1680.40527, 12.34310,   0.00000, 0.00000, 90.00000, -1, -1, -1, 60.0, 60.0);
	CreateDynamicObject(19869, 1860.77136, -1685.66370, 12.34310,   0.00000, 0.00000, 90.00000, -1, -1, -1, 60.0, 60.0);
	CreateDynamicObject(946, 1862.46619, -1680.40527, 14.52350,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(946, 1882.82544, -1680.40527, 14.51650,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1493, 1858.26636, -1698.36462, 12.36910,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1493, 1869.17310, -1706.05493, 12.36910,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1345, 1888.76746, -1661.99976, 13.03000,   0.00000, 0.00000, 93.00000);
	CreateDynamicObject(1344, 1888.78320, -1659.60181, 12.95350,   0.00000, 0.00000, 92.58000);
	CreateDynamicObject(1345, 1888.79370, -1664.52734, 13.02900,   0.00000, 0.00000, 87.41999);
	CreateDynamicObject(1440, 1888.63257, -1657.05994, 12.67230,   0.00000, 0.00000, 90.60000);
	CreateDynamicObject(1265, 1888.80688, -1661.78662, 14.18120,   0.00000, 0.00000, 99.00000);
	CreateDynamicObject(1280, 1873.64087, -1705.61755, 12.68510,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(2670, 1874.12952, -1704.86731, 12.49750,   0.00000, 0.00000, 38.34000);
	CreateDynamicObject(2674, 1885.29236, -1680.84961, 12.19080,   0.00000, 0.00000, -119.52000);
	CreateDynamicObject(2675, 1885.28455, -1678.17944, 12.24260,   0.00000, 0.00000, 16.20000);
	CreateDynamicObject(2673, 1885.51111, -1683.10474, 12.27109,   0.00000, 0.00000, -101.34000);
	CreateDynamicObject(2676, 1889.99451, -1661.03833, 12.28450,   0.00000, 0.00000, 112.98000);
	CreateDynamicObject(2676, 1890.53833, -1664.36218, 12.28950,   0.00000, 0.00000, -69.96000);
	CreateDynamicObject(2674, 1859.17688, -1695.19812, 12.41209,   0.00000, 0.00000, -125.94008);
	CreateDynamicObject(2674, 1859.47937, -1694.10608, 12.41410,   0.00000, 0.00000, -189.90015);
	CreateDynamicObject(1265, 1858.72571, -1695.67285, 12.79550,   0.00000, 0.00000, -222.48001);
	CreateDynamicObject(2671, 1862.35767, -1693.71436, 12.23450,   0.00000, 0.00000, -94.92001);
	CreateDynamicObject(760, 1859.06738, -1705.25671, 12.49717,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(760, 1888.89172, -1707.24866, 12.19214,   0.00000, 0.00000, 16.50000);
	CreateDynamicObject(760, 1898.65051, -1740.71277, 12.09414,   0.00000, 0.00000, 16.50000);
	CreateDynamicObject(760, 1888.64197, -1660.68933, 12.17363,   0.00000, 0.00000, 16.50000);
	CreateDynamicObject(1297, 1861.26782, -1700.87646, 15.93910,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1298, 1877.81799, -1703.08008, 15.54906,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(620, 1913.44238, -1739.10474, 12.36997,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(620, 1929.26904, -1694.24072, 12.36997,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(620, 1908.34204, -1671.80029, 12.36997,   0.00000, 0.00000, 33.66000);
	CreateDynamicObject(620, 1929.47266, -1655.05029, 12.36997,   0.00000, 0.00000, -18.30000);
	CreateDynamicObject(620, 1923.67273, -1625.33618, 12.36997,   0.00000, 0.00000, 9.24000);
	CreateDynamicObject(620, 1929.25061, -1631.45667, 12.36997,   0.00000, 0.00000, -42.06000);
	CreateDynamicObject(673, 1927.70471, -1733.23328, 13.78562,   0.00000, 0.00000, 32.88000);
	CreateDynamicObject(673, 1929.15161, -1673.06116, 13.78562,   0.00000, 0.00000, 8.82000);
	CreateDynamicObject(673, 1908.69641, -1668.68481, 13.78562,   0.00000, 0.00000, 8.82000);
	CreateDynamicObject(673, 1901.77478, -1624.64990, 13.78562,   0.00000, 0.00000, 119.94001);
	CreateDynamicObject(673, 1911.69617, -1650.03406, 13.78562,   0.00000, 0.00000, 26.04003);
	CreateDynamicObject(673, 1900.78564, -1701.08362, 13.78562,   0.00000, 0.00000, 72.42000);
	CreateDynamicObject(620, 1902.72961, -1718.15833, 12.36997,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(647, 1902.10999, -1718.66589, 13.98491,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(647, 1928.40613, -1694.47388, 13.66236,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(647, 1928.85547, -1689.12134, 13.87573,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(647, 1901.16638, -1645.04590, 14.49093,   0.00000, 0.00000, -8.46000);
	CreateDynamicObject(760, 1901.08179, -1654.96399, 13.99118,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(647, 1928.11377, -1650.31860, 14.08489,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(620, 1936.58008, -1686.06348, 10.22530,   0.00000, 0.00000, 20.82000);
	CreateDynamicObject(620, 1936.56177, -1651.55884, 10.22530,   0.00000, 0.00000, 0.78000);
	CreateDynamicObject(620, 1936.49048, -1731.18201, 10.22530,   0.00000, 0.00000, 15.96000);
	CreateDynamicObject(859, 1935.98987, -1732.47742, 12.55240,   0.00000, 0.00000, 17.70000);
	CreateDynamicObject(859, 1936.16223, -1696.98035, 12.55240,   0.00000, 0.00000, 38.52000);
	CreateDynamicObject(859, 1935.86145, -1642.10181, 12.55240,   0.00000, 0.00000, 54.47999);
	CreateDynamicObject(860, 1935.77551, -1737.09668, 12.54689,   0.00000, 0.00000, -30.54000);
	CreateDynamicObject(860, 1935.93433, -1654.89197, 12.54689,   0.00000, 0.00000, 8.70000);
	CreateDynamicObject(861, 1935.52710, -1730.30017, 12.24970,   0.00000, 0.00000, -71.82000);
	CreateDynamicObject(861, 1935.98474, -1687.04602, 12.24970,   0.00000, 0.00000, -49.80000);
	CreateDynamicObject(861, 1935.67224, -1650.50110, 12.24973,   0.00000, 0.00000, -49.80000);
	CreateDynamicObject(1308, 1932.22021, -1722.84351, 12.70940,   0.00000, 5.00000, 21.66000);
	CreateDynamicObject(1308, 1932.31775, -1695.76733, 12.70940,   -0.42000, -2.70000, -42.54000);
	CreateDynamicObject(1308, 1932.42786, -1662.49048, 12.70940,   -0.42000, -2.70000, -103.26000);
	CreateDynamicObject(1308, 1932.16040, -1632.68530, 12.70940,   -0.42000, -2.70000, -194.94002);
	CreateDynamicObject(861, 1935.72083, -1694.76868, 12.24970,   0.00000, 0.00000, -29.22000);
	CreateDynamicObject(1308, 1919.82617, -1742.80652, 12.70940,   0.00000, 5.00000, -26.40000);
	CreateDynamicObject(1308, 1898.76172, -1720.36584, 12.64940,   0.00000, 5.00000, 57.77999);
	CreateDynamicObject(1308, 1890.01782, -1683.45923, 12.64940,   0.00000, 5.00000, 57.77999);
	CreateDynamicObject(1308, 1898.32935, -1655.10339, 12.64940,   0.00000, 5.00000, 7.80000);
	CreateDynamicObject(2121, 1932.51917, -1673.08301, 13.02760,   0.00000, 0.00000, 70.86002);
	CreateDynamicObject(2121, 1932.67468, -1675.20581, 13.02760,   0.00000, 0.00000, 133.08002);
	CreateDynamicObject(2601, 1934.51953, -1673.82959, 12.62610,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1486, 1926.97876, -1747.48657, 12.42770,   0.00000, 90.00000, -26.16000);
	CreateDynamicObject(2671, 1928.45215, -1747.37219, 12.39240,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2671, 1936.68616, -1675.21399, 12.39240,   0.00000, 0.00000, 164.88004);
	CreateDynamicObject(11708, 1930.47803, -1743.06250, 12.62830,   0.00000, 0.00000, 87.48001, -1, -1, -1, 100.0, 100.0);
	CreateDynamicObject(11708, 1930.47803, -1743.06250, 12.98000,   0.00000, 0.00000, 87.54002, -1, -1, -1, 100.0, 100.0);
	CreateDynamicObject(11708, 1930.47803, -1743.06250, 12.80300,   0.00000, 0.00000, 78.78003, -1, -1, -1, 100.0, 100.0);
	CreateDynamicObject(11708, 1927.96936, -1743.06250, 12.62830,   0.00000, 0.00000, 94.98000, -1, -1, -1, 100.0, 100.0);
	CreateDynamicObject(11708, 1927.96936, -1743.06250, 12.80300,   0.00000, 0.00000, 100.50002, -1, -1, -1, 100.0, 100.0);
	CreateDynamicObject(11708, 1927.96936, -1743.06250, 12.98000,   0.00000, 0.00000, 89.70000, -1, -1, -1, 100.0, 100.0);
	CreateDynamicObject(11708, 1934.72534, -1674.33936, 12.60830,   0.00000, 0.00000, 83.82000, -1, -1, -1, 100.0, 100.0);
	CreateDynamicObject(11708, 1934.72534, -1674.33936, 12.78430,   0.00000, 0.00000, 92.76000, -1, -1, -1, 100.0, 100.0);
	CreateDynamicObject(19455, 1888.25659, -1736.45801, 10.68251,   0.00000, 0.00000, 0.00000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(19455, 1888.24805, -1726.96729, 10.68251,   0.00000, 0.00000, 0.00000, -1, -1, -1, 50.0, 50.0);
	CreateDynamicObject(19455, 1888.25916, -1719.77344, 10.68251,   0.00000, 0.00000, 0.00000, -1, -1, -1, 50.0, 50.0);
}

hook OnPlayerConnect(playerid)
{
	// Alhambra replacement MaC + f0cus
	RemoveBuildingForPlayer(playerid, 5544, 1873.7422, -1682.4766, 34.7969, 0.25);
	RemoveBuildingForPlayer(playerid, 1524, 1837.6641, -1640.3828, 13.7578, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1855.7188, -1741.5391, 10.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1879.5078, -1741.4844, 10.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1908.2188, -1741.4844, 10.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 712, 1929.5781, -1736.9063, 21.3906, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1931.0391, -1726.3281, 10.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1832.3828, -1694.3125, 9.7188, 0.25);
	RemoveBuildingForPlayer(playerid, 1537, 1837.4375, -1683.9688, 12.3047, 0.25);
	RemoveBuildingForPlayer(playerid, 1533, 1837.4375, -1683.9531, 12.3047, 0.25);
	RemoveBuildingForPlayer(playerid, 1537, 1837.4375, -1686.9844, 12.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1832.8984, -1670.7656, 9.7188, 0.25);
	RemoveBuildingForPlayer(playerid, 1533, 1837.4375, -1677.9219, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 1537, 1837.4375, -1680.9531, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 1533, 1837.4375, -1680.9375, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 5408, 1873.7422, -1682.4766, 34.7969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1931.0391, -1702.2891, 10.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 712, 1929.5781, -1694.4609, 21.3906, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1931.0391, -1667.0313, 10.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1931.0391, -1637.8984, 10.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1855.7188, -1623.2813, 10.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1879.5078, -1623.1016, 10.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, 1891.9688, -1622.0000, 12.7813, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1908.2188, -1622.9844, 10.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 712, 1929.5781, -1627.6250, 21.3906, 0.25);
}