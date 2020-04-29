/*
 * radio.pwn
 * www.crp.lt 2017 
 */
#include <YSI\y_hooks>

#define INVALID_AUDIO_HANDLE -1

enum E_PLAYER_RADIO_DATA
{
	playerPlayHandle,
	playerRadioVolume
};
new PlayerRadio[MAX_PLAYERS][E_PLAYER_RADIO_DATA];

enum E_VEHICLE_RADIO_DATA
{
	vehicleRadioLink[128],
	vehicleRadioPlay,
};
new VehicleRadio[MAX_VEHICLES][E_VEHICLE_RADIO_DATA];

enum E_RADIO_STATIONS_DATA
{
	stationName[58],
	stationLink[128]
};

new RadioStations[][E_RADIO_STATIONS_DATA] = {
	{"San News Radio", "http://s2.justhost.lt:3004/listen.pls"},
	{"Zip FM", "http://84.46.205.13/zipfm128.mp3.m3u"},
	{"Power Hit Radio", "http://www.radijasfm.lt/resources/_catalog/www.radijasfm.lt-radijo-stotis-power-hit-radio.pls"},
	{"M1", "http://radio.m-1.fm/m1/mp3.m3u"},
	{"FG radio", "http://www.radiofg.com/streams/fg.pls"},
	{"GAY.FM - BEST DANCE HITS", "http://stream.gayfm.de/listen.pls"},
	{"FUCKIN' GOOD RADIO", "http://radiofg.impek.com/fg"},
	{"HOT 108 Jamz Live", "http://jbmedia-edge1.cdnstream.com/hot108?listenerid=d99c3b9dbf53d4a10b8e62dc308772&cb=73453.mp3"},

	{"{ff0000}[  OLDIES  ]{ffffff}", " "},
	{"Beatles", "http://listen.181fm.com:8062"},
	{"Soul", "http://listen.181fm.com:8058"},
	{"Mellow Gold", "http://listen.181fm.com:8060"},
	{"Classic Hits 181", "http://listen.181fm.com:8132"},
	{"Good Time Oldies", "http://listen.181fm.com:8046"},
	{"Super 70s", "http://listen.181fm.com:8066"},

	{"{ff0000}[  RUSSIAN  ]{ffffff}", " "},
	{"Radio Shanson - Moskva FM", "http://chanson.hostingradio.ru:8041/chanson256.mp3"},
	{"Rusradio", "http://icecast.russkoeradio.cdnvideo.ru:8000/rr_m.aac?0.6736804138365374"},

	{"{ff0000}[  80's Decade  ]{ffffff}", " "},
	{"80`s Country", "http://listen.181fm.com:8134"},
	{"Awesome 80`s", "http://listen.181fm.com:8000"},
	{"Lite 80`s", "http://listen.181fm.com:8040"},

	{"{ff0000}[  90`s Decade  ]{ffffff}", " "},
	{"Star 90`s", "http://listen.181fm.com:8012"},
	{"90`s Country", "http://listen.181fm.com:8050"},
	{"Lite 90`s", "http://listen.181fm.com:8048"},

	{"{ff0000}[  Pop  ]{ffffff}", " "},
	{"Power 181 (Top 40)", "http://listen.181fm.com:8128"},
	{"Old School HipHop/RnB", "http://listen.181fm.com:8068"},
	{"UK top 40", "http://listen.181fm.com:8070"},
	{"The Vibe of Vegas", "http://listen.181fm.com:8074"},
	{"The Heart (Love Songs)", "http://listen.181fm.com:8006"},
	{"Smooth AC", "http://listen.181fm.com:8094"},
	{"The Office", "http://listen.181fm.com:8002"},

	{"{ff0000}[  Rock Channels  ]{ffffff}", " "},
	{"The Buzz (Alt. Rock)", "http://listen.181fm.com:8126"},
	{"Classic Buzz (Alt)", "http://listen.181fm.com:8038"},
	{"The Rock! (Hard Rock)", "http://listen.181fm.com:8064"},
	{"Rock 181", "http://listen.181fm.com:8008"},
	{"Chloe @181.FM", "http://listen.181fm.com:8100"},
	{"The Eagle (Classic)", "http://listen.181fm.com:8030"},

	{"{ff0000}[  Country  ]{ffffff}", " "},
	{"Kickin' Country", "http://listen.181fm.com:8130"},
	{"Real Country", "http://listen.181fm.com:8034"},
	{"90's Country", "http://listen.181fm.com:8050"},
	{"US 181", "http://listen.181fm.com:805680"},
	{"80's Country", "http://listen.181fm.com:8134"},

	{"{ff0000}[  Urban  ]{ffffff}", " "},
	{"The Beat (HipHop/R&B)", "http://listen.181fm.com:8054"},
	{"Old School HipHop/RnB", "http://listen.181fm.com:8068"},
	{"True R&B", "http://listen.181fm.com:8022"},
	{"The Box (Urban)", "http://listen.181fm.com:8024"},

	{"{ff0000}[  Dance / Techno  ]{ffffff}", " "},
	{"Energy 98", "http://listen.181fm.com:8800"},
	{"Techno Club", "http://listen.181fm.com/181-technoclub_128k.mp3"},
	{"Energy 93 (Euro EDM)", "http://listen.181fm.com:8044"},
	{"Studio 181", "http://listen.181fm.com:8072"},
	{"90's Dance", "http://listen.181fm.com:8140"},
	{"Chilled Out", "http://listen.181fm.com:8700"},
	{"The Vibe of Vegas", "http://listen.181fm.com:8074"},

	{"{ff0000}[  Easy Listening  ]{ffffff}", " "},
	{"The Breeze", "http://listen.181fm.com:8004"},
	{"Classical Guitar", "http://listen.181fm.com:8020"},
	{"Classical Jazz", "http://listen.181fm.com/181-classicaljazz_128k.mp3"},
	{"Vocal Jazz", "http://listen.181fm.com/181-vocals_128k.mp3"},

	{"{ff0000}[  Latin / Tropical  ]{ffffff}", " "},
	{"Reggae Roots", "http://listen.181fm.com:8096"},
	{"Salsa", "http://listen.181fm.com:8098"},

	{"{ff0000}[  Talk Radio  ]{ffffff}", " "},
	{"Comedy Club", "http://listen.181fm.com:8026"},

	{"{ff0000}[  Christmas  ]{ffffff}", " "},
	{"Christmas Kountry", "http://listen.181fm.com:8084"},
	{"Christmas Classics )", "http://listen.181fm.com:8124"},
	{"Christmas Oldies", "http://listen.181fm.com:8108"},
	{"Christmas Country", "http://listen.181fm.com:8110"},
	{"Christmas Power", "http://listen.181fm.com:8086"},
	{"Christmas Highway", "http://listen.181fm.com:8116"},
	{"Christmas Soundtracks", "http://listen.181fm.com:8114"}
};

/*
 * Hooks
 */

hook OnPlayerConnect(playerid)
{
	StopPlayerRadio(playerid);
	reset(Radio, PlayerRadio[playerid], E_PLAYER_RADIO_DATA);
	return 1;
}

hook OnPlayerDisconnect(playerid)
{
	StopPlayerRadio(playerid);
	reset(Radio, PlayerRadio[playerid], E_PLAYER_RADIO_DATA);
	return 1;
}

hook OnPlayerSpawn(playerid)
{
	PlayerRadio[playerid][playerRadioVolume] = 100;
	return 1;
}

/*
 * Functions
 */

stock SetPlayerRadio(playerid, url[])
{
	StopPlayerRadio(playerid);
	//if(Audio_IsClientConnected(playerid) == 0)
	//{
	PlayAudioStreamForPlayer(playerid, url);
	return 1;
	//}
	//PlayerRadio[playerid][playerPlayHandle] = Audio_PlayStreamed(playerid, url);
	//if(PlayerRadio[playerid][playerPlayHandle] != -1)
	//{
	//	Audio_SetVolume(playerid, PlayerRadio[playerid][playerPlayHandle], PlayerRadio[playerid][playerRadioVolume]);
	//}
	//return 1;
}

stock StopPlayerRadio(playerid)
{
	//if(Audio_IsClientConnected(playerid) == 0)
	//{
	StopAudioStreamForPlayer(playerid);
	return 1;
	//}
	//if(PlayerRadio[playerid][playerPlayHandle] != -1)
	//{
	//	Audio_Stop(playerid, PlayerRadio[playerid][playerPlayHandle]);
	//	PlayerRadio[playerid][playerPlayHandle] = -1;
	//}
	//return 1;
}	

/*
public Audio_OnClientConnect(playerid)
{
	StopPlayerRadio(playerid);
	reset(Radio, PlayerRadio[playerid], E_PLAYER_RADIO_DATA);
	return 1;
}

public Audio_OnClientDisconnect(playerid)
{
	StopPlayerRadio(playerid);
	reset(Radio, PlayerRadio[playerid], E_PLAYER_RADIO_DATA);
	return 1;
}*/