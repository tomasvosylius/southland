new
	g_DialogString[2024];

#define dialog_Show(%0,%1,%2,%3,%4,%5) 	Dialog_ShowCallback(%0, %1, %2, %3, g_DialogString, %4, %5),g_DialogString[0] = EOS
#define dialog_Row(%0)					if(strfind(inputtext,%0) != -1)
#define dialog_Input() 					inputtext // YSI_g_sDialogFix
#define dialog_GetBody() 				g_DialogString
#define dialog_AddLine 					dialog_SetBody

stock dialog_SetHeader(header[], va_args<>)
{
	va_format(g_DialogString, 2024, header, va_start<1>);
}

stock dialog_SetBody(line[], va_args<>)
{
	new 
		p_LineString[256];
	if(strlen(g_DialogString) > 0) strcat(g_DialogString, "\n");
	va_format(p_LineString, 256, line, va_start<1>);
	strins(p_LineString, "\r", 0);
	strcat(g_DialogString, p_LineString);
}

stock dialog_AddOption(mark[], option[], va_args<>)
{
	new 
		p_LineString[256];
	if(strlen(g_DialogString) > 0) strcat(g_DialogString, "\n");
	va_format(p_LineString, 256, option, va_start<2>);
	format(p_LineString, 256, "\r%s %s", mark, p_LineString);
	strcat(g_DialogString, p_LineString);
}

stock dialog_SkipLine() 
{
	strcat(g_DialogString, "\n ");
}



/*

#define ShowDialog Dialog_ShowCallback

// Sets dialog header
stock SetDialogHeader(text[], va_args<>) {
	g_DialogHeader[0] = EOS;

	strcat(g_DialogHeader, "{2ecc71}");
	strcat(g_DialogHeader, text);

	va_formatex(g_DialogHeader, _, g_DialogHeader, va_start<1>);
	convert_colors(g_DialogHeader, "{2ecc71}");

	strcat(g_DialogHeader, "\n \n");

	// reset dialog body
	g_DialogBody[0] = EOS;
}

// Sets dialog body
stock SetDialogBody(text[], va_args<>) {
	g_DialogBody[0] = EOS;

	strcat(g_DialogBody, "[]");
	strcat(g_DialogBody, text);

	va_formatex(g_DialogBody, _, g_DialogBody, va_start<1>);
	convert_colors(g_DialogBody, "{ecf0f1}");

	AddDialogEmptyLine();
}

// Appends styled option line to dialog body
stock AddDialogOption(text[], va_args<>) {
	new sz_OptionText[100];

	strcat(sz_OptionText, "\n{2ecc71}» []");
	strcat(sz_OptionText, text);

	va_formatex(sz_OptionText, _, sz_OptionText, va_start<1>);
	convert_colors(sz_OptionText, "{ecf0f1}");

	strcat(g_DialogBody, sz_OptionText);
}

stock AddDialogEmptyLine() {
	strcat(g_DialogBody, "\n ");
}
*/