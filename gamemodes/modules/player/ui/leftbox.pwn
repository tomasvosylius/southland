#include <YSI\y_hooks>

static 
    Timer:player_Timer[MAX_PLAYERS],
    bool:player_UI_Created[MAX_PLAYERS],
    PlayerText:TD_LeftBox[MAX_PLAYERS];

stock UI_LeftBox_Hide(playerid)
{
    (player_UI_Created[playerid]) && PlayerTextDrawDestroy(playerid, TD_LeftBox[playerid]);
    player_UI_Created[playerid] = false;
    return 1;
}
stock UI_LeftBox_Show(playerid, string[], Float:width = 155.0, Float:time = 3.0)
{
    // printf("UI_LeftBox_Show(%s): %s", ret_GetPlayerName(playerid), string);

    if(player_UI_Created[playerid])
    {
        if(player_Timer[playerid] != Timer:NONE)
        {
            stop player_Timer[playerid];
        }
        PlayerTextDrawSetString(playerid, TD_LeftBox[playerid], string);
    }
    else
    {
        TD_LeftBox[playerid] = CreatePlayerTextDraw(playerid, 17.000000, 152.000000, string); // 
        PlayerTextDrawLetterSize(playerid, TD_LeftBox[playerid], 0.356249, 1.693331);
        PlayerTextDrawTextSize(playerid, TD_LeftBox[playerid], width, 0.000000);
        PlayerTextDrawAlignment(playerid, TD_LeftBox[playerid], 1);
        PlayerTextDrawColor(playerid, TD_LeftBox[playerid], -33);
        PlayerTextDrawUseBox(playerid, TD_LeftBox[playerid], 1);
        PlayerTextDrawBoxColor(playerid, TD_LeftBox[playerid], 150);
        PlayerTextDrawSetShadow(playerid, TD_LeftBox[playerid], 0);
        PlayerTextDrawBackgroundColor(playerid, TD_LeftBox[playerid], 255);
        PlayerTextDrawFont(playerid, TD_LeftBox[playerid], 1);
        PlayerTextDrawSetProportional(playerid, TD_LeftBox[playerid], 1);    
    }
    PlayerTextDrawShow(playerid, TD_LeftBox[playerid]);

    player_UI_Created[playerid] = true;
    if(time > 0.0)
    {
        player_Timer[playerid] = defer PT_HideLeftHud[floatround(time * 1000)](playerid);
    }
}

timer PT_HideLeftHud[3000](playerid)
{
    UI_LeftBox_Hide(playerid);
}

hook OnPlayerConnect(playerid)
{
    player_UI_Created[playerid] = false;
    player_Timer[playerid] = Timer:NONE;
    return 1;
}