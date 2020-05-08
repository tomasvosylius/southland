#define MAX_INTS_PER_PAGE   50

/** External */
stock AMenu_Interiors_Main(playerid)
{
    _Interiors_ShowList(playerid);
    return 1;
}

/** Internals */
static _Interiors_ShowList(playerid, page = 0)
{
    inline loadInts()
    {
        dialog_Clear();
        dialog_AddLine("{11ff99}>> Iðsaugoti naujà interjerà dabartinëje vietoje");

        new name[24],
            i = 0, rows = cache_num_rows();
        for(new r = 0; r < rows; r++)
        {
            i = (page*MAX_INTS_PER_PAGE) + r + 1;
            cache_get_value_name(i, "Name", name, 24);

            dialog_AddLine("%d. %s", i, name);
        }

        if(page > 0) dialog_AddLine("{BABABA}<<< ATGAL\n");
	    if(rows > MAX_INTS_PER_PAGE) dialog_AddLine("{BABABA}>>> KITAS\n");

        inline select(response, listitem)
        {
            dialog_Row(">> Iðsaugoti naujà interjerà")  return _Interiors_CreateNew(playerid);
            dialog_Row("<<< ATGAL")                     return _Interiors_ShowList(playerid, page - 1);
            dialog_Row(">>> KITAS")                     return _Interiors_ShowList(playerid, page + 1);

            _Interiors_ShowDetails(playerid, .offset = (page * MAX_INTS_PER_PAGE) + listitem);
        }
        dialog_Show(playerid, using inline select, DIALOG_STYLE_LIST, "Interjerai", "Tæsti", "Atðaukti");
    }

    mysql_tquery_inline(chandler, using inline loadInts, "SELECT * FROM `interiors` LIMIT %d OFFSET %d", MAX_INTS_PER_PAGE + 1, page * MAX_INTS_PER_PAGE);
    return 1;
}

static _Interiors_CreateNew(playerid, error[] = "")
{
    dialog_Clear();
    dialog_AddLine("Áveskite naujo interjero pavadinimà");
    dialog_AddErrorLine(error);
    inline input(response, listitem)
    {
        if(response)
        {
            new name[24];
            if(sscanf(dialog_Input(),"s[24]",name))
                return _Interiors_CreateNew(playerid, .error = "Neivestas pavadinimas");

            new Float:x, Float:y, Float:z;
            GetPlayerPos(playerid, x, y, z);

            inline addNew()
            {
                MsgSuccess(playerid, "INTERJERAI", "Sëkmingai pridëjote interjerà.");
                _Interiors_ShowList(playerid);
                return 1;
            }
            mysql_tquery_inline(chandler, using inline addNew, "INSERT INTO `interiors` (`Name`,`X`,`Y`,`Z`,`Interior`) VALUES ('%e','%f','%f','%f','%d')", name, x, y, z, GetPlayerInterior(playerid));

            log_init(true);
            log_set_table("logs_admins");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`ExtraString`");
            log_set_values("'%d','%e','(AM) Pridejo nauja interjera','%e'", LogPlayerId(playerid), LogPlayerName(playerid), name);
            log_commit();
        }
        else _Interiors_ShowList(playerid);
    }
    dialog_Show(playerid, using inline input, DIALOG_STYLE_INPUT, "Naujas interjeras", "Pridëti", "Iðeiti");
    return 1;
}

static _Interiors_ShowDetails(playerid, offset)
{
    inline intDetails()
    {
        if(cache_num_rows())
        {
            new name[24],
                Float:x, Float:y, Float:z,
                int = 0, id = 0;

            cache_get_value_int(0, "id", id);
            cache_get_value_name(0, "Name", name);
            cache_get_value_int(0, "Interior", int);
            cache_get_value_float(0, "X", x);
            cache_get_value_float(0, "Y", y);
            cache_get_value_float(0, "Z", z);
            
            dialog_Clear();
            dialog_AddLine("Teleportuotis á interjerà");
            dialog_AddLine("{c60000}Iðtrinti");

            inline edit(response, listitem)
            {
                if(response)
                {
                    dialog_Row("Teleportuotis")
                    {

                        return 1;
                    }
                    dialog_Row("Iðtrinti")
                    {
                        inline delete()
                        {
                            MsgSuccess(playerid, "Interjerai", "Istrinta.");
                            _Interiors_ShowList(playerid);
                            return 1;
                        }
                        mysql_tquery_inline(chandler, using inline delete, "DELETE FROM `interiors` WHERE id = '%d'", id);
                        return 1;
                    }
                }
                else _Interiors_ShowList(playerid);
            }
            dialog_Show(playerid, using inline edit, DIALOG_STYLE_LIST, va_return("Interjeras: %s", name), "Testi", "Grizti");
            return 1;
        }
        else _Interiors_ShowList(playerid);
        return 1;
    }
    mysql_tquery_inline(chandler, using inline intDetails, "SELECT * FROM `interiors` LIMIT 1 OFFSET %d", offset);
    return 1;
}