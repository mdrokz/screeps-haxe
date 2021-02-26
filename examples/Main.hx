import screeps.Globals.Work;
import screeps.Source;
import screeps.Game;
import screeps.Globals.Find.*;
import screeps.Globals.BodyPart.*;

@:expose
class Main {
	static public function init() {
		var source: Source = Game.spawns['Spawn1'].room.find(FIND_SOURCES)[0];
		trace(Game.spawns['Spawn1'].spawnCreep([WORK, CARRY, MOVE], "creep1"+source.id));
	}

	static public function loop() {
		var spawn = Game.spawns['Spawn1'];

		var sources = spawn.room.find(FIND_SOURCES, {
			filter: (x:Source) -> {
				return x.pos.findInRange(FIND_HOSTILE_STRUCTURES, 3).length == 0;
			}
		});

		var creep_length = Game.creeps.length;

		var energy = spawn.store.energy;

		var creep_min = Math.floor(energy / 200);

		if (creep_length > 0) {
			for (source in sources) {
				var f:Source = source;

				if ((creep_length -= 2) >= 0) {
					var creep1 = Game.creeps["creep1" + f.id];
					var creep2 = Game.creeps["creep2" + f.id];
					creep1.moveTo(f);

					if(creep2 != null)
					creep2.moveTo(f);
				} else if (creep_length < 0) {
					var creep1 = Game.creeps["creep1" + f.id];
					creep1.moveTo(f);
					creep_length = 0;
				} else {
					var creep1 = Game.creeps["creep1" + f.id];
					creep1.moveTo(f);
				}
			}
		} else {
			for (source in sources) {
				var f:Source = source;

				if(creep_min >= 2) {
					spawn.spawnCreep([WORK, CARRY, MOVE], "creep1" + f.id);
					spawn.spawnCreep([WORK, CARRY, MOVE], "creep2" + f.id);
				}
			}
		}

		for (v in Game.creeps) {
			// trace(v);
		}
	}
}
