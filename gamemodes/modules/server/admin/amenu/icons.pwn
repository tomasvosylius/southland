/** External */
stock AMenu_Icons_Main(playerid)
{
    _Icons_Main(playerid);
    return 1;
}

/** Internals */
static _Icons_Main(playerid)
{
    dialog_Clear();
    dialog_AddLine("Per�i�r�ti visas");
    dialog_AddLine("Prid�ti");

    inline select(response, listitem)
    {
        if(!response) return AMenu_Main(playerid);

        dialog_Row("Per�i�r�ti visas")  return _Icons_ShowList(playerid);
        dialog_Row("Prid�ti")           return _Icons_CreateNew(playerid);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_LIST, "Map ikonos", "T�sti", "At�aukti");
    return 1;
}

static _Icons_ShowList(playerid)
{
    if(!HaveAdminPermission(playerid, "EditIcons"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Icons_Main(playerid);
    }

    new place[28];

    dialog_Clear();
    dialog_AddLine("{BABABA}Nr.\t{BABABA}Pavadinimas\t{BABABA}Vieta");

    for(new icon = 0; icon < MAX_MAP_ICONS; icon++)
    {
        if(MapIconInfo[icon][mapIconId] != 0)
        {
            GetCoords2DZone(place, 28, MapIconInfo[icon][mapIconX], MapIconInfo[icon][mapIconY]);
            dialog_AddLine("%d.\t%s\t%s", icon+1, MapIconInfo[icon][mapIconName], place);
        }
        else
        {
            break;
        }
    }

    inline select(response, listitem)
    {
        if(response)
        {
            _Icons_ShowDetails(playerid, listitem);
        }
        else _Icons_Main(playerid);
        return 1;
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_TABLIST_HEADERS, "Map ikonos", "T�sti", "At�aukti");
    return 1;
}

static _Icons_ShowDetails(playerid, icon)
{
    dialog_Clear();

    dialog_AddLine("{BABABA}Nustatymas\t{BABABA}Dabartin� reik�m�");
    dialog_AddLine("Pavadinimas\t%s", MapIconInfo[icon][mapIconName]);
    dialog_AddLine("Tipas\t%d", MapIconInfo[icon][mapIconType]);
    dialog_AddLine("Matomumas\t%0.1f", MapIconInfo[icon][mapIconStreamDistance]);
    dialog_AddLine("Keisti viet�");
    dialog_AddLine("Teleportuotis");
    dialog_AddLine("{C60000}I�trinti");

    inline select(response, listitem)
    {
        if(response)
        {
            dialog_Row("Pavadinimas")   return _Icons_ChangeName(playerid, icon);
            dialog_Row("Tipas")         return _Icons_ChangeType(playerid, icon);
            dialog_Row("Matomumas")     return _Icons_ChangeDistance(playerid, icon);
            dialog_Row("Keisti viet�")  return _Icons_ChangePlace(playerid, icon);
            dialog_Row("Teleportuotis") return _Icons_TeleportTo(playerid, icon);
            dialog_Row("I�trinti")      return _Icons_Delete(playerid, icon);
        }
        _Icons_ShowList(playerid);
    }
    dialog_Show(playerid, using inline select, DIALOG_STYLE_TABLIST_HEADERS, "Map ikonos", "T�sti", "At�aukti");
    return 1;
}

static _Icons_ChangeName(playerid, icon, error[] = "")
{
    if(!HaveAdminPermission(playerid, "EditIconName"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Icons_ShowList(playerid);
    }

    dialog_Clear();
    dialog_AddLine("{FFFFFF}�veskite nauj� ikonos pavadinim�.");
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {
            new name[24];
            if(sscanf(dialog_Input(),"s[24]",name))
                return _Icons_ChangeName(playerid, icon, .error = "Neteisingai �vestas pav.");

            format(MapIconInfo[icon][mapIconName], 24, name);

            inline updateIcon()
            {
                MsgSuccess(playerid, "IKONOS", "Pavadinimas pakeistas.");
            }
            mysql_tquery_inline(chandler, using inline updateIcon, "\
                UPDATE `map_icons` SET Name = '%e' WHERE icon = '%d'",
                name, MapIconInfo[icon][mapIconId]
            );

            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`ExtraString`");
            log_set_values("'%d','%e','(AM) Pakeite ikonos pavadinima','%d','%e'", LogPlayerId(playerid), LogPlayerName(playerid), MapIconInfo[icon][mapIconId], dialog_Input());
            log_commit();

            _Icons_ShowDetails(playerid, icon);
        }
        else _Icons_ShowDetails(playerid, icon);
        return 1;
    }

    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Map ikonos", "T�sti", "At�aukti");
    return 1;
}
static _Icons_ChangeType(playerid, icon, error[] = "")
{
    if(!HaveAdminPermission(playerid, "EditIconType"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Icons_ShowDetails(playerid, icon);
    }

    dialog_Clear();
    dialog_AddLine("{FFFFFF}�veskite ikonos ID.");
    dialog_AddLine("{BABABA}(wiki.sa-mp.com/wiki/MapIcons)");
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {
            new type;
            if(sscanf(dialog_Input(),"d", type) || !(0 < type <= 63))
                return _Icons_ChangeType(playerid, icon, .error = "Netinkamas ID.");

            inline updateIcon()
            {
                MsgSuccess(playerid, "IKONOS", "Ikona s�kmingai atnaujinta.");
                return 1;
            }
            mysql_tquery_inline(chandler, using inline updateIcon, "\
                UPDATE `map_icons` SET Type = '%d' WHERE id = '%d'", 
                type, MapIconInfo[icon][mapIconId]
            );
    
            IsValidDynamicMapIcon(MapIconInfo[icon][mapIconIcon]) && DestroyDynamicMapIcon(MapIconInfo[icon][mapIconIcon]);
            MapIconInfo[icon][mapIconType] = type;
            MapIconInfo[icon][mapIconIcon] = CreateDynamicMapIcon(
                    MapIconInfo[icon][mapIconX],
                    MapIconInfo[icon][mapIconY],
                    MapIconInfo[icon][mapIconZ],
                    type,
                    MapIconInfo[icon][mapIconColor],
                    MapIconInfo[icon][mapIconVW],
                    MapIconInfo[icon][mapIconInterior],
                    .streamdistance = MapIconInfo[icon][mapIconStreamDistance],
                    .style = MAPICON_GLOBAL
            );

            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`Amount`");
            log_set_values("'%d','%e','(AM) Pakeite ikonos tipa','%d','%d'", LogPlayerId(playerid), LogPlayerName(playerid), MapIconInfo[icon][mapIconId], type);
            log_commit();
        }
        _Icons_ShowDetails(playerid, icon);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Map ikonos", "T�sti", "At�aukti");
    return 1;
}
static _Icons_ChangeDistance(playerid, icon, error[] = "")
{
    if(!HaveAdminPermission(playerid, "EditIconDistance"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Icons_ShowDetails(playerid, icon);
    }

    dialog_Clear();
    dialog_AddLine("{FFFFFF}�veskite matomumo distancij�.");
    dialog_AddErrorLine(error);

    inline input(response, listitem)
    {
        if(response)
        {
            new Float:distance;
            if(sscanf(dialog_Input(),"f",distance) || distance <= 0.0)
                return _Icons_ChangeDistance(playerid, icon, .error = "Neteisingai �vesta distancija");

            inline updateIcon()
            {
                MsgSuccess(playerid, "IKONOS", "Matomumo distancija s�kmingai atnaujinta.");
            }
            mysql_tquery_inline(chandler, using inline updateIcon, "\
                UPDATE `map_icons` SET StreamDistance = '%0.1f' WHERE icon = '%d'",
                distance, MapIconInfo[icon][mapIconId]
            );

            IsValidDynamicMapIcon(MapIconInfo[icon][mapIconIcon]) && DestroyDynamicMapIcon(MapIconInfo[icon][mapIconIcon]);
            MapIconInfo[icon][mapIconStreamDistance] = distance;
            MapIconInfo[icon][mapIconIcon] = CreateDynamicMapIcon(
                MapIconInfo[icon][mapIconX],
                MapIconInfo[icon][mapIconY],
                MapIconInfo[icon][mapIconZ],
                MapIconInfo[icon][mapIconType],
                MapIconInfo[icon][mapIconColor],
                MapIconInfo[icon][mapIconVW],
                MapIconInfo[icon][mapIconInterior],
                .streamdistance = distance, .style = MAPICON_GLOBAL
            );
            
            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`Amount`");
            log_set_values("'%d','%e','(AM) Pakeite ikonos distancija','%d','%d'", LogPlayerId(playerid), LogPlayerName(playerid), MapIconInfo[icon][mapIconId], floatround(distance));
            log_commit();

            _Icons_ShowDetails(playerid, icon);
            return 1;
        }
        else _Icons_ShowDetails(playerid, icon);
        return 1;
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Map ikonos", "T�sti", "At�aukti");
    return 1;
}
static _Icons_ChangePlace(playerid, icon)
{
    if(!HaveAdminPermission(playerid, "ChangeIconPosition"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Icons_ShowDetails(playerid, icon);
    }

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    
    inline updateIcon()
    {
        MsgSuccess(playerid, "IKONOS", "Vieta s�kmingai atnaujinta.");
    }
    mysql_tquery_inline(chandler, using inline updateIcon, "\
        UPDATE `map_icons` SET X = '%f', Y = '%f', Z = '%f' WHERE icon = '%d'",
        x, y, z, MapIconInfo[icon][mapIconId]
    );
    
    IsValidDynamicMapIcon(MapIconInfo[icon][mapIconIcon]) && DestroyDynamicMapIcon(MapIconInfo[icon][mapIconIcon]);
    MapIconInfo[icon][mapIconX] = x,
    MapIconInfo[icon][mapIconY] = y,
    MapIconInfo[icon][mapIconZ] = z;
    MapIconInfo[icon][mapIconIcon] = CreateDynamicMapIcon(
        x, y, z, 
        MapIconInfo[icon][mapIconType], 
        MapIconInfo[icon][mapIconColor], 
        MapIconInfo[icon][mapIconVW], 
        MapIconInfo[icon][mapIconInterior],
        .streamdistance = MapIconInfo[icon][mapIconStreamDistance],
        .style = MAPICON_GLOBAL
    );

    log_init(true);
    log_set_table("logs_admins");
    log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`");
    log_set_values("'%d','%e','(AM) Pakeite ikonos vieta','%d'", LogPlayerId(playerid), LogPlayerName(playerid), MapIconInfo[icon][mapIconId]);
    log_commit();

    _Icons_ShowDetails(playerid, icon);
    return 1;
}
static _Icons_TeleportTo(playerid, icon)
{
    SetPlayerPos(playerid, MapIconInfo[icon][mapIconX], MapIconInfo[icon][mapIconY], MapIconInfo[icon][mapIconZ]);
    SetPlayerVirtualWorld(playerid, MapIconInfo[icon][mapIconVW]);
    SetPlayerInterior(playerid, MapIconInfo[icon][mapIconInterior]);
    return 1;
}
static _Icons_Delete(playerid, icon)
{
    if(!HaveAdminPermission(playerid, "DeleteIcon"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Icons_ShowDetails(playerid, icon);
    }

    log_init(true);
    log_set_table("logs_admins");
    log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraId`,`ExtraString`");
    log_set_values("'%d','%e','(AM) Istryne ikona','%d','%e'", LogPlayerId(playerid), LogPlayerName(playerid), MapIconInfo[icon][mapIconId], MapIconInfo[icon][mapIconName]);
    log_commit();

    inline deleteIcon() return 1;
    mysql_tquery_inline(chandler, using inline deleteIcon, "DELETE FROM `map_icons` WHERE icon = '%d'", MapIconInfo[icon][mapIconId]);

    DestroyDynamicMapIcon(MapIconInfo[icon][mapIconIcon]);
    reset(MapIcon, MapIconInfo[icon], E_MAP_ICON_DATA);
    MsgSuccess(playerid, "IKONOS", "Ikona i�trinta.");

    SortEnumArray(MapIconInfo, 0, MAX_MAP_ICONS, [mapIconId], 0, E_MAP_ICON_DATA, TRUE);
    
    _Icons_Main(playerid);
    return 1;
}

static _Icons_CreateNew(playerid)
{
    if(!HaveAdminPermission(playerid, "CreateNewIcon"))
    {
        InfoBox(playerid, IB_NO_PRIVILEGE);
        return _Icons_Main(playerid);
    }

    dialog_Clear();
    dialog_AddLine("{FFFFFF}�veskite ikonos ID.");
    dialog_AddLine("{BABABA}(wiki.sa-mp.com/wiki/MapIcons)");
    inline input(response, listitem)
    {
        if(response)
        {
            new icon,
                iter = -1;
            if(sscanf(inputtext,"d",icon) || icon < 0 || icon > 63)
                return _Icons_CreateNew(playerid);

            for(new i = 0; i < MAX_MAP_ICONS; i++)
            {
                if(MapIconInfo[i][mapIconId] <= 0)
                {
                    iter = i;
                    break;
                }
            }

            if(iter != -1)
            {
                GetPlayerPos(playerid, MapIconInfo[iter][mapIconX], MapIconInfo[iter][mapIconY], MapIconInfo[iter][mapIconZ]);
                MapIconInfo[iter][mapIconVW] = GetPlayerVirtualWorld(playerid);
                MapIconInfo[iter][mapIconInterior] = GetPlayerInterior(playerid);
                MapIconInfo[iter][mapIconType] = icon;
                MapIconInfo[iter][mapIconColor] = 0xFFFFFFFF;
                MapIconInfo[iter][mapIconStreamDistance] = 300.0;
                format(MapIconInfo[iter][mapIconName], 14, "Be pavadinimo");

                MapIconInfo[iter][mapIconIcon] = CreateDynamicMapIcon(MapIconInfo[iter][mapIconX], MapIconInfo[iter][mapIconY], MapIconInfo[iter][mapIconZ], MapIconInfo[iter][mapIconType], MapIconInfo[iter][mapIconColor], MapIconInfo[iter][mapIconVW], MapIconInfo[iter][mapIconInterior], .streamdistance = MapIconInfo[iter][mapIconStreamDistance], .style = MAPICON_GLOBAL);

                inline addNew()
                {
                    if(mysql_errno() == 0)
                    {
                        MapIconInfo[iter][mapIconId] = cache_insert_id();
                        _Icons_ShowDetails(playerid, iter);
                    }
                    else
                    {
                        SendError(playerid, "Si�sta u�klausa nepavyko [%d]", mysql_errno());
                    }
                    return 1;
                }               
                mysql_tquery_inline(chandler, using inline addNew, "\
                    INSERT INTO `map_icons` (`Name`,`X`,`Y`,`Z`,`Type`,`StreamDistance`,`Color`,`VW`,`Interior`) \
                    VALUES \
                    ('Be pavadinimo','%f','%f','%f','%d','300.0','0xFFFFFFFF','%d','%d')",
                    MapIconInfo[iter][mapIconX], MapIconInfo[iter][mapIconY], MapIconInfo[iter][mapIconZ],
                    MapIconInfo[iter][mapIconType], MapIconInfo[iter][mapIconVW], MapIconInfo[iter][mapIconInterior]
                );
            }
        }
        else _Icons_Main(playerid);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Map ikonos", "T�sti", "At�aukti");

    return 1;
}