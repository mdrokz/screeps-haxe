import js.lib.Object;
import screeps.Creep.HarvestCode;
import screeps.Globals.CreepActionReturnCode;
import screeps.Source;
// import screeps.RoomPosition;
import screeps.Creep.AnyCreep;
import screeps.Resource;
import screeps.Structure;
import screeps.Flag;
import screeps.Nuke;
import screeps.TombStone;
import screeps.Deposit;
import screeps.Ruin;
using screeps.Globals.Resources;
import haxe.extern.EitherType;
import screeps.Mineral;
// import screeps.RoomPosition.FilterFunction;
#if macro
import haxe.macro.Context;
import haxe.macro.Expr;

using haxe.macro.Tools;
#end


using screeps.GameMap.RouteOptions;

abstract V<T>(Object) {
	
	public var length(get,never): Int;

	function get_length() {
		return Object.keys(this).length;
	}
 
	@:arrayAccess
	public inline function get(key:String):T {
		return js.Syntax.code("{0}[{1}]", this, key);
		// return [for(x in Object.entries(this)) x.key == key ? x : continue][0].value;
		// return Object.entries(this).filter(k -> k.key == key)[0].value;
	}


	public inline function new(v:Any) {
		this = new Object(v);
	}

	public function iterator() {
        return Object.keys(this).iterator();
    }
}

class Test {
    public static function main() {
        
    }

    public function test() {

    }
}