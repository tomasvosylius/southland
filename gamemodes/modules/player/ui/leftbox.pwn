#include <YSI\y_hooks>

static 
    Timer:player_Timer[MAX_PLAYERS],
    bool:player_UI_Showed[MAX_PLAYERS],
    PlayerText:TD_LeftBox[MAX_PLAYERS];

stock UI_LeftBox_Show(playerid, string[], time = 3)
{
    if(player_UI_Showed[playerid])
    {
        if(player_Timer[playerid] != Timer:NONE)
        {
            stop player_Timer[playerid];
        }
        PlayerTextDrawSetString(playerid, TD_LeftBox[playerid], string);
    }
    else
    {
        TD_LeftBox[playerid] = CreatePlayerTextDraw(playerid, 17.000000, 152.000000, "Sustabdyti animacija gali parases ~r~/stopanim"); // 
        PlayerTextDrawLetterSize(playerid, TD_LeftBox[playerid], 0.356249, 1.693331);
        PlayerTextDrawTextSize(playerid, TD_LeftBox[playerid], 149.000000, 0.000000);
        PlayerTextDrawAlignment(playerid, TD_LeftBox[playerid], 1);
        PlayerTextDrawColor(playerid, TD_LeftBox[playerid], -33);
        PlayerTextDrawUseBox(playerid, TD_LeftBox[playerid], 1);
        PlayerTextDrawBoxColor(playerid, TD_LeftBox[playerid], 150);
        PlayerTextDrawSetShadow(playerid, TD_LeftBox[playerid], 0);
        PlayerTextDrawBackgroundColor(playerid, TD_LeftBox[playerid], 255);
        PlayerTextDrawFont(playerid, TD_LeftBox[playerid], 1);
        PlayerTextDrawSetProportional(playerid, TD_LeftBox[playerid], 1);
        PlayerTextDrawShow(playerid, TD_LeftBox[playerid]);
    }

    player_UI_Showed[playerid] = true;
    player_Timer[playerid] = defer PT_HideLeftHud[time * 1000](playerid);
}

timer PT_HideLeftHud[3000](playerid)
{
    PlayerTextDrawDestroy(playerid, TD_LeftBox[playerid]);
    player_UI_Showed[playerid] = false;
    return 1;
}

hook OnPlayerConnect(playerid)
{
    player_UI_Showed[playerid] = false;
    player_Timer[playerid] = Timer:NONE;
    return 1;
}