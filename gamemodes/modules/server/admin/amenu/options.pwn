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

/**
					case 2:
					{
						// namo mokesciai
						new string[256];
						format(string, sizeof string, "{BABABA}Nustatymas\t{BABABA}Dabartinë reikðmë\n{FFFFFF}Mokeðèiø dydis\t$%d", GetGVarInt("HouseTaxes", SERVER_VARS_ID));
						ShowPlayerDialog(playerid, DIALOG_AM_HOUSE_TAXES_MAIN, DIALOG_STYLE_TABLIST_HEADERS, "Namo nustatymai", string, "Tæsti", "Atðaukti");
					}
					case 3:
					{
						// ijungimai/isjungimai
						new string[512];
						format(string, sizeof string, "{BABABA}Nustatymas\t{BABABA}Dabartinë reikðmë\n{FFFFFF}Furniture multi-select sistema\t%s\nPervedimø sistema\t%s\nPrisijungimo 30s laikmatis\t%s\nIðmestø daiktø saugojimas\t%s\nPolicijos atsargø sistema\t%s\nDarbø 3DTextLabel\t%s\nVerslø 3DTextLabel\t%s\nNamø 3DTextLabel\t%s",
							GetGVarInt("EnabledFurnitureMultiSelect", SERVER_VARS_ID) > 0 ? ("Ájungta") : ("Iðjungta"),
							GetGVarInt("EnabledTransactions", SERVER_VARS_ID) > 0 ? ("Ájungta") : ("Iðjungta"),
							GetGVarInt("EnabledLoginTimer", SERVER_VARS_ID) > 0 ? ("Ájungta") : ("Iðjungta"),
							GetGVarInt("EnabledDroppedItemsSaving", SERVER_VARS_ID) > 0 ? ("Ájungta") : ("Iðjungta"),
							GetGVarInt("EnabledPoliceWeaponUsage", SERVER_VARS_ID) > 0 ? ("Ájungta") : ("Iðjungta"),
							GetGVarInt("EnabledJobLabels", SERVER_VARS_ID) > 0 ? ("Ájungta") : ("Iðjungta"),
							GetGVarInt("EnabledBusinessLabels", SERVER_VARS_ID) > 0 ? ("Ájungta") : ("Iðjungta"),
							GetGVarInt("EnabledHouseLabels", SERVER_VARS_ID) > 0 ? ("Ájungta") : ("Iðjungta"));
						ShowPlayerDialog(playerid, DIALOG_AM_ENABLES_DISABLES_MAIN, DIALOG_STYLE_TABLIST_HEADERS, "Ájungimai/iðjungimai", string, "Tæsti", "Atðaukti");
					}
					case 4:
					{
						// spawn nustatymai
						MsgInfo(playerid, "SPAWN", "Pasirinkta vieta bus nustatyta á jûsø dabartinæ.");
						ShowPlayerDialog(playerid, DIALOG_AM_SPAWN_MAIN, DIALOG_STYLE_LIST, "Vietø nustatymai", "Kalëjmo pasodinimo vieta\nIðleidimo ið kalëjimo vieta\nAreðtinës pasodinimo vieta\nIðleidimo ið areðtinës vieta\nOOC kalëjimo vidus\nIðleidimo ið OOC kalëjimo vieta\nBanko vidaus vieta\nSPAWN po mirties vieta\nKalëjimo vieta (/prison)\nAreðtinës vieta (/arrest)\n/ad vieta\nSPAWN vieta", "Nustatyti", "Atðaukti");
					}
					case 5:
					{
						// visi kiti mokesciai
						new string[512];
						format(string, sizeof string, "{BABABA}Nustatymas\t{BABABA}Dabartinë reikðmë\n{FFFFFF}Mokeðèiai nuo algos\t%dproc.\nProcentas á policijos biudþetà\t%dproc.\n", GetGVarInt("TaxesToCity", SERVER_VARS_ID), GetGVarInt("TaxesToPolice", SERVER_VARS_ID));
						format(string, sizeof string, "%sPolicijos ginklø atsargø talpa\t%dvnt.\nPolicijos aprangos atsargø talpa\t%dvnt.\nPolicijos spec atsargø talpa\t%dvnt.\nMaks. veikëjø vartotojui\t%d", string, GetGVarInt("PoliceWeaponCapacity", SERVER_VARS_ID), GetGVarInt("PoliceSkinsCapacity", SERVER_VARS_ID), GetGVarInt("PoliceSpecialCapacity", SERVER_VARS_ID), GetGVarInt("MaxCharacters", SERVER_VARS_ID));
						ShowPlayerDialog(playerid, DIALOG_AM_OTHER_Opts_MAIN, DIALOG_STYLE_TABLIST_HEADERS, "Kiti nustatymai", string, "Tæsti", "Atðaukti");
					}
				}
 */


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
            if(HaveAdminPermission(playerid, "EditVehicleTaxes"))
            {
                dialog_Row("Mokeðèiø dydis")            return _Opts_Vehicles_InputTax(playerid);
                dialog_Row("Ar papildomai priskaièiuoti pagal tr. priemonës klasæ?")     
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
    dialog_Show(playerid, using inline vehicles, DIALOG_STYLE_TABLIST_HEADERS, "Tr. priemoniø nustatymai", "Tæsti", "Atðaukti");
    return 1;
}
static _Opts_Vehicles_InputTax(playerid, error[] = "")
{
    dialog_Clear();
    dialog_AddLine("Áveskite mokeðèiø dydá:");
    dialog_AddLine("Mokeðèiai(TAXES) skaièiuojami pagal formulæ:");
    dialog_AddLine("Jei priskaièiuojama tr. priemonës klasë (CLASS):");
    dialog_AddLine("\tTAXES/2*CLASS");
    dialog_AddLine("Jei nepriskaièiuojama:");
    dialog_AddLine("\tTAXES/2");
    dialog_AddErrorLine(error);

    inline inputTaxes(response, listitem)
    {
        if(response)
        {
            new taxes;
            if(sscanf(dialog_Input(),"d",taxes) || !(0 < taxes <= 2000))
                return _Opts_Vehicles_InputTax(playerid, .error = "Mokeðèiai turi bûti nuo 1$ iki 2000$");

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
    dialog_Show(playerid, using inline inputTaxes, DIALOG_STYLE_INPUT, "Tr. priemoniø mokeðèiai", "Keisti", "Atðaukti");
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

    inline input(response, listitem)
    {
        if(response)
        {
            new taxes;
            if(sscanf(dialog_Input(),"d",taxes) || !(0 < taxes <= 200))
                return _Opts_Business_InputTaxes(playerid, .error = "Mokeðèiai turi bûti nuo 1$ iki 200$");
            
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
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "", "Pakeisti", "Iðeiti");
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

    inline input(response, listitem)
    {
        if(response)
        {
            new capacity;
            if(sscanf(dialog_Input(),"d",capacity) || !(0 < capacity <= 9999999))
                return _Opts_Business_FuelCapacity(playerid, .error = "Talpa turi bûti nuo 1 iki 9999999");
            

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

    inline input(response, listitem)
    {
        if(response)
        {
            new Float:price;
            if(sscanf(dialog_Input(),"f",price) || !(0.0 < price <= 9999999.0))
                return _Opts_Business_FuelOrderPrice(playerid, .error = "Kaina turi bûti nuo 0.1$ iki 9999999.0$");
            
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
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Verslo nustatymai", "Pakeisti", "Iðeiti");
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