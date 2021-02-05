package screeps;

import screeps.Style.TextStyle;
import screeps.Style.PolyStyle;
import screeps.Style.CircleStyle;
import screeps.Style.LineStyle;
import screeps.Globals.Look;
import screeps.Look.AllLookAtTypes;
import screeps.Look.LookAtResultMatrix;
import screeps.RoomPosition.Target;
import screeps.Globals.Terrain;
import screeps.Globals.Num;
import screeps.RoomPosition.PathStep;
import screeps.Find.FindPathOpts;
import screeps.Look.LookAtResult;
import screeps.Globals.ExitConstant;
import screeps.Globals.FindStructure;
import screeps.Globals.Find;
import screeps.Find.FindTypes;
import screeps.RoomPosition.FilterOptions;
import screeps.Globals.Colors;
import screeps.Globals.StructureSpawn;
import screeps.Globals.StructureConstant;
import screeps.RoomPosition.RoomTarget;
import screeps.Globals.ScreepsReturnCode;
import screeps.Globals.BuildableStructure;
import haxe.ds.Option;
import screeps.Structure.StructureTerminal;
import screeps.Structure.StructureStorage;
import screeps.Structure.StructureController;
import screeps.Globals.Mode;
import screeps.Utils.JsObject;
import screeps.Event.EventItem;
import screeps.Globals.Pwr;
import haxe.extern.EitherType;
import screeps.Globals.EFFECT_INVULNERABILITY;
import screeps.Globals.EFFECT_COLLAPSE_TIMER;

typedef Effect = EitherType<EFFECT_INVULNERABILITY, EFFECT_COLLAPSE_TIMER>;

extern enum abstract PermanentStatus(String) {
	var normal = "normal";
	var closed = "closed";
}

extern enum abstract TemporaryStatus(String) {
	var novice = "novice";
	var respawn = "respawn";
}

typedef RoomStatusPermanent = {
	var status:PermanentStatus;
	var timestamp:Any;
}

typedef RoomStatusTemporary = {
	var status:TemporaryStatus;
	var timestamp:Int;
}

typedef RoomStatus = EitherType<RoomStatusPermanent, RoomStatusTemporary>;

/**
 * Natural effect applied to room object
 */
typedef NaturalEffect = {
	/**
	 * Effect ID of the applied effect. `EFFECT_*` constant.
	 */
	final effect:Effect;

	/**
	 * How many ticks will the effect last.
	 */
	final ticksRemaining:Int;
}

/**
 * Effect applied to room object as result of a `PowerCreep.usePower`.
 */
typedef PowerEffect = {
	/**
	 * Power level of the applied effect.
	 */
	final level:Int;

	/**
	 * Effect ID of the applied effect. `PWR_*` constant.
	 */
	final effect:Pwr;

	/**
	 * @deprecated Power ID of the applied effect. `PWR_*` constant. No longer documented, will be removed.
	 */
	final power:Pwr;

	/**
	 * How many ticks will the effect last.
	 */
	final ticksRemaining:Int;
};

extern class RoomVisual {
	/**
	 * You can create new RoomVisual object using its constructor.
	 * @param roomName The room name. If undefined, visuals will be posted to all rooms simultaneously.
	 */
	@:selfCall
	public function new(?roomName:String):Void;

	/**
	 * The name of the room.
	 */
	var roomName:String;

	/**
	 * Draw a line.
	 * @param x1 The start X coordinate.
	 * @param y1 The start Y coordinate.
	 * @param x2 The finish X coordinate.
	 * @param y2 The finish Y coordinate.
	 * @param pos1 The start position object.
	 * @param pos2 The finish position object.
	 * @param style The (optional) style.
	 * @returns The RoomVisual object, for chaining.
	 */
	@:overload(function(pos1:RoomPosition, pos2:RoomPosition, ?style:LineStyle):RoomVisual {})
	public function line(x1:Int, y1:Int, x2:Int, y2:Int, ?style:LineStyle):RoomVisual;

	/**
	 * Draw a circle.
	 * @param x The X coordinate of the center.
	 * @param pos The position object of the center.
	 * @param y The Y coordinate of the center.
	 * @param style The (optional) style.
	 * @returns The RoomVisual object, for chaining.
	 */
	@:overload(function(pos:RoomPosition, ?style:CircleStyle):RoomVisual {})
	public function circle(x:Int, y:Int, ?style:CircleStyle):RoomVisual;

	/**
	 * Draw a rectangle.
	 * @param x The X coordinate of the top-left corner.
	 * @param y The Y coordinate of the top-left corner.
	 * @param w The width of the rectangle.
	 * @param h The height of the rectangle.
	 * @param topLeftPos The position object of the top-left corner.
	 * @param width The width of the rectangle.
	 * @param height The height of the rectangle.
	 * @param style The (optional) style.
	 * @returns The RoomVisual object, for chaining.
	 */
	@:overload(function(topLeftPos:RoomPosition, width:Int, height:Int, ?style:PolyStyle):RoomVisual {})
	public function rect(x:Int, y:Int, w:Int, h:Int, ?style:PolyStyle):RoomVisual;

	/**
	 * Draw a polygon.
	 * @param points An array of points. Every array item should be either an array with 2 numbers (i.e. [10,15]), or a RoomPosition object.
	 * @param style The (optional) style.
	 * @returns The RoomVisual object, for chaining.
	 */
	public function poly(points:Array<EitherType<Array<Int>, RoomPosition>>, ?style:PolyStyle):RoomVisual;

	/**
	 * Draw a text label.
	 * @param text The text message.
	 * @param x The X coordinate of the label baseline center point.
	 * @param y The Y coordinate of the label baseline center point.
	 * @param pos The position object of the center.
	 * @param style The (optional) text style.
	 * @returns The RoomVisual object, for chaining.
	 */
	@:overload(function(text:String, pos:RoomPosition, ?style:TextStyle):RoomVisual {})
	public function text(text:Int, x:Int, y:Int, ?style:TextStyle):RoomVisual;

	/**
	 * Remove all visuals from the room.
	 * @returns The RoomVisual object, for chaining.
	 */
	public function clear():RoomVisual;

	/**
	 * Get the stored size of all visuals added in the room in the current tick.
	 * It must not exceed 512,000 (500 KB).
	 * @returns The size of the visuals in bytes.
	 */
	public function getSize():Int;

	/**
	 * Returns a compact representation of all visuals added in the room in the current tick.
	 * @returns A string with visuals data. There's not much you can do with the string besides store them for later.
	 */
	public function export():String;

	/**
	 * Add previously exported (with `RoomVisual.export`) room visuals to the room visual data of the current tick.
	 * @param data The string returned from `RoomVisual.export`.
	 * @returns The RoomVisual object itself, so that you can chain calls.
	 */
	@:native("import") public function import_(data:String):RoomVisual;
}

/**
 * Result of Object that contains all terrain for a room
 */
interface RoomTerrain {
	/**
	 * Get terrain type at the specified room position. This method works for any room in the world even if you have no access to it.
	 * @param x X position in the room.
	 * @param y Y position in the room.
	 * @return number Number of terrain mask like: TERRAIN_MASK_SWAMP | TERRAIN_MASK_WALL
	 */
	public function get(x:Int, y:Int):EitherType<Num, Terrain>;
}

/**
 * An object representing the room in which your units and structures are in.
 *
 * It can be used to look around, find paths, etc.
 *
 * Every object in the room contains its linked Room instance in the room property.
 */
extern class Room {
	final prototype:Room;

	/**
	 * The Controller structure of this room, if present, otherwise undefined.
	 */
	var controller:Option<StructureController>;

	/**
	 * Total amount of energy available in all spawns and extensions in the room.
	 */
	var energyAvailable:Int;

	/**
	 * Total amount of energyCapacity of all spawns and extensions in the room.
	 */
	var energyCapacityAvailable:Int;

	/**
	 * Returns an array of events happened on the previous tick in this room.
	 */
	public function getEventLog(?raw:Bool):Array<EventItem>;

	/**
	 * A shorthand to `Memory.rooms[room.name]`. You can use it for quick access the room’s specific memory data object.
	 */
	var memory:JsObject<Any>;

	/**
	 * One of the `MODE_*` constants.
	 */
	var mode:Mode;

	/**
	 * The name of the room.
	 */
	final name:String;

	/**
	 * The Storage structure of this room, if present, otherwise undefined.
	 */
	var storage:Option<StructureStorage>;

	/**
	 * The Terminal structure of this room, if present, otherwise undefined.
	 */
	var terminal:Option<StructureTerminal>;

	/**
	 * A RoomVisual object for this room. You can use this object to draw simple shapes (lines, circles, text labels) in the room.
	 */
	var visual:RoomVisual;

	/**
	 * Create new ConstructionSite at the specified location.
	 * @param x The X position.
	 * @param y The Y position.
	 * @param pos Can be a RoomPosition object or any object containing RoomPosition.
	 * @param structureType One of the following constants: STRUCTURE_EXTENSION, STRUCTURE_RAMPART, STRUCTURE_ROAD, STRUCTURE_SPAWN, STRUCTURE_WALL, STRUCTURE_LINK
	 * @param name The name of the structure, for structures that support it (currently only spawns).
	 * @returns Result Code: OK, ERR_INVALID_TARGET, ERR_INVALID_ARGS, ERR_RCL_NOT_ENOUGH
	 */
	@:overload(function(pos:RoomTarget, structure:StructureConstant):ScreepsReturnCode {})
	@:overload(function(x:Int, y:Int, structureType:StructureSpawn, ?name:String):ScreepsReturnCode {})
	@:overload(function(pos:RoomTarget, structureType:StructureSpawn, ?name:String):ScreepsReturnCode {})
	public function createConstructionSite(x:Int, y:Int, structureType:BuildableStructure):ScreepsReturnCode;

	/**
	 * Create new Flag at the specified location.
	 * @param pos Can be a RoomPosition object or any object containing RoomPosition.
	 * @param x The X position.
	 * @param y The Y position.
	 * @param name (optional) The name of a new flag.
	 *
	 * It should be unique, i.e. the Game.flags object should not contain another flag with the same name (hash key).
	 *
	 * If not defined, a random name will be generated.
	 *
	 * The maximum length is 60 characters.
	 * @param color The color of a new flag. Should be one of the COLOR_* constants. The default value is COLOR_WHITE.
	 * @param secondaryColor The secondary color of a new flag. Should be one of the COLOR_* constants. The default value is equal to color.
	 * @returns The name of a new flag, or one of the following error codes: ERR_NAME_EXISTS, ERR_INVALID_ARGS
	 */
	@:overload(function(pos:RoomTarget, ?name:String, ?color:Colors, ?secondaryColor:Colors):EitherType<ScreepsReturnCode, String> {})
	public function createFlag(x:Int, y:Int, ?name:String, ?color:Colors, ?secondaryColor:Colors):EitherType<ScreepsReturnCode, String>;

	/**
	 * Find all objects of the specified type in the room.
	 * @param type One of the following constants:
	 *  * FIND_CREEPS
	 *  * FIND_MY_CREEPS
	 *  * FIND_HOSTILE_CREEPS
	 *  * FIND_MY_SPAWNS
	 *  * FIND_HOSTILE_SPAWNS
	 *  * FIND_SOURCES
	 *  * FIND_SOURCES_ACTIVE
	 *  * FIND_DROPPED_RESOURCES
	 *  * FIND_STRUCTURES
	 *  * FIND_MY_STRUCTURES
	 *  * FIND_HOSTILE_STRUCTURES
	 *  * FIND_FLAGS
	 *  * FIND_CONSTRUCTION_SITES
	 *  * FIND_EXIT_TOP
	 *  * FIND_EXIT_RIGHT
	 *  * FIND_EXIT_BOTTOM
	 *  * FIND_EXIT_LEFT
	 *  * FIND_EXIT
	 * @param opts An object with additional options
	 * @returns An array with the objects found.
	 */
	@:overload(function<T:StructureConstant>(type:FindStructure, ?opts:FilterOptions):Array<T> {})
	public function find<K:Find>(type:K, ?opts:FilterOptions):Array<FindTypes>;

	/**
	 * Find the exit direction en route to another room.
	 * @param room Another room name or room object.
	 * @returns The room direction constant, one of the following: FIND_EXIT_TOP, FIND_EXIT_RIGHT, FIND_EXIT_BOTTOM, FIND_EXIT_LEFT
	 * Or one of the following error codes: ERR_NO_PATH, ERR_INVALID_ARGS
	 */
	public function findExitTo(room:EitherType<String, Room>):EitherType<ExitConstant, ScreepsReturnCode>;

	/**
	 * Find an optimal path inside the room between fromPos and toPos using A* search algorithm.
	 * @param fromPos The start position.
	 * @param toPos The end position.
	 * @param opts (optional) An object containing additonal pathfinding flags
	 * @returns An array with path steps
	 */
	public function findPath(fromPos:RoomPosition, toPos:RoomPosition, ?opts:FindPathOpts):Array<PathStep>;

	/**
	 * Creates a RoomPosition object at the specified location.
	 * @param x The X position.
	 * @param y The Y position.
	 * @returns A RoomPosition object or null if it cannot be obtained.
	 */
	public function getPositionAt(x:Int, y:Int):EitherType<RoomPosition, Void>;

	/**
	 * Get a Room.Terrain object which provides fast access to static terrain data.
	 * This method works for any room in the world even if you have no access to it.
	 */
	public function getTerrain():RoomTerrain;

	/**
	 * Get the list of objects at the specified room position.
	 * @param x The X position.
	 * @param y The Y position.
	 * @param target Can be a RoomPosition object or any object containing RoomPosition.
	 * @returns An array with objects at the specified position
	 */
	@:overload(function(target:Target):Array<LookAtResult> {})
	public function lookAt(x:Int, y:Int):Array<LookAtResult>;

	/**
	 * Get the list of objects at the specified room area. This method is more CPU efficient in comparison to multiple lookAt calls.
	 * @param top The top Y boundary of the area.
	 * @param left The left X boundary of the area.
	 * @param bottom The bottom Y boundary of the area.
	 * @param right The right X boundary of the area.
	 * @param asArray Set to true if you want to get the result as a plain array.
	 * @returns An object with all the objects in the specified area
	 */
	@:overload(function(top:Int, left:Int, bottom:Int, right:Int, asArray:Bool = true):LookAtResultMatrix {})
	public function lookAtArea(top:Int, left:Int, bottom:Int, right:Int, ?asArray:Bool = false):LookAtResultMatrix;

	/**
	 * Get the objects at the given position.
	 * @param type One of the LOOK_* constants.
	 * @param x The X position.
	 * @param y The Y position.
	 * @param target Can be a RoomPosition object or any object containing RoomPosition.
	 * @returns An array of Creep at the given position.
	 */
	@:overload(function<T:Look>(type:T, target:RoomTarget):Array<AllLookAtTypes> {})
	public function lookForAt<T:Look>(type:T, x:Int, y:Int):Array<AllLookAtTypes>;

	/**
	 * Get the given objets in the supplied area.
	 * @param type One of the LOOK_* constants
	 * @param top The top (Y) boundry of the area.
	 * @param left The left (X) boundry of the area.
	 * @param bottom The bottom (Y) boundry of the area.
	 * @param right The right(X) boundry of the area.
	 * @param asArray Flatten the results into an array?
	 * @returns An object with the sstructure object[X coord][y coord] as an array of found objects.
	 */
	@:overload(function<T:AllLookAtTypes>(type:T, top:Int, left:Int, bottom:Int, right:Int, ?asArray:Bool = true):Array<AllLookAtTypes> {})
	public function lookForAtArea<T:AllLookAtTypes>(type:T, top:Int, left:Int, bottom:Int, right:Int, ?asArray:Bool = false):LookAtResultMatrix;
}

/**
 * Discriminated union of possible effects on `effect`
 */
typedef RoomObjectEffect = EitherType<NaturalEffect, PowerEffect>;

extern class RoomObject {
	final prototype:RoomObject;
	var effects:Array<RoomObjectEffect>;
	var roomPosition:RoomPosition;
	var room:EitherType<Room, Void>;

	@:selfCall
	public function new(x:Int, y:Int, roomName:String):Void;
}
