package screeps;

import haxe.extern.EitherType;
import screeps.Creep.AnyCreep;
import screeps.Resource;
import screeps.Construction.ConstructionSite;
import screeps.Structure;
import screeps.Cost.CostMatrix;

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

typedef FindTypes = haxe.macro.MacroType<[
	screeps.Macros.EnumTools.buildNestedFields([
		"RoomPosition",
		"AnyCreep",
		"Source",
		"Resource",
		"Structure",
		"Flag",
		"Mineral",
		"Nuke",
		"TombStone",
		"Deposit",
		"Ruin"
	])
]>;
