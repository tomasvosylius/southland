
CMD:fmenu(playerid, params[])
{
	if(PlayerInfo[playerid][pFaction] == 0) return InfoBox(playerid, IB_NOT_IN_FACTION);

	new faction = GetFactionArrayIndexById(PlayerInfo[playerid][pFaction]);
	if(faction != -1)
	{
		if(PlayerInfo[playerid][pFactionLeader] < 1) return SendWarning(playerid, "Nesate lyderis.");
        FMenu_Main(playerid, faction);
	}
	return 1;
}

stock FMenu_Main(playerid, faction)
{
    dialog_Clear();
    dialog_AddLine("Biudþetas");
    dialog_AddLine("Transporto priemonës");
	dialog_AddLine("Nariø valdymas");
	dialog_AddLine("Rangø tvarkymas");
    inline select(response, listitem)
    {
        if(response)
        {
            dialog_Row("Biudþetas")     		return FMenu_Budget_Main(playerid, faction); // budget.pwn
            dialog_Row("Transporto priemonës") 	return FMenu_Vehicles_Main(playerid, faction); // vehicles.pwn
			dialog_Row("Nariø valdymas")		return FMenu_Workers_Main(playerid, faction); // workers.pwn
			dialog_Row("Rangø tvarkymas")		return FMenu_Ranks_Main(playerid, faction); // ranks.pwn
        }
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_LIST, "Frakcijos valdymas", "Toliau", "Uþdaryti");
    return 1;
}