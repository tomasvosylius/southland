
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
    dialog_AddLine("Biud�etas");
    dialog_AddLine("Transporto priemon�s");
	dialog_AddLine("Nari� valdymas");
	dialog_AddLine("Rang� tvarkymas");
    inline select(response, listitem)
    {
        if(response)
        {
            dialog_Row("Biud�etas")     		return FMenu_Budget_Main(playerid, faction); // budget.pwn
            dialog_Row("Transporto priemon�s") 	return FMenu_Vehicles_Main(playerid, faction); // vehicles.pwn
			dialog_Row("Nari� valdymas")		return FMenu_Workers_Main(playerid, faction); // workers.pwn
			dialog_Row("Rang� tvarkymas")		return FMenu_Ranks_Main(playerid, faction); // ranks.pwn
        }
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_LIST, "Frakcijos valdymas", "Toliau", "U�daryti");
    return 1;
}