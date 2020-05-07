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

/**
					case 2:
					{
						// namo mokesciai
						new string[256];
						format(string, sizeof string, "{BABABA}Nustatymas\t{BABABA}Dabartin� reik�m�\n{FFFFFF}Moke��i� dydis\t$%d", GetGVarInt("HouseTaxes", SERVER_VARS_ID));
						ShowPlayerDialog(playerid, DIALOG_AM_HOUSE_TAXES_MAIN, DIALOG_STYLE_TABLIST_HEADERS, "Namo nustatymai", string, "T�sti", "At�aukti");
					}
					case 3:
					{
						// ijungimai/isjungimai
						new string[512];
						format(string, sizeof string, "{BABABA}Nustatymas\t{BABABA}Dabartin� reik�m�\n{FFFFFF}Furniture multi-select sistema\t%s\nPervedim� sistema\t%s\nPrisijungimo 30s laikmatis\t%s\nI�mest� daikt� saugojimas\t%s\nPolicijos atsarg� sistema\t%s\nDarb� 3DTextLabel\t%s\nVersl� 3DTextLabel\t%s\nNam� 3DTextLabel\t%s",
							GetGVarInt("EnabledFurnitureMultiSelect", SERVER_VARS_ID) > 0 ? ("�jungta") : ("I�jungta"),
							GetGVarInt("EnabledTransactions", SERVER_VARS_ID) > 0 ? ("�jungta") : ("I�jungta"),
							GetGVarInt("EnabledLoginTimer", SERVER_VARS_ID) > 0 ? ("�jungta") : ("I�jungta"),
							GetGVarInt("EnabledDroppedItemsSaving", SERVER_VARS_ID) > 0 ? ("�jungta") : ("I�jungta"),
							GetGVarInt("EnabledPoliceWeaponUsage", SERVER_VARS_ID) > 0 ? ("�jungta") : ("I�jungta"),
							GetGVarInt("EnabledJobLabels", SERVER_VARS_ID) > 0 ? ("�jungta") : ("I�jungta"),
							GetGVarInt("EnabledBusinessLabels", SERVER_VARS_ID) > 0 ? ("�jungta") : ("I�jungta"),
							GetGVarInt("EnabledHouseLabels", SERVER_VARS_ID) > 0 ? ("�jungta") : ("I�jungta"));
						ShowPlayerDialog(playerid, DIALOG_AM_ENABLES_DISABLES_MAIN, DIALOG_STYLE_TABLIST_HEADERS, "�jungimai/i�jungimai", string, "T�sti", "At�aukti");
					}
					case 4:
					{
						// spawn nustatymai
						MsgInfo(playerid, "SPAWN", "Pasirinkta vieta bus nustatyta � j�s� dabartin�.");
						ShowPlayerDialog(playerid, DIALOG_AM_SPAWN_MAIN, DIALOG_STYLE_LIST, "Viet� nustatymai", "Kal�jmo pasodinimo vieta\nI�leidimo i� kal�jimo vieta\nAre�tin�s pasodinimo vieta\nI�leidimo i� are�tin�s vieta\nOOC kal�jimo vidus\nI�leidimo i� OOC kal�jimo vieta\nBanko vidaus vieta\nSPAWN po mirties vieta\nKal�jimo vieta (/prison)\nAre�tin�s vieta (/arrest)\n/ad vieta\nSPAWN vieta", "Nustatyti", "At�aukti");
					}
					case 5:
					{
						// visi kiti mokesciai
						new string[512];
						format(string, sizeof string, "{BABABA}Nustatymas\t{BABABA}Dabartin� reik�m�\n{FFFFFF}Moke��iai nuo algos\t%dproc.\nProcentas � policijos biud�et�\t%dproc.\n", GetGVarInt("TaxesToCity", SERVER_VARS_ID), GetGVarInt("TaxesToPolice", SERVER_VARS_ID));
						format(string, sizeof string, "%sPolicijos ginkl� atsarg� talpa\t%dvnt.\nPolicijos aprangos atsarg� talpa\t%dvnt.\nPolicijos spec atsarg� talpa\t%dvnt.\nMaks. veik�j� vartotojui\t%d", string, GetGVarInt("PoliceWeaponCapacity", SERVER_VARS_ID), GetGVarInt("PoliceSkinsCapacity", SERVER_VARS_ID), GetGVarInt("PoliceSpecialCapacity", SERVER_VARS_ID), GetGVarInt("MaxCharacters", SERVER_VARS_ID));
						ShowPlayerDialog(playerid, DIALOG_AM_OTHER_Opts_MAIN, DIALOG_STYLE_TABLIST_HEADERS, "Kiti nustatymai", string, "T�sti", "At�aukti");
					}
				}
 */


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
            if(HaveAdminPermission(playerid, "EditVehicleTaxes"))
            {
                dialog_Row("Moke��i� dydis")            return _Opts_Vehicles_InputTax(playerid);
                dialog_Row("Ar papildomai priskai�iuoti pagal tr. priemon�s klas�?")     
                {
                    SetGVarIntEx("CountVehicleClass", !GetGVarInt("CountVehicleClass"), SERVER_VARS_ID);
                    
                    SaveServerIntEx("CountVehicleClass", GetGVarInt("CountVehicleClass"));
                    MsgSuccess(playerid, "NUSTATYMAI", "Nustatymai atnaujinti");

                    log_init(true);
                    log_set_table("logs_admins");
                    log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`Amount`");
                    log_set_values("'%d','%e','Nustate automobilio klases priskaiciavima','%d'", LogPlayerId(playerid), LogPlayerName(playerid), GetGVarInt("CountVehicleClass"));
                    log_commit();

                    return _Opts_Main(playerid);
                }
            }
            else InfoBox(playerid, IB_NO_PRIVILEGE);
        }
        else AMenu_Main(playerid);
    }
    dialog_Show(playerid, using inline vehicles, DIALOG_STYLE_TABLIST_HEADERS, "Tr. priemoni� nustatymai", "T�sti", "At�aukti");
    return 1;
}
static _Opts_Vehicles_InputTax(playerid, error[] = "")
{
    dialog_Clear();
    dialog_AddLine("�veskite moke��i� dyd�:");
    dialog_AddLine("Moke��iai(TAXES) skai�iuojami pagal formul�:");
    dialog_AddLine("Jei priskai�iuojama tr. priemon�s klas� (CLASS):");
    dialog_AddLine("\tTAXES/2*CLASS");
    dialog_AddLine("Jei nepriskai�iuojama:");
    dialog_AddLine("\tTAXES/2");
    dialog_AddErrorLine(error);

    inline inputTaxes(response, listitem)
    {
        if(response)
        {
            new taxes;
            if(sscanf(dialog_Input(),"d",taxes) || !(0 < taxes <= 2000))
                return _Opts_Vehicles_InputTax(playerid, .error = "Moke��iai turi b�ti nuo 1$ iki 2000$");

            SetGVarIntEx("VehicleTaxes", taxes, SERVER_VARS_ID);
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
    dialog_Show(playerid, using inline inputTaxes, DIALOG_STYLE_INPUT, "Tr. priemoni� moke��iai", "Keisti", "At�aukti");
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

    inline input(response, listitem)
    {
        if(response)
        {
            new taxes;
            if(sscanf(dialog_Input(),"d",taxes) || !(0 < taxes <= 200))
                return _Opts_Business_InputTaxes(playerid, .error = "Moke��iai turi b�ti nuo 1$ iki 200$");
            
            SetGVarIntEx("BusinessTaxes", taxes, SERVER_VARS_ID);            
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
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "", "Pakeisti", "I�eiti");
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

    inline input(response, listitem)
    {
        if(response)
        {
            new capacity;
            if(sscanf(dialog_Input(),"d",capacity) || !(0 < capacity <= 9999999))
                return _Opts_Business_FuelCapacity(playerid, .error = "Talpa turi b�ti nuo 1 iki 9999999");
            

            SetGVarIntEx("BusinessFuelCapacity", capacity, SERVER_VARS_ID);
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

    inline input(response, listitem)
    {
        if(response)
        {
            new Float:price;
            if(sscanf(dialog_Input(),"f",price) || !(0.0 < price <= 9999999.0))
                return _Opts_Business_FuelOrderPrice(playerid, .error = "Kaina turi b�ti nuo 0.1$ iki 9999999.0$");
            
            SetGVarFloatEx("BusinessOrderFuelPrice", price, SERVER_VARS_ID);    
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
    return 1;
}
/**
    ================================================================================================
    on/offs
*/
static _Opts_OnOff_Main(playerid)
{
    return 1;
}
/**
    ================================================================================================
    Places
*/
static _Opts_Places_Main(playerid)
{
    return 1;
}
/**
    ================================================================================================
    Other
*/
static _Opts_Other_Main(playerid)
{
    return 1;
}