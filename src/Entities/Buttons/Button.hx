package entities.buttons;
 
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.utils.Touch;
import com.haxepunk.graphics.Text;
 
 import classes.Settings;

class Button extends Entity
{
    var clicked:Bool = false;
    var touched:Bool = false;
    var buttonStroke:Image;
    var buttonForeground:Image;
    var buttonText:Text;
    var preservedTouches:Map<Int,Touch>;
    var vis:Bool;
    var w:Int;
    var h:Int;
    var hitThisFrame:Bool;
 
    public function new(x:Float, y:Float, width:Int, height:Int, text:String, visible:Bool = true)
    {
        super(x, y);
 
        if(visible){
            buttonStroke = Image.createRect(width, height, 0x999999);
            addGraphic(buttonStroke);
     
            buttonForeground = Image.createRect(width-4, height-4, 0xDDDDDD);
            buttonForeground.x = buttonStroke.x + 2;
            buttonForeground.y = buttonStroke.y + 2;
            addGraphic(buttonForeground);

            buttonText = new Text(text);
            buttonText.size = Settings.TextSize;
            buttonText.x = buttonForeground.x + (buttonForeground.width/2) - buttonText.textWidth*.5;
            buttonText.y = buttonForeground.y + (buttonForeground.scaledHeight/2) - buttonText.textHeight*.5;
            buttonText.color = 0x000000;
            addGraphic(buttonText);
        }

        this.vis = visible;
        this.w = width;
        this.h = height;
  
        type = "button";
        layer = 0;
    }
 
    public override function update()
    {
        super.update();
        hitThisFrame = false;
        var touches:Map<Int,Touch> = Input.touches;
        if(Lambda.count(touches) > 0){
            preservedTouches = touches;
            touched = true;
            for(elem in preservedTouches){
                if(hit(elem.x + HXP.camera.x, elem.y + HXP.camera.y)){
                    hitThisFrame = true;
                    goActive();
                    onClick();
                }else{
                    goInactive();
                }
            }
            if(!hitThisFrame){
                onRelease();
                goInactive();
                touched = false;
            }
        }else if(Input.mouseDown){
            clicked = true;
            if(hit(scene.mouseX, scene.mouseY)){
                goActive();
                onClick();
            }else{
                goInactive();
            }
        }else if(clicked && Input.mouseReleased){
            if(hit(scene.mouseX, scene.mouseY)){
                onRelease();
            }
            goInactive();
            clicked = false;
        }else if(touched){
            onRelease();
            goInactive();
            touched = false;
        }
    }
 
    public function onRelease(){
        //Do nothing
        //Need to override onRelease method
    }
 
    public function onClick(){
        //Do nothing
        //Need to override onClick method
    }
 
    public function goActive(){
        if(!vis) return;

        //Before X and Y
        var beforeX:Float = buttonStroke.scaledWidth;
        var beforeY:Float = buttonStroke.scaledHeight;
        //Button background
        buttonStroke.color = 0x777777;
        buttonStroke.scaleX = 1.04;
        buttonStroke.scaleY = 1.3;
        //After X and Y
        var afterX:Float = buttonStroke.scaledWidth;
        var afterY:Float = buttonStroke.scaledHeight;
        //Button foreground
        buttonForeground.color = 0xBBBBBB;
        buttonForeground.scaleX = 1.04;
        buttonForeground.scaleY = 1.3;
 
        buttonStroke.x -= (afterX-beforeX)/2;
        buttonForeground.x -= (afterX-beforeX)/2;
 
        buttonStroke.y -= (afterY-beforeY)/2;
        buttonForeground.y -= (afterY-beforeY)/2;
 
        //Button text
        buttonText.size = Settings.TextSize;
        buttonText.x = buttonForeground.x + (buttonForeground.scaledWidth/2) - buttonText.textWidth*.5;
        buttonText.y = buttonForeground.y + (buttonForeground.scaledHeight/2) - buttonText.textHeight*.5;
    }
 
    public function goInactive(){
        if(!vis) return;
        //Before X and Y
        var beforeX:Float = buttonStroke.scaledWidth;
        var beforeY:Float = buttonStroke.scaledHeight;
        //Button background
        buttonStroke.color = 0x999999;
        buttonStroke.scaleX = 1;
        buttonStroke.scaleY = 1;
        //After X and Y
        var afterX:Float = buttonStroke.scaledWidth;
        var afterY:Float = buttonStroke.scaledHeight;
        //Button foreground
        buttonForeground.color = 0xDDDDDD;
        buttonForeground.scaleX = 1;
        buttonForeground.scaleY = 1;
 
        buttonStroke.x += (beforeX-afterX)/2;
        buttonForeground.x += (beforeX-afterX)/2;
 
        buttonStroke.y += (beforeY-afterY)/2;
        buttonForeground.y += (beforeY-afterY)/2;
 
        //Button text
        buttonText.size = Settings.TextSize;
        buttonText.x = buttonForeground.x + (buttonForeground.scaledWidth/2) - buttonText.textWidth*.5;
        buttonText.y = buttonForeground.y + (buttonForeground.scaledHeight/2) - buttonText.textHeight*.5;
    }
 
    public function hit(rX:Float, rY:Float){
        if(vis){
            return collideRect(rX, rY, x, y, buttonStroke.scaledWidth, buttonStroke.scaledHeight);
        }else{
            return collideRect(rX, rY, x, y, w, h);
        }
    }
}