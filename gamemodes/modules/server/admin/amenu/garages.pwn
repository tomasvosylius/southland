#define MAX_INTS_PER_PAGE   50

/** External */
stock AMenu_Garages_Main(playerid)
{
    _Garages_Main(playerid);
    return 1;
}

/** Internals */
static _Garages_Main(playerid)
{
    dialog_Clear();
    dialog_AddLine("Kurti naujà");
    dialog_AddLine("Perþiûrëti visus");

    inline select(response, listitem)
    {
        if(!response) return AMenu_Main(playerid);

        dialog_Row("Kurti naujà")       return _Garages_Add(playerid);
        dialog_Row("Perþiûrëti visus")  return _Garages_ShowList(playerid);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_LIST, "Garaþai", "Tæsti", "Atðaukti");
    return 1;
}

static _Garages_Add(playerid)
{
    if(!HaveAdminPermission(playerid, "CreateNewGarage"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Garages_Main(playerid);
    }

    // kurti nauja garaza
    new __reset_Garage[E_GARAGE_DATA],
        Float:x, Float:y, Float:z,
        garage  = Iter_Free(Garage),
        int     = GetPlayerInterior(playerid),
        vw      = GetPlayerVirtualWorld(playerid);
    GetPlayerPos(playerid, x, y, z);

    inline insertNew()
    {
        if(mysql_errno() == 0)
        {
            if(int != 0 || vw != 0)
            {
                SendWarning(playerid, "Jûs nesate lauke (interior: %d, world: %d), todël sukurto namo bus neámanoma parodyti þemëlapyje.", int, vw);
            }

            GarageInfo[garage] = __reset_Garage;
            GarageInfo[garage][gId] = cache_insert_id();
            GarageInfo[garage][gOutVW] = vw;
            GarageInfo[garage][gExterior] = int;
            GarageInfo[garage][gEnterX] = x,
            GarageInfo[garage][gEnterY] = y,
            GarageInfo[garage][gEnterZ] = z,
            GarageInfo[garage][gCarEnterX] = x,
            GarageInfo[garage][gCarEnterY] = y,
            GarageInfo[garage][gCarEnterZ] = z;
            GarageInfo[garage][gVW] = GarageInfo[garage][gId]+GARAGE_VIRTUAL_WORLD;

            Iter_Add(Garage, garage);
            
            Garage_FixLabels(garage);
            MsgSuccess(playerid, "SERVERIS", "Sëkmingai sukûrëte garaþà, kurio ID: %d", GarageInfo[garage][gId]);

            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`");
            log_set_values("'%d','%e','(AM) Sukure nauja garaza','%d'", LogPlayerId(playerid), LogPlayerName(playerid), GarageInfo[garage][gId]);
            log_commit();

            _Garages_ShowDetails(playerid, garage);
        }
        else
        {
            SendError(playerid, "Siøsta uþklausa nepavyko [%d]", mysql_errno());
        }
    }
    mysql_tquery_inline(chandler, using inline insertNew, "\
        INSERT INTO `garages_data` (`Added`,`EnterX`,`EnterY`,`EnterZ`,`CarEnterX`,`CarEnterY`,`CarEnterZ`,`Exterior`,`OutVW`) \
        VALUES \
        ('%d','%f','%f','%f','%f','%f','%f','%d','%d')",
        PlayerInfo[playerid][pId], x, y, z, x, y, z, int, vw
    );
    return 1;
}

static _Garages_ShowList(playerid)
{
    dialog_Clear();
    dialog_AddLine("Nr.\tMySQL ID (numeris)\tSavininkas");

    new iter,
        name[24];

    if(Iter_Count(Garage) <= 0)
    {
        SendWarning(playerid, "Nëra garaþø.");
        return _Garages_Main(playerid);
    }

    foreach(new garage : Garage)
    {
        if(GarageInfo[garage][gId] != 0)
        {
            if(GarageInfo[garage][gOwner] == 0) format(name, 10, "nëra");
            else format(name, sizeof name, GetNameBySql(GarageInfo[garage][gOwner]));

            iter++;
            dialog_AddLine("%d.\t%d\t%.19s", iter, GarageInfo[garage][gId], name);
        }
    }
    inline select(response, listitem)
    {
        if(response)
        {
            new garage;
            GetSortedAsForeach(Garage, listitem, garage, GarageInfo[loopindex][gId] != 0);
            _Garages_ShowDetails(playerid, garage);
        }
        else _Garages_Main(playerid);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_TABLIST_HEADERS, "Garaþai", "Tæsti", "Atðaukti");
    return 1;
}

static _Garages_ShowDetails(playerid, garage)
{
    if(!HaveAdminPermission(playerid, "EditGarages"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Garages_Main(playerid);
    }

    dialog_Clear();
    dialog_AddLine("{BABABA}Nustatymas\t{BABABA}Dabartinë reikðmë");
    dialog_AddLine("Kaina\t$%d", GarageInfo[garage][gPrice]);
    dialog_AddLine("Savininkas\t%s", GetNameBySql(GarageInfo[garage][gOwner]));
    dialog_AddLine("Keisti áëjimo vietà");
    dialog_AddLine("Keisti iðëjimo vietà");
    dialog_AddLine("Vieta, kur atsiranda tr. priemonë iðvaþiavus");
    dialog_AddLine("Vieta, kur atsiranda tr. priemonë ávaþiavus");
    dialog_AddLine("Iðvalyti baldus");
    dialog_AddLine("Teleportuotis á garaþo laukà");
    dialog_AddLine("Teleportuotis á garaþo vidø");
    dialog_AddLine("{C60000}Iðtrinti");

    inline select(response, listitem)
    {
        if(response)
        {
            dialog_Row("Kaina")                                        return _Garages_ChangePrice(playerid, garage);
            dialog_Row("Savininkas")                                   return _Garages_ChangeOwner(playerid, garage);
            dialog_Row("Keisti áëjimo vietà")                          return _Garages_ChangeEnter(playerid, garage);
            dialog_Row("Keisti iðëjimo vietà")                         return _Garages_ChangeExit(playerid, garage);
            dialog_Row("Vieta, kur atsiranda tr. priemonë iðvaþiavus") return _Garages_ChangeEnterVehicle(playerid, garage);
            dialog_Row("Vieta, kur atsiranda tr. priemonë ávaþiavus")  return _Garages_ChangeExitVehicle(playerid, garage);
            dialog_Row("Iðvalyti baldus")                              return _Garages_ClearFurniture(playerid, garage);
            dialog_Row("Teleportuotis á garaþo laukà")                 return _Garages_TeleportOut(playerid, garage);
            dialog_Row("Teleportuotis á garaþo vidø")                  return _Garages_TeleportIn(playerid, garage);
            dialog_Row("Iðtrinti")                                     return _Garages_Delete(playerid, garage);
        }
        else _Garages_ShowList(playerid);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_TABLIST_HEADERS, "Garaþo redagavimas", "Tæsti", "Atðaukti");
    return 1;
}



static _Garages_ChangePrice(playerid, garage, error[] = "")
{
    if(!HaveAdminPermission(playerid, "EditGaragePrice"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Garages_ShowDetails(playerid, garage);
    }
    dialog_Clear();
    dialog_AddLine("{FFFFFF}Áveskite naujà garaþo kainà.");
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {
            new amount;
            if(sscanf(dialog_Input(),"d",amount) || amount < 0)
                return _Garages_ChangePrice(playerid, garage, .error = "Blogai ávestas skaièius.");

            GarageInfo[garage][gPrice] = amount;
            Garage_FixLabels(garage);

            inline updateGarage()
            {
                MsgSuccess(playerid, "Garaþai", "Pakeitëte garaþo kainà á $%d", amount);
            }
            mysql_tquery_inline(chandler, using inline updateGarage, "\
                UPDATE `garages_data` SET Price = '%d' WHERE id = '%d'", amount, GarageInfo[garage][gId]
            );

            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`Amount`");
            log_set_values("'%d','%e','(AM) Pakeite garazo kaina','%d','%d'", LogPlayerId(playerid), LogPlayerName(playerid), GarageInfo[garage][gId]);
            log_commit();
        }
        _Garages_ShowDetails(playerid, garage);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Garaþo redagavimas", "Keisti", "Atðaukti");
    return 1;
}
static _Garages_ChangeOwner(playerid, garage, error[] = "")
{
    if(!HaveAdminPermission(playerid, "EditGarageOwner"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Garages_ShowDetails(playerid, garage);
    }

    dialog_Clear();
    dialog_AddLine("{FFFFFF}Áveskite naujà garaþo savininko MySQL numerá arba pilnà vardà.");
    dialog_AddLine("{BABABA}Norëdami savininkà paðalinti, áraðykite 0");
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {
            if(!strlen(dialog_Input()))
                return _Garages_ChangeOwner(playerid, garage, .error = "Blogai ávestas ID arba vardas.");

            new ownersql = NONE,
                query[126];

            if(IsNumeric(dialog_Input()))
            {
                ownersql = strval(dialog_Input());

                if(ownersql != 0) mysql_format(chandler, query, sizeof query, "SELECT id FROM `players_data` WHERE id = '%d'", ownersql);
                else mysql_format(chandler, query, sizeof query, "SELECT -1 AS id");
            }
            else mysql_format(chandler, query, sizeof query, "SELECT id FROM `players_data` WHERE Name = '%e'", dialog_Input());
            
            /** Send the query
            */
            inline getPlayerId()
            {
                if(cache_num_rows())
                {
                    cache_get_value_name_int(0, "id", ownersql);
                    if(ownersql <= 0) ownersql = 0;

                    inline updateGarage()
                    {
                        GarageInfo[garage][gOwner] = ownersql;
                        Garage_FixLabels(garage);
                        MsgSuccess(playerid, "Garaþai", "Pakeitëte garaþo savininkà (savininko ID: %d).", ownersql);
                        _Garages_ShowDetails(playerid, garage);

                        log_init(true);
                        log_set_table("logs_admins");
                        log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`Amount`");
                        log_set_values("'%d','%e','(AM) Pakeite garazo savininka','%d','%d'", LogPlayerId(playerid), LogPlayerName(playerid), GarageInfo[garage][gId], ownersql);
                        log_commit();
                        return 1;
                    }
                    mysql_tquery_inline(chandler, using inline updateGarage, "\
                        UPDATE `garages_data` SET Owner = '%d' WHERE id = '%d'", 
                        ownersql, GarageInfo[garage][gId]
                    );
                }
                else return _Garages_ChangeOwner(playerid, garage, .error = "Þaidëjas tokiu vardu/SQL ID neegzistuoja!");
            }   
            mysql_tquery_inline(chandler, using inline getPlayerId, query);
        }
        else _Garages_ShowDetails(playerid, garage);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Garaþo redagavimas", "Keisti", "Atðaukti");
    return 1;
}
static _Garages_ChangeEnter(playerid, garage)
{
    if(!HaveAdminPermission(playerid, "ChangeGarageEnter"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Garages_ShowDetails(playerid, garage);
    }

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    GarageInfo[garage][gOutVW] = GetPlayerVirtualWorld(playerid),
    GarageInfo[garage][gExterior] = GetPlayerInterior(playerid),
    GarageInfo[garage][gEnterX] = x,
    GarageInfo[garage][gEnterY] = y,
    GarageInfo[garage][gEnterZ] = z;
    Garage_FixLabels(garage);

    inline updateGarage()
    {
        MsgSuccess(playerid, "Garaþai", "Sëkmingai pakeista áëjimo vieta.");
        _Garages_ShowDetails(playerid, garage);
        return 1;
    }
    mysql_tquery_inline(chandler, using inline updateGarage, "UPDATE `garages_data` SET EnterX = '%f', EnterY = '%f', EnterZ = '%f', OutVW = '%d', Exterior = '%d' WHERE id = '%d'",
        x, y, z,
        GetPlayerVirtualWorld(playerid),
        GetPlayerInterior(playerid),
        GarageInfo[garage][gId]
    );

    log_init(true);
    log_set_table("logs_admins");
    log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`");
    log_set_values("'%d','%e','(AM) Pakeite garazo iejimo vieta','%d'", LogPlayerId(playerid), LogPlayerName(playerid), GarageInfo[garage][gId]);
    log_commit();
    return 1;
}
static _Garages_ChangeExit(playerid, garage)
{
    if(!HaveAdminPermission(playerid, "ChangeGarageExit"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Garages_ShowDetails(playerid, garage);
    }

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    GarageInfo[garage][gInterior] = GetPlayerInterior(playerid),
    GarageInfo[garage][gExitX] = x,
    GarageInfo[garage][gExitY] = y,
    GarageInfo[garage][gExitZ] = z;
    Garage_FixLabels(garage);

    inline updateGarage()
    {
        MsgSuccess(playerid, "Garaþai", "Sëkmingai pakeista iðëjimo vieta.");
        _Garages_ShowDetails(playerid, garage);
        return 1;
    }
    mysql_tquery_inline(chandler, using inline updateGarage, "\
        UPDATE `garages_data` SET ExitX = '%f', ExitY = '%f', ExitZ = '%f', Interior = '%d' WHERE id = '%d'",
        x, y, z,
        GetPlayerInterior(playerid),
        GarageInfo[garage][gId]
    );

    log_init(true);
    log_set_table("logs_admins");
    log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`");
    log_set_values("'%d','%e','(AM) Pakeite garazo isejimo vieta','%d'", LogPlayerId(playerid), LogPlayerName(playerid), GarageInfo[garage][gId]);
    log_commit();
    return 1;
}

static _Garages_ChangeEnterVehicle(playerid, garage)
{
    if(!HaveAdminPermission(playerid, "ChangeGarageEnter"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Garages_ShowDetails(playerid, garage);
    }

    if(GetPlayerInterior(playerid) != GarageInfo[garage][gExterior])
    {
        MsgError(playerid, "Garaþai", "Nesate tame paèiame interjere, kuriame yra áëjimas á garaþà.");
        _Garages_ShowDetails(playerid, garage);
        return 1;
    }

    new Float:x, Float:y, Float:z, Float:a;
    GetPlayerPos(playerid, x, y, z),
    GetPlayerFacingAngle(playerid, a);
    GarageInfo[garage][gCarEnterX] = x,
    GarageInfo[garage][gCarEnterY] = y,
    GarageInfo[garage][gCarEnterZ] = z,
    GarageInfo[garage][gCarEnterA] = a;

    inline updateGarage()
    {
        MsgSuccess(playerid, "Garaþai", "Tr. priemonë iðvaþiuojant ið garaþo á laukà atsiras jûsø nustatytoje vietoje.");
        _Garages_ShowDetails(playerid, garage);
        return 1;
    }
    mysql_tquery_inline(chandler, using inline updateGarage, "\
        UPDATE `garages_data` SET CarEnterX = '%f', CarEnterY = '%f', CarEnterZ = '%f', CarEnterA = '%f' WHERE id = '%d'", 
        x, y, z, a, GarageInfo[garage][gId]
    );

    log_init(true);
    log_set_table("logs_admins");
    log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`");
    log_set_values("'%d','%e','(AM) Pakeite garazo lauko vieta masinai','%d'", LogPlayerId(playerid), LogPlayerName(playerid), GarageInfo[garage][gId]);
    log_commit();
    return 1;
}
static _Garages_ChangeExitVehicle(playerid, garage)
{
    if(!HaveAdminPermission(playerid, "ChangeGarageExit"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Garages_ShowDetails(playerid, garage);
    }

    // keisti masinos ivaziavus is lauko
    if(GetPlayerInterior(playerid) != GarageInfo[garage][gInterior])
    {
        MsgError(playerid, "Garaþai", "Nesate tame paèiame interjere, kuriame yra iðëjimas ið garaþo.");
        _Garages_ShowDetails(playerid, garage);
        return 1;
    }
    new Float:x, Float:y, Float:z, Float:a;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);
    GarageInfo[garage][gCarExitX] = x,
    GarageInfo[garage][gCarExitY] = y,
    GarageInfo[garage][gCarExitZ] = z,
    GarageInfo[garage][gCarExitA] = a;
    inline updateGarage()
    {
        MsgSuccess(playerid, "Garaþai", "Tr. priemonë ávaþiuojant á garaþà ið lauko atsiras jûsø nustatytoje vietoje.");
        _Garages_ShowDetails(playerid, garage);
        return 1;
    }
    mysql_tquery_inline(chandler, using inline updateGarage, "\
        UPDATE `garages_data` SET CarExitX = '%f', CarExitY = '%f', CarExitZ = '%f', CarExitA = '%f' WHERE id = '%d'",
        x, y, z, a, GarageInfo[garage][gId]
    );
    
    log_init(true);
    log_set_table("logs_admins");
    log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`");
    log_set_values("'%d','%e','(AM) Pakeite garazo vidaus vieta masinai','%d'", LogPlayerId(playerid), LogPlayerName(playerid), GarageInfo[garage][gId]);
    log_commit();
    return 1;
}
static _Garages_ClearFurniture(playerid, garage)
{
    if(!HaveAdminPermission(playerid, "DeleteGarageFurniture"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Garages_ShowDetails(playerid, garage);
    }
    
    Garage_DeleteFurniture(garage);
    MsgSuccess(playerid, "Garaþai", "Furniture iðtrintas.");

    _Garages_ShowDetails(playerid, garage);
    return 1;
}
static _Garages_TeleportIn(playerid, garage)
{
    if(!HaveAdminPermission(playerid, "ChangeGarageEnter"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Garages_ShowDetails(playerid, garage);
    }

    SetPlayerPos(playerid, GarageInfo[garage][gExitX], GarageInfo[garage][gExitY], GarageInfo[garage][gExitZ]);
    SetPlayerInterior(playerid, GarageInfo[garage][gInterior]);
    SetPlayerVirtualWorld(playerid, GarageInfo[garage][gVW]);
    return 1;
}
static _Garages_TeleportOut(playerid, garage)
{
    if(!HaveAdminPermission(playerid, "ChangeGarageExit"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Garages_ShowDetails(playerid, garage);
    }

    SetPlayerPos(playerid, GarageInfo[garage][gEnterX], GarageInfo[garage][gEnterY], GarageInfo[garage][gEnterZ]);
    SetPlayerInterior(playerid, GarageInfo[garage][gExterior]);
    SetPlayerVirtualWorld(playerid, GarageInfo[garage][gOutVW]);
    return 1;
}
static _Garages_Delete(playerid, garage)
{
    if(!HaveAdminPermission(playerid, "DeleteGarage"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Garages_ShowDetails(playerid, garage);
    }

    new __reset_Garage[E_GARAGE_DATA];
    Garage_DeleteFurniture(garage);

    IsValidDynamic3DTextLabel(GarageInfo[garage][gLabel]) && DestroyDynamic3DTextLabel(GarageInfo[garage][gLabel]);

    log_init(true);
    log_set_table("logs_admins");
    log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`");
    log_set_values("'%d','%e','(AM) Istryne garaza','%d'", LogPlayerId(playerid), LogPlayerName(playerid), GarageInfo[garage][gId]);
    log_commit();
    
    GarageInfo[garage] = __reset_Garage;
    GarageInfo[garage][gLabel] = INVALID_3DTEXT_ID;
    Iter_Remove(Garage, garage);

    inline deleteGarage()
    {
        MsgSuccess(playerid, "Garaþai", "Sëkmingai iðtrynëte garaþà.");
        _Garages_ShowList(playerid);
    }
    mysql_tquery_inline(chandler, using inline deleteGarage, "\
        DELETE FROM `garages_data` WHERE id = '%d'", 
        GarageInfo[garage][gId]
    );
    return 1;
}