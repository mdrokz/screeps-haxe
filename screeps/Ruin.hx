package screeps;

import screeps.Structure.AnyStructure;
import screeps.Store.GenericStore;
import screeps.Room.RoomObject;

/**
 * A destroyed structure. This is a walkable object.
 * <ul>
 *     <li>Decay: 500 ticks except some special cases</li>
 * </ul>
 */
// @:build(screeps.Macros.MacroUtils.extendFields(RoomObject, ["prototype"]))
extern class Ruin extends RoomObject {
	/**
	 * A unique object identificator.
	 * You can use {@link Game.getObjectById} method to retrieve an object instance by its id.
	 */
	var id:String;

	/**
	 * Time of destruction.
	 */
	var destroyTime:Int;

	/**
	 * An object with the ruin contents.
	 */
	var store:GenericStore;

	/**
	 * The amount of game ticks before this ruin decays.
	 */
	var ticksToDecay:Int;

	/**
	 * An object containing the destroyed structure.
	 */
	var structure:AnyStructure;

    @:selfCall
    public function new(): Void;
}
