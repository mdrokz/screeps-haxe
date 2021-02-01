import screeps.Source;
import screeps.RoomPosition;
import screeps.Creep.AnyCreep;
import screeps.Resource;
import screeps.Structure;
import screeps.Flag;
import screeps.Nuke;
import screeps.TombStone;
import screeps.Deposit;
import screeps.Ruin;
import haxe.extern.EitherType;
import screeps.Mineral;
import screeps.Globals.Commodities;
import screeps.Globals.ControllerStructures;
import screeps.Globals.FindClosestByPathAlgorithm.astar;
import screeps.Memory;
import screeps.Globals.ScreepsReturnCode.OK;

typedef CreepInfo = {
	source:String
}

@:expose
class Main {
	static public function loop() {
		var s = Memory.creeps["ss"];
		var v = OK;

        var d = Commodities.switch_.cooldown;

        var m: Mineral = null;

        var v = new js.lib.Object({d: "232"});

        
		// var f: Test = "d";

		var x = ControllerStructures.spawn[1];

		trace(x);
		trace(s);

		// trace(colors[1]);
	}
}
