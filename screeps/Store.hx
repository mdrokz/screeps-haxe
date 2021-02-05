package screeps;

import haxe.extern.EitherType;
import screeps.Globals.ResourceConstant;

extern typedef StoreBase = {
	/**
	 * Returns capacity of this store for the specified resource. For a general purpose store, it returns total capacity if `resource` is undefined.
	 * @param resource The type of the resource.
	 * @returns Returns capacity number, or `null` in case of an invalid `resource` for this store type.
	 */
	public function getCapacity(?resource:ResourceConstant):EitherType<Int, Void>;

	/**
	 * Returns the capacity used by the specified resource, or total used capacity for general purpose stores if `resource` is undefined.
	 * @param resource The type of the resource.
	 * @returns Returns used capacity number, or `null` in case of a not valid `resource` for this store type.
	 */
	public function getUsedCapacity(?resource:ResourceConstant):EitherType<Int, Void>;

	/**
	 * Returns free capacity for the store. For a limited store, it returns the capacity available for the specified resource if `resource` is defined and valid for this store.
	 * @param resource The type of the resource.
	 * @returns Returns available capacity number, or `null` in case of an invalid `resource` for this store type.
	 */
	public function getFreeCapacity(?resource:ResourceConstant):EitherType<Int, Void>;
}

extern typedef StoreDefinition = {};
