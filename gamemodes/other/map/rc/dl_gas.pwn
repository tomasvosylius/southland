#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid)
{
    RemoveBuildingForPlayer(playerid, 1438, 670.109, -550.656, 15.273, 0.250);
    RemoveBuildingForPlayer(playerid, 1438, 663.375, -541.625, 15.289, 0.250);
}
hook OnGameModeInit()
{
    //Objects////////////////////////////////////////////////////////////////////////////////////////////////////////
    new tmpobjid;
    tmpobjid = CreateDynamicObject(19368, 654.957153, -559.672241, 16.964532, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 0, "none", "none", 0x00000000);
    tmpobjid = CreateDynamicObject(19368, 656.317199, -559.781860, 16.964532, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 0, "none", "none", 0x00000000);
    tmpobjid = CreateDynamicObject(19368, 654.987182, -570.302551, 16.964532, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 0, "none", "none", 0x00000000);
    tmpobjid = CreateDynamicObject(19368, 656.246948, -570.302551, 16.964532, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 0, "none", "none", 0x00000000);
    tmpobjid = CreateDynamicObject(19366, 666.682495, -570.686279, 15.485939, 0.000000, 0.000000, 90.000000, -1, -1, -1, 200.00, 200.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 0, "none", "none", 0x00000000);
    tmpobjid = CreateDynamicObject(19366, 669.132507, -570.686279, 15.485939, 0.000000, 0.000000, 90.000000, -1, -1, -1, 200.00, 200.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 0, "none", "none", 0x00000000);
    tmpobjid = CreateDynamicObject(19366, 669.132507, -574.656982, 15.485939, 0.000000, 0.000000, 90.000000, -1, -1, -1, 200.00, 200.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 0, "none", "none", 0x00000000);
    tmpobjid = CreateDynamicObject(19366, 666.682617, -574.656982, 15.485939, 0.000000, 0.000000, 90.000000, -1, -1, -1, 200.00, 200.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 0, "none", "none", 0x00000000);
    tmpobjid = CreateDynamicObject(19366, 664.027648, -567.805664, 14.423256, 0.000000, 0.000000, 90.000000, -1, -1, -1, 200.00, 200.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 0, "none", "none", 0x00000000);
    tmpobjid = CreateDynamicObject(19366, 664.067687, -567.245605, 14.443258, 0.000000, 0.000000, 90.000000, -1, -1, -1, 200.00, 200.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 0, "none", "none", 0x00000000);
    tmpobjid = CreateDynamicObject(19366, 663.977600, -565.185668, 17.003263, 0.000000, 0.000000, 90.000000, -1, -1, -1, 200.00, 200.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 0, "none", "none", 0x00000000);
    tmpobjid = CreateDynamicObject(19366, 667.177917, -565.185668, 17.003263, 0.000000, 0.000000, 90.000000, -1, -1, -1, 200.00, 200.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 0, "none", "none", 0x00000000);
    tmpobjid = CreateDynamicObject(19366, 668.368041, -565.125610, 17.003263, 0.000000, 0.000000, 90.000000, -1, -1, -1, 200.00, 200.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 0, "none", "none", 0x00000000);
    tmpobjid = CreateDynamicObject(19366, 667.687988, -565.755615, 15.423256, 0.000000, 0.000000, 90.000000, -1, -1, -1, 200.00, 200.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 0, "none", "none", 0x00000000);
    tmpobjid = CreateDynamicObject(19366, 669.648315, -566.955871, 15.423256, 0.000000, 0.000000, 180.000000, -1, -1, -1, 200.00, 200.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 0, "none", "none", 0x00000000);
    tmpobjid = CreateDynamicObject(19366, 666.682495, -570.205993, 15.485939, 0.000000, 0.000000, 90.000000, -1, -1, -1, 200.00, 200.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 0, "none", "none", 0x00000000);
    tmpobjid = CreateDynamicObject(19366, 669.202758, -570.205993, 15.485939, 0.000000, 0.000000, 90.000000, -1, -1, -1, 200.00, 200.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 0, "none", "none", 0x00000000);
    tmpobjid = CreateDynamicObject(19366, 669.202758, -575.036682, 15.465938, 0.000000, 0.000000, 90.000000, -1, -1, -1, 200.00, 200.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 0, "none", "none", 0x00000000);
    tmpobjid = CreateDynamicObject(19366, 666.702697, -575.036682, 15.465938, 0.000000, 0.000000, 90.000000, -1, -1, -1, 200.00, 200.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 0, "none", "none", 0x00000000);
    tmpobjid = CreateDynamicObject(19366, 666.071472, -566.028564, 14.473261, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 0, "none", "none", 0x00000000);
    tmpobjid = CreateDynamicObject(19366, 665.621093, -566.028564, 14.473261, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 0, "none", "none", 0x00000000);
    tmpobjid = CreateDynamicObject(3035, 669.427551, -551.749206, 16.085935, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00); 
    tmpobjid = CreateDynamicObject(1885, 662.702087, -574.758117, 15.315937, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00); 
    tmpobjid = CreateDynamicObject(705, 680.843139, -405.065643, 15.489145, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00); 
    tmpobjid = CreateDynamicObject(791, 715.911865, -396.358001, 9.902439, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00); 
    tmpobjid = CreateDynamicObject(3172, 713.366882, -294.583618, 6.601692, 0.000000, 0.000000, -43.299987, -1, -1, -1, 200.00, 200.00); 
    tmpobjid = CreateDynamicObject(3171, 699.718505, -289.895507, 6.401559, 0.000000, 0.000000, 178.900009, -1, -1, -1, 200.00, 200.00); 
    tmpobjid = CreateDynamicObject(1412, 656.496826, -619.699279, 16.553970, 0.000000, 0.000000, 90.000000, -1, -1, -1, 200.00, 200.00); 
    tmpobjid = CreateDynamicObject(1412, 656.587036, -624.998107, 16.574325, 0.000000, 0.499999, 90.599990, -1, -1, -1, 200.00, 200.00); 

}