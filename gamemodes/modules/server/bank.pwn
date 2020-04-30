#include <YSI\y_hooks>



CMD:bank(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 5.0, GetGVarFloat("BankX", SERVER_VARS_ID), GetGVarFloat("BankY", SERVER_VARS_ID), GetGVarFloat("BankZ", SERVER_VARS_ID)) && GetPlayerVirtualWorld(playerid) == GetGVarInt("BankVW", SERVER_VARS_ID))
	{
		ShowPlayerBank(playerid, true);
	}
	else InfoBox(playerid, "NESATE", "BANKE");
	return 1;
}

stock PayDay(playerid)
{
	if(PlayerInfo[playerid][pJobContract] > 0) PlayerInfo[playerid][pJobContract]--;
	new playerjob,
		payday = PlayerInfo[playerid][pPayCheck],
		payday_business = 0;
	if(PlayerInfo[playerid][pJob] > 0)
	{
		playerjob = GetJobArrayIndexById(PlayerInfo[playerid][pJob]);
		if(playerjob != -1)
		{
			payday += Jobs[playerjob][jobPayDay];
			if(PlayerInfo[playerid][pJob] == JOB_TRUCKER)
			{
				payday += (PlayerInfo[playerid][pJobLevel]*100);
			}
		}
	}
	else if(PlayerInfo[playerid][pFaction] > 0)
	{
		playerjob = GetFactionArrayIndexById(PlayerInfo[playerid][pFaction]);
		if(playerjob != -1 && PlayerInfo[playerid][pJobLevel] >= 1)
		{
			payday += FactionRankSalaries[playerjob][PlayerInfo[playerid][pJobLevel]-1];
			if(FactionInfo[playerjob][fType] == FACTION_TYPE_POLICE && PlayerInfo[playerid][pPoliceBadge] <= 0 && PlayerInfo[playerid][pJobLevel] >= 1)
			{
				payday = floatround(payday*0.5);
			}
		}
	}
	new	taxes_vehicle,
		taxes_houses,
		taxes_business,
		taxes_rent,
		string[1012];

	// procentai i biudzeta savivaldybes
	new taxes = GetGVarInt("TaxesToCity", SERVER_VARS_ID);
	new pay_to_city = payday*taxes/100;

	// savivaldybes procentai i policija

	// ================================================================
	// MOKESCIAI UZ TRANSPORTO PRIEMONES
	mysql_format(chandler, string, sizeof string, "SELECT Model FROM `vehicles_data` WHERE Owner = '%d'", PlayerInfo[playerid][pId]);
	new Cache:result = mysql_query(chandler, string, true);
	for(new i = 0, rows = cache_num_rows(); i < rows; i++)
	{
		cache_get_value_name_int(0, "Model", taxes_business);
		taxes_vehicle += ((GetGVarInt("VehicleTaxes", SERVER_VARS_ID)/2)*VehicleClassLevel[taxes_business-400]);
	}
	cache_delete(result);
	// ================================================================

	// ================================================================
	// MOKESCIAI UZ VERSLUS
	mysql_format(chandler, string, sizeof string, "SELECT NULL FROM `business_data` WHERE Owner = '%d'", PlayerInfo[playerid][pId]);
	result = mysql_query(chandler, string, true);
	taxes_business = GetGVarInt("BusinessTaxes", SERVER_VARS_ID)*cache_num_rows();
	if(PlayerInfo[playerid][pDonator] >= DONATOR_GOLD) taxes_business = floatround(taxes_business * 0.8);
	cache_delete(result);
	// ================================================================

	// MOKESCIAI UZ NAMUS
	// ================================================================
	mysql_format(chandler, string, sizeof string, "SELECT NULL FROM `houses_data` WHERE Owner = '%d'", PlayerInfo[playerid][pId]);
	result = mysql_query(chandler, string, true);
	taxes_houses = GetGVarInt("HouseTaxes", SERVER_VARS_ID)*cache_num_rows();
	cache_delete(result);
	// ================================================================

	// NUOMA
	mysql_format(chandler, string, sizeof string, "SELECT HouseId FROM `houses_dubkeys` WHERE PlayerId = '%d' AND Valid = '1' AND Type = '1'", PlayerInfo[playerid][pId]);
	result = mysql_query(chandler, string, true);
	new houseid;
	cache_get_value_name_int(0, "HouseId", houseid);
	if((houseid = FindHouseBySql(houseid)) != INVALID_HOUSE_ID)
	{
		taxes_rent = HouseInfo[houseid][hRentPrice];
		if(HouseInfo[houseid][hUpdateSafe] > 0)
		{
			HouseInfo[houseid][hSafe] += taxes_rent;
		}
	}
	cache_delete(result);

	// VERSLU ALGA
	mysql_format(chandler, string, sizeof string, "SELECT business_data.id bdata_id, business_data.Name bdata_name, business_dubkeys.Salary bdub_salary FROM `business_data` INNER JOIN `business_dubkeys` ON business_data.id = business_dubkeys.BusinessId WHERE business_dubkeys.PlayerId = '%d' AND business_dubkeys.Salary > '0'", PlayerInfo[playerid][pId]);
	result = mysql_query(chandler, string, true);

	new	business_id,
		business_name[32],
		business_salary;
	for(new i = 0, rows = cache_num_rows(); i < rows; i++)
	{
		cache_get_value_name(i, "bdata_name", business_name);
		cache_get_value_name_int(i, "bdata_id", business_id);
		cache_get_value_name_int(i, "bdub_salary", business_salary);
		new businessid = FindBusinessBySql(business_id);
		if(businessid != INVALID_BUSINESS_ID)
		{
			if(business_salary > BusinessInfo[businessid][bBudget])
			{
				SendFormat(playerid, 0xF6F275FF, "Verslas {F6F04D}\"%s\"{F6F275} turëjo sumokëti Jums {F6F04D}$%d{F6F275} algà, taèiau biudþete nebëra pinigø.", business_name, business_salary);
				continue;
			}
			BusinessInfo[businessid][bBudget] -= business_salary;
			SaveBusinessIntEx(businessid, "Budget", BusinessInfo[businessid][bBudget]);
			payday_business += business_salary;	
		}
	}
	cache_delete(result);

	/* Savings Ceiling: */
	if(PlayerInfo[playerid][pSavings] >= MAX_SAVINGS)
	{
		new savingsTemp = PlayerInfo[playerid][pSavings];
		PlayerInfo[playerid][pSavings] = 0;
		PlayerInfo[playerid][pBank] += savingsTemp;
		SendWarning(playerid, "Jûs pasiekëte palûkanø maksimumà. Palûkanos iðimtos automatiðkai.");
	}

	// SAVINGS
	// ================================================================
	new savings = floatround(PlayerInfo[playerid][pSavings]/140);
	PlayerInfo[playerid][pSavings] += savings;
	// ================================================================
	
	SendFormat(playerid, 0x55E451ff, "———————————— MAZE BANK ————————————");
	SendFormat(playerid, 0x55E451ff, "| {F7F7F7}\
						Gauta alga: $%d, mokeðèiai valstybei: $%d", payday, pay_to_city);

	(taxes_vehicle > 0) && SendFormat(playerid, 0x55E451ff, "| {F7F7F7}\
						Transporto mokesèiai: $%d", taxes_vehicle);

	(taxes_houses > 0) && SendFormat(playerid, 0x55E451ff, "| {F7F7F7}\
						Nek. turto mokesèiai: $%d", taxes_houses);
	
	(taxes_business > 0) && SendFormat(playerid, 0x55E451ff, "| {F7F7F7}\
						Verslø mokesèiai: $%d", taxes_business);

	(taxes_rent > 0) && SendFormat(playerid, 0x55E451ff, "| {F7F7F7}\
						Nuomos mokestis: $%d", taxes_rent);
	
	(payday_business > 0) && SendFormat(playerid, 0x55E451ff, "| {F7F7F7}\
						Alga ið priv. verslø: $%d", payday_business);
	
	(savings > 0) && SendFormat(playerid, 0x55E451ff, "| {F7F7F7}\
						Gautos palûkanos: $%d", savings);

	// format(string, sizeof string, "_~n~__Gauta_alga:_$%d,_mokesciai_valstybei:_$%d~n~", payday, pay_to_city);
	// if(taxes_vehicle > 0) format(string, sizeof string, "%s__Mokesciai uz tr. priemones:_$%d~n~", string, taxes_vehicle);
	// if(taxes_houses > 0) format(string, sizeof string, "%s__Mokesciai_uz_nek._turta:_$%d~n~", string, taxes_houses);
	// if(taxes_business > 0) format(string, sizeof string, "%s__Mokesciai uz verslus:_$%d~n~", string, taxes_business);
	// if(taxes_rent > 0) format(string, sizeof string, "%s__Nuomos_mokestis:_$%d~n~", string, taxes_rent);
	// if(payday_business > 0) format(string, sizeof string, "%s__Alga_is_privaciu_verslu:_$%d~n~", string, payday_business);
	// if(savings > 0) format(string, sizeof string, "%s__Gautos_palukanos:_$%d~n~", string, savings);


	payday -= (taxes_vehicle + taxes_houses + taxes_business + pay_to_city + taxes_rent); // galutines sumos skaiciavimas
	if(PlayerInfo[playerid][pJob] != 0)
	{
		playerjob = GetJobArrayIndexById(PlayerInfo[playerid][pJob]);
		if(playerjob != -1)
		{
			if(payday > Jobs[playerjob][jobMaxPayout]) payday = Jobs[playerjob][jobMaxPayout];
		}
	}
	payday += payday_business;
	PlayerInfo[playerid][pBank] += payday;
	// format(string, sizeof string, "%s__Galutine_gauta_suma:_$%d~n~__Banko_balansas:_$%d~n~_", string, payday, PlayerInfo[playerid][pBank]);
	SendFormat(playerid, 0x55E451ff, "| {FFFFFF}Galutinë gauta suma: $%d, balansas: $%d", payday, PlayerInfo[playerid][pBank]);

	SendFormat(playerid, 0x55E451ff, "——————————————————————————————");


	PlayerInfo[playerid][pPayCheck] = 0;

	// PRIDEDAM SAVIVALDYBEI PINIGU IR POLICIJAI
	new pd_taxes = GetGVarInt("TaxesToPolice", SERVER_VARS_ID);
	new pay_to_police = pay_to_city*pd_taxes/100;
	pay_to_city -= pay_to_police;

	foreach(new factionid : Faction)
	{
		if(FactionInfo[factionid][fType] == FACTION_TYPE_GOVERNMENT)
		{
			FactionInfo[factionid][fBudget] += pay_to_city;
		}
		if(FactionInfo[factionid][fType] == FACTION_TYPE_POLICE)
		{
			FactionInfo[factionid][fBudget] += pay_to_police;
		}
		if(FactionInfo[factionid][fType] == FACTION_TYPE_FIRE)
		{
			FactionInfo[factionid][fBudget] += 25;
		}
	}
	// ------------------------------------------
	PlayerInfo[playerid][pPayDayCollected] ++ ;
	if(PlayerInfo[playerid][pPayDayCollected] >= 2)
	{
		PlayerInfo[playerid][pPayDayCollected] = 0;
		AddPlayerJobXP(playerid, PlayerInfo[playerid][pJob], 1);
		PlayerInfo[playerid][pXP]++;
		PlayerInfo[playerid][pHoursPlayed]++;
		if(PlayerInfo[playerid][pXP] >= (PlayerInfo[playerid][pLevel] + 1)*4)
		{
			PlayerInfo[playerid][pLevel]++;
			PlayerInfo[playerid][pXP] = 0;
			SetPlayerScore(playerid, PlayerInfo[playerid][pLevel]);
			SendFormat(playerid, 0x88D4FFFF, "Sveikiname, pakilo jûsø veikëjo lygis (%d)!", PlayerInfo[playerid][pLevel]);
		}
		// narkotikai
		for(new i = 0; i < MAX_DRUG_TYPES; i++)
		{
			// jei nenaudojo reikalinga laika, viska resetinam
			if(PlayerDrugs[playerid][i][drugUnused] > 0)
			{
				PlayerDrugs[playerid][i][drugUnused]--;
				if(PlayerDrugs[playerid][i][drugUnused] <= 0)
				{
					if(PlayerDrugs[playerid][i][drugLevel] > 0) PlayerDrugs[playerid][i][drugLevel]--;
					if(PlayerDrugs[playerid][i][drugLevel] > 0)
					{
						PlayerDrugs[playerid][i][drugUnused] = DrugLevelDrop[i][PlayerDrugs[playerid][i][drugLevel]];
					}
				}
			}
		}
	}
	PlayerInfo[playerid][pPayDayTime] = 0;
	log_init(true);
	log_set_table("logs_money");
	log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`Amount`");
	log_set_values("'%d','%e','Gavo alga','%d'", LogPlayerId(playerid), LogPlayerName(playerid), payday);
	log_push();
	SaveAccount(playerid);
	return 1;
}

case DIALOG_BANK_DEPOSIT:
{
    if(response)
    {
        // padeti
        new amount;
        if(sscanf(inputtext,"d",amount)) return 0, ShowPlayerBank(playerid);
        if(0 < amount <= sd_GetPlayerMoney(playerid))
        {
            PlayerInfo[playerid][pBank] += amount;
            sd_GivePlayerMoney(playerid, -amount);
            MsgSuccess(playerid, "BANKAS", "Padëjote $%d á sàskaità.", amount);
            new string[126];
            mysql_format(chandler, string, sizeof string, "INSERT INTO `players_bank_history` (`PlayerId`,`String`,`Amount`) VALUES ('%d','pinigø padëjimas banke','%d')", PlayerInfo[playerid][pId], amount);
            mysql_fquery(chandler, string, "BankLogAdd");
            log_init(true);
            log_set_table("logs_money");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`Amount`");
            log_set_values("'%d','%e','Padejo i saskaita','%d'", LogPlayerId(playerid), LogPlayerName(playerid), amount);
            log_push();
        }
    }
    ShowPlayerBank(playerid);
}
case DIALOG_BANK_WITHDRAW:
{
    if(response)
    {
        new amount;
        if(sscanf(inputtext,"d",amount)) return 0 , ShowPlayerBank(playerid);
        if(0 < amount <= PlayerInfo[playerid][pBank])
        {
            PlayerInfo[playerid][pBank] -= amount;
            sd_GivePlayerMoney(playerid, amount);
            MsgSuccess(playerid, "BANKAS", "Nusiëmëte $%d ið sàskaitos.", amount);
            new string[126];
            mysql_format(chandler, string, sizeof string, "INSERT INTO `players_bank_history` (`PlayerId`,`String`,`Amount`) VALUES ('%d','pinigø nuëmimas banke','%d')", PlayerInfo[playerid][pId], amount);
            mysql_fquery(chandler, string, "BankLogAdd");
            log_init(true);
            log_set_table("logs_money");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`Amount`");
            log_set_values("'%d','%e','Paeme is saskaitos','%d'", LogPlayerId(playerid), LogPlayerName(playerid), amount);
            log_push();
        }
    }
    ShowPlayerBank(playerid);
}
case DIALOG_BANK_SAVINGS:
{
    if(response)
    {
        new amount;
        if(sscanf(inputtext,"d",amount)) return 0, ShowPlayerBank(playerid);
        if(1000 < amount <= 100000)
        {
            if(amount > PlayerInfo[playerid][pBank])
            {
                MsgWarning(playerid, "BANKAS", "Neturite tiek pinigø banko sàskaitoje.");
            }
            else
            {
                PlayerInfo[playerid][pSavings] = amount;
                PlayerInfo[playerid][pBank] -= amount;
                SaveAccountIntEx(playerid, "Bank", PlayerInfo[playerid][pBank]);
                SaveAccountIntEx(playerid, "Savings", amount);
                new string[126];
                mysql_format(chandler, string, sizeof string, "INSERT INTO `players_bank_history` (`PlayerId`,`String`,`Amount`) VALUES ('%d','indëlio padëjimas','%d')", PlayerInfo[playerid][pId], amount);
                mysql_fquery(chandler, string, "BankLogAdd");
                MsgSuccess(playerid, "BANKAS", "Pinigai padëti á indëlá.");
                log_init(true);
                log_set_table("logs_money");
                log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`Amount`");
                log_set_values("'%d','%e','Padejo indeli','%d'", LogPlayerId(playerid), LogPlayerName(playerid), amount);
                log_push();
            }
        }
        else
        {
            MsgWarning(playerid, "BANKAS", "Minimali suma 1000$, maksimali 100000$");
        }
    }
    ShowPlayerBank(playerid);
}
case DIALOG_BANK_MAIN:
{
    if(response)
    {
        switch(listitem)
        {
            case 0:
            {
                // likutis
                if(PlayerInfo[playerid][pBankCard] <= 0)
                {
                    // susikurti rodem jam
                    if(sd_GetPlayerMoney(playerid) < DEFAULT_BANK_CARD_PRICE) return InfoBox(playerid, IB_NOT_ENOUGH_MONEY, DEFAULT_BANK_CARD_PRICE);
                    else
                    {
                        MsgSuccess(playerid, "BANKAS", "Ásigijote banko kortelæ. Jûsø sàskaitos numeris: "#DEFAULT_IBAN_PREFIX"%d", GetPlayerIBAN(PlayerInfo[playerid][pId]));
                        PlayerInfo[playerid][pBankCard] = 1;
                        SaveAccountIntEx(playerid, "BankCard", 1);
                        sd_GivePlayerMoney(playerid, -DEFAULT_BANK_CARD_PRICE);
                        ShowPlayerBank(playerid);
                    }
                }
                else
                {
                    ShowPlayerBank(playerid);
                }
            }
            case 1:
            {
                // inesti
                /*if(PlayerInfo[playerid][pSavings] > 0)
                {
                    MsgError(playerid, "BANKAS", "Jûs kaupiate pinigus indelyje, todël banku negalite naudotis.");
                    return ShowPlayerBank(playerid);
                }*/
                ShowPlayerDialog(playerid, DIALOG_BANK_DEPOSIT, DIALOG_STYLE_INPUT, "Bankas", "{FFFFFF}Áveskite sumà pinigø, kurià norite áneðti á savo banko sàskaità.", "Tæsti", "Atðaukti");
            }
            case 2:
            {
                // paimti
                /*if(PlayerInfo[playerid][pSavings] > 0)
                {
                    MsgError(playerid, "BANKAS", "Jûs kaupiate pinigus indelyje, todël banku negalite naudotis.");
                    return ShowPlayerBank(playerid);
                }*/
                ShowPlayerDialog(playerid, DIALOG_BANK_WITHDRAW, DIALOG_STYLE_INPUT, "Bankas", "{FFFFFF}Áveskite sumà pinigø, kurià norite nuimti ið savo banko sàskaitos.", "Tæsti", "Atðaukti");
            }
            case 3:
            {
                // savings
                ShowPlayerBank(playerid);
            }
            case 4:
            {
                // savings padeti
                if(PlayerInfo[playerid][pSavings] > 0)
                {
                    // nutraukti
                    PlayerInfo[playerid][pBank] += PlayerInfo[playerid][pSavings];
                    SaveAccountIntEx(playerid, "Bank", PlayerInfo[playerid][pBank]);
                    SaveAccountIntEx(playerid, "Savings", 0);
                    MsgSuccess(playerid, "BANKAS", "Pinigai pervesti á jûsø sàskaità.");
                    new string[126];
                    mysql_format(chandler, string, sizeof string, "INSERT INTO `players_bank_history` (`PlayerId`,`String`,`Amount`) VALUES ('%d','indëlio nutraukimas','%d')", PlayerInfo[playerid][pId], PlayerInfo[playerid][pSavings]);
                    mysql_fquery(chandler, string, "BankLogAdd");
                    log_init(true);
                    log_set_table("logs_money");
                    log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`Amount`");
                    log_set_values("'%d','%e','Nusieme indeli','%d'", LogPlayerId(playerid), LogPlayerName(playerid), PlayerInfo[playerid][pSavings]);
                    log_push();
                    PlayerInfo[playerid][pSavings] = 0;
                    ShowPlayerBank(playerid);
                }
                else
                {
                    // padeti savings
                    ShowPlayerDialog(playerid, DIALOG_BANK_SAVINGS, DIALOG_STYLE_INPUT, "Bankas", "{FFFFFF}Áveskite sumà, kurià norite padëti indëliui.\n{EEEEEE}Kiekvienà valandiná atlyginimà gausite iðmokas ið banko, kurios\nbus pridedamos prie jûsø pradinës sumos. Iðmokø dydis kiekvienà kartà\nskaièiuojamas nuo naujos sumos.\nPadëjus pinigus á indëlá, banko sàskaita naudotis negalima.\nSutartá bet kada galima nutraukti", "Tæsti", "Atðaukti");
                }
            }
            case 5:
            {
                // istorija
                ShowPlayerDialog(playerid, DIALOG_BANK_HISTORY, DIALOG_STYLE_MSGBOX, "Banko iðklotinë", "{BABABA}Praðome palaukti, duomenys kraunami.", "Uþdaryti", "");
                SetTimerEx("BankHistoryTimer", 3000, false, "d", playerid);
            }
            case 6:
            {
                // pervedimai
                if(GetGVarInt("EnabledTransactions", SERVER_VARS_ID) >= 1)
                {
                    /*if(PlayerInfo[playerid][pSavings] > 0)
                    {
                        MsgError(playerid, "BANKAS", "Jûs kaupiate pinigus indelyje, todël banku negalite naudotis.");
                        return ShowPlayerBank(playerid);
                    }*/
                    ShowPlayerDialog(playerid, DIALOG_BANK_TRANSACTION_NAME, DIALOG_STYLE_INPUT, "Bankas", "{FFFFFF}Áveskite sàskaità, á kurià norite pervesti pinigø.", "Tæsti", "Atðaukti");
                }
                else SendWarning(playerid, "Sistema iðjungta.") , ShowPlayerBank(playerid);
            }
        }
    }
}
case DIALOG_BANK_TRANSACTION_NAME:
{
    if(response)
    {
        if(!strlen(inputtext)) ShowPlayerBank(playerid);
        new iban[24];
        foreach(new receiverid : Player)
        {
            if(PlayerInfo[playerid][pBankCard] > 0)
            {
                format(iban, 24, ""#DEFAULT_IBAN_PREFIX"%d", GetPlayerIBAN(PlayerInfo[receiverid][pId]));
                if(isequal(iban, inputtext))
                {
                    // radom
                    new string[256];
                    format(string, sizeof string, "{FFFFFF}Áveskite sumà, kurià norite pervesti á sàskaità {FF672B}%s", inputtext);
                    tmpSelected[playerid] = receiverid;
                    ShowPlayerDialog(playerid, DIALOG_BANK_TRANSACTION_AMOUNT, DIALOG_STYLE_INPUT, "Bankas", string, "Pervesti", "Atðaukti");
                    return 1;
                }
            }
        }
        MsgWarning(playerid, "BANKAS", "Tokios sàskaitos nëra, arba á jà dabar negalima pervesti pinigø.");
        ShowPlayerBank(playerid);
    }
    else ShowPlayerBank(playerid);
}
case DIALOG_BANK_TRANSACTION_AMOUNT:
{
    if(response)
    {
        new amount;
        if(sscanf(inputtext,"d",amount)) return ShowPlayerBank(playerid);
        if(0 < amount < 500000)
        {
            if(amount > PlayerInfo[playerid][pBank])
            {
                MsgError(playerid, "BANKAS", "Neturite tiek pinigø banko sàskaitoje.");
                return ShowPlayerBank(playerid);
            }
            new receiverid = tmpSelected[playerid],
                string[356];

            if(IsPlayerConnected(receiverid))
            {
                if(PlayerInfo[playerid][pLevel] < 2 || PlayerInfo[receiverid][pLevel] < 2) return SendWarning(playerid, "Lygis nëra 2");
                SendFormat(receiverid, 0x65BA36FF, "______________________ BANKAS ______________________");
                SendFormat(receiverid, 0x65BA36FF, "|");
                SendFormat(receiverid, 0x65BA36FF, "| {E5E5E5}Gavote pervedimà ið sàskaitos {C4F1AB}["#DEFAULT_IBAN_PREFIX"%d, %s]", GetPlayerIBAN(PlayerInfo[playerid][pId]), GetPlayerNameEx(playerid, true, true));
                SendFormat(receiverid, 0x65BA36FF, "| {E5E5E5}Suma: {C4F1AB}$%d", amount);
                SendFormat(receiverid, 0x65BA36FF, "|___________________________________________________");
                mysql_format(chandler, string, sizeof string, "INSERT INTO `players_bank_history` (`PlayerId`,`String`,`Amount`) VALUES ('%d','pervedimas ið ["#DEFAULT_IBAN_PREFIX"%d,%s]','%d')", PlayerInfo[receiverid][pId], GetPlayerIBAN(PlayerInfo[playerid][pId]), GetPlayerNameEx(playerid), amount);
                mysql_fquery(chandler, string, "BankLogAdd");
                PlayerInfo[receiverid][pBank] += amount;
                SaveAccountIntEx(receiverid, "Bank", PlayerInfo[receiverid][pBank]);


                SendFormat(playerid, 0x65BA36FF, "______________________ BANKAS ______________________");
                SendFormat(playerid, 0x65BA36FF, "|");
                SendFormat(playerid, 0x65BA36FF, "| {E5E5E5}Pervedëte pinigus á sàskaità {C4F1AB}["#DEFAULT_IBAN_PREFIX"%d, %s]", GetPlayerIBAN(PlayerInfo[receiverid][pId]), GetPlayerNameEx(receiverid, true, true));
                SendFormat(playerid, 0x65BA36FF, "| {E5E5E5}Suma: {C4F1AB}$%d", amount);
                SendFormat(playerid, 0x65BA36FF, "|___________________________________________________");
                mysql_format(chandler, string, sizeof string, "INSERT INTO `players_bank_history` (`PlayerId`,`String`,`Amount`) VALUES ('%d','pervedimas á ["#DEFAULT_IBAN_PREFIX"%d,%s]','%d')", PlayerInfo[playerid][pId], GetPlayerIBAN(PlayerInfo[receiverid][pId]), GetPlayerNameEx(receiverid), amount);
                mysql_fquery(chandler, string, "BankLogAdd");
                PlayerInfo[playerid][pBank] -= amount;
                SaveAccountIntEx(playerid, "Bank", PlayerInfo[playerid][pBank]);
                ShowPlayerBank(playerid);
                log_init(true);
                log_set_table("logs_money");
                log_set_keys("`PlayerId`,`PlayerName`,`ExtraId`,`ExtraString`,`ActionText`,`Amount`");
                log_set_values("'%d','%e','%d','%e','Pervede pinigus','%d'", LogPlayerId(playerid), LogPlayerName(playerid), LogPlayerId(receiverid), LogPlayerName(receiverid), amount);
                log_push();
            }
        }
        else
        {
            MsgWarning(playerid, "BANKAS", "Suma turi bûti nuo 1$ iki 500000$");
        }
    }
    else ShowPlayerBank(playerid);
}
case DIALOG_ATM_DEPOSIT:
{
    if(response)
    {
        // padeti
        new amount;
        if(sscanf(inputtext,"d",amount)) return 0;
        if(0 < amount <= sd_GetPlayerMoney(playerid))
        {
            PlayerInfo[playerid][pBank] += amount;
            sd_GivePlayerMoney(playerid, -amount);
            MsgSuccess(playerid, "BANKOMATAS", "Padëjote $%d á sàskaità.", amount);
            log_init(true);
            log_set_table("logs_money");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`Amount`");
            log_set_values("'%d','%e','Padejo i saskaita','%d'", LogPlayerId(playerid), LogPlayerName(playerid), amount);
            log_push();
        }
    }
}
case DIALOG_ATM_WITHDRAW:
{
    if(response)
    {
        new amount,
            selected = tmpSelected[playerid];
        if(sscanf(inputtext,"d",amount)) return 0;
        if(ATMs[selected][atmWithdrawLimit] != 0 && amount > ATMs[selected][atmWithdrawLimit]) return MsgWarning(playerid, "BANKOMATAS", "Nuëmimo limitas: $%d", ATMs[selected][atmWithdrawLimit]);
        if(0 < amount <= PlayerInfo[playerid][pBank])
        {
            PlayerInfo[playerid][pBank] -= amount;
            sd_GivePlayerMoney(playerid, amount);
            MsgSuccess(playerid, "BANKOMATAS", "Nusiëmëte $%d ið sàskaitos.", amount);
            log_init(true);
            log_set_table("logs_money");
            log_set_keys("`PlayerId`,`PlayerName`,`ActionText`,`Amount`");
            log_set_values("'%d','%e','Nusieme is saskaitos','%d'", LogPlayerId(playerid), LogPlayerName(playerid), amount);
            log_push();
        }
    }
}




























if(clickedid == ATM_Action[0])
		{
			// likutis
			new string[256];
			format(string, sizeof string, "{FFFFFF}Jûsø sàskaitoje dabar yra:\n{%s}$%d\n ", PlayerInfo[playerid][pBank] == 0 ? ("FCA800") : (PlayerInfo[playerid][pBank] > 0 ? ("37A51F") : ("B72323")), PlayerInfo[playerid][pBank]);
			ShowPlayerDialog(playerid, DIALOG_ATM_MONEY, DIALOG_STYLE_MSGBOX, "Bankomatas", string, "Gráþti", "");
		}
		if(clickedid == ATM_Action[1])
		{
			// nusiimti
			//if(PlayerInfo[playerid][pSavings] > 0)
			//{
			//	MsgError(playerid, "BANKAS", "Jûs kaupiate pinigus indelyje, todël banku negalite naudotis.");
			//	return 1;
			//}
			ShowPlayerDialog(playerid, DIALOG_ATM_WITHDRAW, DIALOG_STYLE_INPUT, "Bankomatas", "{FFFFFF}Áveskite sumà pinigø, kurià norite pasiimti ið saskaitos.", "Nusiimti", "Atðaukti");
		}
		if(clickedid == ATM_Action[2])
		{
			// padeti
			//if(PlayerInfo[playerid][pSavings] > 0)
			//{
			//	MsgError(playerid, "BANKAS", "Jûs kaupiate pinigus indelyje, todël banku negalite naudotis.");
			//	return 1;
			//}
			new atmid = tmpSelected[playerid];
			if(ATMs[atmid][atmCanDeposit] == 1)
			{
				ShowPlayerDialog(playerid, DIALOG_ATM_DEPOSIT, DIALOG_STYLE_INPUT, "Bankomatas", "{FFFFFF}Áveskite sumà pinigø, kurià norite padëti á sàskaità.", "Padëti", "Atðaukti");
			}
		}
		if(clickedid == ATM_Action[3])
		{
			// baigti
			HidePlayerATM(playerid);
			CancelSelectTextDraw(playerid);
		}