package screeps;

import haxe.extern.EitherType;
import screeps.Utils.JsMap;

using screeps.Utils.JsObject;

typedef Object = JsObject<Any>;

@:keep
@:native("Memory") extern class Memory {
	static final creeps:Object;
	static final powerCreeps:Object;
	static final flags:Object;
	static final rooms:Object;
	static final spawns:Object;

	@:selfCall
	public function new():Void;
}

/**
 * `InterShardMemory` object provides an interface for communicating between shards.
 * Your script is executed separatedly on each shard, and their `Memory` objects are isolated from each other.
 * In order to pass messages and data between shards, you need to use `InterShardMemory` instead.
 *
 * Every shard can have its own data string that can be accessed by all other shards.
 * A shard can write only to its own data, other shards' data is read-only.
 *
 * This data has nothing to do with `Memory` contents, it's a separate data container.
 */
extern class InterShardMemory {
	/**
	 * Returns the string contents of the current shard's data.
	 */
	public static function getLocal():String;

	/**
	 * Replace the current shard's data with the new value
	 * @param value New data value in string format.
	 */
	public static function setLocal(value:String):Void;

	/**
	 * Returns the string contents of another shard's data, null if shard exists but data is not set.
	 *
	 * @param shard Shard name.
	 * @throws Error if shard name is invalid
	 */
	public static function getRemote(shard:String):EitherType<String, Void>;
}

/**
 * RawMemory object allows to implement your own memory stringifier instead of built-in serializer based on JSON.stringify.
 */
extern class RawMemory {
	/**
	 * An object with asynchronous memory segments available on this tick. Each object key is the segment ID with data in string values.
	 * Use RawMemory.setActiveSegments to fetch segments on the next tick. Segments data is saved automatically in the end of the tick.
	 */
	static final segments:JsMap<Int, String>;

	/**
	 * An object with a memory segment of another player available on this tick. Use `setActiveForeignSegment` to fetch segments on the next tick.
	 */
	static final foreignSegment:{
		username:String,
		id:Int,
		data:String,
	};

	/**
	 *  @deprecated Use `InterShardMemory` instead.
	 *
	 *  A string with a shared memory segment available on every world shard. Maximum string length is 100 KB.
	 *
	 * **Warning:** this segment is not safe for concurrent usage! All shards have shared access to the same instance of
	 * data. When the segment contents is changed by two shards simultaneously, you may lose some data, since the segment
	 * string value is written all at once atomically. You must implement your own system to determine when each shard is
	 * allowed to rewrite the inter-shard memory, e.g. based on mutual exclusions.
	 *
	 */
	static final interShardSegment:String;

	/**
	 * Get a raw string representation of the Memory object.
	 */
	public static function get():String;

	/**
	 * Set new memory value.
	 * @param value New memory value as a string.
	 */
	public static function set(value:String):Void;

	/**
	 * Request memory segments using the list of their IDs. Memory segments will become available on the next tick in RawMemory.segments object.
	 * @param ids An array of segment IDs. Each ID should be a number from 0 to 99. Maximum 10 segments can be active at the same time. Subsequent calls of setActiveSegments override previous ones.
	 */
	public static function setActiveSegments(ids:Array<Int>):Void;

	/**
	 * Request a memory segment of another user.
	 *
	 * The segment should be marked by its owner as public using `setPublicSegments`.
	 *
	 * The segment data will become available on the next tick in `foreignSegment` object.
	 *
	 * You can only have access to one foreign segment at the same time.
	 *
	 * @param username The name of another user. Pass `null` to clear the foreign segment.
	 * @param id The ID of the requested segment from 0 to 99. If undefined, the user's default public segment is requested as set by `setDefaultPublicSegment`.
	 */
	public static function setActiveForeignSegment(username:EitherType<String, Void>, ?id:Int):Void;

	/**
	 * Set the specified segment as your default public segment. It will be returned if no id parameter is passed to `setActiveForeignSegment` by another user.
	 *
	 * @param id The ID of the requested segment from 0 to 99. Pass `null` to clear the foreign segment.
	 */
	public static function setDefaultPublicSegment(id:EitherType<Int, Void>):Void;

	/**
	 * Set specified segments as public. Other users will be able to request access to them using `setActiveForeignSegment`.
	 *
	 * @param ids An array of segment IDs. Each ID should be a number from 0 to 99. Subsequent calls of `setPublicSegments` override previous ones.
	 */
	public static function setPublicSegments(ids:Array<Int>):Void;
}
