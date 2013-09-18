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


	public function new(){
		this.actualScreenHeight = Math.floor(HXP.height/HXP.screen.scale);
		this.actualScreenWidth = Math.floor(HXP.width/HXP.screen.scale);
		this.jumpButtonHeight = Math.floor(actualScreenHeight/10);
		this.jumpButtonWidth = Math.floor(actualScreenWidth/10);
		super(0, 0, jumpButtonWidth, jumpButtonHeight, "", true);
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