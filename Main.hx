import screeps.Utils.JsObject;
import screeps.Globals.Reactions;
import screeps.Globals.ControllerStructures;
import screeps.Globals.Constants;
import screeps.Globals.Colors;
import screeps.Memory;
import screeps.Globals.Err.OK;

typedef CreepInfo = {
    source: String
} 

@:expose
class Main {
    // public static final colors = Constants.COLORS_ALL();
    static public function loop() {
        var s = Memory.creeps["ss"];
        var v = OK;

        var d = Reactions.UH2O.X;
        
        var f = new JsObject({f23: "2323"});
        
        var ss = f["f23"];

        var dd = new Map();

        var xx = dd["2"];

        var x = ControllerStructures.spawn[1];
        trace(x);
        trace(s);

        // trace(colors[1]);
    }
}