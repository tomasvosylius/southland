/** External */
stock AMenu_Enters_Main(playerid)
{
    _Enters_Main(playerid);
    return 1;
}

/** Internals */
static _Enters_Main(playerid)
{
    dialog_Clear();
    dialog_AddLine("Kurti naujà");
    dialog_AddLine("Perþiûrëti visus");

    inline select(response, listitem)
    {
        if(response)
        {
            dialog_Row("Kurti naujà")       return _Enters_CreateNew(playerid);
            dialog_Row("Perþiûrëti visus")  return _Enters_ShowList(playerid);
        }
        else AMenu_Main(playerid);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_LIST, "Serverio iðëjimai/áëjimai", "Tæsti", "Atðaukti");
    return 1;
}

static _Enters_CreateNew(playerid, error[] = "")
{
    dialog_Clear();
    dialog_AddLine("{FFFFFF}Áveskite naujo áëjimo pavadinimà.");
    dialog_AddLine("{BABABA}Jis bus rodomas tik áëjimo vietoje. Iðëjimo vietoje bus rodoma \"Iðëjimas\"");

    inline input(response, listitem)
    {
        if(response)
        {
            if(strlen(dialog_Input()) < 3 || strlen(dialog_Input()) > 32)
                return _Enters_CreateNew(playerid, .error = "Pavadinimas per trumpas arba per ilgas.");
            
            new iter = -1;
            if((iter = Iter_Free(EnterExit)) != -1)
            {
                new Float:x, Float:y, Float:z;
                GetPlayerPos(playerid, x, y, z);

                inline insertNew()
                {
                    if(mysql_errno() == 0)
                    {
                        EntersExits[iter][eeId] = cache_insert_id();
                        Iter_Add(EnterExit, iter);

                        MsgSuccess(playerid, "ÁËJIMAI/IÐËJIMAI", "Sëkmingai sukûrëte áëjimà, kurio ID: %d. Praðome nustatyti iðëjimo koordinates.", EntersExits[iter][eeId]);
                        
                        format(EntersExits[iter][eeName], 32, dialog_Input());
                        EntersExits[iter][eeEnterX] = x,
                        EntersExits[iter][eeEnterY] = y,
                        EntersExits[iter][eeEnterZ] = z,
                        EntersExits[iter][eeEnterVW] = GetPlayerVirtualWorld(playerid),
                        EntersExits[iter][eeEnterInt] = GetPlayerInterior(playerid);

                        EnterExit_CreateLabel(iter);

                        log_init(true);
                        log_set_table("logs_admins");
                        log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`ExtraString`");
                        log_set_values("'%d','%e','(AM) Sukure nauja iejima (EE)','%d','%e'", LogPlayerId(playerid), LogPlayerName(playerid), EntersExits[iter][eeId], dialog_Input());
                        log_commit();
                    }
                    else
                    {
                        SendError(playerid, "Siøsta uþklausa nepavyko [%d]", mysql_errno());
                    }
                    return 1;
                }

                mysql_tquery_inline(chandler, using inline insertNew, "\
                    INSERT INTO `enters_exits` (`EnterX`, `EnterY`, `EnterZ`, `Name`, `EnterVW`, `EnterInt`, `Added`) \
                    VALUES \
                    ('%f','%f','%f','%e','%d','%d','%d')",
                    x, y, z, dialog_Input(), GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), PlayerInfo[playerid][pId]
                );
            }
        }
        _Enters_Main(playerid);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Serverio iðëjimo/áëjimo kûrimas", "Kurti", "Atðaukti");
    return 1;
}


static _Enters_ShowList(playerid)
{
    // esami iejimai
    new real_iter = 0;

    dialog_Clear();

    foreach(new id : EnterExit)
    {
        if(EntersExits[id][eeId] != 0)
        {
            tmpArray[playerid][real_iter] = id;

            dialog_AddLine("%d. %.12s(ID:%d)", 
                real_iter+1,
                EntersExits[id][eeName],
                strlen(EntersExits[id][eeName]) > 14 ? ("...") : (" "),
                EntersExits[id][eeId]
            );

            real_iter++;
        }
    }

    inline list(response, listitem)
    {
        if(response)
        {
            _Enters_ShowDetails(playerid, tmpArray[playerid][listitem]);
            return 1;
        }
        _Enters_Main(playerid);
    }
    dialog_Show(playerid, using inline list, DIALOG_STYLE_LIST, "Serverio iðëjimai/áëjimai", "Tæsti", "Atðaukti");
    return 1;
}

static _Enters_ShowDetails(playerid, iter)
{
    dialog_Clear();
    dialog_AddLine("Keisti pavadinimà");
    dialog_AddLine("Keisti pickup");
    dialog_AddLine("Keisti áëjimà");
    dialog_AddLine("Keisti iðëjimà");
    dialog_AddLine("Teleportuotis á áëjimà");
    dialog_AddLine("Teleportuotis á iðëjimà");
    dialog_AddLine("{C60000}Iðtrinti");

    inline edit(response, listitem)
    {
        if(response)
        {
            dialog_Row("Keisti pavadinimà")         return _Enters_ChangeName(playerid, iter);
            dialog_Row("Keisti pickup")             return _Enters_ChangePickup(playerid, iter);
            dialog_Row("Keisti áëjimà")
            {
                // keisti iejima
                new Float:x, Float:y, Float:z;
                GetPlayerPos(playerid, x, y, z);

                EntersExits[iter][eeEnterX] = x, EntersExits[iter][eeEnterY] = y, EntersExits[iter][eeEnterZ] = z,
                EntersExits[iter][eeEnterVW] = GetPlayerVirtualWorld(playerid),
                EntersExits[iter][eeEnterInt] = GetPlayerInterior(playerid);

                inline updatePos()
                {
                    EnterExit_CreateLabel(iter);
                    MsgSuccess(playerid, "ÁËJIMAI/IÐËJIMAI", "Áëjimo vieta sëkmingai pakeista");
                }
                mysql_tquery_inline(chandler, using inline updatePos, "UPDATE `enters_exits` SET EnterX = '%f', EnterY = '%f', EnterZ = '%f', EnterInt = '%d', EnterVW = '%d' WHERE id = '%d'",
                    x, y, z, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid), EntersExits[iter][eeId]
                );

                log_init(true);
                log_set_table("logs_admins");
                log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`ExtraString`");
                log_set_values("'%d','%e','(AM) Pakeite EE iejimo vieta','%d','%e'", LogPlayerId(playerid), LogPlayerName(playerid), EntersExits[iter][eeId], EntersExits[iter][eeName]);
                log_commit();
            }
            dialog_Row("Keisti iðëjimà")
            {
                // keisti isejima
                new Float:x, Float:y, Float:z;
                GetPlayerPos(playerid, x, y, z);

                EntersExits[iter][eeExitX] = x, EntersExits[iter][eeExitY] = y, EntersExits[iter][eeExitZ] = z,
                EntersExits[iter][eeExitVW] = GetPlayerVirtualWorld(playerid),
                EntersExits[iter][eeExitInt] = GetPlayerInterior(playerid);

                inline updatePos()
                {
                    EnterExit_CreateLabel(iter);
                    MsgSuccess(playerid, "ÁËJIMAI/IÐËJIMAI", "Iðëjimo vieta sëkmingai pakeista");
                }
                mysql_tquery_inline(chandler, using inline updatePos, "UPDATE `enters_exits` SET ExitX = '%f', ExitY = '%f', ExitZ = '%f', ExitInt = '%d', ExitVW = '%d' WHERE id = '%d'",
                    x, y, z, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid), EntersExits[iter][eeId]
                );

                log_init(true);
                log_set_table("logs_admins");
                log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`ExtraString`");
                log_set_values("'%d','%e','(AM) Pakeite EE isejimo vieta','%d','%e'", LogPlayerId(playerid), LogPlayerName(playerid), EntersExits[iter][eeId], EntersExits[iter][eeName]);
                log_commit();
            }
            dialog_Row("Teleportuotis á áëjimà")
            {
                SetPlayerPos(playerid, EntersExits[iter][eeEnterX], EntersExits[iter][eeEnterY], EntersExits[iter][eeEnterZ]);
                SetPlayerInterior(playerid, EntersExits[iter][eeEnterInt]);
                SetPlayerVirtualWorld(playerid, EntersExits[iter][eeEnterVW]);
                return 1;
            }
            dialog_Row("Teleportuotis á iðëjimà")
            {
                SetPlayerPos(playerid, EntersExits[iter][eeExitX], EntersExits[iter][eeExitY], EntersExits[iter][eeExitZ]);
                SetPlayerInterior(playerid, EntersExits[iter][eeExitInt]);
                SetPlayerVirtualWorld(playerid, EntersExits[iter][eeExitVW]);
                return 1;
            }
            dialog_Row("Iðtrinti")
            {
                IsValidDynamic3DTextLabel(EntersExits[iter][eeExitLabel]) && DestroyDynamic3DTextLabel(EntersExits[iter][eeExitLabel]);
                IsValidDynamic3DTextLabel(EntersExits[iter][eeEnterLabel]) && DestroyDynamic3DTextLabel(EntersExits[iter][eeEnterLabel]);

                log_init(true);
                log_set_table("logs_admins");
                log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`ExtraString`");
                log_set_values("'%d','%e','(AM) Istryne EE','%d','%e'", LogPlayerId(playerid), LogPlayerName(playerid), EntersExits[iter][eeId], EntersExits[iter][eeName]);
                log_commit();

                new __reset_EnterExit[E_ENTER_EXIT_DATA];
                EntersExits[iter] = __reset_EnterExit;
                EntersExits[iter][eeExitLabel] = 
                EntersExits[iter][eeEnterLabel] = INVALID_3DTEXT_ID;
                Iter_Remove(EnterExit, iter);

                inline deleteEE()
                {
                    MsgSuccess(playerid, "ÁËJIMAI/IÐËJIMAI", "Áëjimas sëkmingai iðtrintas.");
                    return 1;
                }
                mysql_tquery_inline(chandler, using inline deleteEE, "DELETE FROM `enters_exits` WHERE id = '%d'", EntersExits[iter][eeId]);
            }
            _Enters_ShowList(playerid);
        }
        else _Enters_ShowList(playerid);
        return 1;
    }
    dialog_Show(playerid, using inline edit, DIALOG_STYLE_LIST, "Serverio iðëjimo/áëjimo redagavimas", "Tæsti", "Atðaukti");
    return 1;
}

static _Enters_ChangeName(playerid, iter, error[] = "")
{
    dialog_Clear();
    dialog_AddLine("{FFFFFF}Áveskite naujà áëjimo pavadinimà.");
    dialog_AddLine("{BABABA}Jis bus rodomas tik áëjimo vietoje. Iðëjimo vietoje bus rodoma \"Iðëjimas\"");

    inline input(response, listitem)
    {
        if(response)
        {
            new name[32];
            if(sscanf(dialog_Input(),"s[32]",name))
                return _Enters_ChangeName(playerid, iter);

            format(EntersExits[iter][eeName], 32, name);
            EnterExit_CreateLabel(iter);
            
            inline updateName()
            {
                log_init(true);
                log_set_table("logs_admins");
                log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`ExtraString`");
                log_set_values("'%d','%e','(AM) Pakeite iejimo pavadinima','%d','%e'", LogPlayerId(playerid), LogPlayerName(playerid), EntersExits[iter][eeId], name);
                log_commit();
            }
            mysql_tquery_inline(chandler, using inline updateName, "UPDATE `enters_exits` SET Name = '%e' WHERE id = '%d'",
                name, EntersExits[iter][eeId]
            );
        }
        _Enters_ShowDetails(playerid, iter);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Serverio iðëjimo/áëjimo redagavimas", "Keisti", "Atðaukti");
    return 1;
}

static _Enters_ChangePickup(playerid, iter, error[] = "")
{
    dialog_Clear();
    dialog_AddLine("{FFFFFF}Áveskite áëjimo pickup modelio ID.");
    dialog_AddLine("{BABABA}0 paðalins esamà pickup.");
    dialog_AddLine("{BABABA}Pickupø modeliai: http://weedarr.wikidot.com/pickups");

    inline input(response, listitem)
    {
        if(response)
        {
            new pickup;
            if(sscanf(dialog_Input(),"d",pickup) || !(0 <= pickup <= 30000))
                return _Enters_ChangePickup(playerid, iter, .error = "Neteisingas pickup ID!");

            EntersExits[iter][eeEnterPickupType] = pickup;
            EnterExit_CreateLabel(iter);
            
            inline updateName()
            {
                log_init(true);
                log_set_table("logs_admins");
                log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`ExtraString`");
                log_set_values("'%d','%e','(AM) Pakeite iejimo pickup','%d','%s'", LogPlayerId(playerid), LogPlayerName(playerid), EntersExits[iter][eeId], va_return("%d", pickup));
                log_commit();
            }
            mysql_tquery_inline(chandler, using inline updateName, "UPDATE `enters_exits` SET PickupType = '%d' WHERE id = '%d'",
                pickup, EntersExits[iter][eeId]
            );
        }
        _Enters_ShowDetails(playerid, iter);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Serverio iðëjimo/áëjimo redagavimas", "Keisti", "Atðaukti");
    return 1;
}
