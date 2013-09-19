package entities.android;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Touch;

class Jump extends entities.buttons.Button {
	private var actualScreenHeight:Int;
	private var actualScreenWidth:Int;
	private var jumpButtonWidth:Int;
	private var jumpButtonHeight:Int;
	private static var count:Int = 0;

	public function new(){
		if(count > 0){
			this.actualScreenHeight = Math.floor(HXP.height);
			this.actualScreenWidth = Math.floor(HXP.width);
		}else{
			this.actualScreenHeight = Math.floor(HXP.height/HXP.screen.scaleY);
			this.actualScreenWidth = Math.floor(HXP.width/HXP.screen.scaleX);
		}
		this.jumpButtonHeight = Math.floor(actualScreenHeight/10);
		this.jumpButtonWidth = Math.floor(actualScreenWidth/10);
		super(0, 0, jumpButtonWidth, jumpButtonHeight, "", true);
		count++;
	}

	public override function update(){
		// trace(x, y);
		super.update();
	}

	public override function render(){
		x = HXP.camera.x + actualScreenWidth - jumpButtonWidth;
		y = HXP.camera.y + actualScreenHeight - jumpButtonHeight;
		super.render();
	}

	public override function onClick(){
		Controller.JumpButtonHit = true;
		super.onClick();
	}

	public override function onRelease(){
		Controller.JumpButtonHit = false;
		super.onRelease();
	}
}