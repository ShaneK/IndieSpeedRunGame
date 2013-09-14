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
	var isColliding:Bool;
	var dialog:entities.Dialog;
	var dialogOn:Bool;
	var timer:Float;

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
        		if(isColliding){
        			handleUpHit();
        		}
        	}
        }
	}

	public function checkForCollision(){
		isColliding = scene.collideRect("player", x, y, 16, 16) != null;
	}

	public override function update(){
		super.update();
		checkForCollision();
		handleDialogDisplay();
		handleInput();
	}

	public function handleDialogDisplay(){
		if(dialog == null){
			dialog = new entities.Dialog(Std.int(x)-28, Std.int(y)-18, 78, 10, "Press Up to Pray");
			dialogOn = false;
			timer = 0;
		}
		if(isColliding){
			if(!dialogOn){
				timer += HXP.elapsed;
				if(timer >= .25){
					dialogOn = true;
		        	scene.add(dialog);
	        	}
        	}
    	}else if(dialogOn){
    		scene.remove(dialog);
			dialogOn = false;
    		timer = 0;
    	}else if(timer > 0){
    		timer = 0;
    	}
	}

	public function handleUpHit(){
		upHitHook();
	}
}