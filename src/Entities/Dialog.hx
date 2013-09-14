package entities;
 
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;

class Dialog extends Entity
{
	private var image:Image;
    var foreground:Image;
    var stroke:Image;
    var dialogText:Text;

    public function new(x:Int, y:Int, width:Int, height:Int, text:String)
    {
        super(x, y);

        stroke = Image.createRect(width, height, 0x999999);
        addGraphic(stroke);

        foreground = Image.createRect(width-2, height-2, 0xDDDDDD);
        foreground.x = stroke.x + 1;
        foreground.y = stroke.y + 1;
        addGraphic(foreground);

        dialogText = new Text(text);
        dialogText.size = 8;
        dialogText.x = foreground.x + (foreground.width/2) - dialogText.textWidth*.5;
        dialogText.y = foreground.y + (foreground.scaledHeight/2) - dialogText.textHeight*.5;
        dialogText.color = 0x000000;
        addGraphic(dialogText);

        layer = 0;
    }

    public override function update(){
    	super.update();
    }
}