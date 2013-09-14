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
		width = Std.int(16);
		height = Std.int(16);
		this.w = 16;
		this.h = 16;

		super(x, y);
		this.space = space;
		emitter = new Emitter("gfx/particles.png", 2, 2);
		emitter.newType("dirt", [1]);
		emitter.setMotion("dirt", 0, 30, 20, 360, 10);
		emitter.setAlpha("dirt", 1);
		time = 1;
		graphic = emitter;
		layer = 2;
	}

	public override function update(){
		super.update();
		timer += HXP.elapsed;
		if(timer <= time){
			var randomWidth = w*Math.random();
			var randomHeight = h*Math.random();
			emitter.emit("dirt", randomWidth, randomHeight);
		}else{
			var t = new entities.Block(x, y+1);
			scene.add(t);
			space.bodies.add(t.getBody());
			scene.remove(this);
		}
	}
}