#include <YSI\y_hooks>
#include <YSI\y_als>

#define LIMIT_OF_PLAYER_TEXT_DRAWS 350
static stock _G(n, p) return (n >> (4 * p)) & 0xF;
static stock _S(&n, p, v) { n = n & ~(0xF << (p * 4)) | (v << (p * 4)); }

#define M_VAL -0xABCDEF
#define M_COMPRESSED_VAL 15

enum { // Compressed data
	/*
	 * Server data
	 */
	epTD_Active,
	/*
	 * SA-MP data
	 */
	epTD_Alignment,
	epTD_UseBox,
	epTD_Shadow,
	epTD_Outline,
	epTD_Proportional,
	epTD_Selectable,
	epTD_Font
};

enum ePlayerTextDrawProperties {
	/*
	 * Server data
	 */
	PlayerText:epTD_SAMP_ID,
	/*
	 * SA-MP data
	 */
	Float:epTD_Position_X,
	Float:epTD_Position_Y,
	Float:epTD_LetterSize_X,
	Float:epTD_LetterSize_Y,
	Float:epTD_TextSize_X,
	Float:epTD_TextSize_Y,

	Float:epTD_PreviewRot_X,
	Float:epTD_PreviewRot_Y,
	Float:epTD_PreviewRot_Z,
	Float:epTD_Preview_Zoom,

	bool:epTD_Perm,

	epTD_Type,
	epTD_Color,
	epTD_BoxColor,
	epTD_BackgroundColor,
	epTD_PreviewModel,
	epTD_PreviewVehCol_1,
	epTD_PreviewVehCol_2
};

new pTextDraws_Compressed[MAX_PLAYERS][LIMIT_OF_PLAYER_TEXT_DRAWS];
new pTextDraws_String[MAX_PLAYERS][LIMIT_OF_PLAYER_TEXT_DRAWS][256 char];

new pTextDraws[MAX_PLAYERS][LIMIT_OF_PLAYER_TEXT_DRAWS][ePlayerTextDrawProperties];

new TextDrawTypes[1024];

stock PlayerText:pTD_GetIdx(playerid) {
	for(new i; i < sizeof pTextDraws[]; ++i) {
		if( ! _G(pTextDraws_Compressed[playerid][i], epTD_Active)) {
			return PlayerText:i;
		}
	}
	return PlayerText:INVALID_TEXT_DRAW;
}

stock Text:TD_Create(Float:x, Float:y, text[], type[] = "")
{
	new 
		type_int32 = strval(type) > 0 ? td_strint(type, -1) : 0,
		Text:txd;
	txd = TextDrawCreate(x, y, text);
	TextDrawTypes[_:txd] = type_int32;

	return txd;
}

stock TextDrawHideForPlayerType(playerid, type[])
{
	new type_int32 = strlen(type) > 0 ? td_strint(type, -1) : 0;
	for(new td; td < 1024; td++)
	{
		if(TextDrawTypes[td] == type_int32) {
			TextDrawHideForPlayer(playerid, Text:td);
		}
	}
	return true;
}

stock TextDrawShowForPlayerType(playerid, type[])
{
	new type_int32 = td_strint(type, -1);
	for(new td; td < 1024; td++)
	{
		printf("[%d]: type %d looking ", TextDrawTypes[td], type_int32);
		if(TextDrawTypes[td] == type_int32) {
			TextDrawShowForPlayer(playerid, Text:td);
		}
	}
	return true;
}

stock PlayerText:pTD_Create(playerid, Float:x, Float:y, text[], type[] = "", bool:perm = false) {
	new PlayerText:idx = pTD_GetIdx(playerid);
	if(idx == PlayerText:INVALID_TEXT_DRAW) {
		printf("[error] pTD_Create(%s) limit reached!", text);
		//SendCriticalError(playerid, "PTDGETIDX graþino neteisingà reikðmæ", "65535");
		return PlayerText:INVALID_TEXT_DRAW;
	}
	pTextDraws[playerid][_:idx][epTD_SAMP_ID] = (perm ? (CreatePlayerTextDraw(playerid, x, y, text)) : (PlayerText:INVALID_TEXT_DRAW));
	pTextDraws[playerid][_:idx][epTD_Perm] = perm;
	_S(pTextDraws_Compressed[playerid][_:idx], epTD_Active, 1);
	if(!perm)
	{
		_S(pTextDraws_Compressed[playerid][_:idx], epTD_UseBox, M_COMPRESSED_VAL);
		_S(pTextDraws_Compressed[playerid][_:idx], epTD_Shadow, M_COMPRESSED_VAL);
		_S(pTextDraws_Compressed[playerid][_:idx], epTD_Outline, M_COMPRESSED_VAL);
		_S(pTextDraws_Compressed[playerid][_:idx], epTD_Font, M_COMPRESSED_VAL);
		_S(pTextDraws_Compressed[playerid][_:idx], epTD_Proportional, M_COMPRESSED_VAL);
		_S(pTextDraws_Compressed[playerid][_:idx], epTD_Selectable, M_COMPRESSED_VAL);
		_S(pTextDraws_Compressed[playerid][_:idx], epTD_Alignment, M_COMPRESSED_VAL);
		pTextDraws[playerid][_:idx][epTD_Position_X] = x;
		pTextDraws[playerid][_:idx][epTD_Position_Y] = y;
		pTextDraws[playerid][_:idx][epTD_LetterSize_X] = M_VAL;
		pTextDraws[playerid][_:idx][epTD_LetterSize_Y] = M_VAL;
		pTextDraws[playerid][_:idx][epTD_TextSize_X] = M_VAL;
		pTextDraws[playerid][_:idx][epTD_TextSize_Y] = M_VAL;
		pTextDraws[playerid][_:idx][epTD_Color] = M_VAL;
		pTextDraws[playerid][_:idx][epTD_BoxColor] = M_VAL;
		pTextDraws[playerid][_:idx][epTD_BackgroundColor] = M_VAL;
		pTextDraws[playerid][_:idx][epTD_PreviewModel] = M_VAL;
		pTextDraws[playerid][_:idx][epTD_PreviewRot_X] = M_VAL;
		pTextDraws[playerid][_:idx][epTD_PreviewRot_Y] = M_VAL;
		pTextDraws[playerid][_:idx][epTD_PreviewRot_Z] = M_VAL;
		pTextDraws[playerid][_:idx][epTD_Preview_Zoom] = 1.0;
		if(strlen(type) > 0) pTextDraws[playerid][_:idx][epTD_Type] = td_strint(type, -1);
		else pTextDraws[playerid][_:idx][epTD_Type] = 0;
		pTextDraws[playerid][_:idx][epTD_PreviewVehCol_1] = M_VAL;
		pTextDraws[playerid][_:idx][epTD_PreviewVehCol_2] = M_VAL;
		strpack(pTextDraws_String[playerid][_:idx], text);
	}
	//printf("PTD CREATED [%d]: %s", _:idx, text);
	return idx;
}


stock pTD_Destroy(playerid, PlayerText:text) {
	if(text == PlayerText:INVALID_TEXT_DRAW) return false;
	if(pTextDraws[playerid][_:text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawDestroy(playerid, PlayerText:pTextDraws[playerid][_:text][epTD_SAMP_ID]);
	}
    _S(pTextDraws_Compressed[playerid][_:text], epTD_Active, 0);
	new _reset[ePlayerTextDrawProperties];
    pTextDraws[playerid][_:text] = _reset;
	return true;
}

stock pTD_LetterSize(playerid, PlayerText:text, Float:x, Float:y) {
	if(text == PlayerText:INVALID_TEXT_DRAW) return false;
	if(!pTextDraws[playerid][_:text][epTD_Perm])
	{
		pTextDraws[playerid][_:text][epTD_LetterSize_X] = x;
		pTextDraws[playerid][_:text][epTD_LetterSize_Y] = y;
	}
	if(pTextDraws[playerid][_:text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawLetterSize(playerid, PlayerText:pTextDraws[playerid][_:text][epTD_SAMP_ID], x, y);
	}
	return true;
}

stock pTD_TextSize(playerid, PlayerText:text, Float:x, Float:y) {
	if(text == PlayerText:INVALID_TEXT_DRAW) return false;
	if(!pTextDraws[playerid][_:text][epTD_Perm])
	{
		pTextDraws[playerid][_:text][epTD_TextSize_X] = x;
		pTextDraws[playerid][_:text][epTD_TextSize_Y] = y;
	}
	if(pTextDraws[playerid][_:text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawTextSize(playerid, PlayerText:pTextDraws[playerid][_:text][epTD_SAMP_ID], x, y);
	}
	return true;
}

stock pTD_Alignment(playerid, PlayerText:text, alignment) {
	if(text == PlayerText:INVALID_TEXT_DRAW) return false;
	if(!pTextDraws[playerid][_:text][epTD_Perm])
	{
		_S(pTextDraws_Compressed[playerid][_:text], epTD_Alignment, alignment);
	}
	if(pTextDraws[playerid][_:text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawAlignment(playerid, PlayerText:pTextDraws[playerid][_:text][epTD_SAMP_ID], alignment);
	}
	return true;
}

stock pTD_Color(playerid, PlayerText:text, color) {
	if(text == PlayerText:INVALID_TEXT_DRAW) return false;
	if(!pTextDraws[playerid][_:text][epTD_Perm])
	{
		pTextDraws[playerid][_:text][epTD_Color] = color;
	}
	if(pTextDraws[playerid][_:text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawColor(playerid, PlayerText:pTextDraws[playerid][_:text][epTD_SAMP_ID], color);
	}
	return true;
}

stock pTD_UseBox(playerid, PlayerText:text, use) {
	if(text == PlayerText:INVALID_TEXT_DRAW) return false;
	if(!pTextDraws[playerid][_:text][epTD_Perm])
	{
		_S(pTextDraws_Compressed[playerid][_:text], epTD_UseBox, use);
	}
	if(pTextDraws[playerid][_:text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawUseBox(playerid, PlayerText:pTextDraws[playerid][_:text][epTD_SAMP_ID], use);
	}
	return true;
}

stock pTD_BoxColor(playerid, PlayerText:text, color) {
	if(text == PlayerText:INVALID_TEXT_DRAW) return false;
	if(!pTextDraws[playerid][_:text][epTD_Perm])
	{
		pTextDraws[playerid][_:text][epTD_BoxColor] = color;
	}
	if(pTextDraws[playerid][_:text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawBoxColor(playerid, PlayerText:pTextDraws[playerid][_:text][epTD_SAMP_ID], color);
	}
	return true;
}

stock pTD_SetShadow(playerid, PlayerText:text, size) {
	if(text == PlayerText:INVALID_TEXT_DRAW) return false;
	if(!pTextDraws[playerid][_:text][epTD_Perm])
	{
		_S(pTextDraws_Compressed[playerid][_:text], epTD_Shadow, size);
	}
	if(pTextDraws[playerid][_:text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawSetShadow(playerid, PlayerText:pTextDraws[playerid][_:text][epTD_SAMP_ID], size);
	}
	return true;
}

stock pTD_SetOutline(playerid, PlayerText:text, size) {
	if(text == PlayerText:INVALID_TEXT_DRAW) return false;
	if(!pTextDraws[playerid][_:text][epTD_Perm])
	{
		_S(pTextDraws_Compressed[playerid][_:text], epTD_Outline, size);
	}
	if(pTextDraws[playerid][_:text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawSetOutline(playerid, PlayerText:pTextDraws[playerid][_:text][epTD_SAMP_ID], size);
	}
	return true;
}

stock pTD_BackgroundColor(playerid, PlayerText:text, color) {
	if(text == PlayerText:INVALID_TEXT_DRAW) return false;
	if(!pTextDraws[playerid][_:text][epTD_Perm])
	{
		pTextDraws[playerid][_:text][epTD_BackgroundColor] = color;
	}
	if(pTextDraws[playerid][_:text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawBackgroundColor(playerid, PlayerText:pTextDraws[playerid][_:text][epTD_SAMP_ID], color);
	}
	return true;
}

stock pTD_Font(playerid, PlayerText:text, font) {
	if(text == PlayerText:INVALID_TEXT_DRAW) return false;
	if(!pTextDraws[playerid][_:text][epTD_Perm])
	{
		_S(pTextDraws_Compressed[playerid][_:text], epTD_Font, font);
	}
	if(pTextDraws[playerid][_:text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawFont(playerid, PlayerText:pTextDraws[playerid][_:text][epTD_SAMP_ID], font);
	}
	return true;
}

stock pTD_SetProportional(playerid, PlayerText:text, set) {
	if(text == PlayerText:INVALID_TEXT_DRAW) return false;
	if(!pTextDraws[playerid][_:text][epTD_Perm])
	{
		_S(pTextDraws_Compressed[playerid][_:text], epTD_Proportional, set);
	}
	if(pTextDraws[playerid][_:text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawSetProportional(playerid, PlayerText:pTextDraws[playerid][_:text][epTD_SAMP_ID], set);
	}
	return true;
}

stock pTD_SetSelectable(playerid, PlayerText:text, set) {
	if(text == PlayerText:INVALID_TEXT_DRAW) return false;
	if(!pTextDraws[playerid][_:text][epTD_Perm])
	{
		_S(pTextDraws_Compressed[playerid][_:text], epTD_Selectable, set);
	}
	if(pTextDraws[playerid][_:text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawSetSelectable(playerid, PlayerText:pTextDraws[playerid][_:text][epTD_SAMP_ID], set);
	}
	return true;
}


stock pTD_Show(playerid, PlayerText:text) {
	if(text == PlayerText:INVALID_TEXT_DRAW) return false;
	#define __TD pTextDraws[playerid][_:text]
	if(!__TD[epTD_Perm])
	{
		if(pTextDraws[playerid][_:text][epTD_SAMP_ID] == PlayerText:INVALID_TEXT_DRAW) {
			new unpackedString[256];
			strunpack(unpackedString, pTextDraws_String[playerid][_:text]);
	
			pTextDraws[playerid][_:text][epTD_SAMP_ID] = CreatePlayerTextDraw(
				playerid,
				pTextDraws[playerid][_:text][epTD_Position_X], 
				pTextDraws[playerid][_:text][epTD_Position_Y], 
				unpackedString
			);
		}
		if(__TD[epTD_LetterSize_X] != M_VAL) {
			pTD_LetterSize(playerid, text, __TD[epTD_LetterSize_X], __TD[epTD_LetterSize_Y]);
		}
		if(__TD[epTD_TextSize_X] != M_VAL) {
			pTD_TextSize(playerid, text, __TD[epTD_TextSize_X], __TD[epTD_TextSize_Y]);
		}
		if(_G(pTextDraws_Compressed[playerid][_:text], epTD_Alignment) != M_COMPRESSED_VAL) {
			pTD_Alignment(playerid, text, _G(pTextDraws_Compressed[playerid][_:text], epTD_Alignment));
		}
		if(__TD[epTD_Color] != M_VAL) {
			pTD_Color(playerid, text, __TD[epTD_Color]);
		}
		if(_G(pTextDraws_Compressed[playerid][_:text], epTD_UseBox) != M_COMPRESSED_VAL) {
			pTD_UseBox(playerid, text, _G(pTextDraws_Compressed[playerid][_:text], epTD_UseBox));
		}
		if(__TD[epTD_BoxColor] != M_VAL) {
			pTD_BoxColor(playerid, text, __TD[epTD_BoxColor]);
		}
		if(_G(pTextDraws_Compressed[playerid][_:text], epTD_Shadow) != M_COMPRESSED_VAL) {
			pTD_SetShadow(playerid, text, _G(pTextDraws_Compressed[playerid][_:text], epTD_Shadow));
		}
		if(_G(pTextDraws_Compressed[playerid][_:text], epTD_Outline) != M_COMPRESSED_VAL) {
			pTD_SetOutline(playerid, text, _G(pTextDraws_Compressed[playerid][_:text], epTD_Outline));
		}
		if(__TD[epTD_BackgroundColor] != M_VAL) {
			pTD_BackgroundColor(playerid, text, __TD[epTD_BackgroundColor]);
		}
		if(_G(pTextDraws_Compressed[playerid][_:text], epTD_Font) != M_COMPRESSED_VAL) {
			pTD_Font(playerid, text, _G(pTextDraws_Compressed[playerid][_:text], epTD_Font));
		}
		if(_G(pTextDraws_Compressed[playerid][_:text], epTD_Proportional) != M_COMPRESSED_VAL) {
			pTD_SetProportional(playerid, text, _G(pTextDraws_Compressed[playerid][_:text], epTD_Proportional));
		}
		if(_G(pTextDraws_Compressed[playerid][_:text], epTD_Selectable) != M_COMPRESSED_VAL) {
			pTD_SetSelectable(playerid, text, _G(pTextDraws_Compressed[playerid][_:text], epTD_Selectable));
		}
		if(__TD[epTD_PreviewModel] != M_VAL) {
			pTD_SetPreviewModel(playerid, text, __TD[epTD_PreviewModel]);
		}
		if(__TD[epTD_PreviewRot_X] != M_VAL) {
			pTD_SetPreviewRot(playerid, text, __TD[epTD_PreviewRot_X], __TD[epTD_PreviewRot_Y], __TD[epTD_PreviewRot_Z], __TD[epTD_Preview_Zoom]);
		}
		if(__TD[epTD_PreviewVehCol_1] != M_VAL) {
			pTD_SetPreviewVehCol(playerid, text, __TD[epTD_PreviewVehCol_1], __TD[epTD_PreviewVehCol_2]);
		}
	}
	#undef __TD
	return PlayerTextDrawShow(playerid, PlayerText:pTextDraws[playerid][_:text][epTD_SAMP_ID]);
}

stock pTD_Hide(playerid, PlayerText:text) {
	if(text == PlayerText:INVALID_TEXT_DRAW) return false;
	if(pTextDraws[playerid][_:text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		if(!pTextDraws[playerid][_:text][epTD_Perm])
		{
			PlayerTextDrawDestroy(playerid, PlayerText:pTextDraws[playerid][_:text][epTD_SAMP_ID]);
			pTextDraws[playerid][_:text][epTD_SAMP_ID] = PlayerText:INVALID_TEXT_DRAW;
		}
		else
		{
			PlayerTextDrawHide(playerid, PlayerText:pTextDraws[playerid][_:text][epTD_SAMP_ID]);
		}
	}
	return true;
}

stock PlayerTextDrawSetType(playerid, PlayerText:text, type[]) 
{
	if(text == PlayerText:INVALID_TEXT_DRAW) return false;
	if(pTextDraws[playerid][_:text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		new type_int32 = strlen(type) > 0 ? td_strint(type, -1) : 0;
		pTextDraws[playerid][_:text][epTD_Type] = type_int32;
	}
	return true;
}

stock PlayerTextDrawSetSelectableType(playerid, type[], bool:selectable)
{
	new type_int32 = strlen(type) > 0 ? td_strint(type, -1) : 0;
	for(new td; td < LIMIT_OF_PLAYER_TEXT_DRAWS; td++)
	{
		if(pTextDraws[playerid][td][epTD_Type] == type_int32) {
			pTD_SetSelectable(playerid, PlayerText:pTextDraws[playerid][td][epTD_SAMP_ID], selectable);
		}
	}
	return true;
}

stock PlayerTextDrawDestroyType(playerid, type[])
{
	new type_int32 = strlen(type) > 0 ? td_strint(type, -1) : 0;
	for(new td; td < LIMIT_OF_PLAYER_TEXT_DRAWS; td++)
	{
		if(pTextDraws[playerid][td][epTD_Type] == type_int32) {
			pTD_Destroy(playerid, PlayerText:pTextDraws[playerid][td][epTD_SAMP_ID]);
		}
	}
	return true;
}

stock PlayerTextDrawHideType(playerid, type[]) 
{
	new type_int32 = strlen(type) > 0 ? td_strint(type, -1) : 0;
	for(new td; td < LIMIT_OF_PLAYER_TEXT_DRAWS; td++)
	{
		if(pTextDraws[playerid][td][epTD_Type] == type_int32) {
			pTD_Hide(playerid, PlayerText:pTextDraws[playerid][td][epTD_SAMP_ID]);
		}
	}
	return true;
}

stock PlayerTextDrawShowType(playerid, type) 
{
	new type_int32 = strlen(type) > 0 ? td_strint(type, -1) : 0;
	for(new td; td < LIMIT_OF_PLAYER_TEXT_DRAWS; td++)
	{
		if(pTextDraws[playerid][td][epTD_Type] == type_int32) {
			pTD_Show(playerid, PlayerText:pTextDraws[playerid][td][epTD_SAMP_ID]);
		}
	}
	return true;
}

stock pTD_SetString(playerid, PlayerText:text, string[]) {
	if(text == PlayerText:INVALID_TEXT_DRAW) return false;
	strpack(pTextDraws_String[playerid][_:text], string);
	if(pTextDraws[playerid][_:text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawSetString(playerid, PlayerText:pTextDraws[playerid][_:text][epTD_SAMP_ID], string);
	}
	return true;
}

stock pTD_SetPreviewModel(playerid, PlayerText:text, modelindex) {
	if(text == PlayerText:INVALID_TEXT_DRAW) return false;
	pTextDraws[playerid][_:text][epTD_PreviewModel] = modelindex;
	if(pTextDraws[playerid][_:text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawSetPreviewModel(playerid, PlayerText:pTextDraws[playerid][_:text][epTD_SAMP_ID], modelindex);
	}
	return true;
}

stock pTD_SetPreviewRot(playerid, PlayerText:text, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fZoom = 1.0) {
	if(text == PlayerText:INVALID_TEXT_DRAW) return false;
	pTextDraws[playerid][_:text][epTD_PreviewRot_X] = fRotX;
	pTextDraws[playerid][_:text][epTD_PreviewRot_Y] = fRotY;
	pTextDraws[playerid][_:text][epTD_PreviewRot_Z] = fRotZ;
	pTextDraws[playerid][_:text][epTD_Preview_Zoom] = fZoom;
	if(pTextDraws[playerid][_:text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawSetPreviewRot(playerid, PlayerText:pTextDraws[playerid][_:text][epTD_SAMP_ID], fRotX, fRotY, fRotZ, fZoom);
	}
	return true;
}

stock pTD_SetPreviewVehCol(playerid, PlayerText:text, color1, color2) {
	if(text == PlayerText:INVALID_TEXT_DRAW) return false;
	pTextDraws[playerid][_:text][epTD_PreviewVehCol_1] = color1;
	pTextDraws[playerid][_:text][epTD_PreviewVehCol_2] = color2;
	if(pTextDraws[playerid][_:text][epTD_SAMP_ID] != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawSetPreviewVehCol(playerid, PlayerText:pTextDraws[playerid][_:text][epTD_SAMP_ID], color1, color2);
	}
	return true;
}


stock pTD_SetTextDrawPos(playerid, PlayerText:text, Float:x, Float:y)
{
	pTextDraws[playerid][_:text][epTD_Position_X] = x;
	pTextDraws[playerid][_:text][epTD_Position_Y] = y;
	return true;
}


public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid) 
{
	for(new i; i < sizeof pTextDraws[]; ++i) 
	{
		if(pTextDraws[playerid][i][epTD_SAMP_ID] == playertextid) 
		{
			#if defined OnPlayerClickPTextDraw
				OnPlayerClickPTextDraw(playerid, PlayerText:i);
			#else
				CallLocalFunction("OnPlayerClickPTextDraw", "dd", playerid, i);
			#endif
			break;
		}
	}
}

stock td_strint(array[], size = sizeof array)
{
	// f0cus
    new 
        int;
    if(size <= 0) size = strlen(array);
    for(new i = 0; i < size; i++) int += array[i] + ((array[i]+i)^2);
    return int;
}

#define TextDrawCreate TD_Create
#define CreatePlayerTextDraw pTD_Create
#define PlayerTextDrawDestroy pTD_Destroy
#define PlayerTextDrawLetterSize pTD_LetterSize
#define PlayerTextDrawTextSize pTD_TextSize
#define PlayerTextDrawAlignment pTD_Alignment
#define PlayerTextDrawColor pTD_Color
#define PlayerTextDrawUseBox pTD_UseBox
#define PlayerTextDrawBoxColor pTD_BoxColor
#define PlayerTextDrawSetShadow pTD_SetShadow
#define PlayerTextDrawSetOutline pTD_SetOutline
#define PlayerTextDrawBackgroundColor pTD_BackgroundColor
#define PlayerTextDrawFont pTD_Font
#define PlayerTextDrawSetProportional pTD_SetProportional
#define PlayerTextDrawSetSelectable pTD_SetSelectable
#define PlayerTextDrawShow pTD_Show
#define PlayerTextDrawHide pTD_Hide
#define PlayerTextDrawSetString pTD_SetString
#define PlayerTextDrawSetPreviewModel pTD_SetPreviewModel
#define PlayerTextDrawSetPreviewRot pTD_SetPreviewRot
#define PlayerTextDrawSetPreviewVehCol pTD_SetPreviewVehCol
#define PlayerTextDrawSetPosition pTD_SetTextDrawPos




