static enum Visuals_DialogLevels
{
	dLvlMarkColor[7],
	dLvlNormalColor[7],
	dLvlHighlightColor[7]
};
new 
	g_dg_DialogString[4096],
	g_dg_DialogLevel,
	g_dg_LevelOptions[3][Visuals_DialogLevels];

// #define dialog_Show(%1,%2,%3,%4,%5,%6)		Dialog_ShowCallback(%1,%2,%3,%4,g_dg_DialogString,%5,%6),g_dg_DialogString[0]=EOS
// native dialog_Show(playerid, Func:callback<ii>, title[], body[], b1[], b2[]) = Dialog_ShowCallback(padding, callback, title, g_dg_DialogString, b1, b2)

#define dialog_Row(%0)						if(strfind(YSI_g_sDialogInput,%0)!=-1)
#define dialog_EmptyLine()					if(strcmp(YSI_g_sDialogInput, " ") == 0)
#define dialog_AddLine 						dialog_SetBody
#define dialog_GetBody()					g_dg_DialogString
#define dialog_Input()						YSI_g_sDialogInput

stock dialog_Show(playerid, Func:callback<ii>, type, title[], b1[], b2[])
{
	return Dialog_ShowCallback(playerid, Func:callback<ii>, type, title, g_dg_DialogString, b1, b2);
}

stock dialog_AddErrorLine(text[])
{
	(strlen(text)) && dialog_AddLine("{d86666}%s[]", text);
}
stock dialog_Clear()
{
	format(g_dg_DialogString,1,""),
	dialog_SetLevel(0),
	dialog_SetLevelMarkColor(0,""),
	dialog_SetLevelNormalColor(0,""),
	dialog_SetLevelHighlightColor(0,"");
}

stock dialog_SetHeader(header[], va_args<>)
{
	replace_dialog_colors(header, 2024); // spalvu sutvarkymas
	va_format(g_dg_DialogString, 2024, header, va_start<1>);
}


stock dialog_SetBodyFlat(body[])
{
	format(g_dg_DialogString, 2024, body);
	return 1;
}
stock dialog_SetBody(line[], va_args<>)
{
	new 
		p_LineString[256];
	if(strlen(g_dg_DialogString) > 0) strcat(g_dg_DialogString, "\n");
	va_format(p_LineString, 256, line, va_start<1>);

	// pakeiciam spalvas
	replace_dialog_colors(p_LineString);

	// prijungiam
	strcat(g_dg_DialogString, p_LineString);
}

stock dialog_AddOption(mark[], option[], va_args<>)
{
	new 
		p_LineString[256];
	if(strlen(g_dg_DialogString) > 0) strcat(g_dg_DialogString, "\n");
	va_format(p_LineString, 256, option, va_start<2>);

	// pakeiciam [] ir [h] i normalias {asasdas} HEX spalvas
	replace_dialog_colors(p_LineString);

	if(g_dg_LevelOptions[g_dg_DialogLevel][dLvlMarkColor][0] != EOS && g_dg_LevelOptions[g_dg_DialogLevel][dLvlNormalColor][0] != EOS)
	{
		format(p_LineString, 256, "{%s}%s {%s}%s",  g_dg_LevelOptions[g_dg_DialogLevel][dLvlMarkColor], mark, g_dg_LevelOptions[g_dg_DialogLevel][dLvlNormalColor], p_LineString);
	}
	else 
	{
		format(p_LineString, 256, "%s %s", mark, p_LineString);
	}
	strcat(g_dg_DialogString, p_LineString);
}

stock dialog_SkipLine() 
{
	strcat(g_dg_DialogString, "\n ");
}

stock dialog_SetLevel(level) return (g_dg_DialogLevel = level);
stock dialog_SetLevelMarkColor(level, mark_color[]) format(g_dg_LevelOptions[level][dLvlMarkColor], 7, mark_color);
stock dialog_SetLevelNormalColor(level, normal_color[]) format(g_dg_LevelOptions[level][dLvlNormalColor], 7, normal_color);
stock dialog_SetLevelHighlightColor(level, highlight_color[]) format(g_dg_LevelOptions[level][dLvlHighlightColor], 7, highlight_color);

stock replace_dialog_colors(string[], size = sizeof(string))
{
	new hex[9];
	if(strlen(g_dg_LevelOptions[g_dg_DialogLevel][dLvlNormalColor]) > 0)
	{
		// pakeiciame [] i {NORMAL_COLOR}
		format(hex, 9, "{%s}", g_dg_LevelOptions[g_dg_DialogLevel][dLvlNormalColor]);
		strreplace(string, "[]", hex, .maxlength = size);
	} 
	else strreplace(string, "[]", "", .maxlength = size);
	if(strlen(g_dg_LevelOptions[g_dg_DialogLevel][dLvlHighlightColor]) > 0)
	{
		// [h] pakeiciam i {HIGHLIGHT_COLOR}
		format(hex, 9, "{%s}", g_dg_LevelOptions[g_dg_DialogLevel][dLvlHighlightColor]);
		strreplace(string, "[h]", hex, .maxlength = size);
	}
	else strreplace(string, "[h]", "", .maxlength = size);
	return 1;
}