package screeps;

using screeps.Utils.JsObject;

typedef Object = JsObject<Any>;

@:keep
@:native("Memory") extern class Memory {
    static final creeps: Object;
    static final powerCreeps: Object;
    static final flags: Object;
    static final rooms: Object;
    static final spawns: Object;

    @:selfCall
    public function new():Void;
}