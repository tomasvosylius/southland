stock SendToAllExept(color, string[], ...)
{
	new
		args = numargs();
	foreach(Player, playerid)
	{
		for(new i = 3; i <= args; i++) if(i == playerid) { continue; }
		SendClientMessage(playerid, color, string);
	}
	return 1;
}
#define toupper(%0) (((%0) >= 'a' && (%0) <= 'z') ? ((%0) & ~0x20) : (%0))
#define tolower(%0) (((%0) >= 'A' && (%0) <= 'Z') ? ((%0) | 0x20) : (%0))
stock strtoupper(string[])
{
	new upperString[256];
	for (new character = 0; character < strlen(string); character++)
	{
		upperString[character] = toupper(string[character]);
	}
	return upperString;
}
stock strtolower(string[])
{
	new lowerString[256];
	for (new character = 0; character < strlen(string); character++)
	{
		lowerString[character] = tolower(string[character]);
	}
	return lowerString;
}

/*@sprintf_funcinc(); @sprintf_funcinc() format(!"", 0, !"");
stock sprintf(const fmat[], {Float, _}:...) 
{
	static output[256], frm_header[3];
	
	const output_size = sizeof(output);
	
	// Store current frame header
	#emit LCTRL      5
	#emit CONST.alt  frm_header
	#emit MOVS       12
	
	// Change the stack pointer to FRM + 12
	#emit ADD.C    12 // pri is FRM (see above)
	#emit SCTRL    4
	
	// Push sizeof(output)
	#emit PUSH.C      output_size
	
	// Push output
	#emit PUSH.C      output
	
	// Push the argument count
	#emit LOAD.S.pri  8
	#emit ADD.C       8
	#emit PUSH.pri
	
	// Call format
	#emit SYSREQ.C    format
	
	// Restore the stack pointer to FRM
	#emit LCTRL       5
	#emit SCTRL       4
	
	// Copy back the frame header
	#emit MOVE.alt
	#emit CONST.pri   frm_header
	#emit MOVS        12
	
	// IMPORTANT: Fix compiler bug (returning strings in variadic functions)
	#emit LOAD.S.pri  8
	#emit ADD.C       12
	#emit MOVE.alt
	#emit LCTRL       5
	#emit ADD
	#emit LOAD.I
	#emit STOR.S.pri  20 // 16 + (static_args * 4)
	
	return output;
	
	// It is actually used, just not by its symbol name
	#pragma unused fmat
}*/