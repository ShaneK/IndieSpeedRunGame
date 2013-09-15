package entities.buttons;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.utils.Touch;
import classes.Settings;
 
class SettingsMenuButton extends Entity
{
    var clicked:Bool = false;

    public function new(x:Float, y:Float, w:Int, h:Int)
    {
        super(x, y);
        trace("TEST");

        width = w;
        height = h;
 
        var image = new Image("gfx/gears.png");
        image.scale = .03;
        image.relative = false;
        graphic = image;
  
        type = "button";
        layer = 1;
    }
 
    public override function update()
    {
        if(Settings.Paused) return;
        super.update();

        if(Input.multiTouchSupported){
            var touches:Map<Int,Touch> = Input.touches;
            if(Lambda.count(touches) > 0){
                for(elem in touches){
                    if (collideRect(elem.x, elem.y, x, y, width, height))
                    {
                        clicked = true;
                    }
                }
            }else if(clicked){
                action();
                clicked = false;
            }
        }else{
            if (collideRect(scene.mouseX, scene.mouseY, x, y, width, height))
            {   
               //Input.mouseCursor = MouseCursor.BUTTON;
               if (Input.mousePressed) clicked = true;
               if (clicked && Input.mouseReleased) action();
            }
        
            if (Input.mouseReleased) clicked = false;
        }
    }

    public function action(){
        Settings.Paused = true;
        scene.add(new entities.screens.SettingsMenu());
    }
}