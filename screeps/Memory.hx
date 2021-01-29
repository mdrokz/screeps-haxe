package screeps;

typedef Object = Map<String,Any>;

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