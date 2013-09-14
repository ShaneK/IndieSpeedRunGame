package entities;
 
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.utils.Input;

import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Polygon;
import nape.geom.Vec2;
import nape.phys.Material;

import classes.EMath;
 
class Player extends PhysicalBody
{
	private var image:Image;
    private var velocityX:Float = 0;
    private var velocityY:Float = 0;
    private var sprite:Spritemap;

    var maximumSpeed = 75;
    var jumpAmount = 110;
    var jumpVelocity = 0;

    public function new(x:Int, y:Int)
    {
        super(x, y);
 		width = 12;
 		height = 24;

        body = new Body(); // Implicit BodyType.DYNAMIC
        body.shapes.add(new Polygon(Polygon.rect(0, 0, width, height)));
        body.position.setxy(x, y);
        body.setShapeMaterials(new Material(0.0,500));
        body.allowRotation = false;
        body.mass = 25;

        sprite = new Spritemap("gfx/player.png", 32, 64);        
        sprite.add("idle", [0]);        
        sprite.add("walk", [1, 2, 3, 4, 5], 8, true);
        sprite.add("jump", [19]);
        sprite.scaledWidth = width;
        sprite.scaledHeight = height;
        sprite.play("idle");
        
        graphic = sprite;        
        layer = 2;
        type = "player";
    }

    public override function update(){
        velocityX = 0;
    	super.update();
    	x = body.position.x;
    	y = body.position.y;
        handleInput();
        velocityManagement();
        setAnimations();
    }

    public function handleInput(){                
        if (Input.check("left"))
        {
            velocityX += maximumSpeed;
        } 
        
        if (Input.check("right"))
        {
            velocityX += -(maximumSpeed);
        }

        jumpVelocity = Input.check("jump") && isOnGround() ? jumpAmount : 0;
    }

    private function isOnGround():Bool{
        return body.velocity.y < 1 && body.velocity.y > -1;
    }

     private function setAnimations()
     {
        if (body.velocity.x > 1 || body.velocity.x < -1)
        {
            sprite.play("walk");
            sprite.flipped = velocityX > 0;            
        }
        else
        {
            sprite.play("idle");
        }

        if(!isOnGround()){
            sprite.play("jump");
        }
     }

    public function velocityManagement(){        
        body.kinematicVel.x = EMath.clamp(velocityX, -maximumSpeed, maximumSpeed);
        body.kinematicVel.y = jumpVelocity;
    }
}