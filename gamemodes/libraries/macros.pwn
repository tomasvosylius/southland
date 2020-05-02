#define set_filename(%0) 				new const UNIQUE_FUNCTION<p_FileName...>[54] = %0; forward UNIQUE_FUNCTION<p_FileFunction...>(); public UNIQUE_FUNCTION<p_FileFunction...>() return 1
#define filename 	 	 				UNIQUE_FUNCTION<p_FileName...>

#define DURATION_MS(%1)     			(DURATION(%1) * 1000)
#define DURATION(%1)        			(DURATION_PT:%1,0)
#define DURATION_PT:%1,     			(%1:DURATION)+_:DURATION_PT:

#define second%1:DURATION
#define seconds%1:DURATION
#define minute%1:DURATION   			* DURATION_MINUTE
#define minutes%1:DURATION  			* DURATION_MINUTE
#define hour%1:DURATION     			* DURATION_HOUR
#define hours%1:DURATION    			* DURATION_HOUR
#define day%1:DURATION      			* DURATION_DAY
#define days%1:DURATION     			* DURATION_DAY
#define week%1:DURATION     			* DURATION_WEEK
#define weeks%1:DURATION    			* DURATION_WEEK
#define month%1:DURATION    			* DURATION_MONTH
#define months%1:DURATION   			* DURATION_MONTH
#define year%1:DURATION     			* DURATION_YEAR
#define years%1:DURATION    			* DURATION_YEAR 

#define ReturnPlayerHealth(%0)	 		(GetPlayerHealth((%0), Float:I@), Float:I@)
#define ReturnPlayerArmour(%0)			(GetPlayerArmour((%0), Float:I@), Float:I@)
#define ReturnLocationName(%0,%1) 		(GetCoords2DZone((%0),(%1),Q@,32), Q@) 								


// ==============================================================================
// Macro funkcijos
#define SendACMessage(%0,%1,%2); 			foreach(new __internalPlayerid : Player){\
												if(ChatsOff[__internalPlayerid][ACChat]==0 ||%1==true){\
													SendFormat(__internalPlayerid,%0,%2);\
												}\
											}
#define SendAdminMessage(%0,%1,%2);			foreach(new __internalPlayerid : Player){\
												if((ChatsOff[__internalPlayerid][AdminChat]==0||%1==true) && IsPlayerInAnyAdminGroup(__internalPlayerid)>0) {\
													SendFormat(__internalPlayerid,%0,%2); \
												}\
											}
#define SendFactionMessage(%3,%0,%1,%2);	foreach(new __internalPlayerid : Player) {\
												if((ChatsOff[__internalPlayerid][FactionChat]==0||%1==true) && PlayerInfo[__internalPlayerid][pFaction]==%3){\
													SendChatMessage(__internalPlayerid,%0,%2); \
												}\
											}
#define SendFactionTypeMessage(%3,%0,%1,%2); 	foreach(new __internalPlayerid : Player) {\
													if(ChatsOff[__internalPlayerid][FactionChat]==0||%1==true){\
														new __f = GetFactionArrayIndexById(PlayerInfo[__internalPlayerid][pFaction]);\
														if(__f!=-1&&FactionInfo[__f][fType]==%3) {\
															SendFormat(__internalPlayerid,%0,%2);\
														}\
													}\
												}		
#define SendToBroadcasters(%0,%1);			foreach(new __internalPlayerid : Player) {\
												if(player_Broadcast[__internalPlayerid]) {\
													SendFormat(__internalPlayerid,%0,%1);\
												}\
											}					
#define SendBroadcast(%0,%1); 				foreach(new __internalPlayerid : Player) {\
												if(!ChatsOff[__internalPlayerid][BroadcastChat]) {\
													SendChatMessage(__internalPlayerid,%0,%1);\
												}\
											}

#define reset(%0,%1,%2) 					new _rV_%0[%2];\
											%1 = _rV_%0
#define KickEx(%0)							SetTimerEx("Kicker", 100, false, "d", %0)
/** Server vars **/
#define SetGVarFloatEx(%0,%1,%2)			SetGVarFloat(%0,%1,%2) , SaveServerFloatEx(%0,%1)
#define SetGVarIntEx(%0,%1,%2)				SetGVarInt(%0,%1,%2) , SaveServerIntEx(%0,%1)
/** Chat **/
#define SendFormat							va_SendClientMessage
#define SendFormatToAll						va_SendClientMessageToAll
#define SendUsage(%0,%1)					SendFormat(%0,0xBABABAFF,"Naudojimas: {E4E4E4}"%1)
#define SendWarning(%0,%1) 					MsgWarning(%0,"Perspëjimas", %1)
#define SendError(%0,%1)					MsgError(%0,"Klaida",%1)
#define SendCommands(%0,%1)					SendFormat(%0,0xBABABAFF,"Komandos: {E4E4E4}"%1)
#define MsgDefault(%0,%1,%2)				SendFormat(%0,0x2A8AD8FF,%1": {66A8DF}"%2)
#define MsgSuccess(%0,%1,%2)				SendFormat(%0,0xA3D252FF,%1": {BFDF88}"%2)
#define MsgWarning(%0,%1,%2)				SendFormat(%0,0xD7864BFF,%1": {E5A170}"%2)
#define MsgError(%0,%1,%2)					SendFormat(%0,0xD94848FF,%1": {E86F6F}"%2)
#define MsgInfo(%0,%1,%2)					SendFormat(%0,0xE4E4E4FF,%1": {DDDDDD}"%2)
#define MsgImportant(%0,%1,%2)				SendFormat(%0,0xB0CF4CFF,%1": {C5DE74}"%2)
/** Others **/
#define TOS(%0,%1,%2) 						(%0 ? (%1) : (%2))
#define ClearChat(%0,%1)					for(new c=0;c<%1;c++) SendClientMessage(%0,-1,"")
#define mysql_fquery(%0,%1,%2)				mysql_tquery(%0,%1,"sdev__"%2)
#define thread(%0) 							forward sdev__%0(); \
											public sdev__%0() return 1
#define forwarded%0\10;%1 					forward %0; \
											public %0

#define LogPlayerId(%0)						PlayerInfo[%0][pId]
#define LogPlayerName(%0) 					PlayerInfo[%0][pName]
#define IsValueInBetween(%0,%1,%2) 			(%0 <= %1 <= %2)
#define SortEnumArray(%0,%1,%2,%3,%4,%5,%6); for(new i = %1; i < %2; i++) { if(%0[i]%3 == %4) { for(new x = i+1; x < %2; x++) { if(%0[x]%3 != %4) { new __reset[%5]; %0[i] = %0[x]; %0[x] = __reset; if(%6) { %0[x]%3 = %4; } break; } } } }

#define GetSortedAsForeach(%0,%1,%2,%3);	new index,e_index;\
										 	foreach(new loopindex : %0) { if(%3) { if(index == %1) { %2 = loopindex; break; } else { index++; } e_index++; } }
										 	//foreach(new loopindex : %0) { if(index == %1 && %3) { %2 = loopindex; break; } else if(%3) { index++; } }

#define ShowESCTextdraw(%0,%1)				tmpESC[%0] = %1, TextDrawShowForPlayer(%0,TD_ESC)
#define HideESCTextdraw(%0)	 				tmpESC[%0] = ESC_TYPE_NONE , TextDrawShowForPlayer(%0,TD_ESC)
#define GetESCType(%0) 						tmpESC[%0]

#define PRESSED(%0) 						(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define HOLDING(%0) 						((newkeys & (%0)) == (%0))
#define RELEASED(%0) 						(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
#define GetPlayerIpEx(%0) 					PlayerInfo[%0][pIp]
#define tobool(%0) 							!!%0
#define EMPTY_STATEMENT 					truebool
#define FALSE 								falsebool
#define TRUE 								truebool
#define NONE 								-1
#define Probability(%0) 					(100 - %0 <= random(100) <= 99 ? 1 : 0) // by Johurt

#define GetDynamicObjectModel(%0) 			Streamer_GetIntData(STREAMER_TYPE_OBJECT,%0,E_STREAMER_MODEL_ID)

#define IsVehicleInRangeOfPoint(%0,%1,%2,%3,%4) ((%1 >= GetVehicleDistanceFromPoint(%0,%2,%3,%4) ? true : false))