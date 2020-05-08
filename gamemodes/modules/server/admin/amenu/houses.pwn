#define HOUSES_PER_PAGE 50

/** External */
stock AMenu_Houses_Main(playerid)
{
    _Houses_Main(playerid);
    return 1;
}

/** Internals */
static _Houses_Main(playerid)
{
    dialog_Clear();
    dialog_AddLine("Kurti naujà");
    dialog_AddLine("Perþiûrëti visus");

    inline select(response, listitem)
    {
        if(!response) return AMenu_Main(playerid);

        dialog_Row("Kurti naujà")       return _Houses_Add(playerid);
        dialog_Row("Perþiûrëti visus")  return _Houses_ShowList(playerid);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_LIST, "Namai", "Tæsti", "Atðaukti");
    return 1;
}

static _Houses_Add(playerid)
{
    if(!HaveAdminPermission(playerid, "CreateNewHouse"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Houses_Main(playerid);
    }

    new Float:x, Float:y, Float:z,
        int = GetPlayerInterior(playerid),
        vw  = GetPlayerVirtualWorld(playerid);

    GetPlayerPos(playerid, x, y, z);
    inline insertNew()
    {
        if(mysql_errno() == 0)
        {
            if(int != 0 || vw != 0)
            {
                SendWarning(playerid, "Jûs nesate lauke (interior: %d, world: %d), todël sukurto namo bus neámanoma parodyti þemëlapyje.", int, vw);
            }

            new __reset_House[E_HOUSE_DATA],
                house = Iter_Free(House);

            HouseInfo[house] = __reset_House;
            HouseInfo[house][hId] = cache_insert_id();
            HouseInfo[house][hOutVW] = vw;
            HouseInfo[house][hExterior] = int;
            HouseInfo[house][hEnterX] = x,
            HouseInfo[house][hEnterY] = y,
            HouseInfo[house][hEnterZ] = z;
            HouseInfo[house][hVW] = HouseInfo[house][hId] + HOUSE_VIRTUAL_WORLD;

            Iter_Add(House, house);
            MsgSuccess(playerid, "NAMAI", "Sëkmingai sukûrëte namà, kurio ID: %d", HouseInfo[house][hId]);

            House_FixLabels(house);
            House_CreatePickup(house);
            _Houses_ShowDetails(playerid, house);
        }
        else
        {
            SendError(playerid, "Siøsta uþklausa nepavyko [%d]", mysql_errno());
        }
        return 1;
    }
    mysql_tquery_inline(chandler, using inline insertNew, "\
        INSERT INTO `houses_data` (`Added`,`EnterX`,`EnterY`,`EnterZ`,`Exterior`,`OutVW`) \
        VALUES \
        ('%d','%f','%f','%f','%d','%d')", 
        PlayerInfo[playerid][pId], x, y, z, int, vw
    );
    return 1;
}

static _Houses_ShowList(playerid, page = 0)
{
    dialog_Clear();
    dialog_AddLine("{BABABA}Nr.\t{BABABA}MySQL ID (numeris)\t{BABABA}Savininkas");

	new real_iter = 0,
		count_on_this_page = 0,
		name[24];

	foreach(new house : House)
	{
		if(HouseInfo[house][hId] != 0)
		{
			if(real_iter >= HOUSES_PER_PAGE * page)
			{
				if(count_on_this_page >= HOUSES_PER_PAGE)
				{
					if(Iter_Last(House) != house)
					{
                        dialog_AddLine(">>> KITAS");
						break;
					}
				}
				else
				{
					if(HouseInfo[house][hOwner] == 0) format(name, 10, "-");
					else format(name, sizeof name, GetNameBySql(HouseInfo[house][hOwner]));

                    dialog_AddLine("%d.\t%d\t%s", real_iter + 1, HouseInfo[house][hId], name);
				}
				count_on_this_page++;
			}
			real_iter++;
		}
	}
	(page > 0) && dialog_AddLine("<<< ATGAL");

    inline select(response, listitem)
    {
        if(response)
        {   
            dialog_Row(">>> KITAS") return _Houses_ShowList(playerid, page + 1);
            dialog_Row("<<< ATGAL") return _Houses_ShowList(playerid, page - 1);
            
            real_iter = count_on_this_page = 0;
            foreach(new house : House)
            {
                if(HouseInfo[house][hId] != 0)
                {
                    if(real_iter >= MAX_HOUSES_PER_PAGE * page)
                    {
                        if(count_on_this_page == listitem)
                        {
                            _Houses_ShowDetails(playerid, house);
                            return 1;
                        }
                        count_on_this_page ++ ;
                    }
                    real_iter++;
                }
            }
        }
        else _Houses_Main(playerid);

        return 1;
    }
	dialog_Show(playerid, using inline select, DIALOG_STYLE_TABLIST_HEADERS, "Namai", "Tæsti", "Atðaukti");
    return 1;
}

static _Houses_ShowDetails(playerid, house)
{
    if(!HaveAdminPermission(playerid, "EditHouses"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Houses_Main(playerid);
    }

    dialog_Clear();
    dialog_AddLine("{BABABA}Nustatymas\t{BABABA}Dabartinë reikðmë");
    dialog_AddLine("Kaina\t$%d", HouseInfo[house][hPrice]);
    dialog_AddLine("Savininkas\t%s", GetNameBySql(HouseInfo[house][hOwner]));
    dialog_AddLine("Keisti áëjimo vietà");
    dialog_AddLine("Keisti iðëjimo vietà");
    dialog_AddLine("Iðvalyti baldus");
    dialog_AddLine("Redaguoti inventoriø");
    dialog_AddLine("Teleportuotis prie namo áëjimo");
    dialog_AddLine("Teleportuotis prie namo iðëjimo");
    dialog_AddLine("Iðtrinti");

    inline select(response, listitem)
    {
        if(response)
        {
            dialog_Row("Kaina")                           return _Houses_ChangePrice(playerid, house);
            dialog_Row("Savininkas")                      return _Houses_ChangeOwner(playerid, house);
            dialog_Row("Keisti áëjimo vietà")             return _Houses_ChangeEnter(playerid, house);
            dialog_Row("Keisti iðëjimo vietà")            return _Houses_ChangeExit(playerid, house);
            dialog_Row("Iðvalyti baldus")                 return _Houses_ClearFurniture(playerid, house);
            dialog_Row("Teleportuotis prie namo áëjimo")  return _Houses_TeleportOut(playerid, house);
            dialog_Row("Teleportuotis prie namo iðëjimo") return _Houses_TeleportIn(playerid, house);
            dialog_Row("Iðtrinti")                        return _Houses_Delete(playerid, house);
        }
        else _Houses_ShowList(playerid);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_TABLIST_HEADERS, "Namo redagavimas", "Tæsti", "Atðaukti");
    return 1;
}


static _Houses_ChangePrice(playerid, house, error[] = "")
{
    if(!HaveAdminPermission(playerid, "EditHousePrice"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Houses_ShowList(playerid);
    }
    dialog_Clear();
    dialog_AddLine("{FFFFFF}Áveskite naujà namo kainà.");
    dialog_AddErrorLine(error);
    inline input(response, listitem)
    {
        if(response)
        {
            new amount;
            if(sscanf(dialog_Input(),"d",amount) || amount < 0)
                return _Houses_ChangePrice(playerid, house, .error = "Blogai ávestas skaièius.");
            
            HouseInfo[house][hPrice] = amount;
            House_FixLabels(house);
            
            inline updateHouse()
            {
                MsgSuccess(playerid, "Namai", "Pakeitëte namo kainà á $%d", amount);
                return 1;
            }
            mysql_tquery_inline(chandler, using inline updateHouse, "\
                UPDATE `houses_data` SET Price = '%d' WHERE id = '%d'",
                amount, HouseInfo[house][hId]
            );
            
            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`Amount`");
            log_set_values("'%d','%e','(AM) Pakeite namo kaina','%d','%d'", LogPlayerId(playerid), LogPlayerName(playerid), amount);
            log_commit();
        }
        _Houses_ShowDetails(playerid, house);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Namo redagavimas", "Keisti", "Atðaukti");
    return 1;
}

static _Houses_ChangeOwner(playerid, house, error[] = "")
{
    if(!HaveAdminPermission(playerid, "EditHouseOwner"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Houses_ShowList(playerid);
    }
    dialog_Clear();
    dialog_AddLine("{FFFFFF}Áveskite naujà namo savininko MySQL numerá arba pilnà vardà.");
    dialog_AddLine("{BABABA}Norëdami savininkà paðalinti, áraðykite 0");
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {
            if(!strlen(dialog_Input()))
               return _Houses_ChangeOwner(playerid, house, .error = "Blogai ávestas ID arba vardas.");

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

                    inline updateHouse()
                    {
                        HouseInfo[house][hOwner] = ownersql;
                        House_FixLabels(house);
                        House_CreatePickup(house);
                        
                        MsgSuccess(playerid, "Namai", "Pakeitëte namo savininkà (savininko ID: %d).", ownersql);
                        _Houses_ShowDetails(playerid, house);

                        log_init(true);
                        log_set_table("logs_admins");
                        log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`Amount`");
                        log_set_values("'%d','%e','(AM) Pakeite namo savininka','%d','%d'", LogPlayerId(playerid), LogPlayerName(playerid), HouseInfo[house][hId], ownersql);
                        log_commit();
                        return 1;
                    }
                    mysql_tquery_inline(chandler, using inline updateHouse, "UPDATE `houses_data` SET Owner = '0' WHERE id = '%d'", HouseInfo[house][hId]);
                }
                else return _Houses_ChangeOwner(playerid, house, .error = "Þaidëjas tokiu vardu/SQL ID neegzistuoja!");
            }   
            mysql_tquery_inline(chandler, using inline getPlayerId, query);
        }
        else _Houses_ShowDetails(playerid, house);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Namo redagavimas", "Keisti", "Atðaukti");
    return 1;
}

static _Houses_ChangeEnter(playerid, house)
{
    if(!HaveAdminPermission(playerid, "ChangeHouseEnter"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Houses_Main(playerid);
    }

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    HouseInfo[house][hOutVW] = GetPlayerVirtualWorld(playerid),
    HouseInfo[house][hExterior] = GetPlayerInterior(playerid),
    HouseInfo[house][hEnterX] = x,
    HouseInfo[house][hEnterY] = y,
    HouseInfo[house][hEnterZ] = z;

    inline updateHouse()
    {
        MsgSuccess(playerid, "Namai", "Sëkmingai pakeista áëjimo vieta.");
        return 1;
    }
    mysql_tquery_inline(chandler, using inline updateHouse, "\
        UPDATE `houses_data` SET EnterX = '%f', EnterY = '%f', EnterZ = '%f', OutVW = '%d', Exterior = '%d' WHERE id = '%d'", 
        x, y, z, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), HouseInfo[house][hId]
    );
    
    House_CreatePickup(house);
    House_FixLabels(house);

    log_init(true);
    log_set_table("logs_admins");
    log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`");
    log_set_values("'%d','%e','Pakeite namo iejimo vieta','%d'", LogPlayerId(playerid), LogPlayerName(playerid), HouseInfo[house][hId]);
    log_commit();
    return 1;
}

static _Houses_ChangeExit(playerid, house)
{
    if(!HaveAdminPermission(playerid, "ChangeHouseExit"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Houses_Main(playerid);
    }

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    HouseInfo[house][hInterior] = GetPlayerInterior(playerid),
    HouseInfo[house][hExitX] = x,
    HouseInfo[house][hExitY] = y,
    HouseInfo[house][hExitZ] = z;

    inline updateHouse()
    {
        MsgSuccess(playerid, "Namai", "Sëkmingai pakeista iðëjimo vieta.");
        return 1;
    }
    mysql_tquery_inline(chandler, using inline updateHouse, "\
        UPDATE `houses_data` SET ExitX = '%f', ExitY = '%f', ExitZ = '%f', Interior = '%d' WHERE id = '%d'",
        x, y, z, GetPlayerInterior(playerid), HouseInfo[house][hId]
    );

    log_init(true);
    log_set_table("logs_admins");
    log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`");
    log_set_values("'%d','%e','Pakeite namo isejimo vieta','%d'", LogPlayerId(playerid), LogPlayerName(playerid), HouseInfo[house][hId]);
    log_commit();
    return 1;
}

static _Houses_ClearFurniture(playerid, house)
{
    if(!HaveAdminPermission(playerid, "DeleteHouseFurniture"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Houses_Main(playerid);
    }

    House_DeleteFurniture(house);
    _Houses_ShowDetails(playerid, house);

    MsgSuccess(playerid, "Namai", "Sëkmingai iðtrynëte namo baldus.");
    log_init(true);
    log_set_table("logs_admins");
    log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`Amount`");
    log_set_values("'%d','%e','Isvale namo furniture','%d','0'", LogPlayerId(playerid), LogPlayerName(playerid), HouseInfo[house][hId]);
    log_commit();
    return 1;
}

static _Houses_TeleportIn(playerid, house)
{
    if(!HaveAdminPermission(playerid, "ChangeHouseExit"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Houses_Main(playerid);
    }
    // teleportuotis prie isejimo

    SetPlayerInterior(playerid, HouseInfo[house][hInterior]);
    SetPlayerVirtualWorld(playerid, HouseInfo[house][hVW]);
    SetPlayerPos(playerid, HouseInfo[house][hExitX], HouseInfo[house][hExitY], HouseInfo[house][hExitZ]);
    return 1;
}

static _Houses_TeleportOut(playerid, house)
{
    if(!HaveAdminPermission(playerid, "ChangeHouseEnter"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Houses_Main(playerid);
    }
    // teleportuotis prie iejimo
    SetPlayerInterior(playerid, HouseInfo[house][hExterior]);
    SetPlayerVirtualWorld(playerid, HouseInfo[house][hOutVW]);
    SetPlayerPos(playerid, HouseInfo[house][hEnterX], HouseInfo[house][hEnterY], HouseInfo[house][hEnterZ]);
    return 1;
}

static _Houses_Delete(playerid, house)
{
    new __reset_House[E_HOUSE_DATA];
    House_DeleteFurniture(house);
    
    if(IsValidDynamic3DTextLabel(HouseInfo[house][hLabel])) DestroyDynamic3DTextLabel(HouseInfo[house][hLabel]);
    sd_DestroyDynamicPickup(HouseInfo[house][hPickup]);

    log_init(true);
    log_set_table("logs_admins");
    log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`");
    log_set_values("'%d','%e','(AM) Istryne nama','%d'", LogPlayerId(playerid), LogPlayerName(playerid), HouseInfo[house][hId]);
    log_commit();

    inline deleteHouse()
    {
        MsgSuccess(playerid, "Namai", "Sëkmingai iðtrynëte namà.");
        return 1;
    }
    mysql_tquery_inline(chandler, using inline deleteHouse, "\
        DELETE FROM `houses_data` WHERE id = '%d';\
        DELETE FROM `houses_inventory` WHERE house = '%d';\
        DELETE FROM `houses_dubkeys` WHERE house = '%d'", 
        HouseInfo[house][hId], HouseInfo[house][hId], HouseInfo[house][hId]
    );
    HouseInfo[house] = __reset_House;
    HouseInfo[house][hLabel] = INVALID_3DTEXT_ID;
    Iter_Remove(House, house);

    _Houses_ShowList(playerid);
    return 1;
}
