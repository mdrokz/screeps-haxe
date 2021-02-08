package screeps;

import screeps.Globals.ResourceConstant;
import screeps.Room.RoomObject;

/**
 * A dropped piece of resource. It will decay after a while if not picked up. Dropped resource pile decays for ceil(amount/1000) units per tick.
 */
@:build(screeps.Macros.MacroUtils.extendFields(RoomObject, ["prototype"]))
extern class Resource {
    final prototype: Resource;

    /**
     * The amount of resource units containing.
     */
    var amount: Int;
    /**
     * A unique object identifier. You can use `Game.getObjectById` method to retrieve an object instance by its `id`.
     */
    var id: String;
    /**
     * One of the `RESOURCE_*` constants.
     */
    var resourceType: ResourceConstant;

    @:selfCall
    public function new(): Void;
}
