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

class Spikes extends Entity {
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
		height = 8;
		super(x, y+2);
		setOrigin(0, 2);

		sprite = new Spritemap("gfx/tileset.png", 64, 64);
		sprite.add("spikes-normal", [45]);
		sprite.add("spikes-bloody", [55]);

		sprite.play("spikes-normal");
		graphic = sprite;

		hurtCallback = function(){
			var player = cast(Settings.Player, entities.Player);
			player.damage(10);
			sprite.play("spikes-bloody");
			setRandomHurtSFX();
		};		

		setRandomHurtSFX();
	}

	private function setRandomHurtSFX(){
		var hurtnum = Std.random(2) + 1;
		hurtSnd = new Sfx("sfx/SFX/Hurt"+hurtnum+Settings.SoundEffectsFileType, hurtCallback);
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
		isColliding = scene.collideRect("player", x+2, y+24, 60, 40) != null;
	}

	public override function update(){
		super.update();
		checkForCollision();
		handleCollision();
		sinceLast += HXP.elapsed;
	}
}