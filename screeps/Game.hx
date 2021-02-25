package screeps;

import haxe.extern.EitherType;
import screeps.Globals.Shard;
import screeps.Globals.GlobalPowerLevel;
import screeps.Globals.GlobalControlLevel;
import screeps.Cpu.CPU;
import screeps.Structure.StructureSpawn;
import screeps.Construction.ConstructionSite;
import screeps.Creep.PowerCreep;

using screeps.Utils.JsObject;

/**
 * The main global game object containing all the gameplay information.
 */
@:native("Game") extern class Game {
	/**
	 * An object containing information about your CPU usage.
	 */
	static final cpu:CPU;

	/**
	 * A hash containing all your creeps with creep names as hash keys.
	 */
	static final creeps:JsObject<Creep>;

	/**
	 * A hash containing all your flags with flag names as hash keys.
	 */
	static final flags:JsObject<Flag>;

	/**
	 * Your Global Control Level.
	 */
	static final gcl:GlobalControlLevel;

	/**
	 * Your clobal Power Level
	 */
	static final gpl:GlobalPowerLevel;

	/**
	 * A global object representing world GameMap.
	 */
	static final map:GameMap;

	/**
	 * A global object representing the in-game market.
	 */
	static final market:Market;

	/**
	 * A hash containing all your power creeps with their names as hash keys. Even power creeps not spawned in the world can be accessed here.
	 */
	static final powerCreeps:JsObject<PowerCreep>;

	/**
	 * An object with your global resources that are bound to the account, like pixels or cpu unlocks. Each object key is a resource constant, values are resources amounts.
	 */
	static final resources:JsObject<Any>;

	/**
	 * A hash containing all the rooms available to you with room names as hash keys.
	 * A room is visible if you have a creep or an owned structure in it.
	 */
	static final rooms:JsObject<Room>;

	/**
	 * A hash containing all your spawns with spawn names as hash keys.
	 */
	static final spawns:JsObject<StructureSpawn>;

	/**
	 * A hash containing all your structures with structure id as hash keys.
	 */
	static final structures:JsObject<Structure>;

	/**
	 * A hash containing all your construction sites with their id as hash keys.
	 */
	static final constructionSites:JsObject<ConstructionSite>;

	/**
	 * An object describing the world shard where your script is currently being executed in.
	 */
	static final shard:Shard;

	/**
	 * System game tick counter. It is automatically incremented on every tick.
	 */
	static final time:Int;

	/**
	 * Get an object with the specified unique ID. It may be a game object of any type. Only objects from the rooms which are visible to you can be accessed.
	 * @param id The unique identifier.
	 * @returns an object instance or null if it cannot be found.
	 */
	public function getObjectById<T>(id:String):EitherType<T, Void>;

	/**
	 * Send a custom message at your profile email.
	 *
	 * This way, you can set up notifications to yourself on any occasion within the game.
	 *
	 * You can schedule up to 20 notifications during one game tick. Not available in the Simulation Room.
	 * @param message Custom text which will be sent in the message. Maximum length is 1000 characters.
	 * @param groupInterval If set to 0 (default), the notification will be scheduled immediately.
	 * Otherwise, it will be grouped with other notifications and mailed out later using the specified time in minutes.
	 */
	public function notify(message:String, ?groupInterval:Int):Void;
}
