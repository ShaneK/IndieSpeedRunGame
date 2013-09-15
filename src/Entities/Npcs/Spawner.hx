
enum NPCTYPE {
	FARMER,
	WARRIOR
}

class Spawner extends Entity {
	var npcType:NPCTYPE;
	var hasSpawned:Bool = false;

	public function new(x:Float, y:Float, type:NPCTYPE, once:Bool = true){
		super(x, y+2);
		setOrigin(0, 2);

		npcType = type;
	}

	public function spawn(){		
		if(!hasSpawned){
			switch (npcType) {
				case NPCTYPE.FARMER: spawnFarmer(); break;
				case NPCTYPE.WARRIOR: spawnWarrior(); break;
			}
		}

		hasSpawned = true;
	}

	private function spawnFarmer(){
		trace("Spawning: Farmer");
	}

	private function spawnWarrior(){
		trace("Spawning: WARRIOR");
	}
}