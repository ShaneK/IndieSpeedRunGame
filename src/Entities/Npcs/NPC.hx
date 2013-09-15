package entities.npcs;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
 
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Polygon;
import nape.geom.Vec2;
import nape.phys.Material;
 
class NPC extends PhysicalBody
{
    public function new(x:Float, y:Float, width:Int, height:Int)
    {
        super(x, y);
 		this.width = width;
 		this.height = height;
 		
        body = new Body();
        var polygon = new Polygon(Polygon.rect(0, 0, width, height));
        polygon.filter.collisionGroup = 2;
        body.shapes.add(polygon);
        body.position.setxy(x, y);
        body.setShapeMaterials(Material.steel());
        body.allowRotation = false;
    }

    public override function update(){
    	super.update();
    	x = body.position.x;
    	y = body.position.y;
    }
}