stock FMenu_Workers_Main(playerid, faction)
{
    inline loadWorkers()
    {
        new workerid, workerlevel, workername[24], workerrank[24],
            status[24],
            bool:warned,
            rows = cache_num_rows();

        dialog_Clear();
        dialog_AddLine("{BABABA}Vardas\t{BABABA}Rangas\t{BABABA}Statusas{FFFFFF}");
        for(new i = 0; i < rows; i++)
        {
            cache_get_value_name_int(i, "id", workerid);
            cache_get_value_name_int(i, "JobLevel", workerlevel);
            
            if((workerid = FindPlayerBySql(workerid)) != INVALID_PLAYER_ID)
            {
                format(status, sizeof status, "{6ACC4F}prisijung�s");
                GetPlayerName(workerid, workername, sizeof workername);
                workerid = 1;
            }

            else
            {
                format(status, sizeof status, "{CC4F4F}atsijung�s");
                cache_get_value_name(i, "Name", workername);
                workerid = 2;
            }

            if(workerlevel > 0 && workerlevel <= MAX_FACTION_RANKS)
            {
                format(workerrank, sizeof workerrank, (strlen(FactionRankNames[faction][workerlevel-1]) ? (FactionRankNames[faction][workerlevel-1]) : ("ranko n�ra")));
            }
            else
            {
                format(workerrank, sizeof workerrank, "{ERROR}");
                if(!warned)
                {
                    MsgError(playerid, "Frakcija", "Klaida j�s� frakcijos nari� rankuose. Pra�ome �iems nariams nustatyti rankus i� naujo arba juos i�mesti.");
                }
                warned = true;
            }
            dialog_AddLine("%s%s\t%s(%d)\t%s", (workerid != INVALID_PLAYER_ID ? ("{F7F7F7}") : ("{D7D7D7}")), workername, workerrank, workerlevel, status);
        }
        dialog_AddLine(">>> Priimti nauj� nar�");

        inline selectWrk(response, listitem)
        {
            if(response)
            {
                dialog_Row(">>> Priimti nauj� nar�") return _FMenu_Workers_AddNew(playerid, faction);
                inline getId()
                {
                    if(cache_num_rows())
                    {
                        new id;
                        cache_get_value_name_int(0, "id", id);
                        _FMenu_Workers_ShowDetails(playerid, faction, id);
                    }
                    return 1;
                }
                mysql_tquery_inline(chandler, using inline getId, "SELECT id FROM `players_data` WHERE Faction='%d' LIMIT 1 OFFSET %d", 
                    FactionInfo[faction][fId], listitem
                );
            }
            else FMenu_Main(playerid, faction);
        }
        dialog_Show(playerid, using inline selectWrk, DIALOG_STYLE_TABLIST_HEADERS, "Frakcijos nariai", "T�sti", "At�aukti");
        return 1;
    }
	mysql_tquery_inline(chandler, using inline loadWorkers, "\
        SELECT id,JobLevel,Name FROM `players_data` WHERE Faction = '%d'",
        PlayerInfo[playerid][pFaction]
    );
    return 1;
}

static _FMenu_Workers_AddNew(playerid, faction)
{
    dialog_Clear();
    dialog_AddLine("{E4E4E4}�veskite piln� �aid�jo vard�, kur� norite priimti � frakcij�.");
    inline input(response, listitem)
    {
        if(response)
        {
            new name[24];
            if(sscanf(dialog_Input(),"s[24]",name))
                return _FMenu_Workers_AddNew(playerid, faction);

            new receiverid = FindPlayerByName(name);
            if(receiverid == INVALID_PLAYER_ID)
            {
                inline loadWorkerId()
                {
                    if(!cache_num_rows())
                    {
                        SendWarning(playerid, "Toks �aid�jas nerastas.");
                        return _FMenu_Workers_AddNew(playerid, faction);
                    }
                    else
                    {
                        new id;
                        cache_get_value_name_int(0, "id", id);
                        cache_get_value_name(0, "Name", name);

                        inline checkPlayerFaction()
                        {
                            if(!cache_num_rows())
                            {
                                MsgError(playerid, "Frakcija", "�aid�jas jau frakcijoje.");
                                return _FMenu_Workers_AddNew(playerid, faction);
                            }

                            inline addWorker()
                            {
                                MsgSuccess(playerid, "Frakcija", "Pri�m�te %s � frakcij�", name);
                                return FMenu_Workers_Main(playerid, faction);
                            }
                            mysql_tquery_inline(chandler, using inline addWorker, "\
                                UPDATE `players_data` SET Faction = '%d', JobLevel = '1', FactionLeader = '0', Job = '0' WHERE id = '%d'",
                                PlayerInfo[playerid][pFaction], id
                            );
                            log_init(true);
                            log_set_table("logs_factions");
                            log_set_keys("`PlayerId`,`PlayerName`,`FactionId`,`FactionName`,`ActionText`,`ReceiverId`,`ReceiverName`");
                            log_set_values("'%d','%e','%d','%e','(FM) Prieme i frakcija','%d','%e'", LogPlayerId(playerid), LogPlayerName(playerid), PlayerInfo[playerid][pFaction], GetFactionName(PlayerInfo[playerid][pFaction]), id, name);
                            log_commit();
                        }
                        mysql_tquery_inline(chandler, using inline checkPlayerFaction, "SELECT NULL FROM `players_data` WHERE id = '%d' AND Faction = '0' AND Job = '0'", id);   
                    }
                    return 1;
                }
                mysql_tquery_inline(chandler, using inline loadWorkerId, "SELECT id,Name FROM `players_data` WHERE Name = '%e'", name);
                return 1;
            }
            else
            {
                if(PlayerInfo[receiverid][pFaction] != 0)
                {
                    MsgError(playerid, "Frakcija", "�aid�jas jau yra frakcijoje.");
                    return _FMenu_Workers_AddNew(playerid, faction);
                }
                PlayerInfo[receiverid][pJob] = 0;
                PlayerInfo[receiverid][pFaction] = PlayerInfo[playerid][pFaction];
                PlayerInfo[receiverid][pJobLevel] = 1;
                PlayerInfo[receiverid][pFactionLeader] = 0;

                SaveAccountIntEx(receiverid, "Faction", PlayerInfo[receiverid][pFaction]);
                SaveAccountIntEx(receiverid, "JobLevel", 1);

                MsgSuccess(receiverid, "Frakcija", "%s prid�jo jus � frakcij� \"%s\"", GetPlayerNameEx(playerid), FactionInfo[faction][fName]);
                MsgSuccess(playerid, "Frakcija", "Pri�m�te %s � frakcij�.", GetPlayerNameEx(receiverid));
                
                log_init(true);
                log_set_table("logs_factions");
                log_set_keys("`PlayerId`,`PlayerName`,`FactionId`,`FactionName`,`ActionText`,`ReceiverId`,`ReceiverName`");
                log_set_values("'%d','%e','%d','%e','(FM) Prieme i frakcija','%d'", LogPlayerId(playerid), LogPlayerName(playerid), FactionInfo[faction][fId], GetFactionName(faction, false), LogPlayerId(receiverid), LogPlayerName(receiverid));
                log_commit();
            }
        }
        FMenu_Workers_Main(playerid, faction);
        return 1;
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Frakcijos nariai", "T�sti", "At�aukti");
    return 1;
}


stock _FMenu_Workers_ShowDetails(playerid, faction, workerid)
{
    dialog_Clear();
    dialog_AddLine(GetNameBySql(workerid));
    dialog_AddLine("{FFFFFF}Keisti rang�");
    if(FactionInfo[faction][fType] == FACTION_TYPE_POLICE)
    {
        dialog_AddLine("Keisti privilegijas");
    }
    dialog_AddLine("{C60000}I�mesti");

    inline select(response, listitem)
    {
        if(response)
        {
            dialog_Row("Keisti rang�")          return _FMenu_Workers_ChangeRank(playerid, faction, workerid);
            dialog_Row("Keisti privilegijas")   return _FMenu_Workers_ChangePrivileges(playerid, faction, workerid);
            dialog_Row("I�mesti")               return _FMenu_Workers_Fire(playerid, faction, workerid);
            _FMenu_Workers_ShowDetails(playerid, faction, workerid);
        }   
        else FMenu_Workers_Main(playerid, faction);
        return 1;
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_LIST, "Frakcijos nario valdymas", "T�sti", "At�aukti");
    return 1;
}

static _FMenu_Workers_ChangeRank(playerid, faction, workerid)
{
    dialog_Clear();
    dialog_AddLine("{E4E4E4}�veskite nauj� rang� frakcijos nariui.");
    inline input(response, listitem)
    {
        if(response)
        {
            new rankid;
            if(sscanf(dialog_Input(),"d",rankid) || !(0 <= rankid <= MAX_FACTION_RANKS) || !strlen(FactionRankNames[faction][rankid-1]))
            {
                MsgError(playerid, "Frakcija", "Tokio rango n�ra.");
                return _FMenu_Workers_ChangeRank(playerid, faction, workerid);
            }
        
            new receiverid;
            if((receiverid = FindPlayerBySql(workerid)) != INVALID_PLAYER_ID)
            {
                MsgSuccess(receiverid, "Frakcija", "%s pakeit� j�s� rang� � %s", GetPlayerNameEx(playerid), FactionRankNames[faction][rankid-1]);
                PlayerInfo[receiverid][pJobLevel] = rankid;
                SaveAccountIntEx(receiverid, "JobLevel", rankid);

                if(!strlen(FactionRankNames[faction][rankid]) || rankid == MAX_FACTION_RANKS) // ar sitas rank yra max
                {
                    PlayerInfo[receiverid][pFactionLeader] = 1;
                    SaveAccountIntEx(receiverid, "FactionLeader", 1);
                }
            }
            else
            {
                inline updateWorker()
                {
                    return 1;
                }
                mysql_tquery_inline(chandler, using inline updateWorker, "\
                    UPDATE `players_data` SET JobLevel = '%d',FactionLeader='%d' WHERE id = '%d'", 
                    rankid, rankid==MAX_FACTION_RANKS ? (1) : (0), workerid
                );
            }
            MsgSuccess(playerid, "Frakcija", "Pakeit�te %s rang� � %s", GetNameBySql(workerid), FactionRankNames[faction][rankid-1]);
            log_init(true);
            log_set_table("logs_factions");
            log_set_keys("`PlayerId`,`PlayerName`,`ReceiverId`,`ReceiverName`,`FactionId`,`FactionName`,`ActionText`,`ExtraString`");
            log_set_values("'%d','%e','%d','%e','%d','%e','(FM) Pakeite ranga','%e'", LogPlayerId(playerid), LogPlayerName(playerid), workerid, GetNameBySql(workerid), GetFactionName(faction, false), FactionInfo[faction][fId], FactionRankNames[faction][rankid-1]);
            log_commit();
        }
        else _FMenu_Workers_ShowDetails(playerid, faction, workerid);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Frakcijos nariai", "T�sti", "At�aukti");
    return 1;
}

static _FMenu_Workers_ChangePrivileges(playerid, faction, workerid)
{
    new perm[3];
    if(FactionInfo[faction][fType] != FACTION_TYPE_POLICE)
        return _FMenu_Workers_ShowDetails(playerid, faction, workerid);

    inline loadPrivs()
    {
        if(cache_num_rows())
        {
            cache_get_value_name_int(0, "FactionPermission1", perm[0]);
            cache_get_value_name_int(0, "FactionPermission2", perm[1]);
            cache_get_value_name_int(0, "FactionPermission3", perm[2]);
            dialog_AddLine("%s SWAT", perm[0] > 0 ? ("Nuimti") : ("U�d�ti"));
            dialog_AddLine("%s detektyv�", perm[1] > 0 ? ("Nuimti") : ("U�d�ti"));
            dialog_AddLine("%s spec. komandas", perm[2] > 0 ? ("Nuimti") : ("U�d�ti"));

            inline select(response, listitem)
            {
                if(response)
                {
                    new receiverid = FindPlayerBySql(workerid);
                    log_init(true);
                    log_set_table("logs_factions");
                    log_set_keys("`PlayerId`,`PlayerName`,`FactionId`,`FactionName`,`ActionText`,`ReceiverId`,`ReceiverName`");
                    log_set_values("'%d','%e','%d','%e','(FM) Pakeite grupes nustatyma darbuotojui','%d','%e'", LogPlayerId(playerid), LogPlayerName(playerid), PlayerInfo[playerid][pFaction], GetFactionName(PlayerInfo[playerid][pFaction]), workerid, GetNameBySql(workerid));
                    log_commit();

                    inline updateWorker()
                    {
                        MsgSuccess(playerid, "Frakcija", "Nustatymai darbuotojui atnaujinti.");
                        return 1;
                    }
                    mysql_tquery_inline(chandler, using inline updateWorker, "\
                        UPDATE `players_data` SET `FactionPermission%d` = '%d' WHERE id = '%d'", 
                        listitem + 1, !perm[listitem], workerid
                    );

                    if(IsPlayerConnected(receiverid) && PlayerInfo[receiverid][pFaction] == PlayerInfo[playerid][pFaction])
                    {
                        PlayerInfo[receiverid][pFactionPermissions][listitem] = !PlayerInfo[playerid][pFactionPermissions][listitem];
                        MsgSuccess(receiverid, "Frakcija", "J�s� frakcijos grup� buvo %s", PlayerInfo[playerid][pFactionPermissions][listitem] > 0 ? ("u�d�ta") : ("nuimta"));
                    }
                }
				_FMenu_Workers_ShowDetails(playerid, faction, workerid);
                return 1;
            }
            dialog_Show(playerid, using inline select, DIALOG_STYLE_LIST, "Frakcijos nariai", "T�sti", "At�aukti");
        }
        return 1;
    }
    mysql_tquery_inline(chandler, using inline loadPrivs, "\
        SELECT FactionPermission1, FactionPermission2, FactionPermission3 FROM `players_data` WHERE id = '%d'",
        workerid
    );
    return 1;
}

static _FMenu_Workers_Fire(playerid, faction, workerid)
{
    new receiverid;
    if((receiverid = FindPlayerBySql(workerid)) != INVALID_PLAYER_ID)
    {
        Player_LeaveFaction(receiverid);
        MsgWarning(playerid, "Frakcija", "Buvote i�mestas i� frakcijos.");
    }

    inline updateWorker()
    {
        MsgWarning(playerid, "Frakcija", "I�met�te %s i� frakcijos.", GetNameBySql(workerid));
        FMenu_Workers_Main(playerid, faction);
        return 1;
    }
    mysql_tquery_inline(chandler, using inline updateWorker, "\
        UPDATE `players_data` SET \
            Faction = '0', FactionPermission1 = '0', FactionPermission2 = '0', FactionPermission3 = '0', JobLevel = '0',\
            PoliceBadge = '0', RadioChannel = '0' WHERE id = '%d'", 
        workerid
    );

    log_init(true);
    log_set_table("logs_factions");
    log_set_keys("`PlayerId`,`PlayerName`,`ReceiverId`,`ReceiverName`,`FactionId`,`FactionName`,`ActionText`");
    log_set_values("'%d','%e','%d','%e','%d','%e','(FM) Ismete is frakcijos'", LogPlayerId(playerid), LogPlayerName(playerid), workerid, GetNameBySql(workerid), GetFactionName(faction, false), FactionInfo[faction][fId]);
    log_commit();
    return 1;
}
