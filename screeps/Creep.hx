package screeps;

import haxe.extern.EitherType;

typedef AnyCreep = EitherType<Creep,PowerCreep>;

extern class Creep {

    final x:Int;

    @:selfCall
    public function new():Void;
}

extern class PowerCreep {

}