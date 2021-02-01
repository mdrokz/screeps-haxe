package screeps;

/**
 * Container for custom navigation cost data.
 */
extern class CostMatrix {
	/**
	 * Creates a new CostMatrix containing 0's for all positions.
	 */
	@:selfCall
	public function new():Void;

	/**
	 * Set the cost of a position in this CostMatrix.
	 * @param x X position in the room.
	 * @param y Y position in the room.
	 * @param cost Cost of this position. Must be a whole Int. A cost of 0 will use the terrain cost for that tile. A cost greater than or equal to 255 will be treated as unwalkable.
	 */
	public function set(x:Int, y:Int, cost:Int):Void;

	/**
	 * Get the cost of a position in this CostMatrix.
	 * @param x X position in the room.
	 * @param y Y position in the room.
	 */
	public function get(x:Int, y:Int):Int;

	/**
	 * Copy this CostMatrix into a new CostMatrix with the same data.
	 */
	public function clone():CostMatrix;

	/**
	 * Returns a compact representation of this CostMatrix which can be stored via JSON.stringify.
	 */
	public function serialize():Array<Int>;

	/**
	 * Static method which deserializes a new CostMatrix using the return value of serialize.
	 * @param val Whatever serialize returned
	 */
	public function deserialize(val:Array<Int>):CostMatrix;
}
