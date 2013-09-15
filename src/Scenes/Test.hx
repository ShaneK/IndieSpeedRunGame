package scenes;

import com.haxepunk.Entity;
import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.tweens.motion.LinearMotion;
import com.haxepunk.Tween;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
 
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Polygon;
import nape.space.Space;
import nape.phys.Material;

import com.haxepunk.tmx.TmxEntity;
import com.haxepunk.tmx.TmxVec5;

import classes.PlanetBody;

import entities.npcs.Spawner;
import entities.emitters.WaterEmitter;
import entities.emitters.FireEmitter;
import entities.emitters.AirEmitter;
import entities.emitters.GroundEmitter;
import com.haxepunk.Sfx;

import classes.Settings;

class Test extends Scene
{
    private var space:Space;
    private var floor:Entity;
    private var floorBody:Body;
    private var dragging:entities.Circle;
    private var planetList:Array<PlanetBody>;
    private var samplePoint:Body;
    private var tmxEntity:TmxEntity;
    private var cameraOffset:Int = 5;
    private var cameraSpeed:Float = .5;
    private var freeCamera:Bool = true;
    private var heldCameraTime:Float = 0;
    private var slider:entities.Slider;

    private var spawners:Array<Spawner>;

    public function new()
    {
        super();

        HXP.screen.scale = 4;
        var bg = new entities.Background(0, 0);
        add(bg);

        var gravity:Vec2 = new Vec2(0, 300); // units are pixels/second/second
        space = new Space(gravity);
        Settings.Space = space;
        Settings.Scene = this;

        spawners = new Array<Spawner>();
        createMap();

         var sfx = new Sfx("sfx/haunted.mp3");
         sfx.loop();
         sfx.volume = .33;
         sfx.type = "MUSIC";

         
        // add(new WaterEmitter(500, 500, 490, 0, 10));
    }

    public override function begin(){
        for(spawner in spawners){
            spawner.spawn();
        }
        slider = new entities.Slider(0, 0, 55, 12, 8, Settings.MaxHealth, Settings.Health, 0x000000, 0xBB0000, 0xFFFFFF);
        add(slider);
    }

    public function followMe(){     
        if(freeCamera)         {
            var currentPos = HXP.camera;
            var newX = Settings.Player.x-(HXP.halfWidth);
            var newY = Settings.Player.y-(HXP.halfHeight);

            var xDiff = camera.x - newX;
            var yDiff = camera.y - newY;

            
            if(Math.abs(xDiff) > cameraOffset){
                HXP.camera.x += (xDiff < 0 ? cameraSpeed : -cameraSpeed) * (Math.abs(xDiff) * .1);
            }
            if(Math.abs(yDiff) > cameraOffset){
                HXP.camera.y += (yDiff < 0 ? cameraSpeed : -cameraSpeed) * (Math.abs(yDiff) * .1);
            }
        }
        if(!freeCamera){
            heldCameraTime -= HXP.elapsed;
        }

        if(!freeCamera && heldCameraTime <= 0){
            heldCameraTime =0;
            freeCamera = true;
        }
    }

    public function createMap()
    {
        // create the map, set the assets in your nmml file to bytes
        tmxEntity = new TmxEntity("maps/Level_1.tmx");
        tmxEntity.loadGraphic("gfx/tileset.png", ["Bottom", "Middle"]);

        var spawnTiles = tmxEntity.loadMask("PlayerSpawn", "p");
        for(spawnTile in spawnTiles){
            var spawnType = spawnTile.tileProperties.get("spawnType");
            switch (spawnType) {
                case 'player':
                    Settings.Player = new entities.Player(Std.int(spawnTile.x), Std.int(spawnTile.y));
                    addObjectToSpace(Settings.Player);
                case 'warrior': spawners.push(new Spawner(Std.int(spawnTile.x), Std.int(spawnTile.y), WARRIOR));   
                case 'farmer': spawners.push(new Spawner(Std.int(spawnTile.x), Std.int(spawnTile.y), FARMER));   
            }
        }

        var npc = new entities.npcs.Trainer(27*16, 18*16);
        addObjectToSpace(npc);
        add(new entities.SpeechBubble(110, 10, "Press up to talk to me", npc.getBody()));

        var t = new TmxEntity("maps/Level_1.tmx");
        t.loadGraphic("gfx/tileset.png", ["Top"]);
        t.layer = 1;

        // loads a grid layer named collision and sets the entity type to walls
        var groundTiles = tmxEntity.loadMask("Collision", "walls");

        //Water
        var waterTiles = tmxEntity.loadMask("Water", "water");

        add(tmxEntity);
        add(t);
        layGroundTiles(groundTiles);
        layWaterTiles(waterTiles);

        //Totems
        var totemMap = [
            "test1" => function(){ 
                add(new WaterEmitter(500, 500, 470, 0, 10));
             },
            "test2" => function(){ 
                add(new FireEmitter(30, 40, 510, 160, 10));
             },
            "test3" => function(){ 
                add(new AirEmitter(10, 100, 510, 80, 10, space));
             },
            "test4" => function(){ 
                add(new GroundEmitter(46*16, 9*16, space));
                add(new GroundEmitter(47*16, 8*16, space));
                add(new GroundEmitter(47*16, 9*16, space));
                add(new GroundEmitter(48*16, 9*16, space));
             },
            "earthbridge" => function(){
                
                freeCamera = false;
                HXP.camera.x = 129*16;
                HXP.camera.y = 17*16;
                heldCameraTime = 2;

                add(new GroundEmitter(133*16,20*16,space));
                add(new GroundEmitter(134*16,20*16,space));
                add(new GroundEmitter(135*16,20*16,space));
                add(new GroundEmitter(136*16,20*16,space));
                add(new GroundEmitter(137*16,20*16,space));
                add(new GroundEmitter(138*16,20*16,space));
                add(new GroundEmitter(139*16,20*16,space));               
            },
            "windlaunch" => function(){

                 add(new AirEmitter(10, 100, 233 * 16, 9 * 16, 10, space));
            }

        ];
        placeTotems(totemMap);
        placeHazards();
        placeElevators(6);
    }

    public function placeElevators(count:Int){
        for(i in 0...count){
            var beginningX:Float = 0;
            var beginningY:Float = 0;
            var endingX:Float = 0;
            var endingY:Float = 0;
            var elevatorTiles = tmxEntity.loadMask("Elevator_"+i, "elevator");
            for(elevator in elevatorTiles){
                if(elevator.tileProperties.exists("EndElevator")){
                    endingX = elevator.x;
                    endingY = elevator.y;
                }else{
                    beginningX = elevator.x;
                    beginningY = elevator.y;
                }
            }
            addObjectToSpace(new entities.Elevator(beginningX, beginningY, endingX, endingY));
        }
    }

    public function placeHazards(){
        var hazardTiles = tmxEntity.loadMask("Hazards", "hazard");
        for(hazard in hazardTiles){  
            if(hazard.tileProperties.exists("hazardType"))
            {
                var type = hazard.tileProperties.get("hazardType");
                switch (type) {
                    case "spikes": add(new entities.hazards.Spikes(hazard.x, hazard.y));
                    case "swamp": add(new entities.hazards.Swamp(hazard.x, hazard.y));
                    case "fire": add(new entities.hazards.Fire(hazard.x, hazard.y));
                }
            }
        }
    }

    public function placeTotems(totemMap:Map<String, Void->Void>){
        for(key in totemMap.keys()){
            var totemTiles = tmxEntity.loadMask("Totem_"+key, "totem");
            for(totem in totemTiles){
                add(new entities.interactive.Totem(totem.x, totem.y, totemMap[key]));
            }
        }
    }

    public function layGroundTiles(groundTiles:Array<TmxVec5>){
        //Loop through all the ground tiles and place a static body where they are
        for(groundTile in groundTiles){
            var body = new Body(BodyType.STATIC); // Implicit BodyType.DYNAMIC
            body.shapes.add(new Polygon(Polygon.rect(0, groundTile.top, groundTile.width, groundTile.height)));
            body.position.setxy(groundTile.x, groundTile.y);
            body.setShapeMaterials(Material.sand());
            space.bodies.add(body);
        }
    }

    public function layWaterTiles(waterTiles:Array<TmxVec5>){
        //Loop through all the ground tiles and place a static body where they are
        for(waterTile in waterTiles){
            var water = new Polygon(Polygon.rect(0, waterTile.top, waterTile.width, waterTile.height));
            water.fluidEnabled = true;
            water.fluidProperties.density = 3;
            water.fluidProperties.viscosity = 25;
            var body = new Body(BodyType.STATIC);
            body.shapes.add(water);
            body.position.setxy(waterTile.x, waterTile.y);
            water.body = body;
            space.bodies.add(body);
        }
    }
    
    public function addObjectToSpace(e:entities.PhysicalBody){
        add(e);
        var body = e.getBody();
        space.bodies.add(body);
    }
 
    public override function update()
    {        
        super.update();
        slider.updateSlider(Settings.Health);
        if(HXP.elapsed > 0){
            space.step(HXP.elapsed);
        }

        followMe();
    }
}