package scenes;


import com.haxepunk.Entity;
import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.Sfx;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Input;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;

import utils.TextUtils;

import classes.Settings;

#if flash
import flash.system.System;
#end

class MainMenu extends Scene
{
    var doText:Text;
    var noText:Text;
    var harmText:Text;
    var playText:Text;

    public var ready:Bool = false;
    var fade:Bool = false;

    public function new()
    {
        super();        
    }

    public override function begin()
    {        
        if(Settings.sfx != null){
            Settings.sfx.stop();
        }
        Settings.sfx = new Sfx("sfx/Intro.mp3");
        Settings.sfx.loop();
        Settings.sfx.type = "MUSIC";

        var screen = HXP.screen;
        screen.color = 0x000000;
        screen.scale = 1;

        doText = buildIntroText("DO",(screen.width/2) + 128,20);
        noText = buildIntroText("NO",(screen.width/2) + 128,120);
        harmText = buildIntroText("HARM",(screen.width/2) + 128,220);

        playText = new Text("Press 'ENTER' to play.");
        playText.size = 64;
        playText.x = (screen.width/2) - 320;
        playText.y = screen.height - 128;
        playText.color = 0x000000;
        addGraphic(playText);
        HXP.setCamera(0,0);

        super.begin();
    }
 
    public override function update()
    {
        var doIsFaded = TextUtils.fadeInText(doText);
        if(doIsFaded && !ready){
            var noIsFaded = TextUtils.fadeInText(noText);
            if(noIsFaded){
                var harmIsFaded = TextUtils.fadeInText(harmText);
                if(harmIsFaded){
                    var playIsFaded = TextUtils.fadeInText(playText);
                    if(playIsFaded){
                        ready = true;
                    }
                }
            }
        }

        if(ready){
            blinkText(playText);
        }
        super.update();
        CheckInput();
    }

private function CheckInput(){
        if(Input.check("start") && ready){
            Settings.restoreDefault();
            HXP.scene = new Tutorial();
            super.end();
        }
        if(Input.check("credits") && ready){            
            Settings.sfx.stop();
            HXP.scene = new Credits();
            super.end();
        }
        if(Input.check("exit")){
            Settings.sfx.stop();
            super.end();
            #if cpp
            Sys.exit(0);
            #elseif flash
            System.exit(0);
            #end            
        }
    }
    
    private function buildIntroText(string:String,x:Float,y:Float):Text{
        var text = new Text(string);
        text.size = 128;
        text.x = x;
        text.y = y;
        text.color = 0x000000;
        addGraphic(text);

        return text;
    }

    private function blinkText(text:Text):Void{
        if(text.color >= 0xCCCCCC && fade){
            text.color -= 0x020202;
            fade = true;
        }else{
            fade = false;
            text.color += 0x020202;
        }
    }
}