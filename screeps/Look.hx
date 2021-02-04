package screeps;

import haxe.macro.MacroType;
import screeps.Globals.Look;
import screeps.Ruin;
import screeps.Creep.PowerCreep;
import screeps.TombStone;
import screeps.Globals.Terrain;
import screeps.Construction.ConstructionSite;
import screeps.Structure;
import screeps.Source;
import haxe.extern.EitherType;

typedef LookEnergy = {
	var energy:Resource;
}

typedef LookExit = {
	var exit:Any;
}

typedef LookFlag = {
	var flag:Flag;
}

typedef LookMineral = {
	var mineral:Mineral;
}

typedef LookDeposit = {
	var deposit:Deposit;
}

typedef LookNuke = {
	var nuke:Nuke;
}

typedef LookResource = {
	var resource:Resource;
}

typedef LookSource = {
	var source:Source;
}

typedef LookStructure = {
	var structure:Structure;
}

typedef LookTerrain = {
	var terrain:Terrain;
}

typedef LookTombStone = {
	var tombStone:TombStone;
}

typedef LookPowerCreep = {
	var powerCreep:PowerCreep;
}

typedef LookRuin = {
	var ruin:Ruin;
}

typedef LookCreep = {
	var creep:Creep;
}

typedef LookCreepType = LookCreep & {type:Look};
typedef LookRuinType = LookRuin & {type:Look};
typedef LookPowerCreepType = LookPowerCreep & {type:Look};
typedef LookTombStoneType = LookTombStone & {type:Look};
typedef LookTerrainType = LookTerrain & {type:Look};
typedef LookStructureType = LookStructure & {type:Look};
typedef LookSourceType = LookSource & {type:Look};
typedef LookResourceType = LookResource & {type:Look};
typedef LookNukeType = LookNuke & {type:Look};
typedef LookDepositType = LookDeposit & {type:Look};
typedef LookMineralType = LookMineral & {type:Look};
typedef LookFlagType = LookFlag & {type:Look};
typedef LookExitType = LookExit & {type:Look};
typedef LookEnergyType = LookEnergy & {type:Look};

typedef LookPosCreepType = LookCreep & {x:Int,y: Int};
typedef LookPosRuinType = LookRuin & {x:Int,y: Int};
typedef LookPosPowerCreepType = LookPowerCreep & {x:Int,y: Int};
typedef LookPosTombStoneType = LookTombStone & {x:Int,y: Int};
typedef LookPosTerrainType = LookTerrain & {x:Int,y: Int};
typedef LookPosStructureType = LookStructure & {x:Int,y: Int};
typedef LookPosSourceType = LookSource & {x:Int,y: Int};
typedef LookPosResourceType = LookResource & {x:Int,y: Int};
typedef LookPosNukeType = LookNuke & {x:Int,y: Int};
typedef LookPosDepositType = LookDeposit & {x:Int,y: Int};
typedef LookPosMineralType = LookMineral & {x:Int,y: Int};
typedef LookPosFlagType = LookFlag & {x:Int,y: Int};
typedef LookPosExitType = LookExit & {x:Int,y: Int};
typedef LookPosEnergyType = LookEnergy & {x:Int,y: Int};


typedef LookAtResult = MacroType<[
	screeps.Macros.MacroUtils.buildNestedFields([
		"LookCreepType", "LookEnergyType", "LookExitType", "LookFlagType", "LookMineralType", "LookDepositType", "LookNukeType", "LookResourceType",
		"LookSourceType", "LookStructureType", "LookTerrainType", "LookTombStoneType", "LookPowerCreepType"
	])
]>;

typedef LookAtResultWithPos = MacroType<[
	screeps.Macros.MacroUtils.buildNestedFields([
		"LookPosCreepType", "LookPosEnergyType", "LookPosExitType", "LookPosFlagType", "LookPosMineralType", "LookPosDepositType", "LookPosNukeType", "LookPosResourceType",
		"LookPosSourceType", "LookPosStructureType", "LookPosTerrainType", "LookPosTombStoneType", "LookPosPowerCreepType"
	])
]>;

typedef AllLookAtTypes = MacroType<[
	screeps.Macros.MacroUtils.buildNestedFields([
		"ConstructionSite", "Creep", "Resource", "Flag", "Mineral", "Deposit", "Nuke", "Resource", "Source", "Structure", "Terrain", "TombStone", "PowerCreep",
		"Ruin"
	])
]>;

typedef LookAtResultMatrix = Array<Array<Array<LookAtResult>>>;