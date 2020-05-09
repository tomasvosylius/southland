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