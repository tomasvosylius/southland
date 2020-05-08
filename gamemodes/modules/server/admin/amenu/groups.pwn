#define ADMIN_PERMISSIONS_PER_PAGE		18 // kiek permisionu per page rodyt ( << >> )

/** External */
stock AMenu_Groups_Main(playerid)
{
    _Groups_Main(playerid);
    return 1;
}

/** Internal */
static _Groups_Main(playerid)
{
    dialog_Clear();
    dialog_AddLine("Perþiûrëti visas");
    dialog_AddLine("Pridëti");

    inline select(response, listitem)
    {
        if(response)
        {
            dialog_Row("Perþiûrëti visas")  return _Groups_ShowList(playerid);
            dialog_Row("Pridëti")           return _Groups_CreateNew(playerid); 
        }
        else AMenu_Main(playerid);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_LIST, "Grupës", "Tæsti", "Atðaukti");
    return 1;
}

static _Groups_ShowList(playerid)
{
    // visas
    if(!HaveAdminPermission(playerid, "EditGroups"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Groups_Main(playerid);
    }

    dialog_Clear();
    dialog_AddLine("{BABABA}Nr.\t{BABABA}Pavadinimas");

    new i = 0;
    foreach(new groupid : AdminGroup)
    {
        i++;
        dialog_AddLine("%d.\t%s (MySQL ID: %d)", i, GetGroupName(groupid, false), GroupsInfo[groupid][groupId]);
    }
    inline list(response, listitem)
    {
        if(response)
        {
            new groupid;
            GetSortedAsForeach(AdminGroup, listitem, groupid, EMPTY_STATEMENT);

            _Groups_ShowDetails(playerid, groupid);
        }
        else _Groups_Main(playerid);
    }
    dialog_Show(playerid, using inline list, DIALOG_STYLE_TABLIST_HEADERS, "Grupës", "Tæsti", "Atðaukti");
    return 1;
}

static _Groups_ShowDetails(playerid, groupid)
{
    dialog_Clear();
    dialog_AddLine("Keisti pavadinimà");
    dialog_AddLine("Keisti teises");
    dialog_AddLine("Keisti komandø teises");
    dialog_AddLine("{C60000}Iðtrinti");

    inline select(response, listitem)
    {
        if(response)
        {
            dialog_Row("Keisti pavadinimà")     return _Groups_ChangeName(playerid, groupid);
            dialog_Row("Keisti teises")         return _Groups_ChangePermissions(playerid, groupid);
            dialog_Row("Keisti komandø teises") return _Groups_ChangeCommands(playerid, groupid);
            dialog_Row("Iðtrinti")              return _Groups_Delete(playerid, groupid);
        }
        else _Groups_ShowList(playerid);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_LIST, "Grupës", "Tæsti", "Atðaukti");
    return 1;
}

static _Groups_ChangeName(playerid, groupid, error[] = "")
{
    dialog_Clear();
    dialog_AddLine("{FFFFFF}Áveskite naujà grupës pavadinimà. (maks. 30 simboliø)");
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {
            new name[30];
            if(sscanf(dialog_Input(),"s[30]",name) || strlen(name) > 30)
                return _Groups_ChangeName(playerid, groupid, .error = "Neivestas pavadinimas");

            format(GroupsInfo[groupid][groupName], 30, name);
            inline updateName()
            {
                MsgSuccess(playerid, "Grupes", "Pavadinimas pakeitas.");
                return 1;
            }
            mysql_tquery_inline(chandler, using inline updateName, "UPDATE `groups_data` SET Name = '%e' WHERE id = '%d'", name, GroupsInfo[groupid][groupId]);
        }
        _Groups_ShowDetails(playerid, groupid);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Grupës", "Tæsti", "Atðaukti");
    return 1;
}

static _Groups_ChangePermissions(playerid, groupid, page = 0)
{  
    if(!HaveAdminPermission(playerid, "EditGroupPermissions"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Groups_ShowDetails(playerid, groupid);
    }

    inline isSuper()
    {
        if(cache_num_rows())
        {
            SendError(playerid, "Ðios grupës teisiø redaguoti negalima.");
            _Groups_ShowList(playerid);
            return 1;
        }

        inline selectPerms()
        {
            new exists,
                permission_name[30],
                comment[50],
                rows = cache_num_rows();

            /** Permissions dialog */
            dialog_Clear();
            dialog_AddLine("Pavadinimas\tApraðymas\tTuri teisæ");

            for(new r = 0; r < rows; r++)
            {
                if(r >= ADMIN_PERMISSIONS_PER_PAGE) // kadangi ADMIN_PERMISSIONS_PER_PAGE+1 traukiam
                {
                    break;
                }
                else
                {
                    cache_get_value_name(r, "Permission", permission_name);
                    cache_get_value_name(r, "Comment", comment);
                    cache_get_value_name_int(r, "HavePermission", exists);

                    dialog_AddLine("%s\t%s\t%s", permission_name, comment, (exists > 0 ? ("+") : (" ")));
                }
            }

            if(page > 0)
            {
                dialog_AddLine("{D28989}<<<");
            }
            if(rows > ADMIN_PERMISSIONS_PER_PAGE)
            {
                // kadangi tikrinom ADMIN_PERMISSIONS_PER_PAGE+1, gali but 1 daugiau
                dialog_AddLine("{B0DCA8}>>>"); 
            }

            inline permsList(response, listitem)
            {
                if(!response) return _Groups_ShowDetails(playerid, groupid);

                dialog_Row("<<<") return _Groups_ChangePermissions(playerid, .groupid = groupid, .page = page - 1);
                dialog_Row(">>>") return _Groups_ChangePermissions(playerid, .groupid = groupid, .page = page + 1);


                inline getPermName()
                {
                    cache_get_value_name(0, "Permission", permission_name);

                    inline checkPerm()
                    {
                        new changeQuery[256], bool:existed = false;
                        if(cache_num_rows())
                        {
                            // Jei egzistuoja - nuimam
                            existed = true;
                            mysql_format(chandler, changeQuery, sizeof changeQuery, "DELETE FROM `groups_permissions` WHERE GroupId = '%d' AND Permission = '%e'", GroupsInfo[groupid][groupId], permission_name);
                        }
                        else 
                        {
                            // Uzdedam
                            existed = false;
                            mysql_format(chandler, changeQuery, sizeof changeQuery, "INSERT INTO `groups_permissions` (`GroupId`,`Permission`) VALUES ('%d','%e')", GroupsInfo[groupid][groupId], permission_name);
                        }

                        inline changePerm()
                        {
                            /**
                                Pakeite permissionus.
                             */
                            printf("[debug] %s pakeite grupes %d permissiona %s: %d", ret_GetPlayerName(playerid), GroupsInfo[groupid][groupId], permission_name, !existed);

                            MsgSuccess(playerid, "Grupes", "Permission nustatymas pakeistas");
                            _Groups_ChangePermissions(playerid, .groupid = groupid, .page = page);
                            return 1;
                        }
                        mysql_tquery_inline(chandler, using inline changePerm, changeQuery);
                        return 1;
                    }
                    mysql_tquery_inline(chandler, using inline checkPerm, "SELECT NULL FROM `groups_permissions` WHERE GroupId = '%d' AND Permission = '%e'", GroupsInfo[groupid][groupId], permission_name);
                    return 1;
                }
                mysql_tquery_inline(chandler, using inline getPermName, "SELECT `Permission` FROM `groups_permissions_list` LIMIT 1 OFFSET %d", page * ADMIN_PERMISSIONS_PER_PAGE + listitem);
            }
            dialog_Show(playerid, using inline permsList, DIALOG_STYLE_TABLIST_HEADERS, "Teisës", "Tæsti", "Atðaukti");
        }        
        mysql_tquery_inline(chandler, using inline selectPerms, "\
            SELECT `list`.*,(CASE WHEN (SELECT COUNT(*) FROM `groups_permissions` `group` WHERE `group`.`Permission` = `list`.`Permission` AND `group`.`GroupId` = '%d') > 0 THEN 1 ELSE 0 END) as `HavePermission` FROM `groups_permissions_list` `list` LIMIT %d OFFSET %d",
            GroupsInfo[groupid][groupId],
            ADMIN_PERMISSIONS_PER_PAGE + 1,
            page * ADMIN_PERMISSIONS_PER_PAGE);
    
    }
    mysql_tquery_inline(chandler, using inline isSuper, "SELECT NULL FROM `groups_data` WHERE id = '%d' AND Super = '1'",
        GroupsInfo[groupid][groupId]
    );
    return 1;
}



static _Groups_ChangeCommands(playerid, groupid)
{   
    if(!HaveAdminPermission(playerid, "EditGroupCommands"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Groups_ShowDetails(playerid, groupid);
    }

    inline isSuper()
    {
        if(cache_num_rows())
        {
            SendError(playerid, "Ðios grupës teisiø redaguoti negalima.");
            _Groups_ShowList(playerid);
            return 1;
        }

        dialog_Clear();
        dialog_AddLine("{BABABA}Komanda\t{BABABA}Turi teisæ");

        new command[24],
            query[186],
            CmdArray:array = PC_GetCommandArray();

        for(new c = 0, size = PC_GetArraySize(array); c < size; c++)
        {
            PC_GetCommandName(array, c, command, sizeof command);
            if(PC_GetFlags(command) & CMD_TYPE_ADMIN)
            {
                mysql_format(chandler, query, sizeof query, "SELECT NULL FROM `groups_commands` WHERE GroupId = '%d' AND Command = '%e'", GroupsInfo[groupid][groupId], command);
                new Cache:result = mysql_query(chandler, query, true);

                dialog_AddLine("/%s\t%s", command, (cache_num_rows() ? ("+") : (" ")));

                cache_delete(result);
            }
        }
        
        inline cmdList(response, listitem)
        {
            if(!response) return _Groups_ShowDetails(playerid, groupid);
        
            // komanda pasirinko
            new real;
            for(new c = 0, size = PC_GetArraySize(array); c < size; c++)
            {
                PC_GetCommandName(array, c, command, sizeof command);
                if(PC_GetFlags(command) & CMD_TYPE_ADMIN)
                {
                    if(real == listitem) { 
                        break; 
                    }
                    real++;
                }
            }


            inline checkCurrentSet()
            {
                new changeQuery[256], bool:existed = false;
                if(cache_num_rows())
                {
                    // delete
                    existed = true;
                    mysql_format(chandler, changeQuery, sizeof changeQuery, "DELETE FROM `groups_commands` WHERE GroupId = '%d' AND Command = '%e'", GroupsInfo[groupid][groupId], command);
                }
                else
                {
                    // insert
                    existed = false;
                    mysql_format(chandler, changeQuery, sizeof changeQuery, "INSERT INTO `groups_commands` (`GroupId`,`Command`) VALUES ('%d','%e')", GroupsInfo[groupid][groupId], command);
                }

                inline changePerm()
                {
                    /**
                        Pakeite komandos permissionus.
                    */
                    printf("[debug] %s pakeite grupes %d komanda %s: %d", ret_GetPlayerName(playerid), GroupsInfo[groupid][groupId], command, !existed);
                    MsgSuccess(playerid, "Grupes", "Komandos nustatymas pakeistas");

                    _Groups_ChangeCommands(playerid, groupid);
                    return 1;
                }
                mysql_tquery_inline(chandler, using inline changePerm, changeQuery);
                return 1;
            }
            mysql_tquery_inline(chandler, using inline checkCurrentSet, "SELECT NULL FROM `groups_commands` WHERE GroupId = '%d' AND Command = '%e'", GroupsInfo[groupid][groupId], command);
        }
        
        dialog_Show(playerid, using inline cmdList, DIALOG_STYLE_TABLIST_HEADERS, "Grupës", "Keisti", "Atðaukti");
        return 1;
    }

    mysql_tquery_inline(chandler, using inline isSuper, "SELECT NULL FROM `groups_data` WHERE id = '%d' AND Super = '1'",
        GroupsInfo[groupid][groupId]
    );
    return 1;
}
static _Groups_Delete(playerid, groupid)
{
    if(!HaveAdminPermission(playerid, "DeleteGroup"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Groups_ShowDetails(playerid, groupid);
    }


    inline isSuper()
    {
        if(cache_num_rows())
        {
            SendError(playerid, "Ðios grupës iðtrinti negalima.");
            return _Groups_ShowDetails(playerid, groupid);
        }
        else
        {
            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`ExtraString`");
            log_set_values("'%d','%e','(AM) Istryne grupe','%d','%e'", LogPlayerId(playerid), LogPlayerName(playerid), GroupsInfo[groupid][groupId], GroupsInfo[groupid][groupName]);
            log_commit();

            new groupSql = GroupsInfo[groupid][groupId];

            inline ok() return 1;
            mysql_tquery_inline(chandler, using inline ok, "DELETE FROM `groups_data` WHERE id = '%d'", groupSql);
            mysql_tquery_inline(chandler, using inline ok, "DELETE FROM `groups_permissions` WHERE GroupId = '%d'", groupSql);
            mysql_tquery_inline(chandler, using inline ok, "DELETE FROM `groups_commands` WHERE GroupId = '%d'", groupSql);
            mysql_tquery_inline(chandler, using inline ok, "UPDATE `users_data` SET Group1 = '0' WHERE Group1 = '%d'", groupSql);
            mysql_tquery_inline(chandler, using inline ok, "UPDATE `users_data` SET Group2 = '0' WHERE Group2 = '%d'", groupSql);
            mysql_tquery_inline(chandler, using inline ok, "UPDATE `users_data` SET Group3 = '0' WHERE Group3 = '%d'", groupSql);

            MsgSuccess(playerid, "GRUPËS", "Grupë sëkmingai iðtrinta.");
            reset(AdminGroup, GroupsInfo[groupid], E_GROUP_DATA);
            Iter_Remove(AdminGroup, groupid);
        }
        _Groups_ShowList(playerid);
    }
    mysql_tquery_inline(chandler, using inline isSuper, "SELECT NULL FROM `groups_data` WHERE id = '%d' AND Super = '1'", GroupsInfo[groupid][groupId]);
    return 1;
}

static _Groups_CreateNew(playerid, error[] = "")
{
    if(!HaveAdminPermission(playerid, "CreateNewGroup"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Groups_Main(playerid);
    }

    dialog_Clear();
    dialog_AddLine("{FFFFFF}Áveskite naujà grupës pavadinimà.");
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(!response) return _Groups_Main(playerid);

        new name[30];
        if(sscanf(dialog_Input(),"s[30]",name) || !strlen(name))
            return _Groups_CreateNew(playerid, .error = "Neivestas pavadinimas.");

        inline createNewGroup()
        {
            new iter = Iter_Free(AdminGroup);
            if(iter == ITER_NONE) return SendWarning(playerid, "Pasiektas grupiø limitas.");

            new group_sql = GroupsInfo[iter][groupId] = cache_insert_id();

            MsgSuccess(playerid, "GRUPËS", "Grupë sëkmingai sukurta.");

            format(GroupsInfo[iter][groupName], 30, name);
            Iter_Add(AdminGroup, iter);

            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`ExtraString`");
            log_set_values("'%d','%e','(AM) Sukure nauja grupe','%d','%e'", LogPlayerId(playerid), LogPlayerName(playerid), GroupsInfo[iter][groupId], name);
            log_commit();

            inline getPermissions()
            {
                new permission_name[30];
                for(new r = 0, rows = cache_num_rows(); r < rows; r++)
                {
                    cache_get_value_name(r, "Permission", permission_name);

                    inline insertPermission() return 1;
                    mysql_tquery_inline(chandler, using inline insertPermission, "\
                        INSERT INTO `groups_permissions` (`GroupId`,`Permission`) VALUES ('%d','%s')", group_sql, permission_name
                    );
                }
                _Groups_ShowList(playerid);
            }

            mysql_tquery_inline(chandler, using inline getPermissions, "SELECT `Permission` FROM `groups_permissions_list` WHERE DefaultValue > '0'");
            return 1;
        }
        mysql_tquery_inline(chandler, using inline createNewGroup, "\
            INSERT INTO `groups_data` (`Name`,`Super`,`Added`) VALUES ('%e','0','%d')", 
            name, PlayerInfo[playerid][pId]
        );

        return 1;
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Grupës", "Kurti", "Atðaukti");
    return 1;
}