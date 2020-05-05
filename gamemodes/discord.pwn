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
    // format(string, sizeof string, "ID %d reportinio ID %d. Prie�astis: %s", playerid, cheaterid, reason);
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
		if(str[i] == '�') str[i] = 'A';
		if(str[i] == 'a') str[i] = 'a';
		if(str[i] == '�') str[i] = 'C';
		if(str[i] == '�') str[i] = 'c';
		if(str[i] == '�') str[i] = 'E';
		if(str[i] == '�') str[i] = 'e';
		if(str[i] == '�') str[i] = 'E';
		if(str[i] == '�') str[i] = 'e';
		if(str[i] == '�') str[i] = 'I';
		if(str[i] == '�') str[i] = 'i';
		if(str[i] == '�') str[i] = 'S';
		if(str[i] == '�') str[i] = 's';
		if(str[i] == '�') str[i] = 'U';
		if(str[i] == '�') str[i] = 'u';
		if(str[i] == '�') str[i] = 'U';
		if(str[i] == '�') str[i] = 'u';
		if(str[i] == '�') str[i] = 'Z';
		if(str[i] == '�') str[i] = 'z';
	}
	return str;
}