package entities;
 
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import nape.phys.Body;

class SpeechBubble extends Entity
{
	private var image:Image;
    var foreground:Image;
    var stroke:Image;
    var tail:Image;
    var dialogText:Text;
    var following:Body;
    var offsetX:Float;
    var offsetY:Float;
    var timer:Float;
    var duration:Int;

    public function new(width:Int, height:Int, text:String, following:Body, duration:Int, offsetX:Float = 7, offsetY:Float = -7)
    {
        super(following.position.x + offsetX, following.position.y + offsetY);

        stroke = Image.createRect(width, height, 0x999999);
        addGraphic(stroke);

        tail = Image.createRect(3, 4, 0x999999);
        tail.x = stroke.x + 2;
        tail.y = stroke.y + height;
        addGraphic(tail);

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

        this.following = following;
        this.offsetX = offsetX;
        this.offsetY = offsetY;

        this.duration = duration;
        timer = 0;

        layer = 0;
    }

    public override function update(){
    	super.update();
        timer += HXP.elapsed;
        if(timer <= duration){
            x = following.position.x + offsetX;
            y = following.position.y + offsetY;
        }else{
            scene.remove(this);
        }
    }
}