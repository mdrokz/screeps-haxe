package screeps;

import js.lib.Map;

abstract JsMap<T, K>(Map<T, K>) {
	// @:op([T])
	// public function A(rhs:T):K {
	// 	return this.get(rhs);
    // }
    @:arrayAccess
    function get(key:T):haxe.ds.Option<K> {
        var v = this.get(key);

        if(v != null) {
            return Some(v);
        } else {
            return None;
        }
        // return this.get(key);
    }
}
