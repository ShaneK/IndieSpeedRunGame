package entities.npcs;

import classes.Settings;
import com.haxepunk.Entity;
import com.haxepunk.HXP;
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
    var atkTime:Float = 0;
    var isCowering:Bool = false;

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
        sprite.add("cower", [12]);
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

        if(isAlive() && !isCowering){
            wander();
        }else{
            body.velocity.x = 0;
            body.kinematicVel.x = 0;
        }
        setAnimations();
        doFear();
    }

    private function doFear(){
        if((Settings.Attacks >= 4 || Settings.Kills >= 1) && isAlive()){
            cower();
        }
        if(!isAlive()){
            isCowering = false;
        }
    }

    private function cower(){
        if(scene.collideRect("player", x+4, y+8, 16, 16) != null && atkTime > 1){            
            isCowering = true;
            atkTime = 0;
        }
        else{
            if(atkTime > 1){
                isCowering = false;
            }            
        }

        atkTime += HXP.elapsed;
    }

     private function setAnimations()
     {
        sprite.flipped = body.velocity.x < 0;
        if(isCowering){            
            sprite.play('cower');
            return;
        }
        if(!isAlive()){
            sprite.play("dead");
            return;
        }

        if (body.velocity.x > 2 || body.velocity.x < -2)
        {
            sprite.play("walk");            
        }
        else
        {
            sprite.play("idle");
        }
     }
}
