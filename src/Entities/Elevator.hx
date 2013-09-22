package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Spritemap;
 
import com.haxepunk.HXP;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Polygon;
import nape.geom.Vec2;
import nape.phys.Material;
import nape.callbacks.CbType;

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
    private var distX:Float;
    private var distY:Float;
    private var targetX:Float;
    private var targetY:Float;

    public function new(xb:Float, yb:Float, xe:Float, ye:Float, cbType:CbType)
    {
        super(xb+2, yb);
        width = 64;
 		height = 1;
 		
        body = new Body(BodyType.KINEMATIC);
        var polygon = new Polygon(Polygon.rect(0, 0, width, height));
        body.shapes.add(polygon);
        body.position.setxy(x, y);
        body.allowRotation = false;
        body.cbTypes.add(cbType);

        sprite = new Spritemap("gfx/tileset.png", 64, 64);
        sprite.add("elevator", [11]);
        sprite.play("elevator");
        graphic = sprite;

        xStart = xb;
        yStart = yb;
        xEnding = xe;
        yEnding = ye;

        this.duration = 1;
        this.speed = 2;
        timer = 0;
        range = .5;

        goingTowardsEnd = false;
        changeDirection(); //Calculates distance normalization
    }

    public override function update(){
    	super.update();
    	x = body.position.x;
    	y = body.position.y;
        move();
    }

    public function movePlayer(xi:Float, yi:Float){
        var player = scene.collideRect("player", x, y-32, 64, 32);
        if(player == null) return;
        var p = cast(player, PhysicalBody);
        var body = p.getBody();
        if(body.position.y+100 > y-yi) return;
        body.position.x += xi;
        body.position.y += yi;
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
        body.position.setxy(x + distX * speed, y + distY * speed);
        movePlayer(distX*speed, distY*speed);
        if(body.position.x + range >= targetX && body.position.x - range <= targetX && body.position.y + range >= targetY && body.position.y - range <= targetY){
            waiting = true;
            changeDirection();
        }
    }

    public function changeDirection(){
        goingTowardsEnd = !goingTowardsEnd;
        if(goingTowardsEnd){
            targetX = xEnding;
            targetY = yEnding;
        }else{
            targetX = xStart;
            targetY = yStart;
        }
        distX = targetX - x;
        distY = targetY - y;
        var length = EMath.getLengthOfVector([distX, distY]);
        distX /= length;
        distY /= length;
    }
}