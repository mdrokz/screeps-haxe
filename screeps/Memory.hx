package screeps;

import screeps.Utils.JsMap;

typedef Object = JsMap<String,Any>;



@:keep
@:native("Memory") extern class Memory {
    static var creeps: Object;
    static var powerCreeps: Object;
    static var flags: Object;
    static var rooms: Object;
    static var spawns: Object;

    @:selfCall
    public function new():Void;
}