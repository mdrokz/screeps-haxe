package screeps;

import screeps.Find.MoveToOpts;
import screeps.RoomPosition.Target;
import screeps.RoomPosition.PathStep;
import screeps.Globals.ScreepsReturnCode;
import screeps.Globals.ResourceConstant;
import screeps.Globals.BodyPartDefinition;
import screeps.Utils.JsMap;
import screeps.Utils.JsObject;
import screeps.Structure.Owner;
import screeps.Store.GenericStore;
import screeps.Construction.ConstructionSite;
import screeps.Globals.BodyPart;
import screeps.Structure.StructureController;
import screeps.Globals.Directions;
import screeps.Globals.CreepMoveReturnCode;
import screeps.Globals.CreepActionReturnCode;
import screeps.Globals.Pwr;
import screeps.Structure.StructurePowerBank;
import screeps.Structure.StructurePowerSpawn;
import haxe.extern.EitherType;

using screeps.Room.RoomObject;

typedef AnyCreep = EitherType<Creep, PowerCreep>;

enum abstract NormalCode(Int) {
	var OK = 0;
	var ERR_NOT_FOUND = -5;
}

@:build(screeps.Macros.MacroUtils.buildEnum(CreepActionReturnCode))
enum abstract BuildCode(Int) from Int to Int {
	var ERR_NOT_ENOUGH_RESOURCES = -6;
	var ERR_RCL_NOT_ENOUGH = -14;
}

@:build(screeps.Macros.MacroUtils.buildEnum(CreepActionReturnCode))
enum abstract ClaimCode(Int) from Int to Int {
	var ERR_FULL = -8;
	var ERR_GCL_NOT_ENOUGH = -15;
}

@:build(screeps.Macros.MacroUtils.buildEnum(CreepActionReturnCode))
enum abstract HarvestCode(Int) from Int to Int {
	var ERR_NOT_FOUND = -5;
	var ERR_NOT_ENOUGH_RESOURCES = -6;
}

@:build(screeps.Macros.MacroUtils.buildEnum(CreepMoveReturnCode))
enum abstract MoveCode(Int) from Int to Int {
	var ERR_NOT_FOUND = -5;
	var ERR_INVALID_ARGS = -10;
}

@:build(screeps.Macros.MacroUtils.buildEnum(CreepMoveReturnCode))
enum abstract MoveToCode(Int) from Int to Int {
	var ERR_NO_PATH = -2;
	var ERR_INVALID_TARGET = -7;
	var ERR_NOT_FOUND = -5;
}

typedef PathType = EitherType<Array<PathStep>, EitherType<Array<RoomPosition>, String>>;
typedef WidthdrawType = EitherType<Structure, EitherType<TombStone, Ruin>>;

typedef Powers = {
	/**
	 * Current level of the power
	 */
	var level:Int;

	/**
	 * Cooldown ticks remaining, or undefined if the power creep is not spawned in the world.
	 */
	var cooldown:EitherType<Int, Void>;
};

extern typedef PowerCreepPowers = JsMap<Int,Powers>;

/**
 * Power Creeps are immortal "heroes" that are tied to your account and can be respawned in any PowerSpawn after death.
 * You can upgrade their abilities ("powers") up to your account Global Power Level (see `Game.gpl`).
 */
@:build(screeps.Macros.MacroUtils.extendFields(RoomObject, ["prototype", "room"]))
extern class PowerCreep {
	/**
	 * An object with the creep's cargo contents.
	 * @deprecated An alias for Creep.store.
	 */
	var carry:GenericStore;

	/**
	 * The total amount of resources the creep can carry.
	 * @deprecated An alias for Creep.store.getCapacity().
	 */
	var carryCapacity:Int;

	/**
	 * The power creep's class, one of the `POWER_CLASS` constants.
	 */
	var className:String;

	/**
	 * A timestamp when this creeep is marked to be permanently deleted from the account, or undefined otherwise.
	 */
	var deleteTime:EitherType<Int, Void>;

	/**
	 * The current amount of hit points of the creep.
	 */
	var hits:Int;

	/**
	 * The maximum amount of hit points of the creep.
	 */
	var hitsMax:Int;

	/**
	 * A unique identifier. You can use `Game.getObjectById` method to retrieve an object instance by its id.
	 */
	var id:String;

	/**
	 * The power creep's level.
	 */
	var level:Int;

	/**
	 * A shorthand to `Memory.powerCreeps[creep.name]`. You can use it for quick access to the creep's specific memory data object.
	 */
	var memory:JsObject<Any>;

	/**
	 * Whether it is your creep or foe.
	 */
	var my:Bool;

	/**
	 * Power creep name. You can choose the name while creating a new power creep, and `rename` it while unspawned. This name is a hash key to access the creep via the `Game.powerCreeps` object.
	 */
	var name:String;

	/**
	 * An object with the creep's owner information.
	 */
	var owner:Owner;

	/**
	 * A Store object that contains cargo of this creep.
	 */
	var store:GenericStore;

	/**
	 * An object with the creep's available powers.
	 */
	var powers:PowerCreepPowers;

	/**
	 * The text message that the creep was saying at the last tick.
	 */
	var saying:String;

	/**
	 * The name of the shard where the power creeps is spawned, or undefined.
	 */
	var shard:EitherType<String, Void>;

	/**
	 * The timestamp when spawning or deleting this creep will become available. Undefined if the power creep is spawned in the world.
	 * Note: This is a timestamp, not ticks as powerCreeps are not shard dependent.
	 */
	var spawnCooldownTime:EitherType<Int, Void>;

	/**
	 * The remaining amount of game ticks after which the creep will die and become unspawned. Undefined if the creep is not spawned in the world.
	 */
	var ticksToLive:EitherType<Int, Void>;

	/**
	 * Move the creep one square in the specified direction or towards a creep that is pulling it.
	 *
	 * Requires the MOVE body part if not being pulled.
	 * @param target the Creep Object for target.
	 * @param direction The direction to move in (`TOP`, `TOP_LEFT`...)
	 */
	@:overload(function(target:Creep):ScreepsReturnCode {})
	public function move(direction:Directions):CreepMoveReturnCode;

	/**
	 * Move the creep using the specified predefined path. Needs the MOVE body part.
	 * @param path A path value as returned from Room.findPath or RoomPosition.findPathTo methods. Both array form and serialized string form are accepted.
	 */
	public function moveByPath(path:PathType):MoveCode;

	/**
	 * Find the optimal path to the target within the same room and move to it.
	 * A shorthand to consequent calls of pos.findPathTo() and move() methods.
	 * If the target is in another room, then the corresponding exit will be used as a target.
	 *
	 * Needs the MOVE body part.
	 * @param x X position of the target in the room.
	 * @param y Y position of the target in the room.
	 * @param target Can be a RoomPosition object or any object containing RoomPosition.
	 * @param opts An object containing pathfinding options flags (see Room.findPath for more info) or one of the following: reusePath, serializeMemory, noPathFinding
	 */
	@:overload(function(target:Target, ?opts:MoveToOpts):MoveToCode {})
	public function moveTo(x:Int, y:Int, ?opts:MoveToOpts):MoveToCode;

	/**
	 * Cancel the order given during the current game tick.
	 * @param methodName The name of a creep's method to be cancelled.
	 * @returns Result Code: OK, ERR_NOT_FOUND
	 */
	public function cancelOrder(methodName:String):NormalCode;

	/**
	 * Delete the power creep permanently from your account.
	 * It should NOT be spawned in the world. The creep is not deleted immediately, but a 24-hour delete time is started (see `deleteTime`).
	 * You can cancel deletion by calling `delete(true)`.
	 */
	public function delete(?cancel:Bool):ScreepsReturnCode;

	/**
	 * Drop this resource on the ground.
	 * @param resourceType One of the RESOURCE_* constants.
	 * @param amount The amount of resource units to be dropped. If omitted, all the available carried amount is used.
	 */
	public function drop(resourceType:ResourceConstant, ?amount:Int):ScreepsReturnCode;

	/**
	 * Enable power usage in this room. The room controller should be at adjacent tile.
	 * @param controller The room controller
	 */
	public function enableRoom(controller:StructureController):ScreepsReturnCode;

	/**
	 * Toggle auto notification when the creep is under attack. The notification will be sent to your account email. Turned on by default.
	 * @param enabled Whether to enable notification or disable.
	 */
	public function notifyWhenAttacked(enabled:Bool):ScreepsReturnCode;

	/**
	 * Pick up an item (a dropped piece of energy). Needs the CARRY body part. The target has to be at adjacent square to the creep or at the same square.
	 * @param target The target object to be picked up.
	 */
	public function pickup(target:Resource):ClaimCode;

	/**
	 * Rename the power creep. It must not be spawned in the world.
	 */
	public function rename(name:String):ScreepsReturnCode;

	/**
	 * Instantly restore time to live to the maximum using a Power Spawn or a Power Bank nearby. It has to be at adjacent tile.
	 * @param target The target structure
	 */
	public function renew(target:EitherType<StructurePowerBank, StructurePowerSpawn>):ScreepsReturnCode;

	/**
	 * Display a visual speech balloon above the creep with the specified message.
	 *
	 * The message will disappear after a few seconds. Useful for debugging purposes.
	 *
	 * Only the creep's owner can see the speech message unless toPublic is true.
	 * @param message The message to be displayed. Maximum length is 10 characters.
	 * @param set to 'true' to allow other players to see this message. Default is 'false'.
	 */
	public function say(message:String, ?toPublic:Bool):ScreepsReturnCode;

	/**
	 * Spawn this power creep in the specified Power Spawn.
	 * @param powerSpawn Your Power Spawn structure
	 */
	public function spawn(powerSpawn:StructurePowerSpawn):ScreepsReturnCode;

	/**
	 * Kill the creep immediately.
	 */
	public function suicide():ScreepsReturnCode;

	/**
	 * Transfer resource from the creep to another object. The target has to be at adjacent square to the creep.
	 * @param target The target object.
	 * @param resourceType One of the RESOURCE_* constants
	 * @param amount The amount of resources to be transferred. If omitted, all the available carried amount is used.
	 */
	public function transfer(target:EitherType<AnyCreep, Structure>, resourceType:ResourceConstant, ?amount:Int):ScreepsReturnCode;

	/**
	 * Upgrade the creep, adding a new power ability to it or increasing the level of the existing power. You need one free Power Level in your account to perform this action.
	 */
	public function upgrade(power:Pwr):ScreepsReturnCode;

	/**
	 * Apply one of the creep's powers on the specified target.
	 */
	public function usePower(power:Pwr, ?target:RoomObject):ScreepsReturnCode;

	/**
	 * Withdraw resources from a structure, a tombstone or a ruin.
	 *
	 * The target has to be at adjacent square to the creep.
	 *
	 * Multiple creeps can withdraw from the same structure in the same tick.
	 *
	 * Your creeps can withdraw resources from hostile structures as well, in case if there is no hostile rampart on top of it.
	 * @param target The target object.
	 * @param resourceType The target One of the RESOURCE_* constants..
	 * @param amount The amount of resources to be transferred. If omitted, all the available amount is used.
	 */
	public function withdraw(target:WidthdrawType, resourceType:ResourceConstant, ?amount:Int):ScreepsReturnCode;

	/**
	 * A static method to create new Power Creep instance in your account. It will be added in an unspawned state,
	 * use spawn method to spawn it in the world.
	 *
	 * You need one free Power Level in your account to perform this action.
	 *
	 * @param name The name of the power creep.
	 * @param className The class of the new power creep, one of the `POWER_CLASS` constants
	 */
	public static function create(name:String, className:String):ScreepsReturnCode;

	@:selfCall
	public function new():Void;
}

/**
 * Creeps are your units.
 * Creeps can move, harvest energy, construct structures, attack another creeps, and perform other actions.
 * Each creep consists of up to 50 body parts with the following possible types:
 */
@:build(screeps.Macros.MacroUtils.extendFields(RoomObject, ["prototype", "room"]))
extern class Creep {
	final prototype:Creep;

	/**
	 * An array describing the creep's body.
	 */
	var body:Array<BodyPartDefinition>;

	/**
	 * An object with the creep's cargo contents.
	 * @deprecated Is an alias for Creep.store
	 */
	var carry:GenericStore;

	/**
	 * The total amount of resources the creep can carry.
	 * @deprecated alias for Creep.store.getCapacity
	 */
	var carryCapacity:Int;

	/**
	 * The movement fatigue indicator. If it is greater than zero, the creep cannot move.
	 */
	var fatigue:Int;

	/**
	 * The current amount of hit points of the creep.
	 */
	var hits:Int;

	/**
	 * The maximum amount of hit points of the creep.
	 */
	var hitsMax:Int;

	/**
	 * A unique object identifier. You can use `Game.getObjectById` method to retrieve an object instance by its `id`.
	 */
	var id:String;

	/**
	 * A shorthand to `Memory.creeps[creep.name]`. You can use it for quick access the creep’s specific memory data object.
	 */
	var memory:JsObject<Any>;

	/**
	 * Whether it is your creep or foe.
	 */
	var my:Bool;

	/**
	 * Creep’s name. You can choose the name while creating a new creep, and it cannot be changed later. This name is a hash key to access the creep via the `Game.creeps` object.
	 */
	var name:String;

	/**
	 * An object with the creep’s owner info.
	 */
	var owner:Owner;

	/**
	 * The link to the Room object. Always defined because creeps give visibility into the room they're in.
	 */
	var room:Room;

	/**
	 * Whether this creep is still being spawned.
	 */
	var spawning:Bool;

	/**
	 * The text message that the creep was saying at the last tick.
	 */
	var saying:String;

	/**
	 * A Store object that contains cargo of this creep.
	 */
	var store:GenericStore;

	/**
	 * The remaining amount of game ticks after which the creep will die.
	 *
	 * Will be `undefined` if the creep is still spawning.
	 */
	var ticksToLive:EitherType<Int, Void>;

	/**
	 * Attack another creep or structure in a short-ranged attack. Needs the
	 * ATTACK body part. If the target is inside a rampart, then the rampart is
	 * attacked instead.
	 *
	 * The target has to be at adjacent square to the creep. If the target is a
	 * creep with ATTACK body parts and is not inside a rampart, it will
	 * automatically hit back at the attacker.
	 *
	 * @returns Result Code: OK, ERR_NOT_OWNER, ERR_BUSY, ERR_INVALID_TARGET, ERR_NOT_IN_RANGE, ERR_NO_BODYPART
	 */
	public function attack(target:EitherType<AnyCreep, Structure>):CreepActionReturnCode;

	/**
	 * Decreases the controller's downgrade or reservation timer for 1 tick per
	 * every 5 `CLAIM` body parts (so the creep must have at least 5x`CLAIM`).
	 *
	 * The controller under attack cannot be upgraded for the next 1,000 ticks.
	 * The target has to be at adjacent square to the creep.
	 *
	 * @returns Result Code: OK, ERR_NOT_OWNER, ERR_BUSY, ERR_INVALID_TARGET, ERR_NOT_IN_RANGE, ERR_NO_BODYPART, ERR_TIRED
	 */
	public function attackController(target:StructureController):CreepActionReturnCode;

	/**
	 * Build a structure at the target construction site using carried energy.
	 * Needs WORK and CARRY body parts.
	 *
	 * The target has to be within 3 squares range of the creep.
	 *
	 * @param target The target object to be attacked.
	 * @returns Result Code: OK, ERR_NOT_OWNER, ERR_BUSY, ERR_NOT_ENOUGH_RESOURCES, ERR_INVALID_TARGET, ERR_NOT_IN_RANGE, ERR_NO_BODYPART, ERR_RCL_NOT_ENOUGH
	 */
	public function build(target:ConstructionSite):BuildCode;

	/**
	 * Cancel the order given during the current game tick.
	 * @param methodName The name of a creep's method to be cancelled.
	 * @returns Result Code: OK, ERR_NOT_FOUND
	 */
	public function cancelOrder(methodName:String):NormalCode;

	/**
	 * Requires the CLAIM body part.
	 *
	 * If applied to a neutral controller, claims it under your control.
	 * If applied to a hostile controller, decreases its downgrade or reservation timer depending on the CLAIM body parts count.
	 *
	 * The target has to be at adjacent square to the creep.
	 * @param target The target controller object.
	 * @returns Result Code: OK, ERR_NOT_OWNER, ERR_BUSY, ERR_INVALID_TARGET, ERR_FULL, ERR_NOT_IN_RANGE, ERR_NO_BODYPART, ERR_GCL_NOT_ENOUGH
	 */
	public function claimController(target:StructureController):ClaimCode;

	/**
	 * Dismantles any (even hostile) structure returning 50% of the energy spent on its repair.
	 *
	 * Requires the WORK body part. If the creep has an empty CARRY body part, the energy is put into it; otherwise it is dropped on the ground.
	 *
	 * The target has to be at adjacent square to the creep.
	 * @param target The target structure.
	 */
	public function dismantle(target:Structure):CreepActionReturnCode;

	/**
	 * Drop this resource on the ground.
	 * @param resourceType One of the RESOURCE_* constants.
	 * @param amount The amount of resource units to be dropped. If omitted, all the available carried amount is used.
	 */
	public function drop(resourceType:ResourceConstant, ?amount:Int):ScreepsReturnCode;

	/**
	 * Add one more available safe mode activation to a room controller. The creep has to be at adjacent square to the target room controller and have 1000 ghodium resource.
	 * @param target The target room controller.
	 * @returns Result Code: OK, ERR_NOT_OWNER, ERR_BUSY, ERR_NOT_ENOUGH_RESOURCES, ERR_INVALID_TARGET, ERR_NOT_IN_RANGE
	 */
	public function generateSafeMode(target:StructureController):CreepActionReturnCode;

	/**
	 * Get the quantity of live body parts of the given type. Fully damaged parts do not count.
	 * @param type A body part type, one of the following body part constants: MOVE, WORK, CARRY, ATTACK, RANGED_ATTACK, HEAL, TOUGH, CLAIM
	 */
	public function getActiveBodyparts(type:BodyPart):Int;

	/**
	 * Harvest energy from the source or resource from minerals or deposits.
	 *
	 * Needs the WORK body part.
	 *
	 * If the creep has an empty CARRY body part, the harvested resource is put into it; otherwise it is dropped on the ground.
	 *
	 * The target has to be at an adjacent square to the creep.
	 * @param target The source object to be harvested.
	 */
	public function harvest(target:EitherType<Source, EitherType<Mineral, Deposit>>):HarvestCode;

	/**
	 * Heal self or another creep. It will restore the target creep’s damaged body parts function and increase the hits counter.
	 *
	 * Needs the HEAL body part.
	 *
	 * The target has to be at adjacent square to the creep.
	 * @param target The target creep object.
	 */
	public function heal(target:AnyCreep):CreepActionReturnCode;

	/**
	 * Move the creep one square in the specified direction or towards a creep that is pulling it.
	 *
	 * Requires the MOVE body part if not being pulled.
	 * @param target the Creep Object for target.
	 * @param direction The direction to move in (`TOP`, `TOP_LEFT`...)
	 */
	@:overload(function(target:Creep):ScreepsReturnCode {})
	public function move(direction:Directions):CreepMoveReturnCode;

	/**
	 * Move the creep using the specified predefined path. Needs the MOVE body part.
	 * @param path A path value as returned from Room.findPath or RoomPosition.findPathTo methods. Both array form and serialized string form are accepted.
	 */
	public function moveByPath(path:PathType):MoveCode;

	/**
	 * Find the optimal path to the target within the same room and move to it.
	 * A shorthand to consequent calls of pos.findPathTo() and move() methods.
	 * If the target is in another room, then the corresponding exit will be used as a target.
	 *
	 * Needs the MOVE body part.
	 * @param x X position of the target in the room.
	 * @param y Y position of the target in the room.
	 * @param target Can be a RoomPosition object or any object containing RoomPosition.
	 * @param opts An object containing pathfinding options flags (see Room.findPath for more info) or one of the following: reusePath, serializeMemory, noPathFinding
	 */
	@:overload(function(target:Target, ?opts:MoveToOpts):MoveToCode {})
	public function moveTo(x:Int, y:Int, ?opts:MoveToOpts):MoveToCode;

	/**
	 * Toggle auto notification when the creep is under attack. The notification will be sent to your account email. Turned on by default.
	 * @param enabled Whether to enable notification or disable.
	 */
	public function notifyWhenAttacked(enabled:Bool):ScreepsReturnCode;

	/**
	 * Pick up an item (a dropped piece of energy). Needs the CARRY body part. The target has to be at adjacent square to the creep or at the same square.
	 * @param target The target object to be picked up.
	 */
	public function pickup(target:Resource):ClaimCode;

	/**
	 * Allow another creep to follow this creep. The fatigue generated for the target's move will be added to the creep instead of the target.
	 *
	 * Requires the MOVE body part. The target must be adjacent to the creep. The creep must move elsewhere, and the target must move towards the creep.
	 * @param target The target creep to be pulled.
	 */
	public function pull(target:Creep):ScreepsReturnCode;

	/**
	 * A ranged attack against another creep or structure.
	 *
	 * Needs the RANGED_ATTACK body part. If the target is inside a rampart, the rampart is attacked instead.
	 *
	 * The target has to be within 3 squares range of the creep.
	 * @param target The target object to be attacked.
	 */
	public function rangedAttack(target:EitherType<AnyCreep, Structure>):CreepActionReturnCode;

	/**
	 * Heal another creep at a distance.
	 *
	 * It will restore the target creep’s damaged body parts function and increase the hits counter.
	 *
	 * Needs the HEAL body part. The target has to be within 3 squares range of the creep.
	 * @param target The target creep object.
	 */
	public function rangedHeal(target:AnyCreep):CreepActionReturnCode;

	/**
	 * A ranged attack against all hostile creeps or structures within 3 squares range.
	 *
	 * Needs the RANGED_ATTACK body part.
	 *
	 * The attack power depends on the range to each target. Friendly units are not affected.
	 */
	public function rangedMassAttack():ScreepsReturnCode;

	/**
	 * Repair a damaged structure using carried energy. Needs the WORK and CARRY body parts. The target has to be within 3 squares range of the creep.
	 * @param target The target structure to be repaired.
	 */
	public function repair(target:Structure):HarvestCode;

	/**
	 * Temporarily block a neutral controller from claiming by other players.
	 *
	 * Each tick, this command increases the counter of the period during which the controller is unavailable by 1 tick per each CLAIM body part.
	 *
	 * The maximum reservation period to maintain is 5,000 ticks.
	 *
	 * The target has to be at adjacent square to the creep....
	 * @param target The target controller object to be reserved.
	 * @return Result code: OK, ERR_NOT_OWNER, ERR_BUSY, ERR_INVALID_TARGET, ERR_NOT_IN_RANGE, ERR_NO_BODYPART
	 */
	public function reserveController(target:StructureController):CreepActionReturnCode;

	/**
	 * Display a visual speech balloon above the creep with the specified message.
	 *
	 * The message will disappear after a few seconds. Useful for debugging purposes.
	 *
	 * Only the creep's owner can see the speech message unless toPublic is true.
	 * @param message The message to be displayed. Maximum length is 10 characters.
	 * @param set to 'true' to allow other players to see this message. Default is 'false'.
	 */
	public function say(message:String, ?toPublic:Bool):ScreepsReturnCode;

	/**
	 * Sign a controller with a random text visible to all players. This text will appear in the room UI, in the world map, and can be accessed via the API.
	 * You can sign unowned and hostile controllers. The target has to be at adjacent square to the creep. Pass an empty string to remove the sign.
	 * @param target The target controller object to be signed.
	 * @param text The sign text. The maximum text length is 100 characters.
	 * @returns Result Code: OK, ERR_BUSY, ERR_INVALID_TARGET, ERR_NOT_IN_RANGE
	 */
	public function signController(target:StructureController, text:String):ScreepsReturnCode;

	/**
	 * Kill the creep immediately.
	 */
	public function suicide():ScreepsReturnCode;

	/**
	 * Transfer resource from the creep to another object. The target has to be at adjacent square to the creep.
	 * @param target The target object.
	 * @param resourceType One of the RESOURCE_* constants
	 * @param amount The amount of resources to be transferred. If omitted, all the available carried amount is used.
	 */
	public function transfer(target:EitherType<AnyCreep, Structure>, resourceType:ResourceConstant, ?amount:Int):ScreepsReturnCode;

	/**
	 * Upgrade your controller to the next level using carried energy.
	 *
	 * Upgrading controllers raises your Global Control Level in parallel.
	 *
	 * Needs WORK and CARRY body parts.
	 *
	 * The target has to be at adjacent square to the creep.
	 *
	 * A fully upgraded level 8 controller can't be upgraded with the power over 15 energy units per tick regardless of creeps power.
	 *
	 * The cumulative effect of all the creeps performing upgradeController in the current tick is taken into account.
	 * @param target The target controller object to be upgraded.
	 */
	public function upgradeController(target:StructureController):ScreepsReturnCode;

	/**
	 * Withdraw resources from a structure, a tombstone or a ruin.
	 *
	 * The target has to be at adjacent square to the creep.
	 *
	 * Multiple creeps can withdraw from the same structure in the same tick.
	 *
	 * Your creeps can withdraw resources from hostile structures as well, in case if there is no hostile rampart on top of it.
	 * @param target The target object.
	 * @param resourceType The target One of the RESOURCE_* constants..
	 * @param amount The amount of resources to be transferred. If omitted, all the available amount is used.
	 */
	public function withdraw(target:WidthdrawType, resourceType:ResourceConstant, ?amount:Int):ScreepsReturnCode;

	@:selfCall
	public function new():Void;
}
