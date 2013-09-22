package entities.emitters;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Emitter;
import nape.shape.Polygon;
import nape.space.Space;

class GroundEmitter extends Entity {
	private var emitter:Emitter;
	private var timer:Float = 0;
	private var time:Float;
	private var w:Float;
	private var h:Float;
	private var space:Space;

	public function new(x:Float, y:Float, space:Space){
		width = Std.int(64);
		height = Std.int(64);
		this.w = 64;
		this.h = 64;

		super(x, y);
		this.space = space;
		emitter = new Emitter("gfx/particles.png", 8, 8);
		emitter.newType("dirt", [0]);
		emitter.setMotion("dirt", 0, 250, 20, 360, 10);
		emitter.setAlpha("dirt", 1);
		time = .7;
		graphic = emitter;
		layer = 2;
	}

	public override function update(){
		super.update();
		timer += HXP.elapsed;
		if(timer <= time){
			var randomWidth = w*Math.random();
			var randomHeight = h*Math.random();
			emitter.emitInCircle("dirt", randomWidth, randomHeight, 10);
		}else{
			var t = new entities.Block(x, y+1);
			scene.add(t);
			space.bodies.add(t.getBody());
			scene.remove(this);
		}
	}
}