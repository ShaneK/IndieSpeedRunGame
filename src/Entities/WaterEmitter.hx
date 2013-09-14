package entities;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Emitter;

class WaterEmitter extends Entity {
	private var emitter:Emitter;
	private var timer:Float = 0;
	private var time:Float;
	private var w:Float;
	private var h:Float;

	public function new(w:Float, h:Float, x:Float, y:Float, xTime:Float){
		width = Std.int(w);
		height = Std.int(h);
		this.w = w;
		this.h = h;

		super(x, y);
		emitter = new Emitter("gfx/particles.png", 8, 8);
		emitter.newType("water", [1]);
		emitter.setMotion("water", 270, 1500, xTime);
		// emitter.setColor("water", 0xFF0000);
		emitter.setAlpha("water", 1);
		time = xTime;
		graphic = emitter;
	}

	public override function update(){
		super.update();
		timer += HXP.elapsed;
		if(timer <= time){
			var randomWidth = w*Math.random();
			emitter.emit("water", randomWidth, 0);
		}else{
			scene.remove(this);
		}
	}
}