package entities.npcs;

import com.haxepunk.Entity;
import classes.Settings;

enum NPCTYPE {
	FARMER;
	WARRIOR;
}

class Spawner extends Entity {
	var npcType:NPCTYPE;
	var hasSpawned:Bool = false;

	public function new(x:Float, y:Float, type:NPCTYPE, once:Bool = true){
		super(x, y);
		setOrigin(0, 0);

		npcType = type;
	}

	public function spawn(){		
		if(!hasSpawned){
			switch (npcType) {
				case FARMER: return spawnFarmer();
				case WARRIOR: return spawnWarrior();
			}
		}
		hasSpawned = true;
		return null;
	}

	private function spawnFarmer(){
		var npc = new Farmer(this.x, this.y);
		Settings.Scene.add(npc);
		Settings.Space.bodies.add(npc.getBody());
	}

	private function spawnWarrior(){
		var npc = new Warrior(this.x, this.y);
		Settings.Scene.add(npc);
		Settings.Space.bodies.add(npc.getBody());
	}
}