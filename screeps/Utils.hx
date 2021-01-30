package screeps;

import js.lib.Map;
import haxe.ds.Option;
import js.lib.Object;

@:forward
abstract JsMap<T, K>(Map<T, K>) {
	@:arrayAccess
	function get(key:T):Option<K> {
		var v = this.get(key);

		if (v != null) {
			return Some(v);
		} else {
			return None;
		}
    }

    public function new() {
        this = new Map<T,K>();
    }
}

abstract JsObject(Object) {

	@:arrayAccess
	function get(key: String) {
		return Object.entries(this).filter(k -> k.key == key)[0].value;
	}

	public inline function new(v: Any) {
        this = new Object(v);
    }
}