package screeps;

import screeps.Globals.BodyPart;
import screeps.Globals.Directions;
import screeps.Utils.JsObject;
import haxe.macro.MacroType;
import screeps.Creep.AnyCreep;
import screeps.Globals.ResourceConstant;
import screeps.Store.GenericStore;
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
	var username:String;
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
	public function new():Void;
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
	var store:GenericStore;

	/**
	 * The total amount of resources the storage can contain.
	 * @deprecated An alias for .store.getCapacity().
	 */
	var storeCapacity:Int;
}

/**
 * Sends any resources to a Terminal in another room.
 */
@:build(screeps.Macros.MacroUtils.extendFields(OwnedStructure, ["prototype"]))
extern class StructureTerminal {
	final prototype:StructureTerminal;

	/**
	 * The remaining amount of ticks while this terminal cannot be used to make StructureTerminal.send or Game.market.deal calls.
	 */
	var cooldown:Int;

	/**
	 * A Store object that contains cargo of this structure.
	 */
	var store:GenericStore;

	/**
	 * The total amount of resources the storage can contain.
	 * @deprecated An alias for .store.getCapacity().
	 */
	var storeCapacity:Int;

	/**
	 * Sends resource to a Terminal in another room with the specified name.
	 * @param resourceType One of the RESOURCE_* constants.
	 * @param amount The amount of resources to be sent.
	 * @param destination The name of the target room. You don't have to gain visibility in this room.
	 * @param description The description of the transaction. It is visible to the recipient. The maximum length is 100 characters.
	 */
	public function send(resourceType:ResourceConstant, amount:Int, destination:String, ?description:String):ScreepsReturnCode;

	@:selfCall
	public function new():Void;
}

/**
 * Contains up to 2,000 resource units. Can be constructed in neutral rooms. Decays for 5,000 hits per 100 ticks.
 */
@:build(screeps.Macros.MacroUtils.extendFields(Structure, ["prototype"]))
extern class StructureContainer {
	final prototype:StructureContainer;

	/**
	 * An object with the structure contents. Each object key is one of the RESOURCE_* constants, values are resources
	 * amounts. Use _.sum(structure.store) to get the total amount of contents
	 */
	var store:GenericStore;

	/**
	 * The total amount of resources the structure can contain.
	 * @deprecated An alias for .store.getCapacity().
	 */
	var storeCapacity:Int;

	/**
	 * The amount of game ticks when this container will lose some hit points.
	 */
	var ticksToDecay:Int;

	@:selfCall
	public function new():Void;
}

/**
 * A non-player structure.
 * Instantly teleports your creeps to a distant room acting as a room exit tile.
 * Portals appear randomly in the central room of each sector.
 */
@:build(screeps.Macros.MacroUtils.extendFields(Structure, ["prototype"]))
extern class StructurePortal {
	final prototype:StructurePortal;

	/**
	 * If this is an inter-room portal, then this property contains a RoomPosition object leading to the point in the destination room.
	 * If this is an inter-shard portal, then this property contains an object with shard and room string properties.
	 * Exact coordinates are undetermined, the creep will appear at any free spot in the destination room.
	 */
	var destination:EitherType<RoomPosition, {shard:String, room:String}>;

	/**
	 * The amount of game ticks when the portal disappears, or undefined when the portal is stable.
	 */
	var ticksToDecay:EitherType<Int, Void>;

	@:selfCall
	public function new():Void;
}

/**
 * Launches a nuke to another room dealing huge damage to the landing area.
 * Each launch has a cooldown and requires energy and ghodium resources. Launching
 * creates a Nuke object at the target room position which is visible to any player
 * until it is landed. Incoming nuke cannot be moved or cancelled. Nukes cannot
 * be launched from or to novice rooms.
 */
@:build(screeps.Macros.MacroUtils.extendFields(OwnedStructure, ["prototype"]))
extern class StructureNuker {
	final prototype:StructureNuker;

	/**
	 * The amount of energy contained in this structure.
	 * @deprecated An alias for .store[RESOURCE_ENERGY].
	 */
	var energy:Int;

	/**
	 * The total amount of energy this structure can contain.
	 * @deprecated An alias for .store.getCapacity(RESOURCE_ENERGY).
	 */
	var energyCapacity:Int;

	/**
	 * The amount of energy contained in this structure.
	 * @deprecated An alias for .store[RESOURCE_GHODIUM].
	 */
	var ghodium:Int;

	/**
	 * The total amount of energy this structure can contain.
	 * @deprecated An alias for .store.getCapacity(RESOURCE_GHODIUM).
	 */
	var ghodiumCapacity:Int;

	/**
	 * The amount of game ticks the link has to wait until the next transfer is possible.
	 */
	var cooldown:Int;

	/**
	 * A Store object that contains cargo of this structure.
	 */
	var store:GenericStore;

	/**
	 * Launch a nuke to the specified position.
	 * @param pos The target room position.
	 */
	public function launchNuke(pos:RoomPosition):ScreepsReturnCode;

	@:selfCall
	public function new():Void;
}

/**
 * A structure which produces trade commodities from base minerals and other commodities.
 */
@:build(screeps.Macros.MacroUtils.extendFields(OwnedStructure, ["prototype"]))
extern class StructureFactory {
	final prototype:StructureFactory;

	/**
	 * The amount of game ticks the factory has to wait until the next produce is possible.
	 */
	var cooldown:Int;

	/**
	 * The level of the factory.
	 * Can be set by applying the PWR_OPERATE_FACTORY power to a newly built factory.
	 * Once set, the level cannot be changed.
	 */
	var level:Int;

	/**
	 * An object with the structure contents.
	 */
	var store:GenericStore;

	/**
	 * Produces the specified commodity.
	 * All ingredients should be available in the factory store.
	 */
	public function produce(resource:ResourceConstant):ScreepsReturnCode;

	@:selfCall
	public function new():Void;
}

/**
 * A structure which is a control center of NPC Strongholds, and also rules all invaders in the sector.
 */
@:build(screeps.Macros.MacroUtils.extendFields(OwnedStructure, ["prototype"]))
extern class StructureInvaderCore {
	final prototype:StructureInvaderCore;

	/**
	 * The level of the stronghold. The amount and quality of the loot depends on the level.
	 */
	var level:Int;

	/**
	 * Shows the timer for a not yet deployed stronghold, undefined otherwise.
	 */
	var ticksToDeploy:Int;

	@:selfCall
	public function new():Void;
}

/**
 * Contains energy which can be spent on spawning bigger creeps. Extensions can
 * be placed anywhere in the room, any spawns will be able to use them regardless
 * of distance.
 */
@:build(screeps.Macros.MacroUtils.extendFields(OwnedStructure, ["prototype"]))
extern class StructureExtension {
	final prototype:StructureExtension;

	/**
	 * The amount of energy containing in the extension.
	 * @deprecated An alias for .store[RESOURCE_ENERGY].
	 */
	var energy:Int;

	/**
	 * The total amount of energy the extension can contain.
	 * @deprecated An alias for .store.getCapacity(RESOURCE_ENERGY).
	 */
	var energyCapacity:Int;

	/**
	 * A Store object that contains cargo of this structure.
	 */
	var store:GenericStore;

	@:selfCall
	public function new():Void;
}

/**
 * Remotely transfers energy to another Link in the same room.
 */
@:build(screeps.Macros.MacroUtils.extendFields(OwnedStructure, ["prototype"]))
extern class StructureLink {
	final prototype:StructureLink;

	/**
	 * The amount of game ticks the link has to wait until the next transfer is possible.
	 */
	var cooldown:Int;

	/**
	 * The amount of energy containing in the link.
	 * @deprecated An alias for .store[RESOURCE_ENERGY].
	 */
	var energy:Int;

	/**
	 * The total amount of energy the link can contain.
	 * @deprecated An alias for .store.getCapacity(RESOURCE_ENERGY).
	 */
	var energyCapacity:Int;

	/**
	 * A Store object that contains cargo of this structure.
	 */
	var store:GenericStore;

	/**
	 * Transfer energy from the link to another link or a creep.
	 *
	 * If the target is a creep, it has to be at adjacent square to the link.
	 *
	 * If the target is a link, it can be at any location in the same room.
	 *
	 * Remote transfer process implies 3% energy loss and cooldown delay depending on the distance.
	 * @param target The target object.
	 * @param amount The amount of energy to be transferred. If omitted, all the available energy is used.
	 */
	public function transferEnergy(target:EitherType<Creep, StructureLink>, ?amount:Int):ScreepsReturnCode;

	@:selfCall
	public function new():Void;
}

/**
 * Allows to harvest mineral deposits.
 */
@:build(screeps.Macros.MacroUtils.extendFields(OwnedStructure, ["prototype"]))
extern class StructureExtractor {
	final prototype:StructureExtractor;

	/**
	 * The amount of game ticks until the next harvest action is possible.
	 */
	var cooldown:Int;

	@:selfCall
	public function new():Void;
}

/**
 * Remotely attacks or heals creeps, or repairs structures. Can be targeted to
 * any object in the room. However, its effectiveness highly depends on the
 * distance. Each action consumes energy.
 */
@:build(screeps.Macros.MacroUtils.extendFields(OwnedStructure, ["prototype"]))
extern class StructureTower {
	final prototype:StructureTower;

	/**
	 * The amount of energy containing in this structure.
	 * @deprecated An alias for .store[RESOURCE_ENERGY].
	 */
	var energy:Int;

	/**
	 * The total amount of energy this structure can contain.
	 * @deprecated An alias for .store.getCapacity(RESOURCE_ENERGY).
	 */
	var energyCapacity:Int;

	/**
	 * A Store object that contains cargo of this structure.
	 */
	var store:GenericStore;

	/**
	 * Remotely attack any creep or structure in the room. Consumes 10 energy units per tick. Attack power depends on the distance to the target: from 600 hits at range 10 to 300 hits at range 40.
	 * @param target The target creep.
	 */
	public function attack(target:EitherType<AnyCreep, Structure>):ScreepsReturnCode;

	/**
	 * Remotely heal any creep in the room. Consumes 10 energy units per tick. Heal power depends on the distance to the target: from 400 hits at range 10 to 200 hits at range 40.
	 * @param target The target creep.
	 */
	public function heal(target:AnyCreep):ScreepsReturnCode;

	/**
	 * Remotely repair any structure in the room. Consumes 10 energy units per tick. Repair power depends on the distance to the target: from 600 hits at range 10 to 300 hits at range 40.
	 * @param target The target structure.
	 */
	public function repair(target:Structure):ScreepsReturnCode;

	@:selfCall
	public function new():Void;
}

/**
 * Blocks movement of all creeps.
 */
@:build(screeps.Macros.MacroUtils.extendFields(Structure, ["prototype"]))
extern class StructureWall {
	final prototype:StructureWall;

	/**
	 * The amount of game ticks when the wall will disappear (only for automatically placed border walls at the start of the game).
	 */
	var ticksToLive:Int;

	@:selfCall
	public function new():Void;
}

/**
 * Produces mineral compounds from base minerals and boosts creeps.
 */
@:build(screeps.Macros.MacroUtils.extendFields(OwnedStructure, ["prototype"]))
extern class StructureLab {
	final prototype:StructureLab;

	/**
	 * The amount of game ticks the lab has to wait until the next reaction is possible.
	 */
	var cooldown:Int;

	/**
	 * The amount of energy containing in the lab. Energy is used for boosting creeps.
	 * @deprecated An alias for .store[RESOURCE_ENERGY].
	 */
	var energy:Int;

	/**
	 * The total amount of energy the lab can contain.
	 * @deprecated An alias for .store.getCapacity(RESOURCE_ENERGY).
	 */
	var energyCapacity:Int;

	/**
	 * The amount of mineral resources containing in the lab.
	 * @deprecated An alias for lab.store[lab.mineralType].
	 */
	var mineralAmount:Int;

	/**
	 * The type of minerals containing in the lab. Labs can contain only one mineral type at the same time.
	 * Null in case there is no mineral resource in the lab.
	 */
	var mineralType:EitherType<ResourceConstant, Void>;

	/**
	 * The total amount of minerals the lab can contain.
	 * @deprecated An alias for lab.store.getCapacity(lab.mineralType || yourMineral).
	 */
	var mineralCapacity:Int;

	/**
	 * A Store object that contains cargo of this structure.
	 */
	var store:GenericStore;

	/**
	 * Boosts creep body part using the containing mineral compound. The creep has to be at adjacent square to the lab. Boosting one body part consumes 30 mineral units and 20 energy units.
	 * @param creep The target creep.
	 * @param bodyPartsCount The number of body parts of the corresponding type to be boosted.
	 *
	 * Body parts are always counted left-to-right for TOUGH, and right-to-left for other types.
	 *
	 * If undefined, all the eligible body parts are boosted.
	 */
	public function boostCreep(creep:Creep, ?bodyPartsCount:Int):ScreepsReturnCode;

	/**
	 * Immediately remove boosts from the creep and drop 50% of the mineral compounds used to boost it onto the ground regardless of the creep's remaining time to live.
	 * The creep has to be at adjacent square to the lab.
	 * Unboosting requires cooldown time equal to the total sum of the reactions needed to produce all the compounds applied to the creep.
	 * @param creep The target creep.
	 */
	public function unboostCreep(creep:Creep):ScreepsReturnCode;

	/**
	 * Breaks mineral compounds back into reagents. The same output labs can be used by many source labs.
	 * @param lab1 The first result lab.
	 * @param lab2 The second result lab.
	 */
	public function reverseReaction(lab1:StructureLab, lab2:StructureLab):ScreepsReturnCode;

	/**
	 * Produce mineral compounds using reagents from two another labs. Each lab has to be within 2 squares range. The same input labs can be used by many output labs
	 * @param lab1 The first source lab.
	 * @param lab2 The second source lab.
	 */
	public function runReaction(lab1:StructureLab, lab2:StructureLab):ScreepsReturnCode;

	@:selfCall
	public function new():Void;
}

/**
 * Provides visibility into a distant room from your script.
 */
@:build(screeps.Macros.MacroUtils.extendFields(OwnedStructure, ["prototype"]))
extern class StructureObserver {
	final prototype:StructureObserver;

	/**
	 * Provide visibility into a distant room from your script. The target room object will be available on the next tick. The maximum range is 5 rooms.
	 * @param roomName The room to observe.
	 */
	public function observeRoom(roomName:String):ScreepsReturnCode;

	@:selfCall
	public function new():Void;
}

/**
 * Non-player structure. Contains power resource which can be obtained by destroying the structure. Hits the attacker creep back on each attack.
 */
@:build(screeps.Macros.MacroUtils.extendFields(OwnedStructure, ["prototype"]))
extern class StructurePowerBank {
	final prototype:StructurePowerBank;

	/**
	 * The amount of power containing.
	 */
	var power:Int;

	/**
	 * The amount of game ticks when this structure will disappear.
	 */
	var ticksToDecay:Int;

	@:selfCall
	public function new():Void;
}

/**
 * Non-player structure. Contains power resource which can be obtained by
 * destroying the structure. Hits the attacker creep back on each attack.
 */
@:build(screeps.Macros.MacroUtils.extendFields(OwnedStructure, ["prototype"]))
extern class StructurePowerSpawn {
	final prototype:StructurePowerSpawn;

	/**
	 * The amount of energy containing in this structure.
	 * @deprecated An alias for .store[RESOURCE_ENERGY].
	 */
	var energy:Int;

	/**
	 * The total amount of energy this structure can contain.
	 * @deprecated An alias for .store.getCapacity(RESOURCE_ENERGY).
	 */
	var energyCapacity:Int;

	/**
	 * The amount of power containing in this structure.
	 * @deprecated An alias for .store[RESOURCE_POWER].
	 */
	var power:Int;

	/**
	 * The total amount of power this structure can contain.
	 * @deprecated An alias for .store.getCapacity(RESOURCE_POWER).
	 */
	var powerCapacity:Int;

	/**
	 *
	 */
	var store:GenericStore;

	/**
	 * Register power resource units into your account. Registered power allows to develop power creeps skills. Consumes 1 power resource unit and 50 energy resource units.
	 */
	public function processPower():ScreepsReturnCode;

	@:selfCall
	public function new():Void;
}

/**
 * Blocks movement of hostile creeps, and defends your creeps and structures on
 * the same tile. Can be used as a controllable gate.
 */
@:build(screeps.Macros.MacroUtils.extendFields(OwnedStructure, ["prototype"]))
extern class StructureRampart {
	final prototype:StructureRampart;

	/**
	 * The amount of game ticks when this rampart will lose some hit points.
	 */
	var ticksToDecay:Int;

	/**
	 * If false (default), only your creeps can step on the same square. If true, any hostile creeps can pass through.
	 */
	var isPublic:Bool;

	/**
	 * Make this rampart public to allow other players' creeps to pass through.
	 * @param isPublic Whether this rampart should be public or non-public
	 */
	public function setPublic(isPublic:Bool):Void;

	@:selfCall
	public function new():Void;
}

/**
 * Decreases movement cost to 1. Using roads allows creating creeps with less
 * `MOVE` body parts.
 */
@:build(screeps.Macros.MacroUtils.extendFields(Structure, ["prototype"]))
extern class StructureRoad {
	final prototype:StructureRoad;

	/**
	 * The amount of game ticks when this road will lose some hit points.
	 */
	var ticksToDecay:Int;

	@:selfCall
	public function new():Void;
}

/**
 * Non-player structure. Spawns NPC Source Keepers that guards energy sources
 * and minerals in some rooms. This structure cannot be destroyed.
 */
@:build(screeps.Macros.MacroUtils.extendFields(OwnedStructure, ["prototype"]))
extern class StructureKeeperLair {
	final prototype:StructureKeeperLair;

	/**
	 * Time to spawning of the next Source Keeper.
	 */
	var ticksToSpawn:Int;

	@:selfCall
	public function new():Void;
}

/**
 * Spawns are your colony centers. This structure can create, renew, and recycle
 * creeps. All your spawns are accessible through `Game.spawns` hash list.
 * Spawns auto-regenerate a little amount of energy each tick, so that you can
 * easily recover even if all your creeps died.
 */
@:build(screeps.Macros.MacroUtils.extendFields(OwnedStructure, ["prototype", "destroy", "isActive", "notifyWhenAttacked"]))
extern class StructureSpawn {
	final prototype:StructureSpawn;

	/**
	 * The amount of energy containing in the spawn.
	 * @deprecated An alias for .store[RESOURCE_ENERGY].
	 */
	var energy:Int;

	/**
	 * The total amount of energy the spawn can contain
	 * @deprecated An alias for .store.getCapacity(RESOURCE_ENERGY).
	 */
	var energyCapacity:Int;

	/**
	 * A shorthand to `Memory.spawns[spawn.name]`. You can use it for quick access
	 * the spawn’s specific memory data object.
	 *
	 * @see http://docs.screeps.com/global-objects.html#Memory-object
	 */
	var memory:JsObject<Any>;

	/**
	 * Spawn's name. You choose the name upon creating a new spawn, and it cannot
	 * be changed later. This name is a hash key to access the spawn via the
	 * `Game.spawns` object.
	 */
	var name:String;

	/**
	 * If the spawn is in process of spawning a new creep, this object will contain the new creep’s information, or null otherwise.
	 */
	var spawning:EitherType<Spawning, Void>;

	/**
	 * A Store object that contains cargo of this structure.
	 */
	var store:GenericStore;

	/**
	 * Check if a creep can be created.
	 *
	 * @deprecated This method is deprecated and will be removed soon. Please use `StructureSpawn.spawnCreep` with `dryRun` flag instead.
	 * @param body An array describing the new creep’s body. Should contain 1 to 50 elements with one of these constants: WORK, MOVE, CARRY, ATTACK, RANGED_ATTACK, HEAL, TOUGH, CLAIM
	 * @param name The name of a new creep.
	 *
	 * It should be unique creep name, i.e. the Game.creeps object should not contain another creep with the same name (hash key).
	 *
	 * If not defined, a random name will be generated.
	 */
	public function canCreateCreep(body:Array<BodyPart>, ?name:String):ScreepsReturnCode;

	/**
	 * Start the creep spawning process.
	 *
	 * @deprecated This method is deprecated and will be removed soon. Please use `StructureSpawn.spawnCreep` instead.
	 * @param body An array describing the new creep’s body. Should contain 1 to 50 elements with one of these constants: WORK, MOVE, CARRY, ATTACK, RANGED_ATTACK, HEAL, TOUGH, CLAIM
	 * @param name The name of a new creep.
	 *
	 * It should be unique creep name, i.e. the Game.creeps object should not contain another creep with the same name (hash key).
	 *
	 * If not defined, a random name will be generated.
	 * @param memory The memory of a new creep. If provided, it will be immediately stored into Memory.creeps[name].
	 * @returns The name of a new creep or one of these error codes:
	 * ```
	 * ERR_NOT_OWNER            -1  You are not the owner of this spawn.
	 * ERR_NAME_EXISTS          -3  There is a creep with the same name already.
	 * ERR_BUSY                 -4  The spawn is already in process of spawning another creep.
	 * ERR_NOT_ENOUGH_ENERGY    -6  The spawn and its extensions contain not enough energy to create a creep with the given body.
	 * ERR_INVALID_ARGS         -10 Body is not properly described.
	 * ERR_RCL_NOT_ENOUGH       -14 Your Room Controller level is not enough to use this spawn.
	 * ```
	 */
	public function createCreep(body:Array<BodyPart>, ?name:String, ?memory:JsObject<Any>):EitherType<ScreepsReturnCode, String>;

	/**
	 * Start the creep spawning process. The required energy amount can be withdrawn from all spawns and extensions in the room.
	 *
	 * @param body An array describing the new creep’s body. Should contain 1 to 50 elements with one of these constants:
	 *  * WORK
	 *  * MOVE
	 *  * CARRY
	 *  * ATTACK
	 *  * RANGED_ATTACK
	 *  * HEAL
	 *  * TOUGH
	 *  * CLAIM
	 * @param name The name of a new creep. It must be a unique creep name, i.e. the Game.creeps object should not contain another creep with the same name (hash key).
	 * @param opts An object with additional options for the spawning process.
	 * @returns One of the following codes:
	 * ```
	 * OK                       0   The operation has been scheduled successfully.
	 * ERR_NOT_OWNER            -1  You are not the owner of this spawn.
	 * ERR_NAME_EXISTS          -3  There is a creep with the same name already.
	 * ERR_BUSY                 -4  The spawn is already in process of spawning another creep.
	 * ERR_NOT_ENOUGH_ENERGY    -6  The spawn and its extensions contain not enough energy to create a creep with the given body.
	 * ERR_INVALID_ARGS         -10 Body is not properly described or name was not provided.
	 * ERR_RCL_NOT_ENOUGH       -14 Your Room Controller level is insufficient to use this spawn.
	 * ```
	 */
	public function spawnCreep(body:Array<BodyPart>, name:String, ?opts:SpawnOptions):ScreepsReturnCode;

	/**
	 * Destroy this spawn immediately.
	 */
	public function destroy():ScreepsReturnCode;

	/**
	 * Check whether this structure can be used. If the room controller level is not enough, then this method will return false, and the structure will be highlighted with red in the game.
	 */
	public function isActive():Bool;

	/**
	 * Toggle auto notification when the spawn is under attack. The notification will be sent to your account email. Turned on by default.
	 * @param enabled Whether to enable notification or disable.
	 */
	public function notifyWhenAttacked(enabled:Bool):ScreepsReturnCode;

	/**
	 * Increase the remaining time to live of the target creep.
	 *
	 * The target should be at adjacent square.
	 *
	 * The spawn should not be busy with the spawning process.
	 *
	 * Each execution increases the creep's timer by amount of ticks according to this formula: floor(600/body_size).
	 *
	 * Energy required for each execution is determined using this formula: ceil(creep_cost/2.5/body_size).
	 * @param target The target creep object.
	 */
	public function renewCreep(target:Creep):ScreepsReturnCode;

	/**
	 * Kill the creep and drop up to 100% of resources spent on its spawning and boosting depending on remaining life time. The target should be at adjacent square.
	 * @param target The target creep object.
	 */
	public function recycleCreep(target:Creep):ScreepsReturnCode;
}

extern class Spawning {
	final prototype:Spawning;

	/**
	 * An array with the spawn directions
	 * @see http://docs.screeps.com/api/#StructureSpawn.Spawning.setDirections
	 */
	var directions:Array<Directions>;

	/**
	 * The name of the creep
	 */
	var name:String;

	/**
	 * Time needed in total to complete the spawning.
	 */
	var needTime:Int;

	/**
	 * Remaining time to go.
	 */
	var remainingTime:Int;

	/**
	 * A link to the spawn
	 */
	var spawn:StructureSpawn;

	/**
	 * Cancel spawning immediately. Energy spent on spawning is not returned.
	 */
	public function cancel():ScreepsReturnCode;

	/**
	 * Set desired directions where the creep should move when spawned.
	 * @param directions An array with the spawn directions
	 */
	public function setDirections(directions:Array<Directions>):ScreepsReturnCode;
}

/**
 * An object with additional options for the spawning process.
 */
extern typedef SpawnOptions = {
	/**
	 * Memory of the new creep. If provided, it will be immediately stored into Memory.creeps[name].
	 */
	var ?memory:JsObject<Any>;

	/**
	 * Array of spawns/extensions from which to draw energy for the spawning process.
	 * Structures will be used according to the array order.
	 */
	var ?energyStructures:Array<EitherType<StructureSpawn, StructureExtension>>;

	/**
	 * If dryRun is <code>true</code>, the operation will only check if it is possible to create a creep.
	 */
	var ?dryRun:Bool;

	/**
	 * Set desired directions where the creep should move when spawned.
	 * An array with the direction constants.
	 */
	var ?directions:Array<Directions>;
}

typedef AnyOwnedStructure = MacroType<[
	screeps.Macros.MacroUtils.buildNestedFields([
		"StructureController", "StructureExtension", "StructureFactory", "StructureInvaderCore", "StructureKeeperLair", "StructureLab", "StructureLink",
		"StructureNuker", "StructureObserver", "StructurePowerBank", "StructurePowerSpawn", "StructureRampart", "StructureSpawn", "StructureStorage",
		"StructureTerminal", "StructureTower"
	])
]>;

typedef AnyStoreStructure = MacroType<[
	screeps.Macros.MacroUtils.buildNestedFields([
		"StructureExtension", "StructureFactory", "StructureLink", "StructureNuker", "StructurePowerSpawn", "StructureSpawn", "StructureStorage",
		"StructureTerminal", "StructureTower", "StructureContainer"
	])
]>;

typedef AnyStructure = MacroType<[
	screeps.Macros.MacroUtils.buildNestedFields([
		"AnyOwnedStructure",
		"StructureContainer",
		"StructurePortal",
		"StructureRoad",
		"StructureWall"
	])
]>;
