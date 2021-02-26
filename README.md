# screeps-haxe
haxe extern types for game screeps.


# Usage 

1. everything is in the screeps namespace

2. for Globals do import screeps.Globals.*;

3. most of the functions have returns types as EitherTypes so you have to specify the correct return type, for example - filter function in room.find should be like this filter: (x:Source) -> {return false} -- explicitly specifying Source type because of EitherType
