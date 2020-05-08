#include <YSI_Coding\y_hooks>

/** External */
stock AMenu_ATM_Main(playerid)
{
    _ATM_Main(playerid);
    return 1;
}

/** Internals */
static _ATM_Main(playerid)
{
    if(!HaveAdminPermission(playerid, "CreateNewATM"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _ATM_Main(playerid);
    }

    // bankomatai
    dialog_Clear();
    dialog_AddLine("{BABABA}Nustatymas\t{BABABA}Dabartinë reikðmë");
    dialog_AddLine("Kurti naujà");
    dialog_AddLine("Perþiûrëti visus");
    
    new atmid = -1;
    if((atmid = GetClosestATM(playerid, 5.0)) != -1)
    {
        dialog_AddLine("{EDEDED}[Artimiausio bankomato redagavimas]:");
        _ATM_DIALOG_ConcatDetails(atmid);
    }
    inline select(response, listitem)
    {
        if(!response) return AMenu_Main(playerid);
        
        dialog_Row("Kurti naujà")               return _ATM_CreateNew(playerid);
        dialog_Row("Perþiûrëti visus")          return _ATM_ShowList(playerid);
        dialog_Row("Nuëmimo limitas")           return _ATM_InputWithdrawLimit(playerid, atmid);
        dialog_Row("Objekto redagavimas")       return _ATM_EditObject(playerid, atmid);
        dialog_Row("Ar galima áneðti pinigus")  return _ATM_CanDeposit(playerid, atmid);
        dialog_Row("Teleportuotis prie")        return _ATM_TeleportTo(playerid, atmid);
        dialog_Row("Iðtrinti")                  return _ATM_Delete(playerid, atmid);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_TABLIST_HEADERS, "Bankomatai", "Tæsti", "Atðaukti");
    return 1;
}

static _ATM_CreateNew(playerid)
{
    new atmid = Iter_Free(ATM),
        Float:x, Float:y, Float:z;

    if(atmid == ITER_NONE) return SendWarning(playerid, "Pasiektas maks. ATM skaicius");

    GetPlayerPos(playerid, x, y, z);
    inline insertNew()
    {
        if(mysql_errno() == 0)
        {
            ATMs[atmid][atmId] = cache_insert_id();
            ATMs[atmid][atmObject] = CreateDynamicObject(2942, x+1, y+1, z-1, 0.0, 0.0, 0.0, .called = "atm", .extra = "create");
            ATMs[atmid][atmX] = x;
            ATMs[atmid][atmY] = y;
            ATMs[atmid][atmZ] = z;
            ATMs[atmid][atmCanDeposit] = 0;
            ATMs[atmid][atmWithdrawLimit] = 0;
            ATMs[atmid][atmInt] = GetPlayerInterior(playerid);
            ATMs[atmid][atmVW] = GetPlayerVirtualWorld(playerid);
            
            EditDynamicObject(playerid, ATMs[atmid][atmObject]);

            tmpSelected[playerid] = atmid;
            tmpEditing_Component_DMV[playerid] = EDITING_TYPE_DYNAMIC_ATM;

            MsgSuccess(playerid, "BANKOMATAI", "Sëkmingai sukûrëte bankomatà, kurio ID: %d.", ATMs[atmid][atmId]);
            Iter_Add(ATM, atmid);
            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`");
            log_set_values("'%d','%e','(AM) Sukure nauja bankomata (ATM)','%d'", LogPlayerId(playerid), LogPlayerName(playerid), ATMs[atmid][atmId]);
            log_commit();
        }
        else
        {
            SendError(playerid, "Siøsta uþklausa nepavyko [%d]", mysql_errno());
        }
    }
    mysql_tquery_inline(chandler, using inline insertNew, "\
        INSERT INTO `atms` (`X`,`Y`,`Z`,`CanDeposit`,`WithdrawLimit`,`Int`,`VW`,`Added`) \
        VALUES \
        ('%f','%f','%f','0','0','%d','%d','%d')", 
        x, y, z, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid), PlayerInfo[playerid][pId]
    );
    return 1;
}

static _ATM_ShowList(playerid)
{
    new real_iter;

    dialog_Clear();
    foreach(new atm : ATM)
    {
        if(ATMs[atm][atmId] != 0)
        {
            new area[28];
            GetCoords2DZone(area, 28, ATMs[atm][atmX], ATMs[atm][atmY]);
            dialog_AddLine("%d. Bankomatas(%d), %s", real_iter+1, ATMs[atm][atmId], area);

            tmpArray[playerid][real_iter] = atm;
            real_iter++;
        }
    }
    if(real_iter == 0)
    {
        SendWarning(playerid, "Nëra bankomatø.");
        return _ATM_Main(playerid);
    }

    inline atmList(response, listitem)
    {
        if(response)
        {
            _ATM_ShowSelectedEdit(playerid, tmpArray[playerid][listitem]);
            return 1;
        }
        _ATM_Main(playerid);
    }
    dialog_Show(playerid, using inline atmList, DIALOG_STYLE_LIST, "Bankomatai", "Tæsti", "Atðaukti");
    return 1;
}

static _ATM_ShowSelectedEdit(playerid, atmid)
{
    dialog_Clear();
    _ATM_DIALOG_ConcatDetails(atmid);

    inline select(response, listitem)
    {
        if(response)
        {
            dialog_Row("Nuëmimo limitas")           return _ATM_InputWithdrawLimit(playerid, atmid);
            dialog_Row("Objekto redagavimas")       return _ATM_EditObject(playerid, atmid);
            dialog_Row("Ar galima áneðti pinigus")  return _ATM_CanDeposit(playerid, atmid);
            dialog_Row("Teleportuotis prie")        return _ATM_TeleportTo(playerid, atmid);
            dialog_Row("Iðtrinti")                  return _ATM_Delete(playerid, atmid);    
        }
        _ATM_Main(playerid);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_LIST, "Bankomatai", "Tæsti", "Atðaukti");
    return 1;
}

static _ATM_EditObject(playerid, atmid)
{
    tmpSelected[playerid] = atmid;
    tmpEditing_Component_DMV[playerid] = EDITING_TYPE_DYNAMIC_ATM;

    IsValidDynamicObject(ATMs[atmid][atmObject]) && EditDynamicObject(playerid, ATMs[atmid][atmObject]);
    return 1;
}
static _ATM_Delete(playerid, atmid)
{
    new __reset_ATM[E_ATM_DATA];
    IsValidDynamicObject(ATMs[atmid][atmObject]) && DestroyDynamicObject(ATMs[atmid][atmObject], "atm", "delete");

    log_init(true);
    log_set_table("logs_admins");
    log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`");
    log_set_values("'%d','%e','(AM) Istryne bankomata (ATM)','%d'", LogPlayerId(playerid), LogPlayerName(playerid), ATMs[atmid][atmId]);
    log_commit();

    inline deleteATM() return 1;
    mysql_tquery_inline(chandler, using inline deleteATM, "DELETE FROM `atms` WHERE id = '%d'", ATMs[atmid][atmId]);

    ATMs[atmid] = __reset_ATM;
    ATMs[atmid][atmObject] = INVALID_OBJECT_ID;

    MsgSuccess(playerid, "BANKOMATAS", "Sëkmingai iðtrynëte bankomatà.");
    Iter_Remove(ATM, atmid);

    _ATM_Main(playerid);
    return 1;
}
static _ATM_CanDeposit(playerid, atmid)
{
    ATMs[atmid][atmCanDeposit] = !ATMs[atmid][atmCanDeposit];

    if(ATMs[atmid][atmCanDeposit] == 1) MsgSuccess(playerid, "BANKOMATAS", "Dabar á bankomatà galima áneðti pinigus.");
    else MsgSuccess(playerid, "BANKOMATAS", "Dabar á bankomatà negalima áneðti pinigø.");

    inline updateATM() return 1;
    mysql_tquery_inline(chandler, using inline updateATM, "\
        UPDATE `atms` SET CanDeposit = '%d' WHERE id = '%d'", 
        ATMs[atmid][atmCanDeposit], ATMs[atmid][atmId]
    );
    _ATM_Main(playerid);

    log_init(true);
    log_set_table("logs_admins");
    log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`Amount`");
    log_set_values("'%d','%e','(AM) Pakeite ATM inesimo nustatyma','%d','%d'", LogPlayerId(playerid), LogPlayerName(playerid), ATMs[atmid][atmId], ATMs[atmid][atmCanDeposit]);
    log_commit();
    return 1;
}

static _ATM_InputWithdrawLimit(playerid, atmid, error[] = "")
{
    dialog_Clear();
    dialog_AddLine("{FFFFFF}Áveskite nuëmimo limità ðiame bankomate.");
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {
            new amount;
            if(sscanf(dialog_Input(),"d",amount) || amount < 0)
                return _ATM_InputWithdrawLimit(playerid, atmid, .error = "Blogai ávestas skaièius.");

            ATMs[atmid][atmWithdrawLimit] = amount;

            if(amount == 0) MsgSuccess(playerid, "BANKOMATAS", "Nuëmimo limitas buvo paðalintas.");
            else            MsgSuccess(playerid, "BANKOMATAS", "Nuëmimo limitas buvo pakeistas á $%d.", ATMs[atmid][atmWithdrawLimit]);

            inline updateATM() return 1;
            mysql_tquery_inline(chandler, using inline updateATM, "\
                UPDATE `atms` SET WithdrawLimit = '%d' WHERE id = '%d'", 
                amount, ATMs[atmid][atmCanDeposit]
            );
            
            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`Amount`");
            log_set_values("'%d','%e','(AM) Pakeite ATM nuemimo limita','%d','%d'", LogPlayerId(playerid), LogPlayerName(playerid), ATMs[atmid][atmId], amount);
            log_commit();
        }
        _ATM_Main(playerid);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Bankomato redagavimas", "Tæsti", "Atðaukti");
    return 1;
}

static _ATM_TeleportTo(playerid, atmid)
{
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
    SetPlayerPos(playerid, ATMs[atmid][atmX], ATMs[atmid][atmY], ATMs[atmid][atmZ]);
    return 1;
}

static _ATM_DIALOG_ConcatDetails(atmid)
{
    dialog_AddLine("{FFFFFF}Ar galima áneðti pinigus\t%s", ATMs[atmid][atmCanDeposit] ? ("Taip") : ("Ne"));
    dialog_AddLine("Nuëmimo limitas\t$%d", ATMs[atmid][atmWithdrawLimit]);
    dialog_AddLine("Objekto redagavimas");
    dialog_AddLine("Teleportuotis prie bankomato");
    dialog_AddLine("{C60000}Iðtrinti");
    return 1;
}



hook OnPlayerEditDynObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	new Float:oldx, Float:oldrx,
		Float:oldy, Float:oldry,
		Float:oldz, Float:oldrz;
	GetDynamicObjectPos(objectid, oldx, oldy, oldz);
	GetDynamicObjectRot(objectid, oldrx, oldry, oldrz);

	if(response == EDIT_RESPONSE_FINAL)
	{
		switch(tmpEditing_Component_DMV[playerid])
		{
			case EDITING_TYPE_DYNAMIC_ATM:
			{
				new atmid = tmpSelected[playerid];
				if(IsValidDynamicObject(ATMs[atmid][atmObject]))
				{
					SetDynamicObjectPos(ATMs[atmid][atmObject], x, y, z);
					SetDynamicObjectRot(ATMs[atmid][atmObject], rx, ry, rz);

                    MsgSuccess(playerid, "ATM", "Bankomato vieta atnaujinta.");

					ATMs[atmid][atmX] = x;
					ATMs[atmid][atmY] = y;
					ATMs[atmid][atmZ] = z;
					ATMs[atmid][atmRX] = rx;
					ATMs[atmid][atmRY] = ry;
					ATMs[atmid][atmRZ] = rz;
					tmpEditing_Component_DMV[playerid] = 0;
					
                    inline updateATM()
                    {
                        return 1;
                    }
					mysql_tquery_inline(chandler, using inline updateATM, "\
                        UPDATE `atms` SET `X` = '%0.3f', `Y` = '%0.3f', `Z` = '%0.3f', `RX` = '%0.3f', `RY` = '%0.3f', `RZ` = '%0.3f' \
                        WHERE `id` = '%d'", x, y, z, rx, ry, rz, ATMs[atmid][atmId]);
                    
					ShowPlayerAdminMenu(playerid);
				}
			}
        }
    }
    return 1;
}
