package entities.hazards;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Emitter;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.Sfx;

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

		sprite = new Spritemap("gfx/tileset.png", 16, 16);
		sprite.add("spikes-normal", [45]);
		sprite.add("spikes-bloody", [55]);

		sprite.play("spikes-normal");
		graphic = sprite;

		hurtCallback = function(){
			trace("SPIKES BIAAATCH.");
			sprite.play("spikes-bloody");
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
		isColliding = scene.collideRect("player", x, y, 16, 16) != null;
	}

	public override function update(){
		super.update();
		checkForCollision();
		handleCollision();
		sinceLast += HXP.elapsed;
	}
}