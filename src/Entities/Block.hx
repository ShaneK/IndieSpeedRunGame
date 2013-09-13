package entities;
 
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
 
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Polygon;
import nape.geom.Vec2;
import nape.phys.Material;
 
class Block extends PhysicalBody
{
	private var image:Image;

    public function new(x:Int, y:Int, w:Int = 40, h:Int = 40)
    {
        super(x, y);
 		width = w;
 		height = h;
 		
        body = new Body(BodyType.STATIC); // Implicit BodyType.DYNAMIC
        body.shapes.add(new Polygon(Polygon.rect(0, 0, width, height)));
        body.position.setxy(x, y);
        body.setShapeMaterials(Material.steel());

        image = Image.createRect(width,height, 0xFF0000);
        graphic = image;
    }

    public override function update(){
    	super.update();
    	x = body.position.x;
    	y = body.position.y;
    	image.angle = body.rotation;
    }
}