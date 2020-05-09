#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid)
{
    RemoveBuildingForPlayer(playerid, 5206, 2163.6719, -1873.6172, 15.8203, 0.25);
    RemoveBuildingForPlayer(playerid, 5180, 2163.6719, -1873.6172, 15.8203, 0.25);
}
hook OnGameModeInit()
{
    new tmpobjid;
    // pagrindas
    tmpobjid = CreateObject(8661, 2135.87207, -1874.51343, 12.54000,   0.00000, 0.00000, 0.00000);
    SetObjectMaterial(tmpobjid, 0, 16640, "a51", "plaintarmac1", 0xffffffff);
    tmpobjid = CreateObject(8661, 2135.87207, -1873.71338, 12.49000,   0.00000, 0.00000, 0.00000);
    SetObjectMaterial(tmpobjid, 0, 16640, "a51", "plaintarmac1", 0xffffffff);

    tmpobjid = CreateObject(8661, 2175.78809, -1874.51685, 12.54300,   0.00000, 0.00000, 0.00000);
    SetObjectMaterial(tmpobjid, 0, 16640, "a51", "plaintarmac1", 0xffffffff);
    tmpobjid = CreateObject(8661, 2175.78809, -1873.22278, 12.52100,   0.00000, 0.00000, 0.00000);
    SetObjectMaterial(tmpobjid, 0, 16640, "a51", "plaintarmac1", 0xffffffff);
    // kavine
    tmpobjid = CreateObject(18240, 2141.63965, -1879.44226, 12.47510,   0.00000, 0.00000, 0.00000);
    
    // lubos
    tmpobjid = CreateObject(19377, 2188.43994, -1869.79578, 17.72700,   0.00000, 90.00000, 0.00000);
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xffffffff);
    tmpobjid = CreateObject(19377, 2189.20313, -1874.87830, 17.73100,   0.00000, 90.00000, 0.00000);
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xffffffff);
    tmpobjid = CreateObject(19377, 2178.69800, -1874.87085, 17.73100,   0.00000, 90.00000, 0.00000);
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xffffffff);
    tmpobjid = CreateObject(19377, 2168.27368, -1874.87610, 17.73100,   0.00000, 90.00000, 0.00000);
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xffffffff);
    tmpobjid = CreateObject(19377, 2177.97559, -1869.75562, 17.72700,   0.00000, 90.00000, 0.00000);
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xffffffff);
    tmpobjid = CreateObject(19377, 2169.27881, -1869.79858, 17.72700,   0.00000, 90.00000, 0.24000);
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xffffffff);

    // stogas
    tmpobjid = CreateObject(19377, 2190.30640, -1874.78735, 19.44700,   0.00000, 90.00000, 0.00000);
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ws_rooftarmac1", 0xffffffff);
    tmpobjid = CreateObject(19377, 2190.32202, -1869.68689, 19.44500,   0.00000, 90.00000, 0.00000);
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ws_rooftarmac1", 0xffffffff);
    tmpobjid = CreateObject(19377, 2179.82959, -1869.69434, 19.44500,   0.00000, 90.00000, 0.00000);
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ws_rooftarmac1", 0xffffffff);
    tmpobjid = CreateObject(19377, 2179.88013, -1874.79407, 19.44700,   0.00000, 90.00000, 0.00000);
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ws_rooftarmac1", 0xffffffff);
    tmpobjid = CreateObject(19377, 2169.40356, -1874.71814, 19.44700,   0.00000, 90.00000, 0.00000);
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ws_rooftarmac1", 0xffffffff);
    tmpobjid = CreateObject(19377, 2169.37793, -1869.70996, 19.44500,   0.00000, 90.00000, 0.00000);
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ws_rooftarmac1", 0xffffffff);
    tmpobjid = CreateObject(19377, 2161.26758, -1874.73291, 19.44700,   0.00000, 90.00000, 0.00000);
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ws_rooftarmac1", 0xffffffff);
    tmpobjid = CreateObject(19377, 2161.30249, -1869.71448, 19.44900,   0.00000, 90.00000, 0.00000);
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ws_rooftarmac1", 0xffffffff);

    // sienos 1 aukstas
    tmpobjid = CreateDynamicObject(19455, 2160.66382, -1879.65112, 14.28200,   0.00000, 0.00000, 90.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 16093, "a51_ext", "ws_whitewall2_bottom", 0xffffffff);
    tmpobjid = CreateDynamicObject(19455, 2190.85645, -1864.89734, 14.28200,   0.00000, 0.00000, 270.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 16093, "a51_ext", "ws_whitewall2_bottom", 0xffffffff);
    tmpobjid = CreateDynamicObject(19455, 2195.55811, -1874.88257, 14.28200,   0.00000, 0.00000, 0.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 16093, "a51_ext", "ws_whitewall2_bottom", 0xffffffff);
    tmpobjid = CreateDynamicObject(19455, 2195.57300, -1869.77112, 14.28200,   0.00000, 0.00000, 0.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 16093, "a51_ext", "ws_whitewall2_bottom", 0xffffffff);
    tmpobjid = CreateDynamicObject(19455, 2181.23975, -1864.89624, 14.28200,   0.00000, 0.00000, 270.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 16093, "a51_ext", "ws_whitewall2_bottom", 0xffffffff);
    tmpobjid = CreateDynamicObject(19455, 2171.65479, -1864.88245, 14.28200,   0.00000, 0.00000, 270.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 16093, "a51_ext", "ws_whitewall2_bottom", 0xffffffff);
    tmpobjid = CreateDynamicObject(19455, 2162.05322, -1864.88208, 14.28200,   0.00000, 0.00000, 270.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 16093, "a51_ext", "ws_whitewall2_bottom", 0xffffffff);
    tmpobjid = CreateDynamicObject(19455, 2188.38452, -1874.87708, 14.28200,   0.00000, 0.00000, 0.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 16093, "a51_ext", "ws_whitewall2_bottom", 0xffffffff);
    tmpobjid = CreateDynamicObject(19455, 2188.37305, -1869.77112, 14.28200,   0.00000, 0.00000, 0.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 16093, "a51_ext", "ws_whitewall2_bottom", 0xffffffff);
    tmpobjid = CreateDynamicObject(19455, 2155.94727, -1874.84094, 14.28200,   0.00000, 0.00000, 0.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 16093, "a51_ext", "ws_whitewall2_bottom", 0xffffffff);
    tmpobjid = CreateDynamicObject(19455, 2155.97290, -187.77110, 14.28200,   0.00000, 0.00000, 0.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 16093, "a51_ext", "ws_whitewall2_bottom", 0xffffffff);
    tmpobjid = CreateDynamicObject(19455, 2155.97290, -187.77110, 14.28200,   0.00000, 0.00000, 0.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 16093, "a51_ext", "ws_whitewall2_bottom", 0xffffffff);
    tmpobjid = CreateDynamicObject(19455, 2155.97290, -1869.80115, 14.28200,   0.00000, 0.00000, 0.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 16093, "a51_ext", "ws_whitewall2_bottom", 0xffffffff);
    tmpobjid = CreateDynamicObject(19455, 2160.71265, -1864.91064, 14.28000,   0.00000, 0.00000, 270.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 16093, "a51_ext", "ws_whitewall2_bottom", 0xffffffff);
    tmpobjid = CreateDynamicObject(19455, 2163.88892, -1874.90979, 14.28200,   0.00000, 0.00000, 0.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 16093, "a51_ext", "ws_whitewall2_bottom", 0xffffffff);
    tmpobjid = CreateDynamicObject(19455, 2163.91040, -1869.82373, 14.28200,   0.00000, 0.00000, 0.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 16093, "a51_ext", "ws_whitewall2_bottom", 0xffffffff);
    tmpobjid = CreateDynamicObject(19363, 2186.70093, -1879.64709, 14.28400,   0.00000, 0.00000, 90.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 16093, "a51_ext", "ws_whitewall2_bottom", 0xffffffff);
    tmpobjid = CreateDynamicObject(19363, 2189.89844, -1879.64709, 14.28400,   0.00000, 0.00000, 90.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 16093, "a51_ext", "ws_whitewall2_bottom", 0xffffffff);
    tmpobjid = CreateDynamicObject(19363, 2193.11060, -1879.64709, 14.28400,   0.00000, 0.00000, 90.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 16093, "a51_ext", "ws_whitewall2_bottom", 0xffffffff);
    tmpobjid = CreateDynamicObject(19363, 2194.05200, -1879.63916, 14.28400,   0.00000, 0.00000, 90.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 16093, "a51_ext", "ws_whitewall2_bottom", 0xffffffff);
    tmpobjid = CreateDynamicObject(19363, 2176.48047, -1879.64709, 14.28400,   0.00000, 0.00000, 90.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 16093, "a51_ext", "ws_whitewall2_bottom", 0xffffffff);
    tmpobjid = CreateDynamicObject(19363, 2166.51367, -1879.64709, 14.28400,   0.00000, 0.00000, 90.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 16093, "a51_ext", "ws_whitewall2_bottom", 0xffffffff);

    // 2 aukstass 
    tmpobjid = CreateDynamicObject(19455, 2160.66382, -1879.65112, 17.78200,   0.00000, 0.00000, 90.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 17036, "cuntwbt", "corugwall2-1", 0xffffffff);
    tmpobjid = CreateDynamicObject(19455, 2195.55811, -1874.88257, 17.78200,   0.00000, 0.00000, 0.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 17036, "cuntwbt", "corugwall2-1", 0xffffffff);
    tmpobjid = CreateDynamicObject(19455, 2195.57300, -1869.77112, 17.78200,   0.00000, 0.00000, 0.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 17036, "cuntwbt", "corugwall2-1", 0xffffffff);
    tmpobjid = CreateDynamicObject(19455, 2190.85645, -1864.89734, 17.78200,   0.00000, 0.00000, 270.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 17036, "cuntwbt", "corugwall2-1", 0xffffffff);
    tmpobjid = CreateDynamicObject(19455, 2181.23975, -1864.89624, 17.78200,   0.00000, 0.00000, 270.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 17036, "cuntwbt", "corugwall2-1", 0xffffffff);
    tmpobjid = CreateDynamicObject(19455, 2171.65479, -1864.88245, 17.78200,   0.00000, 0.00000, 270.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 17036, "cuntwbt", "corugwall2-1", 0xffffffff);
    tmpobjid = CreateDynamicObject(19455, 2162.05322, -1864.88208, 17.78200,   0.00000, 0.00000, 270.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 17036, "cuntwbt", "corugwall2-1", 0xffffffff);
    tmpobjid = CreateDynamicObject(19455, 2160.71265, -1864.91064, 17.78200,   0.00000, 0.00000, 270.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 17036, "cuntwbt", "corugwall2-1", 0xffffffff);
    tmpobjid = CreateDynamicObject(19455, 2155.97290, -1869.80115, 17.78200,   0.00000, 0.00000, 0.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 17036, "cuntwbt", "corugwall2-1", 0xffffffff);
    tmpobjid = CreateDynamicObject(19455, 2155.94727, -1874.84094, 17.78200,   0.00000, 0.00000, 0.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 17036, "cuntwbt", "corugwall2-1", 0xffffffff);
    tmpobjid = CreateDynamicObject(19455, 2188.37305, -1869.77112, 17.78200,   0.00000, 0.00000, 0.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 17036, "cuntwbt", "corugwall2-1", 0xffffffff);
    tmpobjid = CreateDynamicObject(19455, 2188.38452, -1874.87708, 17.78200,   0.00000, 0.00000, 0.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 17036, "cuntwbt", "corugwall2-1", 0xffffffff);
    tmpobjid = CreateDynamicObject(19455, 2163.91040, -1869.82373, 17.78200,   0.00000, 0.00000, 0.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 17036, "cuntwbt", "corugwall2-1", 0xffffffff);
    tmpobjid = CreateDynamicObject(19455, 2163.88892, -1874.90979, 17.78200,   0.00000, 0.00000, 0.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 17036, "cuntwbt", "corugwall2-1", 0xffffffff);
    tmpobjid = CreateDynamicObject(19455, 2170.97827, -1879.60645, 17.78200,   0.00000, 0.00000, 90.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 17036, "cuntwbt", "corugwall2-1", 0xffffffff);
    tmpobjid = CreateDynamicObject(19455, 2181.03589, -1879.63452, 17.78200,   0.00000, 0.00000, 90.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 17036, "cuntwbt", "corugwall2-1", 0xffffffff);
    tmpobjid = CreateDynamicObject(19363, 2166.51367, -1879.64709, 17.78200,   0.00000, 0.00000, 90.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 17036, "cuntwbt", "corugwall2-1", 0xffffffff);
    tmpobjid = CreateDynamicObject(19363, 2176.48047, -1879.64709, 17.78200,   0.00000, 0.00000, 90.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 17036, "cuntwbt", "corugwall2-1", 0xffffffff);
    tmpobjid = CreateDynamicObject(19363, 2189.89844, -1879.64709, 17.78200,   0.00000, 0.00000, 90.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 17036, "cuntwbt", "corugwall2-1", 0xffffffff);
    tmpobjid = CreateDynamicObject(19363, 2186.70093, -1879.64709, 17.78200,   0.00000, 0.00000, 90.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 17036, "cuntwbt", "corugwall2-1", 0xffffffff);
    tmpobjid = CreateDynamicObject(19363, 2193.11060, -1879.64709, 17.78200,   0.00000, 0.00000, 90.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 17036, "cuntwbt", "corugwall2-1", 0xffffffff);
    tmpobjid = CreateDynamicObject(19363, 2194.05200, -1879.63916, 17.78200,   0.00000, 0.00000, 90.00000, -1,-1,-1,300.0);
    SetDynamicObjectMaterial(tmpobjid, 0, 17036, "cuntwbt", "corugwall2-1", 0xffffffff);

    CreateDynamicObject(936, 2170.68823, -1865.60046, 13.00700,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(11709, 2175.87207, -1865.22278, 13.21700,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19869, 2194.91797, -1907.11096, 12.54100,   0.00000, 0.00000, 84.30000);
    CreateDynamicObject(19869, 2194.14893, -1912.31604, 12.54100,   0.00000, 0.00000, 78.79900);
    CreateDynamicObject(19869, 2192.83496, -1917.40405, 12.54100,   0.00000, 0.00000, 72.29900);
    CreateDynamicObject(19869, 2191.00708, -1922.34802, 12.54100,   0.00000, 0.00000, 67.19900);
    CreateDynamicObject(19869, 2188.67310, -1927.05896, 12.54100,   0.00000, 0.00000, 60.19900);
    CreateDynamicObject(19869, 2185.78296, -1931.45703, 12.54100,   0.00000, 0.00000, 53.29900);
    CreateDynamicObject(19869, 2182.36401, -1935.44397, 12.54100,   0.00000, 0.00000, 45.49900);
    CreateDynamicObject(19869, 2178.51001, -1939.03198, 12.54100,   0.00000, 0.00000, 40.40000);
    CreateDynamicObject(19869, 2174.31299, -1942.18994, 12.54100,   0.00000, 0.00000, 33.60000);
    CreateDynamicObject(1687, 2169.28857, -1873.88403, 20.33800,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1688, 2179.78223, -1874.72937, 20.43700,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(1691, 2161.59155, -1877.90356, 19.92400,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(1328, 2194.39697, -1905.10205, 13.06100,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1328, 2194.61401, -1906.14502, 13.06100,   0.00000, 0.00000, -33.50000);
    CreateDynamicObject(1810, 2166.21875, -1880.45227, 12.54700,   0.00000, 0.00000, 35.27901);
    CreateDynamicObject(19817, 2171.78003, -1872.56702, 11.48700,   0.00000, 0.00000, 0.00000);

    CreateDynamicObject(19815, 2170.02197, -1864.9958, 14.35700,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19815, 2173.00708, -1864.9958, 14.35700,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19815, 2180.40015, -1864.9958, 14.35700,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19815, 2183.35864, -1864.9958, 14.35700,   0.00000, 0.00000, 0.00000);

    CreateDynamicObject(19899, 2176.45410, -1879.08191, 12.54700,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(19899, 2187.67725, -1869.61877, 12.54700,   0.00000, 0.00000, 180.00000);
    CreateDynamicObject(19903, 2167.93677, -1870.55554, 12.54700,   0.00000, 0.00000, -43.66004);
    CreateDynamicObject(1431, 2186.35522, -1879.10815, 13.08700,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1412, 2136.64502, -1904.51904, 13.77900,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1412, 2134.04395, -1907.22900, 13.77900,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(1412, 2134.04395, -1912.51001, 13.77900,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(1412, 2134.04395, -1917.79004, 13.77900,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(1691, 2161.57788, -1873.12634, 19.92400,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(936, 2172.58374, -1865.57898, 13.00700,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19817, 2181.83081, -1872.56702, 11.48700,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19903, 2169.01855, -1869.26892, 12.54700,   0.00000, 0.00000, -89.02003);
    CreateDynamicObject(19903, 2179.13086, -1868.58984, 12.54700,   0.00000, 0.00000, -27.40006);
    CreateDynamicObject(3632, 2165.08984, -1879.09778, 12.96391,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3632, 2165.95679, -1879.11743, 12.96391,   0.00000, 0.00000, 13.44000);
    CreateDynamicObject(923, 2187.55298, -1871.95264, 13.45450,   0.00000, 0.00000, -90.00000);
    CreateDynamicObject(936, 2179.87866, -1865.65503, 13.00700,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(936, 2181.79346, -1865.64978, 13.00700,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(936, 2183.69580, -1865.67151, 13.00700,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(11709, 2177.23560, -1865.22998, 13.21700,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3632, 2165.49585, -1878.46606, 12.96391,   0.00000, 0.00000, -101.81998);
    CreateDynamicObject(3761, 2164.97534, -1874.90234, 12.95510,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3761, 2165.00366, -1868.62195, 12.95510,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(923, 2187.58569, -1867.18860, 13.45450,   0.00000, 0.00000, -90.00000);
    // CreateDynamicObject(3066, 2190.64063, -1881.77783, 12.92590,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(1413, 2195.54248, -1881.74231, 13.78635,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(14826, 2189.94727, -1874.77148, 13.23820,   0.00000, 0.00000, 110.59662);
    CreateDynamicObject(8656, 2178.06836, -1863.72632, 13.63040,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(8656, 2147.56836, -1863.72632, 13.63040,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(1440, 2176.37769, -1880.43481, 13.03731,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1438, 2159.33130, -1880.95972, 12.50160,   0.00000, 0.00000, -360.47995);
    CreateDynamicObject(3035, 2155.13013, -1878.13989, 13.26790,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(910, 2161.79712, -1880.41174, 13.69470,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1449, 2164.31226, -1880.00378, 13.04130,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1219, 2154.14136, -1866.27844, 12.83378,   0.00000, 0.00000, 12.58673);
    CreateDynamicObject(1328, 2174.10156, -1865.52075, 13.02990,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1537, 2188.23364, -1876.48926, 12.54170,   0.00000, 0.00000, -90.00000);
    CreateDynamicObject(18762, 2195.41602, -1863.01807, 9.81637,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(18762, 2131.97656, -1863.71436, 12.26060,   0.00000, 0.00000, 0.00000);
    
    CreateDynamicObject(2674, 2166.61279, -1880.48181, 12.5521,   0.00000, 0.00000, 306.98352);
    CreateDynamicObject(2670, 2176.88989, -1881.62231, 12.62040,   0.00000, 0.00000, 285.88266);
    CreateDynamicObject(4227, 2151.56909, -1869.29993, 13.86280,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(1810, 2167.60669, -1880.55872, 12.54700,   0.00000, 0.00000, -15.48098);
}