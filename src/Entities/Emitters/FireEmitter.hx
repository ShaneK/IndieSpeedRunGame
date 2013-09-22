package entities.emitters;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Emitter;

class FireEmitter extends Entity {
	private var emitter:Emitter;
	private var timer:Float = 0;
	private var time:Float;
	private var w:Float;
	private var h:Float;
	private var intensity:Int;

	public function new(w:Float, h:Float, x:Float, y:Float, xTime:Float, intensity:Int = 1){
		width = Std.int(w);
		height = Std.int(h);
		this.w = w;
		this.h = h;

		super(x, y);
		emitter = new Emitter("gfx/particles.png", 2, 2);
		emitter.newType("fire", [2]);
		emitter.setMotion("fire", 90, 30, 1, 0, 10);
		emitter.setAlpha("fire", 1);
		time = xTime;
		graphic = emitter;
		layer = 1;

		this.intensity = intensity;
	}

	public override function update(){
		super.update();
		timer += HXP.elapsed;
		if(timer <= time || time == -1){
			for(i in 0...intensity){
				var randomWidth = w*Math.random();
				emitter.emit("fire", randomWidth, 0);
			}
		}else{
			scene.remove(this);
		}
	}
}