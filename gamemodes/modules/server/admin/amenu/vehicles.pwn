/** External */
stock AMenu_Vehicles_Main(playerid)
{
    _Vehicles_Main(playerid);
    return 1;
}

/** Internals */
static _Vehicles_Main(playerid)
{
    dialog_Clear();
    dialog_AddLine("Prid�ti nauj�");
    dialog_AddLine("{EDEDED}[Artimiausio automobilio redagavimas]:");
    dialog_AddLine("{FFFFFF}Keisti model�");
    dialog_AddLine("Keisti spalv�");
    dialog_AddLine("Nustatyti frakcij�");
    dialog_AddLine("Nustatyti darb�");
    dialog_AddLine("Nustatyti minimal� darbo/frakcijos lyg�");
    dialog_AddLine("I�saugoti pozicij�");
    dialog_AddLine("{C60000}I�trinti");

    inline select(response, listitem)
    {
        if(response)
        {   
            new vehicleid = GetClosestVehicle(playerid, 5.0);
            dialog_Row("Prid�ti nauj�")                            return _Vehicles_CreateNew(playerid);
            dialog_Row("{FFFFFF}Keisti model�")                    return _Vehicles_ChangeModel(playerid, vehicleid); 
            dialog_Row("Keisti spalv�")                            return _Vehicles_ChangeColor(playerid, vehicleid);
            dialog_Row("Nustatyti frakcij�")                       return _Vehicles_ChangeFaction(playerid, vehicleid); 
            dialog_Row("Nustatyti darb�")                          return _Vehicles_ChangeJob(playerid, vehicleid); 
            dialog_Row("Nustatyti minimal� darbo/frakcijos lyg�")  return _Vehicles_ChangeLevel(playerid, vehicleid); 
            dialog_Row("I�saugoti pozicij�")                       return _Vehicles_SavePosition(playerid, vehicleid); 
            dialog_Row("{C60000}I�trinti")                         return _Vehicles_Delete(playerid, vehicleid); 
        }
        else AMenu_Main(playerid);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_LIST, "Tr. priemon�s", "T�sti", "At�aukti");
    return 1;
}

static _Vehicles_CreateNew(playerid, error[] = "")
{
    if(!HaveAdminPermission(playerid, "CreateNewVehicle"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Vehicles_Main(playerid);
    }
    dialog_Clear();
    dialog_AddLine("{FFFFFF}�veskite tr. priemon�s model�.");
    dialog_AddLine("{BABABA}(wiki.sa-mp.com/wiki/Vehicle_Model_ID_List)");
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {
            new model;
            if(sscanf(dialog_Input(),"d",model) || !(400 <= model <= 612))
                return _Vehicles_CreateNew(playerid, .error = "Neteisingas modelis");

            new Float:x, Float:a, Float:z, Float:y;
            GetPlayerPos(playerid, x, y, z);
            GetPlayerFacingAngle(playerid, a);

            new vehicleid = AddServerVehicle(
                model,
                -1,
                -1,
                playerid,
                x,
                y,
                z,
                a,
                .color1 = 1,
                .color2 = 1,
                .price = 0,
                .addsiren  = 0,
                .respawntime = -1,
                .added_by_admin = true,
                .add_to_mysql = true
            );
            if(vehicleid != INVALID_VEHICLE_ID)
            {
                MsgSuccess(playerid, "Transportas", "Automobilis sukurtas.");
            }

            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`Amount`");
            log_set_values("'%d','%e','(AM) Sukure automobili','%d','%d'", LogPlayerId(playerid), LogPlayerName(playerid), VehicleInfo[vehicleid][vId], model);
            log_commit();
        }
        _Vehicles_Main(playerid);
    }   
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Tr. priemon�s", "T�sti", "At�aukti");
    return 1;
}

static _Vehicles_ChangeModel(playerid, vehicleid, error[] = "")
{
    if(!HaveAdminPermission(playerid, "EditVehicleModel"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Vehicles_Main(playerid);
    }
    if(!IsValidVehicle(vehicleid))
    {
        InfoBox(playerid, IB_NOT_CLOSE_VEHICLE);
        return _Vehicles_Main(playerid);
    }
    dialog_Clear();
    dialog_AddLine("{FFFFFF}�veskite tr. priemon�s model�.");
    dialog_AddLine("{BABABA}(wiki.sa-mp.com/wiki/Vehicle_Model_ID_List)");
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {
            new model;
            if(sscanf(dialog_Input(),"d",model) || !(400 <= model <= 612))
                return _Vehicles_ChangeModel(playerid, vehicleid, .error = "Neteisingas modelis");
            
            new Float:x, Float:y, Float:z, Float:a,
                col1, col2;

            GetVehiclePos(vehicleid, x, y, z);
            GetVehicleZAngle(vehicleid, a);
            GetVehicleColor(vehicleid, col1, col2);

            new newvehicleid = CreateVehicle(model, x, y, z, a, col1, col2, VehicleInfo[vehicleid][vRespawnTime], VehicleInfo[vehicleid][vAddSiren]);

            VehicleInfo[newvehicleid] = VehicleInfo[vehicleid];
            SaveServerVehicleIntEx(newvehicleid, "Model", model);

            DestroyVehicle(vehicleid);
            
            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`Amount`");
            log_set_values("'%d','%e','(AM) Pakeite automobilio modeli','%d','%d'", LogPlayerId(playerid), LogPlayerName(playerid), VehicleInfo[newvehicleid][vId], model);
            log_commit();
        }
        _Vehicles_Main(playerid);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Tr. priemon�s", "T�sti", "At�aukti");
    return 1;
}
static _Vehicles_ChangeColor(playerid, vehicleid, error[] = "")
{
    if(!HaveAdminPermission(playerid, "EditVehicleColor"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Vehicles_Main(playerid);
    }
    if(!IsValidVehicle(vehicleid))
    {
        InfoBox(playerid, IB_NOT_CLOSE_VEHICLE);
        return _Vehicles_Main(playerid);
    }
    
    dialog_Clear();
    dialog_AddLine("�veskite naujas spalvas, pvz: 5 5");
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {
            new color1, color2;
            if(sscanf(dialog_Input(),"dd",color1,color2))
                return _Vehicles_ChangeColor(playerid, vehicleid, .error = "Neivestos spalvos");

            ChangeVehicleColor(vehicleid, color1, color2);
            if(VehicleInfo[vehicleid][vOwner] <= 0)
            {
                SaveServerVehicleIntEx(vehicleid, "Color1", color1);
                SaveServerVehicleIntEx(vehicleid, "Color2", color2);
            }
            else
            {
                SaveVehicleIntEx(vehicleid, "Color1", color1);
                SaveVehicleIntEx(vehicleid, "Color2", color2);
            }

            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`Amount`");
            log_set_values("'%d','%e','(AM) Pakeite automobilio spalva','%d','%d'", LogPlayerId(playerid), LogPlayerName(playerid), VehicleInfo[vehicleid][vId], color1);
            log_commit();
        }
        _Vehicles_Main(playerid);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Tr. priemon�s redagavimas", "T�sti", "At�aukti");
    return 1;
}
static _Vehicles_ChangeFaction(playerid, vehicleid, error[] = "")
{
    if(!HaveAdminPermission(playerid, "EditVehicleFaction"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Vehicles_Main(playerid);
    }
    if(!IsValidVehicle(vehicleid))
    {
        InfoBox(playerid, IB_NOT_CLOSE_VEHICLE);
        return _Vehicles_Main(playerid);
    }

    dialog_Clear();
    dialog_AddLine("{FFFFFF}Frakcij� s�ra�as su numeriais:");
    dialog_AddLine("{0083EF}- -2. Nuoma");
    dialog_AddLine("- -1. Vairavimo mokykla");
    dialog_AddLine("- 0. Jokia");

    foreach(new factionid : Faction)
    {
        dialog_AddLine("- %d. %s", FactionInfo[factionid][fId], FactionInfo[factionid][fName]);
    }
    dialog_AddLine("{BABABA}�veskite norimos frakcijos nurodyt� numer�.");
    dialog_AddLine("Nor�dami pa�alinti tr. priemon�s frakcij�, �veskite 0");
    dialog_AddLine("Priskiriant tr. priemon� frakcijai, ji bus pa�alinta i� darbo.");
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {
            new factionid;
            if(sscanf(dialog_Input(),"d",factionid))
                return _Vehicles_ChangeFaction(playerid, vehicleid, .error = "Neivesta frakcija");
            
            // Reset faction
            VehicleInfo[vehicleid][vRequiredLevel] = VehicleInfo[vehicleid][vJob] = VehicleInfo[vehicleid][vOwner] = 0;
            VehicleInfo[vehicleid][vFaction] = factionid;
    
            SaveServerVehicleIntEx(vehicleid, "FactionId", factionid);    
            MsgSuccess(playerid, "TRANSPORTAS", "Tr. priemon� priskirta frakcijai, kurios MySQL numeris: %d.", factionid);
            SetVehicleToRespawn(vehicleid);

            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`Amount`");
            log_set_values("'%d','%e','(AM) Pakeite automobilio frakcija','%d','%d'", LogPlayerId(playerid), LogPlayerName(playerid), VehicleInfo[vehicleid][vId], VehicleInfo[vehicleid][vFaction]);
            log_commit();
        }
        _Vehicles_Main(playerid);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Tr. priemon�s redagavimas", "T�sti", "At�aukti");
    return 1;
}
static _Vehicles_ChangeJob(playerid, vehicleid, error[] = "")
{
    if(!HaveAdminPermission(playerid, "EditVehicleJob"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Vehicles_Main(playerid);
    }
    if(!IsValidVehicle(vehicleid))
    {
        InfoBox(playerid, IB_NOT_CLOSE_VEHICLE);
        return _Vehicles_Main(playerid);
    }
    
    dialog_Clear();
    dialog_AddLine("{FFFFFF}Darb� s�ra�as su numeriais:\n{0083EF}- 0. Joks");
    for(new i = 0; i < sizeof Jobs; i++)
    {
        dialog_AddLine("- %d. %s", Jobs[i][jobId], Jobs[i][jobName]);
    }
    dialog_AddLine("{BABABA}�veskite norimo darbo nurodyt� numer�.");
    dialog_AddLine("Nor�dami pa�alinti tr. priemon�s darb�, �veskite 0");
    dialog_AddLine("Priskiriant tr. priemon� darbui, ji bus pa�alinta i� frakcijos.");
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {
            new jobid;
            if(sscanf(dialog_Input(),"d",jobid))
                return _Vehicles_ChangeJob(playerid, vehicleid, .error = "Neivestas darbo ID");
            
            VehicleInfo[vehicleid][vRequiredLevel] = 0;
            VehicleInfo[vehicleid][vJob] = jobid;
            VehicleInfo[vehicleid][vOwner] = 0;
            VehicleInfo[vehicleid][vFaction] = 0;
            
            SaveServerVehicleIntEx(vehicleid, "JobId", jobid);
            MsgSuccess(playerid, "TRANSPORTAS", "Tr. priemon� priskirta darbui, kurio ID: %d.", jobid);
            SetVehicleToRespawn(vehicleid);
            
            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`Amount`");
            log_set_values("'%d','%e','(AM) Pakeite automobilio darba','%d','%d'", LogPlayerId(playerid), LogPlayerName(playerid), VehicleInfo[vehicleid][vId], VehicleInfo[vehicleid][vJob]);
            log_commit();
        }
        _Vehicles_Main(playerid);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Tr. priemon�s redagavimas", "T�sti", "At�aukti");
    return 1;
}
static _Vehicles_ChangeLevel(playerid, vehicleid, error[] = "")
{
    if(!HaveAdminPermission(playerid, "EditVehicleJob") && !HaveAdminPermission(playerid, "EditVehicleFaction"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Vehicles_Main(playerid);
    }
    if(!IsValidVehicle(vehicleid))
    {
        InfoBox(playerid, IB_NOT_CLOSE_VEHICLE);
        return _Vehicles_Main(playerid);
    }

    if(VehicleInfo[vehicleid][vJob] == 0 && VehicleInfo[vehicleid][vFaction] == 0)
    {
        return _Vehicles_ChangeLevel(playerid, vehicleid, .error = "Tr. priemon� neturi nustatytos frakcijos arba darbo.");
    }

    dialog_Clear();
    dialog_AddLine("{FFFFFF}�veskite minimal� reikaling� darbo lyg� arba frakcijos rang�.");
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {
            new rank;
            if(sscanf(dialog_Input(),"d",rank))
                return _Vehicles_ChangeLevel(playerid, vehicleid, .error = "Neivestas rank");

            VehicleInfo[vehicleid][vRequiredLevel] = rank;
            SaveServerVehicleIntEx(vehicleid, "RequiredLevel", rank);

            MsgSuccess(playerid, "TRANSPORTAS", "Reikalingas lygis s�kmingai i�saugotas.");

            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`Amount`");
            log_set_values("'%d','%e','(AM) Pakeite automobilio ranka','%d','%d'", LogPlayerId(playerid), LogPlayerName(playerid), VehicleInfo[vehicleid][vId], rank);
            log_commit();
        }
        _Vehicles_Main(playerid);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Tr. priemon�s redagavimas", "T�sti", "At�aukti");
    return 1;
}
static _Vehicles_SavePosition(playerid, vehicleid)
{
    if(!HaveAdminPermission(playerid, "ChangeVehiclePosition"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Vehicles_Main(playerid);
    }
    if(!IsValidVehicle(vehicleid))
    {
        InfoBox(playerid, IB_NOT_CLOSE_VEHICLE);
        return _Vehicles_Main(playerid);
    }

    new Float:x, Float:y, Float:z, Float:a, model,
        newvehicleid,
        col1, col2;

    model = GetVehicleModel(vehicleid);
    GetVehiclePos(vehicleid, x, y, z);
    GetVehicleZAngle(vehicleid, a);
    GetVehicleColor(vehicleid, col1, col2);

    SaveServerVehicleFloatEx(vehicleid, "X", x);
    SaveServerVehicleFloatEx(vehicleid, "Y", y);
    SaveServerVehicleFloatEx(vehicleid, "Z", z);
    SaveServerVehicleFloatEx(vehicleid, "A", a);
    
    newvehicleid = CreateVehicle(model, x, y, z, a, col1, col2, VehicleInfo[vehicleid][vRespawnTime], VehicleInfo[vehicleid][vAddSiren]);
    VehicleInfo[newvehicleid] = VehicleInfo[vehicleid];

    DestroyVehicle(vehicleid);
    MsgSuccess(playerid, "TRANSPORTAS", "Vieta s�kmingai i�saugota.");
    
    log_init(true);
    log_set_table("logs_admins");
    log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`");
    log_set_values("'%d','%e','(AM) Pakeite automobilio vieta','%d','%d'", LogPlayerId(playerid), LogPlayerName(playerid), VehicleInfo[newvehicleid][vId]);
    log_commit();

    
    _Vehicles_Main(playerid);
    return 1;
}
static _Vehicles_Delete(playerid, vehicleid)
{
    if(!HaveAdminPermission(playerid, "DeleteVehicle"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Vehicles_Main(playerid);
    }
    if(!IsValidVehicle(vehicleid))
    {
        InfoBox(playerid, IB_NOT_CLOSE_VEHICLE);
        return _Vehicles_Main(playerid);
    }

    if(VehicleInfo[vehicleid][vOwner] > 0)
    {
        SendWarning(playerid, "Tr. priemon� yra privati.");
        return _Vehicles_Main(playerid);
    }

    inline vehicleDeleted()
    {
        MsgSuccess(playerid, "TRANSPORTAS", "S�kmingai i�tryn�te tr. priemon�.");
        return 1;
    }
    mysql_tquery_inline(chandler, using inline vehicleDeleted, "\
        DELETE IGNORE FROM `vehicles_server` WHERE id = '%d'", VehicleInfo[vehicleid][vId]
    );
    DestroyVehicle(vehicleid);

    log_init(true);
    log_set_table("logs_admins");
    log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`");
    log_set_values("'%d','%e','(AM) Istryne automobili','%d'", LogPlayerId(playerid), LogPlayerName(playerid), VehicleInfo[vehicleid][vId]);
    log_commit();

    _Vehicles_Main(playerid);
    return 1;
}

