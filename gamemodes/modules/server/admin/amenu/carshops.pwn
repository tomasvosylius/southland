#define HOUSES_PER_PAGE 50

/** External */
stock AMenu_CarShops_Main(playerid)
{
    _CarShops_Main(playerid);
    return 1;
}

/** Internals */
static _CarShops_Main(playerid)
{
    dialog_Clear();
    dialog_AddLine("Kurti naujà");
    dialog_AddLine("Perþiûrëti visus");

    inline select(response, listitem)
    {
        if(!response) return AMenu_Main(playerid);

        dialog_Row("Kurti naujà")       return _CarShops_CreateNew(playerid);
        dialog_Row("Perþiûrëti visus")  return _CarShops_ShowList(playerid);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_LIST, "Tr. priemoniø salonai", "Tæsti", "Atðaukti");
    return 1;
}

static _CarShops_CreateNew(playerid, error[] = "")
{
    // kurti nauja salona
    if(!HaveAdminPermission(playerid, "CreateNewSalon"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _CarShops_Main(playerid);
    }

    dialog_Clear();
    dialog_AddLine("{FFFFFF}Áveskite naujojo salono pavadinimà.");
    dialog_AddErrorLine(error);
    inline input(response, listitem)
    {
        if(response)
        {
            if(strlen(dialog_Input()) < 3)
                return _CarShops_CreateNew(playerid, .error = "Pavadinimas per trumpas arba per ilgas.");

            new Float:x, Float:y, Float:z;
            GetPlayerPos(playerid, x, y, z);

            inline insertNew()
            {
                if(mysql_errno() == 0)
                {
                    new salon = Iter_Free(Salon),
                        __reset_Salon[E_SALON_DATA];

                    SalonData[salon] = __reset_Salon;
                    format(SalonData[salon][salonName], 255, dialog_Input());
                    SalonData[salon][salonId] = cache_insert_id();
                    SalonData[salon][salonX] = x,
                    SalonData[salon][salonY] = y,
                    SalonData[salon][salonZ] = z;
                    SalonData[salon][salonInterior] = GetPlayerInterior(playerid);
                    SalonData[salon][salonVW] = GetPlayerVirtualWorld(playerid);
                    SalonData[salon][salonPickup] = sd_CreateDynamicPickup(PICKUP_TYPE_SALON, salon, 1274, 1, SalonData[salon][salonX], SalonData[salon][salonY], SalonData[salon][salonZ], SalonData[salon][salonVW], SalonData[salon][salonInterior]);
                    Iter_Add(Salon, salon);

                    MsgSuccess(playerid, "Salonai", "Sëkmingai sukûrëte salonà, kurio ID: %d", SalonData[salon][salonId]);
                    _CarShops_ShowDetails(playerid, salon);

                    log_init(true);
                    log_set_table("logs_admins");
                    log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`");
                    log_set_values("'%d','%e','(AM) Sukure nauja salona','%d'", LogPlayerId(playerid), LogPlayerName(playerid), SalonData[salon][salonId]);
                    log_commit();
                }
                else
                {
                    SendError(playerid, "Siøsta uþklausa nepavyko [%d]", mysql_errno());
                }
                return 1;
            }
            mysql_tquery_inline(chandler, using inline insertNew, "\
                INSERT INTO `sell_salons` (`Added`,`X`,`Y`,`Z`,`Interior`,`VW`,`Name`) \
                VALUES \
                ('%d','%f','%f','%f','%d','%d','%e')",
                PlayerInfo[playerid][pId], x, y, z, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid), dialog_Input()
            );
            
        }
        else _CarShops_Main(playerid);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Tr. priemoniø salonai", "Tæsti", "Atðaukti");
    return 1;
}

static _CarShops_ShowList(playerid)
{
    if(!HaveAdminPermission(playerid, "EditSalons"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _CarShops_Main(playerid);
    }
    dialog_Clear();
    dialog_AddLine("{BABABA}Nr.\t{BABABA}Pavadinimas\t{BABABA}MySQL ID (numeris)");
    new iter;
    if(Iter_Count(Salon) <= 0)
    {
        SendWarning(playerid, "Nëra salonø.");
        return _CarShops_Main(playerid);
    }
    foreach(new salon : Salon)
    {
        if(SalonData[salon][salonId] != 0)
        {
            iter++;
            dialog_AddLine("%d.\t%.10s%s\t%d", iter, SalonData[salon][salonName], strlen(SalonData[salon][salonName]) > 10 ? ("...") : (""), SalonData[salon][salonId]);
        }
    }
    inline select(response, listitem)
    {
        if(response)
        {
            new salon;
            GetSortedAsForeach(Salon, listitem, salon, SalonData[loopindex][salonId] != 0);
            _CarShops_ShowDetails(playerid, salon);
        }
        else _CarShops_Main(playerid);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_TABLIST_HEADERS, "Tr. priemoniø salonai", "Tæsti", "Atðaukti");
    return 1;
}

static _CarShops_ShowDetails(playerid, salon)
{
    dialog_Clear();
    dialog_AddLine("{BABABA}Nustatymas\t{BABABA}Dabartinë reikðmë");
    dialog_AddLine("Pavadinimas\t%.24s%s", SalonData[salon][salonName], strlen(SalonData[salon][salonName]) > 24 ? ("...") : (""));
    dialog_AddLine("Keisti vietà");
    dialog_AddLine("Galimos SPAWN vietos po nupirkimo");
    dialog_AddLine("Parduodamos tr. priemonës");
    dialog_AddLine("%s broko tikimybæ", SalonData[salon][salonGarbage] > 0 ? ("Iðjungti") : ("Ájungti"));
    dialog_AddLine("{C60000}Iðtrinti");
    inline select(response, listitem)
    {
        if(response)
        {
            dialog_Row("Pavadinimas")                       return _CarShops_ChangeName(playerid, salon);
            dialog_Row("Keisti vietà")                      return _CarShops_ChangePlace(playerid, salon);
            dialog_Row("Galimos SPAWN vietos po nupirkimo") return _CarShops_Spawns_Main(playerid, salon);
            dialog_Row("Parduodamos tr. priemonës")         return _CarShops_Cars_Main(playerid, salon);
            dialog_Row("broko tikimybæ")                    return _CarShops_ChangeGarbage(playerid, salon);
            dialog_Row("Iðtrinti")                          return _CarShops_Delete(playerid, salon);
        }
        else _CarShops_ShowList(playerid);
        return 1;
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_TABLIST_HEADERS, "Tr. priemoniø salonai", "Tæsti", "Atðaukti");
    return 1;
}


static _CarShops_ChangeName(playerid, salon)
{
    if(!HaveAdminPermission(playerid, "EditSalonName"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _CarShops_Main(playerid);
    }
    dialog_Clear();
    dialog_AddLine("{FFFFFF}Áveskite naujà salono pavadinimà.");

    inline input(response, listitem)
    {
        if(response)
        {   
            if(strlen(dialog_Input()) < 3)
                return _CarShops_ChangeName(playerid, salon);

            format(SalonData[salon][salonName], 255, dialog_Input());
            
            inline updateSalon()
            {
                MsgSuccess(playerid, "Salonai", "Pakeitëte salono pavadinimà.");
                return 1;
            }
            mysql_tquery_inline(chandler, using inline updateSalon, "\
                UPDATE `sell_salons` SET Name = '%s' WHERE id = '%d'",
                SalonData[salon][salonId]
            );
        }
        _CarShops_ShowDetails(playerid, salon);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Tr. priemoniø salonai", "Tæsti", "Atðaukti");
    return 1;
}

static _CarShops_ChangePlace(playerid, salon)
{
    if(!HaveAdminPermission(playerid, "ChangeSalonPosition"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _CarShops_Main(playerid);
    }

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    SalonData[salon][salonX] = x,
    SalonData[salon][salonY] = y,
    SalonData[salon][salonZ] = z;
    SalonData[salon][salonInterior] = GetPlayerInterior(playerid);
    SalonData[salon][salonVW] = GetPlayerVirtualWorld(playerid);

    inline updateSalon()
    {
        MsgSuccess(playerid, "Salonai", "Salono vieta nustatyta á jûsø esamà.");
        _CarShops_ShowDetails(playerid, salon);
        return 1;
    }
    mysql_tquery_inline(chandler, using inline updateSalon, "\
        UPDATE `sell_salons` SET X = '%0.3f', Y = '%0.3f', Z = '%0.3f', Interior = '%d', VW = '%d' WHERE id = '%d'",
        SalonData[salon][salonX], SalonData[salon][salonY], SalonData[salon][salonZ],
        SalonData[salon][salonInterior], SalonData[salon][salonVW], SalonData[salon][salonId]
    );

    IsValidDynamicPickup(SalonData[salon][salonPickup]) && sd_DestroyDynamicPickup(SalonData[salon][salonPickup]);
    SalonData[salon][salonPickup] = sd_CreateDynamicPickup(PICKUP_TYPE_SALON, salon, 1274, 1, SalonData[salon][salonX], SalonData[salon][salonY], SalonData[salon][salonZ], SalonData[salon][salonVW], SalonData[salon][salonInterior]);

    log_init(true);
    log_set_table("logs_admins");
    log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`");
    log_set_values("'%d','%e','(AM) Pakeite salono vieta','%d'", LogPlayerId(playerid), LogPlayerName(playerid), SalonData[salon][salonId]);
    log_commit();
    return 1;
}

static _CarShops_ChangeGarbage(playerid, salon)
{
    if(!HaveAdminPermission(playerid, "EditSalons"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _CarShops_Main(playerid);
    }

    SalonData[salon][salonGarbage] = !SalonData[salon][salonGarbage];    
    inline updateSalon()
    {
        SendFormat(playerid, -1, "Broko tikimybe (50-80proc variklis/akumuliatorius) buvo %s siam salonui.", SalonData[salon][salonGarbage] > 0 ? ("ijungta") : ("isjungta"));
        _CarShops_ShowDetails(playerid, salon);
    }
    mysql_tquery_inline(chandler, using inline updateSalon, "\
        UPDATE `sell_salons` SET Garbage = '%d' WHERE id = '%d'",
        SalonData[salon][salonGarbage], SalonData[salon][salonId]
    );
    return 1;
}

static _CarShops_Delete(playerid, salon)
{
    if(!HaveAdminPermission(playerid, "DeleteSalon"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _CarShops_Main(playerid);
    }

    new __reset_Salon[E_SALON_DATA];
    
    log_init(true);
    log_set_table("logs_admins");
    log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`ExtraString`");
    log_set_values("'%d','%e','(AM) Istryne salona','%d','%e'", LogPlayerId(playerid), LogPlayerName(playerid), SalonData[salon][salonId], SalonData[salon][salonName]);
    log_commit();

    inline deleteSalon()
    {
        MsgSuccess(playerid, "Salonai", "Sëkmingai iðtrynëte salonà.");
        _CarShops_Main(playerid);
        return 1;
    }
    mysql_tquery_inline(chandler, using inline deleteSalon, "DELETE FROM `sell_salons` WHERE id = '%d'; DELETE FROM `sell_salons_spawns` WHERE SalonId = '%d'; DELETE FROM `sell_vehicles` WHERE SalonId = '%d'", SalonData[salon][salonId], SalonData[salon][salonId], SalonData[salon][salonId]);

    IsValidDynamicPickup(SalonData[salon][salonPickup]) && sd_DestroyDynamicPickup(SalonData[salon][salonPickup]);
    SalonData[salon] = __reset_Salon;
    Iter_Remove(Salon, salon);
    return 1;
}

/**

    Spawnai

 */

static _CarShops_Spawns_Main(playerid, salon)
{
    if(!HaveAdminPermission(playerid, "EditSalonSpawns"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _CarShops_Main(playerid);
    }
    inline loadSpawns()
    {
        new i, line[32],
            rows = cache_num_rows(), Float:x, Float:y, Float:z;

        dialog_Clear();
        dialog_AddLine("{BABABA}X\t{BABABA}Y\t{BABABA}Z\t{BABABA}Vieta");

        for(; i < rows; i++)
        {
            cache_get_value_name_float(i, "X", x);
            cache_get_value_name_float(i, "Y", y);
            cache_get_value_name_float(i, "Z", z);
            GetCoords2DZone(line, 28, x, y);

            dialog_AddLine("%0.2f\t%0.2f\t%0.2f\t%s", x, y, z, line);
        }

        dialog_AddLine(">>> PRIDËTI");
        inline select(response, listitem)
        {
            if(response)
            {
                dialog_Row(">>> PRIDËTI") return _CarShops_Spawns_CreateNew(playerid, salon);
                _CarShops_Spawns_ShowDetails(playerid, salon, listitem);
            }   
            else _CarShops_ShowDetails(playerid, salon);
        }
        dialog_Show(playerid, using inline select, DIALOG_STYLE_TABLIST_HEADERS, "Tr. priemoniø salonai", "Tæsti", "Atðaukti");
    }
    mysql_tquery_inline(chandler, using inline loadSpawns, "\
        SELECT * FROM `sell_salons_spawns` WHERE SalonId = '%d'",
        SalonData[salon][salonId]
    );
    return 1;
}

stock _CarShops_Spawns_CreateNew(playerid, salon)
{
    // kurti nauja
    new Float:x, Float:y, Float:z, Float:a;
    if(IsPlayerInAnyVehicle(playerid))
    {
        GetVehiclePos(GetPlayerVehicleID(playerid), x, y, z);
        GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
    }
    else
    {
        GetPlayerPos(playerid, x, y, z);
        GetPlayerFacingAngle(playerid, a);
    }
    inline addNewSpawn()
    {
        MsgSuccess(playerid, "Salonai", "Pridëjote papildomà spawn vietà.");
        _CarShops_Spawns_Main(playerid, salon);
        return 1;
    }
    mysql_tquery_inline(chandler, using inline addNewSpawn, "\
        INSERT INTO `sell_salons_spawns` (`SalonId`,`X`,`Y`,`Z`,`A`,`Added`) \
        VALUES \
        ('%d','%0.3f','%0.3f','%0.3f','%0.3f','%d')",
        SalonData[salon][salonId], x, y, z, a, PlayerInfo[playerid][pId]
    );
    
    log_init(true);
    log_set_table("logs_admins");
    log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`");
    log_set_values("'%d','%e','(AM) Pridejo spawn vieta i salona','%d'", LogPlayerId(playerid), LogPlayerName(playerid), SalonData[salon][salonId]);
    log_commit();
    return 1;
}

stock _CarShops_Spawns_ShowDetails(playerid, salon, offset)
{
    dialog_Clear();
    dialog_AddLine("Teleportuotis á vietà");
    dialog_AddLine("{C60000}Iðtrinti");
    inline select(response, listitem)
    {
        if(response)
        {
            dialog_Row("Teleportuotis á vietà") return _CarShops_Spawns_Teleport(playerid, salon, offset);
            dialog_Row("Iðtrinti")              return _CarShops_Spawns_Delete(playerid, salon, offset);
        }
        else _CarShops_Spawns_Main(playerid, salon);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_LIST, "Tr. priemoniø salonai", "Tæsti", "Atðaukti");
    return 1;
}

static _CarShops_Spawns_Teleport(playerid, salon, offset)
{
    new Float:x, Float:y, Float:z, Float:a;

    inline getCords()
    {
        if(cache_num_rows())
        {
            cache_get_value_name_float(0, "X", x);
            cache_get_value_name_float(0, "Y", y);
            cache_get_value_name_float(0, "Z", z);
            cache_get_value_name_float(0, "A", a);
            SetPlayerPos(playerid, x, y, z);
            SetPlayerFacingAngle(playerid, a);
        }
        _CarShops_Spawns_Main(playerid, salon);
    }
    mysql_tquery_inline(chandler, using inline getCords, "\
        SELECT `X`,`Y`,`Z`,`A` FROM `sell_salons_spawns` WHERE SalonId = '%d' LIMIT 1 OFFSET %d", SalonData[salon][salonId], offset);
    return 1;
}
static _CarShops_Spawns_Delete(playerid, salon, offset)
{
    inline getId()
    {
        if(cache_num_rows())
        {
            new id;
            cache_get_value_name_int(0, "id", id);
            inline deleteSpawn()
            {
                MsgSuccess(playerid, "Salonai", "Spawn vieta iðtrinta.");
                _CarShops_Spawns_Main(playerid, salon);
                return 1;
            }
            mysql_tquery_inline(chandler, using inline deleteSpawn, "\
                DELETE FROM `sell_salons_spawns` WHERE SalonId = '%d' AND id = '%d'",
                SalonData[salon][salonId], id
            );
        }
        else SendError(playerid, "Spawn vieta nerasta.");
        return 1;
    }
    mysql_tquery_inline(chandler, using inline getId, "\
        SELECT `id` FROM `sell_salons_spawns` WHERE SalonId = '%d' LIMIT 1 OFFSET %d",
        SalonData[salon][salonId], offset
    );
    return 1;
}


/**

    Car list

 */


static _CarShops_Cars_Main(playerid, salon)
{
    if(!HaveAdminPermission(playerid, "EditSalonVehicles"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _CarShops_Main(playerid);
    }

    dialog_Clear();
    dialog_AddLine("{BABABA}Nr.\t{BABABA}Modelis\t{BABABA}Reikalingas remëjo lygis\t{BABABA}Kaina");
    new salonSql = SalonData[salon][salonId],
        i;
    foreach(new sell : SellVehicle)
    {
        if(SellVehicleData[sell][sellvehicleSalon] == salonSql)
        {
            i++;
            dialog_AddLine("%d.\t%s\t%d\t$%d", 
                i,
                GetModelName(SellVehicleData[sell][sellvehicleModel]),
                SellVehicleData[sell][sellvehicleDonator],
                SellVehicleData[sell][sellvehiclePrice]
            );
        }
    }
    dialog_AddLine(">>> PRIDËTI");
    inline select(response, listitem)
    {
        if(response)
        {
            dialog_Row(">>> PRIDËTI") return _CarShops_Cars_CreateNew(playerid, salon);

            new car = 0;
            GetSortedAsForeach(SellVehicle, listitem, car, (SellVehicleData[loopindex][sellvehicleSalon] == salonSql));
            _CarShops_Cars_ShowDetails(playerid, salon, car);
        }
        else _CarShops_ShowDetails(playerid, salon);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_TABLIST_HEADERS, "Tr. priemoniø salonai", "Tæsti", "Atðaukti");
    return 1;
}

static _CarShops_Cars_CreateNew(playerid, salon, error[] = "")
{
    dialog_Clear();
    dialog_AddLine("{FFFFFF}Áveskite naujà tr. priemonës modelá.");
    dialog_AddLine("{BABABA}(wiki.sa-mp.com/wiki/Vehicle_Model_ID_List)");
    dialog_AddErrorLine(error);

    inline select(response, listitem)
    {
        if(response)
        {
            new model;
            if(sscanf(dialog_Input(),"d",model) || !(400 <= model <= 611))
                return _CarShops_Cars_CreateNew(playerid, salon, .error = "Neteisingas modelis.");

            if(IsModelInSalon(salon, model))
                return _CarShops_Cars_CreateNew(playerid, salon, .error = "Tokia tr. priemonë salone jau yra.");

            inline addNewCar()
            {
                MsgSuccess(playerid, "SALONAI", "Tr. priemonë %s pridëta á salonà. Praðome pakeisti jos kainà.", GetModelName(model));
                return 1;
            }
            mysql_tquery_inline(chandler, using inline addNewCar, "\
                INSERT INTO `sell_vehicles` (`Model`,`Price`,`Added`,`SalonId`) \
                VALUES \
                ('%d','10000','%d','%d')", 
                model, PlayerInfo[playerid][pId], SalonData[salon][salonId]
            );

            new car = Iter_Free(SellVehicle);
            SellVehicleData[car][sellvehicleSalon] = SalonData[salon][salonId];
            SellVehicleData[car][sellvehicleModel] = model;
            SellVehicleData[car][sellvehiclePrice] = 10000;
            SellVehicleData[car][sellvehicleDonator] = 0;
            Iter_Add(SellVehicle, car);
            _CarShops_Cars_ShowDetails(playerid, salon, car);
            
            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`Amount`");
            log_set_values("'%d','%e','(AM) Pridejo modeli i salono parduodamus','%d','%d'", LogPlayerId(playerid), LogPlayerName(playerid), SalonData[salon][salonId], model);
            log_commit();
        }
        else _CarShops_Cars_Main(playerid, salon);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_INPUT, "Tr. priemoniø salonai", "Tæsti", "Atðaukti");
    return 1;
}

static _CarShops_Cars_ShowDetails(playerid, salon, car)
{
    dialog_Clear();
    dialog_AddLine("Keisti modelá");
    dialog_AddLine("Keisti kainà\t%d$", SellVehicleData[car][sellvehiclePrice]);
    dialog_AddLine("Minimalaus remëjo lygis\t%d", SellVehicleData[car][sellvehicleDonator]);
    dialog_AddLine("{C60000}Iðtrinti");
    inline select(response, listitem)
    {
        if(response)
        {
            dialog_Row("Keisti modelá")           return _CarShops_Cars_ChangeModel(playerid, salon, car);
            dialog_Row("Keisti kainà")            return _CarShops_Cars_ChangePrice(playerid, salon, car);
            dialog_Row("Minimalaus remëjo lygis") return _CarShops_Cars_ChangeDonator(playerid, salon, car);
            dialog_Row("Iðtrinti")                return _CarShops_Cars_Delete(playerid, salon, car);
        }
        else _CarShops_Cars_Main(playerid, salon);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_LIST, "Tr. priemoniø salonai", "Tæsti", "Atðaukti");
    return 1;
}

static _CarShops_Cars_ChangeModel(playerid, salon, car, error[] = "")
{
    dialog_Clear();
    dialog_AddLine("{FFFFFF}Áveskite naujà tr. priemonës modelá.");
    dialog_AddLine("{BABABA}(wiki.sa-mp.com/wiki/Vehicle_Model_ID_List)");
    dialog_AddErrorLine(error);
    inline input(response, listitem)
    {
        if(response)
        {
            new model;
            if(sscanf(dialog_Input(),"d",model) || !(400 <= model <= 611))
                return _CarShops_Cars_ChangeModel(playerid, salon, car);

            if(IsModelInSalon(salon, model))
                return _CarShops_Cars_ChangeModel(playerid, salon, car, .error = "Tokia tr. priemonë salone jau yra.");

            inline updateSalonCar()
            {
                MsgSuccess(playerid, "Salonai", "Tr. priemonës modelis sëkmingai pakeistas.");
                return 1;
            }
            mysql_tquery_inline(chandler, using inline updateSalonCar, "\
                UPDATE `sell_vehicles` SET Model = '%d' WHERE Model = '%d' AND SalonId = '%d'",
                model, SellVehicleData[car][sellvehicleModel], SalonData[salon][salonId]
            );
            SellVehicleData[car][sellvehicleModel] = model;

            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`Amount`");
            log_set_values("'%d','%e','(AM) Pakeite salono parduodama modeli','%d','%d'", LogPlayerId(playerid), LogPlayerName(playerid), SalonData[salon][salonId], model);
            log_commit();
        }
        _CarShops_Cars_ShowDetails(playerid, salon, car);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Tr. priemoniø salonai", "Tæsti", "Atðaukti");
    return 1;
}

static _CarShops_Cars_ChangePrice(playerid, salon, car)
{
    dialog_Clear();
    dialog_AddLine("{FFFFFF}Áveskite naujà tr. priemonës kainà.");
    inline input(response, listitem)
    {
        if(response)
        {
            new price;
            if(sscanf(dialog_Input(),"d",price) || price < 100)
                return _CarShops_Cars_ChangePrice(playerid, salon, car);
                
            inline updateSalonCar()
            {
                MsgSuccess(playerid, "Salonai", "Tr. priemonës kaina sëkmingai pakeista.");
                return 1;
            }
            mysql_tquery_inline(chandler, using inline updateSalonCar, "\
                UPDATE `sell_vehicles` SET Price = '%d' WHERE Model = '%d' AND SalonId = '%d'", 
                price, SellVehicleData[car][sellvehicleModel], SalonData[salon][salonId]
            );
            
            SellVehicleData[car][sellvehiclePrice] = price;
                
            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`ReceiverId`,`Amount`");
            log_set_values("'%d','%e','(AM) Pakeite salono parduodamo modelio kaina','%d','%d','%d'", LogPlayerId(playerid), LogPlayerName(playerid), SalonData[salon][salonId], SellVehicleData[car][sellvehicleModel], price);
            log_commit();
        }
        _CarShops_Cars_ShowDetails(playerid, salon, car);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Tr. priemoniø salonai", "Tæsti", "Atðaukti");
    return 1;
}

static _CarShops_Cars_ChangeDonator(playerid, salon, car)
{
    dialog_Clear();
    dialog_AddLine("Joks");
    dialog_AddLine("Bronzinis (I)");
    dialog_AddLine("Sidabrinis (II)");
    dialog_AddLine("Auksinis (III)");
    inline select(response, listitem)
    {
        if(response)
        {
            inline updateSalonCar()
            {
                MsgSuccess(playerid, "Salonai", "Tr. priemonës remëjo lygis sëkmingai pakeistas.");
                return 1;
            }
            mysql_tquery_inline(chandler, using inline updateSalonCar, "\
                UPDATE `sell_vehicles` SET Donator = '%d' WHERE Model = '%d' AND SalonId = '%d'",\
                listitem, SellVehicleData[car][sellvehicleModel], SalonData[salon][salonId]
            );

            SellVehicleData[car][sellvehicleDonator] = listitem;

            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`ReceiverId`,`Amount`");
            log_set_values("'%d','%e','(AM) Pakeite salono parduodamo modelio remeja','%d','%d','%d'", LogPlayerId(playerid), LogPlayerName(playerid), SalonData[salon][salonId], SellVehicleData[car][sellvehicleModel], listitem);
            log_commit();
        }
        _CarShops_Cars_Main(playerid, salon);
        return 1;
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_LIST, "Tr. priemoniø salonai", "Tæsti", "Atðaukti");
    return 1;
}

static _CarShops_Cars_Delete(playerid, salon, car)
{
    log_init(true);
    log_set_table("logs_admins");
    log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`Amount`");
    log_set_values("'%d','%e','(AM) Istryne modeli is salono parduodamu','%d','%d'", LogPlayerId(playerid), LogPlayerName(playerid), SalonData[salon][salonId], SellVehicleData[car][sellvehicleModel]);
    log_commit();

    inline deleteSalonCar()
    {
        MsgSuccess(playerid, "Salonai", "Tr. priemonë paðalinta ið sàraðo.");
        return 1;
    }
    mysql_tquery_inline(chandler, using inline deleteSalonCar, "\
        DELETE FROM `sell_vehicles` WHERE Model = '%d' AND SalonId = '%d'",
        SellVehicleData[car][sellvehicleModel], SalonData[salon][salonId]
    );

    Iter_Remove(SellVehicle, car);    
    _CarShops_Cars_Main(playerid, salon);
    return 1;
}