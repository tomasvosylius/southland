#include <YSI_Coding\y_hooks>

static 
    PlayerText:TD_Core[MAX_PLAYERS][4],
	idx_Core_Value = NONE, idx_Core_Text = NONE;

static 
    player_BarType[MAX_PLAYERS][32],
    Timer:player_BarTimer[MAX_PLAYERS] = {Timer:NONE,...},
    player_BarValue[MAX_PLAYERS],
    bool:player_BarShowed[MAX_PLAYERS] = {false,...};
    
stock UI_LoadBar_IsActive(playerid) return (strlen(player_BarType[playerid]) > 0);

stock UI_LoadBar_Start(playerid, type[], time)
{
	if(UI_LoadBar_IsActive(playerid)) return 0;

	format(player_BarType[playerid], 32, type);
    player_BarValue[playerid] = 0;


    if(!player_BarShowed[playerid])
    {
        _UI_LoadBar_Create(playerid);

        PlayerTextDrawTextSize(playerid, TD_Core[playerid][idx_Core_Value], 0.0, 3.0);
        for(new td = 0; td < sizeof TD_Core[]; td++)
        {
            PlayerTextDrawShow(playerid, TD_Core[playerid][td]);
        }
    }

    player_BarShowed[playerid] = true;
    player_BarTimer[playerid] = repeat PT_LoadBarUpdate[time / 10](playerid);
    return 1;
}

static _UI_LoadBar_Stop(playerid)
{
    if(player_BarTimer[playerid] != Timer:NONE)
    {
        stop player_BarTimer[playerid];
    }
    player_BarTimer[playerid] = Timer:NONE;

    if(player_BarShowed[playerid])
    {
        for(new td = 0; td < sizeof TD_Core[]; td++)
        {
            PlayerTextDrawDestroy(playerid, TD_Core[playerid][td]);
        }
        player_BarShowed[playerid] = false;
    }

    format(player_BarType[playerid], 1, "");
}

timer PT_LoadBarUpdate[100](playerid)
{
    new value = (player_BarValue[playerid] += 10);

    PlayerTextDrawTextSize(playerid, TD_Core[playerid][idx_Core_Value], value * 2.65, 3.0);

    if(value >= 100)
    {
        call OnLoadBarEnd(playerid, player_BarType[playerid]);

        _UI_LoadBar_Stop(playerid);
    }
    return 1;
}

static _UI_LoadBar_Create(playerid)
{
    new td = 0;
    TD_Core[playerid][td] = CreatePlayerTextDraw(playerid, 189.952392, 377.293304, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, TD_Core[playerid][td], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Core[playerid][td], 268.000000, 6.000000);
	PlayerTextDrawAlignment(playerid, TD_Core[playerid][td], 1);
	PlayerTextDrawColor(playerid, TD_Core[playerid][td], 168430335);
	PlayerTextDrawSetShadow(playerid, TD_Core[playerid][td], 0);
	PlayerTextDrawSetOutline(playerid, TD_Core[playerid][td], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Core[playerid][td], 255);
	PlayerTextDrawFont(playerid, TD_Core[playerid][td], 4);
	PlayerTextDrawSetProportional(playerid, TD_Core[playerid][td], 0);
	PlayerTextDrawSetShadow(playerid, TD_Core[playerid][td], 0);
    td++;

	TD_Core[playerid][td] = CreatePlayerTextDraw(playerid, 191.476211, 378.999969, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, TD_Core[playerid][td], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Core[playerid][td], 265.000000, 3.0);
	PlayerTextDrawAlignment(playerid, TD_Core[playerid][td], 1);
	PlayerTextDrawColor(playerid, TD_Core[playerid][td], 0x8E721Cff);
	PlayerTextDrawSetShadow(playerid, TD_Core[playerid][td], 0);
	PlayerTextDrawSetOutline(playerid, TD_Core[playerid][td], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Core[playerid][td], 255);
	PlayerTextDrawFont(playerid, TD_Core[playerid][td], 4);
	PlayerTextDrawSetProportional(playerid, TD_Core[playerid][td], 0);
	PlayerTextDrawSetShadow(playerid, TD_Core[playerid][td], 0);
    td++;

	TD_Core[playerid][td] = CreatePlayerTextDraw(playerid, 191.476211, 378.999969, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, TD_Core[playerid][td], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TD_Core[playerid][td], 0.000000, 3.0);
	PlayerTextDrawAlignment(playerid, TD_Core[playerid][td], 1);
	PlayerTextDrawColor(playerid, TD_Core[playerid][td], 0xEEBC26ff);
	PlayerTextDrawSetShadow(playerid, TD_Core[playerid][td], 0);
	PlayerTextDrawSetOutline(playerid, TD_Core[playerid][td], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_Core[playerid][td], 255);
	PlayerTextDrawFont(playerid, TD_Core[playerid][td], 4);
	PlayerTextDrawSetProportional(playerid, TD_Core[playerid][td], 0);
	PlayerTextDrawSetShadow(playerid, TD_Core[playerid][td], 0);
    (idx_Core_Value == NONE) && (idx_Core_Value = td);
    td++;

	TD_Core[playerid][td] = CreatePlayerTextDraw(playerid, 190.190536, 366.639923, "VARIKLIS_UZVEDAMAS");
	PlayerTextDrawLetterSize(playerid, TD_Core[playerid][td], 0.183238, 1.096533);
	PlayerTextDrawAlignment(playerid, TD_Core[playerid][td], 1);
	PlayerTextDrawColor(playerid, TD_Core[playerid][td], -1);
	PlayerTextDrawSetShadow(playerid, TD_Core[playerid][td], 1);
	PlayerTextDrawSetOutline(playerid, TD_Core[playerid][td], 1);
	PlayerTextDrawBackgroundColor(playerid, TD_Core[playerid][td], 5887);
	PlayerTextDrawFont(playerid, TD_Core[playerid][td], 2);
	PlayerTextDrawSetProportional(playerid, TD_Core[playerid][td], 1);
	PlayerTextDrawSetShadow(playerid, TD_Core[playerid][td], 1);
    (idx_Core_Text == NONE) && (idx_Core_Text = td);
    td++;
}



hook OnPlayerDespawnChar(playerid, reason, changechar)
{
	_UI_LoadBar_Stop(playerid);
    return 1;
}