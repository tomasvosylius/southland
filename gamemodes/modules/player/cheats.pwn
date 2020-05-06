
public OnPlayerCheat(playerid, code, extra_id_1, extra_id_2)
{
    printf("OnPlayerCheat(%s, %03d, %d, %d)", GetPlayerNameEx(playerid), code, extra_id_1, extra_id_2);
    new
        reason[126],
        bool:ban = false,
        bool:ignore_if_admin = false;

    switch(code)
    {
        case CHEAT_HIGH_PING: 
        {
            /** High ping. No warnings, no ban. */
            SendFormat(playerid, 0xff0000ff, "Jûsø ping yra per didelis.");
            KickEx(playerid);
            return 1;
        }
        case CHEAT_MONEY: {
            format(reason, sizeof reason, "Memory hacking");
        }
        case CHEAT_WARP_TO_CAR, CHEAT_CAR_CHANGER, CHEAT_TROLLBOSS, CHEAT_SEAT_CHANGER: {
            ban = true;
            format(reason, sizeof reason, "Maðinø teleportacija");
        }
        case CHEAT_VEH_SPEED: {
            format(reason, sizeof reason, "Speed-hack");
        }
        case CHEAT_NOPS: {
            format(reason, sizeof reason, "NOPs");
        }
        case CHEAT_WEAPON: {
            ban = true;
            format(reason, sizeof reason, "Ginklø/ammo cheat [%d/%d]", extra_id_1, extra_id_2);
        }
        case CHEAT_AIRBRK: {
            ignore_if_admin = true;
            format(reason, sizeof reason, "Air-brk");
        }
        case CHEAT_FAKE_KILL: {
            format(reason, sizeof reason, "Fake-kill");
        }
        case CHEAT_GODMODE: {
            ban = true;
            format(reason, sizeof reason, "Godmode");
        }
        case CHEAT_HEALTH: {
            format(reason, sizeof reason, "Gyvybiø cheat");
        }
        case CHEAT_ARMOUR: {
            // format(reason, sizeof reason, "Ðarvø cheat");
            return 1;
        }
        case CHEAT_PICKUP_TP: {
            format(reason, sizeof reason, "Pickup teleport");
        }
        case CHEAT_VEH_HEALTH: {
            format(reason, sizeof reason, "Transporto gyvybës cheat");
            ignore_if_admin = true;
        }
        case CHEAT_AIMBOT: {
            format(reason, sizeof reason, "Aimbot");
        }
        case CHEAT_RAPID_FIRE: {
            format(reason, sizeof reason, "Rapid Fire");
        }
        case CHEAT_VEH_MODS: {
            format(reason, sizeof reason, "Transporto mod. cheat");
        }
        default: {
            format(reason, sizeof reason, "Kita (%d) [%d/%d]", code, extra_id_1, extra_id_2);
        }
    }

    if(ignore_if_admin && IsPlayerInAnyAdminGroup(playerid)) return 1;

    if(ban && PlayerInfo[playerid][pConnection] != CONNECTION_STATE_LOGGED) {
        // Zaidejas neprisijunges, nebaniname.
        ban = false;
    }


    if(ban) {
        // SendFormat(playerid, 0xff0000ff, "(BAN) Cheat: %s", reason);
        BanPlayer(playerid, "Sistema", reason);
    }
    else {
        // SendFormat(playerid, -1, "(KICK) Cheat: %s", reason);
        KickPlayer(playerid, "Sistema", reason);
    }
    return 1;
}