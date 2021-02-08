package screeps;

import screeps.Globals.AlloyDeposit;
import screeps.Globals.DepositConstant;
import screeps.Room.RoomObject;
/**
 * A rare resource deposit needed for producing commodities.
 * Can be harvested by creeps with a WORK body part.
 * Each harvest operation triggers a cooldown period, which becomes longer and longer over time.
 */
@:build(screeps.Macros.MacroUtils.extendFields(RoomObject, ["prototype"]))
extern class Deposit {
    /**
     * A unique object identificator.
     * You can use {@link Game.getObjectById} method to retrieve an object instance by its id.
     */
     var id: String;
     /**
      * The amount of game ticks until the next harvest action is possible.
      */
     var depositType: AlloyDeposit;
     /**
      * The amount of game ticks until the next harvest action is possible.
      */
     var cooldown: Int;
     /**
      * The cooldown of the last harvest operation on this deposit.
      */
     var lastCooldown: Int;
     /**
      * The amount of game ticks when this deposit will disappear.
      */
     var ticksToDecay: Int;
}
