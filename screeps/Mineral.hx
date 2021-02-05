package screeps;

import screeps.Globals.Minerals;
using screeps.Room.RoomObject;

/**
 * A mineral deposit object. Can be harvested by creeps with a WORK body part using the extractor structure.
 * @see http://docs.screeps.com/api/#Mineral
 */
@:build(screeps.Macros.MacroUtils.extendFields(RoomObject, ["prototype"]))
extern class Mineral {
	final prototype:Mineral;

	/**
	 * The density of this mineral deposit, one of the `DENSITY_*` constants.
	 */
	var density:Int;

	/**
	 * The remaining amount of resources.
	 */
	var mineralAmount:Int;

	/**
	 * The resource type, one of the `RESOURCE_*` constants.
	 */
	var mineralType:Minerals;

	/**
	 * A unique object identifier. You can use `Game.getObjectById` method to retrieve an object instance by its `id`.
	 */
	var id:String;

	/**
	 * The remaining time after which the deposit will be refilled.
	 */
	var ticksToRegeneration:Int;

	@:selfCall
	public function new():Void;
}
