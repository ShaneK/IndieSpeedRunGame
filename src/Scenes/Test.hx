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

        // var floor = new entities.Block(0, HXP.height, HXP.width, 1);
        // addObjectToSpace(floor);

        // var leftWall = new entities.Block(-1, 0, 1, HXP.height);
        // addObjectToSpace(leftWall);

        // var rightWall = new entities.Block(HXP.width+1, 0, 1, HXP.height);
        // addObjectToSpace(rightWall);

        // for(i in 0...150){
        //     var circle = new entities.Circle(Math.floor(HXP.width * HXP.random), Math.floor(HXP.height * HXP.random), Math.ceil(15*HXP.random), Math.ceil(5*HXP.random));
        //     addObjectToSpace(circle);
        // }

        var player = new entities.Player(600, 200);
        addObjectToSpace(player);
    }

    public function createMap()
    {
        // create the map, set the assets in your nmml file to bytes
        var e = new TmxEntity("maps/Level_2.tmx");

        // load layers named bottom, main, top with the appropriate tileset
        e.loadGraphic("gfx/tiles_spritesheet.png", ["Middle", "Top"]);

        // loads a grid layer named collision and sets the entity type to walls
        var groundTiles = e.loadMask("collision", "walls");

        //Water
        var waterTiles = e.loadMask("water", "water");

        //Gravity opjects
        var planets = e.loadMask("gravityObjects", "planets");

        add(e);
        layGroundTiles(groundTiles);
        layWaterTiles(waterTiles);
        placePlanets(planets);
    }

    public function placePlanets(planets:Array<TmxVec5>){
        if(planets.length > 0){
            samplePoint = new Body();
            samplePoint.shapes.add(new Circle(0.001));
            for(planet in planets){
                //Do something
                var body = new Body(BodyType.STATIC); // Implicit BodyType.DYNAMIC
                body.shapes.add(new Polygon(Polygon.rect(0, planet.top, planet.width, planet.height)));
                body.position.setxy(planet.x, planet.y);
                body.setShapeMaterials(Material.sand());
                space.bodies.add(body);
                if(planetList == null){
                    planetList = new Array<PlanetBody>();
                }
                planetList.push(new PlanetBody(body, planet.x, planet.y, planet.width, planet.height));
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

    }
 
    public override function update()
    {
        if(HXP.elapsed > 0){
            planetGravity();
            space.step(HXP.elapsed);
        }
        handleClickingAndDraggingCircles();
        super.update();
    }

    public function planetGravity(){
        if(planetList.length > 0 && HXP.elapsed > 0){
            for(planet in planetList){
                var closestA = Vec2.get();
                var closestB = Vec2.get();
         
                for (body in space.liveBodies) {
                    // Find closest points between bodies.
                    samplePoint.position.set(body.position);
                    var distance = Geom.distanceBody(planet.body, samplePoint, closestA, closestB);
                    // Cut gravity off, well before distance threshold.
                    if (distance > 300) {
                        continue;
                    }
         
                    // Gravitational force.
                    var force = closestA.sub(body.position, true);
         
                    // We don't use a true description of gravity, as it doesn't 'play' as nice.
                    force.length = 15 * 1e6 / (distance * distance);
         
                    // Impulse to be applied = force * deltaTime
                    body.applyImpulse(force.muleq(HXP.elapsed), null, true);
                }
         
                closestA.dispose();
                closestB.dispose();
            }
        }
    }

    public function handleClickingAndDraggingCircles()
    {
        if(Input.mousePressed){
            var collision = collidePoint("circle", Input.mouseX, Input.mouseY);
            if(collision != null){
                var circle = cast(collision, entities.Circle);
                dragging = circle;
            }else{
                var circle = new entities.Circle(Math.floor(Input.mouseX), Math.floor(Input.mouseY), 10, 1);
                var body = circle.getBody();
                addObjectToSpace(circle);
                dragging = circle;
            }
        }

        if(dragging != null){
            dragging.setXY(Input.mouseX, Input.mouseY);
        }

        if(Input.mouseReleased){
            dragging = null;
        }
    }
 
}