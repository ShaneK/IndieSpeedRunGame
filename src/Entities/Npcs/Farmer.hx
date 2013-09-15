package entities.npcs;


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


    public function new(x:Float, y:Float)
    {
        startX = x;
        width = 12;
        height = 24;
        super(x, y, width, height);
        

        sprite = new Spritemap("gfx/farmer.png", 32, 64);        
        sprite.add("idle", [0]);        
        sprite.add("walk", [1, 2, 3, 4, 5], 8, true);
        sprite.add("jump", [19]);
        sprite.add("dead", [54]);
        sprite.scaledWidth = width;
        sprite.scaledHeight = height;
        sprite.play("idle");
        
        graphic = sprite;
        layer = 3;
        type = "other-tribe";
    }

    public override function update(){
    	super.update();        
    	x = body.position.x;
    	y = body.position.y;

        if(isAlive()){
            wander();
        }else{
            body.velocity.x = 0;
            body.kinematicVel.x = 0;
        }
        setAnimations();
    }

     private function setAnimations()
     {
        if(!isAlive()){
            sprite.play("dead");
            return;
        }

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
