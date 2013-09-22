package entities.npcs;

import classes.Settings;
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.Sfx;

import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Polygon;
import nape.geom.Vec2;
import nape.phys.Material;
import com.haxepunk.graphics.Spritemap;
 
class Warrior extends NPC
{
    var sprite:Spritemap;
    var atkTime:Float = 0;
    var isAttacking:Bool = false;
         

    public function new(x:Float, y:Float)
    {
        width = 46;
        height = 100;
        super(x, y, width, height);

        sprite = new Spritemap("gfx/warrior.png", 32, 64);        
        sprite.add("idle", [0]);        
        sprite.add("walk", [1, 2, 3, 4, 5], 8, true);
        sprite.add("jump", [19]);
        sprite.add("dead", [54]);
        sprite.add("attack", [25,26,27,28],8);
        sprite.scaledWidth = width;
        sprite.scaledHeight = height;
        sprite.play("idle");

        alrtSnd = new Sfx("sfx/SFX/Warrior_Alert" + Settings.SoundEffectsFileType);
        hurtSnd = new Sfx("sfx/SFX/Warrior_Hurt" + Settings.SoundEffectsFileType);
        
        graphic = sprite;
        layer = 3;
        type = "other-tribe";
    }

    public override function update(){
        super.update();        
        x = body.position.x;
        y = body.position.y;

        if(isAlive() && !isAttacking){
            wander(8);
        }else{
            body.velocity.x = 0;
            body.kinematicVel.x = 0;
        }        
        setAnimations();
        doAggression();
    }

    private function doAggression(){
        if((Settings.Attacks >= 1 || Settings.Kills >= 1 || Settings.Steals >= 1) && isAlive()){            
            attack();            
        }else{
            if(!isAlive()){
                isAttacking = false;
            }
        }
    }

    private function attack(){
        if(scene.collideRect("player", x+4, y+8, 16, 16) != null && atkTime > .5){            
            isAttacking = true;
            Settings.Health -= 10;
            atkTime = 0;
            if(!alerted){
                alerted = true;      
                alrtSnd.play();
            }
            facePlayer();
        }
        else{
            if(atkTime > .5){
                isAttacking = false;
            }
        }
        atkTime += HXP.elapsed;
    }

     private function setAnimations()
     {
        sprite.flipped = direction > 0;
        if(isAttacking){
            sprite.play('attack');
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