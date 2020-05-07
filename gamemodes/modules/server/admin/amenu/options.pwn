/** External */
stock AMenu_Options_Main(playerid)
{
    _Opts_Main(playerid);
    return 1;
}

/** Internal */
static _Opts_Main(playerid)
{
    dialog_Clear();

    dialog_AddLine("Tr. priemoniø nustatymai");
    dialog_AddLine("Verslo nustatymai");
    dialog_AddLine("Namo nustatymai");
    dialog_AddLine("Ájungimai/iðjungimai");
    dialog_AddLine("Vietø nustatymai");
    dialog_AddLine("Kiti nustatymai");

    inline options(response, listitem)
    {
        if(response)
        {
            dialog_Row("Tr. priemoniø nustatymai") return _Opts_Vehicles_Main(playerid);
            dialog_Row("Verslo nustatymai")        return _Opts_Business_Main(playerid);
            dialog_Row("Namo nustatymai")          return _Opts_Houses_Main(playerid);
            dialog_Row("Ájungimai/iðjungimai")     return _Opts_OnOff_Main(playerid);
            dialog_Row("Vietø nustatymai")         return _Opts_Places_Main(playerid);
            dialog_Row("Kiti nustatymai")          return _Opts_Other_Main(playerid);
        }
    }
    dialog_Show(playerid, using inline options, DIALOG_STYLE_LIST, "Bendrieji serverio nustatymai", "Tæsti", "Atðaukti");
    return 1;
}

static _Opts_Vehicles_Main(playerid)
{
    // tr. priemoniu mokesciai
    dialog_Clear();
    
    dialog_AddLine("{BABABA}Nustatymas\t{BABABA}Dabartinë reikðmë");
    dialog_AddLine("Mokeðèiø dydis\t$%d", GetGVarInt("VehicleTaxes"));
    dialog_AddLine("Ar papildomai priskaièiuoti pagal tr. priemonës klasæ?\t%s", GetGVarInt("CountVehicleClass") > 0 ? ("Taip") : ("Ne"));

    inline vehicles(response, listitem)
    {
        if(response)
        {
            if(!HaveAdminPermission(playerid, "EditVehicleTaxes"))
            {
                InfoBox(playerid, IB_NO_PRIVILEGE);
                return _Opts_Main(playerid);
            }

            dialog_Row("Mokeðèiø dydis") return _Opts_Vehicles_InputTaxes(playerid);

            dialog_Row("Ar papildomai priskaièiuoti pagal tr. priemonës klasæ?")     
            {
                SetGVarIntEx("CountVehicleClass", !GetGVarInt("CountVehicleClass"));
                SaveServerIntEx("CountVehicleClass", GetGVarInt("CountVehicleClass"));

                MsgSuccess(playerid, "NUSTATYMAI", "Nustatymai atnaujinti");

                log_init(true);
                log_set_table("logs_admins");
                log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`Amount`");
                log_set_values("'%d','%e','Nustate automobilio klases priskaiciavima','%d'", LogPlayerId(playerid), LogPlayerName(playerid), GetGVarInt("CountVehicleClass"));
                log_commit();
            }
            _Opts_Vehicles_Main(playerid);
        }
        else AMenu_Main(playerid);
    }
    dialog_Show(playerid, using inline vehicles, DIALOG_STYLE_TABLIST_HEADERS, "Tr. priemoniø nustatymai", "Tæsti", "Atðaukti");
    return 1;
}
static _Opts_Vehicles_InputTaxes(playerid, error[] = "")
{
    dialog_Clear();
    dialog_AddLine("Áveskite mokeðèiø dydá:");
    dialog_AddLine("Mokeðèiai(TAXES) skaièiuojami pagal formulæ:");
    dialog_AddLine("Jei priskaièiuojama tr. priemonës klasë (CLASS):");
    dialog_AddLine("\tTAXES/2*CLASS");
    dialog_AddLine("Jei nepriskaièiuojama:");
    dialog_AddLine("\tTAXES/2");
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {
            new taxes;
            if(sscanf(dialog_Input(),"d",taxes) || !(0 < taxes <= 2000))
                return _Opts_Vehicles_InputTaxes(playerid, .error = "Mokeðèiai turi bûti nuo 1$ iki 2000$");

            SetGVarIntEx("VehicleTaxes", taxes);
            SaveServerIntEx("VehicleTaxes", GetGVarInt("VehicleTaxes"));
            MsgSuccess(playerid, "NUSTATYMAI", "Nustatymai atnaujinti");
            
            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`Amount`");
            log_set_values("'%d','%e','Nustate automobiliu mokesti','%d'", LogPlayerId(playerid), LogPlayerName(playerid), taxes);
            log_commit();
        }
        _Opts_Vehicles_Main(playerid);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Tr. priemoniø mokeðèiai", "Keisti", "Atðaukti");
    return 1;
}
/**
    ================================================================================================
    Business
*/
static _Opts_Business_Main(playerid)
{
    dialog_Clear();

    dialog_AddLine("Nustatymas\tDabartinë reikðmë");
    dialog_AddLine("Mokeðèiø dydis\t$%d", GetGVarInt("BusinessTaxes"));
    dialog_AddLine("Degalø talpa degalinëse\t%dltr", GetGVarInt("BusinessFuelCapacity"));
    dialog_AddLine("Degalø litro kaina uþsakant\t%f$", GetGVarFloat("BusinessOrderFuelPrice"));

    inline options(response, listitem)
    {
        if(response)
        {
            dialog_Row("Mokeðèiø dydis")              return _Opts_Business_InputTaxes(playerid);
            dialog_Row("Degalø talpa degalinëse")     return _Opts_Business_FuelCapacity(playerid);
            dialog_Row("Degalø litro kaina uþsakant") return _Opts_Business_FuelOrderPrice(playerid);
        }
        else _Opts_Main(playerid);
    }
    dialog_Show(playerid, using inline options, DIALOG_STYLE_TABLIST_HEADERS, "Verslo nustatymai", "Tæsti", "Atðaukti");
    return 1;
}
static _Opts_Business_InputTaxes(playerid, error[] = "")
{
    if(!HaveAdminPermission(playerid, "EditBusinessTaxes"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Opts_Business_Main(playerid);
    }

    dialog_Clear();
    dialog_AddLine("Áveskite mokeðèiø dydá:");
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {
            new taxes;
            if(sscanf(dialog_Input(),"d",taxes) || !(0 < taxes <= 200))
                return _Opts_Business_InputTaxes(playerid, .error = "Mokeðèiai turi bûti nuo 1$ iki 200$");
            
            SetGVarIntEx("BusinessTaxes", taxes);            
            SaveServerIntEx("BusinessTaxes", GetGVarInt("BusinessTaxes"));
            MsgSuccess(playerid, "NUSTATYMAI", "Nustatymai atnaujinti");

            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`Amount`");
            log_set_values("'%d','%e','Nustate verslu mokesti','%d'", LogPlayerId(playerid), LogPlayerName(playerid), taxes);
            log_commit();
        }
        _Opts_Business_Main(playerid);
        return 1;
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Verslo mokeðèiai", "Pakeisti", "Iðeiti");
    return 1;
}


static _Opts_Business_FuelCapacity(playerid, error[] = "")
{
    if(!HaveAdminPermission(playerid, "EditFuelSettings"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Opts_Business_Main(playerid);
    }

    dialog_Clear();
    dialog_AddLine("Áveskite degalinës talpà:");
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {
            new capacity;
            if(sscanf(dialog_Input(),"d",capacity) || !(0 < capacity <= 9999999))
                return _Opts_Business_FuelCapacity(playerid, .error = "Talpa turi bûti nuo 1 iki 9999999");
            

            SetGVarIntEx("BusinessFuelCapacity", capacity);
            SaveServerIntEx("BusinessFuelCapacity", GetGVarInt("BusinessFuelCapacity"));
            MsgSuccess(playerid, "NUSTATYMAI", "Nustatymai atnaujinti");

            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`Amount`");
            log_set_values("'%d','%e','Nustate verslo degalu talpa','%d'", LogPlayerId(playerid), LogPlayerName(playerid), capacity);
            log_commit();
        }
        _Opts_Business_Main(playerid);
        return 1;
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Verslo nustatymai", "Pakeisti", "Iðeiti");
    return 1;
}

static _Opts_Business_FuelOrderPrice(playerid, error[] = "")
{
    if(!HaveAdminPermission(playerid, "EditFuelSettings"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Opts_Business_Main(playerid);
    }

    dialog_Clear();
    dialog_AddLine("Áveskite degalø litro kainà, uþsakant juos savininkui:");
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {
            new Float:price;
            if(sscanf(dialog_Input(),"f",price) || !(0.0 < price <= 9999999.0))
                return _Opts_Business_FuelOrderPrice(playerid, .error = "Kaina turi bûti nuo 0.1$ iki 9999999.0$");
            
            SetGVarFloatEx("BusinessOrderFuelPrice", price);    
            SaveServerFloatEx("BusinessOrderFuelPrice", GetGVarFloat("BusinessOrderFuelPrice"));
            MsgSuccess(playerid, "NUSTATYMAI", "Nustatymai atnaujinti");

            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`Amount`");
            log_set_values("'%d','%e','Nustate verslo degalu kaina','%d'", LogPlayerId(playerid), LogPlayerName(playerid), floatround(price));
            log_commit();
        }
        _Opts_Business_Main(playerid);
        return 1;
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Verslo nustatymai", "Pakeisti", "Iðeiti");
    return 1;
}
/**
    ================================================================================================
    Houses
*/
static _Opts_Houses_Main(playerid)
{
    dialog_Clear();
    dialog_AddLine("{BABABA}Nustatymas\t{BABABA}Dabartinë reikðmë");
    dialog_AddLine("{FFFFFF}Mokeðèiø dydis\t$%d", GetGVarInt("HouseTaxes"));

    inline select(response, listitem)
    {
        if(response)
        {
            dialog_Row("Mokeðèiø dydis") return _Opts_Houses_InputTaxes(playerid);
        }
        _Opts_Main(playerid);
        return 1;
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_TABLIST_HEADERS, "Namo nustatymai", "Tæsti", "Atðaukti");
    return 1;
}

stock _Opts_Houses_InputTaxes(playerid, error[] = "")
{
    if(!HaveAdminPermission(playerid, "EditHouseTaxes"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Opts_Houses_Main(playerid);
    }

    dialog_Clear();

    dialog_AddLine("{FFFFFF}Áveskite mokeðèiø dydá:");
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {
            new taxes;
            if(sscanf(dialog_Input(),"d",taxes) || !(0 < taxes <= 200))
                return _Opts_Houses_InputTaxes(playerid, .error = "Mokeðèiai turi bûti nuo 1$ iki 200$");
            
            SetGVarIntEx("HouseTaxes", taxes);
            SaveServerIntEx("HouseTaxes", GetGVarInt("HouseTaxes"));
            MsgSuccess(playerid, "NUSTATYMAI", "Nustatymai atnaujinti");

        
            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`Amount`");
            log_set_values("'%d','%e','Nustate namu mokesti','%d'", LogPlayerId(playerid), LogPlayerName(playerid), taxes);
            log_commit();
        }
        _Opts_Houses_Main(playerid);
        return 1;
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Namo mokeðèiai", "Tæsti", "Atðaukti");
    return 1;
}
/**
    ================================================================================================
    on/offs
*/
static _Opts_OnOff_Main(playerid)
{
    dialog_Clear();
    dialog_AddLine("{BABABA}Nustatymas\t{BABABA}Dabartinë reikðmë");
    dialog_AddLine("{FFFFFF}Furniture multi-select sistema\t%s", GetGVarInt("EnabledFurnitureMultiSelect") > 0 ? ("Ájungta") : ("Iðjungta"));
    dialog_AddLine("Pervedimø sistema\t%s", GetGVarInt("EnabledTransactions") > 0 ? ("Ájungta") : ("Iðjungta"));
    dialog_AddLine("Saugoti iðmestus daiktus\t%s", GetGVarInt("EnabledDroppedItemsSaving") > 0 ? ("Taip") : ("Ne"));
    dialog_AddLine("Darbø 3DTextLabel tekstai\t%s", GetGVarInt("EnabledJobLabels") > 0 ? ("Rodomi") : ("Iðjungti"));
    dialog_AddLine("Verslø 3DTextLabel tekstai\t%s", GetGVarInt("EnabledBusinessLabels") > 0 ? ("Rodomi") : ("Iðjungti"));
    dialog_AddLine("Namø 3DTextLabel tekstai\t%s", GetGVarInt("EnabledHouseLabels") > 0 ? ("Rodomi") : ("Iðjungti"));

    inline toggle(response, listitem)
    {
        if(response)
        {
            new perm[56], 
                setting[56];
            dialog_Row("Furniture multi-select")
            {
                format(perm, 56, "EnableFurnitureMultiSelect");
                format(setting, 56, "EnabledFurnitureMultiSelect");
            }
            dialog_Row("Saugoti iðmestus daiktus")     
            {
                format(perm, 56, "EnableDroppedItemsSaving");
                format(setting, 56, "EnabledDroppedItemsSaving");
            }
            dialog_Row("Pervedimø sistema")     
            {
                format(perm, 56, "EnableTransactions");
                format(setting, 56, "EnabledTransactions");
            }
            dialog_Row("Darbø 3DTextLabel")     
            {
                format(perm, 56, "EnableJobLabels");
                format(setting, 56, "EnabledJobLabels");
            }
            dialog_Row("Verslø 3DTextLabel")    
            {
                format(perm, 56, "EnableBusinessLabels");
                format(setting, 56, "EnabledBusinessLabels");
            }
            dialog_Row("Namø 3DTextLabel")      
            {
                format(perm, 56, "EnableHouseLabels");
                format(setting, 56, "EnabledHouseLabels");
            }

            if(strlen(perm) && strlen(setting))
            {
                if(!HaveAdminPermission(playerid, perm))
                {
                    InfoBox(playerid, IB_NO_PRIVILEGE);
                    return _Opts_Other_Main(playerid);
                }

                new current_set = GetGVarInt(setting);
                SetGVarInt(setting, current_set > 0 ? 0 : 1);
                SaveServerIntEx(setting, GetGVarInt(setting));
                current_set = !current_set;

                MsgSuccess(playerid, "NUSTATYMAI", "Nustatymai atnaujinti");

                switch(YHash(setting, false))
                {
                    case _I<EnabledFurnitureMultiSelect>: 
                    {
                        foreach(new receiver : Player)
                        {
                            FurnitureMultiSelectionEnabled{receiver} = !!current_set;
                        }
                    }
                    case _I<EnableBusinessLabels>: 
                    {
                        foreach(new businessid : Business) Business_FixLabels(businessid, current_set);
                    }
                    case _I<EnabledHouseLabels>: 
                    {
                        foreach(new houseid : House) House_FixLabels(houseid, current_set);
                    }
                    case _I<EnabledJobLabels>: 
                    {
                        Jobs_LoadPickups();
                    }
                }

                _Opts_OnOff_Main(playerid);
            }
        }
        else _Opts_Main(playerid);
    }
    dialog_Show(playerid, using inline toggle, DIALOG_STYLE_TABLIST_HEADERS, "Ájungimai/iðjungimai", "Tæsti", "Atðaukti");
    return 1;
}
/**
    ================================================================================================
    Places
*/
static _Opts_Places_Main(playerid)
{
    MsgInfo(playerid, "SPAWN", "Pasirinkta vieta bus nustatyta á jûsø dabartinæ.");
    
    dialog_Clear();

    dialog_AddLine("Kalëjmo pasodinimo vieta");
    dialog_AddLine("Iðleidimo ið kalëjimo vieta");
    dialog_AddLine("Areðtinës pasodinimo vieta");
    dialog_AddLine("Iðleidimo ið areðtinës vieta");
    dialog_AddLine("OOC kalëjimo vidus");
    dialog_AddLine("Iðleidimo ið OOC kalëjimo vieta");
    dialog_AddLine("Banko vidaus vieta");
    dialog_AddLine("SPAWN po mirties vieta");
    dialog_AddLine("Kalëjimo vieta (/prison)");
    dialog_AddLine("Areðtinës vieta (/arrest)");
    dialog_AddLine("/ad vieta");
    dialog_AddLine("SPAWN vieta");

    inline select(response, listitem)
    {
        if(!response) return _Opts_Main(playerid);

        new 
            perm[56], set[56];

        dialog_Row("Kalëjmo pasodinimo vieta")
        {
            format(perm, 56, "SetJailSpawn");
            format(set, 56, "JailSpawn");
        }
        dialog_Row("Iðleidimo ið kalëjimo vieta")
        {
            format(perm, 56, "SetUnjailSpawn");
            format(set, 56, "Unjail");
        }
        dialog_Row("Areðtinës pasodinimo vieta")
        {
            format(perm, 56, "SetArrestSpawn");
            format(set, 56, "ArrestSpawn");
        }
        dialog_Row("Iðleidimo ið areðtinës vieta")
        {
            format(perm, 56, "SetUnarrestSpawn");
            format(set, 56, "Unarrest");
        }
        dialog_Row("OOC kalëjimo vidus")
        {
            format(perm, 56, "SetOOCJailSpawn");
            format(set, 56, "OOCJailSpawn");
        }
        dialog_Row("Iðleidimo ið OOC kalëjimo vieta")
        {
            format(perm, 56, "SetOOCUnjailSpawn");
            format(set, 56, "OOCUnjail");
        }
        dialog_Row("Banko vidaus vieta")
        {
            format(perm, 56, "SetBankPos");
            format(set, 56, "Bank");
        }
        dialog_Row("SPAWN po mirties vieta")
        {
            format(perm, 56, "SetHospitalSpawnPos");
            format(set, 56, "SpawnHospital");
        }
        dialog_Row("Kalëjimo vieta (/prison)")
        {
            format(perm, 56, "SetJailSpawn");
            format(set, 56, "Jail");
        }
        dialog_Row("Areðtinës vieta (/arrest)")
        {
            format(perm, 56, "SetArrestSpawn");
            format(set, 56, "Arrest");
        }
        dialog_Row("/ad vieta")
        {
            format(perm, 56, "SetAdPos");
            format(set, 56, "Ad");
        }
        dialog_Row("SPAWN vieta")
        {
            format(perm, 56, "SetHospitalSpawnPos");
            format(set, 56, "Spawn");
        }

        if(strlen(perm) && !HaveAdminPermission(playerid, perm))
        {
            InfoBox(playerid, IB_NO_PRIVILEGE);
            return _Opts_Places_Main(playerid);
        }

        new Float:x, Float:y, Float:z,
            int = GetPlayerInterior(playerid),
            vw  = GetPlayerVirtualWorld(playerid);

        GetPlayerPos(playerid, x, y, z);
        
        SetGVarFloatEx(va_return("%sX", set), x);
        SetGVarFloatEx(va_return("%sY", set), y);
        SetGVarFloatEx(va_return("%sZ", set), z);

        MsgSuccess(playerid, "NUSTATYMAI", "Nustatymai sëkmingai pakeisti.");

        if(!isequal(set, "Spawn"))
        {
            SetGVarIntEx(va_return("%sInt", set), int);
            SetGVarIntEx(va_return("%sVW", set), vw);
        }

        switch(YHash(set, false))
        {
            case _I<Bank>: Bank_CreatePickup();
            case _I<Ad>: AdPlace_CreateLabel();
        }

    }  
    dialog_Show(playerid, using inline select, DIALOG_STYLE_LIST, "Vietø nustatymai", "Nustatyti", "Atðaukti");
    return 1;
}
/**
    ================================================================================================
    Other
*/
static _Opts_Other_Main(playerid)
{
    dialog_Clear();
    dialog_AddLine("{BABABA}Nustatymas\t{BABABA}Dabartinë reikðmë");
    dialog_AddLine("{FFFFFF}Mokeðèiai nuo algos\t%dproc.", GetGVarInt("TaxesToCity"));
    dialog_AddLine("Procentas á policijos biudþetà\t%dproc.", GetGVarInt("TaxesToPolice"));
    dialog_AddLine("Maks. veikëjø vartotojui\t%d", GetGVarInt("MaxCharacters"));
    // Nekeiciami:
    dialog_AddLine("{BABABA}[nekeièiama] Policijos ginklø atsargø talpa\t%dvnt.", GetGVarInt("PoliceWeaponCapacity"));
    dialog_AddLine("[nekeièiama] Policijos aprangos atsargø talpa\t%dvnt.", GetGVarInt("PoliceSkinsCapacity"));
    dialog_AddLine("[nekeièiama] Policijos spec atsargø talpa\t%dvnt.", GetGVarInt("PoliceSpecialCapacity"));
    
    inline select(response, listitem)
    {
        if(!response) return _Opts_Main(playerid);

        dialog_Row("Mokeðèiai nuo algos")               return _Opts_Other_PVM(playerid);
        dialog_Row("Procentas á policijos biudþetà")    return _Opts_Other_PolicePercent(playerid);
        dialog_Row("Maks. veikëjø vartotojui")          return _Opts_Other_MaxChars(playerid);

        _Opts_Other_Main(playerid);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_TABLIST_HEADERS, "Kiti nustatymai", "Tæsti", "Atðaukti");
    return 1;
}
static _Opts_Other_PVM(playerid, error[] = "")
{
    if(!HaveAdminPermission(playerid, "EditCityTaxes"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Opts_Other_Main(playerid);
    }

    dialog_Clear();
    dialog_AddLine("{FFFFFF}Ávestas bendras procentas bus nuimamas nuo algos ir atitinkamai");
    dialog_AddLine("padalintas á savivaldybës ir policijos biudþetà");
    dialog_AddLine("{BABABA}Áveskite procentà:");
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {
            new percent;
            if(sscanf(dialog_Input(),"d",percent) || !(0 < percent <= 99))
                return _Opts_Other_PVM(playerid, .error = "Mokeðèiai turi bûti nuo 1 iki 99proc.");
            

            SetGVarIntEx("TaxesToCity", percent);

            SaveServerIntEx("TaxesToCity", GetGVarInt("TaxesToCity"));
            MsgSuccess(playerid, "NUSTATYMAI", "Nustatymai atnaujinti");
            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`Amount`");
            log_set_values("'%d','%e','Nustate bendra proc. mokesti','%d'", LogPlayerId(playerid), LogPlayerName(playerid), percent);
            log_commit();
        }
        _Opts_Other_Main(playerid);
        return 1;
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Bendri mokeðèiai", "Tæsti", "Atðaukti");
    return 1;
}

static _Opts_Other_PolicePercent(playerid, error[] = "")
{
    if(!HaveAdminPermission(playerid, "EditCityTaxes"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Opts_Other_Main(playerid);
    }

    dialog_Clear();
    dialog_AddLine("{FFFFFF}Ávestas procentas bus atimamas ið bendro procento nuo algos");
    dialog_AddLine("ir pervedamas á policijos biudþetà, o likusi suma á savivaldybës biudþetà.");
    dialog_AddLine("Pvz. jei þaidëjas uþdirba 300$, o bendras mokeðèiø procentas yra 10proc.");
    dialog_AddLine("nuo þaidëjo ið viso algos nuimami 30$. Tad ðiame lange ávedus 50proc.,");
    dialog_AddLine("nuo tø 30$ yra nuskaièiuojami 15$ ir pervedami á policijos biudþetà, o");
    dialog_AddLine("likusi suma atitenka savivaldybei.");
    dialog_AddLine("{BABABA}Áveskite procentà:");
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {
            new percent;
            if(sscanf(dialog_Input(),"d",percent) || !(0 < percent <= 99))
                return _Opts_Other_PolicePercent(playerid, .error = "Procentas turi bûti nuo 1 iki 99proc.");    
        
            SetGVarIntEx("TaxesToPolice", percent);
            SaveServerIntEx("TaxesToPolice", GetGVarInt("TaxesToPolice"));
            MsgSuccess(playerid, "NUSTATYMAI", "Nustatymai atnaujinti");

            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`Amount`");
            log_set_values("'%d','%e','Nustate proc. i pd','%d'", LogPlayerId(playerid), LogPlayerName(playerid), percent);
            log_commit();

        }
        _Opts_Other_Main(playerid);
        return 1;
    }

    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Bendri mokeðèiai", "Tæsti", "Atðaukti");
    return 1;
}

static _Opts_Other_MaxChars(playerid, error[] = "")
{
    dialog_Clear();
    dialog_AddLine("{FFFFFF}Áveskite maksimalø veikëjø skaièiø vienam þaidëjui");
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {
            new limit;
            if(sscanf(dialog_Input(),"d",limit) || !(0 < limit <= 20))
                return _Opts_Other_MaxChars(playerid, .error = "Limitas turi bûti nuo 1 iki 20.");
        
            SetGVarIntEx("MaxCharacters", limit);
            
            SaveServerIntEx("MaxCharacters", GetGVarInt("MaxCharacters"));
            MsgSuccess(playerid, "NUSTATYMAI", "Nustatymai atnaujinti");
            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`Amount`");
            log_set_values("'%d','%e','Nustate maks. veikeju skaiciu','%d'", LogPlayerId(playerid), LogPlayerName(playerid), limit);
            log_commit();    
        }
        _Opts_Other_Main(playerid);
        return 1;
    }

    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Maks. veikëjø skaièius", "Tæsti", "Atðaukti");
    return 1;
}
