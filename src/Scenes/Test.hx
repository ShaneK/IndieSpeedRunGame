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

import entities.WaterEmitter;
import entities.FireEmitter;
import com.haxepunk.Sfx;

class Test extends Scene
{
    private var space:Space;
    private var floor:Entity;
    private var floorBody:Body;
    private var dragging:entities.Circle;
    private var planetList:Array<PlanetBody>;
    private var samplePoint:Body;

    public function new()
    {
        super();

        var gravity:Vec2 = new Vec2(0, 300); // units are pixels/second/second
        space = new Space(gravity);

        createMap();

        var sfx = new Sfx("sfx/Intro.mp3");
        sfx.loop();

        var player = new entities.Player(450, 100);
        addObjectToSpace(player);

        // add(new WaterEmitter(500, 500, 490, 0, 10));
    }

    public function createMap()
    {
        // create the map, set the assets in your nmml file to bytes
        var e = new TmxEntity("maps/Level_1.tmx");
        e.loadGraphic("gfx/tileset.png", ["Bottom"]);

        var t = new TmxEntity("maps/Level_1.tmx");
        t.loadGraphic("gfx/tileset.png", ["Top"]);
        t.layer = 1;

        // loads a grid layer named collision and sets the entity type to walls
        var groundTiles = e.loadMask("Collision", "walls");

        //Water
        var waterTiles = e.loadMask("Water", "water");

        add(e);
        add(t);
        layGroundTiles(groundTiles);
        layWaterTiles(waterTiles);
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
            water.fluidProperties.viscosity = 5;
            var body = new Body(BodyType.STATIC); // Implicit BodyType.DYNAMIC
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
    }
}