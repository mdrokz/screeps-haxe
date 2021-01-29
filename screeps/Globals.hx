package screeps;

extern enum abstract Err(Int) {
	var OK = 0;
	var ERR_NOT_OWNER = -1;
	var ERR_NOT_PATH = -2;
	var ERR_NOT_EXISTS = -3;
	var ERR_BUSY = -4;
	var ERR_NOT_FOUND = -5;
	var ERR_NOT_ENOUGH_RESOURCES = -6;
	var ERR_NOT_ENOUGH_ENERGY = -7;
	var ERR_INVALID_TARGET = -8;
	var ERR_FULL = -9;
	var ERR_NOT_IN_RANGE = -10;
	var ERR_INVALID_ARGS = -11;
	var ERR_TIRED = -12;
	var ERR_NO_BODYPART = -13;
	var ERR_NOT_ENOUGH_EXTENSIONS = -14;
	var ERR_RCL_NOT_ENOUGH = -15;
	var ERR_GCL_NOT_ENOUGH = -16;
}

extern enum abstract Find(Int) {
	var FIND_EXIT_TOP = 1;
	var FIND_EXIT_RIGHT = 3;
	var FIND_EXIT_BOTTOM = 5;
	var FIND_EXIT_LEFT = 7;
	var FIND_EXIT = 10;
	var FIND_CREEPS = 101;
	var FIND_MY_CREEPS = 102;
	var FIND_HOSTILE_CREEPS = 103;
	var FIND_SOURCES_ACTIVE = 104;
	var FIND_SOURCES = 105;
	var FIND_DROPPED_RESOURCES = 106;
	var FIND_STRUCTURES = 107;
	var FIND_MY_STRUCTURES = 108;
	var FIND_HOSTILE_STRUCTURES = 109;
	var FIND_FLAGS = 110;
	var FIND_CONSTRUCTION_SITES = 111;
	var FIND_MY_SPAWNS = 112;
	var FIND_HOSTILE_SPAWNS = 113;
	var FIND_MY_CONSTRUCTION_SITES = 114;
	var FIND_HOSTILE_CONSTRUCTION_SITES = 115;
	var FIND_MINERALS = 116;
	var FIND_NUKES = 117;
	var FIND_TOMBSTONES = 118;
	var FIND_POWER_CREEPS = 119;
	var FIND_MY_POWER_CREEPS = 120;
	var FIND_HOSTILE_POWER_CREEPS = 121;
	var FIND_DEPOSITS = 122;
	var FIND_RUINS = 123;
}

extern enum abstract Directions(Int) {
	var TOP = 1;
	var TOP_RIGHT = 2;
	var RIGHT = 3;
	var BOTTOM_RIGHT = 4;
	var BOTTOM = 5;
	var BOTTOM_LEFT = 6;
	var LEFT = 7;
	var TOP_LEFT = 8;
}

extern enum abstract Colors(Int) {
	var COLOR_RED = 1;
	var COLOR_PURPLE = 2;
	var COLOR_BLUE = 3;
	var COLOR_CYAN = 4;
	var COLOR_GREEN = 5;
	var COLOR_YELLOW = 6;
	var COLOR_ORANGE = 7;
	var COLOR_BROWN = 8;
	var COLOR_GREY = 9;
	var COLOR_WHITE = 10;
}

extern enum abstract ColorConstants(haxe.ds.ReadOnlyArray<Int>) {
	// var COLORS_ALL = [0,1];
}

extern enum abstract CreepInfo(Int) {
	var CREEP_SPAWN_TIME = 3;
	var CREEP_LIFE_TIME = 1500;
	var CREEP_CLAIM_LIFE_TIME = 600;
	var CREEP_CORPSE_RATE = 0.2;
}

extern enum abstract ObstacleObjectTypes(String) {
	var spawn;
	var creep;
	var powerCreep;
	var source;
	var mineral;
	var deposit;
	var controller;
	var constructedWall;
	var extension;
	var link;
	var storage;
	var tower;
	var observer;
	var powerSpawn;
	var powerBank;
	var lab;
	var terminal;
	var nuker;
	var factory;
	var invaderCore;
}

extern enum abstract Energy(Int) {
	var ENERGY_REGEN_TIME = 300;
	var ENERGY_DECAY = 1000;
}

extern enum abstract Repair(Float) {
	var REPAIR_COST = 0.01;
}

extern enum abstract Rampart(Int) {
	var RAMPART_DECAY_AMOUNT = 300;
	var RAMPART_DECAY_TIME = 100;
	var RAMPART_HITS = 1;
}

extern enum abstract Spawn(Int) {}

extern enum abstract RAMPART_HITS_MAX(Int) {
	var TWO = 300000;
	var THREE = 1000000;
	var FOUR = 3000000;
	var FIVE = 10000000;
	var SIX = 30000000;
	var SEVEN = 100000000;
	var EIGHT = 300000000;
}
