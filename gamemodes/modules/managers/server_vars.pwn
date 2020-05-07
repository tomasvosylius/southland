/** Server vars **/
stock SetGVarIntEx(key[], value)
{
    SetGVarInt(key, value),
    SaveServerIntEx(key, value);
    return 1;
}
stock SetGVarFloatEx(key[], Float:value)
{
    SetGVarFloat(key, value),
    SaveServerFloatEx(key, value);
    return 1;
}