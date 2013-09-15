package entities.npcs;

import classes.EMath;
import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
 
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Polygon;
import nape.geom.Vec2;
import nape.phys.Material;
import com.haxepunk.graphics.Spritemap;
 
class Farmer extends NPC
{    
    var sprite:Spritemap;
    var timer:Float = 0;
    var randTimer:Float = 0;
    var direction:Int = 1;
    var speed:Float = 500;

    var startX:Float;

    public function new(x:Float, y:Float)
    {
        startX = x;
        super(x, y, 12, 24);
        width = 12;
        height = 24;

        sprite = new Spritemap("gfx/farmer.png", 32, 64);        
        sprite.add("idle", [0]);        
        sprite.add("walk", [1, 2, 3, 4, 5], 8, true);
        sprite.add("jump", [19]);
        sprite.scaledWidth = width;
        sprite.scaledHeight = height;
        sprite.play("idle");
        
        graphic = sprite;
        layer = 3;
        type = "farmer";
    }

    public override function update(){
    	super.update();        
    	x = body.position.x;
    	y = body.position.y;

        var distFromStart = Math.abs(startX - body.position.x);
        timer += HXP.elapsed;
        randTimer += HXP.elapsed;
        if(timer > 1.5 && distFromStart >= 16){
            trace("change dir");
            direction = -direction;
            body.kinematicVel.x = 0;    
            timer = 0;
        }

        if(randTimer > 3){
            trace("rand dir change");
            direction = EMath.randomSignWithZero();
            randTimer = 0;
        }
        body.kinematicVel.x = direction * speed * HXP.elapsed;    
        setAnimations();
    }

     private function setAnimations()
     {
        if (body.velocity.x > 2 || body.velocity.x < -2)
        {
            sprite.play("walk");
            sprite.flipped = body.velocity.x < 0;
        }
        else
        {
            sprite.play("idle");
        }
     }
}
