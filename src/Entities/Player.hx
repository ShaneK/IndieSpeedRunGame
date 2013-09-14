package entities;
 
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
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

    var maximumSpeed = 250;
    var jumpVelocity = 0;

    public function new(x:Int, y:Int)
    {
        super(x, y);
 		width = 5;
 		height = 10;

        body = new Body(); // Implicit BodyType.DYNAMIC
        body.shapes.add(new Polygon(Polygon.rect(0, 0, width, height)));
        body.position.setxy(x, y);
        body.setShapeMaterials(Material.steel());
        body.allowRotation = false;
        body.mass = 10;

        image = Image.createRect(width,height, 0xFF0000);
        layer = 2;
        graphic = image;
    }

    public override function update(){
    	super.update();
    	x = body.position.x;
    	y = body.position.y;
    	// image.angle = body.rotation;
        followMe();
        handleInput();
        velocityManagement();
    }

    public function followMe(){
        var newX = x-(HXP.halfWidth);
        var newY = y-(HXP.halfHeight);
        HXP.setCamera(newX, newY);
    }

    public function handleInput(){
        if (Input.check(Key.LEFT))
        {
            velocityX = EMath.clamp(velocityX+(maximumSpeed*.4), -maximumSpeed, maximumSpeed);
            if(body.velocity.x > 0){
                velocityX = EMath.clamp(velocityX, -maximumSpeed, 0);
            }
        }
 
        if (Input.check(Key.RIGHT))
        {
            velocityX = EMath.clamp(velocityX-(maximumSpeed*.4), -maximumSpeed, maximumSpeed);
            if(body.velocity.x < 0){
                velocityX = EMath.clamp(velocityX, 0, maximumSpeed);
            }
        }
        
        if (Input.check(Key.SPACE) && body.velocity.y == 0)
        {
            jumpVelocity = 200;
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