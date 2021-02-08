package screeps;

import js.lib.Map;
import js.lib.Object;

@:forward
abstract JsMap<T, K>(Map<T, K>) {
	@:arrayAccess
	public inline function get(key:T):K {
		return js.Syntax.code("{0}[{1}]", this, key);
	}

	public inline function new() {
		this = new Map<T, K>();
	}
}

abstract JsObject<T>(Object) {
	@:arrayAccess
	public inline function get(key:String):T {
		return js.Syntax.code("{0}[{1}]", this, key);
		// return [for(x in Object.entries(this)) x.key == key ? x : continue][0].value;
		// return Object.entries(this).filter(k -> k.key == key)[0].value;
	}

	public inline function new(v:Any) {
		this = new Object(v);
	}
}
