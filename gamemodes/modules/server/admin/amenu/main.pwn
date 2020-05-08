#include <YSI_Coding\y_hooks>

flags:amenu(CMD_TYPE_ADMIN);
CMD:amenu(playerid, params[])
{
	AMenu_Main(playerid);
	return 1;
}

stock AMenu_Main(playerid)
{
    dialog_Clear();

    dialog_AddLine("Serverio áëjimai/iðëjimai");
    dialog_AddLine("Transporto priemonës");
    dialog_AddLine("Namai");
    dialog_AddLine("Verslai");
    dialog_AddLine("Garaþai");
    dialog_AddLine("Frakcijos");
    dialog_AddLine("Bendrieji serverio nustatymai");
    dialog_AddLine("Bankomatai");
    dialog_AddLine("Tr. priemoniø salonai");
    dialog_AddLine("Parduodamos tr. priemonës frakcijoms");
    dialog_AddLine("Aikðtelës");
    dialog_AddLine("Ikonos þemëlapyje");
    dialog_AddLine("Taksofonai");
    dialog_AddLine("Juodoji rinka");
    dialog_AddLine("Interjerø meniu");
    dialog_AddLine("Grupës");

    inline mainMenu(response, listitem)
    {
        if(response)
        {
            dialog_Row("Bendrieji serverio nustatymai")        return AMenu_Options_Main(playerid);
            dialog_Row("Serverio áëjimai/iðëjimai")            return AMenu_Enters_Main(playerid);
            dialog_Row("Bankomatai")                           return AMenu_ATM_Main(playerid);
            dialog_Row("Ikonos þemëlapyje")                    return AMenu_Icons_Main(playerid);
            // dialog_Row("Namai")                                return AMenu_Houses_Main(playerid);
            // dialog_Row("Verslai")                              return AMenu_Business_Main(playerid);
            // dialog_Row("Garaþai")                              return AMenu_Garages_Main(playerid);
            // dialog_Row("Tr. priemoniø salonai")                return AMenu_CarShop_Main(playerid);
            // dialog_Row("Transporto priemonës")                 return AMenu_Vehicles_Main(playerid);
            // dialog_Row("Frakcijos")                            return AMenu_Factions_Main(playerid);
            // dialog_Row("Parduodamos tr. priemonës frakcijoms") return AMenu_FacCars_Main(playerid);
            // dialog_Row("Aikðtelës")                            return AMenu_Parkings_Main(playerid);
            // dialog_Row("Grupës")                               return AMenu_Groups_Main(playerid);
            // dialog_Row("Interjerø meniu")                      return AMenu_Interiors_Main(playerid);
            // dialog_Row("Taksofonai")                           return AMenu_Taxophones_Main(playerid);
            // dialog_Row("Juodoji rinka")                        return AMenu_BlackMarket_Main(playerid);
        }
    }
    dialog_Show(playerid, using inline mainMenu, DIALOG_STYLE_LIST, "Administravimo meniu", "Tæsti", "Atðaukti");
	return 1;
}