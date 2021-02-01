package screeps;

import screeps.Globals.Directions;
import screeps.Globals.FindStructure;
import screeps.Find.FindTypes;
import screeps.Globals.FindClosestByPathAlgorithm;
import js.lib.Object;
import haxe.macro.Expr;
import screeps.Deposit;
import screeps.TombStone;
import screeps.Mineral;
import screeps.Construction.ConstructionSite;
import screeps.Structure;
import screeps.Resource;
import haxe.extern.EitherType;
import screeps.Globals.Colors;
import screeps.Find.FindPathOpts;
import screeps.Creep.AnyCreep;
import screeps.Globals.StructureConstant;
import screeps.Globals.ScreepsReturnCode;
import screeps.Globals.BuildableStructure;
import screeps.Source.Source;
import screeps.Globals.Find;

typedef FilterOptions = {
	?filter:EitherType<FilterFunction, EitherType<Object, String>>
}

typedef FilterFunction = (object:FindTypes) -> Bool;

typedef PathStep = {
	final x: Int;
	final dx: Int;
	final y: Int;
	final dy: Int;
	final Direction: Directions;
}

/**
 * An object representing the specified position in the room.
 *
 * Every object in the room contains RoomPosition as the pos property.
 *
 * The position object of a custom location can be obtained using the Room.getPositionAt() method or using the constructor.
 */
extern class RoomPosition {
	final prototype:RoomPosition;

	/**
	 * The name of the room.
	 */
	var roomName:String;

	/**
	 * X position in the room.
	 */
	var x:Int;

	/**
	 * Y position in the room.
	 */
	var y:Int;

	/**
	 * Create new ConstructionSite at the specified location.
	 * @param structureType One of the following constants:
	 *  * STRUCTURE_EXTENSION
	 *  * STRUCTURE_RAMPART
	 *  * STRUCTURE_ROAD
	 *  * STRUCTURE_SPAWN
	 *  * STRUCTURE_WALL
	 *  * STRUCTURE_LINK
	 * @param name The name of the structure, for structures that support it (currently only spawns).
	 */
	@:overload(function(structureType:Structure, ?name:String):ScreepsReturnCode {})
	public function createConstructionSite(structureType:BuildableStructure):ScreepsReturnCode;

	/**
	 * Create new Flag at the specified location.
	 * @param name The name of a new flag.
	 * It should be unique, i.e. the Game.flags object should not contain another flag with the same name (hash key).
	 * If not defined, a random name will be generated.
	 * @param color The color of a new flag. Should be one of the COLOR_* constants
	 * @param secondaryColor The secondary color of a new flag. Should be one of the COLOR_* constants. The default value is equal to color.
	 * @returns The name of the flag if created, or one of the following error codes: ERR_NAME_EXISTS, ERR_INVALID_ARGS
	 */
	public function createFlag(?name:String, ?color:Colors, ?secondaryColor:Colors):EitherType<ScreepsReturnCode, String>;

	/**
	 * Find the object with the shortest path from the given position. Uses A* search algorithm and Dijkstra's algorithm.
	 * @param type Any of the FIND_* constants.
	 * @param objects An array of RoomPositions or objects with a RoomPosition
	 * @param opts An object containing pathfinding options (see Room.findPath), or one of the following: filter, algorithm
	 * @returns An instance of a RoomObject OR One of the supplied objects.
	 */
	@:overload(function<T:StructureConstant>(type:FindStructure, ?opts:FindPathOpts & FilterOptions & {
		?algorithm:FindClosestByPathAlgorithm
	}):EitherType<T, Void> {})
	@:overload(function<T:EitherType<_HasRoomPosition, RoomPosition>>(objects:Array<T>,
		?opts:FindPathOpts & {?filter:(object:T) -> Bool}):EitherType<T, Void> {})
	public function findClosestByPath<K:Find>(type:K,
		?opts:FindPathOpts & FilterOptions & {?algorithm:FindClosestByPathAlgorithm}):EitherType<FindTypes, Void>;

	/**
	 * Find the object with the shortest linear distance from the given position.
	 * @param type Any of the FIND_* constants.
	 * @param objects An array of RoomPositions or objects with a RoomPosition.
	 * @param opts An object containing pathfinding options (see Room.findPath), or one of the following: filter, algorithm
	 */
	@:overload(function<T:StructureConstant>(type:FindStructure, ?opts:FilterOptions):EitherType<T, Void> {})
	@:overload(function<T:EitherType<_HasRoomPosition, RoomPosition>>(objects:Array<T>, ?opts:{filter:EitherType<Object, String>}):EitherType<T, Void> {})
	public function findClosestByRange<K:Find>(type:K, ?opts:FilterOptions):EitherType<FindTypes, Void>;

	/**
	 * Find all objects in the specified linear range.
	 * @param type Any of the FIND_* constants.
     * @param objects An array of room's objects or RoomPosition objects that the search should be executed against.
	 * @param range The range distance.
	 * @param opts See Room.find.
	 */
	 @:overload(function<T:StructureConstant>(type: FindStructure,range: Int,?opts: FilterOptions): Array<T> {})
	 @:overload(function<T: EitherType<_HasRoomPosition,RoomPosition>>(objects: Array<T>,range: Int,?opts: {?filter: EitherType<Object,String>}): Array<T> {})	
	 public function findInRange<K:Find>(type:K, range:Int, ?opts:FilterOptions):Array<FindTypes>;

	 /**
     * Find an optimal path to the specified position using A* search algorithm.
     *
     * This method is a shorthand for Room.findPath. If the target is in another room, then the corresponding exit will be used as a target.
     * @param x X position in the room.
	 * @param y Y position in the room.
     * @param target Can be a RoomPosition object or any object containing RoomPosition.
     * @param opts An object containing pathfinding options flags (see Room.findPath for more details).
	 */
	 @:overload(function(target: FindStructure,?opts: FindPathOpts): Array<PathStep> {})
	 public function findPathTo(x: Int, y: Int, ?opts: FindPathOpts): Array<PathStep>;

	 /**
     * Get linear direction to the specified position.
     * @param x X position in the room.
	 * @param y Y position in the room.
	 * @param target Can be a RoomPosition object or any object containing RoomPosition.
	 */
	 @:overload(function(target: FindStructure): Directions {})
	 public function getDirectionTo(x: Int, y: Int): Directions;

	 /**
     * You can create new RoomPosition object using its constructor.
     * @param x X position in the room.
     * @param y Y position in the room.
     * @param roomName The room name.
	 */
	 @:selfCall
	 public function new(x: Int, y: Int, roomName: String): Void;
}

typedef _HasRoomPosition = {
	var pos:RoomPosition;
}
