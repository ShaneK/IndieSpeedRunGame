package entities;
 
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
 
import nape.phys.Body;
import nape.shape.Circle;
import nape.shape.Polygon;
import nape.geom.Vec2;
import nape.phys.Material;

class Circle extends PhysicalBody
{
	private var image:Image;
	private var radius:Int;

    public function new(x:Int, y:Int, r = 5, mass = 0.1)
    {
        super(x, y);
        radius = r;
        width = r*2;
        height = r*2;

        body = new Body(); // Implicit BodyType.DYNAMIC
        body.shapes.add(new nape.shape.Circle(radius));
        body.position.setxy(x, y);
        var mat = Material.rubber();
        body.setShapeMaterials(mat);
        body.mass = 10;
        body.inertia = 0.1;

        image = Image.createCircle(radius);
        graphic = image;

        type = "circle";
    }

    public override function update(){
    	super.update();
    	x = body.position.x - radius;
    	y = body.position.y - radius;
    	//image.angle = body.rotation; //Screws up spacing around circle
    }

    public function setXY(x:Int, y:Int){
    	body.position.setxy(x, y);
    }
}