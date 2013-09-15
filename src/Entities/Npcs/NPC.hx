package entities.npcs;

import classes.EMath;
import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
 
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Circle;
import nape.geom.Vec2;
import nape.phys.Material;
 
class NPC extends PhysicalBody
{
    var startX:Float;
    var timer:Float = 0;
    var randTimer:Float = 0;
    var direction:Int = 1;
    var speed:Float = 500;

    public function new(x:Float, y:Float, width:Int, height:Int)
    {
        startX = x;
        super(x, y);
 		this.width = width;
 		this.height = height;
 		
        body = new Body();
        var polygon = new Circle(width/2, new Vec2(width/2,18));
        polygon.filter.collisionGroup = 2;
        body.shapes.add(polygon);
        body.position.setxy(x, y-height);
        body.setShapeMaterials(Material.steel());
        body.allowRotation = false;
    }

    public override function update(){
    	super.update();
    	x = body.position.x;
    	y = body.position.y;
    }

    public function wander(dist:Float = 16){
        var distFromStart = Math.abs(startX - body.position.x);
        timer += HXP.elapsed;
        randTimer += HXP.elapsed;
        if(timer > 1.5 && distFromStart >= dist){
            direction = -direction;
            body.kinematicVel.x = 0;    
            timer = 0;
        }

        if(randTimer > 3){
            direction = EMath.randomSignWithZero();
            randTimer = 0;
        }
        body.kinematicVel.x = direction * speed * HXP.elapsed;            
    }
}