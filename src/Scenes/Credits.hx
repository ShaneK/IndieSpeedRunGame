package scenes;


import com.haxepunk.Entity;
import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Input;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;

import utils.TextUtils;

class Credits extends Scene
{
    var createdText:Text;
    var shaneText:Text;
    var calebText:Text;
    var benText:Text;

    public function new()
    {
        super();        
    }

    public override function begin()
    {       
        var screen = HXP.screen;
        screen.color = 0x000000;
        screen.scale = 1;
        createdText = buildCreditsTest("Created By:",screen.width/2,20);
        shaneText = buildCreditsTest("Programming: Shane King",20,100);
        calebText = buildCreditsTest("Music / Level Design: Caleb Creed",20,200);
        benText = buildCreditsTest("Art / Programming: Ben Van Treese",20,300);
        HXP.setCamera(0,0);

        super.begin();
    }
 
    public override function update()
    {
        var createdIsFaded = TextUtils.fadeInText(createdText);
        if(createdIsFaded){
            var shaneFaded = TextUtils.fadeInText(shaneText);
            if(shaneFaded){
                var calebFaded = TextUtils.fadeInText(calebText);
                if(calebFaded){
                    TextUtils.fadeInText(benText);
                }
            }
        }
        super.update();
        CheckInput();
    }

    private function CheckInput(){
        if(Input.check("exit")){
            super.end();
            HXP.scene = new MainMenu();
        }
    }
    
    private function buildCreditsTest(string:String,x:Float,y:Float):Text{
        var text = new Text(string);
        text.size = 32;
        text.x = x;
        text.y = y;
        text.color = 0x000000;
        addGraphic(text);

        return text;
    } 
}