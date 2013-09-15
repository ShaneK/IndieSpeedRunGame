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
    var direction:Int = 1;
    var speed:Float = 5;

    public function new(x:Float, y:Float)
    {
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

        body.kinematicVel.x += direction * speed * HXP.elapsed;

        timer += HXP.elapsed;
        if(timer > 1){
            direction = EMath.randomSign();
            timer = 0;
        }
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
