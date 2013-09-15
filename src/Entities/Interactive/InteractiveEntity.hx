package entities.interactive;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Emitter;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.Sfx;

class InteractiveEntity extends Entity {
	var isColliding:Bool;
	var dialog:entities.Dialog;
	var dialogOn:Bool;
	var timer:Float;
	var sfx:Sfx;
	var text:String;

	public function new(x:Float, y:Float, sfx:Sfx, interactionText:String){
		super(x, y+2);
		setOrigin(0, 2);
		this.sfx = sfx;
		sfx.type = "SFX";
		text = interactionText;
	}

	public function handleInput(){
        if (Input.check(Key.UP) && isColliding && !sfx.playing)
        {        	
        	sfx.play();
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
			var width = text.length * 5;
			dialog = new entities.Dialog(Std.int(x)-28, Std.int(y)-18, width, 10, text);
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
}