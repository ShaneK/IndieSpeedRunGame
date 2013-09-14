package entities;
 
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
 
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Polygon;
import nape.geom.Vec2;
import nape.phys.Material;
import com.haxepunk.graphics.Spritemap;
 
class Block extends PhysicalBody
{
    public function new(x:Float, y:Float)
    {
        super(x, y+2);
 		width = 16;
 		height = 16;
 		
        body = new Body(BodyType.STATIC); // Implicit BodyType.DYNAMIC
        body.shapes.add(new Polygon(Polygon.rect(0, 0, width, height)));
        body.position.setxy(x, y);
        body.setShapeMaterials(Material.steel());
        body.allowRotation = false;

        var sprite = new Spritemap("gfx/tileset.png", 16, 16);
        sprite.add("stone", [20]);
        sprite.play("stone");
        graphic = sprite;
    }

    public override function update(){
    	super.update();
    	x = body.position.x;
    	y = body.position.y;
    }
}