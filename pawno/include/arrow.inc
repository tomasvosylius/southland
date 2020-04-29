/**************************************************************************
	Copyright 2013 Ian Goodwin

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

	   http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.
	
*//////////////////////////////////////////////////////////////////////////

/*
	Credits:
		Incognito 	- Streamer Plugin
		Antonio144  - GetYRotation function
		SA:MP Team 	- For SA:MP

		
		
	Changelog:
		<insert date v1.3>	
			* Values returned by CreateArrow now have the Arrow: tag, to avoid confusion with normal objectids.
			* All function headers expecting an arrowid have changed to accept the new Arrow: tag.
			* Added functions:
				SetArrowRot
				SetPlayerArrowRot
				
			* Fixed more comment errors.
				
		24/07/13 v1.2:
			*Player arrows added.
			* Added functions:
				CreatePlayerArrow
				PointPlayerArrowAtPoint
				DestroyPlayerArrow
				SetPlayerArrowPos
				GetPlayerArrowPos
				GetPlayerArrowRot
				PointPlayerArrowAtPlayer
				PointPlayerArrowAtVehicle
				PointPlayerArrowAtObject
				PointPlayerArrowAtPlayerObject
				SetPlayerArrowColor
				
			*Functions changed
				PointArrowAtPoint   - No loner does rotation calculations if the arrow isn't a valid object. And returns 0 on failure.
			
			*Fixed some comment errors.
				
		23/07/13 v1.1:
			*Arrows now rotate along the Y-Axis, so they an point vertically. (Antonio144)
		22/07/13 v1.0:
			*Initial release.
*/



/*
//global arrows
native Arrow:CreateArrow(Float: x, Float: y, Float: z, Float: target_x, Float: target_y, Float: target_z, Float: stream_dist = DEFAULT_ARROW_DRAW_DISTANCE);
native PointArrowAtPoint(Arrow:arrowid, Float: x, Float: y, Float: z);
native DestroyArrow(Arrow:arrowid);
native SetArrowPos(Arrow:arrowid, Float: x, Float: y, Float: z);
native GetArrowPos(Arrow:arrowid, &Float: x, &Float: y, &Float: z);
native GetArrowRot(Arrow:arrowid, &Float: rx, &Float: ry, &Float: rz);
native SetArrowRot(Arrow:arrowid, Float: rx, Float: ry, Float: rz);
native PointArrowAtPlayer(Arrow:arrowid, playerid);
native PointArrowAtVehicle(Arrow:arrowid, vehicleid);
native PointArrowAtObject(Arrow:arrowid, objectid);
native SetArrowColor(Arrow:arrowid, argb_color);
//player arrows
native Arrow:CreatePlayerArrow(playerid, Float: x, Float: y, Float: z, Float: target_x, Float: target_y, Float: target_z, Float: stream_dist = DEFAULT_ARROW_DRAW_DISTANCE);
native PointPlayerArrowAtPoint(playerid, Arrow:arrowid, Float: x, Float: y, Float: z);
native DestroyPlayerArrow(playerid, Arrow:arrowid);
native SetPlayerArrowPos(playerid, Arrow:arrowid, Float: x, Float: y, Float: z);
native GetPlayerArrowPos(playerid, Arrow:arrowid, &Float: x, &Float: y, &Float: z);
native GetPlayerArrowRot(playerid, Arrow:arrowid, &Float: rx, &Float: ry, &Float: rz);
native SetPlayerArrowRot(playerid, Arrow:arrowid, Float: rx, Float: ry, Float: rz);
native PointPlayerArrowAtPlayer(playerid, Arrow:arrowid, playerid);
native PointPlayerArrowAtVehicle(playerid, Arrow:arrowid, vehicleid);
native PointPlayerArrowAtObject(playerid, Arrow:arrowid, objectid);
native PointPlayerArrowAtPlayerObject(playerid, Arrow:arrowid, targetplayerid, targetobjectid);
native SetPlayerArrowColor(playerid, Arrow:arrowid, argb_color);
*/

#include <a_samp>

#if !defined ARROW_NO_STREAMER
	#tryinclude <streamer>
	#if !defined CreateDynamicObject
		#error streamer include not found, have you got streamer.inc in your includes folder? 
	#endif
#endif

#define ARW_OBJECT_ID						(1318)
#define ARW_Z_ROT_OFFSET					(90.0)
#define DEFAULT_ARROW_DRAW_DISTANCE			(200.0)
#define INVALID_ARROW_ID					Arrow:INVALID_OBJECT_ID

forward Float:arw_PointToPoint(Float:X, Float:Y, Float:PointX, Float:PointY);
forward Float:arw_GetYRotation(Float:x,Float:y,Float:z, Float:ax, Float:ay, Float:az);

/*
	Function:
		CreateArrow
	Description:
		Creates an arrow at the given point, pointing to a target location.
	Param(s):
		x, y, z  	 - Position to create the arrow.
		target_x/y/z - Position to point the arrow at
		stream_dist	 - stream distance for the arrow (default DEFAULT_ARROW_DRAW_DISTANCE)
	Returns:
		Arrowid for the newly created arrow. (returned by CreateObject or CreateDynamicObject

*/
stock Arrow:CreateArrow(Float: x, Float: y, Float: z, Float: target_x, Float: target_y, Float: target_z, Float: 
	stream_dist = DEFAULT_ARROW_DRAW_DISTANCE)
{
	#if !defined ARROW_NO_STREAMER
		return Arrow:CreateDynamicObject( ARW_OBJECT_ID, x, y, z, 
			0.0, 
			arw_GetYRotation(x, y, z, target_x, target_y, target_z), 
			arw_PointToPoint(x, y, target_x, target_y)+ARW_Z_ROT_OFFSET, 
			.streamdistance = stream_dist
		);
	#else
		return Arrow:CreateObject( ARW_OBJECT_ID, x, y, z, 0.0, 
			arw_GetYRotation(x, y, z, target_x, target_y, target_z), 
			arw_PointToPoint(x, y, target_x, target_y)+ARW_Z_ROT_OFFSET, 
			stream_dist 
		);
	#endif
}

/*
	Function:
		CreatePlayerArrow
	Description:
		Creates an arrow for playerid at the given point, pointing to a target location.
	Param(s):
		playerid 	 - The player to show the arrow.
		x, y, z  	 - Position to create the arrow.
		target_x/y/z - Position to point the arrow at
		stream_dist	 - stream distance for the arrow (default DEFAULT_ARROW_DRAW_DISTANCE)
	Returns:
		*Arrowid for the newly created arrow. (returned by CreateObject or CreateDynamicObject
		
		-1 if the player isn't connected.

*/
stock Arrow:CreatePlayerArrow(playerid, Float: x, Float: y, Float: z, 
	Float: target_x, Float: target_y, Float: target_z, Float: stream_dist = DEFAULT_ARROW_DRAW_DISTANCE)
{
	if( IsPlayerConnected( playerid ) )
	{
		#if !defined ARROW_NO_STREAMER
			return Arrow:CreateDynamicObject( ARW_OBJECT_ID, x, y, z, 
				0.0, 
				arw_GetYRotation(x, y, z, target_x, target_y, target_z), 
				arw_PointToPoint(x, y, target_x, target_y)+ARW_Z_ROT_OFFSET, 
				.streamdistance = stream_dist,
				.playerid = playerid
			);
		#else
			return Arrow:CreatePlayerObject( playerid, ARW_OBJECT_ID, x, y, z, 0.0, 
				arw_GetYRotation(x, y, z, target_x, target_y, target_z), 
				arw_PointToPoint(x, y, target_x, target_y)+ARW_Z_ROT_OFFSET, 
				stream_dist 
			);
		#endif
	}
	return INVALID_ARROW_ID;
}

/*
	Function:
		DestroyArrow
	Description:
		Destroys the given arrow.
	Param(s):
		arrowid - The arrowid returned by "CreateArrow" function
	Returns:
		Value returned by DestroyObject or DestroyDynamicObject

*/
stock DestroyArrow(Arrow:arrowid)
{
	#if !defined ARROW_NO_STREAMER
		return DestroyDynamicObject( _:arrowid );
	#else
		return DestroyObject( _:arrowid );
	#endif
}

/*
	Function:
		DestroyPlayerArrow
	Description:
		Destroys the given player arrow.
	Param(s):
		playerid - The player who the arrow is streamed for.
		arrowid  - The arrowid returned by "CreatePlayerArrow" function
	Returns:
		Value returned by DestroyPlayerObject or DestroyDynamicObject

*/
stock DestroyPlayerArrow(playerid, Arrow:arrowid)
{
	#pragma unused playerid
	#if !defined ARROW_NO_STREAMER
		return DestroyDynamicObject( _:arrowid );
	#else
		return DestroyPlayerObject( playerid, _:arrowid );
	#endif
}

/*
	Function:
		SetArrowPos
	Description:
		Sets a new position for the given arrow.
	Param(s):
		arrowid - The arrowid returned by "CreateArrow" function.
		x, y, z - The new position for the arrow to be placed.
	Returns:
		Value returned by SetObjectPos or SetDynamicObjectPos

*/
stock SetArrowPos(Arrow:arrowid, Float: x, Float: y, Float: z)
{
	#if !defined ARROW_NO_STREAMER
		return SetDynamicObjectPos( _:arrowid, x, y, z );
	#else
		return SetObjectPos( _:arrowid, x, y, z );
	#endif
}

/*
	Function:
		SetPlayerArrowPos
	Description:
		Sets a new position for the given player arrow.
	Param(s):
		playerid  - The player who the arrow is streamed for.
		arrowid   - The arrowid returned by "CreatePlayerArrow" function.
		x, y, z   - The new position for the arrow to be placed.
	Returns:
		Value returned by SetPlayerObjectPos or SetDynamicObjectPos

*/
stock SetPlayerArrowPos(playerid, Arrow:arrowid, Float: x, Float: y, Float: z)
{
	#pragma unused playerid
	#if !defined ARROW_NO_STREAMER
		return SetDynamicObjectPos( _:arrowid, x, y, z );
	#else
		return SetPlayerObjectPos( playerid, _:arrowid, x, y, z );
	#endif
}

/*
	Function:
		GetArrowPos
	Description:
		Gets the current position for the given arrow.
	Param(s):
		arrowid - The arrowid returned by "CreateArrow" function.
		x, y, z - Variables to store the position of the arrow, passed by reference.
	Returns:
		Value returned by GetObjectPos or GetDynamicObjectPos

*/
stock GetArrowPos(Arrow:arrowid, &Float: x, &Float: y, &Float: z)
{
	#if !defined ARROW_NO_STREAMER
		return GetDynamicObjectPos( _:arrowid, x, y, z );
	#else
		return GetObjectPos( _:arrowid, x, y, z );
	#endif
}

/*
	Function:
		GetPlayerArrowPos
	Description:
		Gets the current position for the given player arrow.
	Param(s):
		playerid - The player whoi the arrow is streamed for.
		arrowid  - The arrowid returned by "CreatePlayerArrow" function.
		x, y, z  - Variables to store the position of the arrow, passed by reference.
	Returns:
		Value returned by GetPlayerObjectPos or GetDynamicObjectPos

*/
stock GetPlayerArrowPos(playerid, Arrow:arrowid, &Float: x, &Float: y, &Float: z)
{
	#pragma unused playerid
	#if !defined ARROW_NO_STREAMER
		return GetDynamicObjectPos( _:arrowid, x, y, z );
	#else
		return GetPlayerObjectPos( playerid, _:arrowid, x, y, z );
	#endif
}

/*
	Function:
		GetArrowRot
	Description:
		Gets the current rotation for the given arrow.
	Param(s):
		arrowid 	- The arrowid returned by "CreateArrow" function.
		rx, ry, rz 	- Variables to store the rotation of the arrow, passed by reference.
	Returns:
		Value returned by GetObjectRot or GetDynamicObjectRot

*/
stock GetArrowRot(Arrow:arrowid, &Float: rx, &Float: ry, &Float: rz)
{
	#if !defined ARROW_NO_STREAMER
		return GetDynamicObjectRot( _:arrowid, rx, ry, rz );
	#else
		return GetObjectRot( _:arrowid, rx, ry, rz );
	#endif
}

/*
	Function:
		GetPlayerArrowRot
	Description:
		Gets the current rotation for the given player arrow.
	Param(s):
		playerid 	- The player who the object is streamed for.
		arrowid 	- The arrowid returned by "CreatePlayerArrow" function.
		rx, ry, rz 	- Variables to store the rotation of the arrow, passed by reference.
	Returns:
		Value returned by GetPlayerObjectRot or GetDynamicObjectRot

*/
stock GetPlayerArrowRot(playerid, Arrow:arrowid, &Float: rx, &Float: ry, &Float: rz)
{
	#pragma unused playerid
	#if !defined ARROW_NO_STREAMER
		return GetDynamicObjectRot( _:arrowid, rx, ry, rz );
	#else
		return GetPlayerObjectRot( playerid, _:arrowid, rx, ry, rz );
	#endif
}

/*
	Function:
		SetArrowRot
	Description:
		Sets the rotation for the given arrow.
	Param(s):
		arrowid 	- The arrowid returned by "CreateArrow" function.
		rx, ry, rz 	- New rotation values for the arrow. 
	Returns:
		Value returned by SetObjectRot or SetDynamicObjectRot

*/
stock SetArrowRot(Arrow:arrowid, Float: rx, Float: ry, Float: rz)
{
	#if !defined ARROW_NO_STREAMER
		return SetDynamicObjectRot( _:arrowid, rx, ry, rz );
	#else
		return SetObjectRot( _:arrowid, rx, ry, rz );
	#endif
}

/*
	Function:
		SetPlayerArrowRot
	Description:
		Sets the rotation for the given arrow.
	Param(s):
		playerid	- The player who the arrow is streamed for
		arrowid 	- The arrowid returned by "CreateArrow" function.
		rx, ry, rz 	- New rotation values for the arrow. 
	Returns:
		Value returned by SetObjectRot or SetDynamicObjectRot

*/
stock SetPlayerArrowRot(playerid, Arrow:arrowid, Float: rx, Float: ry, Float: rz)
{
	#pragma unused playerid
	#if !defined ARROW_NO_STREAMER
		return SetDynamicObjectRot( _:arrowid, rx, ry, rz );
	#else
		return SetPlayerObjectRot( playerid, _:arrowid, rx, ry, rz );
	#endif
}

/*
	Function:
		SetArrowColor
	Description:
		Sets a new color for the arrow
	Param(s):
		arrowid - The arrowid returned by "CreateArrow" function.
		argb_color - New color for the arrow, NOTE: ARGB format not RGBA
	Returns:
		Value returned by SetObjectMaterial or SetDynamicObjectMaterial

*/
stock SetArrowColor(Arrow:arrowid, argb_color)
{
	#if !defined ARROW_NO_STREAMER
		return SetDynamicObjectMaterial(_:arrowid, 0, -1, "none", "none", argb_color);
	#else
		return SetObjectMaterial(_:arrowid, 0, -1, "none", "none", argb_color);
	#endif
}

/*
	Function:
		SetPlayerArrowColor
	Description:
		Sets a new color for the player arrow.
	Param(s):
		playerid	- The player the arrow is streamed for.
		arrowid 	- The arrowid returned by "CreateArrow" function.
		argb_color 	- New color for the arrow, NOTE: ARGB format not RGBA
	Returns:
		Value returned by SetObjectMaterial or SetDynamicObjectMaterial

*/
stock SetPlayerArrowColor(playerid, Arrow:arrowid, argb_color)
{
	#pragma unused playerid
	#if !defined ARROW_NO_STREAMER
		return SetDynamicObjectMaterial(_:arrowid, 0, -1, "none", "none", argb_color);
	#else
		return SetPlayerObjectMaterial(playerid, _:arrowid, 0, -1, "none", "none", argb_color);
	#endif
}


/*
	Function:
		PointArrowAtPlayer
	Description:
		Points the given arrow at the given playerid
	Param(s):
		arrowid  - The arrowid returned by "CreateArrow" function.
		playerid - ID of the player to point at.
	Returns:
		1 if playerid is connected.
		0 otherwise.

*/
stock PointArrowAtPlayer(Arrow:arrowid, playerid)
{
	new 
		Float: fTargetX, Float: fTargetY, Float: fTargetZ
	;
	
	if( GetPlayerPos(playerid, fTargetX, fTargetY, fTargetZ) )
	{
		PointArrowAtPoint(arrowid, fTargetX, fTargetY, fTargetZ);
		return 1;
	}
	return 0;
}

/*
	Function:
		PointArrowAtPlayer
	Description:
		Points the given arrow at the given playerid
	Param(s):
		playerid - Player who the arrow is streamed for
		arrowid  - The arrowid returned by "CreateArrow" function.
		targetplayerid - ID of the player to point at.
	Returns:
		1 if playerid is connected.
		0 otherwise.

*/
stock PointPlayerArrowAtPlayer(playerid, Arrow:arrowid, targetplayerid)
{
	new 
		Float: fTargetX, Float: fTargetY, Float: fTargetZ
	;
	
	if( GetPlayerPos(targetplayerid, fTargetX, fTargetY, fTargetZ) )
	{
		PointPlayerArrowAtPoint(playerid, arrowid, fTargetX, fTargetY, fTargetZ);
		return 1;
	}
	return 0;
}

/*
	Function:
		PointArrowAtVehicle
	Description:
		Points the given arrow at the given vehicle
	Param(s):
		arrowid  - The arrowid returned by "CreateArrow" function.
		vehicleid - ID of the vehicle to point at.
	Returns:
		1 if vehicleid is found.
		0 otherwise.

*/
stock PointArrowAtVehicle(Arrow:arrowid, vehicleid)
{
	new 
		Float: fTargetX, Float: fTargetY, Float: fTargetZ
	;
	
	if( GetVehiclePos(vehicleid, fTargetX, fTargetY, fTargetZ) )
	{
		PointArrowAtPoint(arrowid, fTargetX, fTargetY, fTargetZ);
		return 1;
	}
	return 0;
}

/*
	Function:
		PointPlayerArrowAtVehicle
	Description:
		Points the given arrow at the given vehicle
	Param(s):
		playerid  - Player who the arrow is streamed for.
		arrowid   - The arrowid returned by "CreateArrow" function.
		vehicleid - ID of the vehicle to point at.
	Returns:
		1 if vehicleid is found.
		0 otherwise.

*/
stock PointPlayerArrowAtVehicle(playerid, Arrow:arrowid, vehicleid)
{
	new 
		Float: fTargetX, Float: fTargetY, Float: fTargetZ
	;
	
	if( GetVehiclePos(vehicleid, fTargetX, fTargetY, fTargetZ) )
	{
		PointPlayerArrowAtPoint(playerid, arrowid, fTargetX, fTargetY, fTargetZ);
		return 1;
	}
	return 0;
}

/*
	Function:
		PointArrowAtObject
	Description:
		Points the given arrow at the given object
	Param(s):
		arrowid  - The arrowid returned by "CreateArrow" function.
		objectid - ID of the object to point at.
	Returns:
		1 if objectid is found.
		0 otherwise.

*/
stock PointArrowAtObject(Arrow:arrowid, objectid)
{
	new 
		Float: fTargetX, Float: fTargetY, Float: fTargetZ
	;
	
	#if !defined ARROW_NO_STREAMER
		if( GetDynamicObjectPos(objectid, fTargetX, fTargetY, fTargetZ) )
		{
			PointArrowAtPoint(arrowid, fTargetX, fTargetY, fTargetZ);
			return 1;
		}
	#else
		if( GetObjectPos(objectid, fTargetX, fTargetY, fTargetZ) )
		{
			PointArrowAtPoint(arrowid, fTargetX, fTargetY, fTargetZ);
			return 1;
		}
	#endif
	
	return 0;
}

/*
	Function:
		PointArrowAtPlayerObject
	Description:
		Points the given arrow at the given object
	Param(s):
		playerid - The player who the arrow is streamed for.
		arrowid  - The arrowid returned by "CreateArrow" function.
		objectid - ID of the object to point at.
	Returns:
		1 if objectid is found.
		0 otherwise.

*/
stock PointPlayerArrowAtObject(playerid, Arrow:arrowid, objectid)
{
	new 
		Float: fTargetX, Float: fTargetY, Float: fTargetZ
	;
	
	#if !defined ARROW_NO_STREAMER
		if( GetDynamicObjectPos(objectid, fTargetX, fTargetY, fTargetZ) )
		{
			PointPlayerArrowAtPoint(playerid, _:arrowid, fTargetX, fTargetY, fTargetZ);
			return 1;
		}
	#else
		if( GetObjectPos(objectid, fTargetX, fTargetY, fTargetZ) )
		{
			PointPlayerArrowAtPoint(playerid, arrowid, fTargetX, fTargetY, fTargetZ);
			return 1;
		}
	#endif
	
	return 0;
}

/*
	Function:
		PointArrowAtPlayerObject
	Description:
		Points the given arrow at the given object
	Param(s):
		playerid 		- The player who the arrow is streamed for.
		arrowid  		- The arrowid returned by "CreateArrow" function.
		targetplayerid	- The player who the target object is streamed for.
		targetobjectid 	- ID of the player object to point at.
	Returns:
		1 if player objectid is found.
		0 otherwise.

*/
stock PointPlayerArrowAtPlayerObject(playerid, Arrow:arrowid, targetplayerid, targetobjectid)
{
	new 
		Float: fTargetX, Float: fTargetY, Float: fTargetZ
	;
	
	#if !defined ARROW_NO_STREAMER
		if( GetDynamicObjectPos(targetobjectid, fTargetX, fTargetY, fTargetZ) )
		{
			PointPlayerArrowAtPoint(playerid, arrowid, fTargetX, fTargetY, fTargetZ);
			return 1;
		}
	#else
		if( GetPlayerObjectPos(targetplayerid, targetobjectid, fTargetX, fTargetY, fTargetZ) )
		{
			PointPlayerArrowAtPoint(playerid, arrowid, fTargetX, fTargetY, fTargetZ);
			return 1;
		}
	#endif
	
	return 0;
}

/*
	Function:
		PointArrowAtPoint
	Description:
		Points the given arrow at the given point
	Param(s):
		arrowid  - The arrowid returned by "CreateArrow" function.
		x, y, z	 - The point, to point the arrow at
	Returns:
		This function returns 1 if the object is valid. 0 otherwise.

*/
stock PointArrowAtPoint(Arrow:arrowid, Float: x, Float: y, Float: z)
{
	new Float: fArrX, Float: fArrY, Float: fArrZ;
	
	#if !defined ARROW_NO_STREAMER
		if( GetDynamicObjectPos(arrowid, fArrX, fArrY, fArrZ) )
		{
			SetDynamicObjectRot(arrowid, 0.0, 
				arw_GetYRotation(fArrX, fArrY, fArrZ, x, y, z), 
				arw_PointToPoint(fArrX, fArrY, x, y)+ARW_Z_ROT_OFFSET
			);
			return 1;
		}
		return 0;
	#else
		if( GetObjectPos(arrowid, fArrX, fArrY, fArrZ) )
		{
			SetObjectRot(arrowid, 0.0, 
				arw_GetYRotation(fArrX, fArrY, fArrZ, x, y, z), 
				arw_PointToPoint(fArrX, fArrY, x, y)+ARW_Z_ROT_OFFSET
			);
			return 1;
		}
		return 0;
	#endif
}

/*
	Function:
		PointPlayerArrowAtPoint
	Description:
		Points the given player arrow at the given point
	Param(s):
		playerid - The player who the arrow is streamed for.
		arrowid  - The arrowid returned by "CreateArrow" function.
		x, y, z	 - The point, to point the player arrow at.
	Returns:
		This function returns 1 if the object is valid. 0 otherwise.

*/
stock PointPlayerArrowAtPoint(playerid, Arrow:arrowid, Float: x, Float: y, Float: z)
{
	#pragma unused playerid
	new Float: fArrX, Float: fArrY, Float: fArrZ;
	
	#if !defined ARROW_NO_STREAMER
		if( GetDynamicObjectPos(_:arrowid, fArrX, fArrY, fArrZ) )
		{
			SetDynamicObjectRot(_:arrowid, 0.0, 
				arw_GetYRotation(fArrX, fArrY, fArrZ, x, y, z), 
				arw_PointToPoint(fArrX, fArrY, x, y)+ARW_Z_ROT_OFFSET
			);
			return 1;
		}
		return 0;
	#else
		if( GetPlayerObjectPos(playerid, _:arrowid, fArrX, fArrY, fArrZ) )
		{
			SetPlayerObjectRot(playerid, _:arrowid, 0.0, 
				arw_GetYRotation(fArrX, fArrY, fArrZ, x, y, z), 
				arw_PointToPoint(fArrX, fArrY, x, y)+ARW_Z_ROT_OFFSET
			);
			return 1;
		}
		return 0;
	#endif
}

stock Float:arw_PointToPoint(Float:X, Float:Y, Float:PointX, Float:PointY)
{
	new Float:fAngle;
	if(X > PointX && Y > PointY) 
		fAngle = floatabs(atan2(floatsub(PointX, X), floatsub(PointY, Y)));
	if(X > PointX && Y <= PointY) 
		fAngle = floatadd(floatabs(atan2(floatsub(Y, PointY), floatsub(PointX, X))), 270.0);
	if(X <= PointX && Y > PointY) 
		fAngle = floatadd(floatabs(atan2(floatsub(PointY, Y), floatsub(X, PointX))), 90.0);
	if(X <= PointX && Y <= PointY) 
		fAngle = floatadd(floatabs(atan2(floatsub(X, PointX), floatsub(Y, PointY))), 180.0);
	return fAngle >= 360.0 ? floatsub(fAngle, 360.0) : fAngle;
}

stock Float:arw_GetYRotation(Float:x,Float:y,Float:z, Float:ax, Float:ay, Float:az)
{
    new Float:xd = ax - x;
    new Float:yd = ay - y;
    new Float:dist = floatsqroot(xd*xd+yd*yd);
    new Float:Yoff = atan((z-az)/dist);
    return Yoff-90;
}

//The following 2 functions wont work with this object model id unfortunatly
/*
	Function:
		SetArrowMaterial
	Description:
		Sets a new material for the arrow
	Param(s):
		arrowid 		- The arrowid returned by "CreateArrow" function.
		objectid 		- The object modelid with the replacement material
		txd_name[]		- Name of the TXD file that holds the material.
		texturename[]   - Name of the texture to use as a replacement
	Returns:
		Value returned by SetObjectMaterial or SetDynamicObjectMaterial


stock SetArrowMaterial(Arrow:arrowid, objectid, txd_name[], texturename[], objcolor=0)
{
	#if !defined ARROW_NO_STREAMER
		return SetDynamicObjectMaterial(_:arrowid, 0, objectid, txd_name, texturename, objcolor);
	#else
		return SetObjectMaterial(_:arrowid, 0, objectid, txd_name, texturename, objcolor);
	#endif
}
*/
/*
	Function:
		SetPlayerArrowMaterial
	Description:
		Sets a new material for the arrow
	Param(s):
		playerid		- The player who the arrow is streamed for.
		arrowid 		- The arrowid returned by "CreateArrow" function.
		objectid 		- The object modelid with the replacement material
		txd_name[]		- Name of the TXD file that holds the material.
		texturename[]   - Name of the texture to use as a replacement
	Returns:
		Value returned by SetObjectMaterial or SetDynamicObjectMaterial


stock SetPlayerArrowMaterial(playerid, Arrow:arrowid, objectid, txd_name[], texturename[], objcolor=0)
{
	#pragma unused playerid
	#if !defined ARROW_NO_STREAMER
		return SetDynamicObjectMaterial(_:arrowid, 0, objectid, txd_name, texturename, objcolor);
	#else
		return SetPlayerObjectMaterial(playerid, _:arrowid, 0, objectid, txd_name, texturename, objcolor);
	#endif
}
*/