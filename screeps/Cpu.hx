package screeps;

import screeps.Utils.JsObject;
import screeps.Globals.ScreepsReturnCode;
import haxe.extern.EitherType;

typedef CPUShardLimits = JsObject<Int>;

private enum abstract Num(Int) {
	var ZERO = 0;
	var ONE = 1;
}

extern typedef HeapStatistics = {
	var total_heap_size:Int;
	var total_heap_size_executable:Int;
	var total_physical_size:Int;
	var total_available_size:Int;
	var used_heap_size:Int;
	var heap_size_limit:Int;
	var malloced_memory:Int;
	var peak_malloced_memory:Int;
	var does_zap_garbage:Num;
	var externally_allocated_size:Int;
}

extern class CPU {
	/**
	 * Your assigned CPU limit for the current shard.
	 */
	var limit:Int;

	/**
	 * An amount of available CPU time at the current game tick. Usually it is higher than `Game.cpu.limit`.
	 */
	var tickLimit:Int;

	/**
	 * An amount of unused CPU accumulated in your bucket.
	 * @see http://docs.screeps.com/cpu-limit.html#Bucket
	 */
	var bucket:Int;

	/**
	 * An object with limits for each shard with shard names as keys. You can use `setShardLimits` method to re-assign them.
	 */
	var shardLimits:CPUShardLimits;

	/**
	 * Whether full CPU is currently unlocked for your account.
	 */
	var unlocked:Bool;

	/**
	 * The time in milliseconds since UNIX epoch time until full CPU is unlocked for your account.
	 * This property is not defined when full CPU is not unlocked for your account or it's unlocked with a subscription.
	 */
	var unlockedTime:EitherType<Int, Void>;

	/**
	 * Get amount of CPU time used from the beginning of the current game tick. Always returns 0 in the Simulation mode.
	 */
	public function getUsed():Int;

	/**
	 * Allocate CPU limits to different shards. Total amount of CPU should remain equal to `Game.cpu.shardLimits`.
	 * This method can be used only once per 12 hours.
	 *
	 * @param limits An object with CPU values for each shard in the same format as `Game.cpu.shardLimits`.
	 * @returns One of the following codes: `OK | ERR_BUSY | ERR_INVALID_ARGS`
	 */
	public function setShardLimits(limits:CPUShardLimits):ScreepsReturnCode;

	/**
	 * Use this method to get heap statistics for your virtual machine.
	 *
	 * This method will be undefined if you are not using IVM.
	 *
	 * The return value is almost identical to the Node.js function v8.getHeapStatistics().
	 * This function returns one additional property: externally_allocated_size which is the total amount of currently
	 * allocated memory which is not included in the v8 heap but counts against this isolate's memory limit.
	 * ArrayBuffer instances over a certain size are externally allocated and will be counted here.
	 */
	public function getHeapStatistics():HeapStatistics;

	/**
	 * This method will be undefined if you are not using IVM.
	 *
	 * Reset your runtime environment and wipe all data in heap memory.
	 * Player code execution stops immediately.
	 */
	public function halt():Void;

	/**
	 * Generate 1 pixel resource unit for 5000 CPU from your bucket.
	 */
	public function generatePixel():ScreepsReturnCode;

	/**
	 * Unlock full CPU for your account for additional 24 hours.
	 * This method will consume 1 CPU unlock bound to your account (See `Game.resources`).
	 * If full CPU is not currently unlocked for your account, it may take some time (up to 5 minutes) before unlock is applied to your account.
	 */
	public function unlock():ScreepsReturnCode;
}
