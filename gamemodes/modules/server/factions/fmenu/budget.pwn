stock FMenu_Budget_Main(playerid, faction)
{
    // biudzetas
    dialog_Clear();
    dialog_AddLine("Frakcijos biudþete: {AFEE9E}$%d", FactionInfo[faction][fBudget]);
    dialog_AddLine("{8BDA76}Padëti á biudþetà");
    dialog_AddLine("{E47059}Paimti ið biudþeto");
    inline select(response, listitem)
    {
        if(response)
        {
            dialog_Row("Padëti") return _FMenu_Budget_Put(playerid, faction);
            dialog_Row("Paimti") return _FMenu_Budget_Take(playerid, faction);
            FMenu_Budget_Main(playerid, faction);
        }
        else FMenu_Main(playerid, faction);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_LIST, "Frakcijos biudþetas", "Tæsti", "Atðaukti");
    return 1;
}

static _FMenu_Budget_Put(playerid, faction, error[] = "")
{
    dialog_Clear();
    dialog_AddLine("{E4E4E4}Áveskite kieká pinigø, kurá norite padëti á biudþetà.");
    dialog_AddLine("Rankose turite: {AFEE9E}$%d", GetPlayerMoney(playerid));
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {
            new amount;
            if(sscanf(dialog_Input(),"d",amount) || !(0 < amount < 99999999))
                return _FMenu_Budget_Put(playerid, faction, .error = "Blogai ávestas kiekis.");

            if(GetPlayerMoney(playerid) < amount)
                return _FMenu_Budget_Put(playerid, faction, .error = "Tiek pinigø neturi.");

            FactionInfo[faction][fBudget] += amount;
            SaveFactionIntEx(faction, "Budget", FactionInfo[faction][fBudget]);
            GivePlayerMoney(playerid, -amount);
            
            MsgSuccess(playerid, "Frakcija", "Padëjote $%d á frakcijos biudþetà.", amount);

            log_init(true);
            log_set_table("logs_factions");
            log_set_keys("`PlayerId`,`PlayerName`,`FactionId`,`FactionName`,`ActionText`,`Amount`");
            log_set_values("'%d','%e','%d','%e','(FM) Padejo i frakcijos biudzeta','%d'", LogPlayerId(playerid), LogPlayerName(playerid), FactionInfo[faction][fId], GetFactionName(faction, false), amount);
            log_commit();
        }
        FMenu_Budget_Main(playerid, faction);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Frakcijos biudþetas", "Tæsti", "Atðaukti");
    return 1;
}

static _FMenu_Budget_Take(playerid, faction, error[] = "")
{
    dialog_Clear();
    dialog_AddLine("{E4E4E4}Áveskite kieká pinigø, kurá norite nuimti ið biudþeto.");
    dialog_AddLine("Dabar yra: {AFEE9E}$%d", FactionInfo[faction][fBudget]);
    dialog_AddErrorLine(error);
    
    inline input(response, listitem)
    {
        if(response)
        {
            new amount;
            if(sscanf(dialog_Input(),"d",amount) || !(0 < amount < 999999999))
                return _FMenu_Budget_Take(playerid, faction, .error = "Blogai ávestas kiekis.");

            if(FactionInfo[faction][fBudget] < amount)
                return _FMenu_Budget_Take(playerid, faction, .error = "Tiek pinigø nëra.");

            FactionInfo[faction][fBudget] -= amount;
            SaveFactionIntEx(faction, "Budget", FactionInfo[faction][fBudget]);
            GivePlayerMoney(playerid, amount);

            MsgSuccess(playerid, "Frakcija", "Paëmete $%d ið frakcijos biudþeto.", amount);
            
            log_init(true);
            log_set_table("logs_factions");
            log_set_keys("`PlayerId`,`PlayerName`,`FactionId`,`FactionName`,`ActionText`,`Amount`");
            log_set_values("'%d','%e','%d','%e','(FM) Paeme is frakcijos biudzeto','%d'", LogPlayerId(playerid), LogPlayerName(playerid), FactionInfo[faction][fId], GetFactionName(faction, false), amount);
            log_commit();
        }   
        FMenu_Budget_Main(playerid, faction);
    }
	// DIALOG_FM_BUDGET_TAKE
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Frakcijos biudþetas", "Tæsti", "Atðaukti");
    return 1;
}