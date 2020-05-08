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

    dialog_AddLine("Serverio ��jimai/i��jimai");
    dialog_AddLine("Transporto priemon�s");
    dialog_AddLine("Namai");
    dialog_AddLine("Verslai");
    dialog_AddLine("Gara�ai");
    dialog_AddLine("Frakcijos");
    dialog_AddLine("Bendrieji serverio nustatymai");
    dialog_AddLine("Bankomatai");
    dialog_AddLine("Tr. priemoni� salonai");
    dialog_AddLine("Parduodamos tr. priemon�s frakcijoms");
    dialog_AddLine("Aik�tel�s");
    dialog_AddLine("Ikonos �em�lapyje");
    dialog_AddLine("Taksofonai");
    dialog_AddLine("Juodoji rinka");
    dialog_AddLine("Interjer� meniu");
    dialog_AddLine("Grup�s");

    inline mainMenu(response, listitem)
    {
        if(response)
        {
            dialog_Row("Bendrieji serverio nustatymai")        return AMenu_Options_Main(playerid);
            dialog_Row("Serverio ��jimai/i��jimai")            return AMenu_Enters_Main(playerid);
            dialog_Row("Bankomatai")                           return AMenu_ATM_Main(playerid);
            dialog_Row("Ikonos �em�lapyje")                    return AMenu_Icons_Main(playerid);
            // dialog_Row("Namai")                                return AMenu_Houses_Main(playerid);
            // dialog_Row("Verslai")                              return AMenu_Business_Main(playerid);
            // dialog_Row("Gara�ai")                              return AMenu_Garages_Main(playerid);
            // dialog_Row("Tr. priemoni� salonai")                return AMenu_CarShop_Main(playerid);
            // dialog_Row("Transporto priemon�s")                 return AMenu_Vehicles_Main(playerid);
            // dialog_Row("Frakcijos")                            return AMenu_Factions_Main(playerid);
            // dialog_Row("Parduodamos tr. priemon�s frakcijoms") return AMenu_FacCars_Main(playerid);
            // dialog_Row("Aik�tel�s")                            return AMenu_Parkings_Main(playerid);
            // dialog_Row("Grup�s")                               return AMenu_Groups_Main(playerid);
            // dialog_Row("Interjer� meniu")                      return AMenu_Interiors_Main(playerid);
            // dialog_Row("Taksofonai")                           return AMenu_Taxophones_Main(playerid);
            // dialog_Row("Juodoji rinka")                        return AMenu_BlackMarket_Main(playerid);
        }
    }
    dialog_Show(playerid, using inline mainMenu, DIALOG_STYLE_LIST, "Administravimo meniu", "T�sti", "At�aukti");
	return 1;
}