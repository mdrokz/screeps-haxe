package screeps;

import haxe.extern.EitherType;
import haxe.ds.Either;
import screeps.Macros.MacroUtils;
import haxe.ds.ReadOnlyArray;
import haxe.macro.MacroType;

extern enum abstract ScreepsReturnCode(Int) {
	final OK = 0;
	final ERR_NOT_OWNER = -1;
	final ERR_NOT_PATH = -2;
	final ERR_NOT_EXISTS = -3;
	final ERR_BUSY = -4;
	final ERR_NOT_FOUND = -5;
	final ERR_NOT_ENOUGH_RESOURCES = -6;
	final ERR_NOT_ENOUGH_ENERGY = -7;
	final ERR_INVALID_TARGET = -8;
	final ERR_FULL = -9;
	final ERR_NOT_IN_RANGE = -10;
	final ERR_INVALID_ARGS = -11;
	final ERR_TIRED = -12;
	final ERR_NO_BODYPART = -13;
	final ERR_NOT_ENOUGH_EXTENSIONS = -14;
	final ERR_RCL_NOT_ENOUGH = -15;
	final ERR_GCL_NOT_ENOUGH = -16;
}

extern enum abstract ExitConstant(Int) {
	final FIND_EXIT_TOP = 1;
	final FIND_EXIT_RIGHT = 3;
	final FIND_EXIT_BOTTOM = 5;
	final FIND_EXIT_LEFT = 7;
}

extern enum abstract Find(Int) {
	final FIND_EXIT_TOP = 1;
	final FIND_EXIT_RIGHT = 3;
	final FIND_EXIT_BOTTOM = 5;
	final FIND_EXIT_LEFT = 7;
	final FIND_EXIT = 10;
	final FIND_CREEPS = 101;
	final FIND_MY_CREEPS = 102;
	final FIND_HOSTILE_CREEPS = 103;
	final FIND_SOURCES_ACTIVE = 104;
	final FIND_SOURCES = 105;
	final FIND_DROPPED_RESOURCES = 106;
	final FIND_STRUCTURES = 107;
	final FIND_MY_STRUCTURES = 108;
	final FIND_HOSTILE_STRUCTURES = 109;
	final FIND_FLAGS = 110;
	final FIND_CONSTRUCTION_SITES = 111;
	final FIND_MY_SPAWNS = 112;
	final FIND_HOSTILE_SPAWNS = 113;
	final FIND_MY_CONSTRUCTION_SITES = 114;
	final FIND_HOSTILE_CONSTRUCTION_SITES = 115;
	final FIND_MINERALS = 116;
	final FIND_NUKES = 117;
	final FIND_TOMBSTONES = 118;
	final FIND_POWER_CREEPS = 119;
	final FIND_MY_POWER_CREEPS = 120;
	final FIND_HOSTILE_POWER_CREEPS = 121;
	final FIND_DEPOSITS = 122;
	final FIND_RUINS = 123;
}

extern enum abstract FindStructure(String) {
	final FIND_STRUCTURES = 107;
	final FIND_MY_STRUCTURES = 108;
	final FIND_HOSTILE_STRUCTURES = 109;
}

extern enum abstract Directions(Int) {
	final TOP = 1;
	final TOP_RIGHT = 2;
	final RIGHT = 3;
	final BOTTOM_RIGHT = 4;
	final BOTTOM = 5;
	final BOTTOM_LEFT = 6;
	final LEFT = 7;
	final TOP_LEFT = 8;
}

extern enum abstract Colors(Int) {
	final COLOR_RED = 1;
	final COLOR_PURPLE = 2;
	final COLOR_BLUE = 3;
	final COLOR_CYAN = 4;
	final COLOR_GREEN = 5;
	final COLOR_YELLOW = 6;
	final COLOR_ORANGE = 7;
	final COLOR_BROWN = 8;
	final COLOR_GREY = 9;
	final COLOR_WHITE = 10;
}

extern class Constants {
	public static inline function COLORS_ALL():ReadOnlyArray<Colors> {
		return MacroUtils.getValues(Colors);
	}
	public static inline function BODYPART_ALL():ReadOnlyArray<BodyPart> {
		return MacroUtils.getValues(BodyPart);
	}
	public static inline function RESOURCE_ALL():ReadOnlyArray<ResourceConstant> {
		return MacroUtils.getValues(ResourceConstant);
	}

	public static inline function INTERSHARD_RESOURCES():ReadOnlyArray<InterShard> {
		return MacroUtils.getValues(InterShard);
	}
}

extern enum abstract FindClosestByPathAlgorithm(String) {
	final astar = "astar";
	final dijsktra = "dijsktra";
}

extern enum abstract CreepInfo(Int) {
	final CREEP_SPAWN_TIME = 3;
	final CREEP_LIFE_TIME = 1500;
	final CREEP_CLAIM_LIFE_TIME = 600;
	final CREEP_CORPSE_RATE = 0.2;
}

extern enum abstract ObstacleObjectTypes(String) {
	final spawn = "spawn";
	final creep = "creep";
	final powerCreep = "powerCreep";
	final source = "source";
	final mineral = "mineral";
	final deposit = "deposit";
	final controller = "controller";
	final constructedWall = "constructedWall";
	final extension = "extension";
	final link = "link";
	final storage = "storage";
	final tower = "tower";
	final observer = "observer";
	final powerSpawn = "powerSpawn";
	final powerBank = "powerBank";
	final lab = "lab";
	final terminal = "terminal";
	final nuker = "nuker";
	final factory = "factory";
	final invaderCore = "invaderCore";
}

extern enum abstract Energy(Int) {
	final ENERGY_REGEN_TIME = 300;
	final ENERGY_DECAY = 1000;
}

extern enum abstract Repair(Float) {
	final REPAIR_COST = 0.01;
}

extern enum abstract Rampart(Int) {
	final RAMPART_DECAY_AMOUNT = 300;
	final RAMPART_DECAY_TIME = 100;
	final RAMPART_HITS = 1;
}

extern enum abstract RampartHitsMax(Int) {
	final TWO = 300000;
	final THREE = 1000000;
	final FOUR = 3000000;
	final FIVE = 10000000;
	final SIX = 30000000;
	final SEVEN = 100000000;
	final EIGHT = 300000000;
}

extern enum abstract Spawn(Int) {
	final SPAWN_HITS = 5000;
	final SPAWN_ENERGY_START = 300;
	final SPAWN_ENERGY_CAPACITY = 300;
}

extern enum abstract SourceConstant(Int) {
	final SOURCE_ENERGY_CAPACITY = 3000;
	final SOURCE_ENERGY_NEUTRAL_CAPACITY = 1500;
	final SOURCE_ENERGY_KEEPER_CAPACITY = 4000;
}

extern enum abstract Wall(Int) {
	final WALL_HITS = 1;
	final WALL_HITS_MAX = 300000000;
}

extern enum abstract Extension(Int) {
	final EXTENSION_HITS = 20;
}

extern enum abstract ExtensionEnergyCapacity(Int) {
	final ZERO = 50;
	final ONE = 50;
	final TWO = 50;
	final THREE = 50;
	final FOUR = 50;
	final FIVE = 50;
	final SIX = 50;
	final SEVEN = 100;
	final EIGHT = 200;
}

extern enum abstract Road(Int) {
	final ROAD_HITS = 5000;
	final ROAD_WEAROUT = 1;
	final ROAD_WEAROUT_POWER_CREEP = 100;
	final ROAD_DECAY_AMOUNT = 100;
	final ROAD_DECAY_TIME = 1000;
}

extern enum abstract Link(Int) {
	final LINK_HITS = 1000;
	final LINK_HITS_MAX = 1000;
	final LINK_CAPACITY = 800;
	final LINK_COOLDOWN = 1;
	final LINK_LOSS_RATIO = 0.03;
}

extern enum abstract Storage(Int) {
	final STORAGE_CAPACITY = 1000000;
	final STORAGE_HITS = 10000;
}

extern enum abstract Factory(Int) {
	final FACTORY_HITS = 1000;
	final FACTORY_CAPACITY = 50000;
}

extern enum abstract BodyPart(String) {
	final MOVE = "move";
	final WORK = "work";
	final CARRY = "carry";
	final ATTACK = "attack";
	final RANGED_ATTACK = "ranged_attack";
	final TOUGH = "tough";
	final HEAL = "heal";
	final CLAIM = "claim";
}

extern enum abstract BodyPartCost(Int) {
	final move = 50;
	final work = 100;
	final attack = 80;
	final carry = 50;
	final heal = 250;
	final ranged_attack = 150;
	final tough = 10;
	final claim = 600;
}

extern enum abstract Carry(Int) {
	final CARRY_CAPACITY = 50;
}

extern enum abstract Power(Int) {
	final HARVEST_POWER = 2;
	final HARVEST_MINERAL_POWER = 1;
	final HARVEST_DEPOSIT_POWER = 1;
	final REPAIR_POWER = 100;
	final DISMANTLE_POWER = 50;
	final BUILD_POWER = 5;
	final ATTACK_POWER = 30;
	final UPGRADE_CONTROLLER_POWER = 1;
	final RANGED_ATTACK_POWER = 10;
	final HEAL_POWER = 12;
	final RANGED_HEAL_POWER = 4;
	final POWER_LEVEL_MULTIPLY = 1000;
	final POWER_LEVEL_POW = 2;
	final POWER_CREEP_SPAWN_COOLDOWN = 28800000; // 8 * 3600 * 1000
	final POWER_CREEP_DELETE_COOLDOWN = 86400000; // 24 * 3600 * 1000
	final POWER_CREEP_MAX_LEVEL = 25;
	final POWER_CREEP_LIFE_TIME = 5000;
}

extern enum abstract PowerClass(String) {
	final Operator = "operator";
}

extern enum abstract Cost(Int) {
	final DISMANTLE_COST = 0.005;
	final CONSTRUCTION_COST_ROAD_SWAMP_RATIO = 5;
	final CONSTRUCTION_COST_ROAD_WALL_RATIO = 150;
	final PIXEL_CPU_COST = 5000;
}

extern enum abstract ConstructionCost(Int) {
	final spawn = 15000;
	final extension = 3000;
	final road = 300;
	final constructedWall = 1;
	final rampart = 1;
	final link = 5000;
	final storage = 30000;
	final tower = 5000;
	final observer = 8000;
	final powerSpawn = 100000;
	final extractor = 5000;
	final lab = 50000;
	final terminal = 100000;
	final container = 5000;
	final nuker = 100000;
	final factory = 100000;
}

extern enum abstract StructureConstant(String) {
	final STRUCTURE_EXTENSION = "extension";
	final STRUCTURE_RAMPART = "rampart";
	final STRUCTURE_ROAD = "road";
	final STRUCTURE_SPAWN = "spawn";
	final STRUCTURE_LINK = "link";
	final STRUCTURE_WALL = "wall";
	final STRUCTURE_KEEPER_LAIR = "keeperLair";
	final STRUCTURE_CONTROLLER = "controller";
	final STRUCTURE_STORAGE = "storage";
	final STRUCTURE_TOWER = "tower";
	final STRUCTURE_OBSERVER = "observer";
	final STRUCTURE_POWER_BANK = "powerBank";
	final STRUCTURE_POWER_SPAWN = "powerSpawn";
	final STRUCTURE_EXTRACTOR = "extractor";
	final STRUCTURE_LAB = "lab";
	final STRUCTURE_TERMINAL = "terminal";
	final STRUCTURE_CONTAINER = "container";
	final STRUCTURE_NUKER = "nuker";
	final STRUCTURE_FACTORY = "factory";
	final STRUCTURE_INVADER_CORE = "invadorCore";
	final STRUCTURE_PORTAL = "portal";
}

extern abstract STRUCTURE_SPAWN(String) {
	@:selfCall
	public inline function new() {
		this = "spawn";
	}
}

extern enum abstract BuildableStructure(String) {
	final STRUCTURE_EXTENSION = "extension";
	final STRUCTURE_RAMPART = "rampart";
	final STRUCTURE_ROAD = "road";
	final STRUCTURE_SPAWN = "spawn";
	final STRUCTURE_LINK = "link";
	final STRUCTURE_WALL = "wall";
	final STRUCTURE_STORAGE = "storage";
	final STRUCTURE_TOWER = "tower";
	final STRUCTURE_OBSERVER = "observer";
	final STRUCTURE_POWER_SPAWN = "powerSpawn";
	final STRUCTURE_LAB = "lab";
	final STRUCTURE_TERMINAL = "terminal";
	final STRUCTURE_CONTAINER = "container";
	final STRUCTURE_NUKER = "nuker";
	final STRUCTURE_FACTORY = "factory";
}

extern enum abstract ResourceConstant(String) {
	final RESOURCE_ENERGY = "energy";
	final RESOURCE_POWER = "power";
	final RESOURCE_OPS = "ops";
	final RESOURCE_UTRIUM = "U";
	final RESOURCE_LEMERGIUM = "L";
	final RESOURCE_KEANIUM = "K";
	final RESOURCE_GHODIUM = "G";
	final RESOURCE_ZYNTHIUM = "Z";
	final RESOURCE_OXYGEN = "O";
	final RESOURCE_HYDROGEN = "H";
	final RESOURCE_CATALYST = "X";
	final RESOURCE_HYDROXIDE = "OH";
	final RESOURCE_ZYNTHIUM_KEANITE = "ZK";
	final RESOURCE_UTRIUM_LEMERGITE = "UL";
	final RESOURCE_UTRIUM_HYDRIDE = "UH";
	final RESOURCE_UTRIUM_OXIDE = "UO";
	final RESOURCE_KEANIUM_HYDRIDE = "KH";
	final RESOURCE_KEANIUM_OXIDE = "KO";
	final RESOURCE_LEMERGIUM_HYDRIDE = "LH";
	final RESOURCE_LEMERGIUM_OXIDE = "LO";
	final RESOURCE_ZYNTHIUM_HYDRIDE = "ZH";
	final RESOURCE_ZYNTHIUM_OXIDE = "ZO";
	final RESOURCE_GHODIUM_HYDRIDE = "GH";
	final RESOURCE_GHODIUM_OXIDE = "GO";
	final RESOURCE_UTRIUM_ACID = "UH2O";
	final RESOURCE_UTRIUM_ALKALIDE = "UHO2";
	final RESOURCE_KEANIUM_ACID = "KH2O";
	final RESOURCE_KEANIUM_ALKALIDE = "KHO2";
	final RESOURCE_LEMERGIUM_ACID = "LH2O";
	final RESOURCE_LEMERGIUM_ALKALIDE = "LHO2";
	final RESOURCE_ZYNTHIUM_ACID = "ZH2O";
	final RESOURCE_ZYNTHIUM_ALKALIDE = "ZHO2";
	final RESOURCE_GHODIUM_ACID = "GH2O";
	final RESOURCE_GHODIUM_ALKALIDE = "GHO2";
	final RESOURCE_CATALYZED_UTRIUM_ACID = "XUH2O";
	final RESOURCE_CATALYZED_UTRIUM_ALKALIDE = "XUHO2";
	final RESOURCE_CATALYZED_KEANIUM_ACID = "XKH2O";
	final RESOURCE_CATALYZED_KEANIUM_ALKALIDE = "XKHO2";
	final RESOURCE_CATALYZED_LEMERGIUM_ACID = "XLH2O";
	final RESOURCE_CATALYZED_LEMERGIUM_ALKALIDE = "XLHO2";
	final RESOURCE_CATALYZED_ZYNTHIUM_ACID = "XZH2O";
	final RESOURCE_CATALYZED_ZYNTHIUM_ALKALIDE = "XZHO2";
	final RESOURCE_CATALYZED_GHODIUM_ACID = "XGH2O";
	final RESOURCE_CATALYZED_GHODIUM_ALKALIDE = "XGHO2";
	final RESOURCE_BIOMASS = "biomass";
	final RESOURCE_METAL = "metal";
	final RESOURCE_MIST = "mist";
	final RESOURCE_SILICON = "silicon";
	final RESOURCE_UTRIUM_BAR = "utrium_bar";
	final RESOURCE_LEMERGIUM_BAR = "lemergium_bar";
	final RESOURCE_ZYNTHIUM_BAR = "zynthium_bar";
	final RESOURCE_KEANIUM_BAR = "keanium_bar";
	final RESOURCE_GHODIUM_MELT = "ghodium_melt";
	final RESOURCE_OXIDANT = "oxidant";
	final RESOURCE_REDUCTANT = "reductant";
	final RESOURCE_PURIFIER = "purifier";
	final RESOURCE_BATTERY = "battery";
	final RESOURCE_COMPOSITE = "composite";
	final RESOURCE_CRYSTAL = "crystal";
	final RESOURCE_LIQUID = "liquid";
	final RESOURCE_WIRE = "wire";
	final RESOURCE_SWITCH = "switch";
	final RESOURCE_TRANSISTOR = "transistor";
	final RESOURCE_MICROCHIP = "microchip";
	final RESOURCE_CIRCUIT = "circuit";
	final RESOURCE_DEVICE = "device";
	final RESOURCE_CELL = "cell";
	final RESOURCE_PHLEGM = "phlegm";
	final RESOURCE_TISSUE = "tissue";
	final RESOURCE_MUSCLE = "muscle";
	final RESOURCE_ORGANOID = "organoid";
	final RESOURCE_ORGANISM = "organism";
	final RESOURCE_ALLOY = "alloy";
	final RESOURCE_TUBE = "tube";
	final RESOURCE_FIXTURES = "fixtures";
	final RESOURCE_FRAME = "frame";
	final RESOURCE_HYDRAULICS = "hydraulics";
	final RESOURCE_MACHINE = "machine";
	final RESOURCE_CONDENSATE = "condensate";
	final RESOURCE_CONCENTRATE = "concentrate";
	final RESOURCE_EXTRACT = "extract";
	final RESOURCE_SPIRIT = "spirit";
	final RESOURCE_EMANATION = "emanation";
	final RESOURCE_ESSENCE = "essence";
}

typedef Resources = MacroType<[screeps.Macros.MacroUtils.buildStructureFromEnum(ResourceConstant, ["switch"])]> & {
	@:native("switch") var _switch:Int;
}

extern enum abstract Minerals(String) {
	var RESOURCE_UTRIUM = "U";
	var RESOURCE_LEMERGIUM = "L";
	var RESOURCE_KEANIUM = "K";
	var RESOURCE_ZYNTHIUM = "Z";
	var RESOURCE_OXYGEN = "O";
	var RESOURCE_HYDROGEN = "H";
	var RESOURCE_CATALYST = "X";
}

extern enum abstract InterShard(String) {
	final SUBSCRIPTION_TOKEN = "token";
	final CPU_UNLOCK = "cpuUnlock";
	final PIXEL = "pixel";
	final ACCESS_KEY = "accessKey";
}

typedef MarketResource = EitherType<ResourceConstant, InterShard>;

extern enum abstract ControllerLevels(Int) {
	final ONE = 200;
	final TWO = 45000;
	final THREE = 135000;
	final FOUR = 405000;
	final FIVE = 1215000;
	final SIX = 3645000;
	final SEVEN = 10935000;
}

@:keep @:native("CONTROLLER_STRUCTURES") extern class ControllerStructures {
	public static final spawn:Array<Int>;
	public static final extension:Array<Int>;
	public static final link:Array<Int>;
	public static final road:Array<Int>;
	public static final constructedWall:Array<Int>;
	public static final rampart:Array<Int>;
	public static final storage:Array<Int>;
	public static final tower:Array<Int>;
	public static final observer:Array<Int>;
	public static final powerSpawn:Array<Int>;
	public static final extractor:Array<Int>;
	public static final terminal:Array<Int>;
	public static final lab:Array<Int>;
	public static final container:Array<Int>;
	public static final nuker:Array<Int>;
	public static final factory:Array<Int>;

	@:selfCall public function new():Void;
}

extern enum abstract ControllerDownGrade(Int) {
	final ONE = 20000;
	final TWO = 10000;
	final THREE = 20000;
	final FOUR = 40000;
	final FIVE = 80000;
	final SIX = 120000;
	final SEVEN = 150000;
	final EIGHT = 200000;
}

extern enum abstract Controller(Int) {
	final CONTROLLER_DOWNGRADE_RESTORE = 100;
	final CONTROLLER_DOWNGRADE_SAFEMODE_THRESHOLD = 5000;
	final CONTROLLER_CLAIM_DOWNGRADE = 300;
	final CONTROLLER_RESERVE = 1;
	final CONTROLLER_RESERVE_MAX = 5000;
	final CONTROLLER_MAX_UPGRADE_PER_TICK = 15;
	final CONTROLLER_ATTACK_BLOCKED_UPGRADE = 1000;
	final CONTROLLER_NUKE_BLOCKED_UPGRADE = 200;
}

extern enum abstract SafeMode(Int) {
	final SAFE_MODE_DURATION = 20000;
	final SAFE_MODE_COOLDOWN = 50000;
	final SAFE_MODE_COST = 1000;
}

extern enum abstract Tower(Int) {
	final TOWER_HITS = 3000;
	final TOWER_CAPACITY = 1000;
	final TOWER_ENERGY_COST = 10;
	final TOWER_POWER_ATTACK = 600;
	final TOWER_POWER_HEAL = 400;
	final TOWER_POWER_REPAIR = 800;
	final TOWER_OPTIMAL_RANGE = 5;
	final TOWER_FALLOFF_RANGE = 20;
	final TOWER_FALLOFF = 0.75;
}

extern enum abstract PowerBank(Int) {
	final POWER_BANK_HITS = 2000000;
	final POWER_BANK_CAPACITY_MAX = 5000;
	final POWER_BANK_CAPACITY_MIN = 500;
	final POWER_BANK_CAPACITY_CRIT = 0.3;
	final POWER_BANK_DECAY = 5000;
	final POWER_BANK_HIT_BACK = 0.5;
}

extern enum abstract PowerSpawn(Int) {
	final POWER_SPAWN_HITS = 5000;
	final POWER_SPAWN_ENERGY_CAPACITY = 5000;
	final POWER_SPAWN_POWER_CAPACITY = 100;
	final POWER_SPAWN_ENERGY_RATIO = 50;
}

extern enum abstract Extractor(Int) {
	final EXTRACTOR_HITS = 500;
	final EXTRACTOR_COOLDOWN = 5;
}

extern enum abstract Lab(Int) {
	final LAB_HITS = 500;
	final LAB_MINERAL_CAPACITY = 3000;
	final LAB_ENERGY_CAPACITY = 2000;
	final LAB_BOOST_ENERGY = 20;
	final LAB_BOOST_MINERAL = 30;
	final LAB_COOLDOWN = 10;
	final LAB_REACTION_AMOUNT = 5;
	final LAB_UNBOOST_ENERGY = 0;
	final LAB_UNBOOST_MINERAL = 15;
}

extern enum abstract GCL(Int) {
	final GCL_POW = 2.4;
	final GCL_MULTIPLY = 1000000;
	final GCL_NOVICE = 3;
}

extern enum abstract Mode(String) {
	final MODE_SIMULATION = null;
	final MODE_WORLD = null;
}

extern enum abstract Num(Int) {
	var ZERO = 0;
}

extern enum abstract Terrain(Int) {
	final TERRAIN_MASK_WALL = 1;
	final TERRAIN_MASK_SWAMP = 2;
	final TERRAIN_MASK_LAVA = 4;
}

extern enum abstract TerrainType(String) {
	final plain = "plain";
	final swamp = "swamp";
	final wall = "wall";
}

extern enum abstract Common(Int) {
	final MAX_CONSTRUCTION_SITES = 100;
	final MAX_CREEP_SIZE = 50;
}

extern enum abstract MineralConstant(Int) {
	final MINERAL_REGEN_TIME = 50000;
	final MINERAL_RANDOM_FACTOR = 2;
	final MINERAL_DENSITY_CHANGE = 0.05;
}

extern enum abstract MineralMinAmount(Int) {
	final H = 35000;
	final O = 35000;
	final L = 35000;
	final K = 35000;
	final Z = 35000;
	final U = 35000;
	final X = 35000;
}

extern enum abstract MineralDensity(Int) {
	final ONE = 15000;
	final TWO = 35000;
	final THREE = 70000;
	final FOUR = 100000;
}

extern enum abstract MineralDensityProbability(Float) {
	final ONE = 0.1;
	final TWO = 0.5;
	final THREE = 0.9;
	final FOUR = 1.0;
}

extern enum abstract Density(Int) {
	final DENSITY_LOW = 1;
	final DENSITY_MODERATE = 2;
	final DENSITY_HIGH = 3;
	final DENSITY_ULTRA = 4;
}

extern enum abstract DepositConstant(Int) {
	final DEPOSIT_EXHAUST_MULTIPLY = 0.001;
	final DEPOSIT_EXHAUST_POW = 1.2;
	final DEPOSIT_DECAY_TIME = 50000;
}

extern enum abstract Terminal(Int) {
	final TERMINAL_CAPACITY = 300000;
	final TERMINAL_HITS = 3000;
	final TERMINAL_SEND_COST = 0.1;
	final TERMINAL_MIN_SEND = 100;
	final TERMINAL_COOLDOWN = 10;
}

extern enum abstract Container(Int) {
	final CONTAINER_HITS = 250000;
	final CONTAINER_CAPACITY = 2000;
	final CONTAINER_DECAY = 5000;
	final CONTAINER_DECAY_TIME = 100;
	final CONTAINER_DECAY_TIME_OWNED = 500;
}

extern enum abstract Nuker(Int) {
	final NUKER_HITS = 1000;
	final NUKER_COOLDOWN = 100000;
	final NUKER_ENERGY_CAPACITY = 300000;
	final NUKER_GHODIUM_CAPACITY = 5000;
	final NUKE_LAND_TIME = 50000;
	final NUKE_RANGE = 10;
}

extern enum abstract NukeDamage(Int) {
	final ZERO = 10000000;
	final TWO = 5000000;
}

extern enum abstract TombStoneConstant(Int) {
	final TOMBSTONE_DECAY_PER_PART = 5;
	final TOMBSTONE_DECAY_POWER_CREEP = 500;
}

extern enum abstract RuinConstant(Int) {
	final RUIN_DECAY = 500;
}

extern enum abstract RuinDecayStructure(Int) {
	final powerBank = 10;
}

extern enum abstract Decay(Int) {
	final PORTAL_DECAY = 30000;
}

extern enum abstract OrderConstant(String) {
	final ORDER_SELL = "sell";
	final ORDER_BUY = "buy";
}

extern enum abstract MarketConstant(Int) {
	final MARKET_FEE = 0.05;
	final MARKET_MAX_ORDERS = 300;
	final MARKET_ORDER_LIFE_TIME = 1000 * 60 * 60 * 24 * 30;
}

extern enum abstract FlagConstant(Int) {
	final FLAGS_LIMIT = 10000;
}

typedef OReaction = {
	final O:String;
	final L:String;
	final K:String;
	final U:String;
	final Z:String;
	final G:String;
}

typedef HReaction = {
	final H:String;
	final L:String;
	final K:String;
	final U:String;
	final Z:String;
	final G:String;
}

typedef KHOReaction = {
	final K:String;
	final H:String;
	final O:String;
}

typedef UHOReaction = {
	final U:String;
	final H:String;
	final O:String;
}

typedef ZHOReaction = {
	final Z:String;
	final H:String;
	final O:String;
}

typedef HOReaction = {
	final H:String;
	final O:String;
}

typedef LHOReaction = {
	final L:String;
	final H:String;
	final O:String;
}

typedef MultiReaction = {
	final UH:String;
	final UO:String;
	final ZH:String;
	final ZO:String;
	final KH:String;
	final KO:String;
	final LH:String;
	final LO:String;
	final GH:String;
	final GO:String;
}

typedef Multi2Reaction = {
	final UH2O:String;
	final UHO2:String;
	final LH2O:String;
	final LHO2:String;
	final KH2O:String;
	final KHO2:String;
	final ZH2O:String;
	final ZHO2:String;
	final GH2O:String;
	final GHO2:String;
}

typedef ULReaction = {
	final UL:String;
}

typedef ZKReaction = {
	final ZK:String;
}

typedef OHReaction = {
	final OH:String;
}

typedef XReaction = {
	final X:String;
}

@:native("REACTIONS") extern enum abstract Reactions({}) {
	final H:OReaction;
	final O:HReaction;
	final Z:KHOReaction;
	final L:UHOReaction;
	final K:ZHOReaction;
	final G:HOReaction;
	final U:LHOReaction;
	final OH:MultiReaction;
	final X:Multi2Reaction;
	final ZK:ULReaction;
	final UL:ZKReaction;
	final LH:OHReaction;
	final ZH:OHReaction;
	final GH:OHReaction;
	final KH:OHReaction;
	final UH:OHReaction;
	final LO:OHReaction;
	final ZO:OHReaction;
	final KO:OHReaction;
	final UO:OHReaction;
	final GO:OHReaction;
	final LH2O:XReaction;
	final KH2O:XReaction;
	final ZH2O:XReaction;
	final UH2O:XReaction;
	final GH2O:XReaction;
	final LHO2:XReaction;
	final UHO2:XReaction;
	final KHO2:XReaction;
	final ZHO2:XReaction;
	final GHO2:XReaction;
}

extern enum abstract ReactionTime(Int) {
	final OH = 20;
	final ZK = 5;
	final UL = 5;
	final G = 5;
	final UH = 10;
	final UH2O = 5;
	final XUH2O = 60;
	final UO = 10;
	final UHO2 = 5;
	final XUHO2 = 60;
	final KH = 10;
	final KH2O = 5;
	final XKH2O = 60;
	final KO = 10;
	final KHO2 = 5;
	final XKHO2 = 60;
	final LH = 15;
	final LH2O = 10;
	final XLH2O = 65;
	final LO = 10;
	final LHO2 = 5;
	final XLHO2 = 60;
	final ZH = 20;
	final ZH2O = 40;
	final XZH2O = 160;
	final ZO = 10;
	final ZHO2 = 5;
	final XZHO2 = 60;
	final GH = 10;
	final GH2O = 15;
	final XGH2O = 80;
	final GO = 10;
	final GHO2 = 30;
	final XGHO2 = 150;
}

typedef Work = {
	final UO:{harvest:Int};
	final UHO2:{harvest:Int};
	final XUHO2:{harvest:Int};
	final LH:{build:Int, repiar:Int};
	final LH2O:{build:Int, repiar:Int};
	final XLH2O:{build:Int, repiar:Int};
	final ZH:{dismantle:Int};
	final ZH2O:{dismantle:Int};
	final XZH2O:{dismantle:Int};
	final GH:{upgradeController:Int};
	final GH2O:{upgradeController:Int};
	final XGH2O:{upgradeController:Int};
}

typedef Attack = {
	final UH:{attack:Int};
	final UH2O:{attack:Int};
	final XUH2O:{attack:Int};
}

typedef RangedAttack = {
	final KO:{rangedAttack:Int, rangedMassAttack:Int};
	final KHO2:{rangedAttack:Int, rangedMassAttack:Int};
	final XKHO2:{rangedAttack:Int, rangedMassAttack:Int};
}

typedef Heal = {
	final LO:{heal:Int, rangedHeal:Int};
	final LHO2:{heal:Int, rangedHeal:Int};
	final XLHO2:{heal:Int, rangedHeal:Int};
}

typedef CarryT = {
	final KH:{capacity:Int};
	final KH2O:{capacity:Int};
	final XKH2O:{capacity:Int};
}

typedef Move = {
	final ZO:{fatigue:Int};
	final ZHO2:{fatigue:Int};
	final XZHO2:{fatigue:Int};
}

typedef Tough = {
	final GO:{damage:Int};
	final GHO2:{damage:Int};
	final XGHO2:{damage:Int};
}

@:native("BOOSTS") extern enum abstract Boost({}) {
	final work:Work;
	final attack:Attack;
	final ranged_attack:RangedAttack;
	final heal:Heal;
	final carry:CarryT;
	final move:Move;
	final tough:Tough;
}

typedef Components = {
	final G:Int;
	final U:Int;
	final L:Int;
	final K:Int;
	final H:Int;
	final Z:Int;
	final O:Int;
	final X:Int;
	final energy:Int;
	final mist:Int;
	final biomass:Int;
	final metal:Int;
	final silicon:Int;
	final utrium_bar:Int;
	final lemergium_bar:Int;
	final zynthium_bar:Int;
	final keanium_bar:Int;
	final ghodium_melt:Int;
	final oxidant:Int;
	final reductant:Int;
	final purifier:Int;
	final battery:Int;
	final composite:Int;
	final crystal:Int;
	final liquid:Int;
	final wire:Int;
	@:native("switch") final switch_:Int;
	final transistor:Int;
	final microchip:Int;
	final circuit:Int;
	final device:Int;
	final cell:Int;
	final phlegm:Int;
	final tissue:Int;
	final muscle:Int;
	final organoid:Int;
	final organism:Int;
	final alloy:Int;
	final tube:Int;
	final fixtures:Int;
	final frame:Int;
	final hydraulics:Int;
	final machine:Int;
	final condensate:Int;
	final concentrate:Int;
	final extract:Int;
	final spirit:Int;
	final emanation:Int;
	final essence:Int;
};

typedef Commodity = {
	final level:Int;
	final amount:Int;
	final cooldown:Int;
	final components:{};
}

@:native("COMMODITIES") extern enum abstract Commodities(Commodity) {
	final G:Commodity;
	final U:Commodity;
	final L:Commodity;
	final K:Commodity;
	final H:Commodity;
	final Z:Commodity;
	final O:Commodity;
	final X:Commodity;
	final energy:Commodity;
	final mist:Commodity;
	final biomass:Commodity;
	final metal:Commodity;
	final silicon:Commodity;
	final utrium_bar:Commodity;
	final lemergium_bar:Commodity;
	final zynthium_bar:Commodity;
	final keanium_bar:Commodity;
	final ghodium_melt:Commodity;
	final oxidant:Commodity;
	final reductant:Commodity;
	final purifier:Commodity;
	final battery:Commodity;
	final composite:Commodity;
	final crystal:Commodity;
	final liquid:Commodity;
	final wire:Commodity;
	@:native("switch") final switch_:Commodity;
	final transistor:Commodity;
	final microchip:Commodity;
	final circuit:Commodity;
	final device:Commodity;
	final cell:Commodity;
	final phlegm:Commodity;
	final tissue:Commodity;
	final muscle:Commodity;
	final organoid:Commodity;
	final organism:Commodity;
	final alloy:Commodity;
	final tube:Commodity;
	final fixtures:Commodity;
	final frame:Commodity;
	final hydraulics:Commodity;
	final machine:Commodity;
	final condensate:Commodity;
	final concentrate:Commodity;
	final extract:Commodity;
	final spirit:Commodity;
	final emanation:Commodity;
	final essence:Commodity;
}

extern enum abstract Look(String) from String to String {
	final LOOK_CREEPS = "creep";
	final LOOK_ENERGY = "energy";
	final LOOK_RESOURCES = "resource";
	final LOOK_SOURCES = "source";
	final LOOK_MINERALS = "mineral";
	final LOOK_DEPOSITS = "deposit";
	final LOOK_STRUCTURES = "structure";
	final LOOK_FLAGS = "flag";
	final LOOK_CONSTRUCTION_SITES = "constructionSite";
	final LOOK_NUKES = "nuke";
	final LOOK_TERRAIN = "terrain";
	final LOOK_TOMBSTONES = "tombstone";
	final LOOK_POWER_CREEPS = "powerCreep";
	final LOOK_RUINS = "ruin";
}

extern abstract INVADERS_ENERGY_GOAL(Int) {
	@:selfCall
	public inline function new() {
		this = 100000;
	}
}

extern abstract SYSTEM_USERNAME(String) {
	@:selfCall
	public inline function new() {
		this = "Screeps";
	}
}

extern abstract STRONGHOLD_DECAY_TICKS(Int) {
	@:selfCall
	public inline function new() {
		this = 150000;
	}
}

extern abstract INVADER_CORE_HITS(Int) {
	@:selfCall
	public inline function new() {
		this = 1000000;
	}
}

extern enum abstract EventConstant(Int) {
	final EVENT_ATTACK = 1;
	final EVENT_OBJECT_DESTROYED = 2;
	final EVENT_ATTACK_CONTROLLER = 3;
	final EVENT_BUILD = 4;
	final EVENT_HARVEST = 5;
	final EVENT_HEAL = 6;
	final EVENT_REPAIR = 7;
	final EVENT_RESERVE_CONTROLLER = 8;
	final EVENT_UPGRADE_CONTROLLER = 9;
	final EVENT_EXIT = 10;
	final EVENT_POWER = 11;
	final EVENT_TRANSFER = 12;
	final EVENT_ATTACK_TYPE_MELEE = 1;
	final EVENT_ATTACK_TYPE_RANGED = 2;
	final EVENT_ATTACK_TYPE_RANGED_MASS = 3;
	final EVENT_ATTACK_TYPE_DISMANTLE = 4;
	final EVENT_ATTACK_TYPE_HIT_BACK = 5;
	final EVENT_ATTACK_TYPE_NUKE = 6;
	final EVENT_HEAL_TYPE_MELEE = 1;
	final EVENT_HEAL_TYPE_RANGED = 2;
}

extern enum abstract Pwr(Int) {
	final PWR_GENERATE_OPS = 1;
	final PWR_OPERATE_SPAWN = 2;
	final PWR_OPERATE_TOWER = 3;
	final PWR_OPERATE_STORAGE = 4;
	final PWR_OPERATE_LAB = 5;
	final PWR_OPERATE_EXTENSION = 6;
	final PWR_OPERATE_OBSERVER = 7;
	final PWR_OPERATE_TERMINAL = 8;
	final PWR_DISRUPT_SPAWN = 9;
	final PWR_DISRUPT_TOWER = 10;
	final PWR_DISRUPT_SOURCE = 11;
	final PWR_SHIELD = 12;
	final PWR_REGEN_SOURCE = 13;
	final PWR_REGEN_MINERAL = 14;
	final PWR_DISRUPT_TERMINAL = 15;
	final PWR_OPERATE_POWER = 16;
	final PWR_FORTIFY = 17;
	final PWR_OPERATE_CONTROLLER = 18;
	final PWR_OPERATE_FACTORY = 19;
}

extern abstract EFFECT_INVULNERABILITY(Int) {
	@:selfCall
	public inline function new() {
		this = 1001;
	}
}

extern abstract EFFECT_COLLAPSE_TIMER(Int) {
	@:selfCall
	public inline function new() {
		this = 1002;
	}
}

extern enum abstract InvaderCoreCreepSpawnTime(Int) {
	final ZERO = 0;
	final ONE = 0;
	final TWO = 6;
	final THREE = 3;
	final FOUR = 2;
	final FIVE = 1;
}

extern abstract INVADER_CORE_EXPAND_TIME(Int) {
	@:selfCall
	public inline function new() {
		this = 15000;
	}
}

extern abstract INVADER_CORE_CONTROLLER_POWER(Int) {
	@:selfCall
	public inline function new() {
		this = 100;
	}
}

extern abstract INVADER_CORE_CONTROLLER_DOWNGRADE(Int) {
	@:selfCall
	public inline function new() {
		this = 5000;
	}
}

extern enum abstract StrongholdRampartHits(Int) {
	final ZERO = 0;
	final ONE = 50000;
	final TWO = 200000;
	final THREE = 500000;
	final FOUR = 1000000;
	final FIVE = 2000000;
}

typedef PowerObject = {
	final className:PowerClass;
	final level:ReadOnlyArray<Int>;
	final cooldown:Int;
	final ?effect:ReadOnlyArray<Float>;
	final ?range:Int;
	final ?energy:Int;
	final ?period:Int;
	final ?ops:EitherType<Int, ReadOnlyArray<Int>>;
	final ?duration:EitherType<Int, ReadOnlyArray<Int>>;
}

extern typedef PI = Array<PowerObject>;

extern abstract POWER_INFO(ReadOnlyArray<PowerObject>) {
	@:selfCall
	public inline function new() {
		this = [
			null,
			{
				className: Operator,
				level: [0, 2, 7, 14, 22],
				cooldown: 50,
				effect: [1, 2, 4, 6, 8],
			},
			{
				className: Operator,
				level: [0, 2, 7, 14, 22],
				cooldown: 300,
				duration: 1000,
				range: 3,
				ops: 100,
				effect: [0.9, 0.7, 0.5, 0.35, 0.2],
			},
			{
				className: Operator,
				level: [0, 2, 7, 14, 22],
				cooldown: 10,
				duration: 100,
				range: 3,
				ops: 10,
				effect: [1.1, 1.2, 1.3, 1.4, 1.5],
			},
			{
				className: Operator,
				level: [0, 2, 7, 14, 22],
				cooldown: 800,
				duration: 1000,
				range: 3,
				ops: 100,
				effect: [500000, 1000000, 2000000, 4000000, 7000000],
			},
			{
				className: Operator,
				level: [0, 2, 7, 14, 22],
				cooldown: 50,
				duration: 1000,
				range: 3,
				ops: 10,
				effect: [2, 4, 6, 8, 10],
			},
			{
				className: Operator,
				level: [0, 2, 7, 14, 22],
				cooldown: 50,
				range: 3,
				ops: 2,
				effect: [0.2, 0.4, 0.6, 0.8, 1.0],
			},
			{
				className: Operator,
				level: [0, 2, 7, 14, 22],
				cooldown: 400,
				duration: [200, 400, 600, 800, 1000],
				range: 3,
				ops: 10,
			},
			{
				className: Operator,
				level: [0, 2, 7, 14, 22],
				cooldown: 500,
				duration: 1000,
				range: 3,
				ops: 100,
				effect: [0.9, 0.8, 0.7, 0.6, 0.5],
			},
			{
				className: Operator,
				level: [0, 2, 7, 14, 22],
				cooldown: 5,
				range: 20,
				ops: 10,
				duration: [1, 2, 3, 4, 5],
			},
			{
				className: Operator,
				level: [0, 2, 7, 14, 22],
				cooldown: 0,
				duration: 5,
				range: 50,
				ops: 10,
				effect: [0.9, 0.8, 0.7, 0.6, 0.5],
			},
			{
				className: Operator,
				level: [0, 2, 7, 14, 22],
				cooldown: 100,
				range: 3,
				ops: 100,
				duration: [100, 200, 300, 400, 500],
			},
			{
				className: Operator,
				level: [0, 2, 7, 14, 22],
				effect: [5000, 10000, 15000, 20000, 25000],
				duration: 50,
				cooldown: 20,
				energy: 100,
			},
			{
				className: Operator,
				level: [10, 11, 12, 14, 22],
				cooldown: 100,
				duration: 300,
				range: 3,
				effect: [50, 100, 150, 200, 250],
				period: 15,
			},
			{
				className: Operator,
				level: [10, 11, 12, 14, 22],
				cooldown: 100,
				duration: 100,
				range: 3,
				effect: [2, 4, 6, 8, 10],
				period: 10,
			},
			{
				className: Operator,
				level: [20, 21, 22, 23, 24],
				cooldown: 8,
				duration: 10,
				range: 50,
				ops: [50, 40, 30, 20, 10],
			},
			{
				className: Operator,
				level: [0, 2, 7, 14, 22],
				cooldown: 5,
				range: 3,
				ops: 5,
				duration: [1, 2, 3, 4, 5],
			},
			{
				className: Operator,
				level: [20, 21, 22, 23, 24],
				cooldown: 800,
				range: 3,
				duration: 1000,
				ops: 200,
				effect: [10, 20, 30, 40, 50],
			},
			{
				className: Operator,
				level: [0, 2, 7, 14, 22],
				cooldown: 1000,
				range: 3,
				duration: 1000,
				ops: 100,
			}
		];
	}
}

extern typedef Shard = {
	/**
	 * The name of the shard.
	 */
	var name:String;

	/**
	 * Currently always equals to normal.
	 */
	var type:String;

	/**
	 * Whether this shard belongs to the PTR.
	 */
	var ptr:Bool;
}

extern typedef GlobalControlLevel = {
	/**
	 * The current level.
	 */
	var level:Int;

	/**
	 * The current progress to the next level.
	 */
	var progress:Int;

	/**
	 * The progress required to reach the next level.
	 */
	var progressTotal:Int;
}

extern typedef GlobalPowerLevel = {
	/**
	 * The current level.
	 */
	var level:Int;

	/**
	 * The current progress to the next level.
	 */
	var progress:Int;

	/**
	 * The progress required to reach the next level.
	 */
	var progressTotal:Int;
}
