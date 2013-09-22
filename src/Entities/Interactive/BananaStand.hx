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
#if android
	private static var floatingText = "Click to steal banana";
#else
	private static var floatingText = "Press up to steal banana";
#end

	public function new(x:Float, y:Float, upHit:Void->Void){
		width = 64;
		height = 64;
		

		sprite = new Spritemap("gfx/tileset.png", 64, 64);
		sprite.add("stand", [50]);
		sprite.add("empty", [60]);

		sprite.play("stand");
		graphic = sprite;

		var takeBanana = function(){
			if(hasBanana){
				sprite.play("empty");
				upHit();
				Settings.Health += 10;
				Settings.Steals += 1;
				hasBanana = false;
				showDialog = false;
			}
		};
		super(x, y, new Sfx("sfx/SFX/GodYes" + Settings.SoundEffectsFileType, takeBanana), floatingText);
	}

	public override function update(){
		super.update();
	}
}