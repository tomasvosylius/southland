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

    dialog_AddLine("Tr. priemoni� nustatymai");
    dialog_AddLine("Verslo nustatymai");
    dialog_AddLine("Namo nustatymai");
    dialog_AddLine("�jungimai/i�jungimai");
    dialog_AddLine("Viet� nustatymai");
    dialog_AddLine("Kiti nustatymai");

    inline options(response, listitem)
    {
        if(response)
        {
            dialog_Row("Tr. priemoni� nustatymai") return _Opts_Vehicles_Main(playerid);
            dialog_Row("Verslo nustatymai")        return _Opts_Business_Main(playerid);
            dialog_Row("Namo nustatymai")          return _Opts_Houses_Main(playerid);
            dialog_Row("�jungimai/i�jungimai")     return _Opts_OnOff_Main(playerid);
            dialog_Row("Viet� nustatymai")         return _Opts_Places_Main(playerid);
            dialog_Row("Kiti nustatymai")          return _Opts_Other_Main(playerid);
        }
    }
    dialog_Show(playerid, using inline options, DIALOG_STYLE_LIST, "Bendrieji serverio nustatymai", "T�sti", "At�aukti");
    return 1;
}

static _Opts_Vehicles_Main(playerid)
{
    // tr. priemoniu mokesciai
    dialog_Clear();
    
    dialog_AddLine("{BABABA}Nustatymas\t{BABABA}Dabartin� reik�m�");
    dialog_AddLine("Moke��i� dydis\t$%d", GetGVarInt("VehicleTaxes"));
    dialog_AddLine("Ar papildomai priskai�iuoti pagal tr. priemon�s klas�?\t%s", GetGVarInt("CountVehicleClass") > 0 ? ("Taip") : ("Ne"));

    inline vehicles(response, listitem)
    {
        if(response)
        {
            if(!HaveAdminPermission(playerid, "EditVehicleTaxes"))
            {
                InfoBox(playerid, IB_NO_PRIVILEGE);
                return _Opts_Main(playerid);
            }

            dialog_Row("Moke��i� dydis") return _Opts_Vehicles_InputTaxes(playerid);

            dialog_Row("Ar papildomai priskai�iuoti pagal tr. priemon�s klas�?")     
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
    dialog_Show(playerid, using inline vehicles, DIALOG_STYLE_TABLIST_HEADERS, "Tr. priemoni� nustatymai", "T�sti", "At�aukti");
    return 1;
}
static _Opts_Vehicles_InputTaxes(playerid, error[] = "")
{
    dialog_Clear();
    dialog_AddLine("�veskite moke��i� dyd�:");
    dialog_AddLine("Moke��iai(TAXES) skai�iuojami pagal formul�:");
    dialog_AddLine("Jei priskai�iuojama tr. priemon�s klas� (CLASS):");
    dialog_AddLine("\tTAXES/2*CLASS");
    dialog_AddLine("Jei nepriskai�iuojama:");
    dialog_AddLine("\tTAXES/2");
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {
            new taxes;
            if(sscanf(dialog_Input(),"d",taxes) || !(0 < taxes <= 2000))
                return _Opts_Vehicles_InputTaxes(playerid, .error = "Moke��iai turi b�ti nuo 1$ iki 2000$");

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
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Tr. priemoni� moke��iai", "Keisti", "At�aukti");
    return 1;
}
/**
    ================================================================================================
    Business
*/
static _Opts_Business_Main(playerid)
{
    dialog_Clear();

    dialog_AddLine("Nustatymas\tDabartin� reik�m�");
    dialog_AddLine("Moke��i� dydis\t$%d", GetGVarInt("BusinessTaxes"));
    dialog_AddLine("Degal� talpa degalin�se\t%dltr", GetGVarInt("BusinessFuelCapacity"));
    dialog_AddLine("Degal� litro kaina u�sakant\t%f$", GetGVarFloat("BusinessOrderFuelPrice"));

    inline options(response, listitem)
    {
        if(response)
        {
            dialog_Row("Moke��i� dydis")              return _Opts_Business_InputTaxes(playerid);
            dialog_Row("Degal� talpa degalin�se")     return _Opts_Business_FuelCapacity(playerid);
            dialog_Row("Degal� litro kaina u�sakant") return _Opts_Business_FuelOrderPrice(playerid);
        }
        else _Opts_Main(playerid);
    }
    dialog_Show(playerid, using inline options, DIALOG_STYLE_TABLIST_HEADERS, "Verslo nustatymai", "T�sti", "At�aukti");
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
    dialog_AddLine("�veskite moke��i� dyd�:");
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {
            new taxes;
            if(sscanf(dialog_Input(),"d",taxes) || !(0 < taxes <= 200))
                return _Opts_Business_InputTaxes(playerid, .error = "Moke��iai turi b�ti nuo 1$ iki 200$");
            
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
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Verslo moke��iai", "Pakeisti", "I�eiti");
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
    dialog_AddLine("�veskite degalin�s talp�:");
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {
            new capacity;
            if(sscanf(dialog_Input(),"d",capacity) || !(0 < capacity <= 9999999))
                return _Opts_Business_FuelCapacity(playerid, .error = "Talpa turi b�ti nuo 1 iki 9999999");
            

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
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Verslo nustatymai", "Pakeisti", "I�eiti");
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
    dialog_AddLine("�veskite degal� litro kain�, u�sakant juos savininkui:");
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {
            new Float:price;
            if(sscanf(dialog_Input(),"f",price) || !(0.0 < price <= 9999999.0))
                return _Opts_Business_FuelOrderPrice(playerid, .error = "Kaina turi b�ti nuo 0.1$ iki 9999999.0$");
            
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
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Verslo nustatymai", "Pakeisti", "I�eiti");
    return 1;
}
/**
    ================================================================================================
    Houses
*/
static _Opts_Houses_Main(playerid)
{
    dialog_Clear();
    dialog_AddLine("{BABABA}Nustatymas\t{BABABA}Dabartin� reik�m�");
    dialog_AddLine("{FFFFFF}Moke��i� dydis\t$%d", GetGVarInt("HouseTaxes"));

    inline select(response, listitem)
    {
        if(response)
        {
            dialog_Row("Moke��i� dydis") return _Opts_Houses_InputTaxes(playerid);
        }
        _Opts_Main(playerid);
        return 1;
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_TABLIST_HEADERS, "Namo nustatymai", "T�sti", "At�aukti");
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

    dialog_AddLine("{FFFFFF}�veskite moke��i� dyd�:");
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {
            new taxes;
            if(sscanf(dialog_Input(),"d",taxes) || !(0 < taxes <= 200))
                return _Opts_Houses_InputTaxes(playerid, .error = "Moke��iai turi b�ti nuo 1$ iki 200$");
            
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
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Namo moke��iai", "T�sti", "At�aukti");
    return 1;
}
/**
    ================================================================================================
    on/offs
*/
static _Opts_OnOff_Main(playerid)
{
    dialog_Clear();
    dialog_AddLine("{BABABA}Nustatymas\t{BABABA}Dabartin� reik�m�");
    dialog_AddLine("{FFFFFF}Furniture multi-select sistema\t%s", GetGVarInt("EnabledFurnitureMultiSelect") > 0 ? ("�jungta") : ("I�jungta"));
    dialog_AddLine("Pervedim� sistema\t%s", GetGVarInt("EnabledTransactions") > 0 ? ("�jungta") : ("I�jungta"));
    dialog_AddLine("Saugoti i�mestus daiktus\t%s", GetGVarInt("EnabledDroppedItemsSaving") > 0 ? ("Taip") : ("Ne"));
    dialog_AddLine("Darb� 3DTextLabel tekstai\t%s", GetGVarInt("EnabledJobLabels") > 0 ? ("Rodomi") : ("I�jungti"));
    dialog_AddLine("Versl� 3DTextLabel tekstai\t%s", GetGVarInt("EnabledBusinessLabels") > 0 ? ("Rodomi") : ("I�jungti"));
    dialog_AddLine("Nam� 3DTextLabel tekstai\t%s", GetGVarInt("EnabledHouseLabels") > 0 ? ("Rodomi") : ("I�jungti"));

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
            dialog_Row("Saugoti i�mestus daiktus")     
            {
                format(perm, 56, "EnableDroppedItemsSaving");
                format(setting, 56, "EnabledDroppedItemsSaving");
            }
            dialog_Row("Pervedim� sistema")     
            {
                format(perm, 56, "EnableTransactions");
                format(setting, 56, "EnabledTransactions");
            }
            dialog_Row("Darb� 3DTextLabel")     
            {
                format(perm, 56, "EnableJobLabels");
                format(setting, 56, "EnabledJobLabels");
            }
            dialog_Row("Versl� 3DTextLabel")    
            {
                format(perm, 56, "EnableBusinessLabels");
                format(setting, 56, "EnabledBusinessLabels");
            }
            dialog_Row("Nam� 3DTextLabel")      
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
    dialog_Show(playerid, using inline toggle, DIALOG_STYLE_TABLIST_HEADERS, "�jungimai/i�jungimai", "T�sti", "At�aukti");
    return 1;
}
/**
    ================================================================================================
    Places
*/
static _Opts_Places_Main(playerid)
{
    MsgInfo(playerid, "SPAWN", "Pasirinkta vieta bus nustatyta � j�s� dabartin�.");
    
    dialog_Clear();

    dialog_AddLine("Kal�jmo pasodinimo vieta");
    dialog_AddLine("I�leidimo i� kal�jimo vieta");
    dialog_AddLine("Are�tin�s pasodinimo vieta");
    dialog_AddLine("I�leidimo i� are�tin�s vieta");
    dialog_AddLine("OOC kal�jimo vidus");
    dialog_AddLine("I�leidimo i� OOC kal�jimo vieta");
    dialog_AddLine("Banko vidaus vieta");
    dialog_AddLine("SPAWN po mirties vieta");
    dialog_AddLine("Kal�jimo vieta (/prison)");
    dialog_AddLine("Are�tin�s vieta (/arrest)");
    dialog_AddLine("/ad vieta");
    dialog_AddLine("SPAWN vieta");

    inline select(response, listitem)
    {
        if(!response) return _Opts_Main(playerid);

        new 
            perm[56], set[56];

        dialog_Row("Kal�jmo pasodinimo vieta")
        {
            format(perm, 56, "SetJailSpawn");
            format(set, 56, "JailSpawn");
        }
        dialog_Row("I�leidimo i� kal�jimo vieta")
        {
            format(perm, 56, "SetUnjailSpawn");
            format(set, 56, "Unjail");
        }
        dialog_Row("Are�tin�s pasodinimo vieta")
        {
            format(perm, 56, "SetArrestSpawn");
            format(set, 56, "ArrestSpawn");
        }
        dialog_Row("I�leidimo i� are�tin�s vieta")
        {
            format(perm, 56, "SetUnarrestSpawn");
            format(set, 56, "Unarrest");
        }
        dialog_Row("OOC kal�jimo vidus")
        {
            format(perm, 56, "SetOOCJailSpawn");
            format(set, 56, "OOCJailSpawn");
        }
        dialog_Row("I�leidimo i� OOC kal�jimo vieta")
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
        dialog_Row("Kal�jimo vieta (/prison)")
        {
            format(perm, 56, "SetJailSpawn");
            format(set, 56, "Jail");
        }
        dialog_Row("Are�tin�s vieta (/arrest)")
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

        MsgSuccess(playerid, "NUSTATYMAI", "Nustatymai s�kmingai pakeisti.");

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
    dialog_Show(playerid, using inline select, DIALOG_STYLE_LIST, "Viet� nustatymai", "Nustatyti", "At�aukti");
    return 1;
}
/**
    ================================================================================================
    Other
*/
static _Opts_Other_Main(playerid)
{
    dialog_Clear();
    dialog_AddLine("{BABABA}Nustatymas\t{BABABA}Dabartin� reik�m�");
    dialog_AddLine("{FFFFFF}Moke��iai nuo algos\t%dproc.", GetGVarInt("TaxesToCity"));
    dialog_AddLine("Procentas � policijos biud�et�\t%dproc.", GetGVarInt("TaxesToPolice"));
    dialog_AddLine("Maks. veik�j� vartotojui\t%d", GetGVarInt("MaxCharacters"));
    // Nekeiciami:
    dialog_AddLine("{BABABA}[nekei�iama] Policijos ginkl� atsarg� talpa\t%dvnt.", GetGVarInt("PoliceWeaponCapacity"));
    dialog_AddLine("[nekei�iama] Policijos aprangos atsarg� talpa\t%dvnt.", GetGVarInt("PoliceSkinsCapacity"));
    dialog_AddLine("[nekei�iama] Policijos spec atsarg� talpa\t%dvnt.", GetGVarInt("PoliceSpecialCapacity"));
    
    inline select(response, listitem)
    {
        if(!response) return _Opts_Main(playerid);

        dialog_Row("Moke��iai nuo algos")               return _Opts_Other_PVM(playerid);
        dialog_Row("Procentas � policijos biud�et�")    return _Opts_Other_PolicePercent(playerid);
        dialog_Row("Maks. veik�j� vartotojui")          return _Opts_Other_MaxChars(playerid);

        _Opts_Other_Main(playerid);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_TABLIST_HEADERS, "Kiti nustatymai", "T�sti", "At�aukti");
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
    dialog_AddLine("{FFFFFF}�vestas bendras procentas bus nuimamas nuo algos ir atitinkamai");
    dialog_AddLine("padalintas � savivaldyb�s ir policijos biud�et�");
    dialog_AddLine("{BABABA}�veskite procent�:");
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {
            new percent;
            if(sscanf(dialog_Input(),"d",percent) || !(0 < percent <= 99))
                return _Opts_Other_PVM(playerid, .error = "Moke��iai turi b�ti nuo 1 iki 99proc.");
            

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
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Bendri moke��iai", "T�sti", "At�aukti");
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
    dialog_AddLine("{FFFFFF}�vestas procentas bus atimamas i� bendro procento nuo algos");
    dialog_AddLine("ir pervedamas � policijos biud�et�, o likusi suma � savivaldyb�s biud�et�.");
    dialog_AddLine("Pvz. jei �aid�jas u�dirba 300$, o bendras moke��i� procentas yra 10proc.");
    dialog_AddLine("nuo �aid�jo i� viso algos nuimami 30$. Tad �iame lange �vedus 50proc.,");
    dialog_AddLine("nuo t� 30$ yra nuskai�iuojami 15$ ir pervedami � policijos biud�et�, o");
    dialog_AddLine("likusi suma atitenka savivaldybei.");
    dialog_AddLine("{BABABA}�veskite procent�:");
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {
            new percent;
            if(sscanf(dialog_Input(),"d",percent) || !(0 < percent <= 99))
                return _Opts_Other_PolicePercent(playerid, .error = "Procentas turi b�ti nuo 1 iki 99proc.");    
        
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

    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Bendri moke��iai", "T�sti", "At�aukti");
    return 1;
}

static _Opts_Other_MaxChars(playerid, error[] = "")
{
    dialog_Clear();
    dialog_AddLine("{FFFFFF}�veskite maksimal� veik�j� skai�i� vienam �aid�jui");
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {
            new limit;
            if(sscanf(dialog_Input(),"d",limit) || !(0 < limit <= 20))
                return _Opts_Other_MaxChars(playerid, .error = "Limitas turi b�ti nuo 1 iki 20.");
        
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

    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Maks. veik�j� skai�ius", "T�sti", "At�aukti");
    return 1;
}
