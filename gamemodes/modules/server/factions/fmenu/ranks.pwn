stock FMenu_Ranks_Main(playerid, faction)
{
    MsgInfo(playerid, "Frakcija", "Pasirinkite rangà, kurio pavadinimà norite pakeisti.");
    
    dialog_Clear();
    for(new rank = 0; rank < MAX_FACTION_RANKS; rank++)
    {
        if(!strlen(FactionRankNames[faction][rank])) { break; }
        dialog_AddLine(FactionRankNames[faction][rank]);
    }
    inline select(response, listitem)
    {
        if(response)
        {
            _FMenu_Ranks_ChangeName(playerid, faction, listitem);
        }
        else FMenu_Main(playerid, faction);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_LIST, "Frakcijos rangai", "Pervadinti", "Atðaukti");
    return 1;
}

static _FMenu_Ranks_ChangeName(playerid, faction, rank)
{
    dialog_Clear();
    dialog_AddLine("{E4E4E4}Áveskite naujà rango {57AAD6}%s (%d){E4E4E4} pavadinimà.", FactionRankNames[faction][rank], rank+1);
    inline input(response, listitem)
    {
        if(response)
        {
            if(!strlen(dialog_Input()))
                return _FMenu_Ranks_ChangeName(playerid, faction, rank);
    
            inline updateRank()
            {
                MsgSuccess(playerid, "Frakcija", "Pervadinote %d rangà á %s", rank+1, dialog_Input());
                return 1;
            }
            mysql_tquery_inline(chandler, using inline updateRank, "\
                UPDATE `factions_ranks` SET Name = '%e' WHERE FactionId = '%d' AND Name = '%e' AND Rank = '%d'",
                dialog_Input(), FactionInfo[faction][fId], FactionRankNames[faction][rank], rank
            );
            format(FactionRankNames[faction][rank], 24, dialog_Input());
            
            log_init(true);
            log_set_table("logs_factions");
            log_set_keys("`PlayerId`,`PlayerName`,`FactionId`,`FactionName`,`ActionText`,`ExtraId`,`ExtraString`");
            log_set_values("'%d','%e','%d','%e','%d','%e','(FM) Pervadino ranga','%d','%e'", LogPlayerId(playerid), LogPlayerName(playerid), GetFactionName(faction, false), FactionInfo[faction][fId], rank+1, dialog_Input());
            log_commit();
        }
        FMenu_Ranks_Main(playerid, faction);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT,  "Frakcijos rangai", "Keisti", "Atðaukti");
    return 1;
}