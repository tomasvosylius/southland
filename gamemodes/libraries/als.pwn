#define ALS_DO_PlayerLogIn<%0> %0<PlayerLogIn,i>(end:playerid)
#define ALS_DO_PlayerRegister<%0> %0<PlayerRegister,i>(end:playerid)
#define ALS_DO_PlayerSpawnChar<%0> %0<PlayerSpawnChar,ii>(more:playerid,end:selected)
#define ALS_DO_PlayerLeaveCharSelect<%0> %0<PlayerLeaveCharSelect,i>(end:playerid)
#define ALS_DO_PlayerSelectChar<%0>	%0<PlayerSelectChar,ii>(more:playerid,end:id)
#define ALS_DO_ResetPlayerData<%0> %0<ResetPlayerData,i>(end:playerid)
#define ALS_DO_CharAccepted<%0> %0<CharAccepted,iii>(more:charid,more:charuserid,end:adminid)
#define ALS_DO_CharRejected<%0> %0<CharRejected,iiis>(more:charid,more:charuserid,more:adminid,end_string:reason[])
#define ALS_DO_PlayerDespawnChar<%0> %0<PlayerDespawnChar,iii>(more:playerid,more:reason,end:changechar)
#define ALS_DO_PlayerLeaveCharCreate<%0> %0<PlayerLeaveCharCreate,i>(end:playerid)
#define ALS_DO_PlayerSubmitNewChar<%0> %0<PlayerSubmitNewChar,i>(end:playerid)
#define ALS_DO_PlayerRenameChar<%0> %0<PlayerRenameChar,iiiiis>(more:playerid,more:charid,more:gender,more:date,more:origin,end_string:name[])
#define ALS_DO_FullPayday<%0> %0<FullPayday,>(none:)
#define ALS_DO_NewDay<%0> %0<NewDay,>(none:)
#define ALS_DO_MysqlEstablished<%0> %0<MysqlEstablished,>(none:)
#define ALS_DO_PlayerEngineTurning<%0> %0<PlayerEngineTurning,iii>(more:playerid,more:vehicleid,end:have_permission)
#define ALS_DO_ProxyResult<%0> %0<ProxyResult,ii>(more:playerid,end:result)
#define ALS_DO_PlayerSpawnFirstTime<%0> %0<PlayerSpawnFirstTime,i>(end:playerid)