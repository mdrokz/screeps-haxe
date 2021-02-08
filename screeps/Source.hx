package screeps;

import screeps.Room.RoomObject;

/**
 * An energy source object. Can be harvested by creeps with a WORK body part.
 */
@:build(screeps.Macros.MacroUtils.extendFields(RoomObject, ["prototype", "room"]))
extern class Source {
	/**
	 * The prototype is stored in the Source.prototype global object. You can use it to extend game objects behaviour globally:
	 */
	final prototype:Source;

	/**
	 * The remaining amount of energy.
	 */
	var energy:Int;

	/**
	 * The total amount of energy in the source. Equals to 3000 in most cases.
	 */
	var energyCapacity:Int;

	/**
	 * A unique object identifier. You can use Game.getObjectById method to retrieve an object instance by its id.
	 */
	var id:String;

	/**
	 * If you can get an instance of Source, you can see it.
	 * If you can see a Source, you can see the room it's in.
	 */
	var room:Room;

	/**
	 * The remaining time after which the source will be refilled.
	 */
	var ticksToRegeneration:Int;

	@:selfCall
	public function new():Void;
}
