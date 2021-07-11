# screeps-haxe
haxe extern types for game screeps.

# Credits

credits to https://github.com/screepers/typed-screeps for typed definitions, the extern types are based on this.

# Installation

```haxelib install screeps-extern 0.0.4```

# Info 

1. everything is in the screeps namespace

2. for Globals do import screeps.Globals.*;

3. most of the functions have returns types as EitherTypes so you have to specify the correct return type, for example - filter function in room.find should be like this ```filter: (x:Source) -> {return false} -- explicitly specifying Source type because of EitherType```

4. refer to the examples directory for proper usage


# Usage

in your main class you should have @:expose metadata and a function named loop that will run in screeps.


* Main.hx
```
import screeps.Globals.Work;
import screeps.Source;
import screeps.Game;
import screeps.Globals.Find.*;
import screeps.Globals.BodyPart.*;


@:expose
class Main {
	static public function init() {
	}

	static public function loop() {
		var spawn = Game.spawns['Spawn1'];

		var sources = spawn.room.find(FIND_SOURCES, {
			filter: (x:Source) -> {
				return x.pos.findInRange(FIND_HOSTILE_STRUCTURES, 3).length == 0;
			}
		});
  }
  
}

```

* main.js

```
const init = require("./out").Main.init;
const loop = require("./out").Main.loop;

init();

exports.loop = loop

```
