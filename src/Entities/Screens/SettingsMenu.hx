package entities.screens;
 
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.Graphic;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.utils.Touch;
import classes.Settings;
import com.haxepunk.graphics.Text;
import com.haxepunk.utils.Data;

class SettingsMenu extends Entity
{
	var clicked:Bool = false;
    var touched:Bool = false;
	var submenu:Graphic;
    var mute:Graphic;
    var muteChecked:Graphic;
    var menuWidth:Int;
    var menuHeight:Int;
    var firstTouch:Touch;
    var muteBackgroundWidth:Int;
    var muteBackgroundHeight:Int;

    public function new()
    {
        super(0,0);

        var w = Std.int(HXP.width/4);
        var h = Std.int(HXP.height/4);
        var halfHeight = Std.int(h/2);
        var halfWidth = Std.int(w/2);

        graphic = Image.createRect(w, h, 0x000000, .5);

        // menuWidth = Math.floor(w*.7);
        // menuHeight = Math.floor(h *.6);
        // var submenuBackground:Graphic = addGraphic(Image.createRect(menuWidth+6, menuHeight+6, 0x444444));
        // submenuBackground.x = (halfWidth) - (menuWidth+6)/2;
        // submenuBackground.y = (halfHeight) - (menuHeight+6)/2;

        // submenu = addGraphic(Image.createRect(menuWidth, menuHeight, 0x555555));
        // submenu.x = (halfWidth) - menuWidth/2;
        // submenu.y = (halfHeight) - menuHeight/2;

        // muteBackgroundWidth = 16;
        // muteBackgroundHeight = 16;
        // var muteBackground:Graphic = addGraphic(Image.createRect(muteBackgroundWidth, muteBackgroundHeight, 0x000000));
        // muteBackground.x = Math.floor(submenu.x + menuWidth*.7) - 2.5;
        // muteBackground.y = Math.floor(submenu.y + menuHeight*.2) - 2.5;

        // mute = addGraphic(Image.createRect(muteBackgroundWidth - 4, muteBackgroundHeight -4, 0xFFFFFF));
        // mute.x = muteBackground.x + 2;
        // mute.y = muteBackground.y + 2;

        // muteChecked = addGraphic(Image.createRect(Math.floor((muteBackgroundWidth-4)/2),Math.floor((muteBackgroundHeight-4)/2),0x000000));
        // var offset:Int = Math.floor((muteBackgroundWidth-4)/4);
        // muteChecked.x = mute.x + offset;
        // muteChecked.y = mute.y + offset;

        // var soundText:Text = new Text("Sound FX");
        // soundText.size = 8;
        // soundText.x = submenu.x + menuWidth * .2;
        // soundText.y = muteBackground.y + (muteBackgroundHeight/2) - soundText.textHeight/2;
        // addGraphic(soundText);

        // var titleText:Text = new Text("Settings");
        // titleText.x = submenu.x + (menuWidth * .5) - titleText.width;
        // titleText.y = submenu.y + titleText.height - 10;
        // titleText.size = 8;
        // addGraphic(titleText);


        layer = 0;
        type = "menu";
    }

    public override function update(){
     //    muteChecked.visible = !Settings.SfxMuted;

     //    var touches:Map<Int,Touch> = Input.touches;
    	// if(Input.mousePressed){
    	// 	clicked = true;
    	// }else if(Lambda.count(touches) > 0){
     //        touched = true;
     //        firstTouch = touches[0];
     //    }else if(clicked || touched){
     //        var clickedX:Float = clicked ? scene.mouseX : firstTouch.x;
     //        var clickedY:Float = clicked ? scene.mouseY : firstTouch.y;

     //        if(!collideRect(clickedX, clickedY, submenu.x, submenu.y, menuWidth, menuHeight)){
     //          resumeGame();
     //        }else{
     //            if(collideRect(clickedX, clickedY, mute.x, mute.y, muteBackgroundWidth, muteBackgroundHeight)){
     //                Settings.SfxMuted = !Settings.SfxMuted;
     //            }
     //        }
     //        clicked = false;
     //        touched = false;
     //    }
    }

    public function saveAllSettings(){
        Data.write("sfxmuted", Settings.SfxMuted);
        Data.save("settings", true);
    }

    public function resumeGame(){
        saveAllSettings();
		Settings.Paused = false;
		scene.remove(this);
    }
}