package screeps;

import screeps.Structure.Owner;
import screeps.Globals.StructureConstant;
import screeps.Room.RoomObject;

/**
 * A site of a structure which is currently under construction.
 */
@:build(screeps.Macros.MacroUtils.extendFields(RoomObject, ["prototype"]))
extern class ConstructionSite {
    final prototype: ConstructionSite;
    /**
     * A unique object identifier. You can use `Game.getObjectById` method to retrieve an object instance by its `id`.
     */
    var id: String;
    /**
     * Whether this is your own construction site.
     */
    var my: Bool;
    /**
     * An object with the structure’s owner info.
     */
    var owner: Owner;
    /**
     * The current construction progress.
     */
    var progress: Int;
    /**
     * The total construction progress needed for the structure to be built.
     */
    var progressTotal: Int;
    /**
     * One of the `STRUCTURE_*` constants.
     */
    var structureType: StructureConstant;
    /**
     * Remove the construction site.
     * @returns Result Code: OK, ERR_NOT_OWNER
     */
    public function remove(): Int;

    @:selfCall 
    public function new(): Void;
}