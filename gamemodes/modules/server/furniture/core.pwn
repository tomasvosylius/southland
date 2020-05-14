#include <YSI_Coding\y_hooks>

#define MAX_FURNITURE_PER_PAGE          100
#define MAX_HOUSE_FURNITURE 			500
#define MAX_BUSINESS_FURNITURE 		    500
#define MAX_GARAGE_FURNITURE 			500

/* Furniture types */
enum E_FURNITURE_PLACE_TYPE 
{
    furniturePlace_Inside = 1,
    furniturePlace_Outside,
};

/* Furniture data */
enum E_FURNITURE_DATA
{
    furId,
	furModel,
	furOwner,
	E_FURNITURE_PLACE_TYPE:furPlaceType,
	furObject,
	furPrice,
	furVW,
	furInterior,
	furName[32],
	furColor[MAX_TEXTURE_SLOTS],
	furTexture[MAX_TEXTURE_SLOTS],
	Float:furPos[3],
	Float:furRot[3],
    bool:furOpened
};

new     
    // House
    Iterator:HouseFurniture[MAX_HOUSES]<MAX_HOUSE_FURNITURE>,
    HouseFurniture[MAX_HOUSES][MAX_HOUSE_FURNITURE][E_FURNITURE_DATA],
    // Business
    Iterator:BusinessFurniture[MAX_BUSINESS]<MAX_BUSINESS_FURNITURE>,
    BusinessFurniture[MAX_BUSINESS][MAX_BUSINESS_FURNITURE][E_FURNITURE_DATA],
    // Garage
    Iterator:GarageFurniture[MAX_GARAGES]<MAX_GARAGE_FURNITURE>,
    GarageFurniture[MAX_GARAGES][MAX_GARAGE_FURNITURE][E_FURNITURE_DATA];



/* Edit types */
enum E_FURNITURE_OWNER_TYPE 
{
    furnitureOwner_House    = 1,
    furnitureOwner_Business,
    furnitureOwner_Garage
}

/** Events */
hook OnHouseLoad(house)
{
    _Furniture_Load(furnitureOwner_House, house);
    return 1;
}

hook OnBusinessLoad(house)
{
    _Furniture_Load(furnitureOwner_Business, house);
    return 1;
}

hook OnGarageLoad(house)
{
    _Furniture_Load(furnitureOwner_Garage, house);
    return 1;
}

/** Global functions */
stock House_CountFurniture(house) return Iter_Count(HouseFurniture[house]);
stock House_DeleteFurniture(house)
{
    foreach(new obj : HouseFurniture[house])
    {
        IsValidDynamicObject(HouseFurniture[house][obj][furObject]) && DestroyDynamicObject(HouseFurniture[house][obj][furObject]);
    }
    Iter_Clear(HouseFurniture[house]);

    inline deleteFurniture() return 1;
	mysql_tquery_inline(chandler, using inline deleteFurniture, "\
        DELETE FROM `houses_furniture` WHERE OwnerId = '%d'",
        HouseInfo[house][hId]
    );
	return 1;
}

stock Garage_CountFurniture(garage) return Iter_Count(GarageFurniture[garage]);
stock Garage_DeleteFurniture(garage)
{
	// istrinam ir furniture
	foreach(new obj : GarageFurniture[garage])
    {
        IsValidDynamicObject(GarageFurniture[garage][obj][furObject]) && DestroyDynamicObject(GarageFurniture[garage][obj][furObject]);
    }
    Iter_Clear(GarageFurniture[garage]);

	inline deleteFurniture() return 1;
	mysql_tquery_inline(chandler, using inline deleteFurniture, "\
        DELETE FROM `garages_furniture` WHERE GarageId = '%d'",
        GarageInfo[garage][gId]
    );
	return 1;
}

stock Business_CountFurniture(business) return Iter_Count(BusinessFurniture[business]);
stock Business_DeleteFurniture(business)
{
	foreach(new obj : BusinessFurniture[business])
    {
        IsValidDynamicObject(BusinessFurniture[business][obj][furObject]) && DestroyDynamicObject(BusinessFurniture[business][obj][furObject]);
    }
    Iter_Clear(BusinessFurniture[business]);

	inline deleteFurniture() return 1;
	mysql_tquery_inline(chandler, using inline deleteFurniture, "\
		DELETE FROM `business_furniture` WHERE BusinessId = '%d'",
		BusinessInfo[business][bId]
	);
    return 1;
}
/** Static functions */
static _Furniture_Load(E_FURNITURE_OWNER_TYPE:ownerType, owner)
{
    new ownerSql,
        table[32];
    switch(ownerType)
    {
        case furnitureOwner_House:      format(table, 32, "houses_furniture"),      ownerSql = HouseInfo[owner][hId];
        case furnitureOwner_Business:   format(table, 32, "business_furniture"),    ownerSql = BusinessInfo[owner][bId];
        case furnitureOwner_Garage:     format(table, 32, "garages_furniture"),     ownerSql = GarageInfo[owner][gId];
    }

    new 
        id, name[32], placeType, model, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, vw, int, price,
        unused;

    inline loadAssetFurniture()
    {
        new rows = cache_num_rows();
        for(new r = 0; r < rows; r++)
        {
            cache_get_value_name(r, "id", name);
            cache_get_value_name_int(r, "id", id);
            cache_get_value_name_int(r, "Price", price);
            cache_get_value_name_int(r, "PlaceType", placeType);
            cache_get_value_name_int(r, "VW", vw);
            cache_get_value_name_int(r, "Int", int);
            cache_get_value_name_int(r, "Model", model);
            cache_get_value_name_float(r, "X", x);
            cache_get_value_name_float(r, "Y", y);
            cache_get_value_name_float(r, "Z", z);
            cache_get_value_name_float(r, "RX", rx);
            cache_get_value_name_float(r, "RY", ry);
            cache_get_value_name_float(r, "RZ", rz);

            Furniture_CreateModel(
                .sql        = id,
                .ownerType  = ownerType,
                .owner      = owner,
                .ownerSql   = ownerSql,
                .placeType  = E_FURNITURE_PLACE_TYPE:placeType,
                .model      = model,
                .name       = name,
                .x          = x,
                .y          = y,
                .z          = z,
                .rx         = rx,
                .ry         = ry,
                .rz         = rz,
                .vw         = vw,
                .int        = int,
                .price      = price,
                .ret_iter   = unused,
                .ret_object = unused
            );
        }
        return 1;
    }
    strlen(table) && mysql_tquery_inline(chandler, using inline loadAssetFurniture, "\
        SELECT * FROM `%s` WHERE OwnerId = '%d'",
        table, ownerSql
    );
    return 1;
}

stock Furniture_CreateModel(
    sql, E_FURNITURE_OWNER_TYPE:ownerType, owner, ownerSql, E_FURNITURE_PLACE_TYPE:placeType, 
    model, name[], Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, vw, int, price, &ret_iter, &ret_object)
{
    new iter = ITER_NONE;
    switch(ownerType)
    {
        case furnitureOwner_House:      iter = Iter_Free(HouseFurniture[owner]);
        case furnitureOwner_Business:   iter = Iter_Free(BusinessFurniture[owner]);
        case furnitureOwner_Garage:     iter = Iter_Free(GarageFurniture[owner]);
    }
    if(iter == ITER_NONE) return -1;

    new obj = CreateDynamicObject(
            model, 
            x,
            y,
            z,
            rx,
            ry,
            rz,
            .worldid = vw,
            .interiorid = int, 
            .playerid = -1
    );

    if(IsValidDynamicObject(obj))
    {
        new furnitureItem[E_FURNITURE_DATA];

        furnitureItem[furOwner] = ownerSql;
        furnitureItem[furId]    = sql;
        furnitureItem[furPlaceType] = placeType;
        furnitureItem[furObject]    = obj;
        furnitureItem[furPrice]     = price;
        furnitureItem[furVW]        = vw;
        furnitureItem[furInterior]  = int;
        furnitureItem[furPos][0] = x,
        furnitureItem[furPos][1] = y,
        furnitureItem[furPos][2] = z,
        furnitureItem[furRot][0] = rx,
        furnitureItem[furRot][1] = ry,
        furnitureItem[furRot][2] = rz;

        switch(ownerType)
        {
            case furnitureOwner_House: {
                Iter_Add(HouseFurniture[owner], iter);
                HouseFurniture[owner][iter] = furnitureItem;
                format(HouseFurniture[owner][iter][furName], 32, name);
            }
            case furnitureOwner_Business: {
                Iter_Add(BusinessFurniture[owner], iter);
                BusinessFurniture[owner][iter] = furnitureItem;
                format(BusinessFurniture[owner][iter][furName], 32, name);
            }
            case furnitureOwner_Garage: {
                Iter_Add(GarageFurniture[owner], iter);
                GarageFurniture[owner][iter] = furnitureItem;
                format(GarageFurniture[owner][iter][furName], 32, name);
            }
        }

        ret_object  = obj;
        ret_iter    = iter;
        return 1;
    }  
    return -2;
}

