package entities.emitters;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Emitter;

class AirEmitter extends Entity {
	private var emitter:Emitter;
	private var timer:Float = 0;
	private var time:Float;
	private var w:Float;
	private var h:Float;

	public function new(w:Float, h:Float, x:Float, y:Float, xTime:Float, left:Bool = false){
		width = Std.int(w);
		height = Std.int(h);
		this.w = w;
		this.h = h;

		super(x, y);
		emitter = new Emitter("gfx/particles.png", 2, 2);
		emitter.newType("air", [3]);
		var direction = left ? -180 : 0;
		emitter.setMotion("air", direction, 500, 1, 0, 10);
		emitter.setAlpha("air", 1);
		time = xTime;
		graphic = emitter;
		layer = 1;
	}

	public override function update(){
		super.update();
		timer += HXP.elapsed;
		if(timer <= time){
			var randomWidth = w/2*Math.random();
			var randomHeight = h*Math.random();
			emitter.emit("air", randomWidth, randomHeight);
		}else{
			scene.remove(this);
		}
	}
}