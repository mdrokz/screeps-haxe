package screeps;

import screeps.RoomPosition.Target;
import screeps.Globals.ScreepsReturnCode;
import screeps.Utils.JsObject;
import screeps.Globals.Colors;

using screeps.Room.RoomObject;

/**
 * A flag. Flags can be used to mark particular spots in a room. Flags are visible to their owners only.
 */
@:build(screeps.Macros.MacroUtils.extendFields(RoomObject, ["prototype"]))
extern class Flag {
	final prototype:Flag;

	/**
	 * Flag color. One of the `COLOR_*` constants.
	 */
	var color:Colors;

	/**
	 * A shorthand to Memory.flags[flag.name]. You can use it for quick access the flag's specific memory data object.
	 */
	var memory:JsObject<Any>;

	/**
	 * Flag’s name.
	 *
	 * You can choose the name while creating a new flag, and it cannot be changed later.
	 *
	 * This name is a hash key to access the spawn via the `Game.flags` object. The maximum name length is 60 characters.
	 */
	var name:String;

	/**
	 * Flag secondary color. One of the `COLOR_*` constants.
	 */
	var secondaryColor:Colors;

	/**
	 * Remove the flag.
	 * @returns Result Code: OK
	 */
	public function remove():ScreepsReturnCode;

	/**
	 * Set new color of the flag.
	 * @param color One of the following constants: COLOR_WHITE, COLOR_GREY, COLOR_RED, COLOR_PURPLE, COLOR_BLUE, COLOR_CYAN, COLOR_GREEN, COLOR_YELLOW, COLOR_ORANGE, COLOR_BROWN
	 * @parma secondaryColor Secondary color of the flag. One of the COLOR_* constants.
	 * @returns Result Code: OK, ERR_INVALID_ARGS
	 */
	public function setColor(color:Colors, ?secondaryColor:Colors):ScreepsReturnCode;

	/**
	 * Set new position of the flag.
	 * @param x The X position in the room.
	 * @param y The Y position in the room.
	 * @param pos Can be a RoomPosition object or any object containing RoomPosition.
	 * @returns Result Code: OK, ERR_INVALID_TARGET
	 */
	@:overload(function(pos:Target):ScreepsReturnCode {})
    public function setPosition(x:Int, y:Int):ScreepsReturnCode;
    
    @:selfCall
    public function new(name: String, color: Colors, secondaryColor: Colors, roomName: String, x: Int, y: Int): Void;
}
