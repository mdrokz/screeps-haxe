import screeps.Memory;
import screeps.Memory.Memory;

typedef CreepInfo = {
    source: String
} 

class Main {
    static public function main() {
        var s: CreepInfo = Memory.creeps["s"];
    }
}