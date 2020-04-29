/*
 *
 * SAN ANDREAS MULTIPLAYER MDC.PWN BY TOMAS TORKQ VOSYLIUS
 * ALL RIGHTS RESERVED
 * 2017
 *
 */

#include <YSI\y_hooks>

#define MAX_PAGES 					15
#define MAX_LOOKUP_ROWS 			10
#define MAX_WANTED_PER_PAGE 		7
#define MAX_WANTED_PER_PAGE_SELECT 	8
#define MAX_RECORDS_PER_PAGE 		15

#define DEFAULT_BUTTON_BOX_X 	154.000000000000
#define DEFAULT_BUTTON_BOX_Y  	140.000000000000

#define DEFAULT_BUTTON_TEXT_X 	184.000000000000
#define DEFAULT_BUTTON_TEXT_Y 	141.000000000000

#define DEFAULT_BASE_X 			153.000000000000 
#define DEFAULT_BASE_Y 			128.000000000000
#define DEFAULT_BASE_SIZE_X		490.000000000000 // actually end spot
#define DEFAULT_BASE_SIZE_Y		26.000000000000

#define DEFAULT_BUTTON_BOX_SIZE_X 	60.0000000
#define DEFAULT_BUTTON_BOX_SIZE_Y	10.0000000

#define MDC_TEXTDRAW_TYPE_GLOBAL 	1
#define MDC_TEXTDRAW_TYPE_PLAYER 	2

#define MDC_BUTTON_TYPE_MENU 		1

#define MDC_MAIN 			0
#define MDC_WANTED 			1
#define MDC_PLAYERS 		2
#define MDC_VEHICLES 		3
#define MDC_WEAPONS 		4
#define MDC_CCTV 			5
#define MDC_PRISON 			6
#define MDC_PLAYER_STATS 	7
#define MDC_VEHICLE_STATS 	8
#define MDC_WANTED_ADD 		9
#define MDC_WANTED_EDIT 	10
#define MDC_WEAPON_STATS 	11
#define MDC_PLAYER_RECORDS 	12
#define MDC_VEHICLE_RECORDS 13
#define MDC_WEAPON_RECORDS 	14

#define MDC_INPUT_NONE 				0
#define MDC_INPUT_PLAYER_LOOKUP 	1
#define MDC_INPUT_VEHICLE_LOOKUP 	2
#define MDC_INPUT_WANTED_NAME 		3
#define MDC_INPUT_WANTED_LOOKS 		4
#define MDC_INPUT_WANTED_SEEN		5
#define MDC_INPUT_WANTED_REASON 	6
#define MDC_INPUT_RECORD 			7
#define MDC_INPUT_WEAPON_LOOKUP 	8

#define MDC_FETCH_LIKE 		1
#define MDC_FETCH_EXACT 	2

#define MDC_Call(%0,%1) 		%0(%1) 
#define mdc_called%0\10;%1 		forward %0; \
								public %0			
#define printmdc(%0) 			printf("[mdc] "%0)


enum E_MDC_TEXTDRAW_DATA
{
	mdcButtonsCount,
};

enum E_MDC_BUTTON_DATA
{
	mdcButtonActionId,
	mdcButtonText[24],
	mdcButtonHeader[45],
	mdcButtonTextdrawType,
	mdcButtonType,
	Float:mdcButtonBoxX,
	Float:mdcButtonBoxY,
	Float:mdcButtonTextX,
	Float:mdcButtonTextY,
	bool:mdcButtonSelectable
};

new	MDC__Buttons_Data[MAX_PAGES][E_MDC_BUTTON_DATA],
	MDC__Textdraw_Data[E_MDC_TEXTDRAW_DATA];

enum E_MDC_PLAYER_DATA
{
	pMdcActivePage,
	pMdcInputId,
	pMdcInputText[126],
	pMdcLookupId,
	pMdcLookupName[24],
	pMdcWantedPage,
	pMdcWantedPlayers[MAX_WANTED_PER_PAGE],
	pMdcWantedSelected,
	// WANTED
	pMdcWantedName[24],
	pMdcWantedSeen[108],
	pMdcWantedReason[108],
	pMdcWantedLooks[108]
};

new MDC__Player_Data[MAX_PLAYERS][E_MDC_PLAYER_DATA];


new PlayerText:MDC_ButtonBox[MAX_PLAYERS][MAX_PAGES],
	PlayerText:MDC_ButtonText[MAX_PLAYERS][MAX_PAGES],
	PlayerText:MDC_HeaderText[MAX_PLAYERS],
	PlayerText:MDC_HeaderName[MAX_PLAYERS],
	PlayerText:MDC_Main_Skin[MAX_PLAYERS],
	PlayerText:MDC_Main_Stats[MAX_PLAYERS],
	PlayerText:MDC_Main_Name[MAX_PLAYERS],
	PlayerText:MDC_Main_HideSkin[MAX_PLAYERS],
	PlayerText:MDC_Lookup_SearchText[MAX_PLAYERS],
	PlayerText:MDC_Lookup_StatsRow[MAX_PLAYERS][MAX_LOOKUP_ROWS],
	PlayerText:MDC_Player_Skin[MAX_PLAYERS],
	PlayerText:MDC_Lookup_StatsKey[MAX_PLAYERS],
	PlayerText:MDC_Lookup_StatsValue[MAX_PLAYERS],
	PlayerText:MDC_Lookup_Action1[MAX_PLAYERS],
	PlayerText:MDC_Lookup_Action2[MAX_PLAYERS],
	PlayerText:MDC_Lookup_Action3[MAX_PLAYERS],
	PlayerText:MDC_Player_HideSkin[MAX_PLAYERS],
	PlayerText:MDC_Vehicle_Model[MAX_PLAYERS],
	PlayerText:MDC_Wanted_Name[MAX_PLAYERS][MAX_WANTED_PER_PAGE],
	PlayerText:MDC_Wanted_Reason[MAX_PLAYERS][MAX_WANTED_PER_PAGE],
	PlayerText:MDC_Wanted_Looks[MAX_PLAYERS][MAX_WANTED_PER_PAGE],
	PlayerText:MDC_Wanted_Seen[MAX_PLAYERS][MAX_WANTED_PER_PAGE],
	PlayerText:MDC_WantedAddEdit_Looks[MAX_PLAYERS],
	PlayerText:MDC_WantedAddEdit_Name[MAX_PLAYERS],
	PlayerText:MDC_WantedAddEdit_Reason[MAX_PLAYERS],
	PlayerText:MDC_WantedAddEdit_Seen[MAX_PLAYERS],
	PlayerText:MDC_Wanted_Next[MAX_PLAYERS],
	PlayerText:MDC_Wanted_Back[MAX_PLAYERS],
	PlayerText:MDC_WantedAddEdit_Action1[MAX_PLAYERS],
	PlayerText:MDC_WantedAddEdit_Action2[MAX_PLAYERS],
	PlayerText:MDC_Prison_CellStatus[MAX_PLAYERS][sizeof PrisonCells],
	PlayerText:MDC_Record_Name[MAX_PLAYERS][MAX_RECORDS_PER_PAGE],
	PlayerText:MDC_Record_Date[MAX_PLAYERS][MAX_RECORDS_PER_PAGE],
	PlayerText:MDC_Weapon_Model[MAX_PLAYERS];

new Text:MDC_HeaderBackground,
	Text:MDC_BackgroundMain,
	Text:MDC_Exit,
	Text:MDC_ExitX,
	Text:MDC_MenuSeparate,
	Text:MDC_Lookup_SearchBox,
	Text:MDC_Lookup_HideSearchBox,
	Text:MDC_Lookup_SearchBoxText,
	Text:MDC_Lookup_StatsBackground,
	Text:MDC_Lookup_AddCrimeBox,
	Text:MDC_Lookup_AddCrimeBoxText,
	Text:MDC_CCTV_Header,
	Text:MDC_CCTV_Camera[sizeof CCTV],
	Text:MDC_WantedAddEdit_Back,
	Text:MDC_WantedAddEdit_Background,
	Text:MDC_WantedAddEdit_Keys,
	Text:MDC_Wanted_Add,
	Text:MDC_Wanted_Key[4],
	Text:MDC_Prison_OpenAll,
	Text:MDC_Prison_CloseAll,
	Text:MDC_Prison_Alarm,
	Text:MDC_Record_Back;

/*
 * Hooks
 */

hook OnPlayerDisconnect(playerid)
{
	reset(MDC, MDC__Player_Data[playerid], E_MDC_PLAYER_DATA);
	return 1;
}

/*
 * Functions
 */

stock MDC_Prepare()
{
	MDC_AddMenuButton("Pagrindinis", MDC_MAIN, "Pagrindinis");
	MDC_AddMenuButton("Ieskomi", MDC_WANTED, "Ieskomi");
	MDC_AddMenuButton("Gyventojai", MDC_PLAYERS, "Gyventojai");
	MDC_AddMenuButton("Tr. priemones", MDC_VEHICLES, "Transporto priemones");
	MDC_AddMenuButton("Ginklai", MDC_WEAPONS, "Ginklai");
	MDC_AddMenuButton("CCTV", MDC_CCTV, "Miesto kameros");
	MDC_AddMenuButton("Kalejimas", MDC_PRISON, "Kalejimas");
	return 1;
}

stock MDC_Init()
{
	MDC_CreateTextdraws();
	return 1;
}

stock MDC_AddMenuButton(text[], action_id, header[] = "", td_type = MDC_TEXTDRAW_TYPE_PLAYER, bool:selectable = true)
{
	new cur = MDC__Textdraw_Data[mdcButtonsCount];
	if(cur + 1 > MAX_PAGES)
	{
		printmdc("[error] Increase MDC MAX_PAGES value");
		SendRconCommand("exit");
		return false;
	}
	else
	{
		format(MDC__Buttons_Data[cur][mdcButtonText], 24, text);
		format(MDC__Buttons_Data[cur][mdcButtonHeader], 45, strlen(header) > 0 ? (header) : (text));
		MDC__Buttons_Data[cur][mdcButtonSelectable] = selectable;
		MDC__Buttons_Data[cur][mdcButtonActionId] = action_id;

		MDC__Buttons_Data[cur][mdcButtonBoxX] = DEFAULT_BUTTON_BOX_X;
		MDC__Buttons_Data[cur][mdcButtonBoxY] = DEFAULT_BUTTON_BOX_Y + (cur * 12.000000000000);
		MDC__Buttons_Data[cur][mdcButtonTextX] = DEFAULT_BUTTON_TEXT_X;
		MDC__Buttons_Data[cur][mdcButtonTextY] = DEFAULT_BUTTON_TEXT_Y + (cur * 12.000000000000);

		MDC__Buttons_Data[cur][mdcButtonTextdrawType] = td_type;
		MDC__Buttons_Data[cur][mdcButtonType] = MDC_BUTTON_TYPE_MENU;
		MDC__Textdraw_Data[mdcButtonsCount]++; 
	}
	return true;
}

stock MDC_CreateTextdraws()
{
	MDC_BackgroundMain = TextDrawCreate(DEFAULT_BASE_X, DEFAULT_BASE_Y, "usebox");
	TextDrawLetterSize(MDC_BackgroundMain, 0.000000, DEFAULT_BASE_SIZE_Y);
	TextDrawTextSize(MDC_BackgroundMain, DEFAULT_BASE_SIZE_X, 0.000000);
	TextDrawAlignment(MDC_BackgroundMain, 1);
	TextDrawColor(MDC_BackgroundMain, -16897);
	TextDrawUseBox(MDC_BackgroundMain, 1);
	TextDrawBoxColor(MDC_BackgroundMain, 2105376255);
	TextDrawSetShadow(MDC_BackgroundMain, 0);
	TextDrawSetOutline(MDC_BackgroundMain, 0);
	TextDrawBackgroundColor(MDC_BackgroundMain, 255);
	TextDrawFont(MDC_BackgroundMain, 1);
	TextDrawSetProportional(MDC_BackgroundMain, 1);
	TextDrawSetShadow(MDC_BackgroundMain, 0);

	MDC_HeaderBackground = TextDrawCreate(DEFAULT_BASE_X + 1.5, DEFAULT_BASE_Y + 1.5, "melynasheader");
	TextDrawLetterSize(MDC_HeaderBackground, 0.000000, 0.785000);
	TextDrawTextSize(MDC_HeaderBackground, DEFAULT_BASE_SIZE_X - 1.5, 0.000000);
	TextDrawAlignment(MDC_HeaderBackground, 1);
	TextDrawColor(MDC_HeaderBackground, -1);
	TextDrawUseBox(MDC_HeaderBackground, 1);
	TextDrawBoxColor(MDC_HeaderBackground, 1788415);
	TextDrawSetShadow(MDC_HeaderBackground, 0);
	TextDrawSetOutline(MDC_HeaderBackground, 0);
	TextDrawBackgroundColor(MDC_HeaderBackground, 255);
	TextDrawFont(MDC_HeaderBackground, 1);
	TextDrawSetProportional(MDC_HeaderBackground, 1);
	TextDrawSetShadow(MDC_HeaderBackground, 0);

	MDC_Exit = TextDrawCreate(DEFAULT_BASE_SIZE_X - 8.2, DEFAULT_BASE_Y + 1.4, "LD_SPAC:white");
	TextDrawLetterSize(MDC_Exit, 0.000000, 0.000000);
	TextDrawTextSize(MDC_Exit, 7.500000, 7.600000);
	TextDrawAlignment(MDC_Exit, 1);
	TextDrawColor(MDC_Exit, -1644166913);
	TextDrawSetShadow(MDC_Exit, 0);
	TextDrawSetOutline(MDC_Exit, 0);
	TextDrawBackgroundColor(MDC_Exit, 255);
	TextDrawFont(MDC_Exit, 4);
	TextDrawSetProportional(MDC_Exit, 0);
	TextDrawSetShadow(MDC_Exit, 0);
	TextDrawSetSelectable(MDC_Exit, true);

	MDC_ExitX = TextDrawCreate(483.604675, 130.793380, "X");
	TextDrawLetterSize(MDC_ExitX, 0.120428, 0.553200);
	TextDrawAlignment(MDC_ExitX, 1);
	TextDrawColor(MDC_ExitX, 0x551A1AFF);
	TextDrawSetShadow(MDC_ExitX, 0);
	TextDrawSetOutline(MDC_ExitX, 0);
	TextDrawBackgroundColor(MDC_ExitX, 255);
	TextDrawFont(MDC_ExitX, 2);
	TextDrawSetProportional(MDC_ExitX, 1);
	TextDrawSetShadow(MDC_ExitX, 0);

	MDC_MenuSeparate = TextDrawCreate(DEFAULT_BASE_X + DEFAULT_BUTTON_BOX_SIZE_X + 4.50000, DEFAULT_BUTTON_BOX_Y + 3.0, "menu atskiria");
	TextDrawLetterSize(MDC_MenuSeparate, 0.000000, 11.5);
	TextDrawTextSize(MDC_MenuSeparate, DEFAULT_BASE_X + DEFAULT_BUTTON_BOX_SIZE_X + 2.500000, 0.000000);
	TextDrawAlignment(MDC_MenuSeparate, 1);
	TextDrawColor(MDC_MenuSeparate, -156);
	TextDrawUseBox(MDC_MenuSeparate, 1);
	TextDrawBoxColor(MDC_MenuSeparate, 15);
	TextDrawSetShadow(MDC_MenuSeparate, 0);
	TextDrawSetOutline(MDC_MenuSeparate, 0);
	TextDrawBackgroundColor(MDC_MenuSeparate, 255);
	TextDrawFont(MDC_MenuSeparate, 1);
	TextDrawSetProportional(MDC_MenuSeparate, 1);
	TextDrawSetShadow(MDC_MenuSeparate, 0);

	MDC_Lookup_SearchBox = TextDrawCreate(421.904785, 143.679962, "LD_OTB2:butnA");
	TextDrawLetterSize(MDC_Lookup_SearchBox, 0.000000, 0.000000);
	TextDrawTextSize(MDC_Lookup_SearchBox, 63.000000, 13.000000);
	TextDrawAlignment(MDC_Lookup_SearchBox, 1);
	TextDrawColor(MDC_Lookup_SearchBox, -1);
	TextDrawSetShadow(MDC_Lookup_SearchBox, 0);
	TextDrawSetOutline(MDC_Lookup_SearchBox, 0);
	TextDrawBackgroundColor(MDC_Lookup_SearchBox, 255);
	TextDrawFont(MDC_Lookup_SearchBox, 4);
	TextDrawSetProportional(MDC_Lookup_SearchBox, 0);
	TextDrawSetShadow(MDC_Lookup_SearchBox, 0);
	TextDrawSetSelectable(MDC_Lookup_SearchBox, true);

	MDC_Lookup_HideSearchBox = TextDrawCreate(421.142730, 155.153289, "mainbg");
	TextDrawLetterSize(MDC_Lookup_HideSearchBox, 0.000000, 5.619040);
	TextDrawTextSize(MDC_Lookup_HideSearchBox, 487.000000, 0.000000);
	TextDrawAlignment(MDC_Lookup_HideSearchBox, 1);
	TextDrawColor(MDC_Lookup_HideSearchBox, -16897);
	TextDrawUseBox(MDC_Lookup_HideSearchBox, 1);
	TextDrawBoxColor(MDC_Lookup_HideSearchBox, 2105376255);
	TextDrawSetShadow(MDC_Lookup_HideSearchBox, 0);
	TextDrawSetOutline(MDC_Lookup_HideSearchBox, 0);
	TextDrawBackgroundColor(MDC_Lookup_HideSearchBox, 255);
	TextDrawFont(MDC_Lookup_HideSearchBox, 1);
	TextDrawSetProportional(MDC_Lookup_HideSearchBox, 1);
	TextDrawSetShadow(MDC_Lookup_HideSearchBox, 0);

	MDC_Lookup_SearchBoxText = TextDrawCreate(452.894989, 144.173416, "IESKOTI");
	TextDrawLetterSize(MDC_Lookup_SearchBoxText, 0.148570, 0.874665);
	TextDrawAlignment(MDC_Lookup_SearchBoxText, 2);
	TextDrawColor(MDC_Lookup_SearchBoxText, 154);
	TextDrawSetShadow(MDC_Lookup_SearchBoxText, 0);
	TextDrawSetOutline(MDC_Lookup_SearchBoxText, 0);
	TextDrawBackgroundColor(MDC_Lookup_SearchBoxText, 255);
	TextDrawFont(MDC_Lookup_SearchBoxText, 2);
	TextDrawSetProportional(MDC_Lookup_SearchBoxText, 1);
	TextDrawSetShadow(MDC_Lookup_SearchBoxText, 0);

	MDC_Lookup_StatsBackground = TextDrawCreate(222.000000, 170.899993, "box");
	TextDrawLetterSize(MDC_Lookup_StatsBackground, 0.000000, 19.257143);
	TextDrawTextSize(MDC_Lookup_StatsBackground, 485.000000, 0.000000);
	TextDrawAlignment(MDC_Lookup_StatsBackground, 1);
	TextDrawColor(MDC_Lookup_StatsBackground, -1);
	TextDrawUseBox(MDC_Lookup_StatsBackground, 1);
	TextDrawBoxColor(MDC_Lookup_StatsBackground, 56);
	TextDrawSetShadow(MDC_Lookup_StatsBackground, 0);
	TextDrawSetOutline(MDC_Lookup_StatsBackground, 0);
	TextDrawBackgroundColor(MDC_Lookup_StatsBackground, 255);
	TextDrawFont(MDC_Lookup_StatsBackground, 1);
	TextDrawSetProportional(MDC_Lookup_StatsBackground, 1);
	TextDrawSetShadow(MDC_Lookup_StatsBackground, 0);

	MDC_Lookup_AddCrimeBox = TextDrawCreate(406.199951, 349.400024, "LD_OTB2:butna");
	TextDrawLetterSize(MDC_Lookup_AddCrimeBox, 0.000000, 0.000000);
	TextDrawTextSize(MDC_Lookup_AddCrimeBox, 81.000000, 12.490011);
	TextDrawAlignment(MDC_Lookup_AddCrimeBox, 1);
	TextDrawColor(MDC_Lookup_AddCrimeBox, -1);
	TextDrawSetShadow(MDC_Lookup_AddCrimeBox, 0);
	TextDrawSetOutline(MDC_Lookup_AddCrimeBox, 0);
	TextDrawBackgroundColor(MDC_Lookup_AddCrimeBox, 255);
	TextDrawFont(MDC_Lookup_AddCrimeBox, 4);
	TextDrawSetProportional(MDC_Lookup_AddCrimeBox, 0);
	TextDrawSetShadow(MDC_Lookup_AddCrimeBox, 0);

	MDC_Lookup_AddCrimeBoxText = TextDrawCreate(448.000000, 349.799987, "PRIDETI_IRASA");
	TextDrawLetterSize(MDC_Lookup_AddCrimeBoxText, 0.148570, 0.874665);
	TextDrawAlignment(MDC_Lookup_AddCrimeBoxText, 2);
	TextDrawColor(MDC_Lookup_AddCrimeBoxText, 154);
	TextDrawSetShadow(MDC_Lookup_AddCrimeBoxText, 0);
	TextDrawSetOutline(MDC_Lookup_AddCrimeBoxText, 0);
	TextDrawBackgroundColor(MDC_Lookup_AddCrimeBoxText, 255);
	TextDrawFont(MDC_Lookup_AddCrimeBoxText, 2);
	TextDrawSetProportional(MDC_Lookup_AddCrimeBoxText, 1);
	TextDrawSetShadow(MDC_Lookup_AddCrimeBoxText, 0);

	MDC_CCTV_Header = TextDrawCreate(220.285690, 141.913314, "_Pasirinkite_kamera:");
	TextDrawLetterSize(MDC_CCTV_Header, 0.209904, 1.028267);
	TextDrawTextSize(MDC_CCTV_Header, 487.000000, 0.000000);
	TextDrawAlignment(MDC_CCTV_Header, 1);
	TextDrawColor(MDC_CCTV_Header, -1);
	TextDrawUseBox(MDC_CCTV_Header, 1);
	TextDrawBoxColor(MDC_CCTV_Header, 166);
	TextDrawSetShadow(MDC_CCTV_Header, 0);
	TextDrawSetOutline(MDC_CCTV_Header, 0);
	TextDrawBackgroundColor(MDC_CCTV_Header, 255);
	TextDrawFont(MDC_CCTV_Header, 1);
	TextDrawSetProportional(MDC_CCTV_Header, 1);
	TextDrawSetShadow(MDC_CCTV_Header, 0);

	MDC_WantedAddEdit_Keys = TextDrawCreate(311.000000, 145.000000, "VARDAS,_PAVARDE:~n~~n~APIBUDINIMAS:~n~~n~~n~IESKOMAS_UZ:_~n~~n~~n~PASKUTINI_KARTA_MATYTAS:");
	TextDrawLetterSize(MDC_WantedAddEdit_Keys, 0.132952, 0.947200);
	TextDrawAlignment(MDC_WantedAddEdit_Keys, 3);
	TextDrawColor(MDC_WantedAddEdit_Keys, 606348543);
	TextDrawSetShadow(MDC_WantedAddEdit_Keys, 0);
	TextDrawSetOutline(MDC_WantedAddEdit_Keys, 0);
	TextDrawBackgroundColor(MDC_WantedAddEdit_Keys, 255);
	TextDrawFont(MDC_WantedAddEdit_Keys, 2);
	TextDrawSetProportional(MDC_WantedAddEdit_Keys, 1);
	TextDrawSetShadow(MDC_WantedAddEdit_Keys, 0);

	MDC_WantedAddEdit_Back = TextDrawCreate(434.000000, 235.000000, "< GRIZTI");
	TextDrawLetterSize(MDC_WantedAddEdit_Back, 0.139809, 0.814933);
	TextDrawTextSize(MDC_WantedAddEdit_Back, 485.000000, 8.000000);
	TextDrawAlignment(MDC_WantedAddEdit_Back, 1);
	TextDrawColor(MDC_WantedAddEdit_Back, -1);
	TextDrawUseBox(MDC_WantedAddEdit_Back, 1);
	TextDrawBoxColor(MDC_WantedAddEdit_Back, 606348543);
	TextDrawSetShadow(MDC_WantedAddEdit_Back, 0);
	TextDrawSetOutline(MDC_WantedAddEdit_Back, 0);
	TextDrawBackgroundColor(MDC_WantedAddEdit_Back, 255);
	TextDrawFont(MDC_WantedAddEdit_Back, 2);
	TextDrawSetProportional(MDC_WantedAddEdit_Back, 1);
	TextDrawSetShadow(MDC_WantedAddEdit_Back, 0);
	TextDrawSetSelectable(MDC_WantedAddEdit_Back, true);

	MDC_WantedAddEdit_Background = TextDrawCreate(154.000000, 140.000000, "LD_SPAC:white");
	TextDrawLetterSize(MDC_WantedAddEdit_Background, 0.000000, 0.000000);
	TextDrawTextSize(MDC_WantedAddEdit_Background, 60.000000, 10.000000);
	TextDrawAlignment(MDC_WantedAddEdit_Background, 1);
	TextDrawColor(MDC_WantedAddEdit_Background, 1010580608);
	TextDrawSetShadow(MDC_WantedAddEdit_Background, 0);
	TextDrawSetOutline(MDC_WantedAddEdit_Background, 0);
	TextDrawBackgroundColor(MDC_WantedAddEdit_Background, 255);
	TextDrawFont(MDC_WantedAddEdit_Background, 4);
	TextDrawSetProportional(MDC_WantedAddEdit_Background, 0);
	TextDrawSetShadow(MDC_WantedAddEdit_Background, 0);
	TextDrawSetSelectable(MDC_WantedAddEdit_Background, true);

	MDC_Wanted_Add = TextDrawCreate(222.000000, 349.000000, "+ PRIDETI IESKOMA ASMENI");
	TextDrawLetterSize(MDC_Wanted_Add, 0.152381, 0.840533);
	TextDrawTextSize(MDC_Wanted_Add, 413.460449, 9.000000);
	TextDrawAlignment(MDC_Wanted_Add, 1);
	TextDrawColor(MDC_Wanted_Add, -1);
	TextDrawUseBox(MDC_Wanted_Add, 1);
	TextDrawBoxColor(MDC_Wanted_Add, -609943297);
	TextDrawSetShadow(MDC_Wanted_Add, 0);
	TextDrawSetOutline(MDC_Wanted_Add, 0);
	TextDrawBackgroundColor(MDC_Wanted_Add, 255);
	TextDrawFont(MDC_Wanted_Add, 2);
	TextDrawSetProportional(MDC_Wanted_Add, 1);
	TextDrawSetShadow(MDC_Wanted_Add, 0);
	TextDrawSetSelectable(MDC_Wanted_Add, true);

	MDC_Wanted_Key[0] = TextDrawCreate(221.000000, 141.999938, "_____VARDAS_PAVARDE");
	TextDrawLetterSize(MDC_Wanted_Key[0], 0.130666, 0.887466);
	TextDrawTextSize(MDC_Wanted_Key[0], 486.000000, 0.000000);
	TextDrawAlignment(MDC_Wanted_Key[0], 1);
	TextDrawColor(MDC_Wanted_Key[0], 336860415);
	TextDrawUseBox(MDC_Wanted_Key[0], 1);
	TextDrawBoxColor(MDC_Wanted_Key[0], -721420155);
	TextDrawSetShadow(MDC_Wanted_Key[0], 0);
	TextDrawSetOutline(MDC_Wanted_Key[0], 0);
	TextDrawBackgroundColor(MDC_Wanted_Key[0], 255);
	TextDrawFont(MDC_Wanted_Key[0], 2);
	TextDrawSetProportional(MDC_Wanted_Key[0], 1);
	TextDrawSetShadow(MDC_Wanted_Key[0], 0);

	MDC_Wanted_Key[1] = TextDrawCreate(305.000000, 142.100006, "IESKOMAS_UZ");
	TextDrawLetterSize(MDC_Wanted_Key[1], 0.130666, 0.887466);
	TextDrawAlignment(MDC_Wanted_Key[1], 1);
	TextDrawColor(MDC_Wanted_Key[1], 336860671);
	TextDrawSetShadow(MDC_Wanted_Key[1], 0);
	TextDrawSetOutline(MDC_Wanted_Key[1], 0);
	TextDrawBackgroundColor(MDC_Wanted_Key[1], 255);
	TextDrawFont(MDC_Wanted_Key[1], 2);
	TextDrawSetProportional(MDC_Wanted_Key[1], 1);
	TextDrawSetShadow(MDC_Wanted_Key[1], 0);

	MDC_Wanted_Key[2] = TextDrawCreate(383.200012, 142.100067, "APIBUDINIMAS");
	TextDrawLetterSize(MDC_Wanted_Key[2], 0.130666, 0.887466);
	TextDrawAlignment(MDC_Wanted_Key[2], 1);
	TextDrawColor(MDC_Wanted_Key[2], 336860415);
	TextDrawSetShadow(MDC_Wanted_Key[2], 0);
	TextDrawSetOutline(MDC_Wanted_Key[2], 0);
	TextDrawBackgroundColor(MDC_Wanted_Key[2], 255);
	TextDrawFont(MDC_Wanted_Key[2], 2);
	TextDrawSetProportional(MDC_Wanted_Key[2], 1);
	TextDrawSetShadow(MDC_Wanted_Key[2], 0);

	MDC_Wanted_Key[3] = TextDrawCreate(448.499847, 141.900054, "PASK._K._MAT.");
	TextDrawLetterSize(MDC_Wanted_Key[3], 0.130666, 0.887466);
	TextDrawAlignment(MDC_Wanted_Key[3], 1);
	TextDrawColor(MDC_Wanted_Key[3], 336860415);
	TextDrawSetShadow(MDC_Wanted_Key[3], 0);
	TextDrawSetOutline(MDC_Wanted_Key[3], 0);
	TextDrawBackgroundColor(MDC_Wanted_Key[3], 255);
	TextDrawFont(MDC_Wanted_Key[3], 2);
	TextDrawSetProportional(MDC_Wanted_Key[3], 1);
	TextDrawSetShadow(MDC_Wanted_Key[3], 0);

	new
		Float:cctv_p_x,
		Float:cctv_p_y = 155.87,
		Float:cctv_s_x,
		Float:cctv_s_y = 5.0,
		cctv_added_to_current_row = 0,
		cctv_current_row = 0,
		cctv_temp;


	for(new c = 0; c < sizeof CCTV; c++)
	{
		if(cctv_added_to_current_row >= 2)
		{
			cctv_added_to_current_row = 0;
			cctv_current_row++;
			cctv_p_y += 12.5;
		}
		cctv_added_to_current_row++;
		cctv_temp = c+1;

		if(cctv_temp % 2 != 0)
		{
			cctv_p_x = 220.285675;
			cctv_s_x = 350.0;
		}
		else
		{
			cctv_p_x = 354.642791;
			cctv_s_x = 487.0;
		}

		MDC_CCTV_Camera[c] = TextDrawCreate(cctv_p_x, cctv_p_y, CCTV[c][cctvName]);
		TextDrawLetterSize(MDC_CCTV_Camera[c], 0.134857, 0.836266);
		TextDrawTextSize(MDC_CCTV_Camera[c], cctv_s_x, cctv_s_y);
		TextDrawAlignment(MDC_CCTV_Camera[c], 1);
		TextDrawColor(MDC_CCTV_Camera[c], -1);
		TextDrawUseBox(MDC_CCTV_Camera[c], 1);
		TextDrawBoxColor(MDC_CCTV_Camera[c], 103);
		TextDrawSetShadow(MDC_CCTV_Camera[c], 0);
		TextDrawSetOutline(MDC_CCTV_Camera[c], 0);
		TextDrawBackgroundColor(MDC_CCTV_Camera[c], 255);
		TextDrawFont(MDC_CCTV_Camera[c], 2);
		TextDrawSetProportional(MDC_CCTV_Camera[c], 1);
		TextDrawSetShadow(MDC_CCTV_Camera[c], 0);
		TextDrawSetSelectable(MDC_CCTV_Camera[c], true);
	}

	MDC_Prison_CloseAll = TextDrawCreate(225.237930, 349.999877, "CLOSE_ALL");
	TextDrawLetterSize(MDC_Prison_CloseAll, 0.169523, 0.964266);
	TextDrawTextSize(MDC_Prison_CloseAll, 264.000000, 9.000000);
	TextDrawAlignment(MDC_Prison_CloseAll, 1);
	TextDrawColor(MDC_Prison_CloseAll, 9699583);
	TextDrawUseBox(MDC_Prison_CloseAll, 1);
	TextDrawBoxColor(MDC_Prison_CloseAll, 505290495);
	TextDrawSetShadow(MDC_Prison_CloseAll, 0);
	TextDrawSetOutline(MDC_Prison_CloseAll, 0);
	TextDrawBackgroundColor(MDC_Prison_CloseAll, 255);
	TextDrawFont(MDC_Prison_CloseAll, 2);
	TextDrawSetProportional(MDC_Prison_CloseAll, 1);
	TextDrawSetShadow(MDC_Prison_CloseAll, 0);
	TextDrawSetSelectable(MDC_Prison_CloseAll, true);

	MDC_Prison_OpenAll = TextDrawCreate(268.285522, 349.999877, "OPEN_ALL");
	TextDrawLetterSize(MDC_Prison_OpenAll, 0.169523, 0.964266);
	TextDrawTextSize(MDC_Prison_OpenAll, 310.000000, 9.000000);
	TextDrawAlignment(MDC_Prison_OpenAll, 1);
	TextDrawColor(MDC_Prison_OpenAll, -1124073217);
	TextDrawUseBox(MDC_Prison_OpenAll, 1);
	TextDrawBoxColor(MDC_Prison_OpenAll, 505290495);
	TextDrawSetShadow(MDC_Prison_OpenAll, 0);
	TextDrawSetOutline(MDC_Prison_OpenAll, 0);
	TextDrawBackgroundColor(MDC_Prison_OpenAll, 255);
	TextDrawFont(MDC_Prison_OpenAll, 2);
	TextDrawSetProportional(MDC_Prison_OpenAll, 1);
	TextDrawSetShadow(MDC_Prison_OpenAll, 0);
	TextDrawSetSelectable(MDC_Prison_OpenAll, true);

	MDC_Prison_Alarm = TextDrawCreate(314.299743, 349.999877, "ALARM");
	TextDrawLetterSize(MDC_Prison_Alarm, 0.169523, 0.964266);
	TextDrawTextSize(MDC_Prison_Alarm, 360.300018, 9.000000);
	TextDrawAlignment(MDC_Prison_Alarm, 1);
	TextDrawColor(MDC_Prison_Alarm, -104136449);
	TextDrawUseBox(MDC_Prison_Alarm, 1);
	TextDrawBoxColor(MDC_Prison_Alarm, 505290495);
	TextDrawSetShadow(MDC_Prison_Alarm, 0);
	TextDrawSetOutline(MDC_Prison_Alarm, 0);
	TextDrawBackgroundColor(MDC_Prison_Alarm, 255);
	TextDrawFont(MDC_Prison_Alarm, 2);
	TextDrawSetProportional(MDC_Prison_Alarm, 1);
	TextDrawSetShadow(MDC_Prison_Alarm, 0);
	TextDrawSetSelectable(MDC_Prison_Alarm, true);

	MDC_Record_Back = TextDrawCreate(454.766784, 348.719970, " < GRIZTI");
	TextDrawLetterSize(MDC_Record_Back, 0.152381, 0.840533);
	TextDrawTextSize(MDC_Record_Back, 486.000000, 9.000000);
	TextDrawAlignment(MDC_Record_Back, 1);
	TextDrawColor(MDC_Record_Back, -1);
	TextDrawUseBox(MDC_Record_Back, 1);
	TextDrawBoxColor(MDC_Record_Back, 757935615);
	TextDrawSetShadow(MDC_Record_Back, 0);
	TextDrawSetOutline(MDC_Record_Back, 0);
	TextDrawBackgroundColor(MDC_Record_Back, 255);
	TextDrawFont(MDC_Record_Back, 2);
	TextDrawSetProportional(MDC_Record_Back, 1);
	TextDrawSetShadow(MDC_Record_Back, 0);
	TextDrawSetSelectable(MDC_Record_Back, true);
	return 1;
}

stock MDC_CreatePlayerTextdraws(playerid)
{
	for(new td = 0, limit = MDC__Textdraw_Data[mdcButtonsCount]; td < limit; td++)
	{
		if(MDC__Buttons_Data[td][mdcButtonType] == MDC_BUTTON_TYPE_MENU && MDC__Buttons_Data[td][mdcButtonTextdrawType] == MDC_TEXTDRAW_TYPE_PLAYER)
		{
			MDC_ButtonBox[playerid][td] = CreatePlayerTextDraw(playerid, MDC__Buttons_Data[td][mdcButtonBoxX], MDC__Buttons_Data[td][mdcButtonBoxY], "LD_SPAC:white");
			PlayerTextDrawLetterSize(playerid, MDC_ButtonBox[playerid][td], 0.000000, 0.000000);
			PlayerTextDrawTextSize(playerid, MDC_ButtonBox[playerid][td], DEFAULT_BUTTON_BOX_SIZE_X, DEFAULT_BUTTON_BOX_SIZE_Y);
			PlayerTextDrawAlignment(playerid, MDC_ButtonBox[playerid][td], 1);
			PlayerTextDrawColor(playerid, MDC_ButtonBox[playerid][td], -1515870721);
			PlayerTextDrawSetShadow(playerid, MDC_ButtonBox[playerid][td], 0);
			PlayerTextDrawSetOutline(playerid, MDC_ButtonBox[playerid][td], 0);
			PlayerTextDrawBackgroundColor(playerid, MDC_ButtonBox[playerid][td], 255);
			PlayerTextDrawFont(playerid, MDC_ButtonBox[playerid][td], 4);
			PlayerTextDrawSetProportional(playerid, MDC_ButtonBox[playerid][td], 0);
			PlayerTextDrawSetShadow(playerid, MDC_ButtonBox[playerid][td], 0);
			PlayerTextDrawSetSelectable(playerid, MDC_ButtonBox[playerid][td], MDC__Buttons_Data[td][mdcButtonSelectable]);

			MDC_ButtonText[playerid][td] = CreatePlayerTextDraw(playerid, MDC__Buttons_Data[td][mdcButtonTextX], MDC__Buttons_Data[td][mdcButtonTextY], MDC__Buttons_Data[td][mdcButtonText]);
			PlayerTextDrawLetterSize(playerid, MDC_ButtonText[playerid][td], 0.129904, 0.823466);
			PlayerTextDrawAlignment(playerid, MDC_ButtonText[playerid][td], 2);
			PlayerTextDrawColor(playerid, MDC_ButtonText[playerid][td], 1061109759);
			PlayerTextDrawSetShadow(playerid, MDC_ButtonText[playerid][td], 0);
			PlayerTextDrawSetOutline(playerid, MDC_ButtonText[playerid][td], 0);
			PlayerTextDrawBackgroundColor(playerid, MDC_ButtonText[playerid][td], 255);
			PlayerTextDrawFont(playerid, MDC_ButtonText[playerid][td], 2);
			PlayerTextDrawSetProportional(playerid, MDC_ButtonText[playerid][td], 1);
			PlayerTextDrawSetShadow(playerid, MDC_ButtonText[playerid][td], 0);
		}
	}
	MDC_HeaderText[playerid] = CreatePlayerTextDraw(playerid, DEFAULT_BASE_X + 1.250000, DEFAULT_BASE_Y + 0.250000, "Los_Santos_Police_Department");
	PlayerTextDrawLetterSize(playerid, MDC_HeaderText[playerid], 0.213952, 0.916133);
	PlayerTextDrawAlignment(playerid, MDC_HeaderText[playerid], 1);
	PlayerTextDrawColor(playerid, MDC_HeaderText[playerid], -1);
	PlayerTextDrawSetShadow(playerid, MDC_HeaderText[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDC_HeaderText[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_HeaderText[playerid], 255);
	PlayerTextDrawFont(playerid, MDC_HeaderText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDC_HeaderText[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDC_HeaderText[playerid], 0);

	MDC_HeaderName[playerid] = CreatePlayerTextDraw(playerid, DEFAULT_BASE_SIZE_X - 10.0, 128.686630, "Developer_Tomas");
	PlayerTextDrawLetterSize(playerid, MDC_HeaderName[playerid], 0.211428, 0.917333);
	PlayerTextDrawAlignment(playerid, MDC_HeaderName[playerid], 3);
	PlayerTextDrawColor(playerid, MDC_HeaderName[playerid], -155);
	PlayerTextDrawSetShadow(playerid, MDC_HeaderName[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDC_HeaderName[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_HeaderName[playerid], 255);
	PlayerTextDrawFont(playerid, MDC_HeaderName[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDC_HeaderName[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDC_HeaderName[playerid], 0);

	MDC_Main_Skin[playerid] = CreatePlayerTextDraw(playerid, 250.904708, 149.453338, "");
	PlayerTextDrawLetterSize(playerid, MDC_Main_Skin[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_Main_Skin[playerid], 200.000000, 147.000000);
	PlayerTextDrawAlignment(playerid, MDC_Main_Skin[playerid], 1);
	PlayerTextDrawColor(playerid, MDC_Main_Skin[playerid], -1);
	PlayerTextDrawSetShadow(playerid, MDC_Main_Skin[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Main_Skin[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_Main_Skin[playerid], 0);
	PlayerTextDrawFont(playerid, MDC_Main_Skin[playerid], 5);
	PlayerTextDrawSetProportional(playerid, MDC_Main_Skin[playerid], 0);
	PlayerTextDrawSetShadow(playerid, MDC_Main_Skin[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, MDC_Main_Skin[playerid], 301);
	PlayerTextDrawSetPreviewRot(playerid, MDC_Main_Skin[playerid], -10.000000, 0.000000, -5.000000, 0.899999);

	MDC_Main_HideSkin[playerid] = CreatePlayerTextDraw(playerid, DEFAULT_BASE_X + DEFAULT_BUTTON_BOX_SIZE_X + 10.000, 197.973327, "mainbg");
	PlayerTextDrawLetterSize(playerid, MDC_Main_HideSkin[playerid], 0.000000, 17.733327);
	PlayerTextDrawTextSize(playerid, MDC_Main_HideSkin[playerid], 466.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDC_Main_HideSkin[playerid], 1);
	PlayerTextDrawColor(playerid, MDC_Main_HideSkin[playerid], -16897);
	PlayerTextDrawUseBox(playerid, MDC_Main_HideSkin[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDC_Main_HideSkin[playerid], 2105376255);
	PlayerTextDrawSetShadow(playerid, MDC_Main_HideSkin[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Main_HideSkin[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_Main_HideSkin[playerid], 255);
	PlayerTextDrawFont(playerid, MDC_Main_HideSkin[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Main_HideSkin[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Main_HideSkin[playerid], 0);

	MDC_Main_Name[playerid] = CreatePlayerTextDraw(playerid, 354.380920, 197.806640, "Kadetas_Austin_Chadwick");
	PlayerTextDrawLetterSize(playerid, MDC_Main_Name[playerid], 0.231618, 1.070933);
	PlayerTextDrawTextSize(playerid, MDC_Main_Name[playerid], 0.000000, 262.000000);
	PlayerTextDrawAlignment(playerid, MDC_Main_Name[playerid], 2);
	PlayerTextDrawColor(playerid, MDC_Main_Name[playerid], 164);
	PlayerTextDrawUseBox(playerid, MDC_Main_Name[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDC_Main_Name[playerid], 35);
	PlayerTextDrawSetShadow(playerid, MDC_Main_Name[playerid], 1);
	PlayerTextDrawSetOutline(playerid, MDC_Main_Name[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_Main_Name[playerid], 10);
	PlayerTextDrawFont(playerid, MDC_Main_Name[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Main_Name[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Main_Name[playerid], 1);

	MDC_Main_Stats[playerid] = CreatePlayerTextDraw(playerid, 223.333297, 213.466644, "~w~PAREIGUNAI_TARNYBOJE:_2~n~~n~STATISTIKA PER PASKUTINE VALANDA:~n~-_~r~0_~w~GAUTU_SKAMBUCIU~n~-_~r~2~w~_ARESTUOTI_AUTOMOBILIAI");
	PlayerTextDrawLetterSize(playerid, MDC_Main_Stats[playerid], 0.148190, 0.930133);
	PlayerTextDrawAlignment(playerid, MDC_Main_Stats[playerid], 1);
	PlayerTextDrawColor(playerid, MDC_Main_Stats[playerid], -1);
	PlayerTextDrawSetShadow(playerid, MDC_Main_Stats[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Main_Stats[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_Main_Stats[playerid], 255);
	PlayerTextDrawFont(playerid, MDC_Main_Stats[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDC_Main_Stats[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Main_Stats[playerid], 0);

	MDC_Lookup_SearchText[playerid] = CreatePlayerTextDraw(playerid, 222.000000, 145.000000, "IVESKITE_PAIESKOS_TEKSTA...");
	PlayerTextDrawLetterSize(playerid, MDC_Lookup_SearchText[playerid], 0.131428, 0.802133);
	PlayerTextDrawTextSize(playerid, MDC_Lookup_SearchText[playerid], 414.000000, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_Lookup_SearchText[playerid], 1);
	PlayerTextDrawColor(playerid, MDC_Lookup_SearchText[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDC_Lookup_SearchText[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDC_Lookup_SearchText[playerid], 110);
	PlayerTextDrawSetShadow(playerid, MDC_Lookup_SearchText[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Lookup_SearchText[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_Lookup_SearchText[playerid], 255);
	PlayerTextDrawFont(playerid, MDC_Lookup_SearchText[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDC_Lookup_SearchText[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Lookup_SearchText[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_Lookup_SearchText[playerid], true);

	for(new i = 0; i < MAX_LOOKUP_ROWS; i++)
	{
		MDC_Lookup_StatsRow[playerid][i] = CreatePlayerTextDraw(playerid, 224.095245, 185.50000 + (i * 12.5), "2016.02.12_23:00_iskaita_uz_\"Pareiguno_uzpuolimas\",_bauda:_1300$");
		PlayerTextDrawLetterSize(playerid, MDC_Lookup_StatsRow[playerid][i], 0.149711, 0.832000);
		PlayerTextDrawTextSize(playerid, MDC_Lookup_StatsRow[playerid][i], 483.000000, 0.869997);
		PlayerTextDrawAlignment(playerid, MDC_Lookup_StatsRow[playerid][i], 1);
		PlayerTextDrawColor(playerid, MDC_Lookup_StatsRow[playerid][i], -1);
		PlayerTextDrawUseBox(playerid, MDC_Lookup_StatsRow[playerid][i], 1);
		PlayerTextDrawBoxColor(playerid, MDC_Lookup_StatsRow[playerid][i], -7602126);
		PlayerTextDrawSetShadow(playerid, MDC_Lookup_StatsRow[playerid][i], 0);
		PlayerTextDrawSetOutline(playerid, MDC_Lookup_StatsRow[playerid][i], 0);
		PlayerTextDrawBackgroundColor(playerid, MDC_Lookup_StatsRow[playerid][i], 255);
		PlayerTextDrawFont(playerid, MDC_Lookup_StatsRow[playerid][i], 2);
		PlayerTextDrawSetProportional(playerid, MDC_Lookup_StatsRow[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, MDC_Lookup_StatsRow[playerid][i], 0);
		PlayerTextDrawSetSelectable(playerid, MDC_Lookup_StatsRow[playerid][i], true);
	}

	MDC_Player_Skin[playerid] = CreatePlayerTextDraw(playerid, 151.476272, 158.840042, "");
	PlayerTextDrawLetterSize(playerid, MDC_Player_Skin[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_Player_Skin[playerid], 204.000000, 179.000000);
	PlayerTextDrawAlignment(playerid, MDC_Player_Skin[playerid], 1);
	PlayerTextDrawColor(playerid, MDC_Player_Skin[playerid], -1);
	PlayerTextDrawSetShadow(playerid, MDC_Player_Skin[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Player_Skin[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_Player_Skin[playerid], 0);
	PlayerTextDrawFont(playerid, MDC_Player_Skin[playerid], 5);
	PlayerTextDrawSetProportional(playerid, MDC_Player_Skin[playerid], 0);
	PlayerTextDrawSetShadow(playerid, MDC_Player_Skin[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, MDC_Player_Skin[playerid], 275);
	PlayerTextDrawSetPreviewRot(playerid, MDC_Player_Skin[playerid], -15.000000, 0.000000, 0.000000, 0.899999);

	MDC_Lookup_StatsKey[playerid] = CreatePlayerTextDraw(playerid, 290.761901, 158.853363, "VARDAS:~n~TEL._NUMERIS:~n~NUSIKALTIMAI:~n~LICENCIJOS:~n~TURTAS:");
	PlayerTextDrawLetterSize(playerid, MDC_Lookup_StatsKey[playerid], 0.162666, 1.024000);
	PlayerTextDrawAlignment(playerid, MDC_Lookup_StatsKey[playerid], 1);
	PlayerTextDrawColor(playerid, MDC_Lookup_StatsKey[playerid], 842150655);
	PlayerTextDrawSetShadow(playerid, MDC_Lookup_StatsKey[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Lookup_StatsKey[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_Lookup_StatsKey[playerid], 255);
	PlayerTextDrawFont(playerid, MDC_Lookup_StatsKey[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDC_Lookup_StatsKey[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Lookup_StatsKey[playerid], 0);

	MDC_Lookup_StatsValue[playerid] = CreatePlayerTextDraw(playerid, 350.190399, 159.280029, "AUSTIN_CHADWICK~n~123456~n~4_ISKAITOS,_SEDEJES_3_KARTUS~n~GINKLO,_LEKTUVO,_AUTOMOBILIO~n~NERA_DEKLARUOTO_TURTO");
	PlayerTextDrawLetterSize(playerid, MDC_Lookup_StatsValue[playerid], 0.188952, 1.011199);
	PlayerTextDrawAlignment(playerid, MDC_Lookup_StatsValue[playerid], 1);
	PlayerTextDrawColor(playerid, MDC_Lookup_StatsValue[playerid], 63);
	PlayerTextDrawSetShadow(playerid, MDC_Lookup_StatsValue[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Lookup_StatsValue[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_Lookup_StatsValue[playerid], 255);
	PlayerTextDrawFont(playerid, MDC_Lookup_StatsValue[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Lookup_StatsValue[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Lookup_StatsValue[playerid], 0);

	MDC_Player_HideSkin[playerid] = CreatePlayerTextDraw(playerid, 223.952438, 207.359954, "mainbg");
	PlayerTextDrawLetterSize(playerid, MDC_Player_HideSkin[playerid], 0.000000, 15.714277);
	PlayerTextDrawTextSize(playerid, MDC_Player_HideSkin[playerid], 470.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, MDC_Player_HideSkin[playerid], 1);
	PlayerTextDrawColor(playerid, MDC_Player_HideSkin[playerid], -16897);
	PlayerTextDrawUseBox(playerid, MDC_Player_HideSkin[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDC_Player_HideSkin[playerid], 2105376255);
	PlayerTextDrawSetShadow(playerid, MDC_Player_HideSkin[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Player_HideSkin[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_Player_HideSkin[playerid], 255);
	PlayerTextDrawFont(playerid, MDC_Player_HideSkin[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDC_Player_HideSkin[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Player_HideSkin[playerid], 0);

	MDC_Lookup_Action1[playerid] = CreatePlayerTextDraw(playerid, 222.571426, 208.773330, "] PERZIURETI NUSIKALTIMU ISTORIJA");
	PlayerTextDrawLetterSize(playerid, MDC_Lookup_Action1[playerid], 0.140952, 0.806400);
	PlayerTextDrawTextSize(playerid, MDC_Lookup_Action1[playerid], 484.000000, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_Lookup_Action1[playerid], 1);
	PlayerTextDrawColor(playerid, MDC_Lookup_Action1[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDC_Lookup_Action1[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDC_Lookup_Action1[playerid], -979828481);
	PlayerTextDrawSetShadow(playerid, MDC_Lookup_Action1[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Lookup_Action1[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_Lookup_Action1[playerid], 255);
	PlayerTextDrawFont(playerid, MDC_Lookup_Action1[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDC_Lookup_Action1[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Lookup_Action1[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_Lookup_Action1[playerid], true);

	MDC_Lookup_Action2[playerid] = CreatePlayerTextDraw(playerid, 222.571426, 220.719985, "+ PRIDETI IRASA");
	PlayerTextDrawLetterSize(playerid, MDC_Lookup_Action2[playerid], 0.144380, 0.797866);
	PlayerTextDrawTextSize(playerid, MDC_Lookup_Action2[playerid], 484.000000, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_Lookup_Action2[playerid], 1);
	PlayerTextDrawColor(playerid, MDC_Lookup_Action2[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDC_Lookup_Action2[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDC_Lookup_Action2[playerid], 1263225855);
	PlayerTextDrawSetShadow(playerid, MDC_Lookup_Action2[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Lookup_Action2[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_Lookup_Action2[playerid], 255);
	PlayerTextDrawFont(playerid, MDC_Lookup_Action2[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDC_Lookup_Action2[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Lookup_Action2[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_Lookup_Action2[playerid], true);

	MDC_Lookup_Action3[playerid] = CreatePlayerTextDraw(playerid, 222.771423, 232.693313, "REGISTRUOTAS TURTAS");
	PlayerTextDrawLetterSize(playerid, MDC_Lookup_Action3[playerid], 0.144380, 0.797866);
	PlayerTextDrawTextSize(playerid, MDC_Lookup_Action3[playerid], 484.000000, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_Lookup_Action3[playerid], 1);
	PlayerTextDrawColor(playerid, MDC_Lookup_Action3[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDC_Lookup_Action3[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDC_Lookup_Action3[playerid], 1263225855);
	PlayerTextDrawSetShadow(playerid, MDC_Lookup_Action3[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Lookup_Action3[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_Lookup_Action3[playerid], 255);
	PlayerTextDrawFont(playerid, MDC_Lookup_Action3[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDC_Lookup_Action3[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Lookup_Action3[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_Lookup_Action3[playerid], true);

	MDC_Vehicle_Model[playerid] = CreatePlayerTextDraw(playerid, 212.809616, 135.373397, "");
	PlayerTextDrawLetterSize(playerid, MDC_Vehicle_Model[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_Vehicle_Model[playerid], 70.000000, 81.000000);
	PlayerTextDrawAlignment(playerid, MDC_Vehicle_Model[playerid], 1);
	PlayerTextDrawColor(playerid, MDC_Vehicle_Model[playerid], -1);
	PlayerTextDrawSetShadow(playerid, MDC_Vehicle_Model[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Vehicle_Model[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_Vehicle_Model[playerid], 0);
	PlayerTextDrawFont(playerid, MDC_Vehicle_Model[playerid], 5);
	PlayerTextDrawSetProportional(playerid, MDC_Vehicle_Model[playerid], 0);
	PlayerTextDrawSetShadow(playerid, MDC_Vehicle_Model[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, MDC_Vehicle_Model[playerid], 411);
	PlayerTextDrawSetPreviewRot(playerid, MDC_Vehicle_Model[playerid], -15.000000, 0.000000, 45.000000, 0.899999);
	PlayerTextDrawSetPreviewVehCol(playerid, MDC_Vehicle_Model[playerid], 1, 1);

	MDC_WantedAddEdit_Name[playerid] = CreatePlayerTextDraw(playerid, 318.000000, 146.000000, "Xavier_Burke");
	PlayerTextDrawLetterSize(playerid, MDC_WantedAddEdit_Name[playerid], 0.171428, 0.849066);
	PlayerTextDrawTextSize(playerid, MDC_WantedAddEdit_Name[playerid], 480.000000, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_WantedAddEdit_Name[playerid], 1);
	PlayerTextDrawColor(playerid, MDC_WantedAddEdit_Name[playerid], -328961);
	PlayerTextDrawUseBox(playerid, MDC_WantedAddEdit_Name[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDC_WantedAddEdit_Name[playerid], 1515870975);
	PlayerTextDrawSetShadow(playerid, MDC_WantedAddEdit_Name[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDC_WantedAddEdit_Name[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_WantedAddEdit_Name[playerid], 255);
	PlayerTextDrawFont(playerid, MDC_WantedAddEdit_Name[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDC_WantedAddEdit_Name[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDC_WantedAddEdit_Name[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_WantedAddEdit_Name[playerid], true);

	MDC_WantedAddEdit_Looks[playerid] = CreatePlayerTextDraw(playerid, 318.000000, 163.000000, "Baltaodis,_aosdkapodskaopdsaksdopakdspasodkpakosdas~n~asdasasdkopasdkopaopdka");
	PlayerTextDrawLetterSize(playerid, MDC_WantedAddEdit_Looks[playerid], 0.171428, 0.849066);
	PlayerTextDrawTextSize(playerid, MDC_WantedAddEdit_Looks[playerid], 480.000000, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_WantedAddEdit_Looks[playerid], 1);
	PlayerTextDrawColor(playerid, MDC_WantedAddEdit_Looks[playerid], -328961);
	PlayerTextDrawUseBox(playerid, MDC_WantedAddEdit_Looks[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDC_WantedAddEdit_Looks[playerid], 1515870975);
	PlayerTextDrawSetShadow(playerid, MDC_WantedAddEdit_Looks[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDC_WantedAddEdit_Looks[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_WantedAddEdit_Looks[playerid], 255);
	PlayerTextDrawFont(playerid, MDC_WantedAddEdit_Looks[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDC_WantedAddEdit_Looks[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDC_WantedAddEdit_Looks[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_WantedAddEdit_Looks[playerid], true);

	MDC_WantedAddEdit_Reason[playerid] = CreatePlayerTextDraw(playerid, 318.000000, 187.000000, "Nusikaltimas,_aapodskaopdsaksdopakdspasodkpakosdas~n~asdadkopsakdakopsdkopakopsdaopdspkoa");
	PlayerTextDrawLetterSize(playerid, MDC_WantedAddEdit_Reason[playerid], 0.171428, 0.849066);
	PlayerTextDrawTextSize(playerid, MDC_WantedAddEdit_Reason[playerid], 480.000000, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_WantedAddEdit_Reason[playerid], 1);
	PlayerTextDrawColor(playerid, MDC_WantedAddEdit_Reason[playerid], -328961);
	PlayerTextDrawUseBox(playerid, MDC_WantedAddEdit_Reason[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDC_WantedAddEdit_Reason[playerid], 1515870975);
	PlayerTextDrawSetShadow(playerid, MDC_WantedAddEdit_Reason[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDC_WantedAddEdit_Reason[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_WantedAddEdit_Reason[playerid], 255);
	PlayerTextDrawFont(playerid, MDC_WantedAddEdit_Reason[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDC_WantedAddEdit_Reason[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDC_WantedAddEdit_Reason[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_WantedAddEdit_Reason[playerid], true);

	MDC_WantedAddEdit_Seen[playerid] = CreatePlayerTextDraw(playerid, 318.000000, 213.600036, "2017.05.23_Los_Santos_Unity_Station_masinu_aiksteleje");
	PlayerTextDrawLetterSize(playerid, MDC_WantedAddEdit_Seen[playerid], 0.171428, 0.849066);
	PlayerTextDrawTextSize(playerid, MDC_WantedAddEdit_Seen[playerid], 480.000000, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_WantedAddEdit_Seen[playerid], 1);
	PlayerTextDrawColor(playerid, MDC_WantedAddEdit_Seen[playerid], -328961);
	PlayerTextDrawUseBox(playerid, MDC_WantedAddEdit_Seen[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDC_WantedAddEdit_Seen[playerid], 1515870975);
	PlayerTextDrawSetShadow(playerid, MDC_WantedAddEdit_Seen[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDC_WantedAddEdit_Seen[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_WantedAddEdit_Seen[playerid], 255);
	PlayerTextDrawFont(playerid, MDC_WantedAddEdit_Seen[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDC_WantedAddEdit_Seen[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDC_WantedAddEdit_Seen[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_WantedAddEdit_Seen[playerid], true);
	
	MDC_Wanted_Next[playerid] = CreatePlayerTextDraw(playerid, 454.766784, 348.719970, "TOLIAU >");
	PlayerTextDrawLetterSize(playerid, MDC_Wanted_Next[playerid], 0.152381, 0.840533);
	PlayerTextDrawTextSize(playerid, MDC_Wanted_Next[playerid], 486.000000, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_Wanted_Next[playerid], 1); 
	PlayerTextDrawColor(playerid, MDC_Wanted_Next[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDC_Wanted_Next[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDC_Wanted_Next[playerid], 757935615);
	PlayerTextDrawSetShadow(playerid, MDC_Wanted_Next[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Wanted_Next[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_Wanted_Next[playerid], 255);
	PlayerTextDrawFont(playerid, MDC_Wanted_Next[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDC_Wanted_Next[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Wanted_Next[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_Wanted_Next[playerid], true);

	MDC_Wanted_Back[playerid] = CreatePlayerTextDraw(playerid, 418.195404, 348.719970, " < GRIZTI");
	PlayerTextDrawLetterSize(playerid, MDC_Wanted_Back[playerid], 0.152381, 0.840533);
	PlayerTextDrawTextSize(playerid, MDC_Wanted_Back[playerid], 450.000000, 9.000000);
	PlayerTextDrawAlignment(playerid, MDC_Wanted_Back[playerid], 1);
	PlayerTextDrawColor(playerid, MDC_Wanted_Back[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDC_Wanted_Back[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDC_Wanted_Back[playerid], 757935615);
	PlayerTextDrawSetShadow(playerid, MDC_Wanted_Back[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Wanted_Back[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_Wanted_Back[playerid], 255);
	PlayerTextDrawFont(playerid, MDC_Wanted_Back[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDC_Wanted_Back[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDC_Wanted_Back[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_Wanted_Back[playerid], true);

	MDC_WantedAddEdit_Action1[playerid] = CreatePlayerTextDraw(playerid, 222.000000, 235.000000, "+_PRIDETI_I_SARASA");
	PlayerTextDrawLetterSize(playerid, MDC_WantedAddEdit_Action1[playerid], 0.139809, 0.814933);
	PlayerTextDrawTextSize(playerid, MDC_WantedAddEdit_Action1[playerid], 361.000000, 7.000000);
	PlayerTextDrawAlignment(playerid, MDC_WantedAddEdit_Action1[playerid], 1);
	PlayerTextDrawColor(playerid, MDC_WantedAddEdit_Action1[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDC_WantedAddEdit_Action1[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDC_WantedAddEdit_Action1[playerid], -777780993);
	PlayerTextDrawSetShadow(playerid, MDC_WantedAddEdit_Action1[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDC_WantedAddEdit_Action1[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_WantedAddEdit_Action1[playerid], 255);
	PlayerTextDrawFont(playerid, MDC_WantedAddEdit_Action1[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDC_WantedAddEdit_Action1[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDC_WantedAddEdit_Action1[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_WantedAddEdit_Action1[playerid], true);

	MDC_WantedAddEdit_Action2[playerid] = CreatePlayerTextDraw(playerid, 366.000000, 235.000000, "X_ISVALYTI");
	PlayerTextDrawLetterSize(playerid, MDC_WantedAddEdit_Action2[playerid], 0.139809, 0.814933);
	PlayerTextDrawTextSize(playerid, MDC_WantedAddEdit_Action2[playerid], 429.000000, 7.000000);
	PlayerTextDrawAlignment(playerid, MDC_WantedAddEdit_Action2[playerid], 1);
	PlayerTextDrawColor(playerid, MDC_WantedAddEdit_Action2[playerid], -1);
	PlayerTextDrawUseBox(playerid, MDC_WantedAddEdit_Action2[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MDC_WantedAddEdit_Action2[playerid], -1626734337);
	PlayerTextDrawSetShadow(playerid, MDC_WantedAddEdit_Action2[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDC_WantedAddEdit_Action2[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_WantedAddEdit_Action2[playerid], 255);
	PlayerTextDrawFont(playerid, MDC_WantedAddEdit_Action2[playerid], 2);
	PlayerTextDrawSetProportional(playerid, MDC_WantedAddEdit_Action2[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDC_WantedAddEdit_Action2[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_WantedAddEdit_Action2[playerid], true);

	for(new i = 0; i < MAX_WANTED_PER_PAGE; i++)
	{
		MDC_Wanted_Name[playerid][i] = CreatePlayerTextDraw(playerid, 221.000000, 155.000 + (i*27.0), "Xavier_Burke~n~~n~~n~");
		PlayerTextDrawLetterSize(playerid, MDC_Wanted_Name[playerid][i], 0.155047, 0.810666);
		PlayerTextDrawTextSize(playerid, MDC_Wanted_Name[playerid][i], 284.000000, 8.000000);
		PlayerTextDrawAlignment(playerid, MDC_Wanted_Name[playerid][i], 1);
		PlayerTextDrawColor(playerid, MDC_Wanted_Name[playerid][i], -1);
		PlayerTextDrawUseBox(playerid, MDC_Wanted_Name[playerid][i], 1);
		PlayerTextDrawBoxColor(playerid, MDC_Wanted_Name[playerid][i], 20223);
		PlayerTextDrawSetShadow(playerid, MDC_Wanted_Name[playerid][i], 0);
		PlayerTextDrawSetOutline(playerid, MDC_Wanted_Name[playerid][i], 0);
		PlayerTextDrawBackgroundColor(playerid, MDC_Wanted_Name[playerid][i], 255);
		PlayerTextDrawFont(playerid, MDC_Wanted_Name[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, MDC_Wanted_Name[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, MDC_Wanted_Name[playerid][i], 0);
		PlayerTextDrawSetSelectable(playerid, MDC_Wanted_Name[playerid][i], true);

		MDC_Wanted_Reason[playerid][i] = CreatePlayerTextDraw(playerid, 289.000000, 155.000 + (i*27.0), "Ginkluotas_apiplesimas,_par~n~eiguno_uzpuolimas,_nelegali~n~veikl...");
		PlayerTextDrawLetterSize(playerid, MDC_Wanted_Reason[playerid][i], 0.155047, 0.810666);
		PlayerTextDrawTextSize(playerid, MDC_Wanted_Reason[playerid][i], 360.000000, 0.000000);
		PlayerTextDrawAlignment(playerid, MDC_Wanted_Reason[playerid][i], 1);
		PlayerTextDrawColor(playerid, MDC_Wanted_Reason[playerid][i], -1);
		PlayerTextDrawUseBox(playerid, MDC_Wanted_Reason[playerid][i], 1);
		PlayerTextDrawBoxColor(playerid, MDC_Wanted_Reason[playerid][i], 20223);
		PlayerTextDrawSetShadow(playerid, MDC_Wanted_Reason[playerid][i], 0);
		PlayerTextDrawSetOutline(playerid, MDC_Wanted_Reason[playerid][i], 0);
		PlayerTextDrawBackgroundColor(playerid, MDC_Wanted_Reason[playerid][i], 255);
		PlayerTextDrawFont(playerid, MDC_Wanted_Reason[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, MDC_Wanted_Reason[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, MDC_Wanted_Reason[playerid][i], 0);

		MDC_Wanted_Looks[playerid][i] = CreatePlayerTextDraw(playerid, 364.699981, 155.000 + (i*27.0), "Baltaodis,_oasdkoasdoadopaa~n~asasdasd~n~~n~");
		PlayerTextDrawLetterSize(playerid, MDC_Wanted_Looks[playerid][i], 0.155047, 0.810666);
		PlayerTextDrawTextSize(playerid, MDC_Wanted_Looks[playerid][i], 438.699981, 0.000000);
		PlayerTextDrawAlignment(playerid, MDC_Wanted_Looks[playerid][i], 1);
		PlayerTextDrawColor(playerid, MDC_Wanted_Looks[playerid][i], -1);
		PlayerTextDrawUseBox(playerid, MDC_Wanted_Looks[playerid][i], 1);
		PlayerTextDrawBoxColor(playerid, MDC_Wanted_Looks[playerid][i], 20223);
		PlayerTextDrawSetShadow(playerid, MDC_Wanted_Looks[playerid][i], 0);
		PlayerTextDrawSetOutline(playerid, MDC_Wanted_Looks[playerid][i], 0);
		PlayerTextDrawBackgroundColor(playerid, MDC_Wanted_Looks[playerid][i], 255);
		PlayerTextDrawFont(playerid, MDC_Wanted_Looks[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, MDC_Wanted_Looks[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, MDC_Wanted_Looks[playerid][i], 0);

		MDC_Wanted_Seen[playerid][i] = CreatePlayerTextDraw(playerid, 443.500030, 155.000 + (i*27.0), "2017-05-23_Los_~n~Santos_Unity...~n~~n~");
		PlayerTextDrawLetterSize(playerid, MDC_Wanted_Seen[playerid][i], 0.155047, 0.810666);
		PlayerTextDrawTextSize(playerid, MDC_Wanted_Seen[playerid][i], 486.000000, 0.000000);
		PlayerTextDrawAlignment(playerid, MDC_Wanted_Seen[playerid][i], 1);
		PlayerTextDrawColor(playerid, MDC_Wanted_Seen[playerid][i], -1);
		PlayerTextDrawUseBox(playerid, MDC_Wanted_Seen[playerid][i], 1);
		PlayerTextDrawBoxColor(playerid, MDC_Wanted_Seen[playerid][i], 20223);
		PlayerTextDrawSetShadow(playerid, MDC_Wanted_Seen[playerid][i], 0);
		PlayerTextDrawSetOutline(playerid, MDC_Wanted_Seen[playerid][i], 0);
		PlayerTextDrawBackgroundColor(playerid, MDC_Wanted_Seen[playerid][i], 255);
		PlayerTextDrawFont(playerid, MDC_Wanted_Seen[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, MDC_Wanted_Seen[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, MDC_Wanted_Seen[playerid][i], 0);
	}

	new 
		Float:cell_p_x = 223.714263,
		Float:cell_p_y = 141.786682,
		Float:cell_s_x = 280.0,
		Float:cell_s_y = 9.0,
		cell_current_row = 0,
		cell_added_to_current_row,
		cell_string[22];
	for(new c = 0; c < sizeof PrisonCells; c++)
	{
		if(cell_added_to_current_row >= 14)
		{
			cell_added_to_current_row = 0;
			cell_current_row++;
			cell_p_y = 141.786682; // vel nuo virsaus
			cell_p_x += 62.0; // pastumiam i sona
			cell_s_x += 62.0;
		}
		if(c != 0 && c != 14 && c != 28 && c != 42) cell_p_y += 14.0;
		cell_added_to_current_row++;

		format(cell_string, 22, "%s%s %s", PrisonCells[c][cellDoorOpened] ? ("~r~") : ("~g~"), PrisonCells[c][cellName], PrisonCells[c][cellDoorOpened] ? ("OPENED") : ("CLOSED"));
		MDC_Prison_CellStatus[playerid][c] = CreatePlayerTextDraw(playerid, cell_p_x, cell_p_y, cell_string);
		PlayerTextDrawLetterSize(playerid, MDC_Prison_CellStatus[playerid][c], 0.169523, 0.964266);
		PlayerTextDrawTextSize(playerid, MDC_Prison_CellStatus[playerid][c], cell_s_x, cell_s_y);
		PlayerTextDrawAlignment(playerid, MDC_Prison_CellStatus[playerid][c], 1);
		PlayerTextDrawColor(playerid, MDC_Prison_CellStatus[playerid][c], 9699583);
		PlayerTextDrawUseBox(playerid, MDC_Prison_CellStatus[playerid][c], 1);
		PlayerTextDrawBoxColor(playerid, MDC_Prison_CellStatus[playerid][c], 336860415);
		PlayerTextDrawSetShadow(playerid, MDC_Prison_CellStatus[playerid][c], 0);
		PlayerTextDrawSetOutline(playerid, MDC_Prison_CellStatus[playerid][c], 0);
		PlayerTextDrawBackgroundColor(playerid, MDC_Prison_CellStatus[playerid][c], 255);
		PlayerTextDrawFont(playerid, MDC_Prison_CellStatus[playerid][c], 2);
		PlayerTextDrawSetProportional(playerid, MDC_Prison_CellStatus[playerid][c], 1);
		PlayerTextDrawSetShadow(playerid, MDC_Prison_CellStatus[playerid][c], 0);
		PlayerTextDrawSetSelectable(playerid, MDC_Prison_CellStatus[playerid][c], true);
	}

	new Float:record_p_y_1 = 141.78,
		Float:record_p_y_2 = 141.08;

	for(new i = 0; i < MAX_RECORDS_PER_PAGE; i++)
	{
		record_p_y_1 += 12.0,
		record_p_y_2 += 12.25;

		MDC_Record_Name[playerid][i] = CreatePlayerTextDraw(playerid, 221.047668, record_p_y_1, "1. Nusikaltimas pirmas");
		PlayerTextDrawLetterSize(playerid, MDC_Record_Name[playerid][i], 0.177142, 0.870400);
		PlayerTextDrawTextSize(playerid, MDC_Record_Name[playerid][i], 487.000000, 9.000000);
		PlayerTextDrawAlignment(playerid, MDC_Record_Name[playerid][i], 1);
		PlayerTextDrawColor(playerid, MDC_Record_Name[playerid][i], -1);
		PlayerTextDrawUseBox(playerid, MDC_Record_Name[playerid][i], 1);
		PlayerTextDrawBoxColor(playerid, MDC_Record_Name[playerid][i], 165);
		PlayerTextDrawSetShadow(playerid, MDC_Record_Name[playerid][i], 0);
		PlayerTextDrawSetOutline(playerid, MDC_Record_Name[playerid][i], 0);
		PlayerTextDrawBackgroundColor(playerid, MDC_Record_Name[playerid][i], 255);
		PlayerTextDrawFont(playerid, MDC_Record_Name[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, MDC_Record_Name[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, MDC_Record_Name[playerid][i], 0);
		PlayerTextDrawSetSelectable(playerid, MDC_Record_Name[playerid][i], true);

		MDC_Record_Date[playerid][i] = CreatePlayerTextDraw(playerid, 486.414184, record_p_y_2, "2017.04.12");
		PlayerTextDrawLetterSize(playerid, MDC_Record_Date[playerid][i], 0.152761, 0.917333);
		PlayerTextDrawAlignment(playerid, MDC_Record_Date[playerid][i], 3);
		PlayerTextDrawColor(playerid, MDC_Record_Date[playerid][i], -192);
		PlayerTextDrawSetShadow(playerid, MDC_Record_Date[playerid][i], 0);
		PlayerTextDrawSetOutline(playerid, MDC_Record_Date[playerid][i], 0);
		PlayerTextDrawBackgroundColor(playerid, MDC_Record_Date[playerid][i], 255);
		PlayerTextDrawFont(playerid, MDC_Record_Date[playerid][i], 2);
		PlayerTextDrawSetProportional(playerid, MDC_Record_Date[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, MDC_Record_Date[playerid][i], 0);
		PlayerTextDrawSetSelectable(playerid, MDC_Record_Date[playerid][i], false);
	}

	MDC_Weapon_Model[playerid] = CreatePlayerTextDraw(playerid, 181.952438, 128.120071, "");
	PlayerTextDrawLetterSize(playerid, MDC_Weapon_Model[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_Weapon_Model[playerid], 102.000000, 129.000000);
	PlayerTextDrawAlignment(playerid, MDC_Weapon_Model[playerid], 1);
	PlayerTextDrawColor(playerid, MDC_Weapon_Model[playerid], -1);
	PlayerTextDrawSetShadow(playerid, MDC_Weapon_Model[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDC_Weapon_Model[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_Weapon_Model[playerid], 0);
	PlayerTextDrawFont(playerid, MDC_Weapon_Model[playerid], 5);
	PlayerTextDrawSetProportional(playerid, MDC_Weapon_Model[playerid], 0);
	PlayerTextDrawSetShadow(playerid, MDC_Weapon_Model[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, MDC_Weapon_Model[playerid], 351);
	PlayerTextDrawSetPreviewRot(playerid, MDC_Weapon_Model[playerid], 360.000000, 0.000000, 128.000000, 2.443384);
	return 1;
}

stock MDC_ShowForPlayer(playerid, active_page = 0)
{
	TextDrawShowForPlayer(playerid, MDC_BackgroundMain);
	TextDrawShowForPlayer(playerid, MDC_HeaderBackground);
	TextDrawShowForPlayer(playerid, MDC_Exit);
	TextDrawShowForPlayer(playerid, MDC_ExitX);
	TextDrawShowForPlayer(playerid, MDC_MenuSeparate);
	MDC__Player_Data[playerid][pMdcInputId] = MDC_INPUT_NONE;
	MDC__Player_Data[playerid][pMdcLookupId] = 0;
	MDC_SetActiveMenuButton(playerid, active_page, .reshow = false);
	MDC_SetHeader(playerid, MDC_GetHeaderName(playerid, active_page, .add_root = true), .show = true);
	MDC_SetName(playerid, GetPlayerNameEx(playerid, .roleplay = true, .ignoremask = true), .show = true);
	MDC_ShowPage(playerid, active_page);
	for(new td = 0, limit = MDC__Textdraw_Data[mdcButtonsCount]; td < limit; td++)
	{
		PlayerTextDrawShow(playerid, MDC_ButtonBox[playerid][td]);
		PlayerTextDrawShow(playerid, MDC_ButtonText[playerid][td]);
	}
	GetESCType(playerid) = ESC_TYPE_MDC;
	return 1;
}

stock MDC_HideForPlayer(playerid)
{
	TextDrawHideForPlayer(playerid, MDC_BackgroundMain);
	TextDrawHideForPlayer(playerid, MDC_HeaderBackground);
	TextDrawHideForPlayer(playerid, MDC_Exit);
	TextDrawHideForPlayer(playerid, MDC_ExitX);
	TextDrawHideForPlayer(playerid, MDC_MenuSeparate);
	PlayerTextDrawHide(playerid, MDC_HeaderText[playerid]);
	PlayerTextDrawHide(playerid, MDC_HeaderName[playerid]);
	MDC_SetUnactiveMenuButton(playerid, MDC__Player_Data[playerid][pMdcActivePage], .reshow = false, .update_variables = false);
	MDC_HidePage(playerid, MDC__Player_Data[playerid][pMdcActivePage], .update_variables = true);
	for(new td = 0, limit = MDC__Textdraw_Data[mdcButtonsCount]; td < limit; td++)
	{
		PlayerTextDrawHide(playerid, MDC_ButtonBox[playerid][td]);
		PlayerTextDrawHide(playerid, MDC_ButtonText[playerid][td]);
	}
	GetESCType(playerid) = ESC_TYPE_NONE;
	MDC__Player_Data[playerid][pMdcLookupId] = 0;
	return 1;
}

stock MDC_SetActiveMenuButton(playerid, page, bool:reshow = true, bool:update_variables = true)
{
	PlayerTextDrawColor(playerid, MDC_ButtonBox[playerid][page], 1010580735);
	PlayerTextDrawColor(playerid, MDC_ButtonText[playerid][page], -1684300801);
	if(reshow)
	{
		PlayerTextDrawHide(playerid, MDC_ButtonBox[playerid][page]);
		PlayerTextDrawShow(playerid, MDC_ButtonBox[playerid][page]);
		PlayerTextDrawHide(playerid, MDC_ButtonText[playerid][page]);
		PlayerTextDrawShow(playerid, MDC_ButtonText[playerid][page]);
	}
	if(update_variables) 
	{
		MDC__Player_Data[playerid][pMdcActivePage] = page;
	}
	return 1;
}

stock MDC_SetUnactiveMenuButton(playerid, page, bool:reshow = true, bool:update_variables = true)
{
	if(page == MDC_PLAYER_STATS || page == MDC_PLAYER_RECORDS) page = MDC_PLAYERS;
	if(page == MDC_WANTED_EDIT || page == MDC_WANTED_ADD) page = MDC_WANTED;
	if(page == MDC_VEHICLE_STATS || page == MDC_VEHICLE_RECORDS) page = MDC_VEHICLES;
	if(page == MDC_WEAPON_STATS || page == MDC_WEAPON_RECORDS) page = MDC_WEAPONS;

	PlayerTextDrawColor(playerid, MDC_ButtonBox[playerid][page], -1515870721);
	PlayerTextDrawColor(playerid, MDC_ButtonText[playerid][page], 1061109759);
	if(reshow)
	{
		PlayerTextDrawHide(playerid, MDC_ButtonBox[playerid][page]);
		PlayerTextDrawShow(playerid, MDC_ButtonBox[playerid][page]);
		PlayerTextDrawHide(playerid, MDC_ButtonText[playerid][page]);
		PlayerTextDrawShow(playerid, MDC_ButtonText[playerid][page]);
	}
	if(update_variables) 
	{
		MDC__Player_Data[playerid][pMdcActivePage] = 0;
	}
	return 1;
}

stock MDC_SetHeader(playerid, name[], bool:show = false)
{
	PlayerTextDrawSetString(playerid, MDC_HeaderText[playerid], name);
	if(show) PlayerTextDrawShow(playerid, MDC_HeaderText[playerid]);
	return 1;
}

stock MDC_GetHeaderName(playerid, page, bool:add_root = true, add_text[] = "")
{
	new header[86];
	format(header, sizeof header, "%s%s", (add_root ? ("Los_Santos_Police_Department ~>~ ") : ("")), MDC__Buttons_Data[page][mdcButtonHeader]);

	if( (MDC__Player_Data[playerid][pMdcLookupId] != -1 && page == MDC_PLAYER_STATS && strlen(add_text)) || 
		(MDC__Player_Data[playerid][pMdcLookupId] != -1 && page == MDC_VEHICLE_STATS && strlen(add_text)) || 
		(MDC__Player_Data[playerid][pMdcLookupId] != -1 && page == MDC_WEAPON_STATS && strlen(add_text)))
	{
		format(header, sizeof header, "%sPaieska ~>~ %s", header, add_text);
	}
	else if( (page == MDC_WANTED_EDIT && strlen(add_text)) )
	{
		format(header, sizeof header, "%sIeskomi ~>~ %s", header, add_text);
	}
	return header;
}

stock MDC_SetName(playerid, name[], bool:show = false)
{
	PlayerTextDrawSetString(playerid, MDC_HeaderName[playerid], name);
	if(show) PlayerTextDrawShow(playerid, MDC_HeaderName[playerid]);
	return 1;
}

stock MDC_ShowPage(playerid, page, bool:update_variables = true)
{
	if(update_variables) MDC__Player_Data[playerid][pMdcActivePage] = page;
	switch(page)
	{
		case MDC_MAIN:
		{
			PlayerTextDrawSetPreviewModel(playerid, MDC_Main_Skin[playerid], GetPlayerSkin(playerid));
			PlayerTextDrawShow(playerid, MDC_Main_Skin[playerid]);
			PlayerTextDrawShow(playerid, MDC_Main_HideSkin[playerid]);
			new string[256];
			format(string, sizeof string, "~w~PAREIGUNAI TARNYBOJE: ~g~%d~n~~n~~w~STATISTIKA PER PASKUTINE VALANDA:~n~- ~r~%d~w~ GAUTU_SKAMBUCIU~n~- ~r~%d~w~ ZMONIU KALEJIME~n~- ~r~%d~w~ ZMONIU ARESTINEJE", CountDutyPolice(), stats_police_calls, CountJailPlayers(), CountArrestPlayers());
			PlayerTextDrawSetString(playerid, MDC_Main_Stats[playerid], string);
			PlayerTextDrawShow(playerid, MDC_Main_Stats[playerid]);
			new factionid = GetFactionArrayIndexById(PlayerInfo[playerid][pFaction]);
			format(string, sizeof string, "%s %s", FactionRankNames[factionid][PlayerInfo[playerid][pJobLevel]-1], GetPlayerNameEx(playerid, .roleplay = true, .ignoremask = true));
			PlayerTextDrawSetString(playerid, MDC_Main_Name[playerid], string);
			PlayerTextDrawShow(playerid, MDC_Main_Name[playerid]);
			MDC__Player_Data[playerid][pMdcLookupId] = -1;
			strmid(MDC__Player_Data[playerid][pMdcInputText], "", 0, 0);
		}
		case MDC_PLAYERS:
		{
			MDC__Player_Data[playerid][pMdcLookupId] = 0;
			PlayerTextDrawSetString(playerid, MDC_Lookup_SearchText[playerid], "IVESKITE_PAIESKOS_TEKSTA...");
			PlayerTextDrawShow(playerid, MDC_Lookup_SearchText[playerid]);
			TextDrawShowForPlayer(playerid, MDC_Lookup_SearchBox);
			TextDrawShowForPlayer(playerid, MDC_Lookup_SearchBoxText);
			TextDrawShowForPlayer(playerid, MDC_Lookup_HideSearchBox);
		}
		case MDC_PLAYER_STATS:
		{
			PlayerTextDrawShow(playerid, MDC_Player_HideSkin[playerid]);
			PlayerTextDrawShow(playerid, MDC_Lookup_Action1[playerid]);
			PlayerTextDrawShow(playerid, MDC_Lookup_Action2[playerid]);
			//PlayerTextDrawShow(playerid, MDC_Lookup_Action3[playerid]);
			PlayerTextDrawShow(playerid, MDC_Lookup_StatsValue[playerid]);
			PlayerTextDrawShow(playerid, MDC_Lookup_StatsKey[playerid]);
		}
		case MDC_VEHICLES:
		{
			MDC__Player_Data[playerid][pMdcLookupId] = 0;
			PlayerTextDrawSetString(playerid, MDC_Lookup_SearchText[playerid], "IVESKITE_PAIESKOS_TEKSTA...");
			PlayerTextDrawShow(playerid, MDC_Lookup_SearchText[playerid]);
			TextDrawShowForPlayer(playerid, MDC_Lookup_SearchBox);
			TextDrawShowForPlayer(playerid, MDC_Lookup_SearchBoxText);
			TextDrawShowForPlayer(playerid, MDC_Lookup_HideSearchBox);
		}
		case MDC_VEHICLE_STATS:
		{
			PlayerTextDrawShow(playerid, MDC_Lookup_Action1[playerid]);
			PlayerTextDrawShow(playerid, MDC_Lookup_Action2[playerid]);
			PlayerTextDrawShow(playerid, MDC_Lookup_StatsValue[playerid]);
			PlayerTextDrawShow(playerid, MDC_Lookup_StatsKey[playerid]);
		}
		case MDC_WEAPONS:
		{
			MDC__Player_Data[playerid][pMdcLookupId] = 0;
			PlayerTextDrawSetString(playerid, MDC_Lookup_SearchText[playerid], "IVESKITE_PAIESKOS_TEKSTA...");
			PlayerTextDrawShow(playerid, MDC_Lookup_SearchText[playerid]);
			TextDrawShowForPlayer(playerid, MDC_Lookup_SearchBox);
			TextDrawShowForPlayer(playerid, MDC_Lookup_SearchBoxText);
			TextDrawShowForPlayer(playerid, MDC_Lookup_HideSearchBox);
		}
		case MDC_WEAPON_STATS:
		{
			PlayerTextDrawShow(playerid, MDC_Lookup_Action1[playerid]);
			PlayerTextDrawShow(playerid, MDC_Lookup_Action2[playerid]);
			PlayerTextDrawShow(playerid, MDC_Lookup_StatsValue[playerid]);
			PlayerTextDrawShow(playerid, MDC_Lookup_StatsKey[playerid]);
		}
		case MDC_WANTED:
		{
			mysql_tquery(chandler, "SELECT * FROM `players_wanted` WHERE Active = '1' LIMIT "#MAX_WANTED_PER_PAGE_SELECT"", "OnFetchWantedList", "dd", playerid, 0);
			for(new i = 0; i < sizeof MDC_Wanted_Key; i++)
			{
				TextDrawShowForPlayer(playerid, MDC_Wanted_Key[i]);
			}
			TextDrawShowForPlayer(playerid, MDC_Wanted_Add);
			format(MDC__Player_Data[playerid][pMdcWantedReason], 9, "Neivesta");
			format(MDC__Player_Data[playerid][pMdcWantedName], 9, "Neivesta");
			format(MDC__Player_Data[playerid][pMdcWantedLooks], 9, "Neivesta");
			format(MDC__Player_Data[playerid][pMdcWantedSeen], 9, "Neivesta");
		}
		case MDC_WANTED_ADD:
		{
			TextDrawShowForPlayer(playerid, MDC_WantedAddEdit_Background);
			PlayerTextDrawSetString(playerid, MDC_WantedAddEdit_Action1[playerid], "+_PRIDETI");
			PlayerTextDrawShow(playerid, MDC_WantedAddEdit_Action1[playerid]);
			PlayerTextDrawSetString(playerid, MDC_WantedAddEdit_Action2[playerid], "X_ISVALYTI");
			PlayerTextDrawShow(playerid, MDC_WantedAddEdit_Action2[playerid]);

			PlayerTextDrawSetString(playerid, MDC_WantedAddEdit_Name[playerid], "Neivesta");
			PlayerTextDrawSetString(playerid, MDC_WantedAddEdit_Looks[playerid], "Neivesta");
			PlayerTextDrawSetString(playerid, MDC_WantedAddEdit_Reason[playerid], "Neivesta");
			PlayerTextDrawSetString(playerid, MDC_WantedAddEdit_Seen[playerid], "Neivesta");

			PlayerTextDrawShow(playerid, MDC_WantedAddEdit_Name[playerid]);
			PlayerTextDrawShow(playerid, MDC_WantedAddEdit_Looks[playerid]);
			PlayerTextDrawShow(playerid, MDC_WantedAddEdit_Reason[playerid]);
			PlayerTextDrawShow(playerid, MDC_WantedAddEdit_Seen[playerid]);

			TextDrawShowForPlayer(playerid, MDC_WantedAddEdit_Keys);
			TextDrawShowForPlayer(playerid, MDC_WantedAddEdit_Back);
		}
		case MDC_WANTED_EDIT:
		{
			TextDrawShowForPlayer(playerid, MDC_WantedAddEdit_Background);
			PlayerTextDrawSetString(playerid, MDC_WantedAddEdit_Action1[playerid], "+_ATNAUJINTI");
			PlayerTextDrawShow(playerid, MDC_WantedAddEdit_Action1[playerid]);
			PlayerTextDrawSetString(playerid, MDC_WantedAddEdit_Action2[playerid], "X_ISTRINTI");
			PlayerTextDrawShow(playerid, MDC_WantedAddEdit_Action2[playerid]);
			TextDrawShowForPlayer(playerid, MDC_WantedAddEdit_Keys);
			TextDrawShowForPlayer(playerid, MDC_WantedAddEdit_Back);
		}
		case MDC_CCTV:
		{
			TextDrawShowForPlayer(playerid, MDC_CCTV_Header);
			for(new c = 0; c < sizeof CCTV; c++)
			{
				TextDrawShowForPlayer(playerid, MDC_CCTV_Camera[c]);
			}
		}
		case MDC_PRISON:
		{
			//TextDrawShowForPlayer(playerid, MDC_Prison_Alarm);
			TextDrawShowForPlayer(playerid, MDC_Prison_CloseAll);
			TextDrawShowForPlayer(playerid, MDC_Prison_OpenAll);
			new cell_string[25];
			for(new c = 0; c < sizeof PrisonCells; c++)
			{
				if(PrisonCells[c][cellDoorOpened]) format(cell_string, 22, "~r~%s OPENED", PrisonCells[c][cellName]);
				else format(cell_string, 22, "~g~%s CLOSED", PrisonCells[c][cellName]);
				PlayerTextDrawSetString(playerid, MDC_Prison_CellStatus[playerid][c], cell_string);
				PlayerTextDrawShow(playerid, MDC_Prison_CellStatus[playerid][c]);
			}
		}
		case MDC_PLAYER_RECORDS, MDC_VEHICLE_RECORDS, MDC_WEAPON_RECORDS:
		{
			TextDrawShowForPlayer(playerid, MDC_Record_Back);
		}
	}
	return 1;
}

stock MDC_HidePage(playerid, page, bool:update_variables = true)
{
	if(update_variables) MDC__Player_Data[playerid][pMdcActivePage] = 0;
	switch(page)
	{
		case MDC_MAIN:
		{
			PlayerTextDrawHide(playerid, MDC_Main_Skin[playerid]);
			PlayerTextDrawHide(playerid, MDC_Main_Stats[playerid]);
			PlayerTextDrawHide(playerid, MDC_Main_Name[playerid]);
			PlayerTextDrawHide(playerid, MDC_Main_HideSkin[playerid]);
		}
		case MDC_PLAYERS, MDC_VEHICLES, MDC_WEAPONS:
		{
			PlayerTextDrawHide(playerid, MDC_Lookup_SearchText[playerid]);
			TextDrawHideForPlayer(playerid, MDC_Lookup_SearchBox);
			TextDrawHideForPlayer(playerid, MDC_Lookup_SearchBoxText);
			TextDrawHideForPlayer(playerid, MDC_Lookup_HideSearchBox);
		}
		case MDC_PLAYER_STATS:
		{
			PlayerTextDrawHide(playerid, MDC_Player_Skin[playerid]);
			PlayerTextDrawHide(playerid, MDC_Player_HideSkin[playerid]);
			PlayerTextDrawHide(playerid, MDC_Lookup_Action1[playerid]);
			//PlayerTextDrawHide(playerid, MDC_Lookup_Action3[playerid]);
			PlayerTextDrawHide(playerid, MDC_Lookup_Action2[playerid]);
			PlayerTextDrawHide(playerid, MDC_Lookup_StatsValue[playerid]);
			PlayerTextDrawHide(playerid, MDC_Lookup_StatsKey[playerid]);
			MDC_HidePage(playerid, MDC_PLAYERS, .update_variables = false);
		}
		case MDC_VEHICLE_STATS:
		{
			PlayerTextDrawHide(playerid, MDC_Vehicle_Model[playerid]);
			PlayerTextDrawHide(playerid, MDC_Lookup_Action1[playerid]);
			PlayerTextDrawHide(playerid, MDC_Lookup_Action2[playerid]);
			PlayerTextDrawHide(playerid, MDC_Lookup_StatsValue[playerid]);
			PlayerTextDrawHide(playerid, MDC_Lookup_StatsKey[playerid]);
			MDC_HidePage(playerid, MDC_VEHICLES, .update_variables = false);
		}
		case MDC_WEAPON_STATS:
		{
			PlayerTextDrawHide(playerid, MDC_Weapon_Model[playerid]);
			PlayerTextDrawHide(playerid, MDC_Lookup_Action1[playerid]);
			PlayerTextDrawHide(playerid, MDC_Lookup_Action2[playerid]);
			PlayerTextDrawHide(playerid, MDC_Lookup_StatsValue[playerid]);
			PlayerTextDrawHide(playerid, MDC_Lookup_StatsKey[playerid]);
			MDC_HidePage(playerid, MDC_WEAPONS, .update_variables = false);
		}
		case MDC_CCTV:
		{
			TextDrawHideForPlayer(playerid, MDC_CCTV_Header);
			for(new c = 0; c < sizeof CCTV; c++)
			{
				TextDrawHideForPlayer(playerid, MDC_CCTV_Camera[c]);
			}
		}
		case MDC_WANTED:
		{
			for(new i = 0; i < sizeof MDC_Wanted_Key; i++)
			{
				TextDrawHideForPlayer(playerid, MDC_Wanted_Key[i]);
			}
			PlayerTextDrawHide(playerid, MDC_Wanted_Next[playerid]);
			PlayerTextDrawHide(playerid, MDC_Wanted_Back[playerid]);
			TextDrawHideForPlayer(playerid, MDC_Wanted_Add);
			for(new i = 0; i < MAX_WANTED_PER_PAGE; i++)
			{
				PlayerTextDrawHide(playerid, MDC_Wanted_Seen[playerid][i]);
				PlayerTextDrawHide(playerid, MDC_Wanted_Name[playerid][i]);
				PlayerTextDrawHide(playerid, MDC_Wanted_Reason[playerid][i]);
				PlayerTextDrawHide(playerid, MDC_Wanted_Looks[playerid][i]);
			}
		}
		case MDC_WANTED_ADD:
		{
			PlayerTextDrawHide(playerid, MDC_WantedAddEdit_Action1[playerid]);
			PlayerTextDrawHide(playerid, MDC_WantedAddEdit_Action2[playerid]);
			PlayerTextDrawHide(playerid, MDC_WantedAddEdit_Name[playerid]);
			PlayerTextDrawHide(playerid, MDC_WantedAddEdit_Looks[playerid]);
			PlayerTextDrawHide(playerid, MDC_WantedAddEdit_Reason[playerid]);
			PlayerTextDrawHide(playerid, MDC_WantedAddEdit_Seen[playerid]);
			TextDrawHideForPlayer(playerid, MDC_WantedAddEdit_Keys);
			TextDrawHideForPlayer(playerid, MDC_WantedAddEdit_Back);
			TextDrawHideForPlayer(playerid, MDC_WantedAddEdit_Background);
		}
		case MDC_WANTED_EDIT:
		{
			PlayerTextDrawHide(playerid, MDC_WantedAddEdit_Action1[playerid]);
			PlayerTextDrawHide(playerid, MDC_WantedAddEdit_Action2[playerid]);
			PlayerTextDrawHide(playerid, MDC_WantedAddEdit_Name[playerid]);
			PlayerTextDrawHide(playerid, MDC_WantedAddEdit_Looks[playerid]);
			PlayerTextDrawHide(playerid, MDC_WantedAddEdit_Reason[playerid]);
			PlayerTextDrawHide(playerid, MDC_WantedAddEdit_Seen[playerid]);
			TextDrawHideForPlayer(playerid, MDC_WantedAddEdit_Keys);
			TextDrawHideForPlayer(playerid, MDC_WantedAddEdit_Back);
			TextDrawHideForPlayer(playerid, MDC_WantedAddEdit_Background);
		}
		case MDC_PRISON:
		{
			//TextDrawHideForPlayer(playerid, MDC_Prison_Alarm);
			TextDrawHideForPlayer(playerid, MDC_Prison_CloseAll);
			TextDrawHideForPlayer(playerid, MDC_Prison_OpenAll);
			for(new c = 0; c < sizeof PrisonCells; c++)
			{
				PlayerTextDrawHide(playerid, MDC_Prison_CellStatus[playerid][c]);
			}
		}
		case MDC_PLAYER_RECORDS, MDC_VEHICLE_RECORDS, MDC_WEAPON_RECORDS:
		{
			TextDrawHideForPlayer(playerid, MDC_Record_Back);
			for(new i = 0; i < MAX_RECORDS_PER_PAGE; i++)
			{
				PlayerTextDrawHide(playerid, MDC_Record_Name[playerid][i]);
				PlayerTextDrawHide(playerid, MDC_Record_Date[playerid][i]);
			}
		}
	}
	return 1;
}

stock MDC_ShowPlayerDialog(playerid, inputid, style, header[], content[], response1[], response2[])
{
	MDC__Player_Data[playerid][pMdcInputId] = inputid;
	return ShowPlayerDialog(playerid, DIALOG_MDC_INPUT, style, header, content, response1, response2);
}

stock MDC_Lookup_InputPlayerName(playerid)
{
	return MDC_ShowPlayerDialog(playerid, MDC_INPUT_PLAYER_LOOKUP, DIALOG_STYLE_INPUT, "Þaidëjo paieðka", "{FFFFFF}Áveskite þaidëjo vardà, pavardæ\t\t\t\t ", "Tæsti", "Atðaukti");
}

stock MDC_Lookup_InputVehicleName(playerid)
{
	return MDC_ShowPlayerDialog(playerid, MDC_INPUT_VEHICLE_LOOKUP, DIALOG_STYLE_INPUT, "Transporto priemonës paieðka", "{FFFFFF}Áveskite transporto priemonës numerius\t\t\t\t ", "Tæsti", "Atðaukti");
}

stock MDC_Lookup_InputWeaponName(playerid)
{
	return MDC_ShowPlayerDialog(playerid, MDC_INPUT_WEAPON_LOOKUP, DIALOG_STYLE_INPUT, "Ginklo paieðka", "{FFFFFF}Áveskite pilnà ginklo numerá\t\t\t\t ", "Tæsti", "Atðaukti");
}

stock MDC_Wanted_InputName(playerid)
{
	return MDC_ShowPlayerDialog(playerid, MDC_INPUT_WANTED_NAME, DIALOG_STYLE_INPUT, "Ieðkomi þaidëjai", "{FFFFFF}Asmens vardas, pavardë\t\t\t\t ", "Tæsti", "Atðaukti"); 
}

stock MDC_Wanted_InputLooks(playerid)
{
	return MDC_ShowPlayerDialog(playerid, MDC_INPUT_WANTED_LOOKS, DIALOG_STYLE_INPUT, "Ieðkomi þaidëjai", "{FFFFFF}Asmens iðvaizda\t\t\t\t ", "Tæsti", "Atðaukti"); 
}

stock MDC_Wanted_InputSeen(playerid)
{
	return MDC_ShowPlayerDialog(playerid, MDC_INPUT_WANTED_SEEN, DIALOG_STYLE_INPUT, "Ieðkomi þaidëjai", "{FFFFFF}Kur ir kada matëte asmená paskutiná kartà\n{BABABA}Pvz.: 2017.04.15 Los Santos Unity Station\t\t\t\t ", "Tæsti", "Atðaukti"); 
}

stock MDC_Wanted_InputReason(playerid)
{
	return MDC_ShowPlayerDialog(playerid, MDC_INPUT_WANTED_REASON, DIALOG_STYLE_INPUT, "Ieðkomi þaidëjai", "{FFFFFF}Ieðkomumo prieþastis\t\t\t\t ", "Tæsti", "Atðaukti"); 	
}


stock MDC_FetchPlayerIdByName(playerid, name[], type, bool:thread = true)
{
	new 
		string[126],
		id;
	mysql_format(chandler, string, 86, "SELECT id,Name FROM `players_data` WHERE Name %s%e%s LIMIT 1", type == MDC_FETCH_LIKE ? ("LIKE '%%") : ("= '"), name, type == MDC_FETCH_LIKE ? ("%%'") : ("'"));
	if(thread) mysql_tquery(chandler, string, "OnFetchIdByString", "ds", playerid, name);
	else
	{
		new Cache:active = cache_save();
		new Cache:result = mysql_query(chandler, string, true);
		cache_get_value_name_int(0, "id", id);
		cache_set_active(result);
		cache_delete(result);
		cache_set_active(active);
		return id;
	}
	return -1;
}

stock MDC_FetchVehicleIdByNumbers(playerid, numbers[], bool:thread = true)
{
	new 
		string[126],
		id;
	if(strfind(numbers, #DEFAULT_FACTION_VEHICLE_NUMBER_PREFIX, true) == 0 && IsNumeric(numbers[4]))
	{
		foreach(new vehicleid : Vehicle)
		{
			// frakcijos
			if(isequal(VehicleInfo[vehicleid][vNumbers], numbers))
			{
				SendFormat(playerid, -1, "Ieðkoma tr. priemonë priklauso frakcijai \"%s\"", GetFactionName(VehicleInfo[vehicleid][vFaction]));
				return 1;
			}
		}
	}
	else if(strfind(numbers, #DEFAULT_JOB_VEHICLE_NUMBER_PREFIX, true) == 0 && IsNumeric(numbers[4]))
	{
		foreach(new vehicleid : Vehicle)
		{
			// frakcijos
			if(isequal(VehicleInfo[vehicleid][vNumbers], numbers))
			{
				SendFormat(playerid, -1, "Ieðkoma tr. priemonë priklauso darbui \"%s\"", GetJobName(VehicleInfo[vehicleid][vJob]));
				return 1;
			}
		}
	}
	mysql_format(chandler, string, 86, "SELECT id FROM `vehicles_data` WHERE Numbers = '%e'", numbers);
	if(thread) mysql_tquery(chandler, string, "OnFetchIdByString", "ds", playerid, numbers);
	else
	{
		new Cache:active = cache_save();
		new Cache:result = mysql_query(chandler, string, true);
		cache_get_value_name_int(0, "id", id);
		cache_set_active(result);
		cache_delete(result);
		cache_set_active(active);
		return id;
	}
	return -1;
}

stock MDC_FetchWeaponIdByUnique(playerid, unique[], bool:thread = true)
{
	new
		string[126],
		delstring[24],
		id;

	strmid(delstring, unique, strlen(#DEFAULT_WEAPON_UNIQUE_ID_PREFIX), strlen(unique));

	mysql_format(chandler, string, 86, "SELECT id,WeaponModel FROM `weapons_data` WHERE id = '%d'", strval(delstring));
	if(thread) mysql_tquery(chandler, string, "OnFetchIdByString", "ds", playerid, delstring);
	else
	{
		new Cache:active = cache_save();
		new Cache:result = mysql_query(chandler, string, true);
		cache_get_value_name_int(0, "id", id);
		cache_set_active(result);
		cache_delete(result);
		cache_set_active(active);
		return id;
	}
	return -1;
}

stock MDC_FetchPlayerDataById(playerid, id)
{
	new string[546];
	mysql_format(chandler, string, sizeof string, "\
		SELECT \
			pdb.*, \
		    COUNT(distinct hdb.id) AS HousesCount, \
		    COUNT(distinct pcr.id) AS CrimesCount, \
		    COUNT(distinct bdb.id) AS BusinessCount, \
		    COUNT(distinct vdb.id) AS VehiclesCount \
		FROM players_data pdb ");
	mysql_format(chandler, string, sizeof string, "%e\
		LEFT JOIN vehicles_data vdb ON pdb.id = vdb.Owner \
		LEFT JOIN players_crimes pcr ON pdb.id = pcr.PlayerId AND pcr.Valid = 1 \
		LEFT JOIN houses_data hdb ON pdb.id = hdb.Owner \
		LEFT JOIN business_data bdb ON pdb.id = bdb.Owner \
		WHERE pdb.id = '%d' GROUP BY pdb.id", string, id);
	mysql_tquery(chandler, string, "OnFetchPlayerDataById", "dd", playerid, id);	
	return 1;
}

stock MDC_FetchVehicleDataById(playerid, id)
{
	new string[546];
	mysql_format(chandler, string, sizeof string, "\
		SELECT \
			vdb.*, \
		    COUNT(vcr.id) AS CrimesCount \
		FROM vehicles_data vdb \
		LEFT JOIN vehicles_crimes vcr ON vdb.id = vcr.VehicleId AND vcr.Valid = 1 \
		WHERE vdb.id = '%d' GROUP BY vdb.id", id);
	mysql_tquery(chandler, string, "OnFetchVehicleDataById", "dd", playerid, id);	
	return 1;
}

stock MDC_FetchWeaponDataById(playerid, id)
{
	new string[256];
	mysql_format(chandler, string, sizeof string, "\
		SELECT \
			wdb.*, \
			COUNT(wcr.id) AS CrimesCount \
		FROM weapons_data wdb \
		LEFT JOIN weapons_crimes wcr ON wdb.id = wcr.WeaponId AND wcr.Valid = 1 \
		WHERE wdb.id = '%d' GROUP BY wdb.id", id);
	mysql_tquery(chandler, string, "OnFetchWeaponDataById", "dd", playerid, id);
	return 1;
}


/*
	Forwards
*/

forward OnRecordAdded(playerid);
public OnRecordAdded(playerid)
{
	if(mysql_errno() != 0)
	{
		new string[25];
		format(string, sizeof string, "%d", mysql_errno());
		SendCriticalError(playerid, "Atsirado MySQL klaida pridedant áraðà", string);
	}
	else
	{
		SendFormat(playerid, 0xDBFF47FF, "Áraðas sëkmingai pridëtas (jo numeris %d)", cache_insert_id());
	}
	return 1;
}

forward OnFetchWantedList(playerid, page);
public OnFetchWantedList(playerid, page)
{
	new 
		string[256],
		rows = cache_num_rows();
	if(rows > MAX_WANTED_PER_PAGE)
	{
		PlayerTextDrawHide(playerid, MDC_Wanted_Next[playerid]);
		PlayerTextDrawSetSelectable(playerid, MDC_Wanted_Next[playerid], true);
		PlayerTextDrawShow(playerid, MDC_Wanted_Next[playerid]);
	}
	else
	{
		PlayerTextDrawHide(playerid, MDC_Wanted_Next[playerid]);
		PlayerTextDrawSetSelectable(playerid, MDC_Wanted_Next[playerid], false);
		PlayerTextDrawShow(playerid, MDC_Wanted_Next[playerid]);
	}
	if(page > 0)
	{
		PlayerTextDrawHide(playerid, MDC_Wanted_Back[playerid]);
		PlayerTextDrawSetSelectable(playerid, MDC_Wanted_Back[playerid], true);
		PlayerTextDrawShow(playerid, MDC_Wanted_Back[playerid]);
	}
	else
	{
		PlayerTextDrawHide(playerid, MDC_Wanted_Back[playerid]);
		PlayerTextDrawSetSelectable(playerid, MDC_Wanted_Back[playerid], false);
		PlayerTextDrawShow(playerid, MDC_Wanted_Back[playerid]);
	}
	for(new i = 0; i < (rows > MAX_WANTED_PER_PAGE ? MAX_WANTED_PER_PAGE : rows); i++)
	{	
		cache_get_value_name(i, "Looks", string);
		cache_get_value_name_int(i, "id", MDC__Player_Data[playerid][pMdcWantedPlayers][i]);
		if(strlen(string) > 25) // BaltaodisasdaopdskopadopaA~n~aSdlopasdopasdkopaopsdkAO~n~AlsDAPS?Dlasdap'sdla'dspA...
		{
			strins(string, "~n~", 25);
			if(strlen(string) > 53)
			{
				strins(string, "~n~", 53);
				if(strlen(string) > 81)
				{
					strdel(string, 81, strlen(string));
					strcat(string, "...");
				}
			}
			else
			{
				strcat(string, "~n~_");
			}
		}
		else
		{
			strcat(string, "~n~~n~_");
		}
		PlayerTextDrawSetString(playerid, MDC_Wanted_Looks[playerid][i], formatlt(string));
		PlayerTextDrawShow(playerid, MDC_Wanted_Looks[playerid][i]);

		cache_get_value_name(i, "Name", string); // AOSDPASDPOAKSDOPKA~n~ASDLPA?SDLA?SDLP?ADLS~n~ASDPALSDPANICKASCIA...
		strcat(string, "~n~~n~_");
		PlayerTextDrawSetString(playerid, MDC_Wanted_Name[playerid][i], string);
		PlayerTextDrawShow(playerid, MDC_Wanted_Name[playerid][i]);

		cache_get_value_name(i, "Seen", string);
		if(strlen(string) > 13) // 2017-05-23LOS~n~ASLALSPAPSLSLS~n~ASAP?SDLPSLA...
		{
			strins(string, "~n~", 13);
			if(strlen(string) > 30)
			{
				strins(string, "~n~", 30);
				if(strlen(string) > 45)
				{
					strdel(string, 45, strlen(string));
					strcat(string, "...");
				}
			}
			else
			{
				strcat(string, "~n~_");
			}
		}
		else
		{
			strcat(string, "~n~~n~_");
		}
		PlayerTextDrawSetString(playerid, MDC_Wanted_Seen[playerid][i], formatlt(string));
		PlayerTextDrawShow(playerid, MDC_Wanted_Seen[playerid][i]);

		cache_get_value_name(i, "Reason", string);
		if(strlen(string) > 28) // Ginkluotasapiplesimasnusikal~n~timasciaaksokpaskoadkosaA~n~adkopaOPASDKOPAaAAaa...
		{
			strins(string, "~n~", 28);
			if(strlen(string) > 57)
			{
				strins(string, "~n~", 57);
				if(strlen(string) > 79)
				{
					strdel(string, 79, strlen(string));
					strcat(string, "...");
				}
			}
			else
			{
				strcat(string, "~n~_");
			}
		}
		else
		{
			strcat(string, "~n~~n~_");
		}
		PlayerTextDrawSetString(playerid, MDC_Wanted_Reason[playerid][i], formatlt(string));
		PlayerTextDrawShow(playerid, MDC_Wanted_Reason[playerid][i]);
	}
	for(new i = rows; i < MAX_WANTED_PER_PAGE; i++)
	{
		PlayerTextDrawHide(playerid, MDC_Wanted_Reason[playerid][i]);
		PlayerTextDrawHide(playerid, MDC_Wanted_Seen[playerid][i]);
		PlayerTextDrawHide(playerid, MDC_Wanted_Name[playerid][i]);
		PlayerTextDrawHide(playerid, MDC_Wanted_Looks[playerid][i]);
		MDC__Player_Data[playerid][pMdcWantedPlayers][i] = 0;
	}
	MDC__Player_Data[playerid][pMdcWantedPage] = page;
	return 1;
}

forward OnFetchPlayerDataById(playerid, lookupid);
public OnFetchPlayerDataById(playerid, lookupid)
{
	if(cache_num_rows())
	{
		new 
			string[126],
			houses_count,
			business_count,
			vehicles_count,
			crimes_count,
			skin,
			nr,
			origin[30],
			number[10],
			licenses[4] = {0,0,0,0},
			licenses_string[56];
		cache_get_value_name_int(0, "CrimesCount", crimes_count);
		cache_get_value_name_int(0, "HousesCount", houses_count);
		cache_get_value_name_int(0, "BusinessCount", business_count);
		cache_get_value_name_int(0, "VehiclesCount", vehicles_count);
		cache_get_value_name_int(0, "Skin", skin);
		cache_get_value_name_int(0, "PhoneNumber", nr);
		cache_get_value_name_int(0, "CarLic", licenses[0]);
		cache_get_value_name_int(0, "MotoLic", licenses[1]);
		cache_get_value_name_int(0, "BoatLic", licenses[2]);
		cache_get_value_name_int(0, "FlyLic", licenses[3]);
		cache_get_value_name(0, "Origin", origin);
		cache_get_value_name(0, "Name", string);
		for(new l = 0; l < 4; l++)
		{
			if(licenses[l] != 0)
			{
				format(licenses_string, sizeof licenses_string, "%s%s", licenses_string, l == 0 ? ("AUTO") : (l == 1 ? ("MOTO") : (l == 2 ? ("VALTIES") : ("LEKTUVO"))) );
				if(l != 3 && licenses[l+1] != 0)
				{
					// nera paskutine ir kita turi, tai reik kablelio pries sekancia lic
					strcat(licenses_string, ",_");
				}
			}
		}
		if(nr > 0) format(number, sizeof number, "%d", nr);
		else format(number, 5, "nera");
		PlayerTextDrawSetString(playerid, MDC_Lookup_StatsKey[playerid], "VARDAS:~n~TEL._NUMERIS:~n~NUSIKALTIMAI:~n~LICENCIJOS:~n~TURTAS:");
		format(string, sizeof string, "%s(%s)~n~%s~n~%d ISKAITOS~n~%s~n~%d VERSLU, %d NAMU, %d AUTOMOBILIU", strtoupper(string), origin, number, crimes_count, licenses_string, business_count, houses_count, vehicles_count);
		PlayerTextDrawSetString(playerid, MDC_Lookup_StatsValue[playerid], string);
		PlayerTextDrawSetPreviewModel(playerid, MDC_Player_Skin[playerid], skin);
		PlayerTextDrawShow(playerid, MDC_Player_Skin[playerid]);
		MDC_ShowPage(playerid, MDC_PLAYER_STATS);
	}
	else
	{
		SendWarning(playerid, "Ieðkant informacijos atsirado klaida (%d no rows).", lookupid);
	}
	return 1;
}

forward OnFetchVehicleDataById(playerid, lookupid);
public OnFetchVehicleDataById(playerid, lookupid)
{
	if(cache_num_rows())
	{	
		new 
			string[256],
			crimes_count,
			modelid,
			owner;


		cache_get_value_name_int(0, "Model", modelid);
		cache_get_value_name_int(0, "Owner", owner);
		cache_get_value_name_int(0, "CrimesCount", crimes_count);
		PlayerTextDrawSetString(playerid, MDC_Lookup_StatsKey[playerid], "MODELIS:~n~NUMERIAI:~n~IRASAI:~n~SAVININKAI:");

		format(string, sizeof string, "%s~n~%s~n~%d_IRASAI~n~%s", modelid >= 400 ? (strtoupper(GetModelName(modelid))) : ("NERA"), strtoupper(MDC__Player_Data[playerid][pMdcLookupName]), crimes_count, GetNameBySql(owner));
		PlayerTextDrawSetString(playerid, MDC_Lookup_StatsValue[playerid], string);

		PlayerTextDrawSetPreviewModel(playerid, MDC_Vehicle_Model[playerid], modelid);
		PlayerTextDrawShow(playerid, MDC_Vehicle_Model[playerid]);
		MDC_ShowPage(playerid, MDC_VEHICLE_STATS);
	}	
	else
	{
		SendWarning(playerid, "Ieðkant informacijos atsirado klaida (%d no rows).", lookupid);
	}
	return 1;
}

forward OnFetchWeaponDataById(playerid, lookupid);
public OnFetchWeaponDataById(playerid, lookupid)
{
	if(cache_num_rows())
	{
		new 
			string[256],
			crimes_count,
			weaponid;
		cache_get_value_name_int(0, "CrimesCount", crimes_count);
		cache_get_value_name_int(0, "WeaponModel", weaponid);

		PlayerTextDrawSetString(playerid, MDC_Lookup_StatsKey[playerid], "MODELIS:~n~TIPAS:~n~IRASAI:~n~GINKLO_NUMERIS:");

		format(string, sizeof string, "%s~n~GINKLAI~n~%d_IRASAI_SIUO_GINKLU~n~%s", strtoupper(GetInventoryItemName(weaponid)), crimes_count, strtoupper(MDC__Player_Data[playerid][pMdcLookupName]));
		PlayerTextDrawSetString(playerid, MDC_Lookup_StatsValue[playerid], string);
		PlayerTextDrawSetPreviewModel(playerid, MDC_Weapon_Model[playerid], WeaponObjects[weaponid]);
		PlayerTextDrawShow(playerid, MDC_Weapon_Model[playerid]);
		MDC_ShowPage(playerid, MDC_WEAPON_STATS);
	}
	else
	{
		SendWarning(playerid, "Ieðkant informacijos atsirado klaida (%d no rows).", lookupid);
	}
	return 1;
}

forward OnFetchIdByString(playerid, inputtext[]);
public OnFetchIdByString(playerid, inputtext[])
{
	if(cache_num_rows())
	{
		switch(MDC__Player_Data[playerid][pMdcActivePage])
		{
			case MDC_PLAYER_STATS, MDC_PLAYERS:
			{
				new 
					id,
					name[24];
				cache_get_value_name_int(0, "id", id);
				cache_get_value_name(0, "Name", name);
				
				if(id == MDC__Player_Data[playerid][pMdcLookupId]) return 1; // tas pats, nieko nedarom

				MDC__Player_Data[playerid][pMdcLookupId] = id;
				format(MDC__Player_Data[playerid][pMdcLookupName], 24, name);

				MDC_SetHeader(playerid, MDC_GetHeaderName(playerid, MDC_PLAYER_STATS, .add_text = name), .show = false);
				MDC_FetchPlayerDataById(playerid, id);
			}
			case MDC_VEHICLE_STATS, MDC_VEHICLES:
			{	
				new 
					id;
				cache_get_value_name_int(0, "id", id);

				if(id == MDC__Player_Data[playerid][pMdcLookupId]) return 1;

				MDC__Player_Data[playerid][pMdcLookupId] = id;
				format(MDC__Player_Data[playerid][pMdcLookupName], 24, inputtext);

				MDC_SetHeader(playerid, MDC_GetHeaderName(playerid, MDC_VEHICLE_STATS, .add_text = inputtext), .show = false);
				MDC_FetchVehicleDataById(playerid, id);
			}
			case MDC_WEAPON_STATS, MDC_WEAPONS:
			{
				new 
					id,
					weaponid;
				cache_get_value_name_int(0, "id", id);
				cache_get_value_name_int(0, "WeaponModel", weaponid);
				
				if(id == MDC__Player_Data[playerid][pMdcLookupId]) return 1;

				MDC__Player_Data[playerid][pMdcLookupId] = id;
				format(MDC__Player_Data[playerid][pMdcLookupName], 24, GetUniqueNumber(weaponid, id, -1));

				MDC_SetHeader(playerid, MDC_GetHeaderName(playerid, MDC_WEAPON_STATS, .add_text = MDC__Player_Data[playerid][pMdcLookupName]), .show = false);
				MDC_FetchWeaponDataById(playerid, id);
			}
		}

	}
	else
	{
		switch(MDC__Player_Data[playerid][pMdcActivePage])
		{
			case MDC_PLAYER_STATS:
			{	
				MDC_HidePage(playerid, MDC_PLAYER_STATS, .update_variables = false);
				MDC_ShowPage(playerid, MDC_PLAYERS, .update_variables = true);
			}
			case MDC_VEHICLE_STATS:
			{
				MDC_HidePage(playerid, MDC_VEHICLE_STATS, .update_variables = false);
				MDC_ShowPage(playerid, MDC_VEHICLES, .update_variables = true);
			}
			case MDC_WEAPON_STATS:
			{
				MDC_HidePage(playerid, MDC_WEAPON_STATS, .update_variables = false);
				MDC_ShowPage(playerid, MDC_WEAPONS, .update_variables = true);
			}
		}
		SendWarning(playerid, "Uþklausa \"%s\" negraþino jokiø rezultatø.", inputtext);
	}
	return 1;
}

forward OnFetchWantedPlayerData(playerid, id);
public OnFetchWantedPlayerData(playerid, id)
{
	if(cache_num_rows())
	{
		MDC_HidePage(playerid, MDC_WANTED);
		MDC_ShowPage(playerid, MDC_WANTED_EDIT, .update_variables = true);

		cache_get_value_name(0, "Name", MDC__Player_Data[playerid][pMdcWantedName], 24);
		MDC_SetHeader(playerid, MDC_GetHeaderName(playerid, MDC_WANTED_EDIT, .add_text = MDC__Player_Data[playerid][pMdcWantedName]));

		cache_get_value_name(0, "Looks", MDC__Player_Data[playerid][pMdcWantedLooks], 108);
		cache_get_value_name(0, "Reason", MDC__Player_Data[playerid][pMdcWantedReason], 108);
		cache_get_value_name(0, "Seen", MDC__Player_Data[playerid][pMdcWantedSeen], 108);

		PlayerTextDrawSetString(playerid, MDC_WantedAddEdit_Name[playerid], MDC__Player_Data[playerid][pMdcWantedName]);
		PlayerTextDrawSetString(playerid, MDC_WantedAddEdit_Looks[playerid], MDC__Player_Data[playerid][pMdcWantedLooks]);
		PlayerTextDrawSetString(playerid, MDC_WantedAddEdit_Reason[playerid], MDC__Player_Data[playerid][pMdcWantedReason]);
		PlayerTextDrawSetString(playerid, MDC_WantedAddEdit_Seen[playerid], MDC__Player_Data[playerid][pMdcWantedSeen]);

		PlayerTextDrawShow(playerid, MDC_WantedAddEdit_Name[playerid]);
		PlayerTextDrawShow(playerid, MDC_WantedAddEdit_Looks[playerid]);
		PlayerTextDrawShow(playerid, MDC_WantedAddEdit_Reason[playerid]);
		PlayerTextDrawShow(playerid, MDC_WantedAddEdit_Seen[playerid]);
	}
	return 1;
}

mdc_called OnLookupActionSelected(playerid, action)
{
	new 
		page = MDC__Player_Data[playerid][pMdcActivePage],
		string[256];
	switch(page)
	{
		case MDC_PLAYERS, MDC_PLAYER_STATS:
		{
			switch(action)
			{
				case 1:
				{
					// perziureti iskaitas
					mysql_format(chandler, string, sizeof string, "SELECT * FROM `players_crimes` WHERE PlayerId = '%d' AND Valid = '1' LIMIT "#MAX_RECORDS_PER_PAGE"", MDC__Player_Data[playerid][pMdcLookupId]);
					mysql_tquery(chandler, string, "OnFetchCrimes", "d", playerid);
				}
				case 2:
				{
					MDC_ShowPlayerDialog(playerid, MDC_INPUT_RECORD, DIALOG_STYLE_INPUT, "Áraðo pridëjimas", "{FFFFFF}Áveskite áraðà", "Pridëti", "Atðaukti"); 
				}
				case 3:
				{
					// registruotas turtas
				}
			}
		}
		case MDC_VEHICLES, MDC_VEHICLE_STATS:
		{
			switch(action)
			{
				case 1:
				{
					// perziureti
					mysql_format(chandler, string, sizeof string, "SELECT * FROM `vehicles_crimes` WHERE VehicleId = '%d' AND Valid = '1' LIMIT "#MAX_RECORDS_PER_PAGE"", MDC__Player_Data[playerid][pMdcLookupId]);
					mysql_tquery(chandler, string, "OnFetchCrimes", "d", playerid);
				}
				case 2:
				{
					MDC_ShowPlayerDialog(playerid, MDC_INPUT_RECORD, DIALOG_STYLE_INPUT, "Áraðo pridëjimas", "{FFFFFF}Áveskite áraðà", "Pridëti", "Atðaukti"); 
				}
			}
		}
		case MDC_WEAPONS, MDC_WEAPON_STATS:
		{
			switch(action)
			{
				case 1:
				{
					// perziureti
					mysql_format(chandler, string, sizeof string, "SELECT * FROM `weapons_crimes` WHERE WeaponId = '%d' AND Valid = '1' LIMIT "#MAX_RECORDS_PER_PAGE"", MDC__Player_Data[playerid][pMdcLookupId]);
					mysql_tquery(chandler, string, "OnFetchCrimes", "d", playerid);
				}
				case 2:
				{
					// prideti
					MDC_ShowPlayerDialog(playerid, MDC_INPUT_RECORD, DIALOG_STYLE_INPUT, "Áraðo pridëjimas", "{FFFFFF}Áveskite áraðà", "Pridëti", "Atðaukti"); 
				}
			}
		}
	}
	return 1;
}

forward OnFetchCrimes(playerid);
public OnFetchCrimes(playerid)
{
	new 
		page = MDC__Player_Data[playerid][pMdcActivePage],
		rows = cache_num_rows(),
		date[20],
		string[61],
		number[4];
	if(!rows) return SendWarning(playerid, "Áraðø nëra.");
	SendFormat(playerid, 0x82ADC6FF, "Rodomi paskutiniai "#MAX_RECORDS_PER_PAGE" áraðø.");
	MDC_HidePage(playerid, MDC__Player_Data[playerid][pMdcActivePage], .update_variables = false);
	switch(page)
	{
		case MDC_PLAYERS, MDC_PLAYER_STATS: MDC_ShowPage(playerid, MDC_PLAYER_RECORDS, .update_variables = true);
		case MDC_VEHICLES, MDC_VEHICLE_STATS: MDC_ShowPage(playerid, MDC_VEHICLE_RECORDS, .update_variables = true);
		case MDC_WEAPONS, MDC_WEAPON_STATS: MDC_ShowPage(playerid, MDC_WEAPON_RECORDS, .update_variables = true);
	}
	for(new i = 0; i < rows; i++)
	{
		format(number, sizeof number, "%d._", i+1);
		cache_get_value_name(i, "Date", date);
		cache_get_value_name(i, "Reason", string);
		strins(string, number, 0);
		PlayerTextDrawSetString(playerid, MDC_Record_Name[playerid][i], formatlt(string));
		PlayerTextDrawSetString(playerid, MDC_Record_Date[playerid][i], date);
		PlayerTextDrawShow(playerid, MDC_Record_Name[playerid][i]);
		PlayerTextDrawShow(playerid, MDC_Record_Date[playerid][i]);
	}
	return 1;
}

mdc_called OnWantedPageBack(playerid, current_page)
{
	new string[126];
	mysql_format(chandler, string, sizeof string, "SELECT * FROM `players_wanted` WHERE Active = '1' LIMIT "#MAX_WANTED_PER_PAGE_SELECT" OFFSET %d", MAX_WANTED_PER_PAGE*(current_page-1) );
	mysql_tquery(chandler, string, "OnFetchWantedList", "dd", playerid, current_page-1);
	return 1;
}
mdc_called OnWantedPageNext(playerid, current_page)
{
	new string[126];
	mysql_format(chandler, string, sizeof string, "SELECT * FROM `players_wanted` WHERE Active = '1' LIMIT "#MAX_WANTED_PER_PAGE_SELECT" OFFSET %d", MAX_WANTED_PER_PAGE*(current_page+1));
	mysql_tquery(chandler, string, "OnFetchWantedList", "dd", playerid, current_page+1);
	return 1;
}

forward OnFetchRecordData(playerid, page, lookupid);
public OnFetchRecordData(playerid, page, lookupid)
{
	if(cache_num_rows())
	{
		new 
			officername[24],
			reason[256],
			id,
			date[20],
			string[512];
		cache_get_value_name_int(0, "id", id);
		cache_get_value_name(0, "OfficerName", officername);
		cache_get_value_name(0, "Reason", reason);
		cache_get_value_name(0, "Date", date);
		format(string, sizeof string, "{BABABA}Áraðo numeris: {FFFFFF}%d\n{BABABA}Data: {FFFFFF}%s\n{BABABA}Pridëjo pareigûnas: {FFFFFF}%s\n{BABABA}Áraðas: {FFFFFF}%.40s\n%s", id, date, officername, reason, reason[40]);
		ShowPlayerDialog(playerid, DIALOG_NONE, DIALOG_STYLE_MSGBOX, "Áraðo informacija", string, "Gráþti", "");
	}
	else
	{
		SendWarning(playerid, "Ieðkant informacijos atsirado klaida (%d no rows).", lookupid);
	}
	return 1;
}

mdc_called OnRecordGoBack(playerid)
{
	new 
		page = MDC__Player_Data[playerid][pMdcActivePage];
	switch(page)
	{
		case MDC_PLAYER_RECORDS:
		{
			MDC_HidePage(playerid, MDC_PLAYER_RECORDS, .update_variables = false);
			MDC_SetHeader(playerid, MDC_GetHeaderName(playerid, MDC_PLAYERS, .add_root = true));
			MDC_ShowPage(playerid, MDC_PLAYERS, .update_variables = true);
		}
		case MDC_VEHICLE_RECORDS:
		{
			MDC_HidePage(playerid, MDC_VEHICLE_RECORDS, .update_variables = false);
			MDC_SetHeader(playerid, MDC_GetHeaderName(playerid, MDC_VEHICLES, .add_root = true));
			MDC_ShowPage(playerid, MDC_VEHICLES, .update_variables = true);
		}
		case MDC_WEAPON_RECORDS:
		{
			MDC_HidePage(playerid, MDC_WEAPON_RECORDS, .update_variables = false);
			MDC_SetHeader(playerid, MDC_GetHeaderName(playerid, MDC_WEAPONS, .add_root = true));
			MDC_ShowPage(playerid, MDC_WEAPONS, .update_variables = true);
		}
	}
	return 1;
}

mdc_called OnRecordSelected(playerid, record)
{
	new 
		string[126],
		page = MDC__Player_Data[playerid][pMdcActivePage],
		lookupid = MDC__Player_Data[playerid][pMdcLookupId];
	switch(page)
	{
		case MDC_PLAYER_RECORDS:
		{
			mysql_format(chandler, string, sizeof string, "SELECT * FROM `players_crimes` WHERE PlayerId = '%d' AND Valid = '1' LIMIT 1 OFFSET %d", lookupid, record);		
		}	
		case MDC_VEHICLE_RECORDS:
		{
			mysql_format(chandler, string, sizeof string, "SELECT * FROM `vehicles_crimes` WHERE VehicleId = '%d' AND Valid = '1' LIMIT 1 OFFSET %d", lookupid, record);
		}
		case MDC_WEAPON_RECORDS:
		{
			mysql_format(chandler, string, sizeof string, "SELECT * FROM `weapons_crimes` WHERE WeaponId = '%d' AND Valid = '1' LIMIT 1 OFFSET %d", lookupid, record);
		}
	}
	if(strlen(string)) mysql_tquery(chandler, string, "OnFetchRecordData", "ddd", playerid, page, lookupid);
	return 1;
}

mdc_called OnCellsOpenAll(playerid)
{
	for(new c = 0; c < sizeof PrisonCells; c++)
	{
		Cell_Open(c);
	}
	MDC_ShowPage(playerid, MDC_PRISON, .update_variables = false);
	return 1;
}

mdc_called OnCellsCloseAll(playerid)
{
	for(new c = 0; c < sizeof PrisonCells; c++)
	{
		Cell_Close(c);
	}
	MDC_ShowPage(playerid, MDC_PRISON, .update_variables = false);
	return 1;
}

mdc_called OnCellSelected(playerid, cell)
{
	new cell_string[22];
	if(PrisonCells[cell][cellDoorOpened])
	{
		Cell_Close(cell);
		format(cell_string, 22, "~g~%s CLOSED", PrisonCells[cell][cellName]);
		PlayerTextDrawSetString(playerid, MDC_Prison_CellStatus[playerid][cell], cell_string);
	}
	else
	{
		Cell_Open(cell);
		format(cell_string, 22, "~r~%s OPENED", PrisonCells[cell][cellName]);
		PlayerTextDrawSetString(playerid, MDC_Prison_CellStatus[playerid][cell], cell_string);
	}
	return 1;
}	

mdc_called OnWantedDeleteSelected(playerid, selected)
{
	new 
		string[126],
		id = MDC__Player_Data[playerid][pMdcWantedPlayers][selected];
	mysql_format(chandler, string, sizeof string, "DELETE FROM `players_wanted` WHERE id = '%d'", id);
	mysql_fquery(chandler, string, "WantedSaved");
	MDC_HidePage(playerid, MDC_WANTED_EDIT);
	MDC_SetHeader(playerid, MDC_GetHeaderName(playerid, MDC_WANTED));
	MDC_ShowPage(playerid, MDC_WANTED, .update_variables = true);
	// logs
	return 1;
}

mdc_called OnWantedClearSelected(playerid)
{
	format(MDC__Player_Data[playerid][pMdcWantedReason], 9, "Neivesta");
	format(MDC__Player_Data[playerid][pMdcWantedName], 9, "Neivesta");
	format(MDC__Player_Data[playerid][pMdcWantedLooks], 9, "Neivesta");
	format(MDC__Player_Data[playerid][pMdcWantedSeen], 9, "Neivesta");
	PlayerTextDrawSetString(playerid, MDC_WantedAddEdit_Name[playerid], "Neivesta");
	PlayerTextDrawSetString(playerid, MDC_WantedAddEdit_Looks[playerid], "Neivesta");
	PlayerTextDrawSetString(playerid, MDC_WantedAddEdit_Reason[playerid], "Neivesta");
	PlayerTextDrawSetString(playerid, MDC_WantedAddEdit_Seen[playerid], "Neivesta");
	PlayerTextDrawShow(playerid, MDC_WantedAddEdit_Name[playerid]);
	PlayerTextDrawShow(playerid, MDC_WantedAddEdit_Looks[playerid]);
	PlayerTextDrawShow(playerid, MDC_WantedAddEdit_Reason[playerid]);
	PlayerTextDrawShow(playerid, MDC_WantedAddEdit_Seen[playerid]);
	return 1;
}

mdc_called OnWantedInputNameSelected(playerid, page)
{
	MDC_Wanted_InputName(playerid);
	return 1;
}

mdc_called OnWantedInputSeenSelected(playerid, page)
{
	MDC_Wanted_InputSeen(playerid);
	return 1;
}

mdc_called OnWantedInputReasonSelected(playerid, page)
{
	MDC_Wanted_InputReason(playerid);
	return 1;
}

mdc_called OnWantedInputLooksSelected(playerid, page)
{
	MDC_Wanted_InputLooks(playerid);
	return 1;
}

mdc_called OnWantedPlayerSelected(playerid, selected)
{
	new 
		string[126],
		id = MDC__Player_Data[playerid][pMdcWantedPlayers][selected];
	MDC__Player_Data[playerid][pMdcWantedSelected] = selected;
	mysql_format(chandler, string, sizeof string, "SELECT * FROM `players_wanted` WHERE id = '%d' LIMIT 1", id);
	mysql_tquery(chandler, string, "OnFetchWantedPlayerData", "dd", playerid, id);
	return 1;
}

mdc_called OnMenuButtonPress(playerid, page)
{
	new active = MDC__Player_Data[playerid][pMdcActivePage];
	if(page != active)
	{
		MDC_SetUnactiveMenuButton(playerid, active, .reshow = true, .update_variables = false);
		MDC_SetActiveMenuButton(playerid, page, .reshow = true, .update_variables = true);
		MDC_SetHeader(playerid, MDC_GetHeaderName(playerid, page));
		MDC_HidePage(playerid, active, .update_variables = false);
		MDC_ShowPage(playerid, page, .update_variables = true);
	}
	return 1;
}

mdc_called OnExitPress(playerid)
{
	MDC_HideForPlayer(playerid);
	CancelSelectTextDraw(playerid);
	return 1;
}


mdc_called OnSearchTextPress(playerid, page)
{
	switch(page)
	{
		case MDC_PLAYERS, MDC_PLAYER_STATS:
		{
			// zaidejo iesko
			MDC_Lookup_InputPlayerName(playerid);
		}
		case MDC_VEHICLES, MDC_VEHICLE_STATS:
		{
			MDC_Lookup_InputVehicleName(playerid);
		}
		case MDC_WEAPONS, MDC_WEAPON_STATS:
		{
			MDC_Lookup_InputWeaponName(playerid);
		}
	}
	return 1;
}

mdc_called OnSearchPress(playerid, page, inputtext[])
{
	switch(page)
	{
		case MDC_PLAYERS, MDC_PLAYER_STATS:
		{
			if(strlen(inputtext) >= 3)
			{
				MDC_FetchPlayerIdByName(playerid, inputtext, MDC_FETCH_LIKE, .thread = true);
			}
			else
			{
				SendWarning(playerid, "Paieðkos tekstas turi bûti bent 3 simboliø ilgumo.");
			}
		}
		case MDC_VEHICLES, MDC_VEHICLE_STATS:
		{
			if(strlen(inputtext) >= 3)
			{
				MDC_FetchVehicleIdByNumbers(playerid, inputtext, .thread = true);
			}
			else
			{
				SendWarning(playerid, "Paieðkos tekstas turi bûti bent 3 simboliø ilgumo.");
			}
		}
		case MDC_WEAPONS, MDC_WEAPON_STATS:
		{
			if(strlen(inputtext) >= strlen(#DEFAULT_WEAPON_UNIQUE_ID_PREFIX))
			{
				MDC_FetchWeaponIdByUnique(playerid, inputtext, .thread = true);
			}
			else 
			{
				SendWarning(playerid, "Paieðkos tekstas turi bûti bent 3 simboliø ilgumo.");
			}
		}
	}
	return 1;
}

mdc_called Response(playerid, type, response, inputid, listitem, inputtext[])
{
	switch(type)
	{
		case 1:
		{
			// dialogas
			switch(inputid)
			{
				case MDC_INPUT_PLAYER_LOOKUP:
				{
					if(response)
					{
						new string[126];
						if(sscanf(inputtext,"s[126]",string)) return MDC_Lookup_InputPlayerName(playerid);
						else
						{
							format(MDC__Player_Data[playerid][pMdcInputText], 126, "%s", string);
							strdel(string, 56, strlen(string));
							strcat(string, "_");
							PlayerTextDrawSetString(playerid, MDC_Lookup_SearchText[playerid], string);
						}
					}
				}
				case MDC_INPUT_VEHICLE_LOOKUP:
				{
					if(response)
					{
						new string[126];
						if(sscanf(inputtext,"s[126]",string)) return MDC_Lookup_InputVehicleName(playerid);
						else
						{
							format(MDC__Player_Data[playerid][pMdcInputText], 126, "%s", string);
							strdel(string, 56, strlen(string));
							strcat(string, "_");
							PlayerTextDrawSetString(playerid, MDC_Lookup_SearchText[playerid], string);
						}
					}
				}
				case MDC_INPUT_WEAPON_LOOKUP:
				{
					if(response)
					{
						new string[126];
						if(sscanf(inputtext,"s[126]",string)) return MDC_Lookup_InputWeaponName(playerid);
						else
						{
							format(MDC__Player_Data[playerid][pMdcInputText], 126, "%s", string);
							strdel(string, 56, strlen(string));
							strcat(string, "_");
							PlayerTextDrawSetString(playerid, MDC_Lookup_SearchText[playerid], string);
						}
					}
				}
				case MDC_INPUT_WANTED_NAME:
				{
					if(response)
					{
						if(strlen(inputtext) <= 0 || strlen(inputtext) > 24 || strlen(inputtext) < 4) return MDC_Wanted_InputName(playerid);
						PlayerTextDrawSetString(playerid, MDC_WantedAddEdit_Name[playerid], formatlt(inputtext));
						format(MDC__Player_Data[playerid][pMdcWantedName], 24, inputtext);
					}
				}
				case MDC_INPUT_WANTED_LOOKS:
				{
					if(response)
					{
						if(strlen(inputtext) <= 0 || strlen(inputtext) > 108 || strlen(inputtext) < 4) return MDC_Wanted_InputLooks(playerid); 
						PlayerTextDrawSetString(playerid, MDC_WantedAddEdit_Looks[playerid], formatlt(inputtext));
						format(MDC__Player_Data[playerid][pMdcWantedLooks], 108, inputtext);
					}
				}
				case MDC_INPUT_WANTED_SEEN:
				{
					if(response)
					{
						if(strlen(inputtext) <= 0 || strlen(inputtext) > 108 || strlen(inputtext) < 4) return MDC_Wanted_InputSeen(playerid); 
						PlayerTextDrawSetString(playerid, MDC_WantedAddEdit_Seen[playerid], formatlt(inputtext));
						format(MDC__Player_Data[playerid][pMdcWantedSeen], 108, inputtext);
					}
				}
				case MDC_INPUT_WANTED_REASON:
				{
					if(response)
					{
						if(strlen(inputtext) <= 0 || strlen(inputtext) > 108 || strlen(inputtext) < 4) return MDC_Wanted_InputReason(playerid); 
						PlayerTextDrawSetString(playerid, MDC_WantedAddEdit_Reason[playerid], formatlt(inputtext));
						format(MDC__Player_Data[playerid][pMdcWantedReason], 108, inputtext);
					}
				}
				case MDC_INPUT_RECORD:
				{
					if(response)
					{
						// prideti iskaita
						if(strlen(inputtext) <= 0 || strlen(inputtext) > 256) return MDC_ShowPlayerDialog(playerid, MDC_INPUT_RECORD, DIALOG_STYLE_INPUT, "Áraðo pridëjimas", "{FFFFFF}Áveskite áraðà", "Pridëti", "Atðaukti"); 
						new 
							string[356],
							page = MDC__Player_Data[playerid][pMdcActivePage],
							lookupid = MDC__Player_Data[playerid][pMdcLookupId];
						switch(page)
						{
							case MDC_PLAYERS, MDC_PLAYER_RECORDS, MDC_PLAYER_STATS:
							{
								mysql_format(chandler, string, sizeof string, "INSERT INTO `players_crimes` (`OfficerName`,`PlayerId`,`Reason`,`Valid`) VALUES ('%e','%d','%e','1')", GetPlayerNameEx(playerid, false), lookupid, inputtext);		
							}
							case MDC_VEHICLES, MDC_VEHICLE_STATS, MDC_VEHICLE_RECORDS:
							{
								mysql_format(chandler, string, sizeof string, "INSERT INTO `vehicles_crimes` (`OfficerName`,`VehicleId`,`Reason`,`Valid`) VALUES ('%e','%d','%e','1')", GetPlayerNameEx(playerid, false), lookupid, inputtext);
							}
							case MDC_WEAPONS, MDC_WEAPON_STATS, MDC_WEAPON_RECORDS:
							{
								mysql_format(chandler, string, sizeof string, "INSERT INTO `weapons_crimes` (`OfficerName`,`WeaponId`,`Reason`,`Valid`) VALUES ('%e','%d','%e','1')", GetPlayerNameEx(playerid, false), lookupid, inputtext);
							}
						}
						if(strlen(string))
						{
							mysql_tquery(chandler, string, "OnRecordAdded", "d", playerid);
						}
						else
						{
							SendWarning(playerid, "Atsirado klaida pridedant áraðà.");
						}
					}
				}
			}
		}
	}
	return 1;
}

mdc_called OnWantedEditSelected(playerid, selected)
{
	new bool:cancel = false;
	if(strlen(MDC__Player_Data[playerid][pMdcWantedName]) < 4 || strlen(MDC__Player_Data[playerid][pMdcWantedName]) > 24) SendWarning(playerid, "Vardas turi bûti nuo 4 iki 24 simboliø (arba \"neivesta\")."), cancel = true;
	if(strlen(MDC__Player_Data[playerid][pMdcWantedReason]) < 4 || strlen(MDC__Player_Data[playerid][pMdcWantedReason]) > 108) SendWarning(playerid, "Prieþastis turi bûti nuo 4 iki 108 simboliø (arba \"neivesta\")."), cancel = true;
	if(strlen(MDC__Player_Data[playerid][pMdcWantedLooks]) < 4 || strlen(MDC__Player_Data[playerid][pMdcWantedLooks]) > 108) SendWarning(playerid, "Iðvaizda turi bûti nuo 4 iki 108 simboliø (arba \"neivesta\")."), cancel = true;
	if(strlen(MDC__Player_Data[playerid][pMdcWantedSeen]) < 4 || strlen(MDC__Player_Data[playerid][pMdcWantedSeen]) > 108) SendWarning(playerid, "P. kart. matytas turi bûti nuo 4 iki 108 simboliø (arba \"neivesta\")."), cancel = true;
	if(!cancel)
	{
		new string[512];
		mysql_format(chandler, string, sizeof string, "UPDATE `players_wanted` SET Name = '%e', Reason = '%e', Looks = '%e', Seen = '%e' WHERE id = '%d'", MDC__Player_Data[playerid][pMdcWantedName], MDC__Player_Data[playerid][pMdcWantedReason], MDC__Player_Data[playerid][pMdcWantedLooks], MDC__Player_Data[playerid][pMdcWantedSeen], MDC__Player_Data[playerid][pMdcWantedPlayers][selected]);
		mysql_fquery(chandler, string, "WantedSaved");
		MDC_HidePage(playerid, MDC__Player_Data[playerid][pMdcActivePage], .update_variables = false);
		MDC_ShowPage(playerid, MDC_WANTED, .update_variables = true);
		// logs
	}
	return 1;
}

mdc_called OnWantedAddSelected(playerid, selected)
{
	new bool:cancel = false;
	if(strlen(MDC__Player_Data[playerid][pMdcWantedName]) < 4 || strlen(MDC__Player_Data[playerid][pMdcWantedName]) > 24) SendWarning(playerid, "Vardas turi bûti nuo 4 iki 24 simboliø (arba \"neivesta\")."), cancel = true;
	if(strlen(MDC__Player_Data[playerid][pMdcWantedReason]) < 4 || strlen(MDC__Player_Data[playerid][pMdcWantedReason]) > 108) SendWarning(playerid, "Prieþastis turi bûti nuo 4 iki 108 simboliø (arba \"neivesta\")."), cancel = true;
	if(strlen(MDC__Player_Data[playerid][pMdcWantedLooks]) < 4 || strlen(MDC__Player_Data[playerid][pMdcWantedLooks]) > 108) SendWarning(playerid, "Iðvaizda turi bûti nuo 4 iki 108 simboliø (arba \"neivesta\")."), cancel = true;
	if(strlen(MDC__Player_Data[playerid][pMdcWantedSeen]) < 4 || strlen(MDC__Player_Data[playerid][pMdcWantedSeen]) > 108) SendWarning(playerid, "P. kart. matytas turi bûti nuo 4 iki 108 simboliø (arba \"neivesta\")."), cancel = true;
	if(!cancel)
	{
		new string[512];
		mysql_format(chandler, string, sizeof string, "INSERT INTO `players_wanted` (`Name`,`Reason`,`Looks`,`Seen`,`OfficerName`) VALUES ('%e','%e','%e','%e','%e')", MDC__Player_Data[playerid][pMdcWantedName], MDC__Player_Data[playerid][pMdcWantedReason], MDC__Player_Data[playerid][pMdcWantedLooks], MDC__Player_Data[playerid][pMdcWantedSeen], MDC__Player_Data[playerid][pMdcWantedPlayers][selected], GetPlayerNameEx(playerid, false));
		mysql_fquery(chandler, string, "WantedSaved");
		MDC_HidePage(playerid, MDC__Player_Data[playerid][pMdcActivePage], .update_variables = false);
		MDC_ShowPage(playerid, MDC_WANTED, .update_variables = true);
		// logs	
	}
	return 1;
}



mdc_called OnWantedGoAdd(playerid)
{
	MDC_HidePage(playerid, MDC__Player_Data[playerid][pMdcActivePage]);
	MDC_ShowPage(playerid, MDC_WANTED_ADD, .update_variables = true);
	return 1;
}

mdc_called OnCCTVSelect(playerid, cctv)
{
	if(CCTV_StartStream(playerid, cctv))
	{
		MDC_HidePage(playerid, MDC__Player_Data[playerid][pMdcActivePage], .update_variables = true);
		MDC_HideForPlayer(playerid);
		CancelSelectTextDraw(playerid);
		SendFormat(playerid, 0x7BC19EFF, "Norëdami baigti stebëti vaizdà per kamerà, raðykite /stopcctv");
	}
	return 1;
}