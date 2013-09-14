package entities;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Emitter;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class Totem extends Entity {
	private var w:Float;
	private var h:Float;
	var sprite:Spritemap;
	var upHit:Bool;
	var upHitHook:Void->Void;

	public function new(x:Float, y:Float, upHit:Void->Void){
		width = 16;
		height = 16;
		super(x, y+2);
		setOrigin(0, 2);

		upHitHook = upHit;

		sprite = new Spritemap("gfx/tileset.png", 16, 16);
		sprite.add("neutral", [25]);
		sprite.add("sad", [15]);
		sprite.add("happy", [35]);

		sprite.play("neutral");
		graphic = sprite;
	}

	public function handleInput(){
        if (Input.check(Key.UP))
        {
        	upHit = true;
        }else{
        	if(upHit){
        		upHit = false;
        		if(scene.collideRect("player", x, y, 16, 16) != null){
        			handleUpHit();
        		}
        	}
        }
	}

	public override function update(){
		super.update();
		handleInput();
	}

	public function handleUpHit(){
		upHitHook();
	}
}