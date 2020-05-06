/*
 *
 * SAN ANDREAS MULTIPLAYER TEXTDRAW.PWN BY TOMAS TORKQ VOSYLIUS
 * ALL RIGHTS RESERVED
 * 2016
 *
 */

#include <YSI_Coding\y_hooks>

#define VL_SUCCESS_COLOR 1409243252
#define VL_DENIED_COLOR -12570764
#define CHARSELECT_COLOR	0xE6E5E5FF

// ===================================================
// Global
new Text:TD_ESC;

new Text:BorderHUD_Top,
	Text:BorderHUD_Bottom;

new Text:DMV_BgMain,
	Text:DMV_BgLeft,
	Text:DMV_BgRight,
	Text:DMV_NamesLeft,
	Text:DMV_Logo,
	Text:DMV_LogoEffect,
	Text:DMV_NamesRight,
	Text:DMV_InfoRight,
	Text:DMV_StartBg,
	Text:DMV_Start;

new Text:VL_Base,
	Text:VL_PageText,
	Text:VL_RowBase[4];

new Text:vShop_Base,
	Text:vShop_Name,
	Text:vShop_NextBase,
	Text:vShop_Next,
	Text:vShop_PrevBase,
	Text:vShop_Prev;

new Text:JailTimeTD_Bg,
	Text:JailTimeTD_Timer;

new Text:ATM_Background,
	Text:ATM_Screen,
	Text:ATM_Button[8],
	Text:ATM_Camera[2],
	Text:ATM_Action[4],
	Text:ATM_ActionName[4],
	Text:ATM_Name,
	Text:ATM_Line,
	Text:ATM_CurrentAction,
	Text:ATM_Effect1[4],
	Text:ATM_Effect2[4];

new Text:TipBox_Base,
	Text:TipBox_NameBase,
	Text:TipBox_Name,
	Text:TipBox_LowText;

new 
	Text:create_g_td_model_bg,
	Text:create_g_td_skin,
	Text:create_g_td_skin_txt,
	Text:create_g_td_age,
	Text:create_g_td_age_txt,
	Text:create_g_td_name_txt,
	Text:create_g_td_name,
	Text:create_g_td_origin_txt,
	Text:create_g_td_origin,
	Text:create_g_td_question[3],
	Text:create_g_td_question_bg[3],
	Text:create_g_td_send,
	Text:create_g_td_send_txt,
	Text:create_g_td_help,
	Text:create_g_td_back,
	Text:create_g_td_help_txt,
	Text:create_g_td_gender,
	Text:create_g_td_back_txt;

new Text:Furniture_LeftBorder,
	Text:Furniture_LeftBase,
	Text:Furniture_Left,
	Text:Furniture_RightBorder,
	Text:Furniture_RightBase,
	Text:Furniture_Right,
	Text:Furniture_UpBorder,
	Text:Furniture_UpBase,
	Text:Furniture_Up,
	Text:Furniture_DownBorder,
	Text:Furniture_DownBase,
	Text:Furniture_Down,
	Text:Furniture_BuyBorder,
	Text:Furniture_BuyBase,
	Text:Furniture_Buy,
	Text:Furniture_CloseBorder,
	Text:Furniture_CloseBase,
	Text:Furniture_Close,
	Text:Furniture_DataBase;

new Text:PayPhoneTD_Border,
	Text:PayPhoneTD_Background,
	Text:PayPhoneTD_Number[10],
	Text:PayPhoneTD_Small[3],
	Text:PayPhoneTD_Exit;

new Text:MechTune_Base,
	Text:MechTune_TextTop,
	Text:MechTune_BuyBase,
	Text:MechTune_CancelBase,
	Text:MechTune_BuyText,
	Text:MechTune_Shadow,
	Text:MechTune_Mega,
	Text:MechTune_Rimshine,
	Text:MechTune_Wires,
	Text:MechTune_Classic,
	Text:MechTune_Twist,
	Text:MechTune_Cutter,
	Text:MechTune_Switch,
	Text:MechTune_Grove,
	Text:MechTune_Import,
	Text:MechTune_Dollar,
	Text:MechTune_Trance,
	Text:MechTune_Atomic,
	Text:MechTune_Ahab,
	Text:MechTune_Virtual,
	Text:MechTune_Access,
	Text:MechTune_Offroad,
	Text:MechTune_Hidraulics,
	Text:MechTune_TextShadow,
	Text:MechTune_TextMega,
	Text:MechTune_TextRimshine,
	Text:MechTune_TextWires,
	Text:MechTune_TextClassic,
	Text:MechTune_TextTwist,
	Text:MechTune_TextCutter,
	Text:MechTune_TextSwitch,
	Text:MechTune_TextGrove,
	Text:MechTune_TextImport,
	Text:MechTune_TextDollar,
	Text:MechTune_TextTrance,
	Text:MechTune_TextAtomic,
	Text:MechTune_TextAhab,
	Text:MechTune_TextVirtual,
	Text:MechTune_TextAccess,
	Text:MechTune_TextOffroad,
	Text:MechTune_TextHidraulics;
	
new Text:JobGuiTD_Base;

new Text:DrugEffect[4];

new Text:SpamBarTD_Base,
	Text:SpamBarTD_LoadBase;

new Text:Phone_TopBorder,
	Text:Phone_BottomBorder,
	Text:Phone_BackgroundFill,
	Text:Phone_MainBackground,
	Text:Phone_TopBackground,
	Text:Phone_BottomBackground,
	Text:Phone_Speaker,
	Text:Phone_TopBarBackground,
	Text:Phone_Signal[3],
	Text:Phone_BottomDividers,
	Text:Phone_BottomMenu[3],
	Text:Phone_Accept1,
	Text:Phone_Accept2,
	Text:Phone_Decline1,
	Text:Phone_Decline2,
	Text:Phone_Button,
	Text:Phone_Menu[4],
	Text:Phone_MenuText[4],
	Text:Phone_DialTopBackground,
	Text:Phone_DialBottomBackground,
	Text:Phone_Numbers[12],
	Text:Phone_NumbersRow[4],
	Text:Phone_ContactPicBackground,
	Text:Phone_ContactPic,
	Text:Phone_SpeakerText,
	Text:Phone_SpeakerTog;

new Text:BlindfoldTD;

new Text:chars_g_td_mainbg,
	Text:chars_g_td_charbg[2],
	Text:chars_g_td_control[2],
	Text:chars_g_td_control_txt[2],
	Text:chars_g_td_play,
	Text:chars_g_td_info,
	Text:chars_g_td_donator,
	Text:chars_g_td_new,
	Text:chars_g_td_page_bg,
	Text:chars_g_td_page_back,
	Text:chars_g_td_page_next,
	Text:chars_g_td_page_back_txt,
	Text:chars_g_td_page_next_txt,
	Text:chars_g_td_play_txt,
	Text:chars_g_td_info_txt,
	Text:chars_g_td_donator_txt,
	Text:chars_g_td_new_txt;
// ===================================================
// Per-player
new PlayerText:tdWarning_Name[MAX_PLAYERS],
	PlayerText:tdWarning_Info[MAX_PLAYERS];

new PlayerText:vShop_CarName[MAX_PLAYERS][3],
	PlayerText:vShop_CarStats[MAX_PLAYERS][3],
	PlayerText:vShop_CarPrice[MAX_PLAYERS][3],
	PlayerText:vShop_Model[MAX_PLAYERS][3],
	PlayerText:vShop_BuyBase[MAX_PLAYERS],
	PlayerText:vShop_BuyText[MAX_PLAYERS],
	PlayerText:vShop_ModelBase[MAX_PLAYERS][3];

new PlayerText:JailTimeTD_Time[MAX_PLAYERS];

new PlayerText:DeathScreenTD[MAX_PLAYERS];

new PlayerText:chars_p_td_lessinfo[MAX_PLAYERS][2],
	PlayerText:chars_p_td_smallname[MAX_PLAYERS][2],
	PlayerText:chars_p_td_charskin[MAX_PLAYERS][2],
	PlayerText:chars_p_td_error[MAX_PLAYERS],
	PlayerText:chars_p_td_bigname[MAX_PLAYERS],
	PlayerText:chars_p_td_biginfo[MAX_PLAYERS],
	PlayerText:chars_p_td_page_txt[MAX_PLAYERS];

new	PlayerText:VL_RowText[MAX_PLAYERS][4],
	PlayerText:VL_SpawnBox[MAX_PLAYERS][4],
	PlayerText:VL_FindBox[MAX_PLAYERS][4],	
	PlayerText:VL_ModelBase[MAX_PLAYERS][4],
	PlayerText:VL_ModelName[MAX_PLAYERS][4],
	PlayerText:VL_FindText[MAX_PLAYERS][4],
	PlayerText:VL_SpawnText[MAX_PLAYERS][4],
	PlayerText:VL_NextBase[MAX_PLAYERS],
	PlayerText:VL_PrevBase[MAX_PLAYERS];

new PlayerText:TaxometerTD[MAX_PLAYERS];

new PlayerText:InfoBar[MAX_PLAYERS];

new PlayerText:MechTune_BasePart[MAX_PLAYERS][18];


new PlayerText:DMV_LicenseModel[MAX_PLAYERS],
	PlayerText:DMV_InfoLeft[MAX_PLAYERS],
	PlayerText:DMV_CarModel[MAX_PLAYERS];

new PlayerText:TipBox_Info[MAX_PLAYERS];
	
new PlayerText:Furniture_Data[MAX_PLAYERS];

new PlayerText:LoadBar_Base[MAX_PLAYERS],
	PlayerText:LoadBar_LoadFull[MAX_PLAYERS],
	PlayerText:LoadBar_Loaded[MAX_PLAYERS],
	PlayerText:LoadBar_Text[MAX_PLAYERS];


new PlayerText:JobGuiTD_TopText[MAX_PLAYERS],
	PlayerText:JobGuiTD_BotText[MAX_PLAYERS];

new PlayerText:SpamBarTD_Load[MAX_PLAYERS],
	PlayerText:SpamBarTD_Value[MAX_PLAYERS];

new PlayerText:Phone_Service[MAX_PLAYERS],
	PlayerText:Phone_Time[MAX_PLAYERS],
	PlayerText:Phone_Battery[MAX_PLAYERS],
	PlayerText:Phone_Estimated[MAX_PLAYERS],
	PlayerText:Phone_Contact[MAX_PLAYERS],
	PlayerText:Phone_NumberLine[MAX_PLAYERS],
	PlayerText:Phone_CallStatus[MAX_PLAYERS];

new PlayerText:PayPhoneTD_Input[MAX_PLAYERS],
	PlayerText:PayPhoneTD_Action[MAX_PLAYERS][2];

new PlayerText:create_p_td_age[MAX_PLAYERS],
	PlayerText:create_p_td_skin[MAX_PLAYERS],
	PlayerText:create_p_td_model[MAX_PLAYERS],
	PlayerText:create_p_td_name[MAX_PLAYERS],
	PlayerText:create_p_td_origin[MAX_PLAYERS],
	PlayerText:create_p_td_answer[MAX_PLAYERS][3],
	PlayerText:create_p_td_gender[MAX_PLAYERS];

stock CreateESCTextdraw()
{
	TD_ESC = TextDrawCreate(0.0, 0.0, " ");	
}

hook OnGameModeInit()
{
	CreateESCTextdraw();
	DrugsEffect_Create_Global();
	JobGuiTD_Create_Global();
	SpamBarTD_Create_Global();
	BorderHUD_Create_Global();
	PhoneTD_Create_Global();
	DMV_Create_Global();
	VLTextdraw_Create_Global();
	VShop_Create_Global();
	FurnitureTd_Create_Global();
	ATM_Create_Global();
	MechTune_Create_Global();
	JailTimeTD_Create_Global();
	TipBox_Create_Global();
	PayPhoneTD_Create_Global();
	BlindfoldTD_Create_Global();
	CharListTD_Create_Global();
	CharCreateTD_Create_Global();
	return 1;
}



stock BlindfoldTD_Create_Global()
{
	BlindfoldTD = TextDrawCreate(-20.000000,2.000000,"|");
    TextDrawUseBox(BlindfoldTD,1);
   	TextDrawBoxColor(BlindfoldTD,0x000000ff);
   	TextDrawTextSize(BlindfoldTD,660.000000,22.000000);
    TextDrawAlignment(BlindfoldTD,0);
   	TextDrawBackgroundColor(BlindfoldTD,0x000000ff);
    TextDrawFont(BlindfoldTD,3);
    TextDrawLetterSize(BlindfoldTD,1.000000,52.200000);
    TextDrawColor(BlindfoldTD,0x000000ff);
   	TextDrawSetOutline(BlindfoldTD,1);
    TextDrawSetProportional(BlindfoldTD,1);
    TextDrawSetShadow(BlindfoldTD,1);
}

hook OnPlayerConnect(playerid)
{
	TaxometerTD[playerid] = CreatePlayerTextDraw(playerid, 45.047412, 326.106597, "Taksometras:_0.00$");
	PlayerTextDrawLetterSize(playerid, TaxometerTD[playerid], 0.172952, 0.998400);
	PlayerTextDrawTextSize(playerid, TaxometerTD[playerid], 128.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TaxometerTD[playerid], 1);
	PlayerTextDrawColor(playerid, TaxometerTD[playerid], -93);
	PlayerTextDrawUseBox(playerid, TaxometerTD[playerid], 1);
	PlayerTextDrawBoxColor(playerid, TaxometerTD[playerid], 58);
	PlayerTextDrawBackgroundColor(playerid, TaxometerTD[playerid], 38);
	PlayerTextDrawFont(playerid, TaxometerTD[playerid], 2);
	PlayerTextDrawSetProportional(playerid, TaxometerTD[playerid], 1);
}

stock PayPhoneTD_Create_Player(playerid)
{
	PayPhoneTD_Input[playerid] = CreatePlayerTextDraw(playerid, 239.000000, 171.000000, "654222");
	PlayerTextDrawLetterSize(playerid, PayPhoneTD_Input[playerid], 0.345522, 1.783467);
	PlayerTextDrawTextSize(playerid, PayPhoneTD_Input[playerid], 412.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, PayPhoneTD_Input[playerid], 1);
	PlayerTextDrawColor(playerid, PayPhoneTD_Input[playerid], 348699647);
	PlayerTextDrawUseBox(playerid, PayPhoneTD_Input[playerid], 1);
	PlayerTextDrawBoxColor(playerid, PayPhoneTD_Input[playerid], 1847039);
	PlayerTextDrawSetShadow(playerid, PayPhoneTD_Input[playerid], 0);
	PlayerTextDrawSetOutline(playerid, PayPhoneTD_Input[playerid], 5);
	PlayerTextDrawBackgroundColor(playerid, PayPhoneTD_Input[playerid], 0);
	PlayerTextDrawFont(playerid, PayPhoneTD_Input[playerid], 2);
	PlayerTextDrawSetProportional(playerid, PayPhoneTD_Input[playerid], 1);
	PlayerTextDrawSetShadow(playerid, PayPhoneTD_Input[playerid], 0);

	PayPhoneTD_Action[playerid][0] = CreatePlayerTextDraw(playerid, 310.000000, 195.000000, "_SKAMBINTI");
	PlayerTextDrawLetterSize(playerid, PayPhoneTD_Action[playerid][0], 0.182857, 1.151998);
	PlayerTextDrawTextSize(playerid, PayPhoneTD_Action[playerid][0], 412.000000, 9.000000);
	PlayerTextDrawAlignment(playerid, PayPhoneTD_Action[playerid][0], 1);
	PlayerTextDrawColor(playerid, PayPhoneTD_Action[playerid][0], 112);
	PlayerTextDrawUseBox(playerid, PayPhoneTD_Action[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, PayPhoneTD_Action[playerid][0], 4259998);
	PlayerTextDrawSetShadow(playerid, PayPhoneTD_Action[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, PayPhoneTD_Action[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, PayPhoneTD_Action[playerid][0], 255);
	PlayerTextDrawFont(playerid, PayPhoneTD_Action[playerid][0], 2);
	PlayerTextDrawSetProportional(playerid, PayPhoneTD_Action[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, PayPhoneTD_Action[playerid][0], 0);
	PlayerTextDrawSetSelectable(playerid, PayPhoneTD_Action[playerid][0], true);

	PayPhoneTD_Action[playerid][1] = CreatePlayerTextDraw(playerid, 310.000000, 211.000000, "_ISTRINTI");
	PlayerTextDrawLetterSize(playerid, PayPhoneTD_Action[playerid][1], 0.182857, 1.151998);
	PlayerTextDrawTextSize(playerid, PayPhoneTD_Action[playerid][1], 412.000000, 9.000000);
	PlayerTextDrawAlignment(playerid, PayPhoneTD_Action[playerid][1], 1);
	PlayerTextDrawColor(playerid, PayPhoneTD_Action[playerid][1], 112);
	PlayerTextDrawUseBox(playerid, PayPhoneTD_Action[playerid][1], 1);
	PlayerTextDrawBoxColor(playerid, PayPhoneTD_Action[playerid][1], -1728053090);
	PlayerTextDrawSetShadow(playerid, PayPhoneTD_Action[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, PayPhoneTD_Action[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, PayPhoneTD_Action[playerid][1], 255);
	PlayerTextDrawFont(playerid, PayPhoneTD_Action[playerid][1], 2);
	PlayerTextDrawSetProportional(playerid, PayPhoneTD_Action[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, PayPhoneTD_Action[playerid][1], 0);
	PlayerTextDrawSetSelectable(playerid, PayPhoneTD_Action[playerid][1], true);
}

stock PayPhoneTD_Create_Global()
{
	PayPhoneTD_Border = TextDrawCreate(232.000000, 162.000000, "box");
	TextDrawLetterSize(PayPhoneTD_Border, 0.000000, 17.657142);
	TextDrawTextSize(PayPhoneTD_Border, 421.000000, 0.000000);
	TextDrawAlignment(PayPhoneTD_Border, 1);
	TextDrawColor(PayPhoneTD_Border, -18945);
	TextDrawUseBox(PayPhoneTD_Border, 1);
	TextDrawBoxColor(PayPhoneTD_Border, 1179010815);
	TextDrawSetShadow(PayPhoneTD_Border, 0);
	TextDrawSetOutline(PayPhoneTD_Border, 0);
	TextDrawBackgroundColor(PayPhoneTD_Border, 255);
	TextDrawFont(PayPhoneTD_Border, 1);
	TextDrawSetProportional(PayPhoneTD_Border, 1);
	TextDrawSetShadow(PayPhoneTD_Border, 0);

	PayPhoneTD_Background = TextDrawCreate(235.000000, 165.000000, "box");
	TextDrawLetterSize(PayPhoneTD_Background, 0.000000, 17.047618);
	TextDrawTextSize(PayPhoneTD_Background, 418.000000, 0.000000);
	TextDrawAlignment(PayPhoneTD_Background, 1);
	TextDrawColor(PayPhoneTD_Background, -1);
	TextDrawUseBox(PayPhoneTD_Background, 1);
	TextDrawBoxColor(PayPhoneTD_Background, -926365441);
	TextDrawSetShadow(PayPhoneTD_Background, 0);
	TextDrawSetOutline(PayPhoneTD_Background, 0);
	TextDrawBackgroundColor(PayPhoneTD_Background, 255);
	TextDrawFont(PayPhoneTD_Background, 1);
	TextDrawSetProportional(PayPhoneTD_Background, 0);
	TextDrawSetShadow(PayPhoneTD_Background, 0);

	PayPhoneTD_Number[0] = TextDrawCreate(248.000000, 195.000000, "1");
	PayPhoneTD_Number[1] = TextDrawCreate(271.000000, 195.000000, "2");
	PayPhoneTD_Number[2] = TextDrawCreate(294.000000, 195.000000, "3");
	PayPhoneTD_Number[3] = TextDrawCreate(248.000000, 219.000000, "4");
	PayPhoneTD_Number[4] = TextDrawCreate(271.000000, 219.000000, "5");
	PayPhoneTD_Number[5] = TextDrawCreate(294.000000, 219.000000, "6");
	PayPhoneTD_Number[6] = TextDrawCreate(248.000000, 243.000000, "7");
	PayPhoneTD_Number[7] = TextDrawCreate(271.000000, 243.000000, "8");
	PayPhoneTD_Number[8] = TextDrawCreate(294.000000, 243.000000, "9");
	PayPhoneTD_Number[9] = TextDrawCreate(248.000000, 267.000000, "0");

	for(new i = 0; i < 10; i++)
	{
		TextDrawLetterSize(PayPhoneTD_Number[i], 0.413713, 1.949866);
		TextDrawTextSize(PayPhoneTD_Number[i], 13.500000, 17.000000);
		TextDrawAlignment(PayPhoneTD_Number[i], 2);
		TextDrawColor(PayPhoneTD_Number[i], 505290495);
		TextDrawUseBox(PayPhoneTD_Number[i], 1);
		TextDrawBoxColor(PayPhoneTD_Number[i], 92);
		TextDrawSetShadow(PayPhoneTD_Number[i], 0);
		TextDrawSetOutline(PayPhoneTD_Number[i], 0);
		TextDrawBackgroundColor(PayPhoneTD_Number[i], 255);
		TextDrawFont(PayPhoneTD_Number[i], 1);
		TextDrawSetProportional(PayPhoneTD_Number[i], 1);
		TextDrawSetShadow(PayPhoneTD_Number[i], 0);
		TextDrawSetSelectable(PayPhoneTD_Number[i], true);
	}

	PayPhoneTD_Exit = TextDrawCreate(248.000000, 300.000000, "X");
	TextDrawLetterSize(PayPhoneTD_Exit, 0.213713, 0.999866);
	TextDrawTextSize(PayPhoneTD_Exit, 13.500000, 17.000000);
	TextDrawAlignment(PayPhoneTD_Exit, 2);
	TextDrawColor(PayPhoneTD_Exit, 0xFF000077);
	TextDrawUseBox(PayPhoneTD_Exit, 0);
	TextDrawBoxColor(PayPhoneTD_Exit, 92);
	TextDrawSetShadow(PayPhoneTD_Exit, 0);
	TextDrawSetOutline(PayPhoneTD_Exit, 0);
	TextDrawBackgroundColor(PayPhoneTD_Exit, 255);
	TextDrawFont(PayPhoneTD_Exit, 1);
	TextDrawSetProportional(PayPhoneTD_Exit, 1);
	TextDrawSetShadow(PayPhoneTD_Exit, 0);
	TextDrawSetSelectable(PayPhoneTD_Exit, true);
	

	PayPhoneTD_Small[0] = TextDrawCreate(386.000000, 145.000000, ".");
	TextDrawLetterSize(PayPhoneTD_Small[0], 0.351999, 18.914133);
	TextDrawAlignment(PayPhoneTD_Small[0], 1);
	TextDrawColor(PayPhoneTD_Small[0], 214);
	TextDrawSetShadow(PayPhoneTD_Small[0], 1);
	TextDrawSetOutline(PayPhoneTD_Small[0], 0);
	TextDrawBackgroundColor(PayPhoneTD_Small[0], 20);
	TextDrawFont(PayPhoneTD_Small[0], 1);
	TextDrawSetProportional(PayPhoneTD_Small[0], 1);
	TextDrawSetShadow(PayPhoneTD_Small[0], 1);

	PayPhoneTD_Small[1] = TextDrawCreate(324.000000, 248.000000, "~n~~n~___PINIGUS___~n~___DETI_CIA:~n~~n~~n~");
	TextDrawLetterSize(PayPhoneTD_Small[1], 0.224380, 0.989866);
	TextDrawTextSize(PayPhoneTD_Small[1], 412.000000, 0.000000);
	TextDrawAlignment(PayPhoneTD_Small[1], 1);
	TextDrawColor(PayPhoneTD_Small[1], 926365695);
	TextDrawUseBox(PayPhoneTD_Small[1], 1);
	TextDrawBoxColor(PayPhoneTD_Small[1], 45);
	TextDrawSetShadow(PayPhoneTD_Small[1], 0);
	TextDrawSetOutline(PayPhoneTD_Small[1], 0);
	TextDrawBackgroundColor(PayPhoneTD_Small[1], 255);
	TextDrawFont(PayPhoneTD_Small[1], 1);
	TextDrawSetProportional(PayPhoneTD_Small[1], 1);
	TextDrawSetShadow(PayPhoneTD_Small[1], 0);

	PayPhoneTD_Small[2] = TextDrawCreate(371.000000, 268.000000, "~>~");
	TextDrawLetterSize(PayPhoneTD_Small[2], 0.359999, 1.156265);
	TextDrawAlignment(PayPhoneTD_Small[2], 1);
	TextDrawColor(PayPhoneTD_Small[2], -83885825);
	TextDrawSetShadow(PayPhoneTD_Small[2], 0);
	TextDrawSetOutline(PayPhoneTD_Small[2], 0);
	TextDrawBackgroundColor(PayPhoneTD_Small[2], 255);
	TextDrawFont(PayPhoneTD_Small[2], 1);
	TextDrawSetProportional(PayPhoneTD_Small[2], 0);
	TextDrawSetShadow(PayPhoneTD_Small[2], 0);
}

/*
stock MDC_Create_Global()
{
	MDC_MainBackground = TextDrawCreate(153.238128, 128.560043, "mainbg");
	TextDrawLetterSize(MDC_MainBackground, 0.000000, 26.495243);
	TextDrawTextSize(MDC_MainBackground, 496.000000, 0.000000);
	TextDrawAlignment(MDC_MainBackground, 1);
	TextDrawColor(MDC_MainBackground, -16897);
	TextDrawUseBox(MDC_MainBackground, 1);
	TextDrawBoxColor(MDC_MainBackground, 2105376255);
	TextDrawSetShadow(MDC_MainBackground, 0);
	TextDrawSetOutline(MDC_MainBackground, 0);
	TextDrawBackgroundColor(MDC_MainBackground, 255);
	TextDrawFont(MDC_MainBackground, 1);
	TextDrawSetProportional(MDC_MainBackground, 1);
	TextDrawSetShadow(MDC_MainBackground, 0);

	MDC_HeaderBackground = TextDrawCreate(155.000000, 130.000000, "melynasheader");
	TextDrawLetterSize(MDC_HeaderBackground, 0.000000, 0.780951);
	TextDrawTextSize(MDC_HeaderBackground, 494.211181, 0.000000);
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

	MDC_ExitButton = TextDrawCreate(487.000000, 130.000000, "LD_SPAC:white");
	TextDrawLetterSize(MDC_ExitButton, 0.000000, 0.000000);
	TextDrawTextSize(MDC_ExitButton, 7.000000, 7.000000);
	TextDrawAlignment(MDC_ExitButton, 1);
	TextDrawColor(MDC_ExitButton, -1644166913);
	TextDrawSetShadow(MDC_ExitButton, 0);
	TextDrawSetOutline(MDC_ExitButton, 0);
	TextDrawBackgroundColor(MDC_ExitButton, 255);
	TextDrawFont(MDC_ExitButton, 4);
	TextDrawSetProportional(MDC_ExitButton, 0);
	TextDrawSetShadow(MDC_ExitButton, 0);
	TextDrawSetSelectable(MDC_ExitButton, true);

	MDC_ExitText = TextDrawCreate(488.000000, 130.000000, "X");
	TextDrawLetterSize(MDC_ExitText, 0.203428, 0.746666);
	TextDrawAlignment(MDC_ExitText, 1);
	TextDrawColor(MDC_ExitText, -724249345);
	TextDrawSetShadow(MDC_ExitText, 0);
	TextDrawSetOutline(MDC_ExitText, 0);
	TextDrawBackgroundColor(MDC_ExitText, 255);
	TextDrawFont(MDC_ExitText, 2);
	TextDrawSetProportional(MDC_ExitText, 1);
	TextDrawSetShadow(MDC_ExitText, 0);

	MDC_MenuSeparate1 = TextDrawCreate(155.650039, 166.000000, "menu atskiria apacia");
	TextDrawLetterSize(MDC_MenuSeparate1, 0.000000, -0.247620);
	TextDrawTextSize(MDC_MenuSeparate1, 214.018890, 0.000000);
	TextDrawAlignment(MDC_MenuSeparate1, 1);
	TextDrawColor(MDC_MenuSeparate1, -156);
	TextDrawUseBox(MDC_MenuSeparate1, 1);
	TextDrawBoxColor(MDC_MenuSeparate1, 15);
	TextDrawSetShadow(MDC_MenuSeparate1, 0);
	TextDrawSetOutline(MDC_MenuSeparate1, 0);
	TextDrawBackgroundColor(MDC_MenuSeparate1, 255);
	TextDrawFont(MDC_MenuSeparate1, 1);
	TextDrawSetProportional(MDC_MenuSeparate1, 1);
	TextDrawSetShadow(MDC_MenuSeparate1, 0);

	MDC_MenuSeparateSide = TextDrawCreate(217.149948, 142.949996, "menu atskiria");
	TextDrawLetterSize(MDC_MenuSeparateSide, 0.000000, 11.942858);
	TextDrawTextSize(MDC_MenuSeparateSide, 215.149948, 0.000000);
	TextDrawAlignment(MDC_MenuSeparateSide, 1);
	TextDrawColor(MDC_MenuSeparateSide, -156);
	TextDrawUseBox(MDC_MenuSeparateSide, 1);
	TextDrawBoxColor(MDC_MenuSeparateSide, 15);
	TextDrawSetShadow(MDC_MenuSeparateSide, 0);
	TextDrawSetOutline(MDC_MenuSeparateSide, 0);
	TextDrawBackgroundColor(MDC_MenuSeparateSide, 255);
	TextDrawFont(MDC_MenuSeparateSide, 1);
	TextDrawSetProportional(MDC_MenuSeparateSide, 1);
	TextDrawSetShadow(MDC_MenuSeparateSide, 0);

	MDC_MenuSeparate2 = TextDrawCreate(155.699981, 214.699981, "menu atskiria apacia");
	TextDrawLetterSize(MDC_MenuSeparate2, 0.000000, -0.247620);
	TextDrawTextSize(MDC_MenuSeparate2, 215.000000, 0.000000);
	TextDrawAlignment(MDC_MenuSeparate2, 1);
	TextDrawColor(MDC_MenuSeparate2, -156);
	TextDrawUseBox(MDC_MenuSeparate2, 1);
	TextDrawBoxColor(MDC_MenuSeparate2, 15);
	TextDrawSetShadow(MDC_MenuSeparate2, 0);
	TextDrawSetOutline(MDC_MenuSeparate2, 0);
	TextDrawBackgroundColor(MDC_MenuSeparate2, 255);
	TextDrawFont(MDC_MenuSeparate2, 1);
	TextDrawSetProportional(MDC_MenuSeparate2, 1);
	TextDrawSetShadow(MDC_MenuSeparate2, 0);
}

stock MDC_Create_Player(playerid)
{
	MDC_HeaderText[playerid] = CreatePlayerTextDraw(playerid, 155.200012, 128.849990, "Red_County_Police_Department");
	PlayerTextDrawLetterSize(playerid, MDC_HeaderText[playerid], 0.213952, 0.916133);
	PlayerTextDrawAlignment(playerid, MDC_HeaderText[playerid], 1);
	PlayerTextDrawColor(playerid, MDC_HeaderText[playerid], -1);
	PlayerTextDrawSetShadow(playerid, MDC_HeaderText[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MDC_HeaderText[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_HeaderText[playerid], 255);
	PlayerTextDrawFont(playerid, MDC_HeaderText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDC_HeaderText[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDC_HeaderText[playerid], 0);

	MDC_MenuButton[playerid][0] = CreatePlayerTextDraw(playerid, 154.000000, 141.000000, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, MDC_MenuButton[playerid][0], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_MenuButton[playerid][0], 60.000000, 10.000000);
	PlayerTextDrawAlignment(playerid, MDC_MenuButton[playerid][0], 1);
	PlayerTextDrawColor(playerid, MDC_MenuButton[playerid][0], -1515870721);
	PlayerTextDrawSetShadow(playerid, MDC_MenuButton[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, MDC_MenuButton[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_MenuButton[playerid][0], 255);
	PlayerTextDrawFont(playerid, MDC_MenuButton[playerid][0], 4);
	PlayerTextDrawSetProportional(playerid, MDC_MenuButton[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, MDC_MenuButton[playerid][0], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_MenuButton[playerid][0], true);	

	MDC_MenuText[playerid][0] = CreatePlayerTextDraw(playerid, 184.000000, 141.449966, "PAGRINDINIS");
	PlayerTextDrawLetterSize(playerid, MDC_MenuText[playerid][0], 0.129904, 0.823466);
	PlayerTextDrawAlignment(playerid, MDC_MenuText[playerid][0], 2);
	PlayerTextDrawColor(playerid, MDC_MenuText[playerid][0], 1061109759);
	PlayerTextDrawSetShadow(playerid, MDC_MenuText[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, MDC_MenuText[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_MenuText[playerid][0], 255);
	PlayerTextDrawFont(playerid, MDC_MenuText[playerid][0], 2);
	PlayerTextDrawSetProportional(playerid, MDC_MenuText[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, MDC_MenuText[playerid][0], 0);

	MDC_MenuButton[playerid][1] = CreatePlayerTextDraw(playerid, 154.000000, 152.000000, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, MDC_MenuButton[playerid][1], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_MenuButton[playerid][1], 60.000000, 10.000000);
	PlayerTextDrawAlignment(playerid, MDC_MenuButton[playerid][1], 1);
	PlayerTextDrawColor(playerid, MDC_MenuButton[playerid][1], -1515870721);
	PlayerTextDrawSetShadow(playerid, MDC_MenuButton[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, MDC_MenuButton[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_MenuButton[playerid][1], 255);
	PlayerTextDrawFont(playerid, MDC_MenuButton[playerid][1], 4);
	PlayerTextDrawSetProportional(playerid, MDC_MenuButton[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, MDC_MenuButton[playerid][1], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_MenuButton[playerid][1], true);	

	MDC_MenuText[playerid][1] = CreatePlayerTextDraw(playerid, 184.199951, 152.649978, "paieska");
	PlayerTextDrawLetterSize(playerid, MDC_MenuText[playerid][1], 0.129904, 0.823466);
	PlayerTextDrawAlignment(playerid, MDC_MenuText[playerid][1], 2);
	PlayerTextDrawColor(playerid, MDC_MenuText[playerid][1], 1061109759);
	PlayerTextDrawSetShadow(playerid, MDC_MenuText[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, MDC_MenuText[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_MenuText[playerid][1], 255);
	PlayerTextDrawFont(playerid, MDC_MenuText[playerid][1], 2);
	PlayerTextDrawSetProportional(playerid, MDC_MenuText[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, MDC_MenuText[playerid][1], 0);

	MDC_MenuButton[playerid][2] = CreatePlayerTextDraw(playerid, 154.000000, 167.350021, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, MDC_MenuButton[playerid][2], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_MenuButton[playerid][2], 60.000000, 10.000000);
	PlayerTextDrawAlignment(playerid, MDC_MenuButton[playerid][2], 1);
	PlayerTextDrawColor(playerid, MDC_MenuButton[playerid][2], -1515870721);
	PlayerTextDrawSetShadow(playerid, MDC_MenuButton[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, MDC_MenuButton[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_MenuButton[playerid][2], 255);
	PlayerTextDrawFont(playerid, MDC_MenuButton[playerid][2], 4);
	PlayerTextDrawSetProportional(playerid, MDC_MenuButton[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, MDC_MenuButton[playerid][2], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_MenuButton[playerid][2], true);

	MDC_MenuText[playerid][2] = CreatePlayerTextDraw(playerid, 184.549972, 168.350021, "ieskomi");
	PlayerTextDrawLetterSize(playerid, MDC_MenuText[playerid][2], 0.129904, 0.823466);
	PlayerTextDrawAlignment(playerid, MDC_MenuText[playerid][2], 2);
	PlayerTextDrawColor(playerid, MDC_MenuText[playerid][2], 1061109759);
	PlayerTextDrawSetShadow(playerid, MDC_MenuText[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, MDC_MenuText[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_MenuText[playerid][2], 255);
	PlayerTextDrawFont(playerid, MDC_MenuText[playerid][2], 2);
	PlayerTextDrawSetProportional(playerid, MDC_MenuText[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, MDC_MenuText[playerid][2], 0);

	MDC_MenuButton[playerid][3] = CreatePlayerTextDraw(playerid, 154.000000, 178.499969, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, MDC_MenuButton[playerid][3], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_MenuButton[playerid][3], 60.000000, 10.000000);
	PlayerTextDrawAlignment(playerid, MDC_MenuButton[playerid][3], 1);
	PlayerTextDrawColor(playerid, MDC_MenuButton[playerid][3], -1515870721);
	PlayerTextDrawSetShadow(playerid, MDC_MenuButton[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, MDC_MenuButton[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_MenuButton[playerid][3], 255);
	PlayerTextDrawFont(playerid, MDC_MenuButton[playerid][3], 4);
	PlayerTextDrawSetProportional(playerid, MDC_MenuButton[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, MDC_MenuButton[playerid][3], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_MenuButton[playerid][3], true);

	MDC_MenuText[playerid][3] = CreatePlayerTextDraw(playerid, 185.000000, 179.000000, "GYVENTOJAI");
	PlayerTextDrawLetterSize(playerid, MDC_MenuText[playerid][3], 0.129904, 0.823466);
	PlayerTextDrawAlignment(playerid, MDC_MenuText[playerid][3], 2);
	PlayerTextDrawColor(playerid, MDC_MenuText[playerid][3], 1061109759);
	PlayerTextDrawSetShadow(playerid, MDC_MenuText[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, MDC_MenuText[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_MenuText[playerid][3], 255);
	PlayerTextDrawFont(playerid, MDC_MenuText[playerid][3], 2);
	PlayerTextDrawSetProportional(playerid, MDC_MenuText[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, MDC_MenuText[playerid][3], 0);

	MDC_MenuButton[playerid][4] = CreatePlayerTextDraw(playerid, 154.000000, 189.549972, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, MDC_MenuButton[playerid][4], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_MenuButton[playerid][4], 60.000000, 10.000000);
	PlayerTextDrawAlignment(playerid, MDC_MenuButton[playerid][4], 1);
	PlayerTextDrawColor(playerid, MDC_MenuButton[playerid][4], -1515870721);
	PlayerTextDrawSetShadow(playerid, MDC_MenuButton[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, MDC_MenuButton[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_MenuButton[playerid][4], 255);
	PlayerTextDrawFont(playerid, MDC_MenuButton[playerid][4], 4);
	PlayerTextDrawSetProportional(playerid, MDC_MenuButton[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, MDC_MenuButton[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_MenuButton[playerid][4], true);

	MDC_MenuText[playerid][4] = CreatePlayerTextDraw(playerid, 185.000000, 190.200012, "TR._PRIEMONES");
	PlayerTextDrawLetterSize(playerid, MDC_MenuText[playerid][4], 0.129904, 0.823466);
	PlayerTextDrawAlignment(playerid, MDC_MenuText[playerid][4], 2);
	PlayerTextDrawColor(playerid, MDC_MenuText[playerid][4], 1061109759);
	PlayerTextDrawSetShadow(playerid, MDC_MenuText[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, MDC_MenuText[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_MenuText[playerid][4], 255);
	PlayerTextDrawFont(playerid, MDC_MenuText[playerid][4], 2);
	PlayerTextDrawSetProportional(playerid, MDC_MenuText[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, MDC_MenuText[playerid][4], 0);

	MDC_MenuButton[playerid][5] = CreatePlayerTextDraw(playerid, 154.000000, 200.599975, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, MDC_MenuButton[playerid][5], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_MenuButton[playerid][5], 60.000000, 10.000000);
	PlayerTextDrawAlignment(playerid, MDC_MenuButton[playerid][5], 1);
	PlayerTextDrawColor(playerid, MDC_MenuButton[playerid][5], -1515870721);
	PlayerTextDrawSetShadow(playerid, MDC_MenuButton[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, MDC_MenuButton[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_MenuButton[playerid][5], 255);
	PlayerTextDrawFont(playerid, MDC_MenuButton[playerid][5], 4);
	PlayerTextDrawSetProportional(playerid, MDC_MenuButton[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, MDC_MenuButton[playerid][5], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_MenuButton[playerid][5], true);

	MDC_MenuText[playerid][5] = CreatePlayerTextDraw(playerid, 185.000000, 201.599975, "GINKLAI");
	PlayerTextDrawLetterSize(playerid, MDC_MenuText[playerid][5], 0.129904, 0.823466);
	PlayerTextDrawAlignment(playerid, MDC_MenuText[playerid][5], 2);
	PlayerTextDrawColor(playerid, MDC_MenuText[playerid][5], 1061109759);
	PlayerTextDrawSetShadow(playerid, MDC_MenuText[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, MDC_MenuText[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_MenuText[playerid][5], 255);
	PlayerTextDrawFont(playerid, MDC_MenuText[playerid][5], 2);
	PlayerTextDrawSetProportional(playerid, MDC_MenuText[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, MDC_MenuText[playerid][5], 0);

	MDC_MenuButton[playerid][6] = CreatePlayerTextDraw(playerid, 154.000000, 216.000000, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, MDC_MenuButton[playerid][6], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_MenuButton[playerid][6], 60.000000, 10.000000);
	PlayerTextDrawAlignment(playerid, MDC_MenuButton[playerid][6], 1);
	PlayerTextDrawColor(playerid, MDC_MenuButton[playerid][6], -1515870721);
	PlayerTextDrawSetShadow(playerid, MDC_MenuButton[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, MDC_MenuButton[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_MenuButton[playerid][6], 255);
	PlayerTextDrawFont(playerid, MDC_MenuButton[playerid][6], 4);
	PlayerTextDrawSetProportional(playerid, MDC_MenuButton[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, MDC_MenuButton[playerid][6], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_MenuButton[playerid][6], true);

	MDC_MenuText[playerid][6] = CreatePlayerTextDraw(playerid, 185.000000, 217.000000, "cctv");
	PlayerTextDrawLetterSize(playerid, MDC_MenuText[playerid][6], 0.129904, 0.823466);
	PlayerTextDrawAlignment(playerid, MDC_MenuText[playerid][6], 2);
	PlayerTextDrawColor(playerid, MDC_MenuText[playerid][6], 1061109759);
	PlayerTextDrawSetShadow(playerid, MDC_MenuText[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, MDC_MenuText[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_MenuText[playerid][6], 255);
	PlayerTextDrawFont(playerid, MDC_MenuText[playerid][6], 2);
	PlayerTextDrawSetProportional(playerid, MDC_MenuText[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, MDC_MenuText[playerid][6], 0);

	MDC_MenuButton[playerid][7] = CreatePlayerTextDraw(playerid, 154.000000, 227.000000, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, MDC_MenuButton[playerid][7], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_MenuButton[playerid][7], 60.000000, 10.000000);
	PlayerTextDrawAlignment(playerid, MDC_MenuButton[playerid][7], 1);
	PlayerTextDrawColor(playerid, MDC_MenuButton[playerid][7], -1515870721);
	PlayerTextDrawSetShadow(playerid, MDC_MenuButton[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, MDC_MenuButton[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_MenuButton[playerid][7], 255);
	PlayerTextDrawFont(playerid, MDC_MenuButton[playerid][7], 4);
	PlayerTextDrawSetProportional(playerid, MDC_MenuButton[playerid][7], 0);
	PlayerTextDrawSetShadow(playerid, MDC_MenuButton[playerid][7], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_MenuButton[playerid][7], true);

	MDC_MenuText[playerid][7] = CreatePlayerTextDraw(playerid, 185.000000, 228.000000, "DARBUOTOJAI");
	PlayerTextDrawLetterSize(playerid, MDC_MenuText[playerid][7], 0.129904, 0.823466);
	PlayerTextDrawAlignment(playerid, MDC_MenuText[playerid][7], 2);
	PlayerTextDrawColor(playerid, MDC_MenuText[playerid][7], 1061109759);
	PlayerTextDrawSetShadow(playerid, MDC_MenuText[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, MDC_MenuText[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_MenuText[playerid][7], 255);
	PlayerTextDrawFont(playerid, MDC_MenuText[playerid][7], 2);
	PlayerTextDrawSetProportional(playerid, MDC_MenuText[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, MDC_MenuText[playerid][7], 0);
}*/
	


stock DrugsEffect_Create_Global()
{
	DrugEffect[0] = TextDrawCreate(0.000000, 0.000000, "box");
	TextDrawLetterSize(DrugEffect[0], 0.000000, 51.028507);
	TextDrawTextSize(DrugEffect[0], 662.000000, 0.000000);
	TextDrawAlignment(DrugEffect[0], 1);
	TextDrawColor(DrugEffect[0], -1);
	TextDrawUseBox(DrugEffect[0], 1);
	TextDrawBoxColor(DrugEffect[0], 0xE40A0A11);
	TextDrawSetShadow(DrugEffect[0], 0);
	TextDrawSetOutline(DrugEffect[0], 0);
	TextDrawBackgroundColor(DrugEffect[0], 255);
	TextDrawFont(DrugEffect[0], 1);
	TextDrawSetProportional(DrugEffect[0], 1);
	TextDrawSetShadow(DrugEffect[0], 0);

	DrugEffect[1] = TextDrawCreate(0.000000, 0.000000, "box");
	TextDrawLetterSize(DrugEffect[1], 0.000000, 51.028507);
	TextDrawTextSize(DrugEffect[1], 662.000000, 0.000000);
	TextDrawAlignment(DrugEffect[1], 1);
	TextDrawColor(DrugEffect[1], -1);
	TextDrawUseBox(DrugEffect[1], 1);
	TextDrawBoxColor(DrugEffect[1], 0xDF661011);
	TextDrawSetShadow(DrugEffect[1], 0);
	TextDrawSetOutline(DrugEffect[1], 0);
	TextDrawBackgroundColor(DrugEffect[1], 255);
	TextDrawFont(DrugEffect[1], 1);
	TextDrawSetProportional(DrugEffect[1], 1);
	TextDrawSetShadow(DrugEffect[1], 0);

	DrugEffect[2] = TextDrawCreate(0.000000, 0.000000, "box");
	TextDrawLetterSize(DrugEffect[2], 0.000000, 51.028507);
	TextDrawTextSize(DrugEffect[2], 662.000000, 0.000000);
	TextDrawAlignment(DrugEffect[2], 1);
	TextDrawColor(DrugEffect[2], -1);
	TextDrawUseBox(DrugEffect[2], 1);
	TextDrawBoxColor(DrugEffect[2], 0xA0DC3011);
	TextDrawSetShadow(DrugEffect[2], 0);
	TextDrawSetOutline(DrugEffect[2], 0);
	TextDrawBackgroundColor(DrugEffect[2], 255);
	TextDrawFont(DrugEffect[2], 1);
	TextDrawSetProportional(DrugEffect[2], 1);
	TextDrawSetShadow(DrugEffect[2], 0);

	DrugEffect[3] = TextDrawCreate(0.000000, 0.000000, "box");
	TextDrawLetterSize(DrugEffect[3], 0.000000, 51.028507);
	TextDrawTextSize(DrugEffect[3], 662.000000, 0.000000);
	TextDrawAlignment(DrugEffect[3], 1);
	TextDrawColor(DrugEffect[3], -1);
	TextDrawUseBox(DrugEffect[3], 1);
	TextDrawBoxColor(DrugEffect[3], 0x2479E111);
	TextDrawSetShadow(DrugEffect[3], 0);
	TextDrawSetOutline(DrugEffect[3], 0);
	TextDrawBackgroundColor(DrugEffect[3], 255);
	TextDrawFont(DrugEffect[3], 1);
	TextDrawSetProportional(DrugEffect[3], 0);
	TextDrawSetShadow(DrugEffect[3], 0);
}

stock DeathScreen_Create_Player(playerid)
{
	DeathScreenTD[playerid] = CreatePlayerTextDraw(playerid, 320.857269, 201.093322, "_~n~~w~KOMOS_BUSENOJE:_~r~10:00~n~~w~NOREDAMI MIRTI, RASYKITE ~r~/die~n~_");
	PlayerTextDrawLetterSize(playerid, DeathScreenTD[playerid], 0.194666, 1.006933);
	PlayerTextDrawTextSize(playerid, DeathScreenTD[playerid], 0.000000, 124.000000);
	PlayerTextDrawAlignment(playerid, DeathScreenTD[playerid], 2);
	PlayerTextDrawColor(playerid, DeathScreenTD[playerid], -1);
	PlayerTextDrawUseBox(playerid, DeathScreenTD[playerid], 1);
	PlayerTextDrawBoxColor(playerid, DeathScreenTD[playerid], 93);
	PlayerTextDrawSetShadow(playerid, DeathScreenTD[playerid], 0);
	PlayerTextDrawSetOutline(playerid, DeathScreenTD[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, DeathScreenTD[playerid], 6);
	PlayerTextDrawFont(playerid, DeathScreenTD[playerid], 1);
	PlayerTextDrawSetProportional(playerid, DeathScreenTD[playerid], 1);
	PlayerTextDrawSetShadow(playerid, DeathScreenTD[playerid], 0);
	return 1;
}

stock DMV_Create_Global()
{
	DMV_BgMain = TextDrawCreate( 139.904830, 123.866714, "box");
	TextDrawLetterSize(DMV_BgMain, 0.000000, 21.352386);
	TextDrawTextSize(DMV_BgMain, 491.000000, 0.000000);
	TextDrawAlignment(DMV_BgMain, 1);
	TextDrawColor(DMV_BgMain, -1);
	TextDrawUseBox(DMV_BgMain, 1);
	TextDrawBoxColor(DMV_BgMain, 1975755);
	TextDrawSetShadow(DMV_BgMain, 0);
	TextDrawSetOutline(DMV_BgMain, 0);
	TextDrawBackgroundColor(DMV_BgMain, 255);
	TextDrawFont(DMV_BgMain, 1);
	TextDrawSetProportional(DMV_BgMain, 1);
	TextDrawSetShadow(DMV_BgMain, 0);

	DMV_BgLeft = TextDrawCreate( 145.238067, 128.559997, "box");
	TextDrawLetterSize(DMV_BgLeft, 0.000000, 20.209535);
	TextDrawTextSize(DMV_BgLeft, 266.000000, 0.000000);
	TextDrawAlignment(DMV_BgLeft, 1);
	TextDrawColor(DMV_BgLeft, -1);
	TextDrawUseBox(DMV_BgLeft, 1);
	TextDrawBoxColor(DMV_BgLeft, -225);
	TextDrawSetShadow(DMV_BgLeft, 0);
	TextDrawSetOutline(DMV_BgLeft, 0);
	TextDrawBackgroundColor(DMV_BgLeft, 255);
	TextDrawFont(DMV_BgLeft, 1);
	TextDrawSetProportional(DMV_BgLeft, 1);
	TextDrawSetShadow(DMV_BgLeft, 0);

	DMV_BgRight = TextDrawCreate( 273.238006, 128.560012, "box");
	TextDrawLetterSize(DMV_BgRight, 0.000000, 20.247631);
	TextDrawTextSize(DMV_BgRight, 487.000000, 0.000000);
	TextDrawAlignment(DMV_BgRight, 1);
	TextDrawColor(DMV_BgRight, -1);
	TextDrawUseBox(DMV_BgRight, 1);
	TextDrawBoxColor(DMV_BgRight, -225);
	TextDrawSetShadow(DMV_BgRight, 0);
	TextDrawSetOutline(DMV_BgRight, 0);
	TextDrawBackgroundColor(DMV_BgRight, 255);
	TextDrawFont(DMV_BgRight, 1);
	TextDrawSetProportional(DMV_BgRight, 1);
	TextDrawSetShadow(DMV_BgRight, 0);

	DMV_NamesLeft = TextDrawCreate( 149.809539, 130.506530, "TRANSPORTO_PRIEMONE:~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~LICENCIJA:");
	TextDrawLetterSize(DMV_NamesLeft, 0.175619, 1.075199);
	TextDrawAlignment(DMV_NamesLeft, 1);
	TextDrawColor(DMV_NamesLeft, -62);
	TextDrawSetShadow(DMV_NamesLeft, 0);
	TextDrawSetOutline(DMV_NamesLeft, 1);
	TextDrawBackgroundColor(DMV_NamesLeft, 2677);
	TextDrawFont(DMV_NamesLeft, 1);
	TextDrawSetProportional(DMV_NamesLeft, 1);
	TextDrawSetShadow(DMV_NamesLeft, 0);

	DMV_Logo = TextDrawCreate( 377.618988, 130.693359, "Department_of_Motor_Vehicles");
	TextDrawLetterSize(DMV_Logo, 0.407238, 1.638399);
	TextDrawAlignment(DMV_Logo, 2);
	TextDrawColor(DMV_Logo, -1715011585);
	TextDrawSetShadow(DMV_Logo, 1);
	TextDrawSetOutline(DMV_Logo, 0);
	TextDrawBackgroundColor(DMV_Logo, 255);
	TextDrawFont(DMV_Logo, 0);
	TextDrawSetProportional(DMV_Logo, 1);
	TextDrawSetShadow(DMV_Logo, 1);

	DMV_LogoEffect = TextDrawCreate( 259.904754, 149.893371, ".");
	TextDrawLetterSize(DMV_LogoEffect, 20.934469, 0.443731);
	TextDrawAlignment(DMV_LogoEffect, 1);
	TextDrawColor(DMV_LogoEffect, -194);
	TextDrawSetShadow(DMV_LogoEffect, 0);
	TextDrawSetOutline(DMV_LogoEffect, 0);
	TextDrawBackgroundColor(DMV_LogoEffect, 255);
	TextDrawFont(DMV_LogoEffect, 1);
	TextDrawSetProportional(DMV_LogoEffect, 1);
	TextDrawSetShadow(DMV_LogoEffect, 0);

	DMV_NamesRight = TextDrawCreate( 278.952423, 158.000030, "Noredami_islaikyti_praktikos_egzamina,_turite:");
	TextDrawLetterSize(DMV_NamesRight, 0.203428, 1.049600);
	TextDrawAlignment(DMV_NamesRight, 1);
	TextDrawColor(DMV_NamesRight, -1);
	TextDrawSetShadow(DMV_NamesRight, 1);
	TextDrawSetOutline(DMV_NamesRight, 0);
	TextDrawBackgroundColor(DMV_NamesRight, 57);
	TextDrawFont(DMV_NamesRight, 1);
	TextDrawSetProportional(DMV_NamesRight, 1);
	TextDrawSetShadow(DMV_NamesRight, 1);

	DMV_InfoRight = TextDrawCreate( 290.000000, 173.786682, "-_Nesudauzyti_tr._priemones~n~-_Laikytis_saugaus_greicio~n~-_Laikytis_desines_kelio_puses");
	TextDrawLetterSize(DMV_InfoRight, 0.233522, 1.032533);
	TextDrawAlignment(DMV_InfoRight, 1);
	TextDrawColor(DMV_InfoRight, -3618561);
	TextDrawSetShadow(DMV_InfoRight, 1);
	TextDrawSetOutline(DMV_InfoRight, 0);
	TextDrawBackgroundColor(DMV_InfoRight, 96);
	TextDrawFont(DMV_InfoRight, 1);
	TextDrawSetProportional(DMV_InfoRight, 1);
	TextDrawSetShadow(DMV_InfoRight, 1);

	DMV_StartBg = TextDrawCreate( 274.142883, 294.946624, "LD_SPAC:white");
	TextDrawLetterSize(DMV_StartBg, 0.000000, 0.000000);
	TextDrawTextSize(DMV_StartBg, 211.000000, 15.000000);
	TextDrawAlignment(DMV_StartBg, 1);
	TextDrawColor(DMV_StartBg, -8439297);
	TextDrawSetShadow(DMV_StartBg, 0);
	TextDrawSetOutline(DMV_StartBg, 0);
	TextDrawBackgroundColor(DMV_StartBg, 255);
	TextDrawFont(DMV_StartBg, 4);
	TextDrawSetProportional(DMV_StartBg, 0);
	TextDrawSetShadow(DMV_StartBg, 0);
	TextDrawSetSelectable(DMV_StartBg, true);

	DMV_Start = TextDrawCreate( 377.618988, 297.519989, "PRADETI");
	TextDrawLetterSize(DMV_Start, 0.262856, 1.117866);
	TextDrawAlignment(DMV_Start, 2);
	TextDrawColor(DMV_Start, 255);
	TextDrawSetShadow(DMV_Start, 0);
	TextDrawSetOutline(DMV_Start, 1);
	TextDrawBackgroundColor(DMV_Start, 0);
	TextDrawFont(DMV_Start, 1);
	TextDrawSetProportional(DMV_Start, 1);
	TextDrawSetShadow(DMV_Start, 0);
	return 1;
}

stock DMV_Create_Player(playerid)
{
	DMV_CarModel[playerid] = CreatePlayerTextDraw(playerid, 164.047576, 120.013336, "");
	PlayerTextDrawLetterSize(playerid, DMV_CarModel[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, DMV_CarModel[playerid], 92.000000, 103.000000);
	PlayerTextDrawAlignment(playerid, DMV_CarModel[playerid], 1);
	PlayerTextDrawColor(playerid, DMV_CarModel[playerid], -1);
	PlayerTextDrawSetShadow(playerid, DMV_CarModel[playerid], 0);
	PlayerTextDrawSetOutline(playerid, DMV_CarModel[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, DMV_CarModel[playerid], 0);
	PlayerTextDrawFont(playerid, DMV_CarModel[playerid], 5);
	PlayerTextDrawSetProportional(playerid, DMV_CarModel[playerid], 0);
	PlayerTextDrawSetShadow(playerid, DMV_CarModel[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, DMV_CarModel[playerid], 426);
	PlayerTextDrawSetPreviewRot(playerid, DMV_CarModel[playerid], 339.000000, 0.000000, 319.000000, 0.822407);
	PlayerTextDrawSetPreviewVehCol(playerid, DMV_CarModel[playerid], 1, 1);

	DMV_LicenseModel[playerid] = CreatePlayerTextDraw(playerid, 173.571380, 241.186660, "LD_DRV:bronze");
	PlayerTextDrawLetterSize(playerid, DMV_LicenseModel[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, DMV_LicenseModel[playerid], 55.000000, 59.000000);
	PlayerTextDrawAlignment(playerid, DMV_LicenseModel[playerid], 1);
	PlayerTextDrawColor(playerid, DMV_LicenseModel[playerid], -1);
	PlayerTextDrawSetShadow(playerid, DMV_LicenseModel[playerid], 0);
	PlayerTextDrawSetOutline(playerid, DMV_LicenseModel[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, DMV_LicenseModel[playerid], 255);
	PlayerTextDrawFont(playerid, DMV_LicenseModel[playerid], 4);
	PlayerTextDrawSetProportional(playerid, DMV_LicenseModel[playerid], 0);
	PlayerTextDrawSetShadow(playerid, DMV_LicenseModel[playerid], 0);

	DMV_InfoLeft[playerid] = CreatePlayerTextDraw(playerid, 200.857162, 202.373321, "PREMIER~n~~n~~n~~n~~n~~n~~n~~n~VAIRAVIMO");
	PlayerTextDrawLetterSize(playerid, DMV_InfoLeft[playerid], 0.278095, 1.250133);
	PlayerTextDrawAlignment(playerid, DMV_InfoLeft[playerid], 2);
	PlayerTextDrawColor(playerid, DMV_InfoLeft[playerid], -690552833);
	PlayerTextDrawSetShadow(playerid, DMV_InfoLeft[playerid], 0);
	PlayerTextDrawSetOutline(playerid, DMV_InfoLeft[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, DMV_InfoLeft[playerid], 255);
	PlayerTextDrawFont(playerid, DMV_InfoLeft[playerid], 1);
	PlayerTextDrawSetProportional(playerid, DMV_InfoLeft[playerid], 1);
	PlayerTextDrawSetShadow(playerid, DMV_InfoLeft[playerid], 0);
}

stock FurnitureTd_Create_Global()
{
	Furniture_LeftBorder = TextDrawCreate(269.952423, 377.719970, "LD_SPAC:white");
	TextDrawLetterSize(Furniture_LeftBorder, 0.000000, 0.000000);
	TextDrawTextSize(Furniture_LeftBorder, 18.000000, 19.000000);
	TextDrawAlignment(Furniture_LeftBorder, 1);
	TextDrawColor(Furniture_LeftBorder, 505290495);
	TextDrawSetShadow(Furniture_LeftBorder, 0);
	TextDrawSetOutline(Furniture_LeftBorder, 0);
	TextDrawBackgroundColor(Furniture_LeftBorder, 255);
	TextDrawFont(Furniture_LeftBorder, 4);
	TextDrawSetProportional(Furniture_LeftBorder, 0);
	TextDrawSetShadow(Furniture_LeftBorder, 0);

	Furniture_UpBorder = TextDrawCreate(288.999969, 377.719970, "LD_SPAC:white");
	TextDrawLetterSize(Furniture_UpBorder, 0.000000, 0.000000);
	TextDrawTextSize(Furniture_UpBorder, 18.000000, 19.000000);
	TextDrawAlignment(Furniture_UpBorder, 1);
	TextDrawColor(Furniture_UpBorder, 505290495);
	TextDrawSetShadow(Furniture_UpBorder, 0);
	TextDrawSetOutline(Furniture_UpBorder, 0);
	TextDrawBackgroundColor(Furniture_UpBorder, 255);
	TextDrawFont(Furniture_UpBorder, 4);
	TextDrawSetProportional(Furniture_UpBorder, 0);
	TextDrawSetShadow(Furniture_UpBorder, 0);

	Furniture_DownBorder = TextDrawCreate(308.047576, 377.719970, "LD_SPAC:white");
	TextDrawLetterSize(Furniture_DownBorder, 0.000000, 0.000000);
	TextDrawTextSize(Furniture_DownBorder, 18.000000, 19.000000);
	TextDrawAlignment(Furniture_DownBorder, 1);
	TextDrawColor(Furniture_DownBorder, 505290495);
	TextDrawSetShadow(Furniture_DownBorder, 0);
	TextDrawSetOutline(Furniture_DownBorder, 0);
	TextDrawBackgroundColor(Furniture_DownBorder, 255);
	TextDrawFont(Furniture_DownBorder, 4);
	TextDrawSetProportional(Furniture_DownBorder, 0);
	TextDrawSetShadow(Furniture_DownBorder, 0);

	Furniture_RightBorder = TextDrawCreate(327.095123, 377.719970, "LD_SPAC:white");
	TextDrawLetterSize(Furniture_RightBorder, 0.000000, 0.000000);
	TextDrawTextSize(Furniture_RightBorder, 18.000000, 19.000000);
	TextDrawAlignment(Furniture_RightBorder, 1);
	TextDrawColor(Furniture_RightBorder, 505290495);
	TextDrawSetShadow(Furniture_RightBorder, 0);
	TextDrawSetOutline(Furniture_RightBorder, 0);
	TextDrawBackgroundColor(Furniture_RightBorder, 255);
	TextDrawFont(Furniture_RightBorder, 4);
	TextDrawSetProportional(Furniture_RightBorder, 0);
	TextDrawSetShadow(Furniture_RightBorder, 0);

	Furniture_LeftBase = TextDrawCreate(271.095245, 379.000000, "LD_SPAC:white");
	TextDrawLetterSize(Furniture_LeftBase, 0.000000, 0.000000);
	TextDrawTextSize(Furniture_LeftBase, 16.000000, 16.000000);
	TextDrawAlignment(Furniture_LeftBase, 1);
	TextDrawColor(Furniture_LeftBase, -926365441);
	TextDrawSetShadow(Furniture_LeftBase, 0);
	TextDrawSetOutline(Furniture_LeftBase, 0);
	TextDrawBackgroundColor(Furniture_LeftBase, 255);
	TextDrawFont(Furniture_LeftBase, 4);
	TextDrawSetProportional(Furniture_LeftBase, 0);
	TextDrawSetShadow(Furniture_LeftBase, 0);
	TextDrawSetSelectable(Furniture_LeftBase, true);

	Furniture_UpBase = TextDrawCreate(290.142852, 379.000000, "LD_SPAC:white");
	TextDrawLetterSize(Furniture_UpBase, 0.000000, 0.000000);
	TextDrawTextSize(Furniture_UpBase, 16.000000, 16.000000);
	TextDrawAlignment(Furniture_UpBase, 1);
	TextDrawColor(Furniture_UpBase, -926365441);
	TextDrawSetShadow(Furniture_UpBase, 0);
	TextDrawSetOutline(Furniture_UpBase, 0);
	TextDrawBackgroundColor(Furniture_UpBase, 255);
	TextDrawFont(Furniture_UpBase, 4);
	TextDrawSetProportional(Furniture_UpBase, 0);
	TextDrawSetShadow(Furniture_UpBase, 0);
	TextDrawSetSelectable(Furniture_UpBase, true);

	Furniture_DownBase = TextDrawCreate(309.190521, 379.000000, "LD_SPAC:white");
	TextDrawLetterSize(Furniture_DownBase, 0.000000, 0.000000);
	TextDrawTextSize(Furniture_DownBase, 16.000000, 16.000000);
	TextDrawAlignment(Furniture_DownBase, 1);
	TextDrawColor(Furniture_DownBase, -926365441);
	TextDrawSetShadow(Furniture_DownBase, 0);
	TextDrawSetOutline(Furniture_DownBase, 0);
	TextDrawBackgroundColor(Furniture_DownBase, 255);
	TextDrawFont(Furniture_DownBase, 4);
	TextDrawSetProportional(Furniture_DownBase, 0);
	TextDrawSetShadow(Furniture_DownBase, 0);
	TextDrawSetSelectable(Furniture_DownBase, true);

	Furniture_RightBase = TextDrawCreate(328.238128, 379.000000, "LD_SPAC:white");
	TextDrawLetterSize(Furniture_RightBase, 0.000000, 0.000000);
	TextDrawTextSize(Furniture_RightBase, 16.000000, 16.000000);
	TextDrawAlignment(Furniture_RightBase, 1);
	TextDrawColor(Furniture_RightBase, -926365441);
	TextDrawSetShadow(Furniture_RightBase, 0);
	TextDrawSetOutline(Furniture_RightBase, 0);
	TextDrawBackgroundColor(Furniture_RightBase, 255);
	TextDrawFont(Furniture_RightBase, 4);
	TextDrawSetProportional(Furniture_RightBase, 0);
	TextDrawSetShadow(Furniture_RightBase, 0);
	TextDrawSetSelectable(Furniture_RightBase, true);

	Furniture_Left = TextDrawCreate(274.142608, 381.560302, "LD_BEAT:left");
	TextDrawLetterSize(Furniture_Left, 0.000000, 0.000000);
	TextDrawTextSize(Furniture_Left, 9.000000, 12.000000);
	TextDrawAlignment(Furniture_Left, 1);
	TextDrawColor(Furniture_Left, -1413545985);
	TextDrawSetShadow(Furniture_Left, 0);
	TextDrawSetOutline(Furniture_Left, 0);
	TextDrawBackgroundColor(Furniture_Left, 255);
	TextDrawFont(Furniture_Left, 4);
	TextDrawSetProportional(Furniture_Left, 0);
	TextDrawSetShadow(Furniture_Left, 0);

	Furniture_Up = TextDrawCreate(292.428466, 382.413360, "LD_BEAT:up");
	TextDrawLetterSize(Furniture_Up, 0.000000, 0.000000);
	TextDrawTextSize(Furniture_Up, 12.000000, 11.000000);
	TextDrawAlignment(Furniture_Up, 1);
	TextDrawColor(Furniture_Up, -1413545985);
	TextDrawSetShadow(Furniture_Up, 0);
	TextDrawSetOutline(Furniture_Up, 0);
	TextDrawBackgroundColor(Furniture_Up, 255);
	TextDrawFont(Furniture_Up, 4);
	TextDrawSetProportional(Furniture_Up, 0);
	TextDrawSetShadow(Furniture_Up, 0);

	Furniture_Down = TextDrawCreate(311.476013, 381.986694, "LD_BEAT:down");
	TextDrawLetterSize(Furniture_Down, 0.000000, 0.000000);
	TextDrawTextSize(Furniture_Down, 12.000000, 11.000000);
	TextDrawAlignment(Furniture_Down, 1);
	TextDrawColor(Furniture_Down, -1413545985);
	TextDrawSetShadow(Furniture_Down, 0);
	TextDrawSetOutline(Furniture_Down, 0);
	TextDrawBackgroundColor(Furniture_Down, 255);
	TextDrawFont(Furniture_Down, 4);
	TextDrawSetProportional(Furniture_Down, 0);
	TextDrawSetShadow(Furniture_Down, 0);

	Furniture_Right = TextDrawCreate(332.047363, 381.560302, "LD_BEAT:right");
	TextDrawLetterSize(Furniture_Right, 0.000000, 0.000000);
	TextDrawTextSize(Furniture_Right, 9.000000, 12.000000);
	TextDrawAlignment(Furniture_Right, 1);
	TextDrawColor(Furniture_Right, -1413545985);
	TextDrawSetShadow(Furniture_Right, 0);
	TextDrawSetOutline(Furniture_Right, 0);
	TextDrawBackgroundColor(Furniture_Right, 255);
	TextDrawFont(Furniture_Right, 4);
	TextDrawSetProportional(Furniture_Right, 0);
	TextDrawSetShadow(Furniture_Right, 0);

	Furniture_BuyBorder = TextDrawCreate(269.952362, 397.773254, "LD_SPAC:white");
	TextDrawLetterSize(Furniture_BuyBorder, 0.000000, 0.000000);
	TextDrawTextSize(Furniture_BuyBorder, 75.000000, 12.000000);
	TextDrawAlignment(Furniture_BuyBorder, 1);
	TextDrawColor(Furniture_BuyBorder, 505290495);
	TextDrawSetShadow(Furniture_BuyBorder, 0);
	TextDrawSetOutline(Furniture_BuyBorder, 0);
	TextDrawBackgroundColor(Furniture_BuyBorder, 255);
	TextDrawFont(Furniture_BuyBorder, 4);
	TextDrawSetProportional(Furniture_BuyBorder, 0);
	TextDrawSetShadow(Furniture_BuyBorder, 0);

	Furniture_BuyBase = TextDrawCreate(271.095245, 399.053283, "LD_SPAC:white");
	TextDrawLetterSize(Furniture_BuyBase, 0.000000, 0.000000);
	TextDrawTextSize(Furniture_BuyBase, 73.000000, 10.000000);
	TextDrawAlignment(Furniture_BuyBase, 1);
	TextDrawColor(Furniture_BuyBase, 6226175);
	TextDrawSetShadow(Furniture_BuyBase, 0);
	TextDrawSetOutline(Furniture_BuyBase, 0);
	TextDrawBackgroundColor(Furniture_BuyBase, 255);
	TextDrawFont(Furniture_BuyBase, 4);
	TextDrawSetProportional(Furniture_BuyBase, 0);
	TextDrawSetShadow(Furniture_BuyBase, 0);
	TextDrawSetSelectable(Furniture_BuyBase, true);

	Furniture_Buy = TextDrawCreate(307.142791, 399.493286, "PIRKTI");
	TextDrawLetterSize(Furniture_Buy, 0.216000, 0.977066);
	TextDrawAlignment(Furniture_Buy, 2);
	TextDrawColor(Furniture_Buy, -1);
	TextDrawSetShadow(Furniture_Buy, 0);
	TextDrawSetOutline(Furniture_Buy, 1);
	TextDrawBackgroundColor(Furniture_Buy, 101);
	TextDrawFont(Furniture_Buy, 1);
	TextDrawSetProportional(Furniture_Buy, 1);
	TextDrawSetShadow(Furniture_Buy, 0);

	Furniture_CloseBorder = TextDrawCreate(269.952362, 410.999908, "LD_SPAC:white");
	TextDrawLetterSize(Furniture_CloseBorder, 0.000000, 0.000000);
	TextDrawTextSize(Furniture_CloseBorder, 75.000000, 12.000000);
	TextDrawAlignment(Furniture_CloseBorder, 1);
	TextDrawColor(Furniture_CloseBorder, 505290495);
	TextDrawSetShadow(Furniture_CloseBorder, 0);
	TextDrawSetOutline(Furniture_CloseBorder, 0);
	TextDrawBackgroundColor(Furniture_CloseBorder, 255);
	TextDrawFont(Furniture_CloseBorder, 4);
	TextDrawSetProportional(Furniture_CloseBorder, 0);
	TextDrawSetShadow(Furniture_CloseBorder, 0);

	Furniture_CloseBase = TextDrawCreate(271.095245, 412.279937, "LD_SPAC:white");
	TextDrawLetterSize(Furniture_CloseBase, 0.000000, 0.000000);
	TextDrawTextSize(Furniture_CloseBase, 73.000000, 10.000000);
	TextDrawAlignment(Furniture_CloseBase, 1);
	TextDrawColor(Furniture_CloseBase, 2130706687);
	TextDrawSetShadow(Furniture_CloseBase, 0);
	TextDrawSetOutline(Furniture_CloseBase, 0);
	TextDrawBackgroundColor(Furniture_CloseBase, 255);
	TextDrawFont(Furniture_CloseBase, 4);
	TextDrawSetProportional(Furniture_CloseBase, 0);
	TextDrawSetShadow(Furniture_CloseBase, 0);
	TextDrawSetSelectable(Furniture_CloseBase, true);

	Furniture_Close = TextDrawCreate(307.142791, 412.719940, "ATSAUKTI");
	TextDrawLetterSize(Furniture_Close, 0.216000, 0.977066);
	TextDrawAlignment(Furniture_Close, 2);
	TextDrawColor(Furniture_Close, -1);
	TextDrawSetShadow(Furniture_Close, 0);
	TextDrawSetOutline(Furniture_Close, 1);
	TextDrawBackgroundColor(Furniture_Close, 101);
	TextDrawFont(Furniture_Close, 1);
	TextDrawSetProportional(Furniture_Close, 1);
	TextDrawSetShadow(Furniture_Close, 0);

	Furniture_DataBase = TextDrawCreate(488.000000, 22.000000, "LD_SPAC:white");
	TextDrawLetterSize(Furniture_DataBase, 0.000000, 0.000000);
	TextDrawTextSize(Furniture_DataBase, 133.000000, 34.000000);
	TextDrawAlignment(Furniture_DataBase, 1);
	TextDrawColor(Furniture_DataBase, 505290387);
	TextDrawSetShadow(Furniture_DataBase, 0);
	TextDrawSetOutline(Furniture_DataBase, 0);
	TextDrawBackgroundColor(Furniture_DataBase, 255);
	TextDrawFont(Furniture_DataBase, 4);
	TextDrawSetProportional(Furniture_DataBase, 0);
	TextDrawSetShadow(Furniture_DataBase, 0);
	return 1;
}
stock FurnitureTd_Create_Player(playerid)
{
	Furniture_Data[playerid] = CreatePlayerTextDraw(playerid, 493.000000, 26.000000, "KATEGORIJA:_STALAI~n~PAVADINIMAS:_DIDELIS_STALAS~n~KAINA:_10000$");
	PlayerTextDrawLetterSize(playerid, Furniture_Data[playerid], 0.190475, 0.921599);
	PlayerTextDrawAlignment(playerid, Furniture_Data[playerid], 1);
	PlayerTextDrawColor(playerid, Furniture_Data[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Furniture_Data[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Furniture_Data[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, Furniture_Data[playerid], 0);
	PlayerTextDrawFont(playerid, Furniture_Data[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Furniture_Data[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Furniture_Data[playerid], 0);
	return 1;
}

stock TipBox_Create_Global()
{
	TipBox_Base = TextDrawCreate(39.333332, 258.266662, "box");
	TextDrawLetterSize(TipBox_Base, 0.000000, 7.904761);
	TextDrawTextSize(TipBox_Base, 137.000000, 0.000000);
	TextDrawAlignment(TipBox_Base, 1);
	TextDrawColor(TipBox_Base, -1);
	TextDrawUseBox(TipBox_Base, 1);
	TextDrawBoxColor(TipBox_Base, 1347440895);
	TextDrawSetShadow(TipBox_Base, 0);
	TextDrawSetOutline(TipBox_Base, 0);
	TextDrawBackgroundColor(TipBox_Base, 69);
	TextDrawFont(TipBox_Base, 1);
	TextDrawSetProportional(TipBox_Base, 1);
	TextDrawSetShadow(TipBox_Base, 0);

	TipBox_NameBase = TextDrawCreate(37.571434, 247.586669, "LD_SPAC:white");
	TextDrawLetterSize(TipBox_NameBase, 0.000000, 0.000000);
	TextDrawTextSize(TipBox_NameBase, 101.000000, 9.000000);
	TextDrawAlignment(TipBox_NameBase, 1);
	TextDrawColor(TipBox_NameBase, 842150655);
	TextDrawSetShadow(TipBox_NameBase, 0);
	TextDrawSetOutline(TipBox_NameBase, 0);
	TextDrawBackgroundColor(TipBox_NameBase, 255);
	TextDrawFont(TipBox_NameBase, 4);
	TextDrawSetProportional(TipBox_NameBase, 0);
	TextDrawSetShadow(TipBox_NameBase, 0);

	TipBox_Name = TextDrawCreate(40.476181, 248.453323, "Patarimas");
	TextDrawLetterSize(TipBox_Name, 0.323809, 1.280000);
	TextDrawAlignment(TipBox_Name, 1);
	TextDrawColor(TipBox_Name, -1);
	TextDrawSetShadow(TipBox_Name, 0);
	TextDrawSetOutline(TipBox_Name, 1);
	TextDrawBackgroundColor(TipBox_Name, 505290495);
	TextDrawFont(TipBox_Name, 0);
	TextDrawSetProportional(TipBox_Name, 1);
	TextDrawSetShadow(TipBox_Name, 0);

	TipBox_LowText = TextDrawCreate(137.238128, 323.546600, "COMMUNITYRP.LT");
	TextDrawLetterSize(TipBox_LowText, 0.110857, 0.746666);
	TextDrawAlignment(TipBox_LowText, 3);
	TextDrawColor(TipBox_LowText, -1);
	TextDrawSetShadow(TipBox_LowText, 0);
	TextDrawSetOutline(TipBox_LowText, 0);
	TextDrawBackgroundColor(TipBox_LowText, 255);
	TextDrawFont(TipBox_LowText, 2);
	TextDrawSetProportional(TipBox_LowText, 1);
	TextDrawSetShadow(TipBox_LowText, 0);
	return 1;
}
stock TipBox_Create_Player(playerid) 
{
	TipBox_Info[playerid] = CreatePlayerTextDraw(playerid, 43.523757, 262.533325, "Ar_zinote,_kad_galite_naudoti~n~komandas_/enter_ir_/exit,~n~noredami_ieiti_arba_iseiti_is_~n~pastato?");
	PlayerTextDrawLetterSize(playerid, TipBox_Info[playerid], 0.182476, 0.998400);
	PlayerTextDrawAlignment(playerid, TipBox_Info[playerid], 1);
	PlayerTextDrawColor(playerid, TipBox_Info[playerid], -1);
	PlayerTextDrawSetShadow(playerid, TipBox_Info[playerid], 1);
	PlayerTextDrawSetOutline(playerid, TipBox_Info[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, TipBox_Info[playerid], 70);
	PlayerTextDrawFont(playerid, TipBox_Info[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TipBox_Info[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TipBox_Info[playerid], 1);
	return 1;
}



stock LoadBar_Create_Player(playerid)
{
	LoadBar_Base[playerid] = CreatePlayerTextDraw(playerid, 189.952392, 377.293304, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, LoadBar_Base[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, LoadBar_Base[playerid], 268.000000, 6.000000);
	PlayerTextDrawAlignment(playerid, LoadBar_Base[playerid], 1);
	PlayerTextDrawColor(playerid, LoadBar_Base[playerid], 168430335);
	PlayerTextDrawSetShadow(playerid, LoadBar_Base[playerid], 0);
	PlayerTextDrawSetOutline(playerid, LoadBar_Base[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, LoadBar_Base[playerid], 255);
	PlayerTextDrawFont(playerid, LoadBar_Base[playerid], 4);
	PlayerTextDrawSetProportional(playerid, LoadBar_Base[playerid], 0);
	PlayerTextDrawSetShadow(playerid, LoadBar_Base[playerid], 0);

	LoadBar_LoadFull[playerid] = CreatePlayerTextDraw(playerid, 191.476211, 378.999969, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, LoadBar_LoadFull[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, LoadBar_LoadFull[playerid], 265.000000, 3.0);
	PlayerTextDrawAlignment(playerid, LoadBar_LoadFull[playerid], 1);
	PlayerTextDrawColor(playerid, LoadBar_LoadFull[playerid], 0x8E721Cff);
	PlayerTextDrawSetShadow(playerid, LoadBar_LoadFull[playerid], 0);
	PlayerTextDrawSetOutline(playerid, LoadBar_LoadFull[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, LoadBar_LoadFull[playerid], 255);
	PlayerTextDrawFont(playerid, LoadBar_LoadFull[playerid], 4);
	PlayerTextDrawSetProportional(playerid, LoadBar_LoadFull[playerid], 0);
	PlayerTextDrawSetShadow(playerid, LoadBar_LoadFull[playerid], 0);

	LoadBar_Loaded[playerid] = CreatePlayerTextDraw(playerid, 191.476211, 378.999969, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, LoadBar_Loaded[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, LoadBar_Loaded[playerid], 0.000000, 3.0);
	PlayerTextDrawAlignment(playerid, LoadBar_Loaded[playerid], 1);
	PlayerTextDrawColor(playerid, LoadBar_Loaded[playerid], 0xEEBC26ff);
	PlayerTextDrawSetShadow(playerid, LoadBar_Loaded[playerid], 0);
	PlayerTextDrawSetOutline(playerid, LoadBar_Loaded[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, LoadBar_Loaded[playerid], 255);
	PlayerTextDrawFont(playerid, LoadBar_Loaded[playerid], 4);
	PlayerTextDrawSetProportional(playerid, LoadBar_Loaded[playerid], 0);
	PlayerTextDrawSetShadow(playerid, LoadBar_Loaded[playerid], 0);

	LoadBar_Text[playerid] = CreatePlayerTextDraw(playerid, 190.190536, 366.639923, "VARIKLIS_UZVEDAMAS");
	PlayerTextDrawLetterSize(playerid, LoadBar_Text[playerid], 0.183238, 1.096533);
	PlayerTextDrawAlignment(playerid, LoadBar_Text[playerid], 1);
	PlayerTextDrawColor(playerid, LoadBar_Text[playerid], -1);
	PlayerTextDrawSetShadow(playerid, LoadBar_Text[playerid], 1);
	PlayerTextDrawSetOutline(playerid, LoadBar_Text[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, LoadBar_Text[playerid], 5887);
	PlayerTextDrawFont(playerid, LoadBar_Text[playerid], 2);
	PlayerTextDrawSetProportional(playerid, LoadBar_Text[playerid], 1);
	PlayerTextDrawSetShadow(playerid, LoadBar_Text[playerid], 1);
}

stock JailTimeTD_Create_Global()
{
	JailTimeTD_Timer = TextDrawCreate(199.857192, 413.986602, "ld_grav:timer");
	TextDrawLetterSize(JailTimeTD_Timer, 0.000000, 0.000000);
	TextDrawTextSize(JailTimeTD_Timer, 12.000000, 12.000000);
	TextDrawAlignment(JailTimeTD_Timer, 1);
	TextDrawColor(JailTimeTD_Timer, -160);
	TextDrawSetShadow(JailTimeTD_Timer, 0);
	TextDrawSetOutline(JailTimeTD_Timer, 0);
	TextDrawBackgroundColor(JailTimeTD_Timer, 255);
	TextDrawFont(JailTimeTD_Timer, 4);
	TextDrawSetProportional(JailTimeTD_Timer, 0);
	TextDrawSetShadow(JailTimeTD_Timer, 0);

	JailTimeTD_Bg = TextDrawCreate(199.714385, 413.146667, "box");
	TextDrawLetterSize(JailTimeTD_Bg, 0.000000, 1.428569);
	TextDrawTextSize(JailTimeTD_Bg, 459.000000, 0.000000);
	TextDrawAlignment(JailTimeTD_Bg, 1);
	TextDrawColor(JailTimeTD_Bg, -1);
	TextDrawUseBox(JailTimeTD_Bg, 1);
	TextDrawBoxColor(JailTimeTD_Bg, 34);
	TextDrawSetShadow(JailTimeTD_Bg, 0);
	TextDrawSetOutline(JailTimeTD_Bg, 0);
	TextDrawBackgroundColor(JailTimeTD_Bg, 255);
	TextDrawFont(JailTimeTD_Bg, 1);
	TextDrawSetProportional(JailTimeTD_Bg, 1);
	TextDrawSetShadow(JailTimeTD_Bg, 0);
	return 1;
}

stock JailTimeTD_Create_Player(playerid)
{
	JailTimeTD_Time[playerid] = CreatePlayerTextDraw(playerid, 217.238128, 415.806604, "KALEJIMO_LAIKAS:_52:20");
	PlayerTextDrawLetterSize(playerid, JailTimeTD_Time[playerid], 0.188571, 1.002667);
	PlayerTextDrawAlignment(playerid, JailTimeTD_Time[playerid], 1);
	PlayerTextDrawColor(playerid, JailTimeTD_Time[playerid], -94);
	PlayerTextDrawSetShadow(playerid, JailTimeTD_Time[playerid], 0);
	PlayerTextDrawSetOutline(playerid, JailTimeTD_Time[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, JailTimeTD_Time[playerid], 9);
	PlayerTextDrawFont(playerid, JailTimeTD_Time[playerid], 1);
	PlayerTextDrawSetProportional(playerid, JailTimeTD_Time[playerid], 1);
	PlayerTextDrawSetShadow(playerid, JailTimeTD_Time[playerid], 0);
	return 1;
}

stock InfoBar_Create_Player(playerid)
{
	InfoBar[playerid] = CreatePlayerTextDraw(playerid, 603.143127, 99.120056, "RACIJOS KANALAS: 911~n~RACIJOS SLOT: 1~n~ATLIEKAMA: 01:12~n~");
	PlayerTextDrawLetterSize(playerid, InfoBar[playerid], 0.209904, 0.938666);
	PlayerTextDrawAlignment(playerid, InfoBar[playerid], 3);
	PlayerTextDrawColor(playerid, InfoBar[playerid], -1);
	PlayerTextDrawSetShadow(playerid, InfoBar[playerid], 0);
	PlayerTextDrawSetOutline(playerid, InfoBar[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, InfoBar[playerid], 86);
	PlayerTextDrawFont(playerid, InfoBar[playerid], 1);
	PlayerTextDrawSetProportional(playerid, InfoBar[playerid], 1);
	PlayerTextDrawSetShadow(playerid, InfoBar[playerid], 0);
}

stock MechTune_Create_Global()
{
	MechTune_Base = TextDrawCreate(135.714355, 104.240013, "box");
	TextDrawLetterSize(MechTune_Base, 0.000000, 26.990480);
	TextDrawTextSize(MechTune_Base, 482.000000, 0.000000);
	TextDrawAlignment(MechTune_Base, 1);
	TextDrawColor(MechTune_Base, -1);
	TextDrawUseBox(MechTune_Base, 1);
	TextDrawBoxColor(MechTune_Base, 122);
	TextDrawSetShadow(MechTune_Base, 0);
	TextDrawSetOutline(MechTune_Base, 0);
	TextDrawBackgroundColor(MechTune_Base, 255);
	TextDrawFont(MechTune_Base, 1);
	TextDrawSetProportional(MechTune_Base, 1);
	TextDrawSetShadow(MechTune_Base, 0);

	MechTune_TextTop = TextDrawCreate(145.238113, 108.080032, "TUNINGAVIMAS");
	TextDrawLetterSize(MechTune_TextTop, 0.185523, 0.998399);
	TextDrawAlignment(MechTune_TextTop, 1);
	TextDrawColor(MechTune_TextTop, -1);
	TextDrawSetShadow(MechTune_TextTop, 0);
	TextDrawSetOutline(MechTune_TextTop, 23);
	TextDrawBackgroundColor(MechTune_TextTop, 0);
	TextDrawFont(MechTune_TextTop, 1);
	TextDrawSetProportional(MechTune_TextTop, 1);
	TextDrawSetShadow(MechTune_TextTop, 0);

	MechTune_CancelBase = TextDrawCreate(365.952239, 301.346649, "LD_SPAC:white");
	TextDrawLetterSize(MechTune_CancelBase, 0.000000, 0.000000);
	TextDrawTextSize(MechTune_CancelBase, 54.000000, 41.000000);
	TextDrawAlignment(MechTune_CancelBase, 1);
	TextDrawColor(MechTune_CancelBase, 1678119935);
	TextDrawSetShadow(MechTune_CancelBase, 0);
	TextDrawSetOutline(MechTune_CancelBase, 0);
	TextDrawBackgroundColor(MechTune_CancelBase, 255);
	TextDrawFont(MechTune_CancelBase, 4);
	TextDrawSetProportional(MechTune_CancelBase, 0);
	TextDrawSetShadow(MechTune_CancelBase, 0);
	TextDrawSetSelectable(MechTune_CancelBase, true);

	MechTune_BuyBase = TextDrawCreate(423.095153, 301.346649, "LD_SPAC:white");
	TextDrawLetterSize(MechTune_BuyBase, 0.000000, 0.000000);
	TextDrawTextSize(MechTune_BuyBase, 54.000000, 41.000000);
	TextDrawAlignment(MechTune_BuyBase, 1);
	TextDrawColor(MechTune_BuyBase, 795813119);
	TextDrawSetShadow(MechTune_BuyBase, 0);
	TextDrawSetOutline(MechTune_BuyBase, 0);
	TextDrawBackgroundColor(MechTune_BuyBase, 255);
	TextDrawFont(MechTune_BuyBase, 4);
	TextDrawSetProportional(MechTune_BuyBase, 0);
	TextDrawSetShadow(MechTune_BuyBase, 0);
	TextDrawSetSelectable(MechTune_BuyBase, true);

	MechTune_BuyText = TextDrawCreate(378.380981, 317.573333, "ATSAUKTI___________PIRKTI");
	TextDrawLetterSize(MechTune_BuyText, 0.187047, 1.092265);
	TextDrawAlignment(MechTune_BuyText, 1);
	TextDrawColor(MechTune_BuyText, -1);
	TextDrawSetShadow(MechTune_BuyText, 0);
	TextDrawSetOutline(MechTune_BuyText, 1);
	TextDrawBackgroundColor(MechTune_BuyText, 87);
	TextDrawFont(MechTune_BuyText, 1);
	TextDrawSetProportional(MechTune_BuyText, 1);
	TextDrawSetShadow(MechTune_BuyText, 0);

	MechTune_Shadow = TextDrawCreate(151.857192, 126.840026, "");
	TextDrawLetterSize(MechTune_Shadow, 0.000000, 0.000000);
	TextDrawTextSize(MechTune_Shadow, 35.000000, 40.000000);
	TextDrawAlignment(MechTune_Shadow, 1);
	TextDrawColor(MechTune_Shadow, -1);
	TextDrawSetShadow(MechTune_Shadow, 0);
	TextDrawSetOutline(MechTune_Shadow, 0);
	TextDrawBackgroundColor(MechTune_Shadow, 0);
	TextDrawFont(MechTune_Shadow, 5);
	TextDrawSetProportional(MechTune_Shadow, 0);
	TextDrawSetShadow(MechTune_Shadow, 0);
	TextDrawSetPreviewModel(MechTune_Shadow, 1073);
	TextDrawSetPreviewRot(MechTune_Shadow, 0.000000, 0.000000, 91.000000, 1.000000);

	MechTune_Mega = TextDrawCreate(207.476226, 126.840026, "");
	TextDrawLetterSize(MechTune_Mega, 0.000000, 0.000000);
	TextDrawTextSize(MechTune_Mega, 35.000000, 40.000000);
	TextDrawAlignment(MechTune_Mega, 1);
	TextDrawColor(MechTune_Mega, -1);
	TextDrawSetShadow(MechTune_Mega, 0);
	TextDrawSetOutline(MechTune_Mega, 0);
	TextDrawBackgroundColor(MechTune_Mega, 0);
	TextDrawFont(MechTune_Mega, 5);
	TextDrawSetProportional(MechTune_Mega, 0);
	TextDrawSetShadow(MechTune_Mega, 0);
	TextDrawSetPreviewModel(MechTune_Mega, 1074);
	TextDrawSetPreviewRot(MechTune_Mega, 0.000000, 0.000000, 91.000000, 1.000000);

	MechTune_Rimshine = TextDrawCreate(263.095245, 126.840026, "");
	TextDrawLetterSize(MechTune_Rimshine, 0.000000, 0.000000);
	TextDrawTextSize(MechTune_Rimshine, 35.000000, 40.000000);
	TextDrawAlignment(MechTune_Rimshine, 1);
	TextDrawColor(MechTune_Rimshine, -1);
	TextDrawSetShadow(MechTune_Rimshine, 0);
	TextDrawSetOutline(MechTune_Rimshine, 0);
	TextDrawBackgroundColor(MechTune_Rimshine, 0);
	TextDrawFont(MechTune_Rimshine, 5);
	TextDrawSetProportional(MechTune_Rimshine, 0);
	TextDrawSetShadow(MechTune_Rimshine, 0);
	TextDrawSetPreviewModel(MechTune_Rimshine, 1075);
	TextDrawSetPreviewRot(MechTune_Rimshine, 0.000000, 0.000000, 91.000000, 1.000000);

	MechTune_Wires = TextDrawCreate(319.476196, 128.120010, "");
	TextDrawLetterSize(MechTune_Wires, 0.000000, 0.000000);
	TextDrawTextSize(MechTune_Wires, 35.000000, 40.000000);
	TextDrawAlignment(MechTune_Wires, 1);
	TextDrawColor(MechTune_Wires, -1);
	TextDrawSetShadow(MechTune_Wires, 0);
	TextDrawSetOutline(MechTune_Wires, 0);
	TextDrawBackgroundColor(MechTune_Wires, 0);
	TextDrawFont(MechTune_Wires, 5);
	TextDrawSetProportional(MechTune_Wires, 0);
	TextDrawSetShadow(MechTune_Wires, 0);
	TextDrawSetPreviewModel(MechTune_Wires, 1076);
	TextDrawSetPreviewRot(MechTune_Wires, 0.000000, 0.000000, 91.000000, 1.000000);

	MechTune_Classic = TextDrawCreate(375.857147, 127.693344, "");
	TextDrawLetterSize(MechTune_Classic, 0.000000, 0.000000);
	TextDrawTextSize(MechTune_Classic, 35.000000, 40.000000);
	TextDrawAlignment(MechTune_Classic, 1);
	TextDrawColor(MechTune_Classic, -1);
	TextDrawSetShadow(MechTune_Classic, 0);
	TextDrawSetOutline(MechTune_Classic, 0);
	TextDrawBackgroundColor(MechTune_Classic, 0);
	TextDrawFont(MechTune_Classic, 5);
	TextDrawSetProportional(MechTune_Classic, 0);
	TextDrawSetShadow(MechTune_Classic, 0);
	TextDrawSetPreviewModel(MechTune_Classic, 1077);
	TextDrawSetPreviewRot(MechTune_Classic, 0.000000, 0.000000, 91.000000, 1.000000);

	MechTune_Twist = TextDrawCreate(431.476226, 126.840011, "");
	TextDrawLetterSize(MechTune_Twist, 0.000000, 0.000000);
	TextDrawTextSize(MechTune_Twist, 35.000000, 40.000000);
	TextDrawAlignment(MechTune_Twist, 1);
	TextDrawColor(MechTune_Twist, -1);
	TextDrawSetShadow(MechTune_Twist, 0);
	TextDrawSetOutline(MechTune_Twist, 0);
	TextDrawBackgroundColor(MechTune_Twist, 0);
	TextDrawFont(MechTune_Twist, 5);
	TextDrawSetProportional(MechTune_Twist, 0);
	TextDrawSetShadow(MechTune_Twist, 0);
	TextDrawSetPreviewModel(MechTune_Twist, 1078);
	TextDrawSetPreviewRot(MechTune_Twist, 0.000000, 0.000000, 91.000000, 1.000000);

	MechTune_Cutter = TextDrawCreate(151.095275, 186.573333, "");
	TextDrawLetterSize(MechTune_Cutter, 0.000000, 0.000000);
	TextDrawTextSize(MechTune_Cutter, 35.000000, 40.000000);
	TextDrawAlignment(MechTune_Cutter, 1);
	TextDrawColor(MechTune_Cutter, -1);
	TextDrawSetShadow(MechTune_Cutter, 0);
	TextDrawSetOutline(MechTune_Cutter, 0);
	TextDrawBackgroundColor(MechTune_Cutter, 0);
	TextDrawFont(MechTune_Cutter, 5);
	TextDrawSetProportional(MechTune_Cutter, 0);
	TextDrawSetShadow(MechTune_Cutter, 0);
	TextDrawSetPreviewModel(MechTune_Cutter, 1079);
	TextDrawSetPreviewRot(MechTune_Cutter, 0.000000, 0.000000, 91.000000, 1.000000);

	MechTune_Switch = TextDrawCreate(207.095275, 187.853332, "");
	TextDrawLetterSize(MechTune_Switch, 0.000000, 0.000000);
	TextDrawTextSize(MechTune_Switch, 35.000000, 40.000000);
	TextDrawAlignment(MechTune_Switch, 1);
	TextDrawColor(MechTune_Switch, -1);
	TextDrawSetShadow(MechTune_Switch, 0);
	TextDrawSetOutline(MechTune_Switch, 0);
	TextDrawBackgroundColor(MechTune_Switch, 0);
	TextDrawFont(MechTune_Switch, 5);
	TextDrawSetProportional(MechTune_Switch, 0);
	TextDrawSetShadow(MechTune_Switch, 0);
	TextDrawSetPreviewModel(MechTune_Switch, 1080);
	TextDrawSetPreviewRot(MechTune_Switch, 0.000000, 0.000000, 91.000000, 1.000000);

	MechTune_Grove = TextDrawCreate(263.095245, 187.853332, "");
	TextDrawLetterSize(MechTune_Grove, 0.000000, 0.000000);
	TextDrawTextSize(MechTune_Grove, 35.000000, 40.000000);
	TextDrawAlignment(MechTune_Grove, 1);
	TextDrawColor(MechTune_Grove, -1);
	TextDrawSetShadow(MechTune_Grove, 0);
	TextDrawSetOutline(MechTune_Grove, 0);
	TextDrawBackgroundColor(MechTune_Grove, 0);
	TextDrawFont(MechTune_Grove, 5);
	TextDrawSetProportional(MechTune_Grove, 0);
	TextDrawSetShadow(MechTune_Grove, 0);
	TextDrawSetPreviewModel(MechTune_Grove, 1081);
	TextDrawSetPreviewRot(MechTune_Grove, 0.000000, 0.000000, 91.000000, 1.000000);

	MechTune_Import = TextDrawCreate(321.000061, 188.706665, "");
	TextDrawLetterSize(MechTune_Import, 0.000000, 0.000000);
	TextDrawTextSize(MechTune_Import, 35.000000, 40.000000);
	TextDrawAlignment(MechTune_Import, 1);
	TextDrawColor(MechTune_Import, -1);
	TextDrawSetShadow(MechTune_Import, 0);
	TextDrawSetOutline(MechTune_Import, 0);
	TextDrawBackgroundColor(MechTune_Import, 0);
	TextDrawFont(MechTune_Import, 5);
	TextDrawSetProportional(MechTune_Import, 0);
	TextDrawSetShadow(MechTune_Import, 0);
	TextDrawSetPreviewModel(MechTune_Import, 1082);
	TextDrawSetPreviewRot(MechTune_Import, 0.000000, 0.000000, 91.000000, 1.000000);

	MechTune_Dollar = TextDrawCreate(377.000030, 188.706665, "");
	TextDrawLetterSize(MechTune_Dollar, 0.000000, 0.000000);
	TextDrawTextSize(MechTune_Dollar, 35.000000, 40.000000);
	TextDrawAlignment(MechTune_Dollar, 1);
	TextDrawColor(MechTune_Dollar, -1);
	TextDrawSetShadow(MechTune_Dollar, 0);
	TextDrawSetOutline(MechTune_Dollar, 0);
	TextDrawBackgroundColor(MechTune_Dollar, 0);
	TextDrawFont(MechTune_Dollar, 5);
	TextDrawSetProportional(MechTune_Dollar, 0);
	TextDrawSetShadow(MechTune_Dollar, 0);
	TextDrawSetPreviewModel(MechTune_Dollar, 1083);
	TextDrawSetPreviewRot(MechTune_Dollar, 0.000000, 0.000000, 91.000000, 1.000000);

	MechTune_Trance = TextDrawCreate(431.857238, 188.706665, "");
	TextDrawLetterSize(MechTune_Trance, 0.000000, 0.000000);
	TextDrawTextSize(MechTune_Trance, 35.000000, 40.000000);
	TextDrawAlignment(MechTune_Trance, 1);
	TextDrawColor(MechTune_Trance, -1);
	TextDrawSetShadow(MechTune_Trance, 0);
	TextDrawSetOutline(MechTune_Trance, 0);
	TextDrawBackgroundColor(MechTune_Trance, 0);
	TextDrawFont(MechTune_Trance, 5);
	TextDrawSetProportional(MechTune_Trance, 0);
	TextDrawSetShadow(MechTune_Trance, 0);
	TextDrawSetPreviewModel(MechTune_Trance, 1084);
	TextDrawSetPreviewRot(MechTune_Trance, 0.000000, 0.000000, 91.000000, 1.000000);

	MechTune_Atomic = TextDrawCreate(150.714401, 247.586608, "");
	TextDrawLetterSize(MechTune_Atomic, 0.000000, 0.000000);
	TextDrawTextSize(MechTune_Atomic, 35.000000, 40.000000);
	TextDrawAlignment(MechTune_Atomic, 1);
	TextDrawColor(MechTune_Atomic, -1);
	TextDrawSetShadow(MechTune_Atomic, 0);
	TextDrawSetOutline(MechTune_Atomic, 0);
	TextDrawBackgroundColor(MechTune_Atomic, 0);
	TextDrawFont(MechTune_Atomic, 5);
	TextDrawSetProportional(MechTune_Atomic, 0);
	TextDrawSetShadow(MechTune_Atomic, 0);
	TextDrawSetPreviewModel(MechTune_Atomic, 1085);
	TextDrawSetPreviewRot(MechTune_Atomic, 0.000000, 0.000000, 91.000000, 1.000000);

	MechTune_Ahab = TextDrawCreate(207.095275, 247.586608, "");
	TextDrawLetterSize(MechTune_Ahab, 0.000000, 0.000000);
	TextDrawTextSize(MechTune_Ahab, 35.000000, 40.000000);
	TextDrawAlignment(MechTune_Ahab, 1);
	TextDrawColor(MechTune_Ahab, -1);
	TextDrawSetShadow(MechTune_Ahab, 0);
	TextDrawSetOutline(MechTune_Ahab, 0);
	TextDrawBackgroundColor(MechTune_Ahab, 0);
	TextDrawFont(MechTune_Ahab, 5);
	TextDrawSetProportional(MechTune_Ahab, 0);
	TextDrawSetShadow(MechTune_Ahab, 0);
	TextDrawSetPreviewModel(MechTune_Ahab, 1096);
	TextDrawSetPreviewRot(MechTune_Ahab, 0.000000, 0.000000, 91.000000, 1.000000);

	MechTune_Virtual = TextDrawCreate(262.714263, 248.013275, "");
	TextDrawLetterSize(MechTune_Virtual, 0.000000, 0.000000);
	TextDrawTextSize(MechTune_Virtual, 35.000000, 40.000000);
	TextDrawAlignment(MechTune_Virtual, 1);
	TextDrawColor(MechTune_Virtual, -1);
	TextDrawSetShadow(MechTune_Virtual, 0);
	TextDrawSetOutline(MechTune_Virtual, 0);
	TextDrawBackgroundColor(MechTune_Virtual, 0);
	TextDrawFont(MechTune_Virtual, 5);
	TextDrawSetProportional(MechTune_Virtual, 0);
	TextDrawSetShadow(MechTune_Virtual, 0);
	TextDrawSetPreviewModel(MechTune_Virtual, 1097);
	TextDrawSetPreviewRot(MechTune_Virtual, 0.000000, 0.000000, 91.000000, 1.000000);

	MechTune_Access = TextDrawCreate(320.618896, 248.866607, "");
	TextDrawLetterSize(MechTune_Access, 0.000000, 0.000000);
	TextDrawTextSize(MechTune_Access, 35.000000, 40.000000);
	TextDrawAlignment(MechTune_Access, 1);
	TextDrawColor(MechTune_Access, -1);
	TextDrawSetShadow(MechTune_Access, 0);
	TextDrawSetOutline(MechTune_Access, 0);
	TextDrawBackgroundColor(MechTune_Access, 0);
	TextDrawFont(MechTune_Access, 5);
	TextDrawSetProportional(MechTune_Access, 0);
	TextDrawSetShadow(MechTune_Access, 0);
	TextDrawSetPreviewModel(MechTune_Access, 1098);
	TextDrawSetPreviewRot(MechTune_Access, 0.000000, 0.000000, 91.000000, 1.000000);

	MechTune_Offroad = TextDrawCreate(377.380706, 248.866607, "");
	TextDrawLetterSize(MechTune_Offroad, 0.000000, 0.000000);
	TextDrawTextSize(MechTune_Offroad, 35.000000, 40.000000);
	TextDrawAlignment(MechTune_Offroad, 1);
	TextDrawColor(MechTune_Offroad, -1);
	TextDrawSetShadow(MechTune_Offroad, 0);
	TextDrawSetOutline(MechTune_Offroad, 0);
	TextDrawBackgroundColor(MechTune_Offroad, 0);
	TextDrawFont(MechTune_Offroad, 5);
	TextDrawSetProportional(MechTune_Offroad, 0);
	TextDrawSetShadow(MechTune_Offroad, 0);
	TextDrawSetPreviewModel(MechTune_Offroad, 1025);
	TextDrawSetPreviewRot(MechTune_Offroad, 0.000000, 0.000000, 91.000000, 1.000000);

	MechTune_Hidraulics = TextDrawCreate(405.190429, 240.333312, "");
	TextDrawLetterSize(MechTune_Hidraulics, 0.000000, 0.000000);
	TextDrawTextSize(MechTune_Hidraulics, 69.000000, 71.000000);
	TextDrawAlignment(MechTune_Hidraulics, 1);
	TextDrawColor(MechTune_Hidraulics, -1);
	TextDrawSetShadow(MechTune_Hidraulics, 0);
	TextDrawSetOutline(MechTune_Hidraulics, 0);
	TextDrawBackgroundColor(MechTune_Hidraulics, 0);
	TextDrawFont(MechTune_Hidraulics, 5);
	TextDrawSetProportional(MechTune_Hidraulics, 0);
	TextDrawSetShadow(MechTune_Hidraulics, 0);
	TextDrawSetPreviewModel(MechTune_Hidraulics, 1114);
	TextDrawSetPreviewRot(MechTune_Hidraulics, 128.000000, 160.000000, 130.000000, 1.489868);

	MechTune_TextShadow = TextDrawCreate(147.523803, 123.440048, "SHADOW~n~~n~~n~~n~~n~"#MECHANICS_SHADOW_PRICE"$");
	TextDrawLetterSize(MechTune_TextShadow, 0.158475, 0.849066);
	TextDrawAlignment(MechTune_TextShadow, 1);
	TextDrawColor(MechTune_TextShadow, -159);
	TextDrawSetShadow(MechTune_TextShadow, 0);
	TextDrawSetOutline(MechTune_TextShadow, 0);
	TextDrawBackgroundColor(MechTune_TextShadow, 255);
	TextDrawFont(MechTune_TextShadow, 1);
	TextDrawSetProportional(MechTune_TextShadow, 1);
	TextDrawSetShadow(MechTune_TextShadow, 0);

	MechTune_TextMega = TextDrawCreate(203.523742, 123.440048, "MEGA~n~~n~~n~~n~~n~"#MECHANICS_MEGA_PRICE"$");
	TextDrawLetterSize(MechTune_TextMega, 0.158475, 0.849066);
	TextDrawAlignment(MechTune_TextMega, 1);
	TextDrawColor(MechTune_TextMega, -159);
	TextDrawSetShadow(MechTune_TextMega, 0);
	TextDrawSetOutline(MechTune_TextMega, 0);
	TextDrawBackgroundColor(MechTune_TextMega, 255);
	TextDrawFont(MechTune_TextMega, 1);
	TextDrawSetProportional(MechTune_TextMega, 1);
	TextDrawSetShadow(MechTune_TextMega, 0);

	MechTune_TextRimshine = TextDrawCreate(258.761779, 123.866714, "RIMSHINE~n~~n~~n~~n~~n~"#MECHANICS_RIMSHINE_PRICE"$");
	TextDrawLetterSize(MechTune_TextRimshine, 0.158475, 0.849066);
	TextDrawAlignment(MechTune_TextRimshine, 1);
	TextDrawColor(MechTune_TextRimshine, -159);
	TextDrawSetShadow(MechTune_TextRimshine, 0);
	TextDrawSetOutline(MechTune_TextRimshine, 0);
	TextDrawBackgroundColor(MechTune_TextRimshine, 255);
	TextDrawFont(MechTune_TextRimshine, 1);
	TextDrawSetProportional(MechTune_TextRimshine, 1);
	TextDrawSetShadow(MechTune_TextRimshine, 0);

	MechTune_TextWires = TextDrawCreate(316.285614, 123.866714, "WIRES~n~~n~~n~~n~~n~"#MECHANICS_WIRES_PRICE"$");
	TextDrawLetterSize(MechTune_TextWires, 0.158475, 0.849066);
	TextDrawAlignment(MechTune_TextWires, 1);
	TextDrawColor(MechTune_TextWires, -159);
	TextDrawSetShadow(MechTune_TextWires, 0);
	TextDrawSetOutline(MechTune_TextWires, 0);
	TextDrawBackgroundColor(MechTune_TextWires, 255);
	TextDrawFont(MechTune_TextWires, 1);
	TextDrawSetProportional(MechTune_TextWires, 1);
	TextDrawSetShadow(MechTune_TextWires, 0);

	MechTune_TextClassic = TextDrawCreate(372.666534, 123.866714, "CLASSIC~n~~n~~n~~n~~n~"#MECHANICS_CLASSIC_PRICE"$");
	TextDrawLetterSize(MechTune_TextClassic, 0.158475, 0.849066);
	TextDrawAlignment(MechTune_TextClassic, 1);
	TextDrawColor(MechTune_TextClassic, -159);
	TextDrawSetShadow(MechTune_TextClassic, 0);
	TextDrawSetOutline(MechTune_TextClassic, 0);
	TextDrawBackgroundColor(MechTune_TextClassic, 255);
	TextDrawFont(MechTune_TextClassic, 1);
	TextDrawSetProportional(MechTune_TextClassic, 1);
	TextDrawSetShadow(MechTune_TextClassic, 0);

	MechTune_TextTwist = TextDrawCreate(428.666534, 123.866714, "TWIST~n~~n~~n~~n~~n~"#MECHANICS_TWIST_PRICE"$");
	TextDrawLetterSize(MechTune_TextTwist, 0.158475, 0.849066);
	TextDrawAlignment(MechTune_TextTwist, 1);
	TextDrawColor(MechTune_TextTwist, -159);
	TextDrawSetShadow(MechTune_TextTwist, 0);
	TextDrawSetOutline(MechTune_TextTwist, 0);
	TextDrawBackgroundColor(MechTune_TextTwist, 255);
	TextDrawFont(MechTune_TextTwist, 1);
	TextDrawSetProportional(MechTune_TextTwist, 1);
	TextDrawSetShadow(MechTune_TextTwist, 0);

	MechTune_TextCutter = TextDrawCreate(147.904693, 184.026748, "CUTTER~n~~n~~n~~n~~n~"#MECHANICS_CUTTER_PRICE"$");
	TextDrawLetterSize(MechTune_TextCutter, 0.158475, 0.849066);
	TextDrawAlignment(MechTune_TextCutter, 1);
	TextDrawColor(MechTune_TextCutter, -159);
	TextDrawSetShadow(MechTune_TextCutter, 0);
	TextDrawSetOutline(MechTune_TextCutter, 0);
	TextDrawBackgroundColor(MechTune_TextCutter, 255);
	TextDrawFont(MechTune_TextCutter, 1);
	TextDrawSetProportional(MechTune_TextCutter, 1);
	TextDrawSetShadow(MechTune_TextCutter, 0);

	MechTune_TextSwitch = TextDrawCreate(203.523757, 184.453414, "SWITCH~n~~n~~n~~n~~n~"#MECHANICS_SWITCH_PRICE"$");
	TextDrawLetterSize(MechTune_TextSwitch, 0.158475, 0.849066);
	TextDrawAlignment(MechTune_TextSwitch, 1);
	TextDrawColor(MechTune_TextSwitch, -159);
	TextDrawSetShadow(MechTune_TextSwitch, 0);
	TextDrawSetOutline(MechTune_TextSwitch, 0);
	TextDrawBackgroundColor(MechTune_TextSwitch, 255);
	TextDrawFont(MechTune_TextSwitch, 1);
	TextDrawSetProportional(MechTune_TextSwitch, 1);
	TextDrawSetShadow(MechTune_TextSwitch, 0);

	MechTune_TextGrove = TextDrawCreate(259.142791, 184.453414, "GROVE~n~~n~~n~~n~~n~"#MECHANICS_GROVE_PRICE"$");
	TextDrawLetterSize(MechTune_TextGrove, 0.158475, 0.849066);
	TextDrawAlignment(MechTune_TextGrove, 1);
	TextDrawColor(MechTune_TextGrove, -159);
	TextDrawSetShadow(MechTune_TextGrove, 0);
	TextDrawSetOutline(MechTune_TextGrove, 0);
	TextDrawBackgroundColor(MechTune_TextGrove, 255);
	TextDrawFont(MechTune_TextGrove, 1);
	TextDrawSetProportional(MechTune_TextGrove, 1);
	TextDrawSetShadow(MechTune_TextGrove, 0);

	MechTune_TextImport = TextDrawCreate(315.904724, 184.453414, "IMPORT~n~~n~~n~~n~~n~"#MECHANICS_IMPORT_PRICE"$");
	TextDrawLetterSize(MechTune_TextImport, 0.158475, 0.849066);
	TextDrawAlignment(MechTune_TextImport, 1);
	TextDrawColor(MechTune_TextImport, -159);
	TextDrawSetShadow(MechTune_TextImport, 0);
	TextDrawSetOutline(MechTune_TextImport, 0);
	TextDrawBackgroundColor(MechTune_TextImport, 255);
	TextDrawFont(MechTune_TextImport, 1);
	TextDrawSetProportional(MechTune_TextImport, 1);
	TextDrawSetShadow(MechTune_TextImport, 0);

	MechTune_TextDollar = TextDrawCreate(373.409454, 184.453414, "DOLLAR~n~~n~~n~~n~~n~"#MECHANICS_DOLLAR_PRICE"$");
	TextDrawLetterSize(MechTune_TextDollar, 0.158475, 0.849066);
	TextDrawAlignment(MechTune_TextDollar, 1);
	TextDrawColor(MechTune_TextDollar, -159);
	TextDrawSetShadow(MechTune_TextDollar, 0);
	TextDrawSetOutline(MechTune_TextDollar, 0);
	TextDrawBackgroundColor(MechTune_TextDollar, 255);
	TextDrawFont(MechTune_TextDollar, 1);
	TextDrawSetProportional(MechTune_TextDollar, 1);
	TextDrawSetShadow(MechTune_TextDollar, 0);

	MechTune_TextTrance = TextDrawCreate(428.266510, 184.453414, "TRANCE~n~~n~~n~~n~~n~"#MECHANICS_TRANCE_PRICE"$");
	TextDrawLetterSize(MechTune_TextTrance, 0.158475, 0.849066);
	TextDrawAlignment(MechTune_TextTrance, 1);
	TextDrawColor(MechTune_TextTrance, -159);
	TextDrawSetShadow(MechTune_TextTrance, 0);
	TextDrawSetOutline(MechTune_TextTrance, 0);
	TextDrawBackgroundColor(MechTune_TextTrance, 255);
	TextDrawFont(MechTune_TextTrance, 1);
	TextDrawSetProportional(MechTune_TextTrance, 1);
	TextDrawSetShadow(MechTune_TextTrance, 0);

	MechTune_TextAtomic = TextDrawCreate(148.266525, 244.613403, "ATOMIC~n~~n~~n~~n~~n~"#MECHANICS_ATOMIC_PRICE"$");
	TextDrawLetterSize(MechTune_TextAtomic, 0.158475, 0.849066);
	TextDrawAlignment(MechTune_TextAtomic, 1);
	TextDrawColor(MechTune_TextAtomic, -159);
	TextDrawSetShadow(MechTune_TextAtomic, 0);
	TextDrawSetOutline(MechTune_TextAtomic, 0);
	TextDrawBackgroundColor(MechTune_TextAtomic, 255);
	TextDrawFont(MechTune_TextAtomic, 1);
	TextDrawSetProportional(MechTune_TextAtomic, 1);
	TextDrawSetShadow(MechTune_TextAtomic, 0);

	MechTune_TextAhab = TextDrawCreate(204.266510, 244.613403, "AHAB~n~~n~~n~~n~~n~"#MECHANICS_AHAB_PRICE"$");
	TextDrawLetterSize(MechTune_TextAhab, 0.158475, 0.849066);
	TextDrawAlignment(MechTune_TextAhab, 1);
	TextDrawColor(MechTune_TextAhab, -159);
	TextDrawSetShadow(MechTune_TextAhab, 0);
	TextDrawSetOutline(MechTune_TextAhab, 0);
	TextDrawBackgroundColor(MechTune_TextAhab, 255);
	TextDrawFont(MechTune_TextAhab, 1);
	TextDrawSetProportional(MechTune_TextAhab, 1);
	TextDrawSetShadow(MechTune_TextAhab, 0);

	MechTune_TextVirtual = TextDrawCreate(259.8855, 244.1867, "VIRTUAL~n~~n~~n~~n~~n~"#MECHANICS_VIRTUAL_PRICE"$");
	TextDrawLetterSize(MechTune_TextVirtual, 0.158475, 0.849066);
	TextDrawAlignment(MechTune_TextVirtual, 1);
	TextDrawColor(MechTune_TextVirtual, -159);
	TextDrawSetShadow(MechTune_TextVirtual, 0);
	TextDrawSetOutline(MechTune_TextVirtual, 0);
	TextDrawBackgroundColor(MechTune_TextVirtual, 255);
	TextDrawFont(MechTune_TextVirtual, 1);
	TextDrawSetProportional(MechTune_TextVirtual, 1);
	TextDrawSetShadow(MechTune_TextVirtual, 0);

	MechTune_TextAccess = TextDrawCreate(316.647430, 244.186737, "ACCESS~n~~n~~n~~n~~n~"#MECHANICS_ACCESS_PRICE"$");
	TextDrawLetterSize(MechTune_TextAccess, 0.158475, 0.849066);
	TextDrawAlignment(MechTune_TextAccess, 1);
	TextDrawColor(MechTune_TextAccess, -159);
	TextDrawSetShadow(MechTune_TextAccess, 0);
	TextDrawSetOutline(MechTune_TextAccess, 0);
	TextDrawBackgroundColor(MechTune_TextAccess, 255);
	TextDrawFont(MechTune_TextAccess, 1);
	TextDrawSetProportional(MechTune_TextAccess, 1);
	TextDrawSetShadow(MechTune_TextAccess, 0);

	MechTune_TextOffroad = TextDrawCreate(373.790313, 245.040069, "OFFROAD~n~~n~~n~~n~~n~"#MECHANICS_OFFROAD_PRICE"$");
	TextDrawLetterSize(MechTune_TextOffroad, 0.158475, 0.849066);
	TextDrawAlignment(MechTune_TextOffroad, 1);
	TextDrawColor(MechTune_TextOffroad, -159);
	TextDrawSetShadow(MechTune_TextOffroad, 0);
	TextDrawSetOutline(MechTune_TextOffroad, 0);
	TextDrawBackgroundColor(MechTune_TextOffroad, 255);
	TextDrawFont(MechTune_TextOffroad, 1);
	TextDrawSetProportional(MechTune_TextOffroad, 1);
	TextDrawSetShadow(MechTune_TextOffroad, 0);

	MechTune_TextHidraulics = TextDrawCreate(429.409423, 244.613403, "HIDRAULIKA~n~~n~~n~~n~~n~"#MECHANICS_HIDRAULICS_PRICE"$");
	TextDrawLetterSize(MechTune_TextHidraulics, 0.158475, 0.849066);
	TextDrawAlignment(MechTune_TextHidraulics, 1);
	TextDrawColor(MechTune_TextHidraulics, -159);
	TextDrawSetShadow(MechTune_TextHidraulics, 0);
	TextDrawSetOutline(MechTune_TextHidraulics, 0);
	TextDrawBackgroundColor(MechTune_TextHidraulics, 255);
	TextDrawFont(MechTune_TextHidraulics, 1);
	TextDrawSetProportional(MechTune_TextHidraulics, 1);
	TextDrawSetShadow(MechTune_TextHidraulics, 0);
}

stock MechTune_Create_Player(playerid)
{
	MechTune_BasePart[playerid][0] = CreatePlayerTextDraw(playerid, 144.238098, 120.866699, "LD_SPAC:white");
	MechTune_BasePart[playerid][1] = CreatePlayerTextDraw(playerid, 199.857101, 120.866699, "LD_SPAC:white");
	MechTune_BasePart[playerid][2] = CreatePlayerTextDraw(playerid, 255.476150, 120.866699, "LD_SPAC:white");
	MechTune_BasePart[playerid][3] = CreatePlayerTextDraw(playerid, 312.237976, 120.866699, "LD_SPAC:white");
	MechTune_BasePart[playerid][4] = CreatePlayerTextDraw(playerid, 368.618896, 120.866699, "LD_SPAC:white");
	MechTune_BasePart[playerid][5] = CreatePlayerTextDraw(playerid, 424.237915, 120.866699, "LD_SPAC:white");
	MechTune_BasePart[playerid][6] = CreatePlayerTextDraw(playerid, 144.238098, 180.600036, "LD_SPAC:white");
	MechTune_BasePart[playerid][7] = CreatePlayerTextDraw(playerid, 199.857162, 181.026702, "LD_SPAC:white");
	MechTune_BasePart[playerid][8] = CreatePlayerTextDraw(playerid, 255.857147, 181.313201, "LD_SPAC:white");
	MechTune_BasePart[playerid][9] = CreatePlayerTextDraw(playerid, 312.619049, 181.313201, "LD_SPAC:white");
	MechTune_BasePart[playerid][10] = CreatePlayerTextDraw(playerid, 368.999938, 181.313201, "LD_SPAC:white");
	MechTune_BasePart[playerid][11] = CreatePlayerTextDraw(playerid, 424.238037, 181.313201, "LD_SPAC:white");
	MechTune_BasePart[playerid][12] = CreatePlayerTextDraw(playerid, 144.238098, 240.759979, "LD_SPAC:white");
	MechTune_BasePart[playerid][13] = CreatePlayerTextDraw(playerid, 200.238082, 240.759979, "LD_SPAC:white");
	MechTune_BasePart[playerid][14] = CreatePlayerTextDraw(playerid, 255.095184, 241.186645, "LD_SPAC:white");
	MechTune_BasePart[playerid][15] = CreatePlayerTextDraw(playerid, 312.618988, 241.186645, "LD_SPAC:white");
	MechTune_BasePart[playerid][16] = CreatePlayerTextDraw(playerid, 369.380920, 241.613311, "LD_SPAC:white");
	MechTune_BasePart[playerid][17] = CreatePlayerTextDraw(playerid, 425.380920, 242.039978, "LD_SPAC:white");
	for(new i = 0; i < 18; i++)
	{
		PlayerTextDrawLetterSize(playerid, MechTune_BasePart[playerid][i], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, MechTune_BasePart[playerid][i], 50.000000, 53.000000);
		PlayerTextDrawAlignment(playerid, MechTune_BasePart[playerid][i], 1);
		PlayerTextDrawColor(playerid, MechTune_BasePart[playerid][i], 65);
		PlayerTextDrawSetShadow(playerid, MechTune_BasePart[playerid][i], 0);
		PlayerTextDrawSetOutline(playerid, MechTune_BasePart[playerid][i], 0);
		PlayerTextDrawBackgroundColor(playerid, MechTune_BasePart[playerid][i], 255);
		PlayerTextDrawFont(playerid, MechTune_BasePart[playerid][i], 4);
		PlayerTextDrawSetProportional(playerid, MechTune_BasePart[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, MechTune_BasePart[playerid][i], 0);
		PlayerTextDrawSetSelectable(playerid, MechTune_BasePart[playerid][i], true);
	}
}

stock VLTextdraw_Create_Global()
{
	VL_Base = TextDrawCreate(95.714256, 93.573341, "box");
	TextDrawLetterSize(VL_Base, 0.000000, 29.123804);
	TextDrawTextSize(VL_Base, 530.000000, 0.000000);
	TextDrawAlignment(VL_Base, 1);
	TextDrawColor(VL_Base, -1);
	TextDrawUseBox(VL_Base, 1);
	TextDrawBoxColor(VL_Base, 45);
	TextDrawSetShadow(VL_Base, 0);
	TextDrawSetOutline(VL_Base, 0);
	TextDrawBackgroundColor(VL_Base, 255);
	TextDrawFont(VL_Base, 1);
	TextDrawSetProportional(VL_Base, 1);
	TextDrawSetShadow(VL_Base, 0);

	VL_RowBase[0] = TextDrawCreate(98.142883, 96.120002, "LD_SPAC:white");
	VL_RowBase[1] = TextDrawCreate(206.333389, 96.120002, "LD_SPAC:white");
	VL_RowBase[2] = TextDrawCreate(314.523864, 96.120002, "LD_SPAC:white");
	VL_RowBase[3] = TextDrawCreate(422.714294, 95.693328, "LD_SPAC:white");
	for(new i = 0; i < 4; i++)
	{
		TextDrawLetterSize(VL_RowBase[i], 0.000000, 0.000000);
		TextDrawTextSize(VL_RowBase[i], 105.000000, 257.000000);
		TextDrawAlignment(VL_RowBase[i], 1);
		TextDrawColor(VL_RowBase[i], 1546072444);
		TextDrawSetShadow(VL_RowBase[i], 0);
		TextDrawSetOutline(VL_RowBase[i], 0);
		TextDrawBackgroundColor(VL_RowBase[i], 255);
		TextDrawFont(VL_RowBase[i], 4);
		TextDrawSetProportional(VL_RowBase[i], 0);
		TextDrawSetShadow(VL_RowBase[i], 0);
	}

	VL_PageText = TextDrawCreate(515.542883, 360.696564, "<    >");
	TextDrawLetterSize(VL_PageText, 0.217904, 1.127933);
	TextDrawAlignment(VL_PageText, 2);
	TextDrawColor(VL_PageText, -1);
	TextDrawSetShadow(VL_PageText, 0);
	TextDrawSetOutline(VL_PageText, 0);
	TextDrawBackgroundColor(VL_PageText, 255);
	TextDrawFont(VL_PageText, 1);
	TextDrawSetProportional(VL_PageText, 1);
	TextDrawSetShadow(VL_PageText, 0);
	return 1;
}

stock VLTextdraw_Create_Player(playerid)
{
	/*
	 * Funkcija, sukurianti masinu listo textdrawus.
	 */
	VL_ModelName[playerid][0] = CreatePlayerTextDraw(playerid, 150.000000, 173.000000, "Infernus");
	VL_ModelBase[playerid][0] = CreatePlayerTextDraw(playerid, 93.000000, 90.000000, "");
	VL_RowText[playerid][0] = CreatePlayerTextDraw(playerid, 148.000000, 199.000000, "NUMERIAI:_ADSX1231~n~DEGALAI:_120L~n~RIDA:_120000KM~n~DRAUDIMAS:_5~n~SIGNALIZACIJA:_1~n~UZRAKTO_LYGIS:_3");
	VL_SpawnBox[playerid][0] = CreatePlayerTextDraw(playerid, 101.000000, 287.000000, "LD_SPAC:white");
	VL_FindBox[playerid][0] = CreatePlayerTextDraw(playerid, 101.000000, 319.000000, "LD_SPAC:white");

	VL_ModelName[playerid][1] = CreatePlayerTextDraw(playerid, 261.000000, 172.000000, "Infernus");
	VL_ModelBase[playerid][1] = CreatePlayerTextDraw(playerid, 202.000000, 91.000000, "");
	VL_RowText[playerid][1] = CreatePlayerTextDraw(playerid, 259.000000, 199.000000, "NUMERIAI:_ADSX1231~n~DEGALAI:_120L~n~RIDA:_120000KM~n~DRAUDIMAS:_5~n~SIGNALIZACIJA:_1~n~UZRAKTO_LYGIS:_3");
	VL_SpawnBox[playerid][1] = CreatePlayerTextDraw(playerid, 209.000000, 287.000000, "LD_SPAC:white");
	VL_FindBox[playerid][1] = CreatePlayerTextDraw(playerid, 209.000000, 319.000000, "LD_SPAC:white");

	VL_ModelName[playerid][2] = CreatePlayerTextDraw(playerid, 366.000000, 171.000000, "Infernus");
	VL_ModelBase[playerid][2] = CreatePlayerTextDraw(playerid, 308.000000, 90.000000, "");
	VL_RowText[playerid][2] = CreatePlayerTextDraw(playerid, 367.000000, 199.000000, "NUMERIAI:_ADSX1231~n~DEGALAI:_120L~n~RIDA:_120000KM~n~DRAUDIMAS:_5~n~SIGNALIZACIJA:_1~n~UZRAKTO_LYGIS:_3");
	VL_SpawnBox[playerid][2] = CreatePlayerTextDraw(playerid, 317.000000, 287.000000, "LD_SPAC:white");
	VL_FindBox[playerid][2] = CreatePlayerTextDraw(playerid, 317.000000, 319.000000, "LD_SPAC:white");

	VL_ModelName[playerid][3] = CreatePlayerTextDraw(playerid, 477.000000, 170.000000, "Infernus");
	VL_ModelBase[playerid][3] = CreatePlayerTextDraw(playerid, 418.000000, 90.000000, "");
	VL_RowText[playerid][3] = CreatePlayerTextDraw(playerid, 474.000000, 199.000000, "NUMERIAI:_ADSX1231~n~DEGALAI:_120L~n~RIDA:_120000KM~n~DRAUDIMAS:_5~n~SIGNALIZACIJA:_1~n~UZRAKTO_LYGIS:_3");
	VL_SpawnBox[playerid][3] = CreatePlayerTextDraw(playerid, 425.000000, 287.000000, "LD_SPAC:white");
	VL_FindBox[playerid][3] = CreatePlayerTextDraw(playerid, 425.000000, 319.000000, "LD_SPAC:white");

	VL_SpawnText[playerid][0] = CreatePlayerTextDraw(playerid, 151.000000, 297.000000, "ISSPAWNINTA");
	VL_FindText[playerid][0] = CreatePlayerTextDraw(playerid, 151.000000, 329.000000, "SURASTI");

	VL_SpawnText[playerid][1] = CreatePlayerTextDraw(playerid, 261.000000, 297.000000, "ISSPAWNINTA");
	VL_FindText[playerid][1] = CreatePlayerTextDraw(playerid, 261.000000, 329.000000, "SURASTI");

	VL_SpawnText[playerid][2] = CreatePlayerTextDraw(playerid, 367.000000, 297.000000, "ISSPAWNINTA");
	VL_FindText[playerid][2] = CreatePlayerTextDraw(playerid, 366.000000, 329.000000, "SURASTI");

	VL_SpawnText[playerid][3] = CreatePlayerTextDraw(playerid, 476.000000, 297.000000, "ISSPAWNINTA");
	VL_FindText[playerid][3] = CreatePlayerTextDraw(playerid, 476.000000, 329.000000, "SURASTI");
	
	VL_NextBase[playerid] = CreatePlayerTextDraw(playerid, 517.190612, 359.373321, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, VL_NextBase[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, VL_NextBase[playerid], 14.000000, 15.000000);
	PlayerTextDrawAlignment(playerid, VL_NextBase[playerid], 1);
	PlayerTextDrawColor(playerid, VL_NextBase[playerid], 34);
	PlayerTextDrawSetShadow(playerid, VL_NextBase[playerid], 0);
	PlayerTextDrawSetOutline(playerid, VL_NextBase[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, VL_NextBase[playerid], 255);
	PlayerTextDrawFont(playerid, VL_NextBase[playerid], 4);
	PlayerTextDrawSetProportional(playerid, VL_NextBase[playerid], 0);
	PlayerTextDrawSetShadow(playerid, VL_NextBase[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, VL_NextBase[playerid], true);

	VL_PrevBase[playerid] = CreatePlayerTextDraw(playerid, 501.571594, 359.373321, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, VL_PrevBase[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, VL_PrevBase[playerid], 14.000000, 15.000000);
	PlayerTextDrawAlignment(playerid, VL_PrevBase[playerid], 1);
	PlayerTextDrawColor(playerid, VL_PrevBase[playerid], 34);
	PlayerTextDrawSetShadow(playerid, VL_PrevBase[playerid], 0);
	PlayerTextDrawSetOutline(playerid, VL_PrevBase[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, VL_PrevBase[playerid], 255);
	PlayerTextDrawFont(playerid, VL_PrevBase[playerid], 4);
	PlayerTextDrawSetProportional(playerid, VL_PrevBase[playerid], 0);
	PlayerTextDrawSetShadow(playerid, VL_PrevBase[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, VL_PrevBase[playerid], true);

	for(new i = 0; i < 4; i++)
	{
		PlayerTextDrawLetterSize(playerid, VL_ModelName[playerid][i], 0.411809, 1.425066);
		PlayerTextDrawAlignment(playerid, VL_ModelName[playerid][i], 2);
		PlayerTextDrawColor(playerid, VL_ModelName[playerid][i], -1);
		PlayerTextDrawSetShadow(playerid, VL_ModelName[playerid][i], 0);
		PlayerTextDrawSetOutline(playerid, VL_ModelName[playerid][i], 1);
		PlayerTextDrawBackgroundColor(playerid, VL_ModelName[playerid][i], 255);
		PlayerTextDrawFont(playerid, VL_ModelName[playerid][i], 0);
		PlayerTextDrawSetProportional(playerid, VL_ModelName[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, VL_ModelName[playerid][i], 0);
	
		PlayerTextDrawLetterSize(playerid, VL_ModelBase[playerid][i], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, VL_ModelBase[playerid][i], 107.000000, 114.000000);
		PlayerTextDrawAlignment(playerid, VL_ModelBase[playerid][i], 1);
		PlayerTextDrawColor(playerid, VL_ModelBase[playerid][i], -1);
		PlayerTextDrawSetShadow(playerid, VL_ModelBase[playerid][i], 0);
		PlayerTextDrawSetOutline(playerid, VL_ModelBase[playerid][i], 0);
		PlayerTextDrawBackgroundColor(playerid, VL_ModelBase[playerid][i], 0);
		PlayerTextDrawFont(playerid, VL_ModelBase[playerid][i], 5);
		PlayerTextDrawSetProportional(playerid, VL_ModelBase[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, VL_ModelBase[playerid][i], 0);
		PlayerTextDrawSetPreviewModel(playerid, VL_ModelBase[playerid][i], 414);
		PlayerTextDrawSetPreviewRot(playerid, VL_ModelBase[playerid][i], 0.000000, 0.000000, 30.000000, 1.000000);
		PlayerTextDrawSetPreviewVehCol(playerid, VL_ModelBase[playerid][i], 1, 1);

		PlayerTextDrawLetterSize(playerid, VL_RowText[playerid][i], 0.207238, 1.058133);
		PlayerTextDrawAlignment(playerid, VL_RowText[playerid][i], 2);
		PlayerTextDrawColor(playerid, VL_RowText[playerid][i], -1);
		PlayerTextDrawSetShadow(playerid, VL_RowText[playerid][i], 1);
		PlayerTextDrawSetOutline(playerid, VL_RowText[playerid][i], 0);
		PlayerTextDrawBackgroundColor(playerid, VL_RowText[playerid][i], 1363);
		PlayerTextDrawFont(playerid, VL_RowText[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, VL_RowText[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, VL_RowText[playerid][i], 1);

		PlayerTextDrawLetterSize(playerid, VL_SpawnBox[playerid][i], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, VL_SpawnBox[playerid][i], 99.000000, 30.000000);
		PlayerTextDrawAlignment(playerid, VL_SpawnBox[playerid][i], 1);
		PlayerTextDrawColor(playerid, VL_SpawnBox[playerid][i], -12570764);
		PlayerTextDrawSetShadow(playerid, VL_SpawnBox[playerid][i], 0);
		PlayerTextDrawSetOutline(playerid, VL_SpawnBox[playerid][i], 0);
		PlayerTextDrawBackgroundColor(playerid, VL_SpawnBox[playerid][i], 255);
		PlayerTextDrawFont(playerid, VL_SpawnBox[playerid][i], 4);
		PlayerTextDrawSetProportional(playerid, VL_SpawnBox[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, VL_SpawnBox[playerid][i], 0);
		PlayerTextDrawSetSelectable(playerid, VL_SpawnBox[playerid][i], true);

		PlayerTextDrawLetterSize(playerid, VL_FindBox[playerid][i], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, VL_FindBox[playerid][i], 99.000000, 30.000000);
		PlayerTextDrawAlignment(playerid, VL_FindBox[playerid][i], 1);
		PlayerTextDrawColor(playerid, VL_FindBox[playerid][i], 1409243252);
		PlayerTextDrawSetShadow(playerid, VL_FindBox[playerid][i], 0);
		PlayerTextDrawSetOutline(playerid, VL_FindBox[playerid][i], 0);
		PlayerTextDrawBackgroundColor(playerid, VL_FindBox[playerid][i], 255);
		PlayerTextDrawFont(playerid, VL_FindBox[playerid][i], 4);
		PlayerTextDrawSetProportional(playerid, VL_FindBox[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, VL_FindBox[playerid][i], 0);
		PlayerTextDrawSetSelectable(playerid, VL_FindBox[playerid][i], true);
	
		PlayerTextDrawLetterSize(playerid, VL_SpawnText[playerid][i], 0.162666, 1.075199);
		PlayerTextDrawAlignment(playerid, VL_SpawnText[playerid][i], 2);
		PlayerTextDrawColor(playerid, VL_SpawnText[playerid][i], -1);
		PlayerTextDrawSetShadow(playerid, VL_SpawnText[playerid][i], 0);
		PlayerTextDrawSetOutline(playerid, VL_SpawnText[playerid][i], 1);
		PlayerTextDrawBackgroundColor(playerid, VL_SpawnText[playerid][i], 36);
		PlayerTextDrawFont(playerid, VL_SpawnText[playerid][i], 2);
		PlayerTextDrawSetProportional(playerid, VL_SpawnText[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, VL_SpawnText[playerid][i], 0);

		PlayerTextDrawLetterSize(playerid, VL_FindText[playerid][i], 0.162666, 1.075199);
		PlayerTextDrawAlignment(playerid, VL_FindText[playerid][i], 2);
		PlayerTextDrawColor(playerid, VL_FindText[playerid][i], -1);
		PlayerTextDrawSetShadow(playerid, VL_FindText[playerid][i], 0);
		PlayerTextDrawSetOutline(playerid, VL_FindText[playerid][i], 1);
		PlayerTextDrawBackgroundColor(playerid, VL_FindText[playerid][i], 36);
		PlayerTextDrawFont(playerid, VL_FindText[playerid][i], 2);
		PlayerTextDrawSetProportional(playerid, VL_FindText[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, VL_FindText[playerid][i], 0);
	}

	return 1;
}

stock VShop_Create_Global()
{
	vShop_Base = TextDrawCreate(99.523857, 83.333374, "box");
	TextDrawLetterSize(vShop_Base, 0.000000, 30.800003);
	TextDrawTextSize(vShop_Base, 513.000000, 0.000000);
	TextDrawAlignment(vShop_Base, 1);
	TextDrawColor(vShop_Base, -1);
	TextDrawUseBox(vShop_Base, 1);
	TextDrawBoxColor(vShop_Base, 861439);
	TextDrawSetShadow(vShop_Base, 0);
	TextDrawSetOutline(vShop_Base, 0);
	TextDrawBackgroundColor(vShop_Base, 255);
	TextDrawFont(vShop_Base, 1);
	TextDrawSetProportional(vShop_Base, 1);
	TextDrawSetShadow(vShop_Base, 0);

	vShop_Name = TextDrawCreate(102.190475, 84.613349, "TRANSPORTO_PRIEMONIU_KATALOGAS");
	TextDrawLetterSize(vShop_Name, 0.188571, 0.925866);
	TextDrawAlignment(vShop_Name, 1);
	TextDrawColor(vShop_Name, -1058144257);
	TextDrawSetShadow(vShop_Name, 0);
	TextDrawSetOutline(vShop_Name, 1);
	TextDrawBackgroundColor(vShop_Name, 255);
	TextDrawFont(vShop_Name, 1);
	TextDrawSetProportional(vShop_Name, 1);
	TextDrawSetShadow(vShop_Name, 0);

	vShop_NextBase = TextDrawCreate(499.285766, 364.066558, "LD_SPAC:white");
	TextDrawLetterSize(vShop_NextBase, 0.000000, 0.000000);
	TextDrawTextSize(vShop_NextBase, 15.000000, 15.000000);
	TextDrawAlignment(vShop_NextBase, 1);
	TextDrawColor(vShop_NextBase, 152383487);
	TextDrawSetShadow(vShop_NextBase, 0);
	TextDrawSetOutline(vShop_NextBase, 0);
	TextDrawBackgroundColor(vShop_NextBase, 255);
	TextDrawFont(vShop_NextBase, 4);
	TextDrawSetProportional(vShop_NextBase, 0);
	TextDrawSetShadow(vShop_NextBase, 0);
	TextDrawSetSelectable(vShop_NextBase, true);

	vShop_PrevBase = TextDrawCreate(482.523925, 364.066558, "LD_SPAC:white");
	TextDrawLetterSize(vShop_PrevBase, 0.000000, 0.000000);
	TextDrawTextSize(vShop_PrevBase, 15.000000, 15.000000);
	TextDrawAlignment(vShop_PrevBase, 1);
	TextDrawColor(vShop_PrevBase, 152383487);
	TextDrawSetShadow(vShop_PrevBase, 0);
	TextDrawSetOutline(vShop_PrevBase, 0);
	TextDrawBackgroundColor(vShop_PrevBase, 255);
	TextDrawFont(vShop_PrevBase, 4);
	TextDrawSetProportional(vShop_PrevBase, 0);
	TextDrawSetShadow(vShop_PrevBase, 0);
	TextDrawSetSelectable(vShop_PrevBase, true);

	vShop_Prev = TextDrawCreate(486.714324, 367.053314, "LD_BEAT:left");
	TextDrawLetterSize(vShop_Prev, 0.000000, 0.000000);
	TextDrawTextSize(vShop_Prev, 7.000000, 10.000000);
	TextDrawAlignment(vShop_Prev, 1);
	TextDrawColor(vShop_Prev, 1554055059);
	TextDrawSetShadow(vShop_Prev, 0);
	TextDrawSetOutline(vShop_Prev, 0);
	TextDrawBackgroundColor(vShop_Prev, 255);
	TextDrawFont(vShop_Prev, 4);
	TextDrawSetProportional(vShop_Prev, 0);
	TextDrawSetShadow(vShop_Prev, 0);

	vShop_Next = TextDrawCreate(503.476196, 366.626647, "LD_BEAT:right");
	TextDrawLetterSize(vShop_Next, 0.000000, 0.000000);
	TextDrawTextSize(vShop_Next, 7.000000, 10.000000);
	TextDrawAlignment(vShop_Next, 1);
	TextDrawColor(vShop_Next, 1554055059);
	TextDrawSetShadow(vShop_Next, 0);
	TextDrawSetOutline(vShop_Next, 0);
	TextDrawBackgroundColor(vShop_Next, 255);
	TextDrawFont(vShop_Next, 4);
	TextDrawSetProportional(vShop_Next, 0);
	TextDrawSetShadow(vShop_Next, 0);
	return 1;
}


stock VShop_Create_Player(playerid)
{
	/*
	 * Funkcija, kuri sukuria textdrawus auto salono.
	 */
	vShop_ModelBase[playerid][0] = CreatePlayerTextDraw(playerid, 102.714294, 97.400047, "LD_SPAC:white");
	vShop_ModelBase[playerid][1] = CreatePlayerTextDraw(playerid, 239.857147, 96.973381, "LD_SPAC:white");
	vShop_ModelBase[playerid][2] = CreatePlayerTextDraw(playerid, 378.54834, 96.973381, "LD_SPAC:white");

	vShop_Model[playerid][0] = CreatePlayerTextDraw(playerid, 90.809547, 50.586669, "");
	vShop_CarName[playerid][0] = CreatePlayerTextDraw(playerid, 165.428634, 169.946685, "Infernus");
	vShop_CarStats[playerid][0] = CreatePlayerTextDraw(playerid, 168.095214, 192.986663, "KATEGORIJA: PAPRASTOS~n~GAMYBOS METAI: 2010~n~~n~VARIKLIO LITRAZAS: 1.8L~n~KURO TIPAS: DYZELINAS~n~~n~SEDIMU VIETU SKAICIUS: 2~n~PAPILDOMA: NERA");

	vShop_CarPrice[playerid][0] = CreatePlayerTextDraw(playerid, 233.238143, 309.893280, "7500000$");

	vShop_Model[playerid][1] = CreatePlayerTextDraw(playerid, 229.476242, 50.586677, "");
	vShop_CarName[playerid][1] = CreatePlayerTextDraw(playerid, 302.571563, 170.373352, "Infernus");
	vShop_CarStats[playerid][1] = CreatePlayerTextDraw(playerid, 305.619049, 192.559997, "KATEGORIJA: SPORTINES~n~GAMYBOS METAI: 2014~n~~n~VARIKLIO LITRAZAS: 5.0L~n~KURO TIPAS: BENZINAS~n~~n~SEDIMU VIETU SKAICIUS: 2~n~PAPILDOMA: NERA");
	vShop_CarPrice[playerid][1] = CreatePlayerTextDraw(playerid, 372.285827, 309.893280, "7500000$");

	vShop_Model[playerid][2] = CreatePlayerTextDraw(playerid, 371.190521, 52.720008, "");
	vShop_CarName[playerid][2] = CreatePlayerTextDraw(playerid, 445.047760, 170.373352, "Infernus");
	vShop_CarStats[playerid][2] = CreatePlayerTextDraw(playerid, 444.666656, 192.559997, "KATEGORIJA: PRABANGIOS~n~GAMYBOS METAI: 2015~n~~n~VARIKLIO LITRAZAS: 4.4L~n~KURO TIPAS: BENZINAS~n~~n~SEDIMU VIETU SKAICIUS: 4~n~PAPILDOMA: NERA");
	vShop_CarPrice[playerid][2] = CreatePlayerTextDraw(playerid, 507.142944, 310.319946, "7500000$");

	vShop_BuyBase[playerid] = CreatePlayerTextDraw(playerid,102.714279, 342.733306, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, vShop_BuyBase[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, vShop_BuyBase[playerid], 407.000000, 15.000000);
	PlayerTextDrawAlignment(playerid, vShop_BuyBase[playerid], 1);
	PlayerTextDrawColor(playerid, vShop_BuyBase[playerid], 3815326);
	PlayerTextDrawSetShadow(playerid, vShop_BuyBase[playerid], 0);
	PlayerTextDrawSetOutline(playerid, vShop_BuyBase[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, vShop_BuyBase[playerid], 255);
	PlayerTextDrawFont(playerid, vShop_BuyBase[playerid], 4);
	PlayerTextDrawSetProportional(playerid, vShop_BuyBase[playerid], 0);
	PlayerTextDrawSetShadow(playerid, vShop_BuyBase[playerid], 0);

	vShop_BuyText[playerid] = CreatePlayerTextDraw(playerid,310.952209, 345.733276, "PIRKIMAS");
	PlayerTextDrawLetterSize(playerid, vShop_BuyText[playerid], 0.181712, 0.891731);
	PlayerTextDrawAlignment(playerid, vShop_BuyText[playerid], 2);
	PlayerTextDrawColor(playerid, vShop_BuyText[playerid], -211);
	PlayerTextDrawSetShadow(playerid, vShop_BuyText[playerid], 0);
	PlayerTextDrawSetOutline(playerid, vShop_BuyText[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, vShop_BuyText[playerid], 255);
	PlayerTextDrawFont(playerid, vShop_BuyText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, vShop_BuyText[playerid], 1);
	PlayerTextDrawSetShadow(playerid, vShop_BuyText[playerid], 0);

	for(new i = 0; i < 3; i++)
	{
		PlayerTextDrawLetterSize(playerid, vShop_Model[playerid][i], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, vShop_Model[playerid][i], 129.000000, 163.000000);
		PlayerTextDrawAlignment(playerid, vShop_Model[playerid][i], 1);
		PlayerTextDrawColor(playerid, vShop_Model[playerid][i], -1);
		PlayerTextDrawSetShadow(playerid, vShop_Model[playerid][i], 0);
		PlayerTextDrawSetOutline(playerid, vShop_Model[playerid][i], 0);
		PlayerTextDrawBackgroundColor(playerid, vShop_Model[playerid][i], 0);
		PlayerTextDrawFont(playerid, vShop_Model[playerid][i], 5);
		PlayerTextDrawSetProportional(playerid, vShop_Model[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, vShop_Model[playerid][i], 0);
		PlayerTextDrawSetPreviewModel(playerid, vShop_Model[playerid][i], 411);
		PlayerTextDrawSetPreviewRot(playerid, vShop_Model[playerid][i], 0.000000, 0.000000, 35.000000, 0.887960);
		PlayerTextDrawSetPreviewVehCol(playerid, vShop_Model[playerid][i], 24, 1);

		PlayerTextDrawLetterSize(playerid, vShop_CarName[playerid][i], 0.510855, 1.813331);
		PlayerTextDrawAlignment(playerid, vShop_CarName[playerid][i], 2);
		PlayerTextDrawColor(playerid, vShop_CarName[playerid][i], -607614216);
		PlayerTextDrawSetShadow(playerid, vShop_CarName[playerid][i], 0);
		PlayerTextDrawSetOutline(playerid, vShop_CarName[playerid][i], 1);
		PlayerTextDrawBackgroundColor(playerid, vShop_CarName[playerid][i], 99);
		PlayerTextDrawFont(playerid, vShop_CarName[playerid][i], 0);
		PlayerTextDrawSetProportional(playerid, vShop_CarName[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, vShop_CarName[playerid][i], 0);

		PlayerTextDrawLetterSize(playerid, vShop_CarStats[playerid][i], 0.182475, 1.117866);
		PlayerTextDrawAlignment(playerid, vShop_CarStats[playerid][i], 2);
		PlayerTextDrawColor(playerid, vShop_CarStats[playerid][i], -1);
		PlayerTextDrawSetShadow(playerid, vShop_CarStats[playerid][i], 0);
		PlayerTextDrawSetOutline(playerid, vShop_CarStats[playerid][i], 1);
		PlayerTextDrawBackgroundColor(playerid, vShop_CarStats[playerid][i], 39);
		PlayerTextDrawFont(playerid, vShop_CarStats[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, vShop_CarStats[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, vShop_CarStats[playerid][i], 0);

		PlayerTextDrawLetterSize(playerid, vShop_CarPrice[playerid][i], 0.354665, 1.826132);
		PlayerTextDrawAlignment(playerid, vShop_CarPrice[playerid][i], 3);
		PlayerTextDrawColor(playerid, vShop_CarPrice[playerid][i], 512171775);
		PlayerTextDrawSetShadow(playerid, vShop_CarPrice[playerid][i], 0);
		PlayerTextDrawSetOutline(playerid, vShop_CarPrice[playerid][i], 1);
		PlayerTextDrawBackgroundColor(playerid, vShop_CarPrice[playerid][i], 113);
		PlayerTextDrawFont(playerid, vShop_CarPrice[playerid][i], 3);
		PlayerTextDrawSetProportional(playerid, vShop_CarPrice[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, vShop_CarPrice[playerid][i], 0);

		PlayerTextDrawLetterSize(playerid, vShop_ModelBase[playerid][i], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, vShop_ModelBase[playerid][i], 134.000000, 243.000000);
		PlayerTextDrawAlignment(playerid, vShop_ModelBase[playerid][i], 1);
		PlayerTextDrawColor(playerid, vShop_ModelBase[playerid][i], 4473343);
		PlayerTextDrawSetShadow(playerid, vShop_ModelBase[playerid][i], 0);
		PlayerTextDrawSetOutline(playerid, vShop_ModelBase[playerid][i], 0);
		PlayerTextDrawBackgroundColor(playerid, vShop_ModelBase[playerid][i], 255);
		PlayerTextDrawFont(playerid, vShop_ModelBase[playerid][i], 4);
		PlayerTextDrawSetProportional(playerid, vShop_ModelBase[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, vShop_ModelBase[playerid][i], 0);
		PlayerTextDrawSetSelectable(playerid, vShop_ModelBase[playerid][i], true);
	}
	return 1;
}


stock ATM_Create_Global()
{
	ATM_Background = TextDrawCreate(139.904846, 97.840026, "box");
	TextDrawLetterSize(ATM_Background, 0.000000, 27.600011);
	TextDrawTextSize(ATM_Background, 488.000000, 0.000000);
	TextDrawAlignment(ATM_Background, 1);
	TextDrawColor(ATM_Background, -1);
	TextDrawUseBox(ATM_Background, 1);
	TextDrawBoxColor(ATM_Background, 101058303);
	TextDrawSetShadow(ATM_Background, 0);
	TextDrawSetOutline(ATM_Background, 0);
	TextDrawBackgroundColor(ATM_Background, 255);
	TextDrawFont(ATM_Background, 1);
	TextDrawSetProportional(ATM_Background, 1);
	TextDrawSetShadow(ATM_Background, 0);

	ATM_Screen = TextDrawCreate(163.904724, 111.066658, "box");
	TextDrawLetterSize(ATM_Screen, 0.000000, 24.590471);
	TextDrawTextSize(ATM_Screen, 467.000000, 0.000000);
	TextDrawAlignment(ATM_Screen, 1);
	TextDrawColor(ATM_Screen, -1);
	TextDrawUseBox(ATM_Screen, 1);
	TextDrawBoxColor(ATM_Screen, 1685848063);
	TextDrawSetShadow(ATM_Screen, 0);
	TextDrawSetOutline(ATM_Screen, 0);
	TextDrawBackgroundColor(ATM_Screen, 255);
	TextDrawFont(ATM_Screen, 1);
	TextDrawSetProportional(ATM_Screen, 1);
	TextDrawSetShadow(ATM_Screen, 0);

	ATM_Button[0] = TextDrawCreate(143.476242, 164.813354, "LD_OTB2:butnA");
	ATM_Button[1] = TextDrawCreate(143.476242, 194.253326, "LD_OTB2:butnA");
	ATM_Button[2] = TextDrawCreate(143.476242, 223.266647, "LD_OTB2:butnA");
	ATM_Button[3] = TextDrawCreate(143.476257, 253.559997, "LD_OTB2:butnA");
	ATM_Button[4] = TextDrawCreate(473.000000, 253.559997, "LD_OTB2:butnA");
	ATM_Button[5] = TextDrawCreate(473.000000, 164.000000, "LD_OTB2:butnA");
	ATM_Button[6] = TextDrawCreate(473.000000, 223.266647, "LD_OTB2:butnA");
	ATM_Button[7] = TextDrawCreate(473.000000, 194.253326, "LD_OTB2:butnA");
	for(new i = 0; i < 8; i++)
	{
		TextDrawLetterSize(ATM_Button[i], 0.000000, 0.000000);
		TextDrawTextSize(ATM_Button[i], 14.000000, 15.000000);
		TextDrawAlignment(ATM_Button[i], 1);
		TextDrawColor(ATM_Button[i], 842150655);
		TextDrawSetShadow(ATM_Button[i], 0);
		TextDrawSetOutline(ATM_Button[i], 0);
		TextDrawBackgroundColor(ATM_Button[i], 255);
		TextDrawFont(ATM_Button[i], 4);
		TextDrawSetProportional(ATM_Button[i], 0);
		TextDrawSetShadow(ATM_Button[i], 0);
	}

	ATM_Camera[0] = TextDrawCreate(161.761871, 99.106689, "LD_BEAT:chit");
	TextDrawLetterSize(ATM_Camera[0], 0.000000, 0.000000);
	TextDrawTextSize(ATM_Camera[0], 8.000000, 8.000000);
	TextDrawAlignment(ATM_Camera[0], 1);
	TextDrawColor(ATM_Camera[0], -120);
	TextDrawSetShadow(ATM_Camera[0], 0);
	TextDrawSetOutline(ATM_Camera[0], 0);
	TextDrawBackgroundColor(ATM_Camera[0], 255);
	TextDrawFont(ATM_Camera[0], 4);
	TextDrawSetProportional(ATM_Camera[0], 0);
	TextDrawSetShadow(ATM_Camera[0], 0);

	ATM_Camera[1] = TextDrawCreate(169.000000, 99.533355, "LD_BEAT:chit");
	TextDrawLetterSize(ATM_Camera[1], 0.000000, 0.000000);
	TextDrawTextSize(ATM_Camera[1], 4.000000, 4.000000);
	TextDrawAlignment(ATM_Camera[1], 1);
	TextDrawColor(ATM_Camera[1], -16776961);
	TextDrawSetShadow(ATM_Camera[1], 0);
	TextDrawSetOutline(ATM_Camera[1], 0);
	TextDrawBackgroundColor(ATM_Camera[1], 255);
	TextDrawFont(ATM_Camera[1], 4);
	TextDrawSetProportional(ATM_Camera[1], 0);
	TextDrawSetShadow(ATM_Camera[1], 0);

	ATM_Name = TextDrawCreate(176.095260, 120.026733, "Los_Santos_bankas");
	TextDrawLetterSize(ATM_Name, 0.400000, 1.600000);
	TextDrawAlignment(ATM_Name, 1);
	TextDrawColor(ATM_Name, 323709439);
	TextDrawSetShadow(ATM_Name, 0);
	TextDrawSetOutline(ATM_Name, 2);
	TextDrawBackgroundColor(ATM_Name, 9);
	TextDrawFont(ATM_Name, 0);
	TextDrawSetProportional(ATM_Name, 1);
	TextDrawSetShadow(ATM_Name, 0);

	ATM_Line = TextDrawCreate(178.380950, 140.506713, "box");
	TextDrawLetterSize(ATM_Line, 0.000000, -0.323809);
	TextDrawTextSize(ATM_Line, 391.000000, 0.000000);
	TextDrawAlignment(ATM_Line, 1);
	TextDrawColor(ATM_Line, -256);
	TextDrawUseBox(ATM_Line, 1);
	TextDrawBoxColor(ATM_Line, -926351361);
	TextDrawSetShadow(ATM_Line, 0);
	TextDrawSetOutline(ATM_Line, 0);
	TextDrawBackgroundColor(ATM_Line, 255);
	TextDrawFont(ATM_Line, 1);
	TextDrawSetProportional(ATM_Line, 0);
	TextDrawSetShadow(ATM_Line, 0);

	ATM_CurrentAction = TextDrawCreate(176.857147, 141.786666, "PAGRINDINIS");
	TextDrawLetterSize(ATM_CurrentAction, 0.191619, 0.870400);
	TextDrawAlignment(ATM_CurrentAction, 1);
	TextDrawColor(ATM_CurrentAction, -926351361);
	TextDrawSetShadow(ATM_CurrentAction, 0);
	TextDrawSetOutline(ATM_CurrentAction, 8);
	TextDrawBackgroundColor(ATM_CurrentAction, 0);
	TextDrawFont(ATM_CurrentAction, 1);
	TextDrawSetProportional(ATM_CurrentAction, 1);
	TextDrawSetShadow(ATM_CurrentAction, 0);

	ATM_Action[0] = TextDrawCreate(170.142852, 160.546661, "LD_SPAC:white");
	TextDrawColor(ATM_Action[0], 336877311);
	ATM_Action[1] = TextDrawCreate(170.142852, 190.839965, "LD_SPAC:white");
	TextDrawColor(ATM_Action[1], 336877311);
	ATM_Action[2] = TextDrawCreate(170.142852, 219.853271, "LD_SPAC:white");
	TextDrawColor(ATM_Action[2], 336877311);
	ATM_Action[3] = TextDrawCreate(340.428558, 160.119934, "LD_SPAC:white");
	TextDrawColor(ATM_Action[3], 1444156671);

	for(new i = 0; i < 4; i++)
	{
		TextDrawLetterSize(ATM_Action[i], 0.000000, 0.000000);	
		TextDrawTextSize(ATM_Action[i], 121.000000, 18.000000);
		TextDrawAlignment(ATM_Action[i], 1);
		TextDrawSetShadow(ATM_Action[i], 0);
		TextDrawSetOutline(ATM_Action[i], 0);
		TextDrawBackgroundColor(ATM_Action[i], 255);
		TextDrawFont(ATM_Action[i], 4);
		TextDrawSetProportional(ATM_Action[i], 0);
		TextDrawSetShadow(ATM_Action[i], 0);
		TextDrawSetSelectable(ATM_Action[i], true);
	}

	ATM_ActionName[0] = TextDrawCreate(193.238098, 163.546691, "saskaitos_likutis");
	TextDrawAlignment(ATM_ActionName[0], 1);

	ATM_ActionName[1] = TextDrawCreate(193.238098, 193.840011, "PINIGU_NUEMIMAS");
	TextDrawAlignment(ATM_ActionName[1], 1);

	ATM_ActionName[2] = TextDrawCreate(193.238098, 222.853317, "PINIGU_INESIMAS");
	TextDrawAlignment(ATM_ActionName[2], 1);

	ATM_ActionName[3] = TextDrawCreate(439.714263, 163.546676, "BAIGTI_SESIJA");
	TextDrawAlignment(ATM_ActionName[3], 3);

	for(new i = 0; i < 4; i++)
	{
		TextDrawLetterSize(ATM_ActionName[i], 0.173714, 1.139200);
		TextDrawColor(ATM_ActionName[i], -1);
		TextDrawSetShadow(ATM_ActionName[i], 1);
		TextDrawSetOutline(ATM_ActionName[i], 0);
		TextDrawBackgroundColor(ATM_ActionName[i], 99);
		TextDrawFont(ATM_ActionName[i], 2);
		TextDrawSetProportional(ATM_ActionName[i], 1);
		TextDrawSetShadow(ATM_ActionName[i], 1);
	}

	ATM_Effect1[0] = TextDrawCreate(171.523818, 162.266693, "box");
	TextDrawLetterSize(ATM_Effect1[0], 0.000000, 1.619045);
	TextDrawTextSize(ATM_Effect1[0], 185.000000, 0.000000);
	TextDrawAlignment(ATM_Effect1[0], 1);
	TextDrawColor(ATM_Effect1[0], -1);
	TextDrawUseBox(ATM_Effect1[0], 1);
	TextDrawBoxColor(ATM_Effect1[0], -191);
	TextDrawSetShadow(ATM_Effect1[0], 0);
	TextDrawSetOutline(ATM_Effect1[0], 0);
	TextDrawBackgroundColor(ATM_Effect1[0], 255);
	TextDrawFont(ATM_Effect1[0], 1);
	TextDrawSetProportional(ATM_Effect1[0], 1);
	TextDrawSetShadow(ATM_Effect1[0], 0);

	ATM_Effect2[0] = TextDrawCreate(176.476226, 162.693359, "<");
	TextDrawLetterSize(ATM_Effect2[0], 0.181333, 1.450666);
	TextDrawAlignment(ATM_Effect2[0], 1);
	TextDrawColor(ATM_Effect2[0], -149);
	TextDrawSetShadow(ATM_Effect2[0], 0);
	TextDrawSetOutline(ATM_Effect2[0], 1);
	TextDrawBackgroundColor(ATM_Effect2[0], 50);
	TextDrawFont(ATM_Effect2[0], 1);
	TextDrawSetProportional(ATM_Effect2[0], 1);
	TextDrawSetShadow(ATM_Effect2[0], 0);

	ATM_Effect1[1] = TextDrawCreate(171.523818, 192.559997, "box");
	TextDrawLetterSize(ATM_Effect1[1], 0.000000, 1.619045);
	TextDrawTextSize(ATM_Effect1[1], 185.000000, 0.000000);
	TextDrawAlignment(ATM_Effect1[1], 1);
	TextDrawColor(ATM_Effect1[1], -1);
	TextDrawUseBox(ATM_Effect1[1], 1);
	TextDrawBoxColor(ATM_Effect1[1], -191);
	TextDrawSetShadow(ATM_Effect1[1], 0);
	TextDrawSetOutline(ATM_Effect1[1], 0);
	TextDrawBackgroundColor(ATM_Effect1[1], 255);
	TextDrawFont(ATM_Effect1[1], 1);
	TextDrawSetProportional(ATM_Effect1[1], 1);
	TextDrawSetShadow(ATM_Effect1[1], 0);

	ATM_Effect2[1] = TextDrawCreate(176.095275, 192.986663, "<");
	TextDrawLetterSize(ATM_Effect2[1], 0.181333, 1.450666);
	TextDrawAlignment(ATM_Effect2[1], 1);
	TextDrawColor(ATM_Effect2[1], -149);
	TextDrawSetShadow(ATM_Effect2[1], 0);
	TextDrawSetOutline(ATM_Effect2[1], 1);
	TextDrawBackgroundColor(ATM_Effect2[1], 50);
	TextDrawFont(ATM_Effect2[1], 1);
	TextDrawSetProportional(ATM_Effect2[1], 1);
	TextDrawSetShadow(ATM_Effect2[1], 0);

	ATM_Effect1[2] = TextDrawCreate(171.523986, 221.573318, "box");
	TextDrawLetterSize(ATM_Effect1[2], 0.000000, 1.619045);
	TextDrawTextSize(ATM_Effect1[2], 185.000000, 0.000000);
	TextDrawAlignment(ATM_Effect1[2], 1);
	TextDrawColor(ATM_Effect1[2], -1);
	TextDrawUseBox(ATM_Effect1[2], 1);
	TextDrawBoxColor(ATM_Effect1[2], -191);
	TextDrawSetShadow(ATM_Effect1[2], 0);
	TextDrawSetOutline(ATM_Effect1[2], 0);
	TextDrawBackgroundColor(ATM_Effect1[2], 255);
	TextDrawFont(ATM_Effect1[2], 1);
	TextDrawSetProportional(ATM_Effect1[2], 1);
	TextDrawSetShadow(ATM_Effect1[2], 0);

	ATM_Effect2[2] = TextDrawCreate(176.095275, 221.999969, "<");
	TextDrawLetterSize(ATM_Effect2[2], 0.181333, 1.450666);
	TextDrawAlignment(ATM_Effect2[2], 1);
	TextDrawColor(ATM_Effect2[2], -149);
	TextDrawSetShadow(ATM_Effect2[2], 0);
	TextDrawSetOutline(ATM_Effect2[2], 1);
	TextDrawBackgroundColor(ATM_Effect2[2], 50);
	TextDrawFont(ATM_Effect2[2], 1);
	TextDrawSetProportional(ATM_Effect2[2], 1);
	TextDrawSetShadow(ATM_Effect2[2], 0);

	ATM_Effect1[3] = TextDrawCreate(447.333648, 161.839996, "box");
	TextDrawLetterSize(ATM_Effect1[3], 0.000000, 1.619045);
	TextDrawTextSize(ATM_Effect1[3], 460.000000, 0.000000);
	TextDrawAlignment(ATM_Effect1[3], 1);
	TextDrawColor(ATM_Effect1[3], -1);
	TextDrawUseBox(ATM_Effect1[3], 1);
	TextDrawBoxColor(ATM_Effect1[3], -191);
	TextDrawSetShadow(ATM_Effect1[3], 0);
	TextDrawSetOutline(ATM_Effect1[3], 0);
	TextDrawBackgroundColor(ATM_Effect1[3], 255);
	TextDrawFont(ATM_Effect1[3], 1);
	TextDrawSetProportional(ATM_Effect1[3], 1);
	TextDrawSetShadow(ATM_Effect1[3], 0);

	ATM_Effect2[3] = TextDrawCreate(451.523834, 161.840011, ">");
	TextDrawLetterSize(ATM_Effect2[3], 0.181333, 1.450666);
	TextDrawAlignment(ATM_Effect2[3], 1);
	TextDrawColor(ATM_Effect2[3], -149);
	TextDrawSetShadow(ATM_Effect2[3], 0);
	TextDrawSetOutline(ATM_Effect2[3], 1);
	TextDrawBackgroundColor(ATM_Effect2[3], 50);
	TextDrawFont(ATM_Effect2[3], 1);
	TextDrawSetProportional(ATM_Effect2[3], 1);
	TextDrawSetShadow(ATM_Effect2[3], 0);
}


stock BorderHUD_Create_Global()
{
	/*
	 * Funkcija, kuri sukuria textdrawus, paslepiancius HUD'a.
	 */
	BorderHUD_Top = TextDrawCreate(0.000000, 100.913330, "usebox");
	TextDrawLetterSize(BorderHUD_Top, 0.000000, -20.362591);
	TextDrawTextSize(BorderHUD_Top, 640.0, 0.000000);
	TextDrawAlignment(BorderHUD_Top, 1);
	TextDrawColor(BorderHUD_Top, 0);
	TextDrawUseBox(BorderHUD_Top, true);
	TextDrawBoxColor(BorderHUD_Top, 255);
	TextDrawSetShadow(BorderHUD_Top, 0);
	TextDrawSetOutline(BorderHUD_Top, 0);
	TextDrawFont(BorderHUD_Top, 0);

	BorderHUD_Bottom = TextDrawCreate(641.619079, 339.419982, "usebox");
	TextDrawLetterSize(BorderHUD_Bottom, 0.000000, 11.867039);
	TextDrawTextSize(BorderHUD_Bottom, -2.000000, 0.000000);
	TextDrawAlignment(BorderHUD_Bottom, 1);
	TextDrawColor(BorderHUD_Bottom, 0);
	TextDrawUseBox(BorderHUD_Bottom, true);
	TextDrawBoxColor(BorderHUD_Bottom, 255);
	TextDrawSetShadow(BorderHUD_Bottom, 0);
	TextDrawSetOutline(BorderHUD_Bottom, 0);
	TextDrawFont(BorderHUD_Bottom, 0);
}


stock WarningTD_Create_Player(playerid)
{
	/*
	 * Funkcija, kuri sukuria po HEALTH BARU textdrawus.
	 */
	tdWarning_Info[playerid] = CreatePlayerTextDraw(playerid, 608.476501, 110.213371, "PAKANKAMAI_PINIGU");
	PlayerTextDrawLetterSize(playerid, tdWarning_Info[playerid], 0.265904, 1.395199);
	PlayerTextDrawAlignment(playerid, tdWarning_Info[playerid], 3);
	PlayerTextDrawColor(playerid, tdWarning_Info[playerid], -1);
	PlayerTextDrawSetShadow(playerid, tdWarning_Info[playerid], 0);
	PlayerTextDrawSetOutline(playerid, tdWarning_Info[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, tdWarning_Info[playerid], 128);
	PlayerTextDrawFont(playerid, tdWarning_Info[playerid], 1);
	PlayerTextDrawSetProportional(playerid, tdWarning_Info[playerid], 1);
	PlayerTextDrawSetShadow(playerid, tdWarning_Info[playerid], 0);

	tdWarning_Name[playerid] = CreatePlayerTextDraw(playerid, 607.333496, 97.840019, "NETURITE");
	PlayerTextDrawLetterSize(playerid, tdWarning_Name[playerid], 0.316952, 1.617066);
	PlayerTextDrawAlignment(playerid, tdWarning_Name[playerid], 3);
	PlayerTextDrawColor(playerid, tdWarning_Name[playerid], -318766849);
	PlayerTextDrawSetShadow(playerid, tdWarning_Name[playerid], 0);
	PlayerTextDrawSetOutline(playerid, tdWarning_Name[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, tdWarning_Name[playerid], 147);
	PlayerTextDrawFont(playerid, tdWarning_Name[playerid], 1);
	PlayerTextDrawSetProportional(playerid, tdWarning_Name[playerid], 1);
	PlayerTextDrawSetShadow(playerid, tdWarning_Name[playerid], 0);
}

stock SpamBarTD_Create_Global()
{
	SpamBarTD_Base = TextDrawCreate(174.714355, 260.386627, "LD_SPAC:white");
	TextDrawLetterSize(SpamBarTD_Base, 0.000000, 0.000000);
	TextDrawTextSize(SpamBarTD_Base, 303.000000, 18.000000);
	TextDrawAlignment(SpamBarTD_Base, 1);
	TextDrawColor(SpamBarTD_Base, 0x151515ff);
	TextDrawSetShadow(SpamBarTD_Base, 0);
	TextDrawSetOutline(SpamBarTD_Base, 0);
	TextDrawBackgroundColor(SpamBarTD_Base, 255);
	TextDrawFont(SpamBarTD_Base, 4);
	TextDrawSetProportional(SpamBarTD_Base, 0);
	TextDrawSetShadow(SpamBarTD_Base, 0);

	SpamBarTD_LoadBase = TextDrawCreate(176.238113, 262.519989, "LD_SPAC:white");
	TextDrawLetterSize(SpamBarTD_LoadBase, 0.000000, 0.000000);
	TextDrawTextSize(SpamBarTD_LoadBase, 300.000000, 14.000000);
	TextDrawAlignment(SpamBarTD_LoadBase, 1);
	TextDrawColor(SpamBarTD_LoadBase, 0x7F7019ff);
	TextDrawSetShadow(SpamBarTD_LoadBase, 0);
	TextDrawSetOutline(SpamBarTD_LoadBase, 0);
	TextDrawBackgroundColor(SpamBarTD_LoadBase, 255);
	TextDrawFont(SpamBarTD_LoadBase, 4);
	TextDrawSetProportional(SpamBarTD_LoadBase, 0);
	TextDrawSetShadow(SpamBarTD_LoadBase, 0);
	return 1;
}

stock SpamBarTD_Create_Player(playerid)
{
	SpamBarTD_Load[playerid] = CreatePlayerTextDraw(playerid, 176.238113, 262.519989, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, SpamBarTD_Load[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, SpamBarTD_Load[playerid], 0.000000, 14.000000);
	PlayerTextDrawAlignment(playerid, SpamBarTD_Load[playerid], 1);
	PlayerTextDrawColor(playerid, SpamBarTD_Load[playerid], 0xE0C31Bff);
	PlayerTextDrawSetShadow(playerid, SpamBarTD_Load[playerid], 0);
	PlayerTextDrawSetOutline(playerid, SpamBarTD_Load[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, SpamBarTD_Load[playerid], 255);
	PlayerTextDrawFont(playerid, SpamBarTD_Load[playerid], 4);
	PlayerTextDrawSetProportional(playerid, SpamBarTD_Load[playerid], 0);
	PlayerTextDrawSetShadow(playerid, SpamBarTD_Load[playerid], 0);

	SpamBarTD_Value[playerid] = CreatePlayerTextDraw(playerid, 180.285797, 265.519958, "0%");
	PlayerTextDrawLetterSize(playerid, SpamBarTD_Value[playerid], 0.190095, 0.832000);
	PlayerTextDrawAlignment(playerid, SpamBarTD_Value[playerid], 1);
	PlayerTextDrawColor(playerid, SpamBarTD_Value[playerid], -1);
	PlayerTextDrawSetShadow(playerid, SpamBarTD_Value[playerid], 0);
	PlayerTextDrawSetOutline(playerid, SpamBarTD_Value[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, SpamBarTD_Value[playerid], 95);
	PlayerTextDrawFont(playerid, SpamBarTD_Value[playerid], 1);
	PlayerTextDrawSetProportional(playerid, SpamBarTD_Value[playerid], 1);
	PlayerTextDrawSetShadow(playerid, SpamBarTD_Value[playerid], 0);
	return 1;
}

stock PhoneTD_Create_Global()
{
	Phone_TopBorder = TextDrawCreate(521.762084, 430.626495, "LD_CHAT:dpad_64");
	TextDrawLetterSize(Phone_TopBorder, 0.000000, 0.000000);
	TextDrawTextSize(Phone_TopBorder, 83.000000, -92.000000);
	TextDrawAlignment(Phone_TopBorder, 1);
	TextDrawColor(Phone_TopBorder, -1);
	TextDrawSetShadow(Phone_TopBorder, 0);
	TextDrawSetOutline(Phone_TopBorder, 0);
	TextDrawBackgroundColor(Phone_TopBorder, 255);
	TextDrawFont(Phone_TopBorder, 4);
	TextDrawSetProportional(Phone_TopBorder, 0);
	TextDrawSetShadow(Phone_TopBorder, 0);

	Phone_BottomBorder = TextDrawCreate(521.761718, 293.239959, "LD_CHAT:dpad_64");
	TextDrawLetterSize(Phone_BottomBorder, 0.000000, 0.000000);
	TextDrawTextSize(Phone_BottomBorder, 83.000000, 86.000000);
	TextDrawAlignment(Phone_BottomBorder, 1);
	TextDrawColor(Phone_BottomBorder, -1);
	TextDrawSetShadow(Phone_BottomBorder, 0);
	TextDrawSetOutline(Phone_BottomBorder, 0);
	TextDrawBackgroundColor(Phone_BottomBorder, 255);
	TextDrawFont(Phone_BottomBorder, 4);
	TextDrawSetProportional(Phone_BottomBorder, 0);
	TextDrawSetShadow(Phone_BottomBorder, 0);

	Phone_BackgroundFill = TextDrawCreate(524.047363, 297.506622, "LD_SPAC:white");
	TextDrawLetterSize(Phone_BackgroundFill, 0.000000, 0.000000);
	TextDrawTextSize(Phone_BackgroundFill, 76.000000, 130.000000);
	TextDrawAlignment(Phone_BackgroundFill, 1);
	TextDrawColor(Phone_BackgroundFill, 255);
	TextDrawSetShadow(Phone_BackgroundFill, 0);
	TextDrawSetOutline(Phone_BackgroundFill, 0);
	TextDrawBackgroundColor(Phone_BackgroundFill, 255);
	TextDrawFont(Phone_BackgroundFill, 4);
	TextDrawSetProportional(Phone_BackgroundFill, 0);
	TextDrawSetShadow(Phone_BackgroundFill, 0);

	Phone_MainBackground = TextDrawCreate(524.047241, 302.200012, "LD_DUAL:backgnd");
	TextDrawLetterSize(Phone_MainBackground, 0.000000, 0.000000);
	TextDrawTextSize(Phone_MainBackground, 79.000000, 119.000000);
	TextDrawAlignment(Phone_MainBackground, 1);
	TextDrawColor(Phone_MainBackground, 1684301055);
	TextDrawSetShadow(Phone_MainBackground, 0);
	TextDrawSetOutline(Phone_MainBackground, 0);
	TextDrawBackgroundColor(Phone_MainBackground, 255);
	TextDrawFont(Phone_MainBackground, 4);
	TextDrawSetProportional(Phone_MainBackground, 0);
	TextDrawSetShadow(Phone_MainBackground, 0);

	Phone_TopBackground = TextDrawCreate(523.666931, 297.933288, "LD_DRV:tvbase");
	TextDrawLetterSize(Phone_TopBackground, 0.000000, 0.000000);
	TextDrawTextSize(Phone_TopBackground, 81.000000, 7.000000);
	TextDrawAlignment(Phone_TopBackground, 1);
	TextDrawColor(Phone_TopBackground, 0);
	TextDrawSetShadow(Phone_TopBackground, 0);
	TextDrawSetOutline(Phone_TopBackground, 0);
	TextDrawBackgroundColor(Phone_TopBackground, 255);
	TextDrawFont(Phone_TopBackground, 4);
	TextDrawSetProportional(Phone_TopBackground, 0);
	TextDrawSetShadow(Phone_TopBackground, 0);

	Phone_BottomBackground = TextDrawCreate(524.047851, 411.426513, "LD_DRV:tvbase");
	TextDrawLetterSize(Phone_BottomBackground, 0.000000, 0.000000);
	TextDrawTextSize(Phone_BottomBackground, 79.000000, 10.000000);
	TextDrawAlignment(Phone_BottomBackground, 1);
	TextDrawColor(Phone_BottomBackground, -589505281);
	TextDrawSetShadow(Phone_BottomBackground, 0);
	TextDrawSetOutline(Phone_BottomBackground, 0);
	TextDrawBackgroundColor(Phone_BottomBackground, 255);
	TextDrawFont(Phone_BottomBackground, 4);
	TextDrawSetProportional(Phone_BottomBackground, 0);
	TextDrawSetShadow(Phone_BottomBackground, 0);

	Phone_Speaker = TextDrawCreate(545.619445, 297.093261, ".");
	TextDrawLetterSize(Phone_Speaker, 3.089524, 0.328532);
	TextDrawAlignment(Phone_Speaker, 1);
	TextDrawColor(Phone_Speaker, -168);
	TextDrawSetShadow(Phone_Speaker, 0);
	TextDrawSetOutline(Phone_Speaker, 0);
	TextDrawBackgroundColor(Phone_Speaker, 255);
	TextDrawFont(Phone_Speaker, 1);
	TextDrawSetProportional(Phone_Speaker, 1);
	TextDrawSetShadow(Phone_Speaker, 0);

	Phone_TopBarBackground = TextDrawCreate(523.666870, 304.759948, "LD_SPAC:white");
	TextDrawLetterSize(Phone_TopBarBackground, 0.000000, 0.000000);
	TextDrawTextSize(Phone_TopBarBackground, 79.000000, 7.000000);
	TextDrawAlignment(Phone_TopBarBackground, 1);
	TextDrawColor(Phone_TopBarBackground, 168430335);
	TextDrawSetShadow(Phone_TopBarBackground, 0);
	TextDrawSetOutline(Phone_TopBarBackground, 0);
	TextDrawBackgroundColor(Phone_TopBarBackground, 255);
	TextDrawFont(Phone_TopBarBackground, 4);
	TextDrawSetProportional(Phone_TopBarBackground, 0);
	TextDrawSetShadow(Phone_TopBarBackground, 0);

	Phone_Signal[0] = TextDrawCreate(539.904968, 307.759948, "I");
	TextDrawLetterSize(Phone_Signal[0], 0.155428, 0.290131);
	TextDrawAlignment(Phone_Signal[0], 1);
	TextDrawColor(Phone_Signal[0], -103);
	TextDrawSetShadow(Phone_Signal[0], 0);
	TextDrawSetOutline(Phone_Signal[0], 0);
	TextDrawBackgroundColor(Phone_Signal[0], 255);
	TextDrawFont(Phone_Signal[0], 1);
	TextDrawSetProportional(Phone_Signal[0], 1);
	TextDrawSetShadow(Phone_Signal[0], 0);

	Phone_Signal[1] = TextDrawCreate(541.428710, 306.479949, "I");
	TextDrawLetterSize(Phone_Signal[1], 0.157333, 0.473598);
	TextDrawAlignment(Phone_Signal[1], 1);
	TextDrawColor(Phone_Signal[1], -103);
	TextDrawSetShadow(Phone_Signal[1], 0);
	TextDrawSetOutline(Phone_Signal[1], 0);
	TextDrawBackgroundColor(Phone_Signal[1], 255);
	TextDrawFont(Phone_Signal[1], 1);
	TextDrawSetProportional(Phone_Signal[1], 1);
	TextDrawSetShadow(Phone_Signal[1], 0);

	Phone_Signal[2] = TextDrawCreate(542.952697, 305.199951, "I");
	TextDrawLetterSize(Phone_Signal[2], 0.160380, 0.627198);
	TextDrawAlignment(Phone_Signal[2], 1);
	TextDrawColor(Phone_Signal[2], -103);
	TextDrawSetShadow(Phone_Signal[2], 0);
	TextDrawSetOutline(Phone_Signal[2], 0);
	TextDrawBackgroundColor(Phone_Signal[2], 255);
	TextDrawFont(Phone_Signal[2], 1);
	TextDrawSetProportional(Phone_Signal[2], 1);
	TextDrawSetShadow(Phone_Signal[2], 0);

	Phone_BottomDividers = TextDrawCreate(549.047729, 396.079956, ".________________.");
	TextDrawLetterSize(Phone_BottomDividers, 0.103238, 2.978128);
	TextDrawAlignment(Phone_BottomDividers, 1);
	TextDrawColor(Phone_BottomDividers, -1);
	TextDrawSetShadow(Phone_BottomDividers, 0);
	TextDrawSetOutline(Phone_BottomDividers, 0);
	TextDrawBackgroundColor(Phone_BottomDividers, 255);
	TextDrawFont(Phone_BottomDividers, 1);
	TextDrawSetProportional(Phone_BottomDividers, 1);
	TextDrawSetShadow(Phone_BottomDividers, 0);

	Phone_BottomMenu[0] = TextDrawCreate(525.000000, 412.000000, "LD_SPAC:white");
	TextDrawLetterSize(Phone_BottomMenu[0], 0.000000, 0.000000);
	TextDrawTextSize(Phone_BottomMenu[0], 25.000000, 9.000000);
	TextDrawAlignment(Phone_BottomMenu[0], 1);
	TextDrawColor(Phone_BottomMenu[0], 0x323332FF);
	TextDrawSetShadow(Phone_BottomMenu[0], 0);
	TextDrawSetOutline(Phone_BottomMenu[0], 0);
	TextDrawFont(Phone_BottomMenu[0], 4);
	TextDrawSetProportional(Phone_BottomMenu[0], 0);
	TextDrawSetShadow(Phone_BottomMenu[0], 0);
	TextDrawSetSelectable(Phone_BottomMenu[0], true);

	Phone_BottomMenu[1] = TextDrawCreate(549.952026, 411.853302, "LD_SPAC:white");
	TextDrawLetterSize(Phone_BottomMenu[1], 0.000000, 0.000000);
	TextDrawTextSize(Phone_BottomMenu[1], 26.000000, 9.000000);
	TextDrawAlignment(Phone_BottomMenu[1], 1);
	TextDrawColor(Phone_BottomMenu[1], 0x323332FF);
	TextDrawSetShadow(Phone_BottomMenu[1], 0);
	TextDrawSetOutline(Phone_BottomMenu[1], 0);
	TextDrawFont(Phone_BottomMenu[1], 4);
	TextDrawSetProportional(Phone_BottomMenu[1], 0);
	TextDrawSetShadow(Phone_BottomMenu[1], 0);
	TextDrawSetSelectable(Phone_BottomMenu[1], true);

	Phone_BottomMenu[2] = TextDrawCreate(576.237426, 411.853302, "LD_SPAC:white");
	TextDrawLetterSize(Phone_BottomMenu[2], 0.000000, 0.000000);
	TextDrawTextSize(Phone_BottomMenu[2], 28.000000, 9.000000);
	TextDrawAlignment(Phone_BottomMenu[2], 1);
	TextDrawColor(Phone_BottomMenu[2], 0x323332FF);
	TextDrawSetShadow(Phone_BottomMenu[2], 0);
	TextDrawSetOutline(Phone_BottomMenu[2], 0);
	TextDrawFont(Phone_BottomMenu[2], 4);
	TextDrawSetProportional(Phone_BottomMenu[2], 0);
	TextDrawSetShadow(Phone_BottomMenu[2], 0);
	TextDrawSetSelectable(Phone_BottomMenu[2], true);

	Phone_Accept1 = TextDrawCreate(534.190307, 417.839935, "box");
	TextDrawLetterSize(Phone_Accept1, 0.000000, -0.171428);
	TextDrawTextSize(Phone_Accept1, 540.000000, 0.000000);
	TextDrawAlignment(Phone_Accept1, 1);
	TextDrawColor(Phone_Accept1, -256);
	TextDrawUseBox(Phone_Accept1, 1);
	TextDrawBoxColor(Phone_Accept1, 5898495);
	TextDrawSetShadow(Phone_Accept1, 0);
	TextDrawSetOutline(Phone_Accept1, 0);
	TextDrawBackgroundColor(Phone_Accept1, 255);
	TextDrawFont(Phone_Accept1, 1);
	TextDrawSetProportional(Phone_Accept1, 1);
	TextDrawSetShadow(Phone_Accept1, 0);

	Phone_Accept2 = TextDrawCreate(531.904907, 403.333221, ".__.");
	TextDrawLetterSize(Phone_Accept2, 0.198476, 1.813333);
	TextDrawAlignment(Phone_Accept2, 1);
	TextDrawColor(Phone_Accept2, 5898495);
	TextDrawSetShadow(Phone_Accept2, 0);
	TextDrawSetOutline(Phone_Accept2, 0);
	TextDrawBackgroundColor(Phone_Accept2, 255);
	TextDrawFont(Phone_Accept2, 1);
	TextDrawSetProportional(Phone_Accept2, 1);
	TextDrawSetShadow(Phone_Accept2, 0);

	Phone_Decline1 = TextDrawCreate(585.999877, 415.706604, "box");
	TextDrawLetterSize(Phone_Decline1, 0.000000, -0.209524);
	TextDrawTextSize(Phone_Decline1, 592.000000, 0.000000);
	TextDrawAlignment(Phone_Decline1, 1);
	TextDrawColor(Phone_Decline1, -256);
	TextDrawUseBox(Phone_Decline1, 1);
	TextDrawBoxColor(Phone_Decline1, 1811939583);
	TextDrawSetShadow(Phone_Decline1, 0);
	TextDrawSetOutline(Phone_Decline1, 0);
	TextDrawBackgroundColor(Phone_Decline1, 255);
	TextDrawFont(Phone_Decline1, 1);
	TextDrawSetProportional(Phone_Decline1, 1);
	TextDrawSetShadow(Phone_Decline1, 0);

	Phone_Decline2 = TextDrawCreate(583.714538, 404.186553, ".__.");
	TextDrawLetterSize(Phone_Decline2, 0.198476, 1.813333);
	TextDrawAlignment(Phone_Decline2, 1);
	TextDrawColor(Phone_Decline2, 1811939583);
	TextDrawSetShadow(Phone_Decline2, 0);
	TextDrawSetOutline(Phone_Decline2, 0);
	TextDrawBackgroundColor(Phone_Decline2, 255);
	TextDrawFont(Phone_Decline2, 1);
	TextDrawSetProportional(Phone_Decline2, 1);
	TextDrawSetShadow(Phone_Decline2, 0);

	Phone_Button = TextDrawCreate(556.428771, 415.266632, "LD_DUAL:light");
	TextDrawLetterSize(Phone_Button, 0.000000, 0.000000);
	TextDrawTextSize(Phone_Button, 12.000000, 2.000000);
	TextDrawAlignment(Phone_Button, 1);
	TextDrawColor(Phone_Button, -1);
	TextDrawSetShadow(Phone_Button, 0);
	TextDrawSetOutline(Phone_Button, 0);
	TextDrawBackgroundColor(Phone_Button, 255);
	TextDrawFont(Phone_Button, 4);
	TextDrawSetProportional(Phone_Button, 0);
	TextDrawSetShadow(Phone_Button, 0);

	Phone_Menu[0] = TextDrawCreate(527.857360, 317.559967, "LD_SPAC:white");
	TextDrawLetterSize(Phone_Menu[0], 0.000000, 0.000000);
	TextDrawTextSize(Phone_Menu[0], 41.000000, 28.000000);
	TextDrawAlignment(Phone_Menu[0], 1);
	TextDrawColor(Phone_Menu[0], -3928577);
	TextDrawSetShadow(Phone_Menu[0], 0);
	TextDrawSetOutline(Phone_Menu[0], 0);
	TextDrawBackgroundColor(Phone_Menu[0], 255);
	TextDrawFont(Phone_Menu[0], 4);
	TextDrawSetProportional(Phone_Menu[0], 0);
	TextDrawSetShadow(Phone_Menu[0], 0);
	TextDrawSetSelectable(Phone_Menu[0], true);

	Phone_Menu[1] = TextDrawCreate(570.904663, 317.559967, "LD_SPAC:white");
	TextDrawLetterSize(Phone_Menu[1], 0.000000, 0.000000);
	TextDrawTextSize(Phone_Menu[1], 29.000000, 28.000000);
	TextDrawAlignment(Phone_Menu[1], 1);
	TextDrawColor(Phone_Menu[1], -632083201);
	TextDrawSetShadow(Phone_Menu[1], 0);
	TextDrawSetOutline(Phone_Menu[1], 0);
	TextDrawBackgroundColor(Phone_Menu[1], 255);
	TextDrawFont(Phone_Menu[1], 4);
	TextDrawSetProportional(Phone_Menu[1], 0);
	TextDrawSetShadow(Phone_Menu[1], 0);
	TextDrawSetSelectable(Phone_Menu[1], true);

	Phone_Menu[2] = TextDrawCreate(527.857055, 347.853271, "LD_SPAC:white");
	TextDrawLetterSize(Phone_Menu[2], 0.000000, 0.000000);
	TextDrawTextSize(Phone_Menu[2], 72.000000, 14.000000);
	TextDrawAlignment(Phone_Menu[2], 1);
	TextDrawColor(Phone_Menu[2], -1189267457);
	TextDrawSetShadow(Phone_Menu[2], 0);
	TextDrawSetOutline(Phone_Menu[2], 0);
	TextDrawBackgroundColor(Phone_Menu[2], 255);
	TextDrawFont(Phone_Menu[2], 4);
	TextDrawSetProportional(Phone_Menu[2], 0);
	TextDrawSetShadow(Phone_Menu[2], 0);
	TextDrawSetSelectable(Phone_Menu[2], true);

	Phone_MenuText[0] = TextDrawCreate(531.142578, 320.559936, "_____~n~___DIAL~n~_");
	TextDrawLetterSize(Phone_MenuText[0], 0.172571, 0.814933);
	TextDrawTextSize(Phone_MenuText[0], 566.000000, 0.000000);
	TextDrawAlignment(Phone_MenuText[0], 1);
	TextDrawColor(Phone_MenuText[0], -1);
	TextDrawUseBox(Phone_MenuText[0], 1);
	TextDrawBoxColor(Phone_MenuText[0], 27);
	TextDrawSetShadow(Phone_MenuText[0], 0);
	TextDrawSetOutline(Phone_MenuText[0], 4);
	TextDrawBackgroundColor(Phone_MenuText[0], 943208448);
	TextDrawFont(Phone_MenuText[0], 1);
	TextDrawSetProportional(Phone_MenuText[0], 1);
	TextDrawSetShadow(Phone_MenuText[0], 0);

	Phone_MenuText[1] = TextDrawCreate(573.809204, 320.559936, "_____~n~_SMS~n~_");
	TextDrawLetterSize(Phone_MenuText[1], 0.172571, 0.814933);
	TextDrawTextSize(Phone_MenuText[1], 597.000000, 0.000000);
	TextDrawAlignment(Phone_MenuText[1], 1);
	TextDrawColor(Phone_MenuText[1], -1);
	TextDrawUseBox(Phone_MenuText[1], 1);
	TextDrawBoxColor(Phone_MenuText[1], 27);
	TextDrawSetShadow(Phone_MenuText[1], 0);
	TextDrawSetOutline(Phone_MenuText[1], 267);
	TextDrawBackgroundColor(Phone_MenuText[1], 943208448);
	TextDrawFont(Phone_MenuText[1], 1);
	TextDrawSetProportional(Phone_MenuText[1], 1);
	TextDrawSetShadow(Phone_MenuText[1], 0);

	Phone_MenuText[2] = TextDrawCreate(530.761291, 351.279907, "___CONTACTS");
	TextDrawLetterSize(Phone_MenuText[2], 0.172571, 0.814933);
	TextDrawTextSize(Phone_MenuText[2], 597.000000, 0.000000);
	TextDrawAlignment(Phone_MenuText[2], 1);
	TextDrawColor(Phone_MenuText[2], -1);
	TextDrawUseBox(Phone_MenuText[2], 1);
	TextDrawBoxColor(Phone_MenuText[2], 27);
	TextDrawSetShadow(Phone_MenuText[2], 0);
	TextDrawSetOutline(Phone_MenuText[2], 4);
	TextDrawBackgroundColor(Phone_MenuText[2], 943208448);
	TextDrawFont(Phone_MenuText[2], 1);
	TextDrawSetProportional(Phone_MenuText[2], 1);
	TextDrawSetShadow(Phone_MenuText[2], 0);


	Phone_Menu[3] = TextDrawCreate(527.856933, 364.919921, "LD_SPAC:white");
	TextDrawLetterSize(Phone_Menu[3], 0.000000, 0.000000);
	TextDrawTextSize(Phone_Menu[3], 72.000000, 14.000000);
	TextDrawAlignment(Phone_Menu[3], 1);
	TextDrawColor(Phone_Menu[3], -680918785);
	TextDrawSetShadow(Phone_Menu[3], 0);
	TextDrawSetOutline(Phone_Menu[3], 0);
	TextDrawBackgroundColor(Phone_Menu[3], 255);
	TextDrawFont(Phone_Menu[3], 4);
	TextDrawSetProportional(Phone_Menu[3], 0);
	TextDrawSetShadow(Phone_Menu[3], 0);
	TextDrawSetSelectable(Phone_Menu[3], true);

	Phone_MenuText[3] = TextDrawCreate(530.761413, 368.346557, "___OPTIONS");
	TextDrawLetterSize(Phone_MenuText[3], 0.172571, 0.814933);
	TextDrawTextSize(Phone_MenuText[3], 597.000000, 0.000000);
	TextDrawAlignment(Phone_MenuText[3], 1);
	TextDrawColor(Phone_MenuText[3], -1);
	TextDrawUseBox(Phone_MenuText[3], 1);
	TextDrawBoxColor(Phone_MenuText[3], 27);
	TextDrawSetShadow(Phone_MenuText[3], 0);
	TextDrawSetOutline(Phone_MenuText[3], 4);
	TextDrawBackgroundColor(Phone_MenuText[3], 943208448);
	TextDrawFont(Phone_MenuText[3], 1);
	TextDrawSetProportional(Phone_MenuText[3], 1);
	TextDrawSetShadow(Phone_MenuText[3], 0);


	Phone_DialTopBackground = TextDrawCreate(526.000000, 313.000000, "box");
	TextDrawLetterSize(Phone_DialTopBackground, 0.000000, 3.180951);
	TextDrawTextSize(Phone_DialTopBackground, 601.000000, 0.000000);
	TextDrawAlignment(Phone_DialTopBackground, 1);
	TextDrawColor(Phone_DialTopBackground, -1);
	TextDrawUseBox(Phone_DialTopBackground, 1);
	TextDrawBoxColor(Phone_DialTopBackground, 336860415);
	TextDrawSetShadow(Phone_DialTopBackground, 0);
	TextDrawSetOutline(Phone_DialTopBackground, 0);
	TextDrawBackgroundColor(Phone_DialTopBackground, 255);
	TextDrawFont(Phone_DialTopBackground, 1);
	TextDrawSetProportional(Phone_DialTopBackground, 1);
	TextDrawSetShadow(Phone_DialTopBackground, 0);

	Phone_DialBottomBackground = TextDrawCreate(526.000000, 345.000000, "box");
	TextDrawLetterSize(Phone_DialBottomBackground, 0.000000, 7.219049);
	TextDrawTextSize(Phone_DialBottomBackground, 601.000000, 0.000000);
	TextDrawAlignment(Phone_DialBottomBackground, 1);
	TextDrawColor(Phone_DialBottomBackground, -1);
	TextDrawUseBox(Phone_DialBottomBackground, 1);
	TextDrawBoxColor(Phone_DialBottomBackground, 252645375);
	TextDrawSetShadow(Phone_DialBottomBackground, 0);
	TextDrawSetOutline(Phone_DialBottomBackground, 0);
	TextDrawBackgroundColor(Phone_DialBottomBackground, 255);
	TextDrawFont(Phone_DialBottomBackground, 1);
	TextDrawSetProportional(Phone_DialBottomBackground, 1);
	TextDrawSetShadow(Phone_DialBottomBackground, 0);

	Phone_Numbers[0] = TextDrawCreate(528.000000, 349.000000, "LD_SPAC:white");
	TextDrawLetterSize(Phone_Numbers[0], 0.000000, 0.000000);
	TextDrawTextSize(Phone_Numbers[0], 16.000000, 17.000000);
	TextDrawAlignment(Phone_Numbers[0], 1);
	TextDrawColor(Phone_Numbers[0], 1684301055);
	TextDrawSetShadow(Phone_Numbers[0], 0);
	TextDrawSetOutline(Phone_Numbers[0], 0);
	TextDrawBackgroundColor(Phone_Numbers[0], 255);
	TextDrawFont(Phone_Numbers[0], 4);
	TextDrawSetProportional(Phone_Numbers[0], 0);
	TextDrawSetShadow(Phone_Numbers[0], 0);
	TextDrawSetSelectable(Phone_Numbers[0], true);

	Phone_Numbers[1] = TextDrawCreate(546.000000, 349.000000, "LD_SPAC:white");
	TextDrawLetterSize(Phone_Numbers[1], 0.000000, 0.000000);
	TextDrawTextSize(Phone_Numbers[1], 16.000000, 17.000000);
	TextDrawAlignment(Phone_Numbers[1], 1);
	TextDrawColor(Phone_Numbers[1], 1684301055);
	TextDrawSetShadow(Phone_Numbers[1], 0);
	TextDrawSetOutline(Phone_Numbers[1], 0);
	TextDrawBackgroundColor(Phone_Numbers[1], 255);
	TextDrawFont(Phone_Numbers[1], 4);
	TextDrawSetProportional(Phone_Numbers[1], 0);
	TextDrawSetShadow(Phone_Numbers[1], 0);
	TextDrawSetSelectable(Phone_Numbers[1], true);

	Phone_Numbers[2] = TextDrawCreate(564.000000, 349.000000, "LD_SPAC:white");
	TextDrawLetterSize(Phone_Numbers[2], 0.000000, 0.000000);
	TextDrawTextSize(Phone_Numbers[2], 16.000000, 17.000000);
	TextDrawAlignment(Phone_Numbers[2], 1);
	TextDrawColor(Phone_Numbers[2], 1684301055);
	TextDrawSetShadow(Phone_Numbers[2], 0);
	TextDrawSetOutline(Phone_Numbers[2], 0);
	TextDrawBackgroundColor(Phone_Numbers[2], 255);
	TextDrawFont(Phone_Numbers[2], 4);
	TextDrawSetProportional(Phone_Numbers[2], 0);
	TextDrawSetShadow(Phone_Numbers[2], 0);
	TextDrawSetSelectable(Phone_Numbers[2], true);

	Phone_Numbers[3] = TextDrawCreate(528.000000, 368.000000, "LD_SPAC:white");
	TextDrawLetterSize(Phone_Numbers[3], 0.000000, 0.000000);
	TextDrawTextSize(Phone_Numbers[3], 16.000000, 17.000000);
	TextDrawAlignment(Phone_Numbers[3], 1);
	TextDrawColor(Phone_Numbers[3], 1684301055);
	TextDrawSetShadow(Phone_Numbers[3], 0);
	TextDrawSetOutline(Phone_Numbers[3], 0);
	TextDrawBackgroundColor(Phone_Numbers[3], 255);
	TextDrawFont(Phone_Numbers[3], 4);
	TextDrawSetProportional(Phone_Numbers[3], 0);
	TextDrawSetShadow(Phone_Numbers[3], 0);
	TextDrawSetSelectable(Phone_Numbers[3], true);

	Phone_Numbers[4] = TextDrawCreate(546.000000, 368.000000, "LD_SPAC:white");
	TextDrawLetterSize(Phone_Numbers[4], 0.000000, 0.000000);
	TextDrawTextSize(Phone_Numbers[4], 16.000000, 17.000000);
	TextDrawAlignment(Phone_Numbers[4], 1);
	TextDrawColor(Phone_Numbers[4], 1684301055);
	TextDrawSetShadow(Phone_Numbers[4], 0);
	TextDrawSetOutline(Phone_Numbers[4], 0);
	TextDrawBackgroundColor(Phone_Numbers[4], 255);
	TextDrawFont(Phone_Numbers[4], 4);
	TextDrawSetProportional(Phone_Numbers[4], 0);
	TextDrawSetShadow(Phone_Numbers[4], 0);
	TextDrawSetSelectable(Phone_Numbers[4], true);

	Phone_Numbers[5] = TextDrawCreate(564.000000, 368.000000, "LD_SPAC:white");
	TextDrawLetterSize(Phone_Numbers[5], 0.000000, 0.000000);
	TextDrawTextSize(Phone_Numbers[5], 16.000000, 17.000000);
	TextDrawAlignment(Phone_Numbers[5], 1);
	TextDrawColor(Phone_Numbers[5], 1684301055);
	TextDrawSetShadow(Phone_Numbers[5], 0);
	TextDrawSetOutline(Phone_Numbers[5], 0);
	TextDrawBackgroundColor(Phone_Numbers[5], 255);
	TextDrawFont(Phone_Numbers[5], 4);
	TextDrawSetProportional(Phone_Numbers[5], 0);
	TextDrawSetShadow(Phone_Numbers[5], 0);
	TextDrawSetSelectable(Phone_Numbers[5], true);

	Phone_Numbers[6] = TextDrawCreate(528.000000, 387.000000, "LD_SPAC:white");
	TextDrawLetterSize(Phone_Numbers[6], 0.000000, 0.000000);
	TextDrawTextSize(Phone_Numbers[6], 16.000000, 17.000000);
	TextDrawAlignment(Phone_Numbers[6], 1);
	TextDrawColor(Phone_Numbers[6], 1684301055);
	TextDrawSetShadow(Phone_Numbers[6], 0);
	TextDrawSetOutline(Phone_Numbers[6], 0);
	TextDrawBackgroundColor(Phone_Numbers[6], 255);
	TextDrawFont(Phone_Numbers[6], 4);
	TextDrawSetProportional(Phone_Numbers[6], 0);
	TextDrawSetShadow(Phone_Numbers[6], 0);
	TextDrawSetSelectable(Phone_Numbers[6], true);

	Phone_Numbers[7] = TextDrawCreate(546.000000, 387.000000, "LD_SPAC:white");
	TextDrawLetterSize(Phone_Numbers[7], 0.000000, 0.000000);
	TextDrawTextSize(Phone_Numbers[7], 16.000000, 17.000000);
	TextDrawAlignment(Phone_Numbers[7], 1);
	TextDrawColor(Phone_Numbers[7], 1684301055);
	TextDrawSetShadow(Phone_Numbers[7], 0);
	TextDrawSetOutline(Phone_Numbers[7], 0);
	TextDrawBackgroundColor(Phone_Numbers[7], 255);
	TextDrawFont(Phone_Numbers[7], 4);
	TextDrawSetProportional(Phone_Numbers[7], 0);
	TextDrawSetShadow(Phone_Numbers[7], 0);
	TextDrawSetSelectable(Phone_Numbers[7], true);

	Phone_Numbers[8] = TextDrawCreate(564.000000, 387.000000, "LD_SPAC:white");
	TextDrawLetterSize(Phone_Numbers[8], 0.000000, 0.000000);
	TextDrawTextSize(Phone_Numbers[8], 16.000000, 17.000000);
	TextDrawAlignment(Phone_Numbers[8], 1);
	TextDrawColor(Phone_Numbers[8], 1684301055);
	TextDrawSetShadow(Phone_Numbers[8], 0);
	TextDrawSetOutline(Phone_Numbers[8], 0);
	TextDrawBackgroundColor(Phone_Numbers[8], 255);
	TextDrawFont(Phone_Numbers[8], 4);
	TextDrawSetProportional(Phone_Numbers[8], 0);
	TextDrawSetShadow(Phone_Numbers[8], 0);
	TextDrawSetSelectable(Phone_Numbers[8], true);

	Phone_NumbersRow[0] = TextDrawCreate(536.000000, 352.000000, "1~n~~n~4~n~~n~7");
	TextDrawLetterSize(Phone_NumbersRow[0], 0.305524, 1.066667);
	TextDrawAlignment(Phone_NumbersRow[0], 2);
	TextDrawColor(Phone_NumbersRow[0], -989855745);
	TextDrawSetShadow(Phone_NumbersRow[0], 0);
	TextDrawSetOutline(Phone_NumbersRow[0], 0);
	TextDrawBackgroundColor(Phone_NumbersRow[0], 255);
	TextDrawFont(Phone_NumbersRow[0], 2);
	TextDrawSetProportional(Phone_NumbersRow[0], 1);
	TextDrawSetShadow(Phone_NumbersRow[0], 0);

	Phone_NumbersRow[1] = TextDrawCreate(554.000000, 352.000000, "2~n~~n~5~n~~n~8");
	TextDrawLetterSize(Phone_NumbersRow[1], 0.305524, 1.066667);
	TextDrawAlignment(Phone_NumbersRow[1], 2);
	TextDrawColor(Phone_NumbersRow[1], -989855745);
	TextDrawSetShadow(Phone_NumbersRow[1], 0);
	TextDrawSetOutline(Phone_NumbersRow[1], 0);
	TextDrawBackgroundColor(Phone_NumbersRow[1], 255);
	TextDrawFont(Phone_NumbersRow[1], 2);
	TextDrawSetProportional(Phone_NumbersRow[1], 1);
	TextDrawSetShadow(Phone_NumbersRow[1], 0);

	Phone_NumbersRow[2] = TextDrawCreate(572.000000, 352.000000, "3~n~~n~6~n~~n~9");
	TextDrawLetterSize(Phone_NumbersRow[2], 0.305524, 1.066667);
	TextDrawAlignment(Phone_NumbersRow[2], 2);
	TextDrawColor(Phone_NumbersRow[2], -989855745);
	TextDrawSetShadow(Phone_NumbersRow[2], 0);
	TextDrawSetOutline(Phone_NumbersRow[2], 0);
	TextDrawBackgroundColor(Phone_NumbersRow[2], 255);
	TextDrawFont(Phone_NumbersRow[2], 2);
	TextDrawSetProportional(Phone_NumbersRow[2], 1);
	TextDrawSetShadow(Phone_NumbersRow[2], 0);

	Phone_Numbers[9] = TextDrawCreate(582.000000, 349.000000, "LD_SPAC:white");
	TextDrawLetterSize(Phone_Numbers[9], 0.000000, 0.000000);
	TextDrawTextSize(Phone_Numbers[9], 16.000000, 17.000000);
	TextDrawAlignment(Phone_Numbers[9], 1);
	TextDrawColor(Phone_Numbers[9], 1684301055);
	TextDrawSetShadow(Phone_Numbers[9], 0);
	TextDrawSetOutline(Phone_Numbers[9], 0);
	TextDrawBackgroundColor(Phone_Numbers[9], 255);
	TextDrawFont(Phone_Numbers[9], 4);
	TextDrawSetProportional(Phone_Numbers[9], 0);
	TextDrawSetShadow(Phone_Numbers[9], 0);
	TextDrawSetSelectable(Phone_Numbers[9], true);

	Phone_Numbers[10] = TextDrawCreate(582.000000, 387.000000, "LD_SPAC:white");
	TextDrawLetterSize(Phone_Numbers[10], 0.000000, 0.000000);
	TextDrawTextSize(Phone_Numbers[10], 16.000000, 17.000000);
	TextDrawAlignment(Phone_Numbers[10], 1);
	TextDrawColor(Phone_Numbers[10], 1684301055);
	TextDrawSetShadow(Phone_Numbers[10], 0);
	TextDrawSetOutline(Phone_Numbers[10], 0);
	TextDrawBackgroundColor(Phone_Numbers[10], 255);
	TextDrawFont(Phone_Numbers[10], 4);
	TextDrawSetProportional(Phone_Numbers[10], 0);
	TextDrawSetShadow(Phone_Numbers[10], 0);
	TextDrawSetSelectable(Phone_Numbers[10], true);

	Phone_Numbers[11] = TextDrawCreate(582.000000, 368.000000, "LD_SPAC:white");
	TextDrawLetterSize(Phone_Numbers[11], 0.000000, 0.000000);
	TextDrawTextSize(Phone_Numbers[11], 16.000000, 17.000000);
	TextDrawAlignment(Phone_Numbers[11], 1);
	TextDrawColor(Phone_Numbers[11], 1684301055);
	TextDrawSetShadow(Phone_Numbers[11], 0);
	TextDrawSetOutline(Phone_Numbers[11], 0);
	TextDrawBackgroundColor(Phone_Numbers[11], 255);
	TextDrawFont(Phone_Numbers[11], 4);
	TextDrawSetProportional(Phone_Numbers[11], 0);
	TextDrawSetShadow(Phone_Numbers[11], 0);
	TextDrawSetSelectable(Phone_Numbers[11], true);

	Phone_NumbersRow[3] = TextDrawCreate(590.000000, 352.000000, "X~n~~n~C~n~~n~0");
	TextDrawLetterSize(Phone_NumbersRow[3], 0.305524, 1.066667);
	TextDrawAlignment(Phone_NumbersRow[3], 2);
	TextDrawColor(Phone_NumbersRow[3], -989855745);
	TextDrawSetShadow(Phone_NumbersRow[3], 0);
	TextDrawSetOutline(Phone_NumbersRow[3], 0);
	TextDrawBackgroundColor(Phone_NumbersRow[3], 255);
	TextDrawFont(Phone_NumbersRow[3], 2);
	TextDrawSetProportional(Phone_NumbersRow[3], 1);
	TextDrawSetShadow(Phone_NumbersRow[3], 0);



	Phone_ContactPicBackground = TextDrawCreate(528.476135, 318.426635, "box");
	TextDrawLetterSize(Phone_ContactPicBackground, 0.000000, 2.114283);
	TextDrawTextSize(Phone_ContactPicBackground, 547.000000, 0.000000);
	TextDrawAlignment(Phone_ContactPicBackground, 1);
	TextDrawColor(Phone_ContactPicBackground, -1);
	TextDrawUseBox(Phone_ContactPicBackground, 1);
	TextDrawBoxColor(Phone_ContactPicBackground, -1768515841);
	TextDrawSetShadow(Phone_ContactPicBackground, 0);
	TextDrawSetOutline(Phone_ContactPicBackground, 0);
	TextDrawBackgroundColor(Phone_ContactPicBackground, 255);
	TextDrawFont(Phone_ContactPicBackground, 1);
	TextDrawSetProportional(Phone_ContactPicBackground, 1);
	TextDrawSetShadow(Phone_ContactPicBackground, 0);

	Phone_ContactPic = TextDrawCreate(522.523742, 316.279937, "LD_OTB2:Ric1");
	TextDrawLetterSize(Phone_ContactPic, 0.000000, 0.000000);
	TextDrawTextSize(Phone_ContactPic, 31.000000, 31.000000);
	TextDrawAlignment(Phone_ContactPic, 1);
	TextDrawColor(Phone_ContactPic, 131);
	TextDrawSetShadow(Phone_ContactPic, 0);
	TextDrawSetOutline(Phone_ContactPic, 0);
	TextDrawBackgroundColor(Phone_ContactPic, 255);
	TextDrawFont(Phone_ContactPic, 4);
	TextDrawSetProportional(Phone_ContactPic, 0);
	TextDrawSetShadow(Phone_ContactPic, 0);

	Phone_SpeakerText = TextDrawCreate(563.142944, 348.293243, "SPEAKER_ON/OFF");
	TextDrawLetterSize(Phone_SpeakerText, 0.128380, 0.836265);
	TextDrawAlignment(Phone_SpeakerText, 2);
	TextDrawColor(Phone_SpeakerText, -1);
	TextDrawSetShadow(Phone_SpeakerText, 1);
	TextDrawSetOutline(Phone_SpeakerText, 1);
	TextDrawBackgroundColor(Phone_SpeakerText, 63);
	TextDrawFont(Phone_SpeakerText, 2);
	TextDrawSetProportional(Phone_SpeakerText, 1);
	TextDrawSetShadow(Phone_SpeakerText, 1);

	Phone_SpeakerTog = TextDrawCreate(527.857177, 347.426666, "LD_SPAC:white");
	TextDrawLetterSize(Phone_SpeakerTog, 0.000000, 0.000000);
	TextDrawTextSize(Phone_SpeakerTog, 71.000000, 10.000000);
	TextDrawAlignment(Phone_SpeakerTog, 1);
	TextDrawColor(Phone_SpeakerTog, -1431655681);
	TextDrawSetShadow(Phone_SpeakerTog, 0);
	TextDrawSetOutline(Phone_SpeakerTog, 0);
	TextDrawBackgroundColor(Phone_SpeakerTog, 255);
	TextDrawFont(Phone_SpeakerTog, 4);
	TextDrawSetProportional(Phone_SpeakerTog, 0);
	TextDrawSetShadow(Phone_SpeakerTog, 0);
	TextDrawSetSelectable(Phone_SpeakerTog, true);
	return 1;
}

stock PhoneTD_Create_Player(playerid)
{
	Phone_Service[playerid] = CreatePlayerTextDraw(playerid, 526.190490, 304.773284, "AT&T");
	PlayerTextDrawLetterSize(playerid, Phone_Service[playerid], 0.110476, 0.665598);
	PlayerTextDrawAlignment(playerid, Phone_Service[playerid], 1);
	PlayerTextDrawColor(playerid, Phone_Service[playerid], -103);
	PlayerTextDrawSetShadow(playerid, Phone_Service[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Phone_Service[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, Phone_Service[playerid], 255);
	PlayerTextDrawFont(playerid, Phone_Service[playerid], 2);
	PlayerTextDrawSetProportional(playerid, Phone_Service[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Phone_Service[playerid], 0);

	Phone_Time[playerid] = CreatePlayerTextDraw(playerid, 562.000122, 304.773284, "12:20");
	PlayerTextDrawLetterSize(playerid, Phone_Time[playerid], 0.110476, 0.665598);
	PlayerTextDrawAlignment(playerid, Phone_Time[playerid], 2);
	PlayerTextDrawColor(playerid, Phone_Time[playerid], -103);
	PlayerTextDrawSetShadow(playerid, Phone_Time[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Phone_Time[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, Phone_Time[playerid], 255);
	PlayerTextDrawFont(playerid, Phone_Time[playerid], 2);
	PlayerTextDrawSetProportional(playerid, Phone_Time[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Phone_Time[playerid], 0);

	Phone_Battery[playerid] = CreatePlayerTextDraw(playerid, 600.857604, 305.199951, "IIIII");
	PlayerTextDrawLetterSize(playerid, Phone_Battery[playerid], 0.173713, 0.644264);
	PlayerTextDrawAlignment(playerid, Phone_Battery[playerid], 3);
	PlayerTextDrawColor(playerid, Phone_Battery[playerid], -103);
	PlayerTextDrawSetShadow(playerid, Phone_Battery[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Phone_Battery[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, Phone_Battery[playerid], 255);
	PlayerTextDrawFont(playerid, Phone_Battery[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Phone_Battery[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Phone_Battery[playerid], 0);

	Phone_Estimated[playerid] = CreatePlayerTextDraw(playerid, 551.333251, 321.839996, "01:20");
	PlayerTextDrawLetterSize(playerid, Phone_Estimated[playerid], 0.208000, 1.006932);
	PlayerTextDrawAlignment(playerid, Phone_Estimated[playerid], 1);
	PlayerTextDrawColor(playerid, Phone_Estimated[playerid], -1061109505);
	PlayerTextDrawSetShadow(playerid, Phone_Estimated[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Phone_Estimated[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, Phone_Estimated[playerid], 255);
	PlayerTextDrawFont(playerid, Phone_Estimated[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Phone_Estimated[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Phone_Estimated[playerid], 0);

	Phone_Contact[playerid] = CreatePlayerTextDraw(playerid, 551.332946, 315.440032, "du_mc_susitinka");
	PlayerTextDrawLetterSize(playerid, Phone_Contact[playerid], 0.171427, 0.819199);
	PlayerTextDrawAlignment(playerid, Phone_Contact[playerid], 1);
	PlayerTextDrawColor(playerid, Phone_Contact[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Phone_Contact[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Phone_Contact[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, Phone_Contact[playerid], 255);
	PlayerTextDrawFont(playerid, Phone_Contact[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Phone_Contact[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Phone_Contact[playerid], 0);

	Phone_CallStatus[playerid] = CreatePlayerTextDraw(playerid, 563.143066, 377.733337, "CALLING");
	PlayerTextDrawLetterSize(playerid, Phone_CallStatus[playerid], 0.180952, 0.878932);
	PlayerTextDrawAlignment(playerid, Phone_CallStatus[playerid], 2);
	PlayerTextDrawColor(playerid, Phone_CallStatus[playerid], -1061109505);
	PlayerTextDrawSetShadow(playerid, Phone_CallStatus[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Phone_CallStatus[playerid], 10);
	PlayerTextDrawBackgroundColor(playerid, Phone_CallStatus[playerid], 0);
	PlayerTextDrawFont(playerid, Phone_CallStatus[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Phone_CallStatus[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Phone_CallStatus[playerid], 0);
		
	Phone_NumberLine[playerid] = CreatePlayerTextDraw(playerid, 596.000000, 320.000000, "12345");
	PlayerTextDrawLetterSize(playerid, Phone_NumberLine[playerid], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, Phone_NumberLine[playerid], 3);
	PlayerTextDrawColor(playerid, Phone_NumberLine[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Phone_NumberLine[playerid], 1);
	PlayerTextDrawSetOutline(playerid, Phone_NumberLine[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, Phone_NumberLine[playerid], 61);
	PlayerTextDrawFont(playerid, Phone_NumberLine[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Phone_NumberLine[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Phone_NumberLine[playerid], 1);
	return 1;
}




stock SpamBarTD_Show(playerid)
{
	TextDrawShowForPlayer(playerid, SpamBarTD_Base);
	TextDrawShowForPlayer(playerid, SpamBarTD_LoadBase);
	PlayerTextDrawShow(playerid, SpamBarTD_Load[playerid]);
	PlayerTextDrawShow(playerid, SpamBarTD_Value[playerid]);
	return 1;
}

stock SpamBarTD_Hide(playerid)
{
	TextDrawHideForPlayer(playerid, SpamBarTD_Base);
	TextDrawHideForPlayer(playerid, SpamBarTD_LoadBase);
	PlayerTextDrawHide(playerid, SpamBarTD_Load[playerid]);
	PlayerTextDrawHide(playerid, SpamBarTD_Value[playerid]);
	return 1;
}

stock JobGuiTD_Create_Global()
{
	JobGuiTD_Base = TextDrawCreate(17.238109, 107.653366, "box");
	TextDrawLetterSize(JobGuiTD_Base, 0.000000, 7.104763);
	TextDrawTextSize(JobGuiTD_Base, 156.000000, 0.000000);
	TextDrawAlignment(JobGuiTD_Base, 1);
	TextDrawColor(JobGuiTD_Base, -1);
	TextDrawUseBox(JobGuiTD_Base, 1);
	TextDrawBoxColor(JobGuiTD_Base, 95);
	TextDrawSetShadow(JobGuiTD_Base, 0);
	TextDrawSetOutline(JobGuiTD_Base, 0);
	TextDrawBackgroundColor(JobGuiTD_Base, 255);
	TextDrawFont(JobGuiTD_Base, 1);
	TextDrawSetProportional(JobGuiTD_Base, 1);
	TextDrawSetShadow(JobGuiTD_Base, 0);
	return 1;
}

stock JobGuiTD_Create_Player(playerid)
{
	JobGuiTD_TopText[playerid] = CreatePlayerTextDraw(playerid, 20.285699, 108.933403, "UZDUOTIS:_~n~LAIKAS:_~n~~n~~n~~n~~n~");
	PlayerTextDrawLetterSize(playerid, JobGuiTD_TopText[playerid], 0.207999, 0.989867);
	PlayerTextDrawAlignment(playerid, JobGuiTD_TopText[playerid], 1);
	PlayerTextDrawColor(playerid, JobGuiTD_TopText[playerid], -1);
	PlayerTextDrawSetShadow(playerid, JobGuiTD_TopText[playerid], 1);
	PlayerTextDrawSetOutline(playerid, JobGuiTD_TopText[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, JobGuiTD_TopText[playerid], 162);
	PlayerTextDrawFont(playerid, JobGuiTD_TopText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, JobGuiTD_TopText[playerid], 1);
	PlayerTextDrawSetShadow(playerid, JobGuiTD_TopText[playerid], 1);

	JobGuiTD_BotText[playerid] = CreatePlayerTextDraw(playerid, 20.285699, 147.333374, "KROVINYS:_NEZINOMAS~n~PAEMIMO_VIETA:_LOS_SANTOS_DOCKS~n~ISKROVIMO_VIETA:_BLUEBERRY_FARMS");
	PlayerTextDrawLetterSize(playerid, JobGuiTD_BotText[playerid], 0.178285, 0.806399);
	PlayerTextDrawAlignment(playerid, JobGuiTD_BotText[playerid], 1);
	PlayerTextDrawColor(playerid, JobGuiTD_BotText[playerid], -1580676865);
	PlayerTextDrawSetShadow(playerid, JobGuiTD_BotText[playerid], 1);
	PlayerTextDrawSetOutline(playerid, JobGuiTD_BotText[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, JobGuiTD_BotText[playerid], 133);
	PlayerTextDrawFont(playerid, JobGuiTD_BotText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, JobGuiTD_BotText[playerid], 1);
	PlayerTextDrawSetShadow(playerid, JobGuiTD_BotText[playerid], 1);
	return 1;
}


stock JobGUI_Show(playerid)
{
	if(ShowingJobGUI{playerid} == false)
	{
		TextDrawShowForPlayer(playerid, JobGuiTD_Base);
		PlayerTextDrawShow(playerid, JobGuiTD_TopText[playerid]);
		PlayerTextDrawShow(playerid, JobGuiTD_BotText[playerid]);
		ShowingJobGUI{playerid} = true;
	}
	return 1;
}

stock JobGUI_Hide(playerid)
{
	TextDrawHideForPlayer(playerid, JobGuiTD_Base);
	PlayerTextDrawHide(playerid, JobGuiTD_TopText[playerid]);
	PlayerTextDrawHide(playerid, JobGuiTD_BotText[playerid]);
	ShowingJobGUI{playerid} = false;
	return 1;
}


stock BorderHUD_Show(playerid)
{
	TextDrawShowForPlayer(playerid, BorderHUD_Top);
	TextDrawShowForPlayer(playerid, BorderHUD_Bottom);
	return 1;
}

stock BorderHUD_Hide(playerid)
{
	TextDrawHideForPlayer(playerid, BorderHUD_Top);
	TextDrawHideForPlayer(playerid, BorderHUD_Bottom);
	return 1;
}


stock CharListTD_Create_Player(playerid)
{
	chars_p_td_lessinfo[playerid][0] = CreatePlayerTextDraw(playerid, 149.000000, 274.000000, "Lygis:_10_(2/50_XP)~n~Darbas:_nera~n~Grynieji:_1000$~n~Banke:_1000$", .perm = true);
	PlayerTextDrawLetterSize(playerid, chars_p_td_lessinfo[playerid][0], 0.199616, 0.900264);
	PlayerTextDrawAlignment(playerid, chars_p_td_lessinfo[playerid][0], 1);
	PlayerTextDrawColor(playerid, chars_p_td_lessinfo[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, chars_p_td_lessinfo[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, chars_p_td_lessinfo[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, chars_p_td_lessinfo[playerid][0], 255);
	PlayerTextDrawFont(playerid, chars_p_td_lessinfo[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, chars_p_td_lessinfo[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, chars_p_td_lessinfo[playerid][0], 0);

	chars_p_td_smallname[playerid][0] = CreatePlayerTextDraw(playerid, 149.000000, 261.000000, "BENJAMIN_MC_FORBES_TIPO", .perm = true);
	PlayerTextDrawLetterSize(playerid, chars_p_td_smallname[playerid][0], 0.214855, 1.036798);
	PlayerTextDrawAlignment(playerid, chars_p_td_smallname[playerid][0], 1);
	PlayerTextDrawColor(playerid, chars_p_td_smallname[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, chars_p_td_smallname[playerid][0], 1);
	PlayerTextDrawSetOutline(playerid, chars_p_td_smallname[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, chars_p_td_smallname[playerid][0], 74);
	PlayerTextDrawFont(playerid, chars_p_td_smallname[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, chars_p_td_smallname[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, chars_p_td_smallname[playerid][0], 1);

	chars_p_td_charskin[playerid][0] = CreatePlayerTextDraw(playerid, 136.000000, 131.000000, "", .perm = true);
	PlayerTextDrawLetterSize(playerid, chars_p_td_charskin[playerid][0], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, chars_p_td_charskin[playerid][0], 118.000000, 117.000000);
	PlayerTextDrawAlignment(playerid, chars_p_td_charskin[playerid][0], 1);
	PlayerTextDrawColor(playerid, chars_p_td_charskin[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, chars_p_td_charskin[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, chars_p_td_charskin[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, chars_p_td_charskin[playerid][0], 0);
	PlayerTextDrawFont(playerid, chars_p_td_charskin[playerid][0], 5);
	PlayerTextDrawSetProportional(playerid, chars_p_td_charskin[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, chars_p_td_charskin[playerid][0], 0);
	PlayerTextDrawSetPreviewModel(playerid, chars_p_td_charskin[playerid][0], 241);
	PlayerTextDrawSetPreviewRot(playerid, chars_p_td_charskin[playerid][0], 0.000000, 0.000000, 0.000000, 1.007151);


	chars_p_td_smallname[playerid][1] = CreatePlayerTextDraw(playerid, 256.000000, 261.000000, "BENJAMIN_MC_FORBES_TIPO", .perm = true);
	PlayerTextDrawLetterSize(playerid, chars_p_td_smallname[playerid][1], 0.214855, 1.036798);
	PlayerTextDrawAlignment(playerid, chars_p_td_smallname[playerid][1], 1);
	PlayerTextDrawColor(playerid, chars_p_td_smallname[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, chars_p_td_smallname[playerid][1], 1);
	PlayerTextDrawSetOutline(playerid, chars_p_td_smallname[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, chars_p_td_smallname[playerid][1], 74);
	PlayerTextDrawFont(playerid, chars_p_td_smallname[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, chars_p_td_smallname[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, chars_p_td_smallname[playerid][1], 1);

	chars_p_td_lessinfo[playerid][1] = CreatePlayerTextDraw(playerid, 256.599975, 274.000000, "Lygis:_10_(2/50_XP)~n~Darbas:_nera~n~Grynieji:_1000$~n~Banke:_1000$", .perm = true);
	PlayerTextDrawLetterSize(playerid, chars_p_td_lessinfo[playerid][1], 0.199616, 0.900264);
	PlayerTextDrawAlignment(playerid, chars_p_td_lessinfo[playerid][1], 1);
	PlayerTextDrawColor(playerid, chars_p_td_lessinfo[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, chars_p_td_lessinfo[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, chars_p_td_lessinfo[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, chars_p_td_lessinfo[playerid][1], 255);
	PlayerTextDrawFont(playerid, chars_p_td_lessinfo[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, chars_p_td_lessinfo[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, chars_p_td_lessinfo[playerid][1], 0);


	chars_p_td_charskin[playerid][1] = CreatePlayerTextDraw(playerid, 244.000000, 130.000000, "", .perm = true);
	PlayerTextDrawLetterSize(playerid, chars_p_td_charskin[playerid][1], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, chars_p_td_charskin[playerid][1], 118.000000, 117.000000);
	PlayerTextDrawAlignment(playerid, chars_p_td_charskin[playerid][1], 1);
	PlayerTextDrawColor(playerid, chars_p_td_charskin[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, chars_p_td_charskin[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, chars_p_td_charskin[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, chars_p_td_charskin[playerid][1], 0);
	PlayerTextDrawFont(playerid, chars_p_td_charskin[playerid][1], 5);
	PlayerTextDrawSetProportional(playerid, chars_p_td_charskin[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, chars_p_td_charskin[playerid][1], 0);
	PlayerTextDrawSetPreviewModel(playerid, chars_p_td_charskin[playerid][1], 154);
	PlayerTextDrawSetPreviewRot(playerid, chars_p_td_charskin[playerid][1], 0.000000, 0.000000, 0.000000, 1.007151);

	chars_p_td_error[playerid] = CreatePlayerTextDraw(playerid, 325.000000, 351.000000, "~n~_Sis_veikejas_yra_naudojamas!_Pirmiausia_turite_ji~n~_atjungti_nuo_zaidimo.~n~~n~", .perm = true);
	PlayerTextDrawLetterSize(playerid, chars_p_td_error[playerid], 0.204571, 0.768000);
	PlayerTextDrawTextSize(playerid, chars_p_td_error[playerid], 492.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, chars_p_td_error[playerid], 1);
	PlayerTextDrawColor(playerid, chars_p_td_error[playerid], -1061109505);
	PlayerTextDrawUseBox(playerid, chars_p_td_error[playerid], 1);
	PlayerTextDrawBoxColor(playerid, chars_p_td_error[playerid], 255);
	PlayerTextDrawSetShadow(playerid, chars_p_td_error[playerid], 0);
	PlayerTextDrawSetOutline(playerid, chars_p_td_error[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, chars_p_td_error[playerid], 95);
	PlayerTextDrawFont(playerid, chars_p_td_error[playerid], 1);
	PlayerTextDrawSetProportional(playerid, chars_p_td_error[playerid], 1);
	PlayerTextDrawSetShadow(playerid, chars_p_td_error[playerid], 0);

	chars_p_td_bigname[playerid] = CreatePlayerTextDraw(playerid, 362.000000, 121.000000, "BENJAMIN_MC_FORBES_TIPO", .perm = true);
	PlayerTextDrawLetterSize(playerid, chars_p_td_bigname[playerid], 0.238474, 1.117865);
	PlayerTextDrawAlignment(playerid, chars_p_td_bigname[playerid], 1);
	PlayerTextDrawColor(playerid, chars_p_td_bigname[playerid], -1);
	PlayerTextDrawSetShadow(playerid, chars_p_td_bigname[playerid], 1);
	PlayerTextDrawSetOutline(playerid, chars_p_td_bigname[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, chars_p_td_bigname[playerid], 74);
	PlayerTextDrawFont(playerid, chars_p_td_bigname[playerid], 1);
	PlayerTextDrawSetProportional(playerid, chars_p_td_bigname[playerid], 1);
	PlayerTextDrawSetShadow(playerid, chars_p_td_bigname[playerid], 1);

	chars_p_td_biginfo[playerid] = CreatePlayerTextDraw(playerid, 362.000000, 132.000000 /*122.000000*/, "Administracijos_grupes:_(Ikurejas)~n~(Administratorius_I)_(Frakciju_valdyb~n~a)~n~Frakcija:_Los_Santos_Police_Dep.~n~Rangas:_Detective_I~n~Turimos_tr._priemones:_3~n~Turimi_namai:_3~n~Turimi_verslai:_3~n~", .perm = true);
	PlayerTextDrawLetterSize(playerid, chars_p_td_biginfo[playerid], 0.199616, 0.900264); 
	PlayerTextDrawAlignment(playerid, chars_p_td_biginfo[playerid], 1);
	PlayerTextDrawColor(playerid, chars_p_td_biginfo[playerid], -1);
	PlayerTextDrawSetShadow(playerid, chars_p_td_biginfo[playerid], 0);
	PlayerTextDrawSetOutline(playerid, chars_p_td_biginfo[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, chars_p_td_biginfo[playerid], 255);
	PlayerTextDrawFont(playerid, chars_p_td_biginfo[playerid], 1);
	PlayerTextDrawSetProportional(playerid, chars_p_td_biginfo[playerid], 1);
	PlayerTextDrawSetShadow(playerid, chars_p_td_biginfo[playerid], 0);

	chars_p_td_page_txt[playerid] = CreatePlayerTextDraw(playerid, 425.000000, 319.000000, "Puslapis:_3/3_antras_pt_kaire_desine", .perm = true);
	PlayerTextDrawLetterSize(playerid, chars_p_td_page_txt[playerid], 0.192761, 0.951466);
	PlayerTextDrawAlignment(playerid, chars_p_td_page_txt[playerid], 2);
	PlayerTextDrawColor(playerid, chars_p_td_page_txt[playerid], 255);
	PlayerTextDrawSetShadow(playerid, chars_p_td_page_txt[playerid], 0);
	PlayerTextDrawSetOutline(playerid, chars_p_td_page_txt[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, chars_p_td_page_txt[playerid], -2139062017);
	PlayerTextDrawFont(playerid, chars_p_td_page_txt[playerid], 1);
	PlayerTextDrawSetProportional(playerid, chars_p_td_page_txt[playerid], 1);
	PlayerTextDrawSetShadow(playerid, chars_p_td_page_txt[playerid], 0);
}

stock CharListTD_Create_Global()
{
	chars_g_td_mainbg = TextDrawCreate(131.142959, 109.786651, "main_bg");
	TextDrawLetterSize(chars_g_td_mainbg, 0.000000, 26.419048);
	TextDrawTextSize(chars_g_td_mainbg, 492.000000, 0.000000);
	TextDrawAlignment(chars_g_td_mainbg, 1);
	TextDrawColor(chars_g_td_mainbg, -1);
	TextDrawUseBox(chars_g_td_mainbg, 1);
	TextDrawBoxColor(chars_g_td_mainbg, 522133474);
	TextDrawSetShadow(chars_g_td_mainbg, 0);
	TextDrawSetOutline(chars_g_td_mainbg, 0);
	TextDrawBackgroundColor(chars_g_td_mainbg, 255);
	TextDrawFont(chars_g_td_mainbg, 1);
	TextDrawSetProportional(chars_g_td_mainbg, 1);
	TextDrawSetShadow(chars_g_td_mainbg, 0);

	chars_g_td_play = TextDrawCreate(363.000000, 238.100921, "LD_SPAC:white");
	TextDrawLetterSize(chars_g_td_play, 0.000000, 0.000000);
	TextDrawTextSize(chars_g_td_play, 120.000000, 12.000000);
	TextDrawAlignment(chars_g_td_play, 1);
	TextDrawColor(chars_g_td_play, -1364283649);
	TextDrawSetShadow(chars_g_td_play, 0);
	TextDrawSetOutline(chars_g_td_play, 0);
	TextDrawBackgroundColor(chars_g_td_play, 255);
	TextDrawFont(chars_g_td_play, 4);
	TextDrawSetProportional(chars_g_td_play, 0);
	TextDrawSetShadow(chars_g_td_play, 0);
	TextDrawSetSelectable(chars_g_td_play, true);

	chars_g_td_info = TextDrawCreate(363.000000, 252.601806, "LD_SPAC:white");
	TextDrawLetterSize(chars_g_td_info, 0.000000, 0.000000);
	TextDrawTextSize(chars_g_td_info, 120.000000, 12.000000);
	TextDrawAlignment(chars_g_td_info, 1);
	TextDrawColor(chars_g_td_info, -1364283649);
	TextDrawSetShadow(chars_g_td_info, 0);
	TextDrawSetOutline(chars_g_td_info, 0);
	TextDrawBackgroundColor(chars_g_td_info, 255);
	TextDrawFont(chars_g_td_info, 4);
	TextDrawSetProportional(chars_g_td_info, 0);
	TextDrawSetShadow(chars_g_td_info, 0);
	TextDrawSetSelectable(chars_g_td_info, true);

	chars_g_td_donator = TextDrawCreate(363.000000, 266.802673, "LD_SPAC:white");
	TextDrawLetterSize(chars_g_td_donator, 0.000000, 0.000000);
	TextDrawTextSize(chars_g_td_donator, 120.000000, 12.000000);
	TextDrawAlignment(chars_g_td_donator, 1);
	TextDrawColor(chars_g_td_donator, -1364283649);
	TextDrawSetShadow(chars_g_td_donator, 0);
	TextDrawSetOutline(chars_g_td_donator, 0);
	TextDrawBackgroundColor(chars_g_td_donator, 255);
	TextDrawFont(chars_g_td_donator, 4);
	TextDrawSetProportional(chars_g_td_donator, 0);
	TextDrawSetShadow(chars_g_td_donator, 0);
	TextDrawSetSelectable(chars_g_td_donator, true);

	chars_g_td_new = TextDrawCreate(363.000000, 281.300018, "LD_SPAC:white");
	TextDrawLetterSize(chars_g_td_new, 0.000000, 0.000000);
	TextDrawTextSize(chars_g_td_new, 120.000000, 31.000000);
	TextDrawAlignment(chars_g_td_new, 1);
	TextDrawColor(chars_g_td_new, 7291391);
	TextDrawSetShadow(chars_g_td_new, 0);
	TextDrawSetOutline(chars_g_td_new, 0);
	TextDrawBackgroundColor(chars_g_td_new, 255);
	TextDrawFont(chars_g_td_new, 4);
	TextDrawSetProportional(chars_g_td_new, 0);
	TextDrawSetShadow(chars_g_td_new, 0);
	TextDrawSetSelectable(chars_g_td_new, true);

	chars_g_td_page_bg = TextDrawCreate(383.501251, 315.000000, "LD_SPAC:white");
	TextDrawLetterSize(chars_g_td_page_bg, 0.000000, 0.000000);
	TextDrawTextSize(chars_g_td_page_bg, 78.759948, 18.000000);
	TextDrawAlignment(chars_g_td_page_bg, 1);
	TextDrawColor(chars_g_td_page_bg, 1583243007);
	TextDrawSetShadow(chars_g_td_page_bg, 0);
	TextDrawSetOutline(chars_g_td_page_bg, 0);
	TextDrawBackgroundColor(chars_g_td_page_bg, 255);
	TextDrawFont(chars_g_td_page_bg, 4);
	TextDrawSetProportional(chars_g_td_page_bg, 0);
	TextDrawSetShadow(chars_g_td_page_bg, 0);
	TextDrawSetSelectable(chars_g_td_page_bg, false);

	chars_g_td_page_back = TextDrawCreate(363.100006, 315.000000, "LD_SPAC:white");
	TextDrawLetterSize(chars_g_td_page_back, 0.000000, 0.000000);
	TextDrawTextSize(chars_g_td_page_back, 18.000000, 18.000000);
	TextDrawAlignment(chars_g_td_page_back, 1);
	TextDrawColor(chars_g_td_page_back, -1364283649);
	TextDrawSetShadow(chars_g_td_page_back, 0);
	TextDrawSetOutline(chars_g_td_page_back, 0);
	TextDrawBackgroundColor(chars_g_td_page_back, 255);
	TextDrawFont(chars_g_td_page_back, 4);
	TextDrawSetProportional(chars_g_td_page_back, 0);
	TextDrawSetShadow(chars_g_td_page_back, 0);
	TextDrawSetSelectable(chars_g_td_page_back, true);

	chars_g_td_page_next = TextDrawCreate(464.600036, 315.000000, "LD_SPAC:white");
	TextDrawLetterSize(chars_g_td_page_next, 0.000000, 0.000000);
	TextDrawTextSize(chars_g_td_page_next, 18.000000, 18.000000);
	TextDrawAlignment(chars_g_td_page_next, 1);
	TextDrawColor(chars_g_td_page_next, -1364283649);
	TextDrawSetShadow(chars_g_td_page_next, 0);
	TextDrawSetOutline(chars_g_td_page_next, 0);
	TextDrawBackgroundColor(chars_g_td_page_next, 255);
	TextDrawFont(chars_g_td_page_next, 4);
	TextDrawSetProportional(chars_g_td_page_next, 0);
	TextDrawSetShadow(chars_g_td_page_next, 0);
	TextDrawSetSelectable(chars_g_td_page_next, true);

	chars_g_td_page_back_txt = TextDrawCreate(366.000000, 319.000000, "LD_BEAT:left");
	TextDrawLetterSize(chars_g_td_page_back_txt, 0.000000, 0.000000);
	TextDrawTextSize(chars_g_td_page_back_txt, 12.000000, 12.000000);
	TextDrawAlignment(chars_g_td_page_back_txt, 1);
	TextDrawColor(chars_g_td_page_back_txt, -1);
	TextDrawSetShadow(chars_g_td_page_back_txt, 0);
	TextDrawSetOutline(chars_g_td_page_back_txt, 0);
	TextDrawBackgroundColor(chars_g_td_page_back_txt, 255);
	TextDrawFont(chars_g_td_page_back_txt, 4);
	TextDrawSetProportional(chars_g_td_page_back_txt, 0);
	TextDrawSetShadow(chars_g_td_page_back_txt, 0);

	chars_g_td_page_next_txt = TextDrawCreate(467.699981, 318.499969, "LD_BEAT:right");
	TextDrawLetterSize(chars_g_td_page_next_txt, 0.000000, 0.000000);
	TextDrawTextSize(chars_g_td_page_next_txt, 12.000000, 12.000000);
	TextDrawAlignment(chars_g_td_page_next_txt, 1);
	TextDrawColor(chars_g_td_page_next_txt, -1);
	TextDrawSetShadow(chars_g_td_page_next_txt, 0);
	TextDrawSetOutline(chars_g_td_page_next_txt, 0);
	TextDrawBackgroundColor(chars_g_td_page_next_txt, 255);
	TextDrawFont(chars_g_td_page_next_txt, 4);
	TextDrawSetProportional(chars_g_td_page_next_txt, 0);
	TextDrawSetShadow(chars_g_td_page_next_txt, 0);

	chars_g_td_play_txt = TextDrawCreate(424.000000, 239.400024, "Zaisti");
	TextDrawLetterSize(chars_g_td_play_txt, 0.192761, 0.951466);
	TextDrawAlignment(chars_g_td_play_txt, 2);
	TextDrawColor(chars_g_td_play_txt, 255);
	TextDrawSetShadow(chars_g_td_play_txt, 0);
	TextDrawSetOutline(chars_g_td_play_txt, 1);
	TextDrawBackgroundColor(chars_g_td_play_txt, 0);
	TextDrawFont(chars_g_td_play_txt, 1);
	TextDrawSetProportional(chars_g_td_play_txt, 1);
	TextDrawSetShadow(chars_g_td_play_txt, 0);

	chars_g_td_info_txt = TextDrawCreate(424.000000, 253.700897, "Daugiau_informacijos");
	TextDrawLetterSize(chars_g_td_info_txt, 0.192761, 0.951466);
	TextDrawAlignment(chars_g_td_info_txt, 2);
	TextDrawColor(chars_g_td_info_txt, 255);
	TextDrawSetShadow(chars_g_td_info_txt, 0);
	TextDrawSetOutline(chars_g_td_info_txt, 1);
	TextDrawBackgroundColor(chars_g_td_info_txt, 0);
	TextDrawFont(chars_g_td_info_txt, 1);
	TextDrawSetProportional(chars_g_td_info_txt, 1);
	TextDrawSetShadow(chars_g_td_info_txt, 0);

	chars_g_td_donator_txt = TextDrawCreate(424.000000, 268.101776, "Remejo_meniu");
	TextDrawLetterSize(chars_g_td_donator_txt, 0.192761, 0.951466);
	TextDrawAlignment(chars_g_td_donator_txt, 2);
	TextDrawColor(chars_g_td_donator_txt, 255);
	TextDrawSetShadow(chars_g_td_donator_txt, 0);
	TextDrawSetOutline(chars_g_td_donator_txt, 1);
	TextDrawBackgroundColor(chars_g_td_donator_txt, 0);
	TextDrawFont(chars_g_td_donator_txt, 1);
	TextDrawSetProportional(chars_g_td_donator_txt, 1);
	TextDrawSetShadow(chars_g_td_donator_txt, 0);

	chars_g_td_new_txt = TextDrawCreate(425.499969, 292.000000, "Naujo_veikejo_kurimas");
	TextDrawLetterSize(chars_g_td_new_txt, 0.192761, 0.951466);
	TextDrawAlignment(chars_g_td_new_txt, 2);
	TextDrawColor(chars_g_td_new_txt, 255);
	TextDrawSetShadow(chars_g_td_new_txt, 0);
	TextDrawSetOutline(chars_g_td_new_txt, 1);
	TextDrawBackgroundColor(chars_g_td_new_txt, 0);
	TextDrawFont(chars_g_td_new_txt, 1);
	TextDrawSetProportional(chars_g_td_new_txt, 1);
	TextDrawSetShadow(chars_g_td_new_txt, 0);

	chars_g_td_charbg[0] = TextDrawCreate(146.000000, 123.000000, "LD_SPAC:white");
	TextDrawLetterSize(chars_g_td_charbg[0], 0.000000, 0.000000);
	TextDrawTextSize(chars_g_td_charbg[0], 102.000000, 210.000000);
	TextDrawAlignment(chars_g_td_charbg[0], 1);
	TextDrawColor(chars_g_td_charbg[0], 976894719);
	TextDrawSetShadow(chars_g_td_charbg[0], 0);
	TextDrawSetOutline(chars_g_td_charbg[0], 0);
	TextDrawBackgroundColor(chars_g_td_charbg[0], 255);
	TextDrawFont(chars_g_td_charbg[0], 4);
	TextDrawSetProportional(chars_g_td_charbg[0], 0);
	TextDrawSetShadow(chars_g_td_charbg[0], 0);

	chars_g_td_charbg[1] = TextDrawCreate(252.800048, 123.000000, "LD_SPAC:white");
	TextDrawLetterSize(chars_g_td_charbg[1], 0.000000, 0.000000);
	TextDrawTextSize(chars_g_td_charbg[1], 102.000000, 210.000000);
	TextDrawAlignment(chars_g_td_charbg[1], 1);
	TextDrawColor(chars_g_td_charbg[1], 976894719);
	TextDrawSetShadow(chars_g_td_charbg[1], 0);
	TextDrawSetOutline(chars_g_td_charbg[1], 0);
	TextDrawBackgroundColor(chars_g_td_charbg[1], 255);
	TextDrawFont(chars_g_td_charbg[1], 4);
	TextDrawSetProportional(chars_g_td_charbg[1], 0);
	TextDrawSetShadow(chars_g_td_charbg[1], 0);

	chars_g_td_control[0] = TextDrawCreate(148.400024, 317.200012, "LD_SPAC:white");
	TextDrawLetterSize(chars_g_td_control[0], 0.000000, 0.000000);
	TextDrawTextSize(chars_g_td_control[0], 97.000000, 12.000000);
	TextDrawAlignment(chars_g_td_control[0], 1);
	TextDrawColor(chars_g_td_control[0], -1364283649);
	TextDrawSetShadow(chars_g_td_control[0], 0);
	TextDrawSetOutline(chars_g_td_control[0], 0);
	TextDrawBackgroundColor(chars_g_td_control[0], 255);
	TextDrawFont(chars_g_td_control[0], 4);
	TextDrawSetProportional(chars_g_td_control[0], 0);
	TextDrawSetShadow(chars_g_td_control[0], 0);
	TextDrawSetSelectable(chars_g_td_control[0], true);

	chars_g_td_control[1] = TextDrawCreate(255.400024, 317.200012, "LD_SPAC:white");
	TextDrawLetterSize(chars_g_td_control[1], 0.000000, 0.000000);
	TextDrawTextSize(chars_g_td_control[1], 97.000000, 12.000000);
	TextDrawAlignment(chars_g_td_control[1], 1);
	TextDrawColor(chars_g_td_control[1], -1364283649);
	TextDrawSetShadow(chars_g_td_control[1], 0);
	TextDrawSetOutline(chars_g_td_control[1], 0);
	TextDrawBackgroundColor(chars_g_td_control[1], 255);
	TextDrawFont(chars_g_td_control[1], 4);
	TextDrawSetProportional(chars_g_td_control[1], 0);
	TextDrawSetShadow(chars_g_td_control[1], 0);
	TextDrawSetSelectable(chars_g_td_control[1], true);

	chars_g_td_control_txt[0] = TextDrawCreate(196.000000, 319.000000, "Valdymas");
	TextDrawLetterSize(chars_g_td_control_txt[0], 0.192761, 0.951466);
	TextDrawAlignment(chars_g_td_control_txt[0], 2);
	TextDrawColor(chars_g_td_control_txt[0], 255);
	TextDrawSetShadow(chars_g_td_control_txt[0], 0);
	TextDrawSetOutline(chars_g_td_control_txt[0], 1);
	TextDrawBackgroundColor(chars_g_td_control_txt[0], 0);
	TextDrawFont(chars_g_td_control_txt[0], 1);
	TextDrawSetProportional(chars_g_td_control_txt[0], 1);
	TextDrawSetShadow(chars_g_td_control_txt[0], 0);

	chars_g_td_control_txt[1] = TextDrawCreate(306.000000, 319.000000, "Valdymas");
	TextDrawLetterSize(chars_g_td_control_txt[1], 0.192761, 0.951466);
	TextDrawAlignment(chars_g_td_control_txt[1], 2);
	TextDrawColor(chars_g_td_control_txt[1], 255);
	TextDrawSetShadow(chars_g_td_control_txt[1], 0);
	TextDrawSetOutline(chars_g_td_control_txt[1], 1);
	TextDrawBackgroundColor(chars_g_td_control_txt[1], 0);
	TextDrawFont(chars_g_td_control_txt[1], 1);
	TextDrawSetProportional(chars_g_td_control_txt[1], 1);
	TextDrawSetShadow(chars_g_td_control_txt[1], 0);
}

stock CharCreateTD_Create_Global()
{
	create_g_td_model_bg = TextDrawCreate(147.523834, 181.040008, "skin_bg");
	TextDrawLetterSize(create_g_td_model_bg, 0.000000, 13.466655);
	TextDrawTextSize(create_g_td_model_bg, 242.000000, 0.000000);
	TextDrawAlignment(create_g_td_model_bg, 1);
	TextDrawColor(create_g_td_model_bg, -1);
	TextDrawUseBox(create_g_td_model_bg, 1);
	TextDrawBoxColor(create_g_td_model_bg, -238);
	TextDrawSetShadow(create_g_td_model_bg, 0);
	TextDrawSetOutline(create_g_td_model_bg, 0);
	TextDrawBackgroundColor(create_g_td_model_bg, 255);
	TextDrawFont(create_g_td_model_bg, 1);
	TextDrawSetProportional(create_g_td_model_bg, 1);
	TextDrawSetShadow(create_g_td_model_bg, 0);

	create_g_td_skin = TextDrawCreate(146.142822, 319.266632, "LD_SPAC:white"); // skin bg
	TextDrawLetterSize(create_g_td_skin, 0.000000, 0.000000);
	TextDrawTextSize(create_g_td_skin, 97.000000, 12.000000);
	TextDrawAlignment(create_g_td_skin, 1);
	TextDrawColor(create_g_td_skin, -1364283649);
	TextDrawSetShadow(create_g_td_skin, 0);
	TextDrawSetOutline(create_g_td_skin, 0);
	TextDrawBackgroundColor(create_g_td_skin, 255);
	TextDrawFont(create_g_td_skin, 4);
	TextDrawSetProportional(create_g_td_skin, 0);
	TextDrawSetShadow(create_g_td_skin, 0);
	TextDrawSetSelectable(create_g_td_skin, true);

	create_g_td_skin_txt = TextDrawCreate(146.361816, 310.273193, "VEIKEJO_ISVAIZDA");
	TextDrawLetterSize(create_g_td_skin_txt, 0.210666, 0.896000);
	TextDrawAlignment(create_g_td_skin_txt, 1);
	TextDrawColor(create_g_td_skin_txt, -421075201);
	TextDrawSetShadow(create_g_td_skin_txt, 0);
	TextDrawSetOutline(create_g_td_skin_txt, 0);
	TextDrawBackgroundColor(create_g_td_skin_txt, 255);
	TextDrawFont(create_g_td_skin_txt, 1);
	TextDrawSetProportional(create_g_td_skin_txt, 1);
	TextDrawSetShadow(create_g_td_skin_txt, 0);

	create_g_td_age = TextDrawCreate(146.323776, 158.366683, "LD_SPAC:white"); // age bg
	TextDrawLetterSize(create_g_td_age, 0.000000, 0.000000);
	TextDrawTextSize(create_g_td_age, 97.000000, 12.000000);
	TextDrawAlignment(create_g_td_age, 1);
	TextDrawColor(create_g_td_age, -1364283649);
	TextDrawSetShadow(create_g_td_age, 0);
	TextDrawSetOutline(create_g_td_age, 0);
	TextDrawBackgroundColor(create_g_td_age, 255);
	TextDrawFont(create_g_td_age, 4);
	TextDrawSetProportional(create_g_td_age, 0);
	TextDrawSetShadow(create_g_td_age, 0);
	TextDrawSetSelectable(create_g_td_age, true);

	create_g_td_age_txt = TextDrawCreate(146.380920, 149.466644, "VEIKEJO_GIMIMO_METAI");
	TextDrawLetterSize(create_g_td_age_txt, 0.210666, 0.896000);
	TextDrawAlignment(create_g_td_age_txt, 1);
	TextDrawColor(create_g_td_age_txt, -421075201);
	TextDrawSetShadow(create_g_td_age_txt, 0);
	TextDrawSetOutline(create_g_td_age_txt, 0);
	TextDrawBackgroundColor(create_g_td_age_txt, 255);
	TextDrawFont(create_g_td_age_txt, 1);
	TextDrawSetProportional(create_g_td_age_txt, 1);
	TextDrawSetShadow(create_g_td_age_txt, 0);

	create_g_td_name_txt = TextDrawCreate(145.999969, 124.293334, "VARDAS_PAVARDE");
	TextDrawLetterSize(create_g_td_name_txt, 0.210666, 0.896000);
	TextDrawAlignment(create_g_td_name_txt, 1);
	TextDrawColor(create_g_td_name_txt, -421075201);
	TextDrawSetShadow(create_g_td_name_txt, 0);
	TextDrawSetOutline(create_g_td_name_txt, 0);
	TextDrawBackgroundColor(create_g_td_name_txt, 255);
	TextDrawFont(create_g_td_name_txt, 1);
	TextDrawSetProportional(create_g_td_name_txt, 1);
	TextDrawSetShadow(create_g_td_name_txt, 0);

	create_g_td_name = TextDrawCreate(146.599975, 133.799987, "LD_SPAC:white"); // name bg
	TextDrawLetterSize(create_g_td_name, 0.000000, 0.000000);
	TextDrawTextSize(create_g_td_name, 97.000000, 12.000000);
	TextDrawAlignment(create_g_td_name, 1);
	TextDrawColor(create_g_td_name, -1364283649);
	TextDrawSetShadow(create_g_td_name, 0);
	TextDrawSetOutline(create_g_td_name, 0);
	TextDrawBackgroundColor(create_g_td_name, 255);
	TextDrawFont(create_g_td_name, 4);
	TextDrawSetProportional(create_g_td_name, 0);
	TextDrawSetShadow(create_g_td_name, 0);
	TextDrawSetSelectable(create_g_td_name, true);

	create_g_td_origin_txt = TextDrawCreate(266.761840, 123.866668, "VEIKEJO_TAUTYBE");
	TextDrawLetterSize(create_g_td_origin_txt, 0.210666, 0.896000);
	TextDrawAlignment(create_g_td_origin_txt, 1);
	TextDrawColor(create_g_td_origin_txt, -421075201);
	TextDrawSetShadow(create_g_td_origin_txt, 0);
	TextDrawSetOutline(create_g_td_origin_txt, 0);
	TextDrawBackgroundColor(create_g_td_origin_txt, 255);
	TextDrawFont(create_g_td_origin_txt, 1);
	TextDrawSetProportional(create_g_td_origin_txt, 1);
	TextDrawSetShadow(create_g_td_origin_txt, 0);

	create_g_td_origin = TextDrawCreate(266.785614, 133.493392, "LD_SPAC:white"); // origin bg
	TextDrawLetterSize(create_g_td_origin, 0.000000, 0.000000);
	TextDrawTextSize(create_g_td_origin, 97.000000, 12.000000);
	TextDrawAlignment(create_g_td_origin, 1);
	TextDrawColor(create_g_td_origin, -1364283649);
	TextDrawSetShadow(create_g_td_origin, 0);
	TextDrawSetOutline(create_g_td_origin, 0);
	TextDrawBackgroundColor(create_g_td_origin, 255);
	TextDrawFont(create_g_td_origin, 4);
	TextDrawSetProportional(create_g_td_origin, 0);
	TextDrawSetShadow(create_g_td_origin, 0);
	TextDrawSetSelectable(create_g_td_origin, true);

	create_g_td_question[0] = TextDrawCreate(266.761840, 149.039932, "TRUMPAI_APRASYKITE,_KAS_YRA_ROLEPLAY");
	TextDrawLetterSize(create_g_td_question[0], 0.210666, 0.896000);
	TextDrawAlignment(create_g_td_question[0], 1);
	TextDrawColor(create_g_td_question[0], -421075201);
	TextDrawSetShadow(create_g_td_question[0], 0);
	TextDrawSetOutline(create_g_td_question[0], 0);
	TextDrawBackgroundColor(create_g_td_question[0], 255);
	TextDrawFont(create_g_td_question[0], 1);
	TextDrawSetProportional(create_g_td_question[0], 1);
	TextDrawSetShadow(create_g_td_question[0], 0);

	create_g_td_question_bg[0] = TextDrawCreate(267.166564, 158.239990, "LD_SPAC:white"); // KAS YRA RP
	TextDrawLetterSize(create_g_td_question_bg[0], 0.000000, 0.000000);
	TextDrawTextSize(create_g_td_question_bg[0], 211.000000, 42.000000);
	TextDrawAlignment(create_g_td_question_bg[0], 1);
	TextDrawColor(create_g_td_question_bg[0], -1364283649);
	TextDrawSetShadow(create_g_td_question_bg[0], 0);
	TextDrawSetOutline(create_g_td_question_bg[0], 0);
	TextDrawBackgroundColor(create_g_td_question_bg[0], 255);
	TextDrawFont(create_g_td_question_bg[0], 4);
	TextDrawSetProportional(create_g_td_question_bg[0], 0);
	TextDrawSetShadow(create_g_td_question_bg[0], 0);
	TextDrawSetSelectable(create_g_td_question_bg[0], true);

	create_g_td_question[1] = TextDrawCreate(267.304687, 204.586456, "TRUMPAI_APRASYKITE,_KAS_YRA_METAGAME_IR_POWERGAME");
	TextDrawLetterSize(create_g_td_question[1], 0.210666, 0.896000);
	TextDrawAlignment(create_g_td_question[1], 1);
	TextDrawColor(create_g_td_question[1], -421075201);
	TextDrawSetShadow(create_g_td_question[1], 0);
	TextDrawSetOutline(create_g_td_question[1], 0);
	TextDrawBackgroundColor(create_g_td_question[1], 255);
	TextDrawFont(create_g_td_question[1], 1);
	TextDrawSetProportional(create_g_td_question[1], 1);
	TextDrawSetShadow(create_g_td_question[1], 0);

	create_g_td_question_bg[1] = TextDrawCreate(267.709411, 213.786499, "LD_SPAC:white"); // kas yra MG 
	TextDrawLetterSize(create_g_td_question_bg[1], 0.000000, 0.000000);
	TextDrawTextSize(create_g_td_question_bg[1], 211.000000, 42.000000);
	TextDrawAlignment(create_g_td_question_bg[1], 1);
	TextDrawColor(create_g_td_question_bg[1], -1364283649);
	TextDrawSetShadow(create_g_td_question_bg[1], 0);
	TextDrawSetOutline(create_g_td_question_bg[1], 0);
	TextDrawBackgroundColor(create_g_td_question_bg[1], 255);
	TextDrawFont(create_g_td_question_bg[1], 4);
	TextDrawSetProportional(create_g_td_question_bg[1], 0);
	TextDrawSetShadow(create_g_td_question_bg[1], 0);
	TextDrawSetSelectable(create_g_td_question_bg[1], true);

	create_g_td_question[2] = TextDrawCreate(267.304687, 260.053070, "TRUMPAI_APRASYKITE,_KUO_ROLEPLAY_SKIRIASI_NUO_GRP");
	TextDrawLetterSize(create_g_td_question[2], 0.210666, 0.896000);
	TextDrawAlignment(create_g_td_question[2], 1);
	TextDrawColor(create_g_td_question[2], -421075201);
	TextDrawSetShadow(create_g_td_question[2], 0);
	TextDrawSetOutline(create_g_td_question[2], 0);
	TextDrawBackgroundColor(create_g_td_question[2], 255);
	TextDrawFont(create_g_td_question[2], 1);
	TextDrawSetProportional(create_g_td_question[2], 1);
	TextDrawSetShadow(create_g_td_question[2], 0);

	create_g_td_question_bg[2] = TextDrawCreate(267.709411, 269.253112, "LD_SPAC:white"); // grp ir rp skirtumai bg
	TextDrawLetterSize(create_g_td_question_bg[2], 0.000000, 0.000000);
	TextDrawTextSize(create_g_td_question_bg[2], 211.000000, 42.000000);
	TextDrawAlignment(create_g_td_question_bg[2], 1);
	TextDrawColor(create_g_td_question_bg[2], -1364283649);
	TextDrawSetShadow(create_g_td_question_bg[2], 0);
	TextDrawSetOutline(create_g_td_question_bg[2], 0);
	TextDrawBackgroundColor(create_g_td_question_bg[2], 255);
	TextDrawFont(create_g_td_question_bg[2], 4);
	TextDrawSetProportional(create_g_td_question_bg[2], 0);
	TextDrawSetShadow(create_g_td_question_bg[2], 0);
	TextDrawSetSelectable(create_g_td_question_bg[2], true);

	create_g_td_send = TextDrawCreate(267.285705, 319.266632, "LD_SPAC:white"); // ISISUSTI ANKETA BG
	TextDrawLetterSize(create_g_td_send, 0.000000, 0.000000);
	TextDrawTextSize(create_g_td_send, 211.000000, 17.000000);
	TextDrawAlignment(create_g_td_send, 1);
	TextDrawColor(create_g_td_send, 7291391);
	TextDrawSetShadow(create_g_td_send, 0);
	TextDrawSetOutline(create_g_td_send, 0);
	TextDrawBackgroundColor(create_g_td_send, 255);
	TextDrawFont(create_g_td_send, 4);
	TextDrawSetProportional(create_g_td_send, 0);
	TextDrawSetShadow(create_g_td_send, 0);
	TextDrawSetSelectable(create_g_td_send, true);

	create_g_td_send_txt = TextDrawCreate(374.371459, 324.026550, "ISSIUSTI_ANKETA");
	TextDrawLetterSize(create_g_td_send_txt, 0.192761, 0.951466);
	TextDrawAlignment(create_g_td_send_txt, 2);
	TextDrawColor(create_g_td_send_txt, 255);
	TextDrawSetShadow(create_g_td_send_txt, 0);
	TextDrawSetOutline(create_g_td_send_txt, 1);
	TextDrawBackgroundColor(create_g_td_send_txt, 0);
	TextDrawFont(create_g_td_send_txt, 1);
	TextDrawSetProportional(create_g_td_send_txt, 1);
	TextDrawSetShadow(create_g_td_send_txt, 0);

	create_g_td_help = TextDrawCreate(457.300018, 123.299934, "LD_SPAC:white"); // ? bg
	TextDrawLetterSize(create_g_td_help, 0.000000, 0.000000);
	TextDrawTextSize(create_g_td_help, 21.000000, 21.000000);
	TextDrawAlignment(create_g_td_help, 1);
	TextDrawColor(create_g_td_help, -2139062017);
	TextDrawSetShadow(create_g_td_help, 0);
	TextDrawSetOutline(create_g_td_help, 0);
	TextDrawBackgroundColor(create_g_td_help, 255);
	TextDrawFont(create_g_td_help, 4);
	TextDrawSetProportional(create_g_td_help, 0);
	TextDrawSetShadow(create_g_td_help, 0);
	TextDrawSetSelectable(create_g_td_help, true);

	create_g_td_back = TextDrawCreate(434.499969, 123.399993, "LD_SPAC:white"); // back bg
	TextDrawLetterSize(create_g_td_back, 0.000000, 0.000000);
	TextDrawTextSize(create_g_td_back, 21.000000, 21.000000);
	TextDrawAlignment(create_g_td_back, 1);
	TextDrawColor(create_g_td_back, -2139062017);
	TextDrawSetShadow(create_g_td_back, 0);
	TextDrawSetOutline(create_g_td_back, 0);
	TextDrawBackgroundColor(create_g_td_back, 255);
	TextDrawFont(create_g_td_back, 4);
	TextDrawSetProportional(create_g_td_back, 0);
	TextDrawSetShadow(create_g_td_back, 0);
	TextDrawSetSelectable(create_g_td_back, true);

	create_g_td_help_txt = TextDrawCreate(463.000000, 122.000000, "?");
	TextDrawLetterSize(create_g_td_help_txt, 0.431998, 2.385066);
	TextDrawAlignment(create_g_td_help_txt, 1);
	TextDrawColor(create_g_td_help_txt, 1650615039);
	TextDrawSetShadow(create_g_td_help_txt, 0);
	TextDrawSetOutline(create_g_td_help_txt, 1);
	TextDrawBackgroundColor(create_g_td_help_txt, -858993409);
	TextDrawFont(create_g_td_help_txt, 2);
	TextDrawSetProportional(create_g_td_help_txt, 1);
	TextDrawSetShadow(create_g_td_help_txt, 0);

	create_g_td_back_txt = TextDrawCreate(439.000000, 127.000000, "LD_BEAT:left");
	TextDrawLetterSize(create_g_td_back_txt, 0.000000, 0.000000);
	TextDrawTextSize(create_g_td_back_txt, 13.000000, 14.000000);
	TextDrawAlignment(create_g_td_back_txt, 1);
	TextDrawColor(create_g_td_back_txt, -1);
	TextDrawSetShadow(create_g_td_back_txt, 0);
	TextDrawSetOutline(create_g_td_back_txt, 0);
	TextDrawBackgroundColor(create_g_td_back_txt, 255);
	TextDrawFont(create_g_td_back_txt, 4);
	TextDrawSetProportional(create_g_td_back_txt, 0);
	TextDrawSetShadow(create_g_td_back_txt, 0);

	create_g_td_gender = TextDrawCreate(366.395080, 133.293380, "LD_SPAC:white");
	TextDrawLetterSize(create_g_td_gender, 0.000000, 0.000000);
	TextDrawTextSize(create_g_td_gender, 55.000000, 12.000000);
	TextDrawAlignment(create_g_td_gender, 1);
	TextDrawColor(create_g_td_gender, -1364283649);
	TextDrawSetShadow(create_g_td_gender, 0);
	TextDrawSetOutline(create_g_td_gender, 0);
	TextDrawBackgroundColor(create_g_td_gender, 255);
	TextDrawFont(create_g_td_gender, 4);
	TextDrawSetProportional(create_g_td_gender, 0);
	TextDrawSetShadow(create_g_td_gender, 0);
	TextDrawSetSelectable(create_g_td_gender, true);
}

stock CharCreateTD_Create_Player(playerid)
{
	create_p_td_age[playerid] = CreatePlayerTextDraw(playerid, 195.142913, 159.706588, "1999");
	PlayerTextDrawLetterSize(playerid, create_p_td_age[playerid], 0.192761, 0.951466);
	PlayerTextDrawAlignment(playerid, create_p_td_age[playerid], 2);
	PlayerTextDrawColor(playerid, create_p_td_age[playerid], 255);
	PlayerTextDrawSetShadow(playerid, create_p_td_age[playerid], 0);
	PlayerTextDrawSetOutline(playerid, create_p_td_age[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, create_p_td_age[playerid], 0);
	PlayerTextDrawFont(playerid, create_p_td_age[playerid], 1);
	PlayerTextDrawSetProportional(playerid, create_p_td_age[playerid], 1);
	PlayerTextDrawSetShadow(playerid, create_p_td_age[playerid], 0);

	create_p_td_skin[playerid] = CreatePlayerTextDraw(playerid, 195.704803, 320.613189, "Nenustatyta");
	PlayerTextDrawLetterSize(playerid, create_p_td_skin[playerid], 0.192761, 0.951466);
	PlayerTextDrawAlignment(playerid, create_p_td_skin[playerid], 2);
	PlayerTextDrawColor(playerid, create_p_td_skin[playerid], 255);
	PlayerTextDrawSetShadow(playerid, create_p_td_skin[playerid], 0);
	PlayerTextDrawSetOutline(playerid, create_p_td_skin[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, create_p_td_skin[playerid], 0);
	PlayerTextDrawFont(playerid, create_p_td_skin[playerid], 1);
	PlayerTextDrawSetProportional(playerid, create_p_td_skin[playerid], 1);
	PlayerTextDrawSetShadow(playerid, create_p_td_skin[playerid], 0);

	create_p_td_model[playerid] = CreatePlayerTextDraw(playerid, 136.238098, 175.906631, "");
	PlayerTextDrawLetterSize(playerid, create_p_td_model[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, create_p_td_model[playerid], 118.000000, 117.000000);
	PlayerTextDrawAlignment(playerid, create_p_td_model[playerid], 1);
	PlayerTextDrawColor(playerid, create_p_td_model[playerid], -1);
	PlayerTextDrawSetShadow(playerid, create_p_td_model[playerid], 0);
	PlayerTextDrawSetOutline(playerid, create_p_td_model[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, create_p_td_model[playerid], 0);
	PlayerTextDrawFont(playerid, create_p_td_model[playerid], 5);
	PlayerTextDrawSetProportional(playerid, create_p_td_model[playerid], 0);
	PlayerTextDrawSetShadow(playerid, create_p_td_model[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, create_p_td_model[playerid], 735555);
	PlayerTextDrawSetPreviewRot(playerid, create_p_td_model[playerid], 0.000000, 0.000000, 0.000000, 1.007151);

	create_p_td_name[playerid] = CreatePlayerTextDraw(playerid, 194.019119, 134.906661, "Benjamin_Forbes");
	PlayerTextDrawLetterSize(playerid, create_p_td_name[playerid], 0.192761, 0.951466);
	PlayerTextDrawAlignment(playerid, create_p_td_name[playerid], 2);
	PlayerTextDrawColor(playerid, create_p_td_name[playerid], 255);
	PlayerTextDrawSetShadow(playerid, create_p_td_name[playerid], 0);
	PlayerTextDrawSetOutline(playerid, create_p_td_name[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, create_p_td_name[playerid], 0);
	PlayerTextDrawFont(playerid, create_p_td_name[playerid], 1);
	PlayerTextDrawSetProportional(playerid, create_p_td_name[playerid], 1);
	PlayerTextDrawSetShadow(playerid, create_p_td_name[playerid], 0);

	create_p_td_origin[playerid] = CreatePlayerTextDraw(playerid, 316.685699, 134.906661, "Amerikietis");
	PlayerTextDrawLetterSize(playerid, create_p_td_origin[playerid], 0.192761, 0.951466);
	PlayerTextDrawAlignment(playerid, create_p_td_origin[playerid], 2);
	PlayerTextDrawColor(playerid, create_p_td_origin[playerid], 255);
	PlayerTextDrawSetShadow(playerid, create_p_td_origin[playerid], 0);
	PlayerTextDrawSetOutline(playerid, create_p_td_origin[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, create_p_td_origin[playerid], 0);
	PlayerTextDrawFont(playerid, create_p_td_origin[playerid], 1);
	PlayerTextDrawSetProportional(playerid, create_p_td_origin[playerid], 1);
	PlayerTextDrawSetShadow(playerid, create_p_td_origin[playerid], 0);

	create_p_td_answer[playerid][0] = CreatePlayerTextDraw(playerid, 269.828735, 160.079925, "Roleplay_tai_yra_zaidimo_tipas,_paremtas_tikrove.");
	PlayerTextDrawLetterSize(playerid, create_p_td_answer[playerid][0], 0.192761, 0.951466);
	PlayerTextDrawAlignment(playerid, create_p_td_answer[playerid][0], 1);
	PlayerTextDrawColor(playerid, create_p_td_answer[playerid][0], 255);
	PlayerTextDrawSetShadow(playerid, create_p_td_answer[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, create_p_td_answer[playerid][0], 1);
	PlayerTextDrawBackgroundColor(playerid, create_p_td_answer[playerid][0], 0);
	PlayerTextDrawFont(playerid, create_p_td_answer[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, create_p_td_answer[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, create_p_td_answer[playerid][0], 0);
	PlayerTextDrawSetSelectable(playerid, create_p_td_answer[playerid][0], false);

	create_p_td_answer[playerid][1] = CreatePlayerTextDraw(playerid, 270.209716, 215.873199, "MEtagame_powergame");
	PlayerTextDrawLetterSize(playerid, create_p_td_answer[playerid][1], 0.192761, 0.951466);
	PlayerTextDrawAlignment(playerid, create_p_td_answer[playerid][1], 1);
	PlayerTextDrawColor(playerid, create_p_td_answer[playerid][1], 255);
	PlayerTextDrawSetShadow(playerid, create_p_td_answer[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, create_p_td_answer[playerid][1], 1);
	PlayerTextDrawBackgroundColor(playerid, create_p_td_answer[playerid][1], 0);
	PlayerTextDrawFont(playerid, create_p_td_answer[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, create_p_td_answer[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, create_p_td_answer[playerid][1], 0);
	PlayerTextDrawSetSelectable(playerid, create_p_td_answer[playerid][1], false);

	create_p_td_answer[playerid][2] = CreatePlayerTextDraw(playerid, 270.971618, 271.339843, "Roleplay_nuo_grp");
	PlayerTextDrawLetterSize(playerid, create_p_td_answer[playerid][2], 0.192761, 0.951466);
	PlayerTextDrawAlignment(playerid, create_p_td_answer[playerid][2], 1);
	PlayerTextDrawColor(playerid, create_p_td_answer[playerid][2], 255);
	PlayerTextDrawSetShadow(playerid, create_p_td_answer[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, create_p_td_answer[playerid][2], 1);
	PlayerTextDrawBackgroundColor(playerid, create_p_td_answer[playerid][2], 0);
	PlayerTextDrawFont(playerid, create_p_td_answer[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, create_p_td_answer[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, create_p_td_answer[playerid][2], 0);
	PlayerTextDrawSetSelectable(playerid, create_p_td_answer[playerid][2], false);

	create_p_td_gender[playerid] = CreatePlayerTextDraw(playerid, 395.161834, 134.906661, "Moteris");
	PlayerTextDrawLetterSize(playerid, create_p_td_gender[playerid], 0.192761, 0.951466);
	PlayerTextDrawAlignment(playerid, create_p_td_gender[playerid], 2);
	PlayerTextDrawColor(playerid, create_p_td_gender[playerid], 255);
	PlayerTextDrawSetShadow(playerid, create_p_td_gender[playerid], 0);
	PlayerTextDrawSetOutline(playerid, create_p_td_gender[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, create_p_td_gender[playerid], 0);
	PlayerTextDrawFont(playerid, create_p_td_gender[playerid], 1);
	PlayerTextDrawSetProportional(playerid, create_p_td_gender[playerid], 1);
	PlayerTextDrawSetShadow(playerid, create_p_td_gender[playerid], 0);
}
