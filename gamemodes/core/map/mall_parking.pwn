#include <YSI\y_hooks>

hook OnPlayerConnect(playerid)
{
	RemoveBuildingForPlayer(playerid, 5536, 1866.328, -1789.781, 20.945, 0.250);
	RemoveBuildingForPlayer(playerid, 1308, 1831.468, -1798.203, 12.703, 0.250);
	RemoveBuildingForPlayer(playerid, 1308, 1867.718, -1798.203, 12.703, 0.250);
	RemoveBuildingForPlayer(playerid, 5397, 1866.328, -1789.781, 20.945, 0.250);
	RemoveBuildingForPlayer(playerid, 5681, 1921.484, -1778.914, 18.578, 0.250);
}

hook OnGameModeInit()
{
	new tmpobjid;

	tmpobjid = CreateObject(8661,1853.286,-1796.159,12.544,0.000,0.000,-13.500,250.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateObject(8661,1884.022,-1803.649,12.542,0.000,0.000,-13.750,250.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateObject(8661,1841.541,-1780.335,12.542,0.000,0.000,-90.000,250.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateObject(8661,1861.500,-1782.206,12.542,0.000,0.000,-90.000,250.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateObject(8661,1891.127,-1782.219,12.538,0.000,0.000,-90.000,250.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateObject(8661,1878.503,-1782.140,12.540,0.000,0.000,-90.000,250.0);
	SetObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateObject(8661,1855.469,-1788.075,12.552,0.000,0.000,0.000,250.0);
	SetObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	tmpobjid = CreateObject(8661,1876.929,-1788.075,12.555,0.000,0.000,0.000,250.0);
	SetObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);

	tmpobjid = CreateDynamicObject(19377,1853.496,-1767.122,12.466,0.000,90.000,0.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	tmpobjid = CreateDynamicObject(19377,1884.986,-1767.122,12.466,0.000,90.000,0.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	tmpobjid = CreateDynamicObject(19377,1891.656,-1773.262,12.469,0.000,90.000,0.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	tmpobjid = CreateDynamicObject(19377,1881.156,-1773.262,12.469,0.000,90.000,0.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	tmpobjid = CreateDynamicObject(19377,1870.665,-1773.262,12.469,0.000,90.000,0.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	tmpobjid = CreateDynamicObject(19377,1860.175,-1773.262,12.469,0.000,90.000,0.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	tmpobjid = CreateDynamicObject(19377,1849.703,-1773.262,12.469,0.000,90.000,0.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	tmpobjid = CreateDynamicObject(19377,1840.713,-1773.262,12.472,0.000,90.000,0.000,-1,-1,-1,180.000,160.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1895.486,-1763.196,11.151,0.000,0.000,0.000,-1,-1,-1,200.000,170.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4992, "airportdetail", "hedge2", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1874.536,-1763.196,11.151,0.000,0.000,0.000,-1,-1,-1,200.000,170.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4992, "airportdetail", "hedge2", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1863.945,-1763.196,11.151,0.000,0.000,0.000,-1,-1,-1,200.000,170.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4992, "airportdetail", "hedge2", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1866.498,-1763.193,11.154,0.000,0.000,0.000,-1,-1,-1,200.000,170.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4992, "airportdetail", "hedge2", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1842.928,-1763.193,11.154,0.000,0.000,0.000,-1,-1,-1,200.000,170.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4992, "airportdetail", "hedge2", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1837.220,-1763.190,11.157,0.000,0.000,0.000,-1,-1,-1,200.000,170.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4992, "airportdetail", "hedge2", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1832.699,-1767.691,11.160,0.000,0.000,90.000,-1,-1,-1,200.000,170.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4992, "airportdetail", "hedge2", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1832.699,-1777.680,11.160,0.000,0.000,90.000,-1,-1,-1,200.000,170.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4992, "airportdetail", "hedge2", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1832.699,-1787.680,11.160,0.000,0.000,90.000,-1,-1,-1,200.000,170.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4992, "airportdetail", "hedge2", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1832.696,-1796.548,11.163,0.000,0.000,90.000,-1,-1,-1,200.000,170.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4992, "airportdetail", "hedge2", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1837.922,-1802.008,11.163,0.000,0.000,166.699,-1,-1,-1,200.000,170.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4992, "airportdetail", "hedge2", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1847.653,-1804.309,11.163,0.000,0.000,166.699,-1,-1,-1,200.000,170.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4992, "airportdetail", "hedge2", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1857.376,-1806.608,11.163,0.000,0.000,166.699,-1,-1,-1,200.000,170.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4992, "airportdetail", "hedge2", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1867.097,-1808.907,11.163,0.000,0.000,166.699,-1,-1,-1,200.000,170.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4992, "airportdetail", "hedge2", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1876.829,-1811.207,11.163,0.000,0.000,166.699,-1,-1,-1,200.000,170.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4992, "airportdetail", "hedge2", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1886.561,-1813.507,11.163,0.000,0.000,166.699,-1,-1,-1,200.000,170.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4992, "airportdetail", "hedge2", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1895.157,-1815.537,11.166,0.000,0.000,166.699,-1,-1,-1,200.000,170.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4992, "airportdetail", "hedge2", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1900.379,-1812.171,11.160,0.000,0.000,90.000,-1,-1,-1,200.000,170.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4992, "airportdetail", "hedge2", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1900.379,-1802.171,11.160,0.000,0.000,90.000,-1,-1,-1,200.000,170.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4992, "airportdetail", "hedge2", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1900.379,-1792.180,11.160,0.000,0.000,90.000,-1,-1,-1,200.000,170.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4992, "airportdetail", "hedge2", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1900.379,-1782.180,11.160,0.000,0.000,90.000,-1,-1,-1,200.000,170.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4992, "airportdetail", "hedge2", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1900.379,-1772.180,11.160,0.000,0.000,90.000,-1,-1,-1,200.000,170.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4992, "airportdetail", "hedge2", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1900.382,-1767.686,11.163,0.000,0.000,90.000,-1,-1,-1,200.000,170.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4992, "airportdetail", "hedge2", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1881.319,-1784.162,11.154,0.000,0.000,0.000,-1,-1,-1,200.000,170.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4992, "airportdetail", "hedge2", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1851.128,-1784.162,11.154,0.000,0.000,0.000,-1,-1,-1,200.000,170.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4992, "airportdetail", "hedge2", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1861.119,-1784.162,11.154,0.000,0.000,0.000,-1,-1,-1,200.000,170.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4992, "airportdetail", "hedge2", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1871.349,-1784.162,11.154,0.000,0.000,0.000,-1,-1,-1,200.000,170.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4992, "airportdetail", "hedge2", 0x00000000);
	tmpobjid = CreateDynamicObject(18766,1869.392,-1784.159,11.157,0.000,0.000,0.000,-1,-1,-1,200.000,170.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4992, "airportdetail", "hedge2", 0x00000000);


	tmpobjid = CreateDynamicObject(19455,1882.592,-1784.221,12.494,0.000,90.000,270.000,-1,-1,-1,140.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1850.001,-1784.221,12.494,0.000,90.000,270.000,-1,-1,-1,140.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1859.619,-1784.221,12.494,0.000,90.000,270.000,-1,-1,-1,140.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1872.990,-1784.221,12.494,0.000,90.000,270.000,-1,-1,-1,140.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	tmpobjid = CreateDynamicObject(19455,1867.640,-1784.221,12.497,0.000,90.000,270.000,-1,-1,-1,140.000,120.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);

	
	tmpobjid = CreateDynamicObject(19325,1853.560,-1763.561,12.583,0.000,90.000,270.000,-1,-1,-1,70.000,50.000);
	SetDynamicObjectMaterialText(tmpobjid, 0, "ENTERANCE", 130, "Ariel", 80, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19325,1884.620,-1763.561,12.583,0.000,90.000,450.000,-1,-1,-1,70.000,50.000);
	SetDynamicObjectMaterialText(tmpobjid, 0, "EXIT", 130, "Ariel", 80, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19325,1882.949,-1778.840,12.583,0.000,90.000,270.000,-1,-1,-1,70.000,50.000);
	SetDynamicObjectMaterialText(tmpobjid, 0, "PARKING", 130, "Ariel", 80, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19325,1873.539,-1778.840,12.583,0.000,90.000,270.000,-1,-1,-1,70.000,50.000);
	SetDynamicObjectMaterialText(tmpobjid, 0, "PARKING", 130, "Ariel", 80, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19325,1865.128,-1778.840,12.583,0.000,90.000,270.000,-1,-1,-1,70.000,50.000);
	SetDynamicObjectMaterialText(tmpobjid, 0, "PARKING", 130, "Ariel", 80, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19325,1857.157,-1778.840,12.583,0.000,90.000,270.000,-1,-1,-1,70.000,50.000);
	SetDynamicObjectMaterialText(tmpobjid, 0, "PARKING", 130, "Ariel", 80, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19325,1847.996,-1778.840,12.583,0.000,90.000,270.000,-1,-1,-1,70.000,50.000);
	SetDynamicObjectMaterialText(tmpobjid, 0, "PARKING", 130, "Ariel", 80, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19325,1847.996,-1789.411,12.583,0.000,90.000,89.999,-1,-1,-1,70.000,50.000);
	SetDynamicObjectMaterialText(tmpobjid, 0, "PARKING", 130, "Ariel", 80, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19325,1857.406,-1789.411,12.583,0.000,90.000,89.999,-1,-1,-1,70.000,50.000);
	SetDynamicObjectMaterialText(tmpobjid, 0, "PARKING", 130, "Ariel", 80, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19325,1865.817,-1789.411,12.583,0.000,90.000,89.999,-1,-1,-1,70.000,50.000);
	SetDynamicObjectMaterialText(tmpobjid, 0, "PARKING", 130, "Ariel", 80, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19325,1873.788,-1789.411,12.583,0.000,90.000,89.999,-1,-1,-1,70.000,50.000);
	SetDynamicObjectMaterialText(tmpobjid, 0, "PARKING", 130, "Ariel", 80, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19325,1882.949,-1789.411,12.583,0.000,90.000,89.999,-1,-1,-1,70.000,50.000);
	SetDynamicObjectMaterialText(tmpobjid, 0, "PARKING", 130, "Ariel", 80, 1, 0xFFFFFFFF, 0x00000000, 1);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	tmpobjid = CreateDynamicObject(1226,1874.268,-1769.417,16.349,0.000,0.000,90.000,-1,-1,-1,90.000,90.000);
	tmpobjid = CreateDynamicObject(1226,1842.777,-1769.417,16.349,0.000,0.000,90.000,-1,-1,-1,90.000,90.000);
	tmpobjid = CreateDynamicObject(1226,1894.738,-1769.417,16.349,0.000,0.000,90.000,-1,-1,-1,90.000,90.000);
	tmpobjid = CreateDynamicObject(1226,1885.037,-1786.867,16.349,0.000,0.000,90.000,-1,-1,-1,90.000,90.000);
	tmpobjid = CreateDynamicObject(1226,1848.668,-1786.867,16.349,0.000,0.000,90.000,-1,-1,-1,90.000,90.000);
	tmpobjid = CreateDynamicObject(1226,1866.668,-1786.867,16.349,0.000,0.000,90.000,-1,-1,-1,90.000,90.000);
	tmpobjid = CreateDynamicObject(1226,1876.929,-1781.577,16.349,0.000,0.000,270.000,-1,-1,-1,90.000,90.000);
	tmpobjid = CreateDynamicObject(1226,1856.478,-1781.577,16.349,0.000,0.000,270.000,-1,-1,-1,90.000,90.000);
	tmpobjid = CreateDynamicObject(1226,1856.478,-1797.157,16.349,0.000,0.000,270.000,-1,-1,-1,90.000,90.000);
	tmpobjid = CreateDynamicObject(1226,1878.929,-1797.157,16.349,0.000,0.000,270.000,-1,-1,-1,90.000,90.000);
	tmpobjid = CreateDynamicObject(617,1894.784,-1802.089,12.264,0.000,0.000,0.000,-1,-1,-1,150.000,120.000);
	tmpobjid = CreateDynamicObject(617,1879.544,-1808.169,12.264,0.000,0.000,90.000,-1,-1,-1,150.000,120.000);
	tmpobjid = CreateDynamicObject(617,1897.114,-1766.118,12.264,0.000,0.000,90.000,-1,-1,-1,150.000,120.000);
	tmpobjid = CreateDynamicObject(617,1866.554,-1766.118,12.264,0.000,0.000,66.600,-1,-1,-1,150.000,120.000);
	tmpobjid = CreateDynamicObject(617,1835.448,-1767.269,12.244,0.000,0.000,35.900,-1,-1,-1,150.000,120.000);
	tmpobjid = CreateDynamicObject(617,1862.475,-1804.604,12.244,0.000,0.000,35.900,-1,-1,-1,150.000,120.000);
	tmpobjid = CreateDynamicObject(672,1846.434,-1800.700,13.133,0.000,0.000,78.299,-1,-1,-1,150.000,120.000);
	tmpobjid = CreateDynamicObject(672,1872.694,-1801.860,13.133,0.000,0.000,78.299,-1,-1,-1,150.000,120.000);
	tmpobjid = CreateDynamicObject(672,1887.099,-1804.843,13.133,0.000,0.000,113.799,-1,-1,-1,150.000,120.000);

	tmpobjid = CreateDynamicObject(19957,1848.325,-1762.353,12.199,0.000,0.000,180.000,-1,-1,-1,50.000,40.000);
	tmpobjid = CreateDynamicObject(19957,1858.694,-1762.353,12.199,0.000,0.000,180.000,-1,-1,-1,50.000,40.000);
	tmpobjid = CreateDynamicObject(19957,1879.834,-1768.354,12.199,0.000,0.000,360.000,-1,-1,-1,50.000,40.000);
	tmpobjid = CreateDynamicObject(19957,1890.205,-1768.354,12.199,0.000,0.000,360.000,-1,-1,-1,50.000,40.000);

	tmpobjid = CreateDynamicObject(19967,1890.182,-1762.375,12.322,0.000,0.000,540.000,-1,-1,-1,50.000,40.000);
	tmpobjid = CreateDynamicObject(19967,1879.790,-1762.375,12.322,0.000,0.000,540.000,-1,-1,-1,50.000,40.000);
	tmpobjid = CreateDynamicObject(19967,1858.708,-1768.366,12.322,0.000,0.000,720.000,-1,-1,-1,50.000,40.000);
	tmpobjid = CreateDynamicObject(19967,1848.318,-1768.366,12.322,0.000,0.000,720.000,-1,-1,-1,50.000,40.000);
}