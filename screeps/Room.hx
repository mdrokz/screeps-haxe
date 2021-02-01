package screeps;

import screeps.Globals.Pwr;
import haxe.extern.EitherType;
import screeps.Globals.EFFECT_INVULNERABILITY;
import screeps.Globals.EFFECT_COLLAPSE_TIMER;

typedef Effect = EitherType<EFFECT_INVULNERABILITY, EFFECT_COLLAPSE_TIMER>;

/**
 * Natural effect applied to room object
 */
typedef NaturalEffect = {
	/**
	 * Effect ID of the applied effect. `EFFECT_*` constant.
	 */
	final effect:Effect;

	/**
	 * How many ticks will the effect last.
	 */
	final ticksRemaining:Int;
}

/**
 * Effect applied to room object as result of a `PowerCreep.usePower`.
 */
typedef PowerEffect = {
	/**
	 * Power level of the applied effect.
	 */
	final level:Int;

	/**
	 * Effect ID of the applied effect. `PWR_*` constant.
	 */
	final effect:Pwr;

	/**
	 * @deprecated Power ID of the applied effect. `PWR_*` constant. No longer documented, will be removed.
	 */
	final power:Pwr;

	/**
	 * How many ticks will the effect last.
	 */
	final ticksRemaining:Int;
};

/**
 * Discriminated union of possible effects on `effect`
 */
typedef RoomObjectEffect = EitherType<NaturalEffect, PowerEffect>;

extern class RoomObject {
    final prototype:RoomObject;
    final effects: Array<RoomObjectEffect>;
    final roomPosition: RoomPosition;
}
