package entities;
 
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Backdrop;

class Background extends Entity
{
	private var image:Backdrop;

    public function new(x:Int, y:Int)
    {
        super(x, y);
        image = new Backdrop("gfx/background.png", true, false);
        graphic = image;
        layer = 10000;
    }

    public override function update(){
    	super.update();
    }
}