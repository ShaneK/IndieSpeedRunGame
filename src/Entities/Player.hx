package entities;
 
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.utils.Input;
import com.haxepunk.Sfx;

import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Polygon;
import nape.shape.Circle;
import nape.geom.Vec2;
import nape.phys.Material;

import classes.EMath;
import classes.Settings;
 
class Player extends PhysicalBody
{
	private var image:Image;
    private var velocityX:Float = 0;
    private var velocityY:Float = 0;
    private var sprite:Spritemap;
    private var jumpSnd:Sfx;
    private var landSnd:Sfx;
    private var atkSnd:Sfx;
    private var goingLeft:Bool;
    private var ignoreInput:Bool = false;
    
    
    //Leveling up related
    private var levelingUp:Bool = false;
    private var levelUpTimeout:Float = 0;

#if debug
    var maximumSpeed = 10000;
    var jumpAmount = 410;
#else
    var maximumSpeed = 75;
    var jumpAmount = 110;
#end
    var jumpVelocity = 0;
    var isFalling = false;

    public function new(x:Int, y:Int)
    {
        super(x, y);
 		width = 12;
 		height = 24;

        body = new Body(); // Implicit BodyType.DYNAMIC
        //var polygon = new Polygon(Polygon.rect(0, 0, width, height));
        var polygon = new Circle(width/2, new Vec2(width/2,18));
        polygon.filter.collisionMask = ~2;
        body.shapes.add(polygon);
        body.position.setxy(x, y-16);
        body.setShapeMaterials(new Material(0.0, .8, .0001));
        body.allowRotation = false;
        body.mass = 25;

        sprite = new Spritemap("gfx/player.png", 32, 64);        
        sprite.add("idle", [0]);        
        sprite.add("walk", [1, 2, 3, 4, 5], 8, true);
        sprite.add("run", [1, 2, 3, 4, 5], 12, true);
        sprite.add("jump", [19]);
        sprite.add("attack", [24,25,26],8);
        sprite.scaledWidth = width;
        sprite.scaledHeight = height;
        sprite.play("idle");

        goingLeft = false;
        
        jumpSnd = new Sfx('sfx/SFX/Jump.mp3');
        landSnd = new Sfx('sfx/SFX/Land.mp3');
        atkSnd = new Sfx('sfx/SFX/Hurt1.mp3');

        graphic = sprite;        
        layer = 2;
        type = "player";
    }

    public override function update(){
        super.update();
        if(!levelingUp){
            velocityX = 0;
        	x = body.position.x;
        	y = body.position.y;
            if(!ignoreInput){
                handleInput();
            }
            velocityManagement();
            setAnimations();
            watchHealth();
            if(y > 880){
                damage(Settings.Health);
            }
        }else{
            levelUpAnimation();
        }
    }

    public function handleInput(){         
        var speed = maximumSpeed * .5;
        if(Input.check("run")){
            speed = maximumSpeed;
        }else{
#if debug
            speed = maximumSpeed * .01;
#end
        }
        if (Input.check("left"))
        {
            velocityX += speed;
        } 
        
        if (Input.check("right"))
        {
            velocityX -= speed;
        }

        if(Input.check("attack")){
            attack();
        }

        if(Input.check('jump') && isOnGround()){
            jumpVelocity = jumpAmount;            
            jumpSnd.play();
        }
        else{
            jumpVelocity = 0;    
        }
        
    }

    private function isOnGround():Bool{
        return body.interactingBodies(nape.callbacks.InteractionType.COLLISION).length != 0;
    }

     private function setAnimations()
     {
        if(atkSnd.playing){
            return;
        }
        if (body.velocity.x > 10 || body.velocity.x < -10)
        {
            goingLeft = body.velocity.x <= 0;
            Input.check('run') ? sprite.play("run") : sprite.play("walk");
            sprite.flipped = goingLeft;
        }
        else
        {
            sprite.play("idle");
        }

        if(!isOnGround()){
            sprite.play("jump");
            isFalling = true;
        }

        if(isOnGround() && isFalling){
            isFalling = false;
            landSnd.play();
        }
     }

    public function velocityManagement(){        
        body.kinematicVel.x = EMath.clamp(velocityX, -maximumSpeed, maximumSpeed);
        if(!isOnGround()){
            body.velocity.x -= EMath.clamp(velocityX * 2 * HXP.elapsed, -maximumSpeed, maximumSpeed);
        }
        body.kinematicVel.y = jumpVelocity;
    }

    public function damage(howMuch:Int){
        Settings.Health -= howMuch;
    }

    public function attack(){
        if(!atkSnd.playing){
            var centerX = x + width/2;
            var centerY = y;// - height/2;

            var attackDir = goingLeft ? -6 : 6;

            var entityHit = scene.collideRect("other-tribe",centerX +attackDir ,y + 8, 1, 1);
            if(entityHit != null){
                var npc = cast(entityHit, entities.npcs.NPC);
                npc.onAttacked();
            }
            atkSnd.play();      
            sprite.play("attack");      
        }
    }

    public function levelUp(){
        if(!levelingUp){
            Settings.Level += 1;
            ignoreInput = true;
            levelingUp = true;
        }
    }

    public function levelUpAnimation(){
        levelUpTimeout += HXP.elapsed;
        if(levelUpTimeout <= .2){

        }else{
            levelingUp = false;
            levelUpTimeout = 0;
            ignoreInput = false;
            HXP.scene = Settings.getNextScene(Settings.Level);
        }
    }

    public function watchHealth(){
        if(Settings.Health <= 0){
            if(Settings.Level == 1){
                Settings.Health = Settings.MaxHealth;
                body.position.setxy(112*16, 32*16);
                return;
            }
            Settings.sfx.stop();
            HXP.scene = new scenes.Credits();
        }
    }
}