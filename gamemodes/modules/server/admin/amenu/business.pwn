#define BUSINESS_PER_PAGE 50

/** External */
stock AMenu_Business_Main(playerid)
{
    _Business_Main(playerid);
    return 1;
}

/** Internals */
static _Business_Main(playerid)
{
    dialog_Clear();
    dialog_AddLine("Kurti naujà");
    dialog_AddLine("Perþiûrëti visus");
    dialog_AddLine("Galimos prekës parduotuvëms");
    dialog_AddLine("Verslo lygiai");

    inline select(response, listitem)
    {
        if(!response) return AMenu_Main(playerid);

        dialog_Row("Kurti naujà")                   return _Business_CreateNew(playerid);
        dialog_Row("Perþiûrëti visus")              return _Business_ShowList(playerid);
        dialog_Row("Galimos prekës parduotuvëms")   return _Business_Wares_Main(playerid);
        dialog_Row("Verslo lygiai")                 return _Business_Levels_Main(playerid);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_LIST, "Verslai", "Tæsti", "Atðaukti");
    return 1;
}

static _Business_CreateNew(playerid)
{
    if(!HaveAdminPermission(playerid, "CreateNewBusiness"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Business_Main(playerid);
    }

    new business = Iter_Free(Business),
        __reset_Business[E_BUSINESS_DATA],
        Float:x, Float:y, Float:z, 
        int = GetPlayerInterior(playerid),
        vw = GetPlayerVirtualWorld(playerid);

    GetPlayerPos(playerid, x, y, z);
    inline insertNew()
    {
        if(mysql_errno() == 0)
        {
            if(int != 0 || vw != 0)
            {
                SendWarning(playerid, "Jûs nesate lauke (interior: %d, world: %d), todël sukurto verslo business neámanoma parodyti þemëlapyje.", int, vw);
            }

            
            BusinessInfo[business] = __reset_Business;
            format(BusinessInfo[business][bName], 14, "Be pavadinimo");
            BusinessInfo[business][bId] = cache_insert_id();
            BusinessInfo[business][bEnterX] = x,
            BusinessInfo[business][bEnterY] = y,
            BusinessInfo[business][bEnterZ] = z;
            BusinessInfo[business][bOutVW] = vw;
            BusinessInfo[business][bExterior] = int;
            BusinessInfo[business][bVW] = BUSINESS_VIRTUAL_WORLD+BusinessInfo[business][bId];
            Iter_Add(Business, business);
            
            Business_FixLabels(business);
            Business_CreatePickup(business);

            _Business_ShowDetails(playerid, business);
            
            MsgSuccess(playerid, "Verslai", "Sëkmingai sukûrëte verslà, kurio ID: %d", BusinessInfo[business][bId]);
            
            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`");
            log_set_values("'%d','%e','(AM) Sukure nauja versla','%d'", LogPlayerId(playerid), LogPlayerName(playerid), BusinessInfo[business][bId]);
            log_commit();
        }
        else
        {
            SendError(playerid, "Siøsta uþklausa nepavyko [%d]", mysql_errno());
        }
        return 1;
    }
    mysql_tquery_inline(chandler, using inline insertNew, "\
        INSERT INTO `business_data` (`Added`,`Name`,`EnterX`,`EnterY`,`EnterZ`,`OutVW`,`Exterior`) \
        VALUES \
        ('%d','Be pavadinimo','%f','%f','%f','%d','%d')",
        PlayerInfo[playerid][pId], x, y, z, vw, int
    );
    return 1;
}

static _Business_ShowList(playerid, page = 0)
{
    dialog_Clear();
	dialog_AddLine("{BABABA}Nr.\t{BABABA}Pavadinimas\t{BABABA}MySQL ID (numeris)\t{BABABA}Savininkas{FFFFFF}");


	new owner[24],
		real_iter,
		count_on_this_page;
	
    if(Iter_Count(Business) <= 0)
    {
        SendWarning(playerid, "Nëra verslø.");
        return _Business_Main(playerid);
    }

	foreach(new businessid : Business)
	{
		if(BusinessInfo[businessid][bId] != 0)
		{
			if(real_iter >= BUSINESS_PER_PAGE * page)
			{
				if(count_on_this_page >= BUSINESS_PER_PAGE)
				{
					if(Iter_Last(Business) != businessid)
					{
						dialog_AddLine(">>> KITAS");
						break;
					}
				}
				else
				{
					if(BusinessInfo[businessid][bOwner] == 0) format(owner, 10, "-");
					else format(owner, sizeof owner, GetNameBySql(BusinessInfo[businessid][bOwner]));

					dialog_AddLine("%d.\t%.10s%s\t%d\t%s",
                        real_iter+1,
                        BusinessInfo[businessid][bName], 
                        strlen(BusinessInfo[businessid][bName]) > 10 ? ("..") : (" "), 
                        BusinessInfo[businessid][bId], owner
                    );
				}
				count_on_this_page++;
			}
			real_iter++;
		}
	}
    if(page > 0) dialog_AddLine("<<< ATGAL");
	
    inline select(response, listitem)
    {
        if(response)
        {   
            dialog_Row(">>> KITAS") return _Business_ShowList(playerid, page + 1);
            dialog_Row("<<< ATGAL") return _Business_ShowList(playerid, page - 1);

            real_iter = count_on_this_page = 0;
            foreach(new business : Business)
            {
                if(BusinessInfo[business][bId] != 0)
                {
                    if(real_iter >= BUSINESS_PER_PAGE * page)
                    {
                        if(count_on_this_page == listitem)
                        {
                            _Business_ShowDetails(playerid, business);
                            return 1;
                        }
                        count_on_this_page ++ ;
                    }
                    real_iter++;
                }
            }
        }
        else _Business_Main(playerid);
    }
	dialog_Show(playerid, using inline select, DIALOG_STYLE_TABLIST_HEADERS, "Verslai", "Tæsti", "Atðaukti");
    return 1;
}

static _Business_ShowDetails(playerid, business)
{
    if(!HaveAdminPermission(playerid, "EditBusiness"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Business_Main(playerid);
    }

    dialog_Clear();
    dialog_AddLine("{BABABA}Nustatymas\t{BABABA}Dabartinë reikðmë");
    dialog_AddLine("Pavadinimas\t%.14s%s", BusinessInfo[business][bName], strlen(BusinessInfo[business][bName]) > 14 ? ("...") : (""));
    dialog_AddLine("Kaina\t$%d", BusinessInfo[business][bPrice]);
    dialog_AddLine("Savininkas\t%s", GetNameBySql(BusinessInfo[business][bOwner]));
    dialog_AddLine("Keisti áëjimo vietà");
    dialog_AddLine("Keisti iðëjimo vietà");
    dialog_AddLine("Iðvalyti baldus");
    dialog_AddLine("Nustatyti verslo tipà");
    dialog_AddLine("Papildomos koordinatës");
    dialog_AddLine("Teleportuotis prie verslo áëjimo");
    dialog_AddLine("Teleportuotis prie verslo iðëjimo");
    dialog_AddLine("Keisti verslo lygá\t%d", BusinessInfo[business][bLevel]);
    dialog_AddLine("Keisti prekiø pristatymo vietà (maðinai)");
    dialog_AddLine("Keisti dëþiø pristatymo vietà (þmogui)");
    dialog_AddLine("{C60000}Iðtrinti");

    inline select(response, listitem)
    {
        if(response)
        {
            dialog_Row("Pavadinimas")                               return _Business_ChangeName(playerid, business);
            dialog_Row("Kaina")                                     return _Business_ChangePrice(playerid, business);
            dialog_Row("Savininkas")                                return _Business_ChangeOwner(playerid, business);
            dialog_Row("Keisti áëjimo vietà")                       return _Business_ChangeEnter(playerid, business);
            dialog_Row("Keisti iðëjimo vietà")                      return _Business_ChangeExit(playerid, business);
            dialog_Row("Iðvalyti baldus")                           return _Business_ClearFurniture(playerid, business);
            dialog_Row("Nustatyti verslo tipà")                     return _Business_ChangeType(playerid, business);
            dialog_Row("Papildomos koordinatës")                    return _Business_ChangeExtraCoords(playerid, business);
            dialog_Row("Teleportuotis prie verslo áëjimo")          return _Business_TeleportOut(playerid, business);
            dialog_Row("Teleportuotis prie verslo iðëjimo")         return _Business_TeleportIn(playerid, business);
            dialog_Row("Keisti verslo lygá")                        return _Business_ChangeLevel(playerid, business);
            dialog_Row("Keisti prekiø pristatymo vietà (maðinai)")  return _Business_ChangeWaresPlacePED(playerid, business);
            dialog_Row("Keisti dëþiø pristatymo vietà (þmogui)")    return _Business_ChangeWaresPlaceVEH(playerid, business);
            dialog_Row("Iðtrinti")                                  return _Business_Delete(playerid, business);
        }
        else _Business_ShowList(playerid);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_TABLIST_HEADERS, "Verslo redagavimas", "Tæsti", "Atðaukti");
    return 1;
}


static _Business_ChangeName(playerid, business, error[] = "")
{
    if(!HaveAdminPermission(playerid, "EditBusinessName"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Business_ShowDetails(playerid, business);
    }

    dialog_Clear();
    dialog_AddLine("{FFFFFF}Áveskite naujà verslo pavadinimà.");
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {
            if(strlen(dialog_Input()) <= 3 || strlen(dialog_Input()) > 24)
                return _Business_ChangeName(playerid, business, .error = "Blogai ávestas pavadinimas (3-24 simboliai).");
            
            format(BusinessInfo[business][bName], 24, dialog_Input());
            Business_FixLabels(business);
            inline updateBusiness()
            {
                MsgSuccess(playerid, "Verslai", "Verslo pavadinimas pakeistas.");
                return 1;
            }
            mysql_tquery_inline(chandler, using inline updateBusiness, "\
                UPDATE `business_data` SET Name = '%e' WHERE id = '%d'",
                dialog_Input(), BusinessInfo[business][bId]
            );
            
            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`ExtraString`");
            log_set_values("'%d','%e','(AM) Pakeite verslo pavadinima','%d','%e'", LogPlayerId(playerid), LogPlayerName(playerid), BusinessInfo[business][bId], dialog_Input());
            log_commit();
        }
        _Business_ShowDetails(playerid, business);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Verslo redagavimas", "Keisti", "Atðaukti");
    return 1;
}
static _Business_ChangePrice(playerid, business, error[] = "")
{
    if(!HaveAdminPermission(playerid, "EditBusinessPrice"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Business_ShowDetails(playerid, business);
    }
    dialog_Clear();
    dialog_AddLine("{FFFFFF}Áveskite naujà verslo kainà.");
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {   
            new amount;
            if(sscanf(dialog_Input(),"d",amount) || amount < 0)
                return _Business_ChangePrice(playerid, business, .error = "Blogai ávestas skaièius.");
            
            BusinessInfo[business][bPrice] = amount;
            
            inline updateBusiness()
            {
                MsgSuccess(playerid, "Verslai", "Pakeitëte verslo kainà á $%d", amount);
                return 1;
            }
            mysql_tquery_inline(chandler, using inline updateBusiness, "UPDATE `business_data` SET Price = '%d' WHERE id = '%d'", amount, BusinessInfo[business][bId]);
            Business_FixLabels(business);

            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`Amount`");
            log_set_values("'%d','%e','Pakeite verslo kaina','%d','%d'", LogPlayerId(playerid), LogPlayerName(playerid), BusinessInfo[business][bId], amount);
            log_commit();
        }
        _Business_ShowDetails(playerid, business);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Verslo redagavimas", "Keisti", "Atðaukti");
    return 1;
}
static _Business_ChangeOwner(playerid, business, error[] = "")
{
    if(!HaveAdminPermission(playerid, "EditBusinessOwner"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Business_ShowDetails(playerid, business);
    }
    dialog_Clear();
    dialog_AddLine("{FFFFFF}Áveskite naujà verslo savininko MySQL numerá arba pilnà vardà.");
    dialog_AddLine("{BABABA}Norëdami savininkà paðalinti, áraðykite 0");
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {
            if(!strlen(dialog_Input()))
               return _Business_ChangeOwner(playerid, business, .error = "Blogai ávestas ID arba vardas.");

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

                    inline updateBusiness()
                    {
                        BusinessInfo[business][bOwner] = ownersql;
                        Business_FixLabels(business);
                        Business_CreatePickup(business);
                        
                        MsgSuccess(playerid, "Verslai", "Pakeitëte verslo savininkà (savininko ID: %d).", ownersql);
                        _Business_ShowDetails(playerid, business);

                        log_init(true);
                        log_set_table("logs_admins");
                        log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`Amount`");
                        log_set_values("'%d','%e','(AM) Pakeite verslo savininka','%d','%d'", LogPlayerId(playerid), LogPlayerName(playerid), BusinessInfo[business][bId], ownersql);
                        log_commit();
                        return 1;
                    }
                    mysql_tquery_inline(chandler, using inline updateBusiness, "\
                        UPDATE `business_data` SET Owner = '%d' WHERE id = '%d'",
                        ownersql, BusinessInfo[business][bId]
                    );
                }
                else return _Business_ChangeOwner(playerid, business, .error = "Þaidëjas tokiu vardu/SQL ID neegzistuoja!");
            }   
            mysql_tquery_inline(chandler, using inline getPlayerId, query);
        }
        else _Business_ShowDetails(playerid, business);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Verslo redagavimas", "Keisti", "Atðaukti");
    return 1;
}
static _Business_ChangeEnter(playerid, business)
{
    if(!HaveAdminPermission(playerid, "ChangeBusinessEnter"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Business_ShowDetails(playerid, business);
    }
    
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    BusinessInfo[business][bOutVW] = GetPlayerVirtualWorld(playerid);
    BusinessInfo[business][bExterior] = GetPlayerInterior(playerid);
    BusinessInfo[business][bEnterX] = x,
    BusinessInfo[business][bEnterY] = y,
    BusinessInfo[business][bEnterZ] = z;

    inline updateBusiness()
    {
        MsgSuccess(playerid, "Verslai", "Sëkmingai pakeista áëjimo vieta.");
        _Business_ShowDetails(playerid, business);
        return 1;
    }
    mysql_tquery_inline(chandler, using inline updateBusiness, "\
        UPDATE `business_data` SET EnterX = '%f', EnterY = '%f', EnterZ = '%f', OutVW = '%d', Exterior = '%d' WHERE id = '%d'", 
        x, y, z, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), BusinessInfo[business][bId]
    );

    Business_FixLabels(business);
    Business_CreatePickup(business);

    log_init(true);
    log_set_table("logs_admins");
    log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`");
    log_set_values("'%d','%e','(AM) Pakeite verslo iejimo vieta','%d'", LogPlayerId(playerid), LogPlayerName(playerid), BusinessInfo[business][bId]);
    log_commit();
    return 1;
}
static _Business_ChangeExit(playerid, business)
{
    if(!HaveAdminPermission(playerid, "ChangeBusinessExit"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Business_ShowDetails(playerid, business);
    }
    
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    BusinessInfo[business][bInterior] = GetPlayerInterior(playerid),
    BusinessInfo[business][bExitX] = x,
    BusinessInfo[business][bExitY] = y,
    BusinessInfo[business][bExitZ] = z;

    inline updateBusiness()
    {
        MsgSuccess(playerid, "Verslai", "Sëkmingai pakeista iðëjimo vieta.");
        _Business_ShowDetails(playerid, business);
        return 1;
    }
    mysql_tquery_inline(chandler, using inline updateBusiness, "\
        UPDATE `business_data` SET ExitX = '%f', ExitY = '%f', ExitZ = '%f', Interior = '%d' WHERE id = '%d'",
        x, y, z, GetPlayerInterior(playerid), BusinessInfo[business][bId]
    );

    log_init(true);
    log_set_table("logs_admins");
    log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`");
    log_set_values("'%d','%e','(AM) Pakeite verslo isejimo vieta','%d'", LogPlayerId(playerid), LogPlayerName(playerid), BusinessInfo[business][bId]);
    log_commit();
    return 1;
}
static _Business_ClearFurniture(playerid, business)
{
    if(!HaveAdminPermission(playerid, "DeleteBusinessFurniture"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Business_ShowDetails(playerid, business);
    }

    Business_DeleteFurniture(business);
    MsgSuccess(playerid, "Verslai", "Sëkmingai iðtrynëte verslo baldus.");
    _Business_ShowDetails(playerid, business);

    log_init(true);
    log_set_table("logs_admins");
    log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`Amount`");
    log_set_values("'%d','%e','(AM) Isvale verslo furniture','%d','0'", LogPlayerId(playerid), LogPlayerName(playerid), BusinessInfo[business][bId]);
    log_commit();
    return 1;
}
static _Business_ChangeType(playerid, business)
{
    if(!HaveAdminPermission(playerid, "EditBusinessType"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Business_ShowDetails(playerid, business);
    }

    dialog_Clear();
    dialog_AddLine("0. Joks");
    dialog_AddLine("1. Degalinë");
    dialog_AddLine("2. Maitinimo ástaiga");
    dialog_AddLine("3. 24/7 parduotuvë");
    dialog_AddLine("4. Drabuþiø parduotuvë");
    dialog_AddLine("5. Ginklø parduotuvë");

    inline select(response, listitem)
    {
        if(response)
        {
            BusinessInfo[business][bType] = listitem;
            if(listitem == BUSINESS_TYPE_FUEL)
            {
                BusinessInfo[business][bFuel] = GetGVarInt("BusinessFuelCapacity");
                BusinessInfo[business][bFuelPrice] = 3;
            }

            inline updateBusiness()
            {
                MsgSuccess(playerid, "Verslai", "Verslo tipas sëkmingai pakeistas. %s", (listitem == BUSINESS_TYPE_FUEL ? ("Nustatykite papildomas koordinates, kur galima naudoti /fill") : ("")));
                _Business_ShowDetails(playerid, business);
                return 1;
            }
            mysql_tquery_inline(chandler, using inline updateBusiness, "\
                UPDATE `business_data` SET Type = '%d' WHERE id = '%d'",
                listitem, BusinessInfo[business][bId]
            );
            
            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`Amount`");
            log_set_values("'%d','%e','(AM) Pakeite verslo tipa','%d','%d'", LogPlayerId(playerid), LogPlayerName(playerid), BusinessInfo[business][bId], listitem);
            log_commit();
        }
        _Business_ShowDetails(playerid, business);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_LIST, "Verslo redagavimas", "Tæsti", "Atðaukti");
    return 1;
}
static _Business_ChangeExtraCoords(playerid, business)
{
    if(!HaveAdminPermission(playerid, "ChangeBusinessExtra"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Business_ShowDetails(playerid, business);
    }

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    BusinessInfo[business][bExtraX] = x,
    BusinessInfo[business][bExtraY] = y,
    BusinessInfo[business][bExtraZ] = z;

    inline updateBusiness()
    {
        MsgSuccess(playerid, "Verslai", "Papildomos koordinatës nustatytos á jûsø dabartinæ pozicijà.");
        _Business_ShowDetails(playerid, business);
        return 1;
    }
    mysql_tquery_inline(chandler, using inline updateBusiness, "\
        UPDATE `business_data` SET ExtraX = '%f', ExtraY = '%f', ExtraZ = '%f' WHERE id = '%d'",
        x, y, z, BusinessInfo[business][bId]
    );
    
    log_init(true);
    log_set_table("logs_admins");
    log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`");
    log_set_values("'%d','%e','(AM) Pakeite verslo papildomas koord.','%d'", LogPlayerId(playerid), LogPlayerName(playerid), BusinessInfo[business][bId]);
    log_commit();

    // * Ideja: sukurti nauja table `business_coordinates` ir ten glaima kelt unlimited koordinates su tipais.
    // * verslo id  	x 	y 	z 		type
    // * 1			0.0, 0.0, 0.0   fill_fuel
    // * 1			0.0, 0.0, 0.0   unload_wares

    switch(BusinessInfo[business][bType])
    {
        case BUSINESS_TYPE_FUEL: MsgInfo(playerid, "Verslai", "Ðiose koordinatëse business leidþiama pilti degalus.");
        default: MsgInfo(playerid, "Verslai", "Papildomos koordinatës ðiam verslo tipui (%d) neturi reikðmës.", BusinessInfo[business][bType]);
    }
    return 1;
}
static _Business_TeleportOut(playerid, business)
{
    if(!HaveAdminPermission(playerid, "ChangeBusinessEnter"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Business_ShowDetails(playerid, business);
    }

    SetPlayerPos(playerid, BusinessInfo[business][bEnterX], BusinessInfo[business][bEnterY], BusinessInfo[business][bEnterZ]);
    SetPlayerInterior(playerid, BusinessInfo[business][bExterior]);
    SetPlayerVirtualWorld(playerid, BusinessInfo[business][bOutVW]);
    return 1;
}
static _Business_TeleportIn(playerid, business)
{
    if(!HaveAdminPermission(playerid, "ChangeBusinessExit"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Business_ShowDetails(playerid, business);
    }

    SetPlayerPos(playerid, BusinessInfo[business][bExitX], BusinessInfo[business][bExitY], BusinessInfo[business][bExitZ]);
    SetPlayerInterior(playerid, BusinessInfo[business][bInterior]);
    SetPlayerVirtualWorld(playerid, BusinessInfo[business][bVW]);
    return 1;
}
static _Business_ChangeLevel(playerid, business)
{
    if(!HaveAdminPermission(playerid, "EditBusinessLevel"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Business_ShowDetails(playerid, business);
    }

    dialog_Clear();
    dialog_AddLine("{BABABA}Lygis\t{BABABA}Iðmoka verslui per payday");
    
    new varname[24];
    for(new i = 0, j = GetGVarInt("BusinessPayMaxLevels"); i <= j; i++)
    {
        format(varname, sizeof varname, "BusinessPayLevel%d", i);
        dialog_AddLine("%d\t$%d", i, GetGVarInt(varname));
    }

    inline select(response, listitem)
    {
        if(response)
        {
            BusinessInfo[business][bLevel] = listitem;
            SaveBusinessIntEx(business, "Level", listitem);

            MsgSuccess(playerid, "Verslai", "Verslo lygis sëkmingai pakeistas á %d.", listitem);

            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`Amount`");
            log_set_values("'%d','%e','(AM) Pakeite verslo lygi','%d','%d'", LogPlayerId(playerid), LogPlayerName(playerid), BusinessInfo[business][bId], listitem);
            log_commit();
        }
        _Business_ShowDetails(playerid, business);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_TABLIST_HEADERS, "Verslo redagavimas", "Tæsti", "Atðaukti");
    return 1;
}
static _Business_ChangeWaresPlaceVEH(playerid, business)
{
    if(!HaveAdminPermission(playerid, "ChangeBusinessExtra"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Business_ShowDetails(playerid, business);
    }

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    BusinessInfo[business][bWaresX] = x,
    BusinessInfo[business][bWaresY] = y,
    BusinessInfo[business][bWaresZ] = z;

    inline updateBusiness()
    {
        MsgSuccess(playerid, "Verslai", "Sëkmingai pakeista prekiø iðkrovimo vieta.");
        _Business_ShowDetails(playerid, business);
    }
    mysql_tquery_inline(chandler, using inline updateBusiness, "\
        UPDATE `business_data` SET WaresX = '%f', WaresY = '%f', WaresZ = '%f' WHERE id = '%d'",
        x, y, z, BusinessInfo[business][bId]
    );
    
    log_init(true);
    log_set_table("logs_admins");
    log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`");
    log_set_values("'%d','%e','(AM) Pakeite verslo iskrovimo vieta','%d'", LogPlayerId(playerid), LogPlayerName(playerid), BusinessInfo[business][bId]);
    log_commit();
    return 1;
}
static _Business_ChangeWaresPlacePED(playerid, business)
{
    if(!HaveAdminPermission(playerid, "ChangeBusinessExtra"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Business_ShowDetails(playerid, business);
    }

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    BusinessInfo[business][bCratesX] = x,
    BusinessInfo[business][bCratesY] = y,
    BusinessInfo[business][bCratesZ] = z;

    inline updateBusiness()
    {
        MsgSuccess(playerid, "Verslai", "Sëkmingai pakeista prekiø nuneðimo vieta.");
        _Business_ShowDetails(playerid, business);
        return 1;
    }

    
    mysql_tquery_inline(chandler, using inline updateBusiness, "\
        UPDATE `business_data` SET CratesX = '%f', CratesY = '%f', CratesZ = '%f' WHERE id = '%d'",
        x, y, z, BusinessInfo[business][bId]
    );
    
    log_init(true);
    log_set_table("logs_admins");
    log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`");
    log_set_values("'%d','%e','(AM) Pakeite verslo nunesimo vieta','%d'", LogPlayerId(playerid), LogPlayerName(playerid), BusinessInfo[business][bId]);
    log_commit();
    return 1;
}
static _Business_Delete(playerid, business)
{
    if(!HaveAdminPermission(playerid, "DeleteBusiness"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Business_ShowDetails(playerid, business);
    }

    log_init(true);
    log_set_table("logs_admins");
    log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`");
    log_set_values("'%d','%e','(AM) Istryne versla','%d'", LogPlayerId(playerid), LogPlayerName(playerid), BusinessInfo[business][bId]);
    log_commit();

    inline deleteBusiness()
    {
        return 1;
    }
    mysql_tquery_inline(chandler, using inline deleteBusiness, "\
        DELETE FROM `business_data` WHERE id = '%d';\
        DELETE FROM `business_wares` WHERE BusinessId = '%d';", 
        BusinessInfo[business][bId], BusinessInfo[business][bId]
    );
    mysql_tquery_inline(chandler, using inline deleteBusiness, "\
        DELETE FROM `business_dubkeys` WHERE BusinessId = '%d';\
        DELETE FROM `business_inventory` WHERE BusinessId = '%d';\
        DELETE FROM `business_orders` WHERE BusinessId = '%d';\
        DELETE FROM `business_orders_fuel` WHERE BusinessId = '%d'",
        BusinessInfo[business][bId], BusinessInfo[business][bId], BusinessInfo[business][bId], BusinessInfo[business][bId]
    );

    foreach(new receiver : Player)
    {
        if(PlayerInfo[playerid][pJobDestination] == business && PlayerInfo[playerid][pJobCurrentType] == 1)
        {
            MsgError(playerid, "DARBAS", "Verslas, á kurá veþëte uþsakymà buvo iðtrintas administratoriaus.");
            JobGUI_Hide(playerid);
            PlayerInfo[playerid][pJobCurrentAction] =
            PlayerInfo[playerid][pJobDuty] =
            PlayerInfo[playerid][pJobDestination] = 0;
        }
    }
    
    new 
        __reset_Business[E_BUSINESS_DATA];
    Business_DeleteFurniture(business);

    IsValidDynamic3DTextLabel(BusinessInfo[business][bLabel]) && DestroyDynamic3DTextLabel(BusinessInfo[business][bLabel]);
    sd_DestroyDynamicPickup(BusinessInfo[business][bPickup]);

    BusinessInfo[business] = __reset_Business;
    BusinessInfo[business][bLabel] = INVALID_3DTEXT_ID;

    Iter_Remove(Business, business);
    MsgSuccess(playerid, "Verslai", "Sëkmingai iðtrynëte verslà.");

    _Business_ShowList(playerid);
    return 1;
}



/**

    Prekes

 */
static _Business_Wares_Main(playerid)
{
    dialog_Clear();
    dialog_AddLine("{BABABA}Nr.\t{BABABA}Daiktas\t{BABABA}Min-max galima kaina\t{BABABA}Kiekis á inventoriø");

    for(new i = 0; i < MAX_AVAILABLE_WARES; i++)
    {
        if(AvailableWares[i][awItem] != 0)
        {
            dialog_AddLine("%d.\t%s\t$%d-$%d\t%d",
                i+1,
                GetInventoryItemName(AvailableWares[i][awItem]),
                AvailableWares[i][awMinPrice],
                AvailableWares[i][awMaxPrice],
                AvailableWares[i][awAmount]
            );
        }
        else
        {
            dialog_AddLine(">>> PRIDËTI");
            break;
        }
    }
    inline select(response, listitem)
    {
        if(response)
        {
            dialog_Row(">>> PRIDËTI")                 return _Business_Wares_AddNew(playerid);
            if(AvailableWares[listitem][awItem] != 0) return _Business_Wares_ShowDetails(playerid, listitem);
        }
        else _Business_Main(playerid);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_TABLIST_HEADERS, "Verslo galimos prekës", "Tæsti", "Atðaukti");
    return 1;
}

static _Business_Wares_AddNew(playerid, error[] = "")
{
    dialog_Clear();
    dialog_AddLine("{FFFFFF}Áveskite daikto ID, kurá norite pridëti");
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {
            new itemid;
            if(sscanf(dialog_Input(),"d",itemid))
                return _Business_Wares_AddNew(playerid, .error = "Neivestas prekes ID");

            new bool:found = false;
            for(new i = 0; i < MAX_AVAILABLE_WARES; i++)
            {
                if(AvailableWares[i][awItem] == 0)
                {
                    AvailableWares[i][awItem] = itemid;
                    AvailableWares[i][awMinPrice] = 5;
                    AvailableWares[i][awMaxPrice] = 50;
                    AvailableWares[i][awAmount] = 1;
                    found = true;
                    break;
                }
            }
            if(found)
            {
                log_init(true);
                log_set_table("logs_admins");
                log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraString`");
                log_set_values("'%d','%e','(AM) Pridejo preke i galimas verslams','%e'", LogPlayerId(playerid), LogPlayerName(playerid), GetInventoryItemName(itemid));
                log_commit();
                SendFormat(playerid, -1, "Prekë pridëta á saraðà. Praðome jà suredaguoti.");
                SaveAvailableWares();
            }
            else
            {
                SendWarning(playerid, "Galimø prekiø limitas iðnaudotas ("#MAX_AVAILABLE_WARES")");
            }
        }
        _Business_Wares_Main(playerid);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Verslo galimos prekës", "Tæsti", "Atðaukti");
    return 1;
}

static _Business_Wares_ShowDetails(playerid, ware)
{
    dialog_Clear();
    dialog_AddLine("{BABABA}Nustatymas\t{BABABA}Dabartinë reikðmë");
    dialog_AddLine("Daiktas\t%s", GetInventoryItemName(AvailableWares[ware][awItem]));
    dialog_AddLine("Pridedamas kiekis á inventoriø po pirkimo\t%d", AvailableWares[ware][awAmount]);
    dialog_AddLine("Minimali kaina\t$%d", AvailableWares[ware][awMinPrice]);
    dialog_AddLine("Maksimali kaina\t$%d", AvailableWares[ware][awMaxPrice]);
    dialog_AddLine("{C60000}Iðtrinti");
    inline select(response, listitem)
    {
        if(response)
        {
            dialog_Row("Pridedamas kiekis") return _Business_Wares_ChangeAmount(playerid, ware);
            dialog_Row("Minimali kaina")    return _Business_Wares_ChangeMinPrice(playerid, ware);
            dialog_Row("Maksimali kaina")   return _Business_Wares_ChangeMaxPrice(playerid, ware);
            dialog_Row("Iðtrinti")          return _Business_Wares_Delete(playerid, ware);
            return _Business_ShowDetails(playerid, ware);
        }
        else _Business_Wares_Main(playerid);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_TABLIST_HEADERS, "Verslo galimos prekës", "Keisti", "Atðaukti");
    return 1;
}

static _Business_Wares_ChangeAmount(playerid, ware, error[] = "")
{
    dialog_Clear();
    dialog_AddLine("{FFFFFF}Áveskite prekës kieká, kuris business duodamas þaidëjui á inventoriø");
    dialog_AddLine("po pirkimo");
    dialog_AddErrorLine(error);
    inline input(response, listitem)
    {
        if(response)
        {
            new amount;
            if(sscanf(dialog_Input(),"d",amount) || amount <= 0)
                return _Business_Wares_ChangeAmount(playerid, ware, .error = "Neivestas kiekis");
            
            AvailableWares[ware][awAmount] = amount;
            MsgSuccess(playerid, "Verslo prekës", "Kiekis pakeistas.");
            
            SaveAvailableWares(ware, AvailableWares[ware][awItem]);
            _Business_Wares_ShowDetails(playerid, ware);
        }
        else _Business_Wares_Main(playerid);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Verslo galimos prekës", "Tæsti", "Atðaukti");
    return 1;
}

static _Business_Wares_ChangeMinPrice(playerid, ware, error[] = "")
{
    dialog_Clear();
    dialog_AddLine("{FFFFFF}Áveskite minimalià kainà, kurià gali nustatyti verslas ðiai prekei.");
    dialog_AddErrorLine(error);
    inline input(response, listitem)
    {
        if(response)
        {
            new price;
            if(sscanf(dialog_Input(),"d",price) || price <= 0)
                return _Business_Wares_ChangeMinPrice(playerid, ware, .error = "Neivestas kaina");
                
            AvailableWares[ware][awMinPrice] = price;
            MsgSuccess(playerid, "Verslo prekës", "Minimali kaina pakeista.");

            if(AvailableWares[ware][awMinPrice] > AvailableWares[ware][awMaxPrice])
            {
                IntegerSwitch(AvailableWares[ware][awMinPrice], AvailableWares[ware][awMaxPrice]);
            }
            SaveAvailableWares(ware, AvailableWares[ware][awItem]);
        }
        _Business_Wares_ShowDetails(playerid, ware);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Verslo galimos prekës", "Tæsti", "Atðaukti");
    return 1;
}

static _Business_Wares_ChangeMaxPrice(playerid, ware, error[] = "")
{
    dialog_Clear();
    dialog_AddLine("{FFFFFF}Áveskite maksimalià kainà, kurià gali nustatyti verslas ðiai prekei.");
    dialog_AddErrorLine(error);
    inline input(response, listitem)
    {
        if(response)
        {
            new price;
            if(sscanf(dialog_Input(),"d",price) || price <= 0)
                return _Business_Wares_ChangeMaxPrice(playerid, ware, .error = "Neivesta kaina");
            
            AvailableWares[ware][awMaxPrice] = price;
            MsgSuccess(playerid, "Verslo prekës", "Maksimali kaina pakeista.");

            if(AvailableWares[ware][awMinPrice] > AvailableWares[ware][awMaxPrice])
            {
                IntegerSwitch(AvailableWares[ware][awMinPrice], AvailableWares[ware][awMaxPrice]);
            }
            SaveAvailableWares(ware, AvailableWares[ware][awItem]);
        }
        _Business_Wares_ShowDetails(playerid, ware);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Verslo galimos prekës", "Tæsti", "Atðaukti");
    return 1;
}

static _Business_Wares_Delete(playerid, ware)
{
    new __reset_AvailableWare[E_AVAILABLE_WARES_DATA];

    inline updateBusinessWares()
    {
        MsgSuccess(playerid, "Verslo prekës", "Sëkmingai paðalinote %s ið galimø prekiø sàraðo.", GetInventoryItemName(AvailableWares[ware][awItem]));

        AvailableWares[ware] = __reset_AvailableWare;
    
        SortEnumArray(AvailableWares, 0, MAX_AVAILABLE_WARES, [awItem], 0, E_AVAILABLE_WARES_DATA, FALSE);
        SaveAvailableWares();

        _Business_Wares_Main(playerid);
        return 1;
    }
    mysql_tquery_inline(chandler, using inline updateBusinessWares, "DELETE FROM `wares_available` WHERE ItemId = '%d'", AvailableWares[ware][awItem]);
    
    log_init(true);
    log_set_table("logs_admins");
    log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraString`");
    log_set_values("'%d','%e','(AM) Pasalino preke is galimu verslams','%e'", LogPlayerId(playerid), LogPlayerName(playerid), GetInventoryItemName(AvailableWares[ware][awItem]));
    log_commit();
    return 1;
}


/**

    Lygiai

 */
static _Business_Levels_Main(playerid)
{
    dialog_Clear();
    dialog_AddLine("{BABABA}Lygis\t{BABABA}Iðmoka");

    new varname[32];
    for(new i = 0, j = GetGVarInt("BusinessPayMaxLevels"); i <= j; i++)
    {
        format(varname, sizeof varname, "BusinessPayLevel%d", i);
        dialog_AddLine("%d\t$%d", i, GetGVarInt(varname));
    }
    inline select(response, listitem)
    {
        if(response)
        {
            _Business_Levels_ChangeMoney(playerid, listitem);
            return 1;
        }
        else _Business_Main(playerid);
        return 1;
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_TABLIST_HEADERS, "Verslo lygiai", "Tæsti", "Atðaukti");
    return 1;
}

stock _Business_Levels_ChangeMoney(playerid, level, error[] = "")
{
    dialog_Clear();
    dialog_AddLine("{FFFFFF}Áveskite iðmokà, kurià gaus visi verslai, turintys {C2EBA1}%d{FFFFFF} lygá.", level);
    inline input(response, listitem)
    {   
        if(response)
        {
            new amount,
                varname[32];
            if(sscanf(dialog_Input(),"d",amount) || amount < 0)
                return _Business_Levels_ChangeMoney(playerid, level, .error = "Neivesta suma");

            format(varname, sizeof varname, "BusinessPayLevel%d", level);
            SetGVarInt(varname, amount);
            SaveServerIntEx(varname, amount);

            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`Amount`");
            log_set_values("'%d','%e','(AM) Nustate verslo lygio gaunama suma','%d','%d'", LogPlayerId(playerid), LogPlayerName(playerid), level, amount);
            log_commit();

            MsgSuccess(playerid, "Verslai", "%d lygio suma pakeista á %d.", level, amount);
            _Business_Levels_Main(playerid);
            return 1;
        }
        else _Business_Main(playerid);
        return 1;
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Verslo lygiai", "Keisti", "Atðaukti");
    return 1;
}
