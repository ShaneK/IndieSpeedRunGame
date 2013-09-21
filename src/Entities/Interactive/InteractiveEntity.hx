package entities.interactive;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Emitter;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Touch;
import com.haxepunk.utils.Key;
import com.haxepunk.Sfx;

import entities.android.Controller;
import classes.Settings;

class InteractiveEntity extends Entity {
	var isColliding:Bool;
	var dialog:entities.Dialog;
	var dialogOn:Bool;
	var timer:Float;
	var sfx:Sfx;
	var text:String;
	var showDialog:Bool;

	public function new(x:Float, y:Float, sfx:Sfx, interactionText:String, showDialog:Bool = true){
		super(x, y+2);
		setOrigin(0, 2);
		this.sfx = sfx;
		sfx.type = "SFX";
		text = interactionText;
		this.showDialog = showDialog;
	}

	public function handleInput(){
	    if (isColliding && !sfx.playing)
	    {     
			if(Settings.IsMobile){
				if(Controller.RightButtonHit || Controller.LeftButtonHit) return; //Player is moving, ignore this.
		        var touches:Map<Int,Touch> = Input.touches;
		        if(Lambda.count(touches) > 0){
		            for(elem in touches){
		                if(collideRect(elem.x + HXP.camera.x, elem.y + HXP.camera.y, x, y, 16, 16)){
	    					sfx.play();
	    					return;
		                }
		            }
		        }
		    }else if(Input.check(Key.UP)){
	    		sfx.play();
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
			var width = text.length * 5;
			dialog = new entities.Dialog(Std.int(x)-28, Std.int(y)-18, width, 10, text);
			dialogOn = false;
			timer = 0;
		}
		if(isColliding && showDialog){
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