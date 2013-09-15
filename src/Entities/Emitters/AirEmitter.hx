package entities.emitters;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Emitter;
import nape.space.Space;
import nape.geom.Vec2;

class AirEmitter extends Entity {
	private var emitter:Emitter;
	private var timer:Float = 0;
	private var time:Float;
	private var w:Float;
	private var h:Float;
	private var space:Space;
	private var windWidth:Float;
	private var windMultiplier:Float;

	public function new(w:Float, h:Float, x:Float, y:Float, xTime:Float, left:Bool = false, space:Space, windWidth:Float = 400, windMultiplier:Float = 100){
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

		this.windWidth = windWidth;
		this.windMultiplier = windMultiplier;

		this.space = space;
	}

	public function wind(){
		for (body in space.liveBodies) {
			var remoteX = body.position.x;
			var remoteY = body.position.y;

			if(!((remoteX >= x && remoteX <= x+windWidth) && (remoteY >= y && remoteY <= y+h))){
				continue;
			}
 
            // Gravitational force.d
            var force = Vec2.get(100, 0);
 
            // We don't use a true description of gravity, as it doesn't 'play' as nice.
            force.length = body.mass * windMultiplier;
 
            // Impulse to be applied = force * deltaTime
            body.applyImpulse(force.muleq(HXP.elapsed), null);
        }
	}

	public override function update(){
		super.update();
		timer += HXP.elapsed;
		if(timer <= time){
			var randomWidth = w/2*Math.random();
			var randomHeight = h*Math.random();
			emitter.emit("air", randomWidth, randomHeight);
			wind();
		}else{
			scene.remove(this);
		}
	}
}