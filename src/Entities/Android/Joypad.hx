package entities.android;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Touch;
import com.haxepunk.graphics.Image;

import classes.Settings;

class Joypad extends entities.buttons.Button {
	private var actualScreenHeight:Int;
	private var actualScreenWidth:Int;
	private var joypadWidth:Int;
	private var joypadHeight:Int;
	private var orgX:Float = 0;
	private var orgY:Float = 0;
	private var currentX:Float = 0;
	private var currentY:Float = 0;
	private var runDistance:Int = 35;
	private var image:Image;
	private var nob:Image;

	public function new(){
		if(Settings.Level > 1){
			this.actualScreenHeight = Math.floor(HXP.height);
			this.actualScreenWidth = Math.floor(HXP.width);
		}else{
			this.actualScreenHeight = Math.floor(HXP.height/HXP.screen.scaleY);
			this.actualScreenWidth = Math.floor(HXP.width/HXP.screen.scaleX);
		}
		this.joypadHeight = Math.floor(actualScreenHeight/2);
		this.joypadWidth = Math.floor(actualScreenWidth/2);
		super(0, 0, joypadWidth, joypadHeight, "Test", false);

		image = Image.createCircle(20, 0x888888);
		image.relative = false;
		image.alpha = 0.6;
		nob = Image.createCircle(17, 0x777777);
		nob.relative = false;
		nob.alpha = 0;
		addGraphic(image);
		addGraphic(nob);
	}

	public override function update(){
		// trace(x, y);
		super.update();
	}

	public override function render(){
		x = HXP.camera.x;
		y = HXP.camera.y + actualScreenHeight - joypadHeight;
		if(orgX == 0){
			image.alpha = 0.6;
			image.x = x + (joypadWidth/4) - (image.scaledWidth/2);
			image.y = y + (joypadHeight/1.5) - (image.scaledHeight/2);
		}else{
			image.alpha = 0.8;
			image.x = orgX + HXP.camera.x - (image.scaledWidth/2);
			image.y = orgY + HXP.camera.y - (image.scaledHeight/2);
		}
		if(currentX == 0){
			nob.alpha = 0;
		}else{
			nob.alpha = 1;
			nob.x = currentX + HXP.camera.x - (nob.scaledWidth/2);
			nob.y = currentY + HXP.camera.y - (nob.scaledHeight/2);
		}
		super.render();
	}

	public override function onClick(){
		var touches:Map<Int,Touch> = Input.touches;
		if(Lambda.count(touches) > 0){
			for(elem in touches){
				if(hit(elem.x + HXP.camera.x, elem.y + HXP.camera.y)){
					if(orgX == 0){
						orgX = elem.x;
						orgY = elem.y;
						continue;
					}
					currentX = elem.x;
					currentY = elem.y;
					if(elem.x > orgX){
						if(elem.x - orgX >= runDistance){
							Controller.RunButtonHit = true;
						}else{
							Controller.RunButtonHit = false;
						}
						Controller.RightButtonHit = true;
						Controller.LeftButtonHit = false;
					}else{
						if(orgX - elem.x >= runDistance){
							Controller.RunButtonHit = true;
						}else{
							Controller.RunButtonHit = false;
						}
						Controller.RightButtonHit = false;
						Controller.LeftButtonHit = true;
					}
				}
            }
		}
		super.onClick();
	}

	public override function onRelease(){
		Controller.RightButtonHit = false;
		Controller.LeftButtonHit = false;
		Controller.RunButtonHit = false;
		orgX = 0;
		currentX = 0;
		super.onRelease();
	}
}