/*******************************************************************************************************************************
 ZCMD Improved (I-ZCMD)

 This include is just a re-make of the ZCMD Command Processor ( V0.3.1 31/10/2009) originnaly developed by Zeex.

 Version:0.2.2

 Credits:
 Yashas - speed improvements.
 hldev - help text system, command shifter.
 Zeex - first original release.
*******************************************************************************************************************************/
#if defined _I_ZCMD_INCLUDED_V0_2_2_
	#endinput
#endif	
#define _I_ZCMD_INCLUDED_V0_2_2_
/******************************************************************************************************************************/
#define MAX_FUNC_NAME (32)

#define CMD:%1(%2,%3) \
			forward cmd_%1(%2,%3); \
			public cmd_%1(%2,%3)	

#define CMD_SUCCESS 1
#define CMD_FAILURE 0


#define COMMAND_HELP_UNDEFINED() if(help) return SendClientMessage(playerid,-1,HELP_TEXT_UNDEFINED)
#define COMMAND_HELP_ERROR() if(help) return 1
#define COMMAND_HELP_TEXT(%0) if(help) return SendClientMessage(playerid,-1,%0)

#define SHIFT_CMD:%0->%1; CMD:%0(playerid, params[], help) return cmd_%1(playerid, params, help);

#if !defined isnull
        #define isnull(%1) ((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))
#endif
/******************************************************************************************************************************/
#if defined OnPlayerCommandReceived
	forward OnPlayerCommandReceived(playerid,cmdtext[]);
#endif
#if defined OnPlayerCommandPerformed
	forward OnPlayerCommandPerformed(playerid,cmdtext[], success);
#endif
/******************************************************************************************************************************/
public OnPlayerCommandText(playerid, cmdtext[])
{
	#if defined OnPlayerCommandReceived
	    if(!OnPlayerCommandReceived(playerid,cmdtext)) return 1;
	#endif
	static funcname[MAX_FUNC_NAME] = "cmd_";
	
    new pos = 1;

	while(cmdtext[pos] > ' ')
		if(cmdtext[pos] == '_') funcname[pos++ + 3] = '_';
		else funcname[pos+3] = cmdtext[pos++] | 0x20;

	funcname[pos+3] = 0;

    while (cmdtext[pos] == ' ') pos++;
	if(cmdtext[pos])
	{
  		#if defined OnPlayerCommandPerformed
			return OnPlayerCommandPerformed(playerid,cmdtext,CallLocalFunction(funcname,"dsd",playerid,cmdtext[pos],0));
		#else
			return CallLocalFunction(funcname,"dsd",playerid,cmdtext[pos],0);
		#endif
	}
	else
	{
	   	#if defined OnPlayerCommandPerformed // Jeigu yra public sitas callbackas, iskvieciam ji.
			return OnPlayerCommandPerformed(playerid,cmdtext,CallLocalFunction(funcname,"dsd",playerid,"\r",0));
		#else
			return CallLocalFunction(funcname,"dsd",playerid,"\r",0);
		#endif
	}
}
#if defined _ALS_OnPlayerCommandText
    #undef OnPlayerCommandText
#else
    #define _ALS_OnPlayerCommandText
#endif
#define OnPlayerCommandText izcmd_OnPlayerCommandText
forward izcmd_OnPlayerCommandText(playerid, cmdtext[]);