package screeps;

using screeps.Room.RoomObject;

/**
 * A nuke landing position. This object cannot be removed or modified. You can find incoming nukes in the room using the FIND_NUKES constant.
 */
@:build(screeps.Macros.MacroUtils.extendFields(RoomObject, ["prototype"]))
extern class Nuke {
	final prototype:Nuke;

	/**
	 * A unique object identifier. You can use Game.getObjectById method to retrieve an object instance by its id.
	 */
	var id:String;

	/**
	 * The name of the room where this nuke has been launched from.
	 */
	var launchRoomName:String;

	/**
	 * The remaining landing time.
	 */
    var timeToLand:Int;
    
    @:selfCall
    public function new():Void;
}
