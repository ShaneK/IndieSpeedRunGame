package entities.emitters;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Emitter;

class WaterEmitter extends Entity {
	private var emitter:Emitter;
	private var timer:Float = 0;
	private var time:Float;
	private var w:Float;
	private var h:Float;
	private var intensity:Int;

	public function new(w:Float, h:Float, xi:Float, yi:Float, xTime:Float, intensity:Int = 1){
		width = Std.int(w);
		height = Std.int(h);
		this.w = w;
		this.h = h;

		super(xi, yi);
		emitter = new Emitter("gfx/particles.png", 2, 2);
		emitter.newType("water", [1]);
		emitter.setMotion("water", 270, 1500, xTime);
		// emitter.setColor("water", 0xFF0000);
		emitter.setAlpha("water", 1);

		this.intensity = intensity;

		time = xTime;
		graphic = emitter;
	}

	public override function update(){
		super.update();
		timer += HXP.elapsed;
		if(timer <= time){
			for(i in 0...intensity){
				var randomWidth = w*Math.random();
				emitter.emit("water", randomWidth, 0);
			}
		}else{
			scene.remove(this);
		}
	}
}