new g_DbgLevel;

#define debug:%0(%1) 	if(g_DbgLevel >= %0) dbg(filename, %1)

stock dbg(const tag[], string[], va_args<>)
{
	new 
		_str[512],
		_tag_str[86];
	format(_tag_str, sizeof _tag_str, "[%s (%d)]: ", tag);
	va_format(_str, sizeof _str, string, va_start<3>);
	strins(_str, _tag_str, 0);
	printf(_str);
	return 1;
}

stock dbg_Level(level = -1)
{
	if(level != -1)
	{		
		g_DbgLevel = level;
	}
	return g_DbgLevel;
}