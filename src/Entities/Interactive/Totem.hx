package entities.interactive;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Emitter;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.Sfx;

import classes.Settings;

class Totem extends InteractiveEntity {
	private var w:Float;
	private var h:Float;
	var sprite:Spritemap;
#if android
	private static var floatingText = "Click to pray";
#else
	private static var floatingText = "Press up to pray";
#end

	public function new(x:Float, y:Float, upHit:Void->Void){
		width = 16;
		height = 16;

		super(x, y, new Sfx("sfx/SFX/Pray" + Settings.SoundEffectsFileType, upHit), floatingText);

		sprite = new Spritemap("gfx/tileset.png", 16, 16);
		sprite.add("neutral", [25]);
		sprite.add("sad", [15]);
		sprite.add("happy", [35]);

		sprite.play("neutral");
		graphic = sprite;
	}

	public override function update(){
		super.update();
	}
}