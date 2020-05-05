#include <YSI_Coding\y_hooks>

static enum E_GUIDE_POINTS
{
    guideText[256],
    Float:guideTime,
    Float:guidePos[3],
    Float:guideLook[3]
};  

static 
    GuidePoints[][E_GUIDE_POINTS] = {
        {
            "~w~Dabar ~y~1 minutes~w~ gidas aprodys svarbiausias vietas. Praleisti gida gali su ~r~/skip",
            4.15,
            {1880.1526,-2002.2029,40.0697},
            {1952.9141,-1911.8890,23.8318},
        },
        {
            "~w~Serveryje gali issinuomoti automobili. Ieskok automobiliu ~r~\"RENT\"~w~ numeriais. \
            Varikli uzvesti gali su ~y~/engine~w~ arba ~y~ALT~w~ mygtuku.",
            6.5,
            {2088.2292,-1766.8760,18.8603},
            {2118.7241,-1774.8286,13.3920}
        },
        {
            "~w~Cia igysi vairavimo ~y~teises. ~w~Uz sio pastato rasi ~b~~h~San_News~w~, \
            kuriame gali deti skelbimus su ~r~/ad",
            5.5,
            {1823.0577,-1739.1483,20.7241},
            {1823.0577,-1739.1483,20.7241}
        },
        {
            "~w~Noredamas pilti degalus, degalineje naudok komanda ~y~/fill~w~",
            4.15,
            {1966.2476,-1767.5554,17.1714},
            {1942.7316,-1772.5522,14.5074}
        },
        {
            "~w~Vienas is galimu darbu - ~r~mechanikai~w~, kurie uzsiima transporto taisymu ir tobulinimu.",
            5.0,
            {2126.5168,-1875.8082,21.7220},
            {2157.2954,-1904.0613,16.7034}
        },
        {
            "~w~Cia gali isidarbinti ~r~kroviniu isveziotoju~w~ ir neblogai uzdirbti. Visi zaidejai ~g~~h~alga~w~ gauna kas 30min.",
            6.5,
            {2411.3591,-2079.7864,20.2639},
            {2439.9382,-2097.9646,15.0768}
        },
        {
            "~b~Policija~w~ - tai viena is oficialiu frakciju. I ja gali patekti tik atrankas praeje zmones. \
            Daugiau apie jas rasi www.southland.lt",
            8.0,
            {1511.1141,-1718.4338,22.7151},
            {1542.1799,-1683.0861,19.4206}
        },
        {
            "~w~Visas serverio vietas gali rasti parases ~r~~h~/gps.~w~ Serverio komandas rasi ~g~/help",
            4.2,
            {2206.5186,-1696.4133,29.3065},
            {2138.5750,-1729.2648,21.5000}
        }
};

static  
    bool:player_InTutorial[MAX_PLAYERS];

hook OnPlayerSpawnFirstTime(playerid)
{
    if( PlayerInfo[playerid][pTutorialDone] <= 0 && 
        PlayerInfo[playerid][pUserId] != 0)
    {
        ClearChat(playerid, 15);
        Tutorial_Start(playerid);   
    }
    return 1;
}

CMD:skip(playerid, params[], help)
{
    if(Player_IsInTutorial(playerid))
    {
        Tutorial_End(playerid);
    }
    return 1;
}

stock Tutorial_End(playerid)
{
    PlayerInfo[playerid][pTutorialDone] = 1;
    SaveUserIntEx(PlayerInfo[playerid][pUserId], "TutorialDone", 1);

    SendFormat(playerid, 0xbababaff, "Gidas baigtas, gero þaidimo!");

    player_InTutorial[playerid] = false;
    TogglePlayerSpectating(playerid, false);
    UI_LeftBox_Hide(playerid);
    return 1;
}
stock Tutorial_Start(playerid)
{  
    player_InTutorial[playerid] = true;
    TogglePlayerSpectating(playerid, true);
    Tutorial_Step(playerid, 0);
    return 1;
}

timer PT_SetGuidePoint[1000](playerid, step)
{
    Player_IsInTutorial(playerid) && Tutorial_Step(playerid, step);
}

stock Tutorial_Step(playerid, step)
{  
    if(step >= sizeof GuidePoints)
    {
        Tutorial_End(playerid);
        return 0;
    }
    
    UI_LeftBox_Show(playerid, GuidePoints[step][guideText], .width = 180.0, .time = 0.0);

    InterpolateCameraPos(playerid, 	
        GuidePoints[step][guidePos][0], GuidePoints[step][guidePos][1], GuidePoints[step][guidePos][2],
        GuidePoints[step][guidePos][0], GuidePoints[step][guidePos][1], GuidePoints[step][guidePos][2] + 1.0,
        10000, CAMERA_CUT);

	InterpolateCameraLookAt(playerid, 
        GuidePoints[step][guideLook][0], GuidePoints[step][guideLook][1], GuidePoints[step][guideLook][2],
        GuidePoints[step][guideLook][0], GuidePoints[step][guideLook][1], GuidePoints[step][guideLook][2] + 1.0,
        10000, CAMERA_CUT);

    // SetPlayerCameraPos(playerid, GuidePoints[step][guidePos][0], GuidePoints[step][guidePos][1], GuidePoints[step][guidePos][2]);
    // SetPlayerCameraLookAt(playerid, GuidePoints[step][guideLook][0], GuidePoints[step][guideLook][1], GuidePoints[step][guideLook][2]);

    defer PT_SetGuidePoint[floatround(GuidePoints[step][guideTime] * 1000)](playerid, step + 1);
    return 1;
}

stock Player_IsInTutorial(playerid) return player_InTutorial[playerid];

hook OnPlayerConnect(playerid)
{
    player_InTutorial[playerid] = false;
    return 1;
}