#include <YSI\y_hooks>

hook OnPlayerConnect(playerid)
{
	RemoveBuildingForPlayer(playerid, 4076, 1783.1016, -1702.3047, 14.3516, 0.25);
	RemoveBuildingForPlayer(playerid, 1531, 1799.1328, -1708.7656, 14.1016, 0.25);
	RemoveBuildingForPlayer(playerid, 1266, 1805.0234, -1692.4453, 25.1484, 0.25);
	RemoveBuildingForPlayer(playerid, 4027, 1783.1016, -1702.3047, 14.3516, 0.25);
	RemoveBuildingForPlayer(playerid, 1260, 1805.0234, -1692.4453, 25.1484, 0.25);
}

hook OnGameModeInit()
{
	new obj = CreateObject(4027, 1783.10156, -1702.30469, 14.35160,   0.00000, 0.00000, 0.00000, 250.00);
	SetObjectMaterial(obj, 4, 4552, "ammu_lan2", "sl_lavicdtwall1", 0x00000000);
	//SetObjectMaterial(obj, 0, 3925, "weemap", "concretenewb256", 0xFFFFFFFF);
}
