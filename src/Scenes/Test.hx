package scenes;

import com.haxepunk.Entity;
import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
 
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Circle;
import nape.shape.Polygon;
import nape.space.Space;
import nape.util.BitmapDebug;
import nape.util.Debug;
import nape.phys.Material;
import nape.geom.Geom;

import com.haxepunk.tmx.TmxEntity;
import com.haxepunk.tmx.TmxVec5;

import classes.PlanetBody;

import entities.emitters.WaterEmitter;
import entities.emitters.FireEmitter;
import entities.emitters.AirEmitter;
import entities.emitters.GroundEmitter;
import com.haxepunk.Sfx;

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

    private var player:entities.PhysicalBody;

    public function new()
    {
        super();

        var bg = new entities.Background(0, 0);
        add(bg);

        var gravity:Vec2 = new Vec2(0, 300); // units are pixels/second/second
        space = new Space(gravity);

        createMap();

        var sfx = new Sfx("sfx/haunted.mp3");
        sfx.loop();

        // add(new WaterEmitter(500, 500, 490, 0, 10));
    }

    public function followMe(){              
        var currentPos = HXP.camera;
        var newX = player.x-(HXP.halfWidth);
        var newY = player.y-(HXP.halfHeight);

        var xDiff = camera.x - newX;
        var yDiff = camera.y - newY;
        
        if(Math.abs(xDiff) > cameraOffset){
            HXP.camera.x += (xDiff < 0 ? cameraSpeed : -cameraSpeed) * (Math.abs(xDiff) * .1);
        }
        if(Math.abs(yDiff) > cameraOffset){
            HXP.camera.y += (yDiff < 0 ? cameraSpeed : -cameraSpeed) * (Math.abs(yDiff) * .1);
        }

        //HXP.setCamera(newX, newY);        
    }

    public function createMap()
    {
        // create the map, set the assets in your nmml file to bytes
        tmxEntity = new TmxEntity("maps/Level_1.tmx");
        tmxEntity.loadGraphic("gfx/tileset.png", ["Bottom", "Middle"]);

        var playerTiles = tmxEntity.loadMask("PlayerSpawn", "p");
        for(playerSpawn in playerTiles){
            player = new entities.Player(Std.int(playerSpawn.x), Std.int(playerSpawn.y));
            addObjectToSpace(player);

            add(new entities.SpeechBubble(60, 10, "Test", player.getBody(), 3));
        }

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
             }
        ];
        placeTotems(totemMap);
    }

    public function placeTotems(totemMap:Map<String, Void->Void>){
        for(key in totemMap.keys()){
            var totemTiles = tmxEntity.loadMask("Totem_"+key, "totem");
            for(totem in totemTiles){
                add(new entities.Totem(totem.x, totem.y, totemMap[key]));
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

    public override function begin()
    {
        HXP.setCamera(400, 50);
    }
 
    public override function update()
    {        
        if(HXP.elapsed > 0){
            space.step(HXP.elapsed);
        }
        super.update();
        followMe();
    }
}