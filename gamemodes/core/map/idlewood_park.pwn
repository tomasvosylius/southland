#include <YSI\y_hooks>

hook OnPlayerConnect(playerid)
{
	RemoveBuildingForPlayer(playerid, 3617, 1972.390, -1630.000, 17.679, 0.250);
	RemoveBuildingForPlayer(playerid, 3774, 1972.390, -1630.000, 17.679, 0.250);
	RemoveBuildingForPlayer(playerid, 3616, 1971.349, -1651.300, 17.906, 0.250);
	RemoveBuildingForPlayer(playerid, 3773, 1971.349, -1651.300, 17.906, 0.250);
	RemoveBuildingForPlayer(playerid, 3617, 1974.949, -1667.479, 17.656, 0.250);
	RemoveBuildingForPlayer(playerid, 3774, 1974.949, -1667.479, 17.656, 0.250);
	RemoveBuildingForPlayer(playerid, 5412, 1971.660, -1682.310, 13.742, 0.250);
	RemoveBuildingForPlayer(playerid, 5545, 1971.660, -1682.310, 13.742, 0.250);
	RemoveBuildingForPlayer(playerid, 3580, 1976.130, -1682.959, 19.351, 0.250);
	RemoveBuildingForPlayer(playerid, 3772, 1976.130, -1682.959, 19.351, 0.250);
	RemoveBuildingForPlayer(playerid, 3616, 1971.270, -1701.770, 17.882, 0.250);
	RemoveBuildingForPlayer(playerid, 3773, 1971.270, -1701.770, 17.882, 0.250);
	RemoveBuildingForPlayer(playerid, 3580, 1975.510, -1719.040, 19.328, 0.250);
	RemoveBuildingForPlayer(playerid, 3772, 1975.510, -1719.040, 19.328, 0.250);
	RemoveBuildingForPlayer(playerid, 673, 1988.770, -1702.050, 15.015, 0.250);
	RemoveBuildingForPlayer(playerid, 673, 1986.589, -1650.920, 14.664, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1958.369, -1736.550, 14.484, 0.250);
	RemoveBuildingForPlayer(playerid, 5633, 2089.359, -1643.929, 18.218, 0.250);
	RemoveBuildingForPlayer(playerid, 673, 1955.020, -1632.920, 14.968, 0.250);
	RemoveBuildingForPlayer(playerid, 1308, 2013.199, -1623.760, 12.781, 0.250);
	RemoveBuildingForPlayer(playerid, 673, 1955.300, -1649.880, 15.062, 0.250);

	/*RemoveBuildingForPlayer(playerid, 3617, 1972.390, -1630.000, 17.679, 0.250);
	RemoveBuildingForPlayer(playerid, 3774, 1972.390, -1630.000, 17.679, 0.250);
	RemoveBuildingForPlayer(playerid, 3616, 1971.349, -1651.300, 17.906, 0.250);
	RemoveBuildingForPlayer(playerid, 3773, 1971.349, -1651.300, 17.906, 0.250);
	RemoveBuildingForPlayer(playerid, 3617, 1974.949, -1667.479, 17.656, 0.250);
	RemoveBuildingForPlayer(playerid, 3774, 1974.949, -1667.479, 17.656, 0.250);
	RemoveBuildingForPlayer(playerid, 5412, 1971.660, -1682.310, 13.742, 0.250);
	RemoveBuildingForPlayer(playerid, 5545, 1971.660, -1682.310, 13.742, 0.250);
	RemoveBuildingForPlayer(playerid, 3580, 1976.130, -1682.959, 19.351, 0.250);
	RemoveBuildingForPlayer(playerid, 3772, 1976.130, -1682.959, 19.351, 0.250);
	RemoveBuildingForPlayer(playerid, 3616, 1971.270, -1701.770, 17.882, 0.250);
	RemoveBuildingForPlayer(playerid, 3773, 1971.270, -1701.770, 17.882, 0.250);
	RemoveBuildingForPlayer(playerid, 3580, 1975.510, -1719.040, 19.328, 0.250);
	RemoveBuildingForPlayer(playerid, 3772, 1975.510, -1719.040, 19.328, 0.250);
	RemoveBuildingForPlayer(playerid, 673, 1988.770, -1702.050, 15.015, 0.250);
	RemoveBuildingForPlayer(playerid, 673, 1986.589, -1650.920, 14.664, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1958.369, -1736.550, 14.484, 0.250);
	RemoveBuildingForPlayer(playerid, 5633, 2089.359, -1643.929, 18.218, 0.250);
	RemoveBuildingForPlayer(playerid, 673, 1955.020, -1632.920, 14.968, 0.250);
	RemoveBuildingForPlayer(playerid, 1308, 2013.199, -1623.760, 12.781, 0.250);
	RemoveBuildingForPlayer(playerid, 673, 1955.300, -1649.880, 15.062, 0.250);*/
}

hook OnGameModeInit()
{	
	new tmpobjid;

	// eglute tmpobjid = CreateDynamicObject(19076,1966.441,-1719.584,11.445,0.000,0.000,0.000,-1,-1,-1,110.000,90.000);

	tmpobjid = CreateObject(8661,1961.563,-1637.192,12.540,0.000,0.000,90.000,300.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateObject(8661,1961.563,-1702.701,12.543,0.000,0.000,90.000,300.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateObject(8661,1961.563,-1722.462,12.540,0.000,0.000,90.000,300.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateObject(8661,1961.563,-1711.612,12.537,0.000,0.000,90.000,300.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateObject(8661,1971.894,-1732.842,12.534,0.000,0.000,180.000,300.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateObject(8661,1971.894,-1712.873,12.534,0.000,0.000,180.000,300.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateObject(8661,1971.894,-1692.892,12.534,0.000,0.000,180.000,300.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateObject(8661,1971.894,-1647.132,12.537,0.000,0.000,180.000,300.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateObject(8661,1971.894,-1632.952,12.534,0.000,0.000,180.000,300.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);

	tmpobjid = CreateObject(19377,1987.095,-1661.526,12.451,0.000,90.000,90.000,300.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateObject(19377,1987.095,-1675.046,12.451,0.000,90.000,90.000,300.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateObject(19377,1987.095,-1670.586,12.454,0.000,90.000,90.000,300.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateObject(19377,1956.404,-1675.007,12.454,0.000,90.000,90.000,300.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateObject(19377,1956.404,-1662.406,12.454,0.000,90.000,90.000,300.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateObject(19377,1956.404,-1666.505,12.457,0.000,90.000,90.000,300.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);

	tmpobjid = CreateObject(19435,1962.958,-1679.395,12.455,0.000,90.000,0.000,200.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateObject(19435,1966.457,-1679.395,12.455,0.000,90.000,0.000,200.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateObject(19435,1969.927,-1679.395,12.455,0.000,90.000,0.000,200.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateObject(19435,1973.428,-1679.395,12.455,0.000,90.000,0.000,200.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateObject(19435,1976.928,-1679.395,12.455,0.000,90.000,0.000,200.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateObject(19435,1980.418,-1679.395,12.455,0.000,90.000,0.000,200.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateObject(19435,1978.418,-1676.845,12.455,0.000,90.000,90.000,200.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateObject(19435,1978.418,-1673.346,12.455,0.000,90.000,90.000,200.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateObject(19435,1978.418,-1669.855,12.455,0.000,90.000,90.000,200.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateObject(19435,1978.418,-1666.365,12.455,0.000,90.000,90.000,200.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateObject(19435,1978.418,-1662.875,12.455,0.000,90.000,90.000,200.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateObject(19435,1978.418,-1658.873,12.455,0.000,90.000,90.000,200.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateObject(19435,1978.418,-1660.254,12.452,0.000,90.000,90.000,200.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateObject(19435,1977.400,-1657.806,12.452,0.000,90.000,315.000,200.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateObject(19435,1961.681,-1657.658,12.452,0.000,90.000,405.000,200.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateObject(19435,1961.723,-1677.953,12.452,0.000,90.000,495.000,200.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateObject(19435,1977.032,-1678.242,12.452,0.000,90.000,585.000,200.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);


	// takeliai
	tmpobjid = CreateDynamicObject(19455,1958.049,-1675.352,12.456,0.000,90.000,180.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9515, "bigboxtemp1", "redbrickground256", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1958.049,-1666.942,12.466,0.000,90.000,180.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9515, "bigboxtemp1", "redbrickground256", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1958.049,-1657.311,12.466,0.000,90.000,180.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9515, "bigboxtemp1", "redbrickground256", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1964.618,-1654.229,12.466,0.000,90.000,270.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9515, "bigboxtemp1", "redbrickground256", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1974.400,-1654.229,12.466,0.000,90.000,270.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9515, "bigboxtemp1", "redbrickground256", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1972.670,-1654.229,12.463,0.000,90.000,270.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9515, "bigboxtemp1", "redbrickground256", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1986.968,-1681.922,12.456,0.000,90.000,90.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9515, "bigboxtemp1", "redbrickground256", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1977.350,-1681.922,12.456,0.000,90.000,90.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9515, "bigboxtemp1", "redbrickground256", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1967.719,-1681.922,12.456,0.000,90.000,90.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9515, "bigboxtemp1", "redbrickground256", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1956.357,-1681.922,12.456,0.000,90.000,90.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9515, "bigboxtemp1", "redbrickground256", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1961.938,-1681.922,12.459,0.000,90.000,90.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9515, "bigboxtemp1", "redbrickground256", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1973.629,-1688.471,12.459,0.000,90.000,180.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9515, "bigboxtemp1", "redbrickground256", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1973.629,-1698.093,12.459,0.000,90.000,180.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9515, "bigboxtemp1", "redbrickground256", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1976.520,-1705.073,12.456,0.000,90.000,225.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9515, "bigboxtemp1", "redbrickground256", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1983.330,-1711.883,12.456,0.000,90.000,225.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9515, "bigboxtemp1", "redbrickground256", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1986.219,-1718.873,12.459,0.000,90.000,180.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9515, "bigboxtemp1", "redbrickground256", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1987.210,-1725.433,12.459,0.000,90.000,270.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9515, "bigboxtemp1", "redbrickground256", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1977.581,-1725.433,12.459,0.000,90.000,270.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9515, "bigboxtemp1", "redbrickground256", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1967.962,-1725.433,12.459,0.000,90.000,270.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9515, "bigboxtemp1", "redbrickground256", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1961.402,-1725.433,12.459,0.000,90.000,360.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9515, "bigboxtemp1", "redbrickground256", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1961.402,-1737.614,12.459,0.000,90.000,360.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9515, "bigboxtemp1", "redbrickground256", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1961.402,-1733.213,12.462,0.000,90.000,360.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9515, "bigboxtemp1", "redbrickground256", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1961.402,-1715.803,12.462,0.000,90.000,360.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9515, "bigboxtemp1", "redbrickground256", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1958.342,-1709.232,12.462,0.000,90.000,450.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9515, "bigboxtemp1", "redbrickground256", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1955.192,-1709.232,12.456,0.000,90.000,450.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9515, "bigboxtemp1", "redbrickground256", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1980.930,-1675.381,12.456,0.000,90.000,180.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9515, "bigboxtemp1", "redbrickground256", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1980.930,-1665.751,12.456,0.000,90.000,180.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9515, "bigboxtemp1", "redbrickground256", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1980.930,-1656.121,12.456,0.000,90.000,180.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9515, "bigboxtemp1", "redbrickground256", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1980.470,-1650.181,12.459,0.000,90.000,225.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9515, "bigboxtemp1", "redbrickground256", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1989.608,-1659.319,12.459,0.000,90.000,225.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9515, "bigboxtemp1", "redbrickground256", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1987.260,-1656.971,12.462,0.000,90.000,225.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9515, "bigboxtemp1", "redbrickground256", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1973.669,-1643.380,12.462,0.000,90.000,225.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9515, "bigboxtemp1", "redbrickground256", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1966.860,-1636.571,12.462,0.000,90.000,225.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9515, "bigboxtemp1", "redbrickground256", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1959.878,-1633.677,12.465,0.000,90.000,270.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9515, "bigboxtemp1", "redbrickground256", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1956.437,-1633.677,12.462,0.000,90.000,270.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9515, "bigboxtemp1", "redbrickground256", 0x00000000);

	// suoliukai
	tmpobjid = CreateDynamicObject(1280,1956.498,-1675.826,12.900,0.000,0.000,180.000,-1,-1,-1,100.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14651, "ab_trukstpd", "Bow_bar_flooring", 0x00000000);
	tmpobjid = CreateDynamicObject(1280,1956.498,-1673.256,12.900,0.000,0.000,180.000,-1,-1,-1,100.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14651, "ab_trukstpd", "Bow_bar_flooring", 0x00000000);
	tmpobjid = CreateDynamicObject(1280,1956.498,-1663.375,12.900,0.000,0.000,180.000,-1,-1,-1,100.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14651, "ab_trukstpd", "Bow_bar_flooring", 0x00000000);
	tmpobjid = CreateDynamicObject(1280,1965.078,-1652.744,12.900,0.000,0.000,90.000,-1,-1,-1,100.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14651, "ab_trukstpd", "Bow_bar_flooring", 0x00000000);
	tmpobjid = CreateDynamicObject(1280,1973.649,-1652.744,12.900,0.000,0.000,90.000,-1,-1,-1,100.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14651, "ab_trukstpd", "Bow_bar_flooring", 0x00000000);
	tmpobjid = CreateDynamicObject(1280,1958.352,-1632.211,12.900,0.000,0.000,90.000,-1,-1,-1,100.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14651, "ab_trukstpd", "Bow_bar_flooring", 0x00000000);
	tmpobjid = CreateDynamicObject(1280,1971.278,-1639.042,12.900,0.000,0.000,45.000,-1,-1,-1,100.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14651, "ab_trukstpd", "Bow_bar_flooring", 0x00000000);
	tmpobjid = CreateDynamicObject(1280,1981.000,-1648.765,12.900,0.000,0.000,45.000,-1,-1,-1,100.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14651, "ab_trukstpd", "Bow_bar_flooring", 0x00000000);
	tmpobjid = CreateDynamicObject(1280,1982.361,-1665.126,12.900,0.000,0.000,0.000,-1,-1,-1,100.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14651, "ab_trukstpd", "Bow_bar_flooring", 0x00000000);
	tmpobjid = CreateDynamicObject(1280,1982.361,-1676.736,12.900,0.000,0.000,0.000,-1,-1,-1,100.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14651, "ab_trukstpd", "Bow_bar_flooring", 0x00000000);
	tmpobjid = CreateDynamicObject(1280,1979.410,-1673.336,12.900,0.000,0.000,180.000,-1,-1,-1,100.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14651, "ab_trukstpd", "Bow_bar_flooring", 0x00000000);
	tmpobjid = CreateDynamicObject(1280,1979.430,-1670.796,12.900,0.000,0.000,180.000,-1,-1,-1,100.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14651, "ab_trukstpd", "Bow_bar_flooring", 0x00000000);
	tmpobjid = CreateDynamicObject(1280,1965.880,-1683.437,12.900,0.000,0.000,270.000,-1,-1,-1,100.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14651, "ab_trukstpd", "Bow_bar_flooring", 0x00000000);
	tmpobjid = CreateDynamicObject(1280,1975.041,-1695.977,12.900,0.000,0.000,360.000,-1,-1,-1,100.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14651, "ab_trukstpd", "Bow_bar_flooring", 0x00000000);
	tmpobjid = CreateDynamicObject(1280,1980.571,-1707.021,12.900,0.000,0.000,405.000,-1,-1,-1,100.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14651, "ab_trukstpd", "Bow_bar_flooring", 0x00000000);
	tmpobjid = CreateDynamicObject(1280,1982.871,-1723.971,12.900,0.000,0.000,450.000,-1,-1,-1,100.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14651, "ab_trukstpd", "Bow_bar_flooring", 0x00000000);
	tmpobjid = CreateDynamicObject(1280,1972.341,-1726.932,12.900,0.000,0.000,630.000,-1,-1,-1,100.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14651, "ab_trukstpd", "Bow_bar_flooring", 0x00000000);
	tmpobjid = CreateDynamicObject(1280,1962.942,-1732.142,12.900,0.000,0.000,720.000,-1,-1,-1,100.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14651, "ab_trukstpd", "Bow_bar_flooring", 0x00000000);
	tmpobjid = CreateDynamicObject(1280,1959.911,-1719.001,12.900,0.000,0.000,900.000,-1,-1,-1,100.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14651, "ab_trukstpd", "Bow_bar_flooring", 0x00000000);
	tmpobjid = CreateDynamicObject(1280,1956.731,-1710.761,12.900,0.000,0.000,990.000,-1,-1,-1,100.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14651, "ab_trukstpd", "Bow_bar_flooring", 0x00000000);

	// siena
	tmpobjid = CreateDynamicObject(19377,1954.987,-1625.384,8.648,69.899,0.000,90.000,-1,-1,-1,200.000,200.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);
	tmpobjid = CreateDynamicObject(19377,1988.345,-1625.384,8.656,69.899,0.000,270.000,-1,-1,-1,200.000,200.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);
	tmpobjid = CreateDynamicObject(19377,1980.254,-1625.386,9.731,0.000,0.000,90.000,-1,-1,-1,200.000,200.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);
	tmpobjid = CreateDynamicObject(19377,1963.074,-1625.386,9.731,0.000,0.000,90.000,-1,-1,-1,200.000,200.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);
	tmpobjid = CreateDynamicObject(19377,1970.778,-1625.383,9.734,0.000,0.000,90.000,-1,-1,-1,200.000,200.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);

	// po vandeniu
	tmpobjid = CreateDynamicObject(19455,1967.719,-1677.423,11.254,0.000,135.000,90.000,-1,-1,-1,70.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "stones256128", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1970.999,-1677.402,11.236,0.000,135.000,90.000,-1,-1,-1,70.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "stones256128", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1976.437,-1671.712,11.240,0.000,135.000,180.000,-1,-1,-1,70.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "stones256128", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1976.437,-1662.102,11.240,0.000,135.000,180.000,-1,-1,-1,70.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "stones256128", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1970.868,-1658.312,11.240,0.000,135.000,270.000,-1,-1,-1,70.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "stones256128", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1961.228,-1658.312,11.240,0.000,135.000,270.000,-1,-1,-1,70.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "stones256128", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1962.402,-1664.052,11.240,0.000,135.000,360.000,-1,-1,-1,70.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "stones256128", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1962.402,-1673.673,11.240,0.000,135.000,360.000,-1,-1,-1,70.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "stones256128", 0x00000000);
	tmpobjid = CreateDynamicObject(19435,1962.644,-1677.032,11.915,45.000,90.000,495.000,-1,-1,-1,70.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "stones256128", 0x00000000);
	tmpobjid = CreateDynamicObject(19435,1976.107,-1677.317,11.908,45.000,90.000,585.000,-1,-1,-1,70.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "stones256128", 0x00000000);
	tmpobjid = CreateDynamicObject(19435,1976.469,-1658.737,11.915,45.000,90.000,315.000,-1,-1,-1,70.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "stones256128", 0x00000000);
	tmpobjid = CreateDynamicObject(19435,1962.606,-1658.583,11.908,45.000,90.000,405.000,-1,-1,-1,70.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "stones256128", 0x00000000);
	tmpobjid = CreateDynamicObject(19377,1966.304,-1672.066,11.457,0.000,90.000,90.000,-1,-1,-1,70.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "stones256128", 0x00000000);
	tmpobjid = CreateDynamicObject(19377,1975.934,-1672.066,11.457,0.000,90.000,90.000,-1,-1,-1,70.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "stones256128", 0x00000000);
	tmpobjid = CreateDynamicObject(19377,1975.934,-1661.567,11.457,0.000,90.000,90.000,-1,-1,-1,70.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "stones256128", 0x00000000);
	tmpobjid = CreateDynamicObject(19377,1966.304,-1661.567,11.457,0.000,90.000,90.000,-1,-1,-1,70.000,70.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "stones256128", 0x00000000);

	tmpobjid = CreateDynamicObject(19603,1974.664,-1660.507,11.601,0.000,0.000,0.000,-1,-1,-1,70.000,50.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 19480, "signsurf", "sign", 0x00000000);
	tmpobjid = CreateDynamicObject(19603,1969.664,-1660.507,11.601,0.000,0.000,0.000,-1,-1,-1,70.000,50.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 19480, "signsurf", "sign", 0x00000000);
	tmpobjid = CreateDynamicObject(19603,1964.673,-1660.507,11.601,0.000,0.000,0.000,-1,-1,-1,70.000,50.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 19480, "signsurf", "sign", 0x00000000);
	tmpobjid = CreateDynamicObject(19603,1964.673,-1665.507,11.601,0.000,0.000,0.000,-1,-1,-1,70.000,50.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 19480, "signsurf", "sign", 0x00000000);
	tmpobjid = CreateDynamicObject(19603,1964.673,-1670.508,11.601,0.000,0.000,0.000,-1,-1,-1,70.000,50.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 19480, "signsurf", "sign", 0x00000000);
	tmpobjid = CreateDynamicObject(19603,1964.673,-1675.509,11.601,0.000,0.000,0.000,-1,-1,-1,70.000,50.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 19480, "signsurf", "sign", 0x00000000);
	tmpobjid = CreateDynamicObject(19603,1969.665,-1675.509,11.601,0.000,0.000,0.000,-1,-1,-1,70.000,50.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 19480, "signsurf", "sign", 0x00000000);
	tmpobjid = CreateDynamicObject(19603,1974.677,-1675.509,11.601,0.000,0.000,0.000,-1,-1,-1,70.000,50.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 19480, "signsurf", "sign", 0x00000000);
	tmpobjid = CreateDynamicObject(19603,1974.677,-1670.489,11.601,0.000,0.000,0.000,-1,-1,-1,70.000,50.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 19480, "signsurf", "sign", 0x00000000);
	tmpobjid = CreateDynamicObject(19603,1974.677,-1665.488,11.601,0.000,0.000,0.000,-1,-1,-1,70.000,50.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 19480, "signsurf", "sign", 0x00000000);
	tmpobjid = CreateDynamicObject(19603,1969.658,-1665.488,11.601,0.000,0.000,0.000,-1,-1,-1,70.000,50.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 19480, "signsurf", "sign", 0x00000000);
	tmpobjid = CreateDynamicObject(19603,1969.658,-1670.367,11.601,0.000,0.000,0.000,-1,-1,-1,70.000,50.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 19480, "signsurf", "sign", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// sviestuvai
	tmpobjid = CreateDynamicObject(1223,1955.997,-1707.250,12.464,0.000,0.000,-90.000,-1,-1,-1,130.000,110.000);
	tmpobjid = CreateDynamicObject(1223,1968.907,-1723.422,12.464,0.000,0.000,-90.000,-1,-1,-1,130.000,110.000);
	tmpobjid = CreateDynamicObject(1223,1989.809,-1723.422,12.464,0.000,0.000,-90.000,-1,-1,-1,130.000,110.000);
	tmpobjid = CreateDynamicObject(1223,1956.048,-1679.932,12.464,0.000,0.000,-90.000,-1,-1,-1,130.000,110.000);
	tmpobjid = CreateDynamicObject(1223,1988.838,-1679.932,12.464,0.000,0.000,-90.000,-1,-1,-1,130.000,110.000);
	tmpobjid = CreateDynamicObject(1223,1956.198,-1631.693,12.464,0.000,0.000,-90.000,-1,-1,-1,130.000,110.000);
	tmpobjid = CreateDynamicObject(1223,1969.509,-1683.942,12.464,0.000,0.000,90.000,-1,-1,-1,130.000,110.000);
	tmpobjid = CreateDynamicObject(1223,1977.059,-1727.464,12.464,0.000,0.000,90.000,-1,-1,-1,130.000,110.000);
	tmpobjid = CreateDynamicObject(1223,1963.448,-1737.394,12.464,0.000,0.000,180.000,-1,-1,-1,130.000,110.000);
	tmpobjid = CreateDynamicObject(1223,1959.407,-1717.004,12.464,0.000,0.000,360.000,-1,-1,-1,130.000,110.000);
	tmpobjid = CreateDynamicObject(1223,1971.549,-1698.484,12.464,0.000,0.000,360.000,-1,-1,-1,130.000,110.000);
	tmpobjid = CreateDynamicObject(1223,1978.939,-1668.795,12.464,0.000,0.000,360.000,-1,-1,-1,130.000,110.000);
	tmpobjid = CreateDynamicObject(1223,1987.593,-1660.140,12.464,0.000,0.000,405.000,-1,-1,-1,130.000,110.000);
	tmpobjid = CreateDynamicObject(1223,1966.761,-1639.308,12.464,0.000,0.000,405.000,-1,-1,-1,130.000,110.000);
	tmpobjid = CreateDynamicObject(1223,1979.136,-1645.997,12.464,0.000,0.000,585.000,-1,-1,-1,130.000,110.000);
	tmpobjid = CreateDynamicObject(1223,1982.580,-1708.373,12.464,0.000,0.000,585.000,-1,-1,-1,130.000,110.000);
	tmpobjid = CreateDynamicObject(1223,1956.048,-1667.201,12.464,0.000,0.000,0.000,-1,-1,-1,130.000,110.000);
	tmpobjid = CreateDynamicObject(1223,1963.218,-1652.241,12.464,0.000,0.000,-90.000,-1,-1,-1,130.000,110.000);

	// vanduo
	tmpobjid = CreateDynamicObject(10444,1970.549,-1668.940,12.151,0.000,0.000,0.000,-1,-1,-1,150.000,100.000);
	tmpobjid = CreateDynamicObject(10444,1964.077,-1668.940,12.154,0.000,0.000,0.000,-1,-1,-1,150.000,100.000);
	tmpobjid = CreateDynamicObject(10444,1964.077,-1668.940,12.154,0.000,0.000,0.000,-1,-1,-1,150.000,100.000);
	tmpobjid = CreateDynamicObject(10444,1970.549,-1668.940,12.151,0.000,0.000,0.000,-1,-1,-1,150.000,100.000);

	// medziai
	tmpobjid = CreateDynamicObject(617,1958.289,-1703.334,12.325,0.000,0.000,0.000,-1,-1,-1,200.000,180.000);
	tmpobjid = CreateDynamicObject(617,1974.919,-1716.095,12.325,0.000,0.000,90.000,-1,-1,-1,200.000,180.000);
	tmpobjid = CreateDynamicObject(617,1985.188,-1732.725,12.325,0.000,0.000,180.000,-1,-1,-1,200.000,180.000);
	tmpobjid = CreateDynamicObject(617,1955.299,-1726.125,12.325,0.000,0.000,270.000,-1,-1,-1,200.000,180.000);
	tmpobjid = CreateDynamicObject(617,1957.199,-1687.355,12.325,0.000,0.000,270.000,-1,-1,-1,200.000,180.000);
	tmpobjid = CreateDynamicObject(617,1982.849,-1687.355,12.325,0.000,0.000,360.000,-1,-1,-1,200.000,180.000);
	tmpobjid = CreateDynamicObject(617,1982.849,-1639.165,12.325,0.000,0.000,450.000,-1,-1,-1,200.000,180.000);
	tmpobjid = CreateDynamicObject(617,1960.638,-1639.165,12.325,0.000,0.000,540.000,-1,-1,-1,200.000,180.000);

	// medziai
	tmpobjid = CreateDynamicObject(672,1988.617,-1647.993,13.464,0.000,0.000,0.000,-1,-1,-1,190.0,170.0);
	tmpobjid = CreateDynamicObject(672,1986.406,-1670.613,13.464,0.000,0.000,90.000,-1,-1,-1,190.0,170.0);
	tmpobjid = CreateDynamicObject(672,1981.066,-1700.052,13.464,0.000,0.000,180.000,-1,-1,-1,190.0,170.0);
	//tmpobjid = CreateDynamicObject(672,1969.336,-1735.712,13.464,0.000,0.000,180.000,-1,-1,-1,190.0,170.0);
	tmpobjid = CreateDynamicObject(672,1969.336,-1707.752,13.464,0.000,0.000,180.000,-1,-1,-1,190.0,170.0);
	tmpobjid = CreateDynamicObject(672,1954.206,-1656.692,13.254,0.000,0.000,270.000,-1,-1,-1,190.0,170.0);
	tmpobjid = CreateDynamicObject(672,1987.447,-1694.242,13.464,0.000,0.000,135.599,-1,-1,-1,190.0,170.0);

	// medziai
	tmpobjid = CreateDynamicObject(715,1971.984,-1631.717,20.809,0.000,0.000,-128.899,-1,-1,-1,200.000,180.000);
	tmpobjid = CreateDynamicObject(715,1967.256,-1649.092,20.809,0.000,0.000,-172.400,-1,-1,-1,200.000,180.000);
	tmpobjid = CreateDynamicObject(715,1963.136,-1695.786,20.809,0.000,0.000,-172.400,-1,-1,-1,200.000,180.000);
	tmpobjid = CreateDynamicObject(715,1988.484,-1707.467,20.809,0.000,0.000,127.499,-1,-1,-1,200.000,180.000);

	// medziai
	tmpobjid = CreateDynamicObject(886,1961.927,-1656.776,12.514,0.000,0.000,0.000,-1,-1,-1,200.000,180.000);
	tmpobjid = CreateDynamicObject(886,1971.167,-1656.776,12.514,0.000,0.000,90.000,-1,-1,-1,200.000,180.000);
	tmpobjid = CreateDynamicObject(886,1974.847,-1679.416,12.514,0.000,0.000,90.000,-1,-1,-1,200.000,180.000);
	tmpobjid = CreateDynamicObject(886,1954.487,-1670.046,12.514,0.000,0.000,90.000,-1,-1,-1,200.000,180.000);

	// krumai
	tmpobjid = CreateDynamicObject(805,1957.940,-1702.709,12.859,0.000,0.000,0.000,-1,-1,-1,150.000,130.000);
	tmpobjid = CreateDynamicObject(805,1955.410,-1693.959,12.859,0.000,0.000,-14.699,-1,-1,-1,150.000,130.000);
	tmpobjid = CreateDynamicObject(805,1957.222,-1687.053,12.859,0.000,0.000,-14.699,-1,-1,-1,150.000,130.000);
	tmpobjid = CreateDynamicObject(805,1966.233,-1690.771,12.859,0.000,0.000,-50.899,-1,-1,-1,150.000,130.000);
	tmpobjid = CreateDynamicObject(805,1981.968,-1687.428,12.859,0.000,0.000,-50.899,-1,-1,-1,150.000,130.000);
	tmpobjid = CreateDynamicObject(805,1956.119,-1714.130,12.859,0.000,0.000,-50.899,-1,-1,-1,150.000,130.000);
	tmpobjid = CreateDynamicObject(805,1953.829,-1736.202,12.859,0.000,0.000,-89.999,-1,-1,-1,150.000,130.000);
	tmpobjid = CreateDynamicObject(805,1956.689,-1737.792,12.859,0.000,0.000,0.000,-1,-1,-1,150.000,130.000);
	tmpobjid = CreateDynamicObject(805,1984.889,-1734.542,12.859,0.000,0.000,0.000,-1,-1,-1,150.000,130.000);
	tmpobjid = CreateDynamicObject(805,1988.480,-1708.191,12.859,0.000,0.000,0.000,-1,-1,-1,150.000,130.000);
	tmpobjid = CreateDynamicObject(805,1982.939,-1639.101,12.859,0.000,0.000,0.000,-1,-1,-1,150.000,130.000);
	tmpobjid = CreateDynamicObject(805,1987.719,-1633.301,12.859,0.000,0.000,-13.699,-1,-1,-1,150.000,130.000);
	tmpobjid = CreateDynamicObject(805,1960.509,-1639.112,12.859,0.000,0.000,-13.699,-1,-1,-1,150.000,130.000);
	tmpobjid = CreateDynamicObject(805,1954.518,-1644.898,12.859,0.000,0.000,35.000,-1,-1,-1,150.000,130.000);
	tmpobjid = CreateDynamicObject(805,1955.681,-1629.141,12.859,0.000,0.000,35.000,-1,-1,-1,150.000,130.000);

	tmpobjid = CreateDynamicObject(805,1957.940,-1702.709,12.859,0.000,0.000,0.000,-1,-1,-1,150.000,130.000);
	tmpobjid = CreateDynamicObject(805,1955.410,-1693.959,12.859,0.000,0.000,-14.699,-1,-1,-1,150.000,130.000);
	tmpobjid = CreateDynamicObject(805,1957.222,-1687.053,12.859,0.000,0.000,-14.699,-1,-1,-1,150.000,130.000);
	tmpobjid = CreateDynamicObject(805,1966.233,-1690.771,12.859,0.000,0.000,-50.899,-1,-1,-1,150.000,130.000);
	tmpobjid = CreateDynamicObject(805,1981.968,-1687.428,12.859,0.000,0.000,-50.899,-1,-1,-1,150.000,130.000);
	tmpobjid = CreateDynamicObject(805,1968.436,-1718.218,12.859,0.000,0.000,-50.899,-1,-1,-1,150.000,130.000);
	tmpobjid = CreateDynamicObject(805,1956.119,-1714.130,12.859,0.000,0.000,-50.899,-1,-1,-1,150.000,130.000);
	tmpobjid = CreateDynamicObject(805,1955.549,-1726.001,12.859,0.000,0.000,-89.999,-1,-1,-1,150.000,130.000);
	tmpobjid = CreateDynamicObject(805,1953.829,-1736.202,12.859,0.000,0.000,-89.999,-1,-1,-1,150.000,130.000);
	tmpobjid = CreateDynamicObject(805,1956.689,-1737.792,12.859,0.000,0.000,0.000,-1,-1,-1,150.000,130.000);
	tmpobjid = CreateDynamicObject(805,1984.889,-1734.542,12.859,0.000,0.000,0.000,-1,-1,-1,150.000,130.000);
	tmpobjid = CreateDynamicObject(805,1988.480,-1708.191,12.859,0.000,0.000,0.000,-1,-1,-1,150.000,130.000);
	tmpobjid = CreateDynamicObject(805,1982.939,-1639.101,12.859,0.000,0.000,0.000,-1,-1,-1,150.000,130.000);
	tmpobjid = CreateDynamicObject(805,1987.719,-1633.301,12.859,0.000,0.000,-13.699,-1,-1,-1,150.000,130.000);
	tmpobjid = CreateDynamicObject(805,1960.509,-1639.112,12.859,0.000,0.000,-13.699,-1,-1,-1,150.000,130.000);
	tmpobjid = CreateDynamicObject(805,1954.518,-1644.898,12.859,0.000,0.000,35.000,-1,-1,-1,150.000,130.000);
	tmpobjid = CreateDynamicObject(805,1955.681,-1629.141,12.859,0.000,0.000,35.000,-1,-1,-1,150.000,130.000);

	// akmenys
	tmpobjid = CreateDynamicObject(748,1961.933,-1658.674,12.260,0.000,0.000,0.000,-1,-1,-1,120.000,100.000);
	tmpobjid = CreateDynamicObject(748,1963.979,-1657.744,12.260,0.000,0.000,-71.099,-1,-1,-1,120.000,100.000);
	tmpobjid = CreateDynamicObject(748,1961.933,-1669.564,12.260,0.000,0.000,170.199,-1,-1,-1,120.000,100.000);
	tmpobjid = CreateDynamicObject(748,1976.772,-1676.482,12.190,0.000,0.000,350.200,-1,-1,-1,120.000,100.000);

	tmpobjid = CreateDynamicObject(906,1967.331,-1667.719,11.128,0.000,0.000,0.000,-1,-1,-1,120.000,100.000);
	tmpobjid = CreateDynamicObject(9915,1962.662,-1660.657,-2.393,0.000,0.000,-37.399,-1,-1,-1,120.000,100.000);
}