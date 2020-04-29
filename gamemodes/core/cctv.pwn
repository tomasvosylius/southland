/*
 *
 * SAN ANDREAS MULTIPLAYER CCTV.PWN BY TOMAS TORKQ VOSYLIUS
 * ALL RIGHTS RESERVED
 * 2017
 *
 */

#include <YSI\y_hooks>

enum E_CCTV_PLAYER_DATA
{
	Float:pCctvBeforeX,
	Float:pCctvBeforeY,
	Float:pCctvBeforeZ,
	pCctvBeforeVW,
	pCctvBeforeInt,
	Float:pCctvUDDeg,
	Float:pCctvLRDeg,
	pCctvTimer,
	bool:pCctvActive,
	pCctvCurrent
};
new pCCTV[MAX_PLAYERS][E_CCTV_PLAYER_DATA];

enum E_CCTV_ARRAY_DATA
{
	cctvName[15],
	Float:cctvX,
	Float:cctvY,
	Float:cctvZ,
	cctvInterior
};
new CCTV[][E_CCTV_ARRAY_DATA] = {
	{"PD 1", 1412.9564,-1659.1570,19.8454, 0},
	{"PD 2", 1385.9000,-1634.1108,19.3894, 0},
	{"PD 3", 1381.2220,-1715.4232,18.8370, 0},
	{"Govern", 1502.7141,-1770.9623,20.3612, 0},
	{"Unity St.", 1811.1250,-1871.5112,18.4640, 0},
	{"Unity Mall", 1838.5073,-1740.1718,23.6629, 0},
	{"DMV", 1922.1836,-1644.7817,18.8292, 0},
	{"Pizza Stack", 2104.3320,-1790.1392,17.4410, 0},
	{"Laundry", 2360.2095,-1373.6570,29.9766, 0},
	{"Car Shop", 2140.5808,-1145.0448,29.2897, 0},
	{"MAZE Bank", 1471.5037,-1258.8571,17.5367, 0},
	{"Street", 1383.6472,-1130.7820,37.2719, 0},
	{"InsideTrack", 1640.4293,-1171.0776,29.7505, 0}
	//{"BANKAS 1", 2282.09, 67.51, 30.30, 0},
	//{"BANKAS 2", 224.05, 68.54, 29.97, 	0},
	//{"BANKAS 3", 2263.18, 76.71, 29.97, 0},
	//{"DMV", 206.58, -3.08, 5.03, 0},
	//{"MECHANIKAI", 208.03, -228.45, 5.03, 0},
	//{"MD 1", 1176.22, 508.15, 24.50, 0},
	//{"MD 2", 1142.69, 503.68, 24.50, 0},
	//{"MD 3", 1222.20, 475.11, 24.50, 0},
	//{"GOVERNMENT", 629.12, -557.80, 20.38, 0},
	//{"DL FUEL", 679.47, -466.37, 19.37, 0}
};

/*
 * Hooks
 */

hook OnPlayerDisconnect(playerid)
{
	if(pCCTV[playerid][pCctvActive]) KillTimer(pCCTV[playerid][pCctvTimer]);
	//reset(CCTV, pCCTV[playerid], E_CCTV_PLAYER_DATA);
	new __reset_CCTV_Player[E_CCTV_PLAYER_DATA];
	pCCTV[playerid] = __reset_CCTV_Player;
	return 1;
}

/*
 * Functions
 */

stock CCTV_StartStream(playerid, cctv)
{
	if(0 <= cctv < sizeof CCTV)
	{
		pCCTV[playerid][pCctvActive] = true;
		pCCTV[playerid][pCctvTimer] = SetTimerEx("CCTVMoveTimer", 100, true, "dd", playerid, cctv);
		pCCTV[playerid][pCctvCurrent] = cctv;
		GetPlayerPos(playerid, pCCTV[playerid][pCctvBeforeX], pCCTV[playerid][pCctvBeforeY], pCCTV[playerid][pCctvBeforeZ]);
		SetPlayerPos(playerid, CCTV[cctv][cctvX], CCTV[cctv][cctvY], -1.0);
		SetPlayerCameraPos(playerid, CCTV[cctv][cctvX], CCTV[cctv][cctvY], CCTV[cctv][cctvZ]);
		CCTV_MoveCamera(playerid, 0.0, 0.0, cctv);
		pCCTV[playerid][pCctvBeforeVW] = GetPlayerVirtualWorld(playerid);
		pCCTV[playerid][pCctvBeforeInt] = GetPlayerInterior(playerid);
		PlayerInfo[playerid][pViewStatus] = PLAYER_VIEW_STATUS_CCTV;
		SetPlayerInterior(playerid, CCTV[cctv][cctvInterior]);
		SetPlayerVirtualWorld(playerid, 0);
		TogglePlayerControllable(playerid, false);
		SendFormat(playerid, 0x7BC19EFF, "Kameros valdymas: up, down, left, right mygtukais.");
		return true;
	}
	return false;
}

stock CCTV_StopStream(playerid)
{
	if(pCCTV[playerid][pCctvActive])
	{
		KillTimer(pCCTV[playerid][pCctvTimer]);
		new __reset_CCTV_Player[E_CCTV_PLAYER_DATA];
		SetPlayerInterior(playerid, pCCTV[playerid][pCctvBeforeInt]);
		SetPlayerVirtualWorld(playerid, pCCTV[playerid][pCctvBeforeVW]);
		SetPlayerPos(playerid, pCCTV[playerid][pCctvBeforeX], pCCTV[playerid][pCctvBeforeY], pCCTV[playerid][pCctvBeforeZ]+0.5);
		SetCameraBehindPlayer(playerid);
		TogglePlayerControllable(playerid, true);
		PlayerInfo[playerid][pViewStatus] = PLAYER_VIEW_STATUS_NONE;
		pCCTV[playerid] = __reset_CCTV_Player;
		return true;
	}	
	return false;
}

forward CCTVMoveTimer(playerid, cctv);
public CCTVMoveTimer(playerid, cctv)
{
	new 
		unused,
		ud,
		lr;
	GetPlayerKeys(playerid, unused, ud, lr);
	// right/left
	if(lr == KEY_RIGHT)
	{
		pCCTV[playerid][pCctvLRDeg] -= 5.0;
		if(pCCTV[playerid][pCctvLRDeg] < 0.0) pCCTV[playerid][pCctvLRDeg] = 359.0;
		CCTV_MoveCamera(playerid, pCCTV[playerid][pCctvLRDeg], pCCTV[playerid][pCctvUDDeg], pCCTV[playerid][pCctvCurrent]);
	}
	else if(lr == KEY_LEFT)
	{	
		pCCTV[playerid][pCctvLRDeg] += 5.0;
		if(pCCTV[playerid][pCctvLRDeg] >= 360.0) pCCTV[playerid][pCctvLRDeg] = 0.0;
		CCTV_MoveCamera(playerid, pCCTV[playerid][pCctvLRDeg], pCCTV[playerid][pCctvUDDeg], pCCTV[playerid][pCctvCurrent]);
	}
	// up/down
	else if(ud == KEY_UP)
	{	
		if(pCCTV[playerid][pCctvUDDeg] < 26.0)
		{
			pCCTV[playerid][pCctvUDDeg] += 2.0;
			CCTV_MoveCamera(playerid, pCCTV[playerid][pCctvLRDeg], pCCTV[playerid][pCctvUDDeg], pCCTV[playerid][pCctvCurrent]);
		}
	}
	else if(ud == KEY_DOWN)
	{
		if(pCCTV[playerid][pCctvUDDeg] >= -6.0)
		{
			pCCTV[playerid][pCctvUDDeg] -= 2.0;
			CCTV_MoveCamera(playerid, pCCTV[playerid][pCctvLRDeg], pCCTV[playerid][pCctvUDDeg], pCCTV[playerid][pCctvCurrent]);
		}
	}
	return 1;
}

stock CCTV_MoveCamera(playerid, Float:lrdeg, Float:uddeg, cctv)
{
	new 
		Float:lookX,
		Float:lookY,
		Float:lookZ;
	lookX = CCTV[cctv][cctvX] + floatmul(lrdeg, floatsin(-lrdeg, degrees));
	lookY = CCTV[cctv][cctvY] + floatmul(lrdeg, floatcos(-lrdeg, degrees));
	lookZ = CCTV[cctv][cctvZ] + uddeg;
	SetPlayerCameraLookAt(playerid, lookX, lookY, lookZ);
	return 1;
}