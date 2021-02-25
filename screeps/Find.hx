package screeps;

import haxe.extern.EitherType;
import screeps.Creep.AnyCreep;
import screeps.Resource;
import screeps.Structure;
import screeps.Cost.CostMatrix;
import screeps.Style.PolyStyle;

typedef FindPathOpts = {
	/**
	 * Treat squares with creeps as walkable. Can be useful with too many moving creeps around or in some other cases. The default
	 * value is false.
	 */
	var ?ignoreCreeps:Bool;

	/**
	 * Treat squares with destructible structures (constructed walls, ramparts, spawns, extensions) as walkable. Use this flag when
	 * you need to move through a territory blocked by hostile structures. If a creep with an ATTACK body part steps on such a square,
	 * it automatically attacks the structure. The default value is false.
	 */
	var ?ignoreDestructibleStructures:Bool;

	/**
	 * Ignore road structures. Enabling this option can speed up the search. The default value is false. This is only used when the
	 * new PathFinder is enabled.
	 */
	var ?ignoreRoads:Bool;

	/**
	 * You can use this callback to modify a CostMatrix for any room during the search. The callback accepts two arguments, roomName
	 * and costMatrix. Use the costMatrix instance to make changes to the positions costs. If you return a new matrix from this callback,
	 * it will be used instead of the built-in cached one. This option is only used when the new PathFinder is enabled.
	 *
	 * @param roomName The name of the room.
	 * @param costMatrix The current CostMatrix
	 * @returns The new CostMatrix to use
	 */
	public function costCallback(roomName:String, costMatrix:CostMatrix):EitherType<Void, CostMatrix>;

	/**
	 * An array of the room's objects or RoomPosition objects which should be treated as walkable tiles during the search. This option
	 * cannot be used when the new PathFinder is enabled (use costCallback option instead).
	 */
	var ?ignore:EitherType<Array<Any>, RoomPosition>;

	/**
	 * An array of the room's objects or RoomPosition objects which should be treated as obstacles during the search. This option cannot
	 * be used when the new PathFinder is enabled (use costCallback option instead).
	 */
	var ?avoid:EitherType<Array<Any>, Array<RoomPosition>>;

	/**
	 * The maximum limit of possible pathfinding operations. You can limit CPU time used for the search based on ratio 1 op ~ 0.001 CPU.
	 * The default value is 2000.
	 */
	var ?maxOps:Int;

	/**
	 * Weight to apply to the heuristic in the A* formula F = G + weight * H. Use this option only if you understand the underlying
	 * A* algorithm mechanics! The default value is 1.2.
	 */
	var ?heuristicWeight:Int;

	/**
	 * If true, the result path will be serialized using Room.serializePath. The default is false.
	 */
	var ?serialize:Bool;

	/**
	 * The maximum allowed rooms to search. The default (and maximum) is 16. This is only used when the new PathFinder is enabled.
	 */
	var ?maxRooms:Int;

	/**
	 * Path to within (range) tiles of target tile. The default is to path to the tile that the target is on (0).
	 */
	var ?range:Int;

	/**
	 * Cost for walking on plain positions. The default is 1.
	 */
	var ?plainCost:Int;

	/**
	 * Cost for walking on swamp positions. The default is 5.
	 */
	var ?swampCost:Int;
}

typedef MoveToOpts = FindPathOpts & {
    /**
     * This option enables reusing the path found along multiple game ticks. It allows to save CPU time, but can result in a slightly
     * slower creep reaction behavior. The path is stored into the creep's memory to the `_move` property. The `reusePath` value defines
     * the amount of ticks which the path should be reused for. The default value is 5. Increase the amount to save more CPU, decrease
     * to make the movement more consistent. Set to 0 if you want to disable path reusing.
     */
    var ?reusePath: Int;

    /**
     * If `reusePath` is enabled and this option is set to true, the path will be stored in memory in the short serialized form using
     * `Room.serializePath`. The default value is true.
     */
    var ?serializeMemory: Bool;

    /**
     * If this option is set to true, `moveTo` method will return `ERR_NOT_FOUND` if there is no memorized path to reuse. This can
     * significantly save CPU time in some cases. The default value is false.
     */
    var ?noPathFinding: Bool;

    /**
     * Draw a line along the creep’s path using `RoomVisual.poly`. You can provide either an empty object or custom style parameters.
     */
    var ?visualizePathStyle: PolyStyle;
}

typedef Pos = {
	var pos:RoomPosition;
	var range:Int;
}

/**
 * An object containing additional pathfinding flags.
 */
 typedef PathFinderOpts = {
    /**
     * Cost for walking on plain positions. The default is 1.
     */
    var ?plainCost: Int;
    /**
     * Cost for walking on swamp positions. The default is 5.
     */
   var ?swampCost: Int;
    /**
     * Instead of searching for a path to the goals this will search for a path away from the goals.
     * The cheapest path that is out of range of every goal will be returned. The default is false.
     */
   var ?flee: Bool;
    /**
     * The maximum allowed pathfinding operations. You can limit CPU time used for the search based on ratio 1 op ~ 0.001 CPU. The default value is 2000.
     */
   var ?maxOps: Int;
    /**
     * The maximum allowed rooms to search. The default (and maximum) is 16.
     */
   var ?maxRooms: Int;
    /**
     * The maximum allowed cost of the path returned. If at any point the pathfinder detects that it is impossible to find
     * a path with a cost less than or equal to maxCost it will immediately halt the search. The default is Infinity.
     */
   var ?maxCost: Int;
    /**
     * Weight to apply to the heuristic in the A* formula F = G + weight * H. Use this option only if you understand
     * the underlying A* algorithm mechanics! The default value is 1.
     */
   var ?heuristicWeight: Int;

    /**
     * Request from the pathfinder to generate a CostMatrix for a certain room. The callback accepts one argument, roomName.
     * This callback will only be called once per room per search. If you are running multiple pathfinding operations in a
     * single room and in a single tick you may consider caching your CostMatrix to speed up your code. Please read the
     * CostMatrix documentation below for more information on CostMatrix.
     *
     * @param roomName The name of the room the pathfinder needs a cost matrix for.
     */
   var ?roomCallback: (roomName: String) -> EitherType<Bool,CostMatrix>;
}

/**
 * An object containing:
 * path - An array of RoomPosition objects.
 * ops - Total number of operations performed before this path was calculated.
 * cost - The total cost of the path as derived from `plainCost`, `swampCost` and any given CostMatrix instances.
 * incomplete - If the pathfinder fails to find a complete path, this will be true.
 *   Note that `path` will still be populated with a partial path which represents the closest path it could find given the search parameters.
 */
 typedef PathFinderPath = {
    /**
     * An array of RoomPosition objects.
     */
    var path: Array<RoomPosition>;
    /**
     * Total number of operations performed before this path was calculated.
     */
    var ops: Int;
    /**
     * The total cost of the path as derived from `plainCost`, `swampCost` and any given CostMatrix instances.
     */
    var cost: Int;
    /**
     * If the pathfinder fails to find a complete path, this will be true.
     *
     * Note that `path` will still be populated with a partial path which represents the closest path it could find given the search parameters.
     */
    var incomplete: Bool;
}


/**
 * Contains powerful methods for pathfinding in the game world. Support exists for custom navigation costs and paths which span multiple rooms.
 * Additionally PathFinder can search for paths through rooms you can't see, although you won't be able to detect any dynamic obstacles like creeps or buildings.
 */
extern class PathFinder {
	/**
	 * Container for custom navigation cost data.
	 */
	@:native("CostMatrix") var costMatrix:CostMatrix;

	/**
	 * Find an optimal path between origin and goal.
	 *
	 * @param origin The start position.
	 * @param goal goal A RoomPosition, an object containing a RoomPosition and range or an array of either.
	 * @param opts An object containing additional pathfinding flags.
	 */
	public function search(origin:RoomPosition, goal:EitherType<RoomPosition, EitherType<Pos, Array<RoomPosition>>>, ?opts:PathFinderOpts):PathFinderPath;

	/**
	 * Specify whether to use this new experimental pathfinder in game objects methods.
	 * This method should be invoked every tick. It affects the following methods behavior:
	 * * `Room.findPath`
	 * * `RoomPosition.findPathTo`
	 * * `RoomPosition.findClosestByPath`
	 * * `Creep.moveTo`
	 *
	 * @deprecated This method is deprecated and will be removed soon.
	 * @param isEnabled Whether to activate the new pathfinder or deactivate.
	 */
	public function use(isEnabled:Bool):Void;
}

typedef FindTypes = haxe.macro.MacroType<[
	screeps.Macros.MacroUtils.buildNestedFields([
		"RoomPosition", "AnyCreep", "Source", "Resource", "Structure", "Flag", "Mineral", "Nuke", "TombStone", "Deposit", "Ruin"
	])
]>;
