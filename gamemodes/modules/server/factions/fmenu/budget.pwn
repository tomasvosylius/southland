stock FMenu_Budget_Main(playerid, faction)
{
    // biudzetas
    dialog_Clear();
    dialog_AddLine("Frakcijos biud�ete: {AFEE9E}$%d", FactionInfo[faction][fBudget]);
    dialog_AddLine("{8BDA76}Pad�ti � biud�et�");
    dialog_AddLine("{E47059}Paimti i� biud�eto");
    inline select(response, listitem)
    {
        if(response)
        {
            dialog_Row("Pad�ti") return _FMenu_Budget_Put(playerid, faction);
            dialog_Row("Paimti") return _FMenu_Budget_Take(playerid, faction);
            FMenu_Budget_Main(playerid, faction);
        }
        else FMenu_Main(playerid, faction);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_LIST, "Frakcijos biud�etas", "T�sti", "At�aukti");
    return 1;
}

static _FMenu_Budget_Put(playerid, faction, error[] = "")
{
    dialog_Clear();
    dialog_AddLine("{E4E4E4}�veskite kiek� pinig�, kur� norite pad�ti � biud�et�.");
    dialog_AddLine("Rankose turite: {AFEE9E}$%d", GetPlayerMoney(playerid));
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {
            new amount;
            if(sscanf(dialog_Input(),"d",amount) || !(0 < amount < 99999999))
                return _FMenu_Budget_Put(playerid, faction, .error = "Blogai �vestas kiekis.");

            if(GetPlayerMoney(playerid) < amount)
                return _FMenu_Budget_Put(playerid, faction, .error = "Tiek pinig� neturi.");

            FactionInfo[faction][fBudget] += amount;
            SaveFactionIntEx(faction, "Budget", FactionInfo[faction][fBudget]);
            GivePlayerMoney(playerid, -amount);
            
            MsgSuccess(playerid, "Frakcija", "Pad�jote $%d � frakcijos biud�et�.", amount);

            log_init(true);
            log_set_table("logs_factions");
            log_set_keys("`PlayerId`,`PlayerName`,`FactionId`,`FactionName`,`ActionText`,`Amount`");
            log_set_values("'%d','%e','%d','%e','(FM) Padejo i frakcijos biudzeta','%d'", LogPlayerId(playerid), LogPlayerName(playerid), FactionInfo[faction][fId], GetFactionName(faction, false), amount);
            log_commit();
        }
        FMenu_Budget_Main(playerid, faction);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Frakcijos biud�etas", "T�sti", "At�aukti");
    return 1;
}

static _FMenu_Budget_Take(playerid, faction, error[] = "")
{
    dialog_Clear();
    dialog_AddLine("{E4E4E4}�veskite kiek� pinig�, kur� norite nuimti i� biud�eto.");
    dialog_AddLine("Dabar yra: {AFEE9E}$%d", FactionInfo[faction][fBudget]);
    dialog_AddErrorLine(error);
    
    inline input(response, listitem)
    {
        if(response)
        {
            new amount;
            if(sscanf(dialog_Input(),"d",amount) || !(0 < amount < 999999999))
                return _FMenu_Budget_Take(playerid, faction, .error = "Blogai �vestas kiekis.");

            if(FactionInfo[faction][fBudget] < amount)
                return _FMenu_Budget_Take(playerid, faction, .error = "Tiek pinig� n�ra.");

            FactionInfo[faction][fBudget] -= amount;
            SaveFactionIntEx(faction, "Budget", FactionInfo[faction][fBudget]);
            GivePlayerMoney(playerid, amount);

            MsgSuccess(playerid, "Frakcija", "Pa�mete $%d i� frakcijos biud�eto.", amount);
            
            log_init(true);
            log_set_table("logs_factions");
            log_set_keys("`PlayerId`,`PlayerName`,`FactionId`,`FactionName`,`ActionText`,`Amount`");
            log_set_values("'%d','%e','%d','%e','(FM) Paeme is frakcijos biudzeto','%d'", LogPlayerId(playerid), LogPlayerName(playerid), FactionInfo[faction][fId], GetFactionName(faction, false), amount);
            log_commit();
        }   
        FMenu_Budget_Main(playerid, faction);
    }
	// DIALOG_FM_BUDGET_TAKE
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Frakcijos biud�etas", "T�sti", "At�aukti");
    return 1;
}