/*  ctype.inc (PAWN version of ctype.h for C)
 *
 *	Made and tested on version 3.2.3664 of the PAWN (SMALL) compiler.
 */
 
#if defined _ctype_included
	#endinput
#endif

#define _ctype_included

#if !defined _samp_included
	#tryinclude <a_samp>
#endif

stock isalnum(c)
{
    if ((c >= 0x30 && c <= 0x39) || (c >= 0x41 && c <= 0x5A) || (c >= 0x61 && c <= 0x7A)) return 1;
    else return 0;
}

stock isalpha(c)
{
	if ((c >= 0x41 && c <= 0x5A) || (c >= 0x61 && c <= 0x7A)) return 1;
	else return 0;
}

stock iscntrl(c)
{
	if ((c >= 0x00 && c <= 0x1F) || (c == 0x7F)) return 1;
	else return 0;
}

stock isdigit(c)
{
	if (c >= 0x30 && c <= 0x39) return 1;
	else return 0;
}

stock isgraph(c)
{
	if (c >= 0x21 && c <= 0x7E) return 1;
	else return 0;
}

stock islower(c)
{
	if (c >= 0x61 && c <= 0x7A) return 1;
	else return 0;
}

stock isprint(c)
{
	if (c >= 0x20 && c <= 0x7E) return 1;
	else return 0;
}

stock ispunct(c)
{
    if ((c >= 0x21 && c <= 0x2F) || (c >=0x3A && c <= 0x40) || (c >= 0x5B && c <= 0x60) || (c >= 0x7B && c <= 0x7E)) return 1;
    else return 0;
}

stock isspace(c)
{
	if ((c >= 0x09 && c <= 0x0D) || (c == 0x20)) return 1;
	else return 0;
}

stock isupper(c)
{
	if (c >= 0x41 && c <= 0x5A) return 1;
	else return 0;
}

stock isxdigit(c)
{
	if ((c >= 0x30 && c <= 0x39) || (c >= 0x41 && c <= 0x46) || (c >= 0x61 && c <= 0x66)) return 1;
	else return 0;
}

#if defined printf

stock cprintinf(c)
{
	printf("%c:\n\tisalnum? %d\n\tisalpha? %d\n\tiscntrl? %d\n\tisdigit? %d\n\tisgraph? %d\n\tislower? %d\n\tisprint? %d\n\tispunct? %d\n\tisspace? %d\n\tisupper? %d\n\tisxdigit? %d\n\n",
	            c, isalnum(c), isalpha(c), iscntrl(c), isdigit(c), isgraph(c), islower(c), isprint(c), ispunct(c), isspace(c), isupper(c), isxdigit(c));
}

#endif
