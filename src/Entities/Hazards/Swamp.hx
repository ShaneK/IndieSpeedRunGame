package entities.hazards;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Emitter;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.Sfx;
import classes.Settings;

class Swamp extends Entity {
	private var w:Float;
	private var h:Float;
	var sprite:Spritemap;
	var isColliding:Bool;
	var dialog:entities.Dialog;
	var dialogOn:Bool;
	var hurtSnd:Sfx;
	var hurtCallback:AudioCompleteCallback;
	var sinceLast:Float = 0;

	public function new(x:Float, y:Float){
		width = 16;
		height = 16;
		super(x + 1, y+1);
		setOrigin(0, 2);

		sprite = new Spritemap("gfx/tileset.png", 16, 16);
		sprite.add("swamp", [4]);
		sprite.play("swamp");
		graphic = sprite;

		hurtCallback = function(){
			var player = cast(Settings.Player, entities.Player);
			player.damage(10);
			setRandomHurtSFX();
		};		

		setRandomHurtSFX();
	}

	private function setRandomHurtSFX(){
		var hurtnum = Std.random(2) + 1;
		hurtSnd = new Sfx("sfx/SFX/Hurt"+hurtnum+".mp3", hurtCallback);
		hurtSnd.type = "SFX";
	}

	public function handleCollision(){
        if (isColliding && !hurtSnd.playing && sinceLast > 1)
        {        	
        	hurtSnd.play();
        	sinceLast = 0;
        }
	}

	public function checkForCollision(){
		isColliding = scene.collideRect("player", x+4, y+8, 4, 4) != null;
	}

	public override function update(){
		super.update();
		checkForCollision();
		handleCollision();
		sinceLast += HXP.elapsed;
	}
}