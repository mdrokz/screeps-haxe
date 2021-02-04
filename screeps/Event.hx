package screeps;

import haxe.macro.MacroType;
import screeps.Globals.EventConstant;
import screeps.Globals.ResourceConstant;
import screeps.Globals.Pwr;
import screeps.Globals.StructureConstant;
import haxe.extern.EitherType;

@:build(screeps.Macros.MacroUtils.buildEnum(StructureConstant))
extern enum abstract EventDestroyType(String) {
	var CREEP = "creep";
}

extern enum abstract EventAttackType(Int) {
	final ONE = 1;
	final TWO = 2;
	final THREE = 3;
	final FOUR = 4;
	final FIVE = 5;
	final SIX = 6;
}

extern enum abstract EventHealType(Int) {
	final ONE = 1;
	final TWO = 2;
}

typedef EventAttack = {
	var targetId:String;
	var damage:Int;
	var AttackType:EventAttackType;
}

typedef EventObjectDestroyed = {
	var type:EventDestroyType;
}

typedef EventAttackController = Void;

typedef EventBuild = {
	var targetId:String;
	var amount:Int;
	var energySpent:Int;
}

typedef EventHarvest = {
	var targetId:String;
	var amount:Int;
}

typedef EventHeal = {
	var targetId:String;
	var amount:Int;
	var healType:EventHealType;
}

typedef EventRepair = {
	var targetId:String;
	var amount:Int;
	var energySpent:Int;
}

typedef EventReserveController = {
	var amount:Int;
}

typedef EventUpgradeController = {
	var amount:Int;
	var energySpent:Int;
}

typedef EventExit = {
	var room:String;
	var x:Int;
	var y:Int;
}

typedef EventPower = {
	var targetId:String;
	var power:Pwr;
}

typedef EventTransfer = {
	var targetId:String;
	var resourceType:ResourceConstant;
	var amount:Int;
}

typedef ItemAttack = {
	var event:EventConstant;
	var objectId:String;
	var data:EventAttack;
}

typedef ItemObjectDestroyed = {
	var event:EventConstant;
	var objectId:String;
	var data:EventObjectDestroyed;
}

typedef ItemAttackController = {
	var event:EventConstant;
	var objectId:String;
	var data:EventAttackController;
}

typedef ItemBuild = {
	var event:EventConstant;
	var objectId:String;
	var data:EventBuild;
}

typedef ItemHarvest = {
	var event:EventConstant;
	var objectId:String;
	var data:EventHarvest;
}

typedef ItemHeal = {
	var event:EventConstant;
	var objectId:String;
	var data:EventHeal;
}

typedef ItemRepair = {
	var event:EventConstant;
	var objectId:String;
	var data:EventRepair;
}

typedef ItemReserveController = {
	var event:EventConstant;
	var objectId:String;
	var data:EventReserveController;
}

typedef ItemUpgradeController = {
	var event:EventConstant;
	var objectId:String;
	var data:EventUpgradeController;
}

typedef ItemExit = {
	var event:EventConstant;
	var objectId:String;
	var data:EventExit;
}

typedef ItemPower = {
	var event:EventConstant;
	var objectId:String;
	var data:EventPower;
}

typedef ItemTransfer = {
	var event:EventConstant;
	var objectId:String;
	var data:EventTransfer;
}

typedef EventItem = MacroType<[
	screeps.Macros.MacroUtils.buildNestedFields([
		"ItemAttack", "ItemObjectDestroyed", "ItemAttackController", "ItemBuild", "ItemHeal", "ItemHarvest", "ItemRepair", "ItemReserveController",
		"ItemUpgradeController", "ItemExit", "ItemPower", "ItemTransfer"
	])
]>
