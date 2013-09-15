package entities.interactive;

import classes.Settings;
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Emitter;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.Sfx;

class BananaStand extends InteractiveEntity {
	private var w:Float;
	private var h:Float;
	var sprite:Spritemap;
	var hasBanana:Bool = true;

	public function new(x:Float, y:Float, upHit:Void->Void){
		width = 16;
		height = 16;
		

		sprite = new Spritemap("gfx/tileset.png", 16, 16);
		sprite.add("stand", [50]);
		sprite.add("empty", [60]);

		sprite.play("stand");
		graphic = sprite;

		var takeBanana = function(){
			if(hasBanana){
				sprite.play("empty");
				upHit();
				Settings.Health += 10;
				hasBanana = false;
			}
		};
		super(x, y, new Sfx("sfx/SFX/GodYes.mp3", takeBanana), "Press Up to steal banana.");
	}

	public override function update(){
		super.update();
	}
}