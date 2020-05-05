#include <a_samp>
#include <a_mysql>
#include <discord-connector>

static 
    DCC_Channel:reports_ch,
    MySQL:chandler;

public OnFilterScriptInit()
{
    chandler = mysql_connect("localhost", "root", "", "southland");
    reports_ch = DCC_FindChannelById("705791066892140644");

    printf("Discord connectors FS loaded. Reports channel: %d", _:reports_ch);
    return 1;
}

forward OnReportAdded(adminsOnDuty, playerid, playerUser, cheaterid, cheaterUser, reason[]);
public OnReportAdded(adminsOnDuty, playerid, playerUser, cheaterid, cheaterUser, reason[])
{
    new
        string[256];
    printf("From FS: %d about %d: %s", playerid, cheaterid, reason);
    
    format(string, sizeof string, "SELECT `DiscordUser`,`id` FROM `users_data` WHERE id = '%d' OR id = '%d'", playerUser, cheaterUser);
    mysql_tquery(chandler, string, "OnUsersIDSLoad", "ddds", adminsOnDuty, playerUser, cheaterUser, reason);
    return 1;
}

forward OnUsersIDSLoad(admins, playerUser, cheaterUser, reason[]);
public OnUsersIDSLoad(admins, playerUser, cheaterUser, reason[])
{
    // format(string, sizeof string, "ID %d reportinio ID %d. Prieþastis: %s", playerid, cheaterid, reason);
    // DCC_SendChannelMessage(reports_ch, string, "", "");

    new 
        playerDiscord[32],
        cheaterDiscord[32],
        string[256];

    for(new r = 0, rows = cache_num_rows(); r < rows; r++)
    {
        new userid;
        cache_get_value_name_int(r, "id", userid);

        if(userid == playerUser) 
        {
            (strlen(playerDiscord) <= 0) && cache_get_value_name(r, "DiscordUser", playerDiscord);
        }
        if(userid == cheaterUser)
        {
            (strlen(cheaterDiscord) <= 0) && cache_get_value_name(r, "DiscordUser", cheaterDiscord);
        }
    }

    format(string, sizeof string, "<@%s> reportino <@%s>. Priezastis: `%s`.", playerDiscord, cheaterDiscord, formatlt(reason));
    if(admins <= 0) {
        strcat(string, " 0 AOD! <@705135249079664681>");
    }

    print(string);

    DCC_SendChannelMessage(reports_ch, string, "", "");
    return 1;
}


stock formatlt(const string[])
{
	/*
		Funkcija, pavercianti eilute su lietuviskomis raidemis i angliskas
	*/
	new strlenght = strlen(string),
		str[126];
	format(str, sizeof str, string);
	for(new i = 0; i < strlenght; i++)
	{
		if(str[i] == 'À') str[i] = 'A';
		else if(str[i] == 'à') str[i] = 'a';
		else if(str[i] == 'È') str[i] = 'C';
		else if(str[i] == 'è') str[i] = 'c';
		else if(str[i] == 'Æ') str[i] = 'E';
		else if(str[i] == 'æ') str[i] = 'e';
		else if(str[i] == 'Ë') str[i] = 'E';
		else if(str[i] == 'ë') str[i] = 'e';
		else if(str[i] == 'Á') str[i] = 'I';
		else if(str[i] == 'á') str[i] = 'i';
		else if(str[i] == 'Ð') str[i] = 'S';
		else if(str[i] == 'ð') str[i] = 's';
		else if(str[i] == 'Ø') str[i] = 'U';
		else if(str[i] == 'ø') str[i] = 'u';
		else if(str[i] == 'Û') str[i] = 'U';
		else if(str[i] == 'û') str[i] = 'u';
		else if(str[i] == 'Þ') str[i] = 'Z';
		else if(str[i] == 'þ') str[i] = 'z';
		else if(str[i] == '—') str[i] = '-';
        else if(str[i] >= 128) str[i] = ' ';
	}
	return str;
}