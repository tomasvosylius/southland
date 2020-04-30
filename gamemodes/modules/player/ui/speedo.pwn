#include <YSI_Coding\y_hooks>

static 
    PlayerText:TD_Speedo[MAX_PLAYERS][4],
    idx_Speedo_Speed = NONE, idx_Speedo_Fuel = NONE, idx_Speedo_Mileage = NONE;

static 
    bool:player_UI_Created[MAX_PLAYERS],
    bool:player_UI_Showed[MAX_PLAYERS];

stock Speedo_Update(playerid, speed_string[] = "", km_string[] = "", fuel_level[] = "")
{  
    if(TextdrawDisabled_Speedo{playerid}) return 0; // Zaidejas yra pasirinkes nematyti spidometro.

	(!player_UI_Showed[playerid]) && Speedo_Show(playerid);
	if(strlen(speed_string) >= 1)
    {
        PlayerTextDrawSetString(playerid, TD_Speedo[playerid][idx_Speedo_Speed], speed_string);
    }
	if(strlen(fuel_level) >= 1)
    {
        PlayerTextDrawSetString(playerid, TD_Speedo[playerid][idx_Speedo_Fuel], fuel_level);
    }
	if(strlen(km_string) >= 1)
    {
        PlayerTextDrawSetString(playerid, TD_Speedo[playerid][idx_Speedo_Mileage], km_string);
    }
	return 1;
}

stock Speedo_Show(playerid, bool:create = true)
{
    if(player_UI_Showed[playerid] || tmpPhone_InventoryPage[playerid] != 0) return 0;

    create && _Speedo_Create(playerid);

    for(new td = 0; td < sizeof TD_Speedo[]; td++)
    {
        PlayerTextDrawShow(playerid, TD_Speedo[playerid][td]);
    }

    player_UI_Showed[playerid] = true;
    return 1;
}

stock Speedo_Hide(playerid, bool:destroy = true)
{
    if(destroy) _Speedo_Destroy(playerid);
    else
    {
        for(new td = 0; td < sizeof TD_Speedo[]; td++)
        {
            PlayerTextDrawHide(playerid, TD_Speedo[playerid][td]);
        }
    }
    player_UI_Showed[playerid] = false;
    return 1;
}

stock _Speedo_Destroy(playerid)
{
    for(new td = 0; td < sizeof TD_Speedo[]; td++)
    {
        PlayerTextDrawDestroy(playerid, TD_Speedo[playerid][td]);
    }
    player_UI_Created[playerid] = false;
    return 1;
}

stock _Speedo_Create(playerid)
{
    if(player_UI_Created[playerid]) return 0;

    new td = 0;
    TD_Speedo[playerid][td] = CreatePlayerTextDraw(playerid, 545.000000, 394.000000, "box"); // 
    PlayerTextDrawLetterSize(playerid, TD_Speedo[playerid][td], 0.000000, 3.683331);
    PlayerTextDrawTextSize(playerid, TD_Speedo[playerid][td], 623.000000, 0.000000);
    PlayerTextDrawAlignment(playerid, TD_Speedo[playerid][td], 1);
    PlayerTextDrawColor(playerid, TD_Speedo[playerid][td], -1);
    PlayerTextDrawUseBox(playerid, TD_Speedo[playerid][td], 1);
    PlayerTextDrawBoxColor(playerid, TD_Speedo[playerid][td], 150);
    PlayerTextDrawSetShadow(playerid, TD_Speedo[playerid][td], 0);
    PlayerTextDrawBackgroundColor(playerid, TD_Speedo[playerid][td], 255);
    PlayerTextDrawFont(playerid, TD_Speedo[playerid][td], 1);
    PlayerTextDrawSetProportional(playerid, TD_Speedo[playerid][td], 1);
    td++;

    TD_Speedo[playerid][td] = CreatePlayerTextDraw(playerid, 549.000000, 397.000000, "GREITIS:_100KM/H"); // 
    PlayerTextDrawLetterSize(playerid, TD_Speedo[playerid][td], 0.236248, 1.008888);
    PlayerTextDrawAlignment(playerid, TD_Speedo[playerid][td], 1);
    PlayerTextDrawColor(playerid, TD_Speedo[playerid][td], -64);
    PlayerTextDrawSetShadow(playerid, TD_Speedo[playerid][td], 0);
    PlayerTextDrawBackgroundColor(playerid, TD_Speedo[playerid][td], 255);
    PlayerTextDrawFont(playerid, TD_Speedo[playerid][td], 1);
    PlayerTextDrawSetProportional(playerid, TD_Speedo[playerid][td], 1);
    (idx_Speedo_Speed == NONE) && (idx_Speedo_Speed = td);
    td++;

    TD_Speedo[playerid][td] = CreatePlayerTextDraw(playerid, 549.000000, 406.000000, "DEGALAI: ~g~~h~IIIIIIIIIII"); // 
    PlayerTextDrawLetterSize(playerid, TD_Speedo[playerid][td], 0.236248, 1.008888);
    PlayerTextDrawTextSize(playerid, TD_Speedo[playerid][td], 646.000000, 0.000000);
    PlayerTextDrawAlignment(playerid, TD_Speedo[playerid][td], 1);
    PlayerTextDrawColor(playerid, TD_Speedo[playerid][td], -64);
    PlayerTextDrawSetShadow(playerid, TD_Speedo[playerid][td], 0);
    PlayerTextDrawBackgroundColor(playerid, TD_Speedo[playerid][td], 255);
    PlayerTextDrawFont(playerid, TD_Speedo[playerid][td], 1);
    PlayerTextDrawSetProportional(playerid, TD_Speedo[playerid][td], 1);
    (idx_Speedo_Fuel == NONE) && (idx_Speedo_Fuel = td);
    td++;

    TD_Speedo[playerid][td] = CreatePlayerTextDraw(playerid, 549.000000, 415.000000, "RIDA:_100KM"); // 
    PlayerTextDrawLetterSize(playerid, TD_Speedo[playerid][td], 0.236248, 1.008888);
    PlayerTextDrawTextSize(playerid, TD_Speedo[playerid][td], 646.000000, 0.000000);
    PlayerTextDrawAlignment(playerid, TD_Speedo[playerid][td], 1);
    PlayerTextDrawColor(playerid, TD_Speedo[playerid][td], -64);
    PlayerTextDrawSetShadow(playerid, TD_Speedo[playerid][td], 0);
    PlayerTextDrawBackgroundColor(playerid, TD_Speedo[playerid][td], 255);
    PlayerTextDrawFont(playerid, TD_Speedo[playerid][td], 1);
    PlayerTextDrawSetProportional(playerid, TD_Speedo[playerid][td], 1);
    (idx_Speedo_Mileage == NONE) && (idx_Speedo_Mileage = td);
    td++;
    player_UI_Created[playerid] = true;
    return 1;
}

hook OnPlayerConnect(playerid)
{
    player_UI_Created[playerid] = 
    player_UI_Showed[playerid] = false;
    return 1;
}