import screeps.Utils.JsObject;
import screeps.Mineral;
import screeps.Globals.Commodities;
import screeps.Globals.ControllerStructures;
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

		var v = new JsObject<{d: String}>({d: "232"});

		var f = v["d"];

		var x = ControllerStructures.spawn[1];

		
		trace(x);
		trace(s);

		// trace(colors[1]);
	}

}
