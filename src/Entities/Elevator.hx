package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
 
import com.haxepunk.HXP;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Polygon;
import nape.geom.Vec2;
import nape.phys.Material;
import com.haxepunk.graphics.Spritemap;

import classes.EMath;

class Elevator extends PhysicalBody
{
    private var sprite:Spritemap;
    private var xStart:Float;
    private var yStart:Float;
    private var xEnding:Float;
    private var yEnding:Float;
    private var goingTowardsEnd:Bool;
    private var waiting:Bool;
    private var timer:Float;
    private var duration:Float;
    private var speed:Int;
    private var range:Float;

    public function new(xb:Float, yb:Float, xe:Float, ye:Float, duration:Float = 1, speed:Int = 1)
    {
        super(xb+2, yb);
        width = 15;
 		height = 15;
 		
        body = new Body(BodyType.KINEMATIC);
        var polygon = new Polygon(Polygon.rect(0, 0, width, height/4));
        body.shapes.add(polygon);
        body.position.setxy(x, y);
        body.allowRotation = false;

        sprite = new Spritemap("gfx/tileset.png", 16, 16);
        sprite.add("elevator", [11]);
        sprite.play("elevator");
        graphic = sprite;

        xStart = xb;
        yStart = yb;
        xEnding = xe;
        yEnding = ye;

        goingTowardsEnd = true;

        this.duration = duration;
        this.speed = speed;
        timer = 0;
        range = .5;
    }

    public override function update(){
    	super.update();
    	x = body.position.x;
    	y = body.position.y;
        move();
    }

    public function move(){
        if(waiting){
            timer += HXP.elapsed;
            if(timer >= duration){
                timer = 0;
                waiting = false;
            }else{
                return;
            }
        }
        var targetX:Float;
        var targetY:Float;
        if(goingTowardsEnd){
            targetX = xEnding;
            targetY = yEnding;
        }else{
            targetX = xStart;
            targetY = yStart;
        }
        var distX = targetX - x;
        var distY = targetY - y;
        var length = EMath.getLengthOfVector([distX, distY]);
        distX /= length;
        distY /= length;
        body.position.setxy(x + distX * speed, y + distY * speed);
        if(body.position.x + range >= targetX && body.position.x - range <= targetX && body.position.y + range >= targetY && body.position.y - range <= targetY){
            goingTowardsEnd = !goingTowardsEnd;
            waiting = true;
        }
    }
}