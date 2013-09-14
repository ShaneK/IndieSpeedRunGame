package entities;
 
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

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

    var maximumSpeed = 250;
    var jumpVelocity = 0;

    public function new(x:Int, y:Int)
    {
        super(x, y);
 		width = 50;
 		height = 100;

        body = new Body(); // Implicit BodyType.DYNAMIC
        body.shapes.add(new Polygon(Polygon.rect(0, 0, width, height)));
        body.position.setxy(x, y);
        body.setShapeMaterials(Material.steel());
        body.allowRotation = false;
        body.mass = 10;
        
        sprite = new Spritemap("gfx/player.png", 32, 64);        
        sprite.add("idle", [0]);        
        sprite.add("walk", [1, 2, 3, 4, 5], 8, true);
        sprite.add("jump", [19]);
        sprite.scaledWidth = width;
        sprite.scaledHeight = height;
        
        // // tell the sprite to play the idle animation
        // sprite.play("idle");
 
        // // apply the sprite to our graphic object so we can see the player
         graphic = sprite;

        // defines left and right as arrow keys and WASD controls
        Input.define("left", [Key.LEFT, Key.A]);
        Input.define("right", [Key.RIGHT, Key.D]);
        Input.define("jump", [Key.UP, Key.W, Key.SPACE]);
    }

    public override function update(){
    	super.update();
    	x = body.position.x;
    	y = body.position.y;
        // followMe();
        handleInput();
        velocityManagement();
        setAnimations();
    }

    public function followMe(){
        var newX = x-(HXP.halfWidth);
        var newY = y-(HXP.halfHeight);
        HXP.setCamera(newX, newY);
    }

    public function handleInput(){
        if (Input.check("left"))
        {
            velocityX = EMath.clamp(velocityX+(maximumSpeed*.4), -maximumSpeed, maximumSpeed);
            // if(body.velocity.x > 0){
            //     velocityX = EMath.clamp(velocityX, -maximumSpeed, 0);
            // }
        }
 
        if (Input.check("right"))
        {
            velocityX = EMath.clamp(velocityX-(maximumSpeed*.4), -maximumSpeed, maximumSpeed);
            // if(body.velocity.x < 0){
            //     velocityX = EMath.clamp(velocityX, 0, maximumSpeed);
            // }
        }
        
        if (Input.check("jump") && body.velocity.y == 0)
        {
            jumpVelocity = 200;
        }
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

        if(body.velocity.y > 1 || body.velocity.y < -1){
            sprite.play("jump");
        }
     }

    public function velocityManagement(){
        if(body.velocity.y != 0){
            jumpVelocity = 0;
        }
        if(velocityX > 0){
            velocityX = EMath.clamp(velocityX-(maximumSpeed*.1), -maximumSpeed, maximumSpeed);
        }else if(velocityX < 0){
            velocityX = EMath.clamp(velocityX+(maximumSpeed*.1), -maximumSpeed, maximumSpeed);
        }
        body.kinematicVel.x = velocityX;
        body.kinematicVel.y = jumpVelocity;
    }
}