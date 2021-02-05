package screeps;

import screeps.Store.StoreDefinition;
import haxe.extern.EitherType;
import screeps.Globals.ScreepsReturnCode;
import screeps.Globals.StructureConstant;
import screeps.Room.RoomObject;

/**
 * Parent object for structure classes
 */
@:build(screeps.Macros.MacroUtils.extendFields(RoomObject, ["prototype", "room"]))
extern class Structure {
	final prototype:Structure;

	/**
	 * The current amount of hit points of the structure.
	 */
	var hits:Int;

	/**
	 * The total amount of hit points of the structure.
	 */
	var hitsMax:Int;

	/**
	 * A unique object identifier. You can use Game.getObjectById method to retrieve an object instance by its id.
	 */
	var id:String;

	/**
	 * If you can get an instance of a Structure, you can see it.
	 * If you can see the Structure, you can see the room it's in.
	 */
	var room:Room;

	/**
	 * One of the STRUCTURE_* constants.
	 */
	var structureType:StructureConstant;

	/**
	 * Destroy this structure immediately.
	 */
	public function destroy():ScreepsReturnCode;

	/**
	 * Check whether this structure can be used. If the room controller level is not enough, then this method will return false, and the structure will be highlighted with red in the game.
	 */
	public function isActive():Bool;

	/**
	 * Toggle auto notification when the structure is under attack. The notification will be sent to your account email. Turned on by default.
	 * @param enabled Whether to enable notification or disable.
	 */
	public function notifyWhenAttacked(enabled:Bool):ScreepsReturnCode;
}

typedef Owner = {
	/**
	 * The name of the owner user.
	 */
	var username:String;
}

typedef OwnerOrVoid = EitherType<Owner, Void>;

/**
 * The base prototype for a structure that has an owner. Such structures can be
 * found using `FIND_MY_STRUCTURES` and `FIND_HOSTILE_STRUCTURES` constants.
 */
@:build(screeps.Macros.MacroUtils.extendFields(Structure, ["prototype", "room"]))
extern class OwnedStructure {
	final prototype:OwnedStructure;

	/**
	 * Whether this is your own structure. Walls and roads don't have this property as they are considered neutral structures.
	 */
	var my:Bool;

	/**
	 * An object with the structure’s owner info (if present) containing the following properties: username
	 */
	var owner:EitherType<StructureConstant, EitherType<Owner, OwnerOrVoid>>;

	/**
	 * The link to the Room object. Is always present because owned structures give visibility.
	 */
	var room:Room;
}

typedef ReservationDefinition = {
	var sername:String;
	var ticksToEnd:Int;
}

typedef SignDefinition = {
	var username:String;
	var text:String;
	var time:Int;
	var datetime:Date;
}

/**
 * Claim this structure to take control over the room. The controller structure
 * cannot be damaged or destroyed. It can be addressed by `Room.controller`
 * property.
 */
@:build(screeps.Macros.MacroUtils.extendFields(OwnedStructure, ["prototype"]))
extern class StructureController {
	final prototype:StructureController;

	/**
	 * Whether using power is enabled in this room.
	 *
	 * Use `PowerCreep.enableRoom()` to turn powers on.
	 */
	var isPowerEnabled:Bool;

	/**
	 * Current controller level, from 0 to 8.
	 */
	var level:Int;

	/**
	 * The current progress of upgrading the controller to the next level.
	 */
	var progress:Int;

	/**
	 * The progress needed to reach the next level.
	 */
	var progressTotal:Int;

	/**
	 * An object with the controller reservation info if present: username, ticksToEnd
	 */
	var reservation:EitherType<ReservationDefinition, Void>;

	/**
	 * How many ticks of safe mode are remaining, or undefined.
	 */
	var safeMode:Int;

	/**
	 * Safe mode activations available to use.
	 */
	var safeModeAvailable:Int;

	/**
	 * During this period in ticks new safe mode activations will be blocked, undefined if cooldown is inactive.
	 */
	var safeModeCooldown:Int;

	/**
	 * An object with the controller sign info if present
	 */
	var sign:EitherType<SignDefinition, Void>;

	/**
	 * The amount of game ticks when this controller will lose one level. This timer can be reset by using Creep.upgradeController.
	 */
	var ticksToDowngrade:Int;

	/**
	 * The amount of game ticks while this controller cannot be upgraded due to attack.
	 */
	var upgradeBlocked:Int;

	/**
	 * Activate safe mode if available.
	 * @returns Result Code: OK, ERR_NOT_OWNER, ERR_BUSY, ERR_NOT_ENOUGH_RESOURCES, ERR_TIRED
	 */
	public function activateSafeMode():ScreepsReturnCode;

	/**
	 * Make your claimed controller neutral again.
	 */
    public function unclaim():ScreepsReturnCode;
    
    @:selfCall
    public function new(): Void;
}

/**
 * A structure that can store huge amount of resource units. Only one structure
 * per room is allowed that can be addressed by `Room.storage` property.
 */
@:build(screeps.Macros.MacroUtils.extendFields(OwnedStructure, ["prototype"]))
extern class StructureStorage {
	final prototype:StructureStorage;

	/**
	 * An object with the storage contents.
	 */
	var store:StoreDefinition;

	/**
	 * The total amount of resources the storage can contain.
	 * @deprecated An alias for .store.getCapacity().
	 */
	var storeCapacity:Int;
}

extern class StructureTerminal {}
