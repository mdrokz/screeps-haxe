package screeps;

import screeps.Utils.JsObject;
import screeps.Macros.EnumTools;

extern enum abstract Err(Int) {
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
	// public static inline function COLORS_ALL() = ReadOnlyArray<Colors> {
	//     return EnumTools.getValues(Colors);
	// }
	// public static inline function BODYPART_ALL() = ReadOnlyArray<BodyPart> {
	// 	return EnumTools.getValues(BodyPart);
	// }
	// public static inline function RESOURCE_ALL() = ReadOnlyArray<Resource> {
	//     return EnumTools.getValues(Resource);
	// }
}

extern enum abstract CreepInfo(Int) {
	final CREEP_SPAWN_TIME = 3;
	final CREEP_LIFE_TIME = 1500;
	final CREEP_CLAIM_LIFE_TIME = 600;
	final CREEP_CORPSE_RATE = 0.2;
}

extern enum abstract ObstacleObjectTypes(String) {
	final spawn;
	final creep;
	final powerCreep;
	final source;
	final mineral;
	final deposit;
	final controller;
	final constructedWall;
	final extension;
	final link;
	final storage;
	final tower;
	final observer;
	final powerSpawn;
	final powerBank;
	final lab;
	final terminal;
	final nuker;
	final factory;
	final invaderCore;
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

extern enum abstract Source(Int) {
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
	final MOVE = move;
	final WORK = work;
	final CARRY = carry;
	final ATTACK = attack;
	final RANGED_ATTACK = ranged_attack;
	final TOUGH = tough;
	final HEAL = heal;
	final CLAIM = claim;
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

extern enum abstract Structure(String) {
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

extern enum abstract Resource(String) {
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
	final RESOURCE_SPIRIT = "extract";
	final RESOURCE_EMANATION = "emanation";
	final RESOURCE_ESSENCE = "essence";
}

extern enum abstract Purchase(String) {
	final SUBSCRIPTION_TOKEN = "token";
	final CPU_UNLOCK = "cpuUnlock";
	final PIXEL = "pixel";
	final ACCESS_KEY = "accessKey";
}

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

extern enum abstract Terrain(Int) {
	final TERRAIN_MASK_WALL = 1;
	final TERRAIN_MASK_SWAMP = 2;
	final TERRAIN_MASK_LAVA = 4;
}

extern enum abstract Common(Int) {
	final MAX_CONSTRUCTION_SITES = 100;
	final MAX_CREEP_SIZE = 50;
}

extern enum abstract Mineral(Int) {
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

extern enum abstract Deposit(Int) {
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

extern enum abstract TombStone(Int) {
	final TOMBSTONE_DECAY_PER_PART = 5;
	final TOMBSTONE_DECAY_POWER_CREEP = 500;
}

extern enum abstract Ruin(Int) {
	final RUIN_DECAY = 500;
}

extern enum abstract RuinDecayStructure(Int) {
	final powerBank = 10;
}

extern enum abstract Decay(Int) {
	final PORTAL_DECAY = 30000;
}

extern enum abstract Order(String) {
	final ORDER_SELL = "sell";
	final ORDER_BUY = "buy";
}

extern enum abstract Market(Int) {
	final MARKET_FEE = 0.05;
	final MARKET_MAX_ORDERS = 300;
	final MARKET_ORDER_LIFE_TIME = 1000 * 60 * 60 * 24 * 30;
}

extern enum abstract Flag(Int) {
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
	var UH:String;
	var UO:String;
	var ZH:String;
	var ZO:String;
	var KH:String;
	var KO:String;
	var LH:String;
	var LO:String;
	var GH:String;
	var GO:String;
}

typedef Multi2Reaction = {
	var UH2O:String;
	var UHO2:String;
	var LH2O:String;
	var LHO2:String;
	var KH2O:String;
	var KHO2:String;
	var ZH2O:String;
	var ZHO2:String;
	var GH2O:String;
	var GHO2:String;
}

typedef ULReaction = {
	var UL:String;
}

typedef ZKReaction = {
	var ZK:String;
}

typedef OHReaction = {
	var OH:String;
}

typedef XReaction = {
	var X:String;
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
	var OH = 20;
	var ZK = 5;
	var UL = 5;
	var G = 5;
	var UH = 10;
	var UH2O = 5;
	var XUH2O = 60;
	var UO = 10;
	var UHO2 = 5;
	var XUHO2 = 60;
	var KH = 10;
	var KH2O = 5;
	var XKH2O = 60;
	var KO = 10;
	var KHO2 = 5;
	var XKHO2 = 60;
	var LH = 15;
	var LH2O = 10;
	var XLH2O = 65;
	var LO = 10;
	var LHO2 = 5;
	var XLHO2 = 60;
	var ZH = 20;
	var ZH2O = 40;
	var XZH2O = 160;
	var ZO = 10;
	var ZHO2 = 5;
	var XZHO2 = 60;
	var GH = 10;
	var GH2O = 15;
	var XGH2O = 80;
	var GO = 10;
	var GHO2 = 30;
	var XGHO2 = 150;
}
