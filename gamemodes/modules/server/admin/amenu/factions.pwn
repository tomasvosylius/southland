/** External */
stock AMenu_Factions_Main(playerid)
{
    _Factions_Main(playerid);
    return 1;
}

/** Internals */
static _Factions_Main(playerid)
{
    dialog_Clear();
    dialog_AddLine("Kurti naujà");
    dialog_AddLine("Perþiûrëti visas");

    inline select(response, listitem)
    {
        if(!response) return AMenu_Main(playerid);

        dialog_Row("Kurti naujà")       return _Factions_Add(playerid);
        dialog_Row("Perþiûrëti visas")  return _Factions_ShowList(playerid);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_LIST, "Frakcijos", "Tæsti", "Atðaukti");
    return 1;
}

static _Factions_Add(playerid)
{
    if(!HaveAdminPermission(playerid, "CreateNewFaction"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Factions_Main(playerid);
    }

    dialog_Clear();
    dialog_AddLine("{FFFFFF}Áveskite naujos frakcijos pavadinimà.");
    inline input(response, listitem)
    {
        if(response)
        {
            new name[48];
            if(sscanf(dialog_Input(),"s[48]",name))
                return _Factions_Add(playerid);

            inline insertNew()
            {
                new iter = Iter_Free(Faction);
                FactionInfo[iter][fId] = cache_insert_id();
                format(FactionInfo[iter][fName], 48, name);
                Iter_Add(Faction, iter);
        
                MsgSuccess(playerid, "Frakcijos", "Frakcija sëkmingai sukurta.");
                _Factions_ShowDetails(playerid, iter);

                log_init(true);
                log_set_table("logs_admins");
                log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`ExtraString`");
                log_set_values("'%d','%e','(AM) Sukure nauja frakcija','%d','%e'", LogPlayerId(playerid), LogPlayerName(playerid), FactionInfo[iter][fId], FactionInfo[iter][fName]);
                log_commit();
                return 1;
            }
            mysql_tquery_inline(chandler, using inline insertNew, "\
                INSERT INTO `factions_data` (`Name`,`Added`) VALUES ('%e','%d')",
                name, PlayerInfo[playerid][pId]
            );
        }
        else _Factions_Main(playerid);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Frakcijos", "Kurti", "Atðaukti");
    return 1;
}

static _Factions_ShowList(playerid)
{
    if(!HaveAdminPermission(playerid, "EditFactions"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Factions_Main(playerid);
    }

    new i = 0,
        type[16];

    dialog_Clear();
    dialog_AddLine("{BABABA}Nr.\t{BABABA}Pavadinimas\t{BABABA}Tipas");

    foreach(new faction : Faction)
    {
        if(FactionInfo[faction][fId] == 0) { continue; }
        i++;
        switch(FactionInfo[faction][fType])
        {
            case FACTION_TYPE_POLICE:       format(type, sizeof type, "PD");
            case FACTION_TYPE_FIRE:         format(type, sizeof type, "FD/MD");
            case FACTION_TYPE_GOVERNMENT:   format(type, sizeof type, "Savivaldybë");
            case FACTION_TYPE_LEGAL:        format(type, sizeof type, "Legali fr.");
            case FACTION_TYPE_ILLEGAL:      format(type, sizeof type, "Nelegali fr.");
            case FACTION_TYPE_SAN_NEWS:     format(type, sizeof type, "San News");
            case FACTION_TYPE_NONE:         format(type, sizeof type, "Paprasta");
            default: format(type, sizeof type, "Neþinoma");
        }
        dialog_AddLine("%d.\t%s (MySQL ID: %d)\t%s", i, FactionInfo[faction][fName], FactionInfo[faction][fId], type);
    }
    inline select(response, listitem)
    {
        if(response)
        {
            new faction;
            GetSortedAsForeach(Faction, listitem, faction, FactionInfo[loopindex][fId] != 0);
            _Factions_ShowDetails(playerid, faction);
        }
        else _Factions_Main(playerid);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_TABLIST_HEADERS, "Frakcijos", "Tæsti", "Atðaukti");
    return 1;
}

static _Factions_ShowDetails(playerid, faction)
{
    dialog_Clear();
    dialog_AddLine("Keisti pavadinimà");
    dialog_AddLine("Redaguoti rankus");
    dialog_AddLine("Keisti spawn vietà");
    dialog_AddLine("Keisti tipà");
    dialog_AddLine("Suteikti/atimti frakcijos chat");
    dialog_AddLine("{C60000}Iðtrinti");

    inline select(response, listitem)
    {
        if(response)
        {
            dialog_Row("Keisti pavadinimà")              return _Factions_ChangeName(playerid, faction);
            dialog_Row("Redaguoti rankus")               return _Factions_Ranks_ShowList(playerid, faction);
            dialog_Row("Keisti spawn vietà")             return _Factions_ChangeSpawn(playerid, faction);
            dialog_Row("Keisti tipà")                    return _Factions_ChangeType(playerid, faction);
            dialog_Row("Suteikti/atimti frakcijos chat") return _Factions_ChangeFChat(playerid, faction);
            dialog_Row("{C60000}Iðtrinti")               return _Factions_Delete(playerid, faction);
        }
        else _Factions_ShowList(playerid);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_LIST, "Frakcijos", "Tæsti", "Atðaukti");
    return 1;
}

static _Factions_ChangeName(playerid, faction)
{
    dialog_Clear();
    dialog_AddLine("{FFFFFF}Áveskite naujà frakcijos pavadinimà.");
    inline input(response, listitem)
    {
        if(response)
        {
            new name[48];
            if(sscanf(dialog_Input(),"s[48]",name))
                return _Factions_ChangeName(playerid, faction);

            format(FactionInfo[faction][fName], 48, name);
            SaveFactionEx(faction, "Name", name);
            MsgSuccess(playerid, "Frakcijos", "Pavadinimas sëkmingai pakeistas á %s", name);
            
            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`ExtraString`");
            log_set_values("'%d','%e','(AM) Pakeite frakcijos pavadinima','%d','%e'", LogPlayerId(playerid), LogPlayerName(playerid), FactionInfo[faction][fId], dialog_Input());
            log_commit();
        }
        _Factions_ShowDetails(playerid, faction);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Frakcijos", "Tæsti", "Atðaukti");
    return 1;
}

static _Factions_Ranks_ShowList(playerid, faction)
{
    dialog_Clear();
    dialog_AddLine("{BABABA}Nr.\t{BABABA}Pavadinimas\t{BABABA}Alga");
    for(new i = 0; i < MAX_FACTION_RANKS; i++)
    {
        if(strlen(FactionRankNames[faction][i]) > 0)
        {
            dialog_AddLine("%d\t%s\t$%d", i+1, FactionRankNames[faction][i], FactionRankSalaries[faction][i]); 
        }
        else
        {
            dialog_AddLine("{82C84D}>>> PRIDËTI");
            break;
        }
    }

    inline select(response, listitem)
    {
        if(response)
        {
            dialog_Row(">>> PRIDËTI") return _Factions_Ranks_CreateNew(playerid, faction);
            return _Factions_Ranks_ShowDetails(playerid, faction, listitem);
        }
        else _Factions_ShowDetails(playerid, faction);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_TABLIST_HEADERS, "Frakcijos rankai", "Tæsti", "Atðaukti");
    return 1;
}

static _Factions_Ranks_CreateNew(playerid, faction)
{
    dialog_Clear();
    dialog_AddLine("{FFFFFF}Áveskite naujo ranko pavadinimà.");
    inline input(response, listitem)
    {
        if(response)
        {
            new name[24], bool:foundfree,
                rank = -1;
            if(sscanf(dialog_Input(),"s[24]",name))
                return _Factions_Ranks_CreateNew(playerid, faction);
            
            for(rank = 0; rank < sizeof FactionRankIds[]; rank++)
            {
                if(FactionRankIds[faction][rank] == 0)
                {
                    foundfree = true;
                    break;
                }
            }
            if(!foundfree)
            {
                SendWarning(playerid, "Pasiektas rankø limitas.");
                return _Factions_Ranks_ShowList(playerid, faction);
            }

            inline insertNew()
            {
                MsgSuccess(playerid, "Frakcijos", "Sëkmingai pridëjote rankà.");
                
                FactionRankIds[faction][rank] = cache_insert_id();
                format(FactionRankNames[faction][rank], 84, name);
                FactionRankSalaries[faction][rank] = 0;

                _Factions_Ranks_ShowList(playerid, faction);
                return 1;
            }
            mysql_tquery_inline(chandler, using inline insertNew, "\
                INSERT INTO `factions_ranks` (`FactionId`,`Name`,`Added`,`Salary`,`Rank`) \
                (SELECT '%d','%e','%d','0',MAX(Rank)+1 FROM `factions_ranks` WHERE FactionId = '%d')",
                FactionInfo[faction][fId], name, PlayerInfo[playerid][pId], FactionInfo[faction][fId]
            );

            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`ExtraString`,`ReceiverId`");
            log_set_values("'%d','%e','(AM) Pridejo frakcijos ranka','%d','%e','%d'", LogPlayerId(playerid), LogPlayerName(playerid), FactionInfo[faction][fId], name, rank+1);
            log_commit();
        }
        else _Factions_Ranks_ShowList(playerid, faction);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Frakcijos rankai", "Tæsti", "Atðaukti");
    return 1;
}

stock _Factions_Ranks_ShowDetails(playerid, faction, rank)
{
    if(FactionRankIds[faction][rank] != 0)
    {
        // edit
        dialog_Clear();
        dialog_AddLine("{BABABA}Nustatymas\t{BABABA}Dabartinë reikðmë");
        dialog_AddLine("Pavadinimas\t%s", FactionRankNames[faction][rank]);
        dialog_AddLine("Alga\t$%d", FactionRankSalaries[faction][rank]);
        if(rank != 0) dialog_AddLine("{C60000}Iðtrinti");

        inline select(response, listitem)
        {
            if(response)
            {
                dialog_Row("Pavadinimas")   return _Factions_Ranks_ChangeName(playerid, faction, rank);
                dialog_Row("Alga")          return _Factions_Ranks_ChangeSalary(playerid, faction, rank);
                dialog_Row("Iðtrinti")      return _Factions_Ranks_Delete(playerid, faction, rank);
            }
            else _Factions_Ranks_ShowList(playerid, faction);
        }
        dialog_Show(playerid, using inline select, DIALOG_STYLE_TABLIST_HEADERS, "Frakcijos rankai", "Tæsti", "Atðaukti");
    }
    else _Factions_ShowDetails(playerid, faction);
    return 1;
}

static _Factions_Ranks_ChangeName(playerid, faction, rank)
{
    dialog_Clear();
    dialog_AddLine("{FFFFFF}Áveskite naujà ranko pavadinimà.");
    inline input(response, listitem)
    {
        if(response)
        {
            new name[84];
            if(sscanf(dialog_Input(),"s[84]",name))
                return _Factions_Ranks_ChangeName(playerid, faction, rank);
                
            format(FactionRankNames[faction][rank], 84, name);
            inline updateRank()
            {
                MsgSuccess(playerid, "Frakcijos", "Ranko pavadinimas sëkmingai pakeistas.");
                _Factions_Ranks_ShowDetails(playerid, faction, rank);
                return 1;
            }
            mysql_tquery_inline(chandler, using inline updateRank, "UPDATE `factions_ranks` SET Name = '%e' WHERE id = '%d'", name, FactionRankIds[faction][rank]);
            
            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`ExtraString`,`ReceiverId`");
            log_set_values("'%d','%e','(AM) Pakeite frakcijos ranko pavadinima','%d','%e','%d'", LogPlayerId(playerid), LogPlayerName(playerid), FactionInfo[faction][fId], name, rank+1);
            log_commit();
        }
        else _Factions_Ranks_ShowDetails(playerid, faction, rank);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Frakcijos rankai", "Tæsti", "Atðaukti");
    return 1;
}
static _Factions_Ranks_ChangeSalary(playerid, faction, rank)
{
    dialog_Clear();
    dialog_AddLine("{FFFFFF}Áveskite naujà ranko algà.");
    inline input(response, listitem)
    {
        if(response)
        {
            new salary;
            if(sscanf(dialog_Input(),"d",salary) || !(0 < salary <= 9999999))
                return _Factions_Ranks_ChangeSalary(playerid, faction, rank);

            FactionRankSalaries[faction][rank] = salary;
            inline updateRank()
            {
                MsgSuccess(playerid, "Frakcijos", "Ranko alga sëkmingai pakeista.");
                _Factions_Ranks_ShowDetails(playerid, faction, rank);
                return 1;
            }
            mysql_tquery_inline(chandler, using inline updateRank, "\
                UPDATE `factions_ranks` SET Salary = '%d' WHERE id = '%d'",
                salary, FactionRankIds[faction][rank]
            );

            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`ExtraString`,`ReceiverId`,`Amount`");
            log_set_values("'%d','%e','(AM) Pakeite frakcijos ranko alga','%d','%e','%d','%d'", LogPlayerId(playerid), LogPlayerName(playerid), FactionInfo[faction][fId], FactionRankNames[faction][rank], rank+1, salary);
            log_commit();
        }
        else _Factions_Ranks_ShowDetails(playerid, faction, rank);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Frakcijos rankai", "Tæsti", "Atðaukti");
    return 1;
}

static _Factions_Ranks_Delete(playerid, faction, rank)
{
    log_init(true);
    log_set_table("logs_admins");
    log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`ExtraString`,`ReceiverId`");
    log_set_values("'%d','%e','(AM) Istryne frakcijos ranka','%d','%e','%d'", LogPlayerId(playerid), LogPlayerName(playerid), FactionInfo[faction][fId], FactionRankNames[faction][rank], rank+1);
    log_commit();

    inline deleteRank()
    {
        MsgSuccess(playerid, "Frakcijos", "Rankas sëkmingai iðtrintas");
        _Factions_Ranks_ShowList(playerid, faction);
        return 1;
    }
    mysql_tquery_inline(chandler, using inline deleteRank, "\
        DELETE FROM `factions_ranks` WHERE id = '%d';\
        UPDATE `factions_ranks` SET `Rank` = `Rank`-1 WHERE `Rank` > '%d'",
        FactionRankIds[faction][rank],
        rank+1
    );

    FactionRankIds[faction][rank] =
    FactionRankSalaries[faction][rank] = 0;
    format(FactionRankNames[faction][rank], 2, "");

    for(new i = rank; i < MAX_FACTION_RANKS; i++)
    {
        if(i != MAX_FACTION_RANKS-1)
        {
            FactionRankIds[faction][i] = FactionRankIds[faction][i+1];
            FactionRankSalaries[faction][i] = FactionRankSalaries[faction][i+1];
            strmid(FactionRankNames[faction][i], FactionRankNames[faction][i+1], 0, 84);
        }
    }
    return 1;
}

static _Factions_ChangeSpawn(playerid, faction)
{
    if(GetPlayerInterior(playerid) != 0 || GetPlayerVirtualWorld(playerid) != 0)
    {
        SendError(playerid, "Turite bûti lauke");
        return _Factions_ShowDetails(playerid, faction);
    }
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    FactionInfo[faction][fSpawnX] = x,
    FactionInfo[faction][fSpawnY] = y,
    FactionInfo[faction][fSpawnZ] = z;

    SaveFactionFloatEx(faction, "SpawnX", FactionInfo[faction][fSpawnX]);
    SaveFactionFloatEx(faction, "SpawnY", FactionInfo[faction][fSpawnY]);
    SaveFactionFloatEx(faction, "SpawnZ", FactionInfo[faction][fSpawnZ]);

    MsgSuccess(playerid, "Frakcijos", "SPAWN vieta sëkmingai pakeista.");
    _Factions_ShowDetails(playerid, faction);

    log_init(true);
    log_set_table("logs_admins");
    log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`");
    log_set_values("'%d','%e','(AM) Pakeite frakcijos spawn','%d'", LogPlayerId(playerid), LogPlayerName(playerid), FactionInfo[faction][fId]);
    log_commit();
    return 1;
}

static _Factions_ChangeType(playerid, faction)
{
    dialog_Clear();
    dialog_AddLine("Paprasta frakcija");
    dialog_AddLine("Policijos departamentas");
    dialog_AddLine("Ugniagesiai/medicinos departmentas");
    dialog_AddLine("Savivaldybë");
    dialog_AddLine("Nelegali frakcija");
    dialog_AddLine("Legali frakcija");
    dialog_AddLine("San News");
    inline select(response, listitem)
    {
        if(response)
        {  
            FactionInfo[faction][fType] = listitem;
            MsgSuccess(playerid, "Frakcijos", "Tipas sëkmingai pakeistas.");
            SaveFactionIntEx(faction, "Type", listitem);
            
            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`Amount`");
            log_set_values("'%d','%e','(AM) Pakeite frakcijos tipa','%d','%d'", LogPlayerId(playerid), LogPlayerName(playerid), FactionInfo[faction][fId], listitem);
            log_commit();
        }
        _Factions_ShowDetails(playerid, faction);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_LIST, "Frakcijos", "Tæsti", "Atðaukti");
    return 1;
}

static _Factions_ChangeFChat(playerid, faction)
{
    FactionInfo[faction][fHasChat] = !FactionInfo[faction][fHasChat];
    SaveFactionIntEx(faction, "HasChat", FactionInfo[faction][fHasChat]);
    MsgSuccess(playerid, "Frakcijos", "Frakcijos %s pokalbiø kanalas buvo %s.", FactionInfo[faction][fName], (FactionInfo[faction][fHasChat] > 0 ? ("sukurtas") : ("iðtrintas")));
    
    log_init(true);
    log_set_table("logs_admins");
    log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`Amount`");
    log_set_values("'%d','%e','(AM) Pakeite frakcijos chat turejima','%d','%d'", LogPlayerId(playerid), LogPlayerName(playerid), FactionInfo[faction][fId], FactionInfo[faction][fHasChat]);
    log_commit();

    _Factions_ShowDetails(playerid, faction);
    return 1;
}

static _Factions_Delete(playerid, faction)
{
    // istrinti
    new __reset_Faction[E_FACTION_DATA];

    log_init(true);
    log_set_table("logs_admins");
    log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`ExtraString`");
    log_set_values("'%d','%e','(AM) Istryne frakcija','%d','%e'", LogPlayerId(playerid), LogPlayerName(playerid), FactionInfo[faction][fId], FactionInfo[faction][fName]);
    log_commit();

    inline deleteFaction()
    {
        foreach(new receiverid : Player)
        {
            if(PlayerInfo[receiverid][pFaction] == FactionInfo[faction][fId])
            {
                PlayerInfo[receiverid][pFaction] =
                PlayerInfo[receiverid][pFactionLeader] =
                PlayerInfo[receiverid][pJobLevel] = 0;
                MsgError(receiverid, "Informacija", "Frakcija, kurioje dirbote, buvo iðtrinta.");
            }
        }

        MsgSuccess(playerid, "FRAKCIJOS", "Frakcija sëkmingai iðtrinta.");
        _Factions_ShowList(playerid);
        return 1;
    }
    mysql_tquery_inline(chandler, using inline deleteFaction, "\
        DELETE FROM `factions_data` WHERE id = '%d';\
        DELETE FROM `factions_ranks` WHERE FactionId = '%d';\
        UPDATE `players_data` SET Faction = '0' AND JobLevel = '0' WHERE Faction = '%d'", 
        FactionInfo[faction][fId], FactionInfo[faction][fId], FactionInfo[faction][fId]
    );
    for(new i = 0; i < MAX_FACTION_RANKS; i++)
    {
        format(FactionRankNames[faction][i], 2, " ");
        FactionRankSalaries[faction][i] = 0;
    }
    FactionInfo[faction] = __reset_Faction;
    Iter_Remove(Faction, faction);
    return 1;
}