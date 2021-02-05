package screeps;

using haxe.extern.EitherType;

using screeps.Globals.ExitConstant;

using screeps.Globals.ScreepsReturnCode;

using screeps.Globals.TerrainType;

using screeps.Room.RoomTerrain;

using screeps.Room.RoomStatus;

using screeps.Style.Align;

typedef RoomOrRoomName = EitherType<String, Room>;


// No static is available

extern class MapVisual {
    /**
     * Draw a line.
     * @param pos1 The start position object.
     * @param pos2 The finish position object.
     * @param style The optional style
     * @returns The MapVisual object, for chaining.
     */
    public function line(pos1: RoomPosition, pos2: RoomPosition, ?style: MapLineStyle): MapVisual;

    /**
     * Draw a circle.
     * @param pos The position object of the center.
     * @param style The optional style
     * @returns The MapVisual object, for chaining.
     */
     public function circle(pos: RoomPosition, ?style: MapCircleStyle): MapVisual;

    /**
     * Draw a rectangle.
     * @param topLeftPos The position object of the top-left corner.
     * @param width The width of the rectangle.
     * @param height The height of the rectangle.
     * @param style The optional style
     * @returns The MapVisual object, for chaining.
     */
     public function rect(topLeftPos: RoomPosition, width: Int, height: Int, ?style: MapPolyStyle): MapVisual;

    /**
     * Draw a polyline.
     * @param points An array of points. Every item should be a `RoomPosition` object.
     * @param style The optional style
     * @returns The MapVisual object, for chaining.
     */
     public function poly(points: Array<RoomPosition>, ?style: MapPolyStyle): MapVisual;

    /**
     * Draw a text label. You can use any valid Unicode characters, including emoji.
     * @param text The text message.
     * @param pos The position object of the label baseline.
     * @param style The optional style
     * @returns The MapVisual object, for chaining
     */
     public function text(text: String, pos: RoomPosition, ?style: MapTextStyle): MapVisual;

    /**
     * Remove all visuals from the map.
     * @returns The MapVisual object, for chaining
     */
     public function clear(): MapVisual;

    /**
     * Get the stored size of all visuals added on the map in the current tick. It must not exceed 1024,000 (1000 KB).
     * @returns The size of the visuals in bytes.
     */
     public function getSize(): Int;

    /**
     * Returns a compact representation of all visuals added on the map in the current tick.
     * @returns A string with visuals data. There's not much you can do with the string besides store them for later.
     */
     public function export(): String;

    /**
     * Add previously exported (with `Game.map.visual.export`) map visuals to the map visual data of the current tick.
     * @param data The string returned from `Game.map.visual.export`.
     * @returns The MapVisual object itself, so that you can chain calls.
     */
     @:native("import") public function import_(data: String): MapVisual;
}

typedef MapLineStyle = {
    /**
     * Line width, default is 0.1.
     */
    var ?width: Int;
    /**
     * Line color in the following format: #ffffff (hex triplet). Default is #ffffff.
     */
    var ?color: Int;
    /**
     * Opacity value, default is 0.5.
     */
    var ?opacity: Int;
    /**
     * Either undefined (solid line), dashed, or dotted. Default is undefined.
     */
    var ?lineStyle: Style;
}

typedef MapPolyStyle = {
    /**
     * Fill color in the following format: #ffffff (hex triplet). Default is #ffffff.
     */
    var ?fill: String;
    /**
     * Opacity value, default is 0.5.
     */
    var ?opacity: Int;
    /**
     * Stroke color in the following format: #ffffff (hex triplet). Default is undefined (no stroke).
     */
    var ?stroke: EitherType<String,Void>;
    /**
     * Stroke line width, default is 0.5.
     */
    var ?strokeWidth: Int;
    /**
     * Either undefined (solid line), dashed, or dotted. Default is undefined.
     */
    var ?lineStyle: Style;
}

typedef MapCircleStyle = MapPolyStyle & {
    /**
     * Circle radius, default is 10.
     */
    var ?radius: Int;
}

typedef MapTextStyle = {
    /**
     * Font color in the following format: #ffffff (hex triplet). Default is #ffffff.
     */
    var ?color: String;
    /**
     * The font family, default is sans-serif
     */
   var ?fontFamily: String;
    /**
     * The font size in game coordinates, default is 10
     */
   var ?fontSize: Int;
    /**
     * The font style ('normal', 'italic' or 'oblique')
     */
   var ?fontStyle: String;
    /**
     * The font variant ('normal' or 'small-caps')
     */
   var ?fontVariant: String;
    /**
     * Stroke color in the following format: #ffffff (hex triplet). Default is undefined (no stroke).
     */
   var ?stroke: String;
    /**
     * Stroke width, default is 0.15.
     */
   var ?strokeWidth: Int;
    /**
     * Background color in the following format: #ffffff (hex triplet). Default is undefined (no background). When background is enabled, text vertical align is set to middle (default is baseline).
     */
   var ?backgroundColor: String;
    /**
     * Background rectangle padding, default is 2.
     */
   var ?backgroundPadding: Int;
    /**
     * Text align, either center, left, or right. Default is center.
     */
   var ?align: Align;
    /**
     * Opacity value, default is 0.5.
     */
   var ?opacity: Int;
}


/**
 * The options that can be accepted by `findRoute()` and friends.
 */
typedef RouteOptions = {
  var routeCallback: (roomName: String, fromRoomName: String) -> Any;
}

extern enum abstract ExitsRecord(String) {
    var ONE = "1";
    var THREE =  "3";
    var FIVE = "5";
    var SEVEN = "7";
} 

typedef ExitsInformation = Any;

/**
 * A global object representing world map. Use it to navigate between rooms. The object is accessible via Game.map property.
 */
extern class GameMap {
	/**
	 * List all exits available from the room with the given name.
	 * @param roomName The room name.
	 * @returns The exits information or null if the room not found.
	 */
	public function describeExits(roomName:String):ExitsInformation;

	/**
	 * Find the exit direction from the given room en route to another room.
	 * @param fromRoom Start room name or room object.
	 * @param toRoom Finish room name or room object.
	 * @param opts (optional) An object with the pathfinding options.
	 * @returns The room direction constant, one of the following:
	 * FIND_EXIT_TOP, FIND_EXIT_RIGHT, FIND_EXIT_BOTTOM, FIND_EXIT_LEFT
	 * Or one of the following Result codes:
	 * ERR_NO_PATH, ERR_INVALID_ARGS
	 */
	public function findExit(fromRoom:RoomOrRoomName, toRoom:RoomOrRoomName, ?opts:RouteOptions):EitherType<ExitConstant, ScreepsReturnCode>;

	/**
	 * Find route from the given room to another room.
	 * @param fromRoom Start room name or room object.
	 * @param toRoom Finish room name or room object.
	 * @param opts (optional) An object with the pathfinding options.
	 * @returns the route array or ERR_NO_PATH code
	 */
	public function findRoute(fromRoom:RoomOrRoomName, toRoom:RoomOrRoomName,
		?opts:RouteOptions):EitherType<Array<{exit:ExitConstant, room:String}>, ScreepsReturnCode>;

	/**
	 * Get the linear distance (in rooms) between two rooms. You can use this function to estimate the energy cost of
	 * sending resources through terminals, or using observers and nukes.
	 * @param roomName1 The name of the first room.
	 * @param roomName2 The name of the second room.
	 * @param continuous Whether to treat the world map continuous on borders. Set to true if you
	 *                   want to calculate the trade or terminal send cost. Default is false.
	 */ public function getRoomLinearDistance(roomName1:String, roomName2:String, ?continuous:Bool):Int;

	/**
	 * Get terrain type at the specified room position. This method works for any room in the world even if you have no access to it.
	 * @param x X position in the room.
	 * @param y Y position in the room.
	 * @param pos The position object.
	 * @param roomName The room name.
	 * @deprecated use `Game.map.getRoomTerrain` instead
	 */
	@:overload(function(pos:RoomPosition):TerrainType {})
	public function getTerrainAt(x:Int, y:Int, roomName:String):TerrainType;

	/**
	 * Get room terrain for the specified room. This method works for any room in the world even if you have no access to it.
	 * @param roomName String name of the room.
	 */ public function getRoomTerrain(roomName:String):RoomTerrain;

	/**
	 * Returns the world size as a number of rooms between world corners. For example, for a world with rooms from W50N50 to E50S50 this method will return 102.
	 */ public function getWorldSize():Int;

	/**
	 * Check if the room is available to move into.
	 * @param roomName The room name.
	 * @returns A boolean value.
	 * @deprecated Use `Game.map.getRoomStatus` instead
	 */ public function isRoomAvailable(roomName:String):Bool;

	/**
	 * Get the room status to determine if it's available, or in a reserved area.
	 * @param roomName The room name.
	 * @returns An object with the following properties {status: "normal" | "closed" | "novice" | "respawn", timestamp: number}
	 */ public function getRoomStatus(roomName:String):RoomStatus;

	/**
	 * Map visuals provide a way to show various visual debug info on the game map.
	 * You can use the `Game.map.visual` object to draw simple shapes that are visible only to you.
	 *
	 * Map visuals are not stored in the database, their only purpose is to display something in your browser.
	 * All drawings will persist for one tick and will disappear if not updated.
	 * All `Game.map.visual` calls have no added CPU cost (their cost is natural and mostly related to simple JSON.serialize calls).
	 * However, there is a usage limit: you cannot post more than 1000 KB of serialized data.
	 *
	 * All draw coordinates are measured in global game coordinates (`RoomPosition`).
	 */ var visual:MapVisual;
}
