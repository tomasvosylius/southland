#include <YSI_Coding\y_hooks>

/** External */
stock AMenu_Payphones_Main(playerid)
{
    _Payphones_Main(playerid);
    return 1;
}

/** Internals */
static _Payphones_Main(playerid)
{
    dialog_Clear();
    dialog_AddLine("Perþiûrëti visus");
    dialog_AddLine("Pridëti");

    inline select(response, listitem)
    {
        if(response)
        {
            dialog_Row("Perþiûrëti")    return _Payphones_ShowList(playerid);
            dialog_Row("Pridëti")       return _Payphones_CreateNew(playerid);
        }
        else AMenu_Main(playerid);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_LIST, "Taksofonai", "Tæsti", "Atðaukti");
    return 1;
}

static _Payphones_ShowList(playerid)
{   
    // visi
    if(!HaveAdminPermission(playerid, "EditPayPhones"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Payphones_Main(playerid);
    }

    new 
        zone[28];

    if(Iter_Count(PayPhone) <= 0)
    {
        SendWarning(playerid, "Nëra taksofonø.");
        return _Payphones_Main(playerid);
    }

    dialog_Clear();

    new i = 0;
    foreach(new pp : PayPhone)
    {
        if(PayPhoneInfo[pp][payPhoneId] != 0)
        {
            i++;
            GetCoords2DZone(zone, 28, PayPhoneInfo[pp][payPhoneX], PayPhoneInfo[pp][payPhoneY]);
            dialog_AddLine("%d.\t%d\t%s", i, PayPhoneInfo[pp][payPhoneId], zone);
        }
    }
    inline select(response, listitem)
    {
        if(response)
        {
            new selected;
            GetSortedAsForeach(PayPhone, listitem, selected, PayPhoneInfo[loopindex][payPhoneId] != 0);
            _Payphones_ShowDetails(playerid, selected);
        }
        else _Payphones_Main(playerid);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_TABLIST_HEADERS, "Taksofonai", "Tæsti", "Atðaukti");
    return 1;
}

static _Payphones_ShowDetails(playerid, pp)
{
    dialog_Clear();
    dialog_AddLine("Keisti pozicijà");
    dialog_AddLine("Teleportuotis prie taksofono");
    dialog_AddLine("{C60000}Iðtrinti");

    inline edit(response, listitem)
    {
        if(response)
        {
            dialog_Row("Keisti pozicijà")
            {
                if(!HaveAdminPermission(playerid, "ChangePayPhonePosition"))
                {
                    InfoBox(playerid, IB_NO_PRIVILEGE);
                    return _Payphones_ShowDetails(playerid, pp);
                }
                new 
                    Float:x, Float:y, Float:z;

                GetPlayerPos(playerid, x, y, z);
                SetDynamicObjectPos(PayPhoneInfo[pp][payPhoneObject], x+1, y+1, z);
                Streamer_Update(playerid);

                PayPhoneInfo[pp][payPhoneX] = x+1,
                PayPhoneInfo[pp][payPhoneY] = y+1,
                PayPhoneInfo[pp][payPhoneZ] = z;

                FixPayPhoneLabel(pp);
                tmpSelected[playerid] = pp;
                tmpEditing_Component_DMV[playerid] = EDITING_TYPE_DYNAMIC_PAYPHONE;
                EditDynamicObject(playerid, PayPhoneInfo[pp][payPhoneObject]);
                return 1;
            }
            dialog_Row("Teleportuotis prie taksofono")
            {
                // teleport
                SetPlayerPos(playerid, PayPhoneInfo[pp][payPhoneX], PayPhoneInfo[pp][payPhoneY], PayPhoneInfo[pp][payPhoneZ]);
                return _Payphones_ShowDetails(playerid, pp);
            }
            dialog_Row("Iðtrinti")
            {
                if(!HaveAdminPermission(playerid, "DeletePayPhone"))
                {
                    InfoBox(playerid, IB_NO_PRIVILEGE);
                    return _Payphones_ShowDetails(playerid, pp);
                }
                
                log_init(true);
                log_set_table("logs_admins");
                log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`");
                log_set_values("'%d','%e','(AM) Istryne taksofona','%d'", LogPlayerId(playerid), LogPlayerName(playerid), PayPhoneInfo[pp][payPhoneId]);
                log_commit();

                inline deletePP()
                {
                    MsgSuccess(playerid, "TAKSOFONAI", "Taksofonas iðtrintas.");
                    return 1;
                }
                mysql_tquery_inline(chandler, using inline deletePP, "\
                    DELETE FROM `payphones_data` WHERE id = '%d'",
                    PayPhoneInfo[pp][payPhoneId]
                );
                
                IsValidDynamicObject(PayPhoneInfo[pp][payPhoneObject]) && DestroyDynamicObject(PayPhoneInfo[pp][payPhoneObject], "payphone", "admin_delete");
                IsValidDynamic3DTextLabel(PayPhoneInfo[pp][payPhoneLabel]) && DestroyDynamic3DTextLabel(PayPhoneInfo[pp][payPhoneLabel]);

                new __reset_PayPhone[E_PAYPHONE_DATA];
                PayPhoneInfo[pp] = __reset_PayPhone;
                PayPhoneInfo[pp][payPhoneLabel] = INVALID_3DTEXT_ID;
                PayPhoneInfo[pp][payPhoneObject] = INVALID_OBJECT_ID;

                Iter_Remove(PayPhone, pp);
            }
        }
        _Payphones_ShowList(playerid);
    }
    dialog_Show(playerid, using inline edit, DIALOG_STYLE_LIST, "Taksofonai", "Tæsti", "Atðaukti");
    return 1;
}

static _Payphones_CreateNew(playerid)
{
    if(!HaveAdminPermission(playerid, "CreateNewPayPhone"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Payphones_Main(playerid);
    }

    new iter = Iter_Free(PayPhone);
    if(iter != MAX_PAYPHONES - 1)
    {
        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);

        inline insertNew()
        {
            PayPhoneInfo[iter][payPhoneId] = cache_insert_id();
            PayPhoneInfo[iter][payPhoneX] = x+1,
            PayPhoneInfo[iter][payPhoneY] = y+1,
            PayPhoneInfo[iter][payPhoneY] = z+1;
            PayPhoneInfo[iter][payPhoneObject] = CreateDynamicObject(1216, x+1, y+1, z+1, 0.0, 0.0, 0.0, .called = "payphone", .extra = "create");
            FixPayPhoneLabel(iter);
            Streamer_Update(playerid);

            tmpSelected[playerid] = iter;
            tmpEditing_Component_DMV[playerid] = EDITING_TYPE_DYNAMIC_PAYPHONE;
            EditDynamicObject(playerid, PayPhoneInfo[iter][payPhoneObject]);

            MsgSuccess(playerid, "TAKSOFONAI", "Sëkmingai sukûrëte taksofonà, kurio ID: %d.", PayPhoneInfo[iter][payPhoneId]);
            
            Iter_Add(PayPhone, iter);
            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`");
            log_set_values("'%d','%e','(AM) Sukure nauja taksofona','%d'", LogPlayerId(playerid), LogPlayerName(playerid), PayPhoneInfo[iter][payPhoneId]);
            log_commit();
        }
        mysql_tquery_inline(chandler, using inline insertNew, "INSERT INTO `payphones_data` (`X`,`Y`,`Z`,`Added`) VALUES ('%f','%f','%f','%d')", x, y, z, PlayerInfo[playerid][pId]);
    }
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
			case EDITING_TYPE_DYNAMIC_PAYPHONE:
			{
				new pp = tmpSelected[playerid];
				if(IsValidDynamicObject(PayPhoneInfo[pp][payPhoneObject]))
				{
					SetDynamicObjectPos(PayPhoneInfo[pp][payPhoneObject], x, y, z);
					SetDynamicObjectRot(PayPhoneInfo[pp][payPhoneObject], rx, ry, rz);
                    
					PayPhoneInfo[pp][payPhoneX] = x;
					PayPhoneInfo[pp][payPhoneY] = y;
					PayPhoneInfo[pp][payPhoneZ] = z;
					PayPhoneInfo[pp][payPhoneRX] = rx;
					PayPhoneInfo[pp][payPhoneRY] = ry;
					PayPhoneInfo[pp][payPhoneRZ] = rz;
					tmpEditing_Component_DMV[playerid] = 0;
					
                    inline update()
                    {
                        FixPayPhoneLabel(pp);
                        return 1;
                    }
					mysql_tquery_inline(chandler, using inline update, "\
                        UPDATE `payphones_data` SET `X` = '%0.3f', `Y` = '%0.3f', `Z` = '%0.3f', `RX` = '%0.3f', `RY` = '%0.3f', `RZ` = '%0.3f' \
                        WHERE `id` = '%d'", 
                        x, y, z, rx, ry, rz, PayPhoneInfo[pp][payPhoneId]
                    );
				}
			}
        }
    }
    return 1;
}