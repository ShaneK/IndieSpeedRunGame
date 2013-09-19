package entities.android;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Touch;

class Joypad extends entities.buttons.Button {
	private var actualScreenHeight:Int;
	private var actualScreenWidth:Int;
	private var joypadWidth:Int;
	private var joypadHeight:Int;
	private var orgX:Float = 0;

	public function new(){
		this.actualScreenHeight = Math.floor(HXP.height/HXP.screen.scaleY);
		this.actualScreenWidth = Math.floor(HXP.width/HXP.screen.scaleX);
		this.joypadHeight = Math.floor(actualScreenHeight/2);
		this.joypadWidth = Math.floor(actualScreenWidth/2);
		super(0, 0, joypadWidth, joypadHeight, "Test", false);
	}

	public override function update(){
		// trace(x, y);
		super.update();
	}

	public override function render(){
		x = HXP.camera.x;
		y = HXP.camera.y + actualScreenHeight - joypadHeight;
		super.render();
	}

	public override function onClick(){
		var touches:Map<Int,Touch> = Input.touches;
		if(Lambda.count(touches) > 0){
			for(elem in touches){
				if(hit(elem.x + HXP.camera.x, elem.y + HXP.camera.y)){
					if(orgX == 0){
						orgX = elem.x;
						continue;
					}
					if(elem.x > orgX){
						Controller.RightButtonHit = true;
						Controller.LeftButtonHit = false;
					}else{
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
		orgX = 0;
		super.onRelease();
	}
}