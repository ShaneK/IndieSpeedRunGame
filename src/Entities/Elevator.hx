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

    public function new(xb:Float, yb:Float, xe:Float, ye:Float)
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

        xStart = xe;
        yStart = ye;
        xEnding = xe;
        yEnding = ye;

        goingTowardsEnd = true;
    }

    public override function update(){
    	super.update();
    	x = body.position.x;
    	y = body.position.y;
        move();
    }

    public function move(){
        var distX:Float;
        var distY:Float;
        var speed = .2;
        if(goingTowardsEnd){
            distX = xEnding - x;
            distY = yEnding - y;
        }else{
            distX = xStart - x;
            distY = yStart - y;
        }
        var length = EMath.getLengthOfVector([distX, distY]);
        distX /= length;
        distY /= length;

        // var force = Vec2.get(x, y);
        // var t = force.sub(Vec2.get(xEnding, yEnding));
        // t.length = 1000 * 1e10;
        body.position.setxy(x + distX * speed, y + distY * speed);
        // if(body.position.x )
    }
}