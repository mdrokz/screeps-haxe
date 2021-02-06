package screeps;

using screeps.Room.RoomObject;

using screeps.Creep.AnyCreep;

using screeps.Store.GenericStore;

/**
 * A remnant of dead creeps. This is a walkable structure.
 * <ul>
 *     <li>Decay: 5 ticks per body part of the deceased creep</li>
 * </ul>
 */
 @:build(screeps.Macros.MacroUtils.extendFields(RoomObject,[]))
 @:native("Tombstone") extern class TombStone {
    /**
     * A unique object identificator.
     * You can use {@link Game.getObjectById} method to retrieve an object instance by its id.
     */
    var id: String;
    /**
     * Time of death.
     */
    var deathTime: Int;
    /**
     * An object with the tombstone contents.
     * Each object key is one of the RESOURCE_* constants, values are resources amounts.
     * RESOURCE_ENERGY is always defined and equals to 0 when empty,
     * other resources are undefined when empty.
     * You can use lodash.sum to get the total amount of contents.
     */
    var store: GenericStore;
    /**
     * The amount of game ticks before this tombstone decays.
     */
    var ticksToDecay: Int;
    /**
     * An object containing the deceased creep.
     */
    var creep: AnyCreep;
}