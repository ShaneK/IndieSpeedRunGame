package scenes;

import classes.Settings;
import com.haxepunk.Entity;
import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import com.haxepunk.Sfx;

import utils.TextUtils;

class Credits extends Scene
{
    var thingText:Text;
    var createdText:Text;
    var shaneText:Text;
    var calebText:Text;
    var benText:Text;
    var scoreKillsText:Text;
    var scoreAttacksText:Text;
    var scoreStealsText:Text;
    var scoreStatusText:Text;
    var returnText:Text;
    private var hit:Bool = false;
    private var changing:Bool = false;

    public function new()
    {
        super();        
    }

    public override function begin()
    {       
        Settings.sfx = new Sfx("sfx/longhouse.mp3");
        Settings.sfx.loop();
        Settings.sfx.volume = .5;
        Settings.sfx.type = "MUSIC";

        var screen = HXP.screen;
        // screen.scaleX = screen.scaleY = screen.scale = 1;

        var baseHeight = (HXP.height/HXP.screen.scaleY)*.1;
        var baseWidth = (HXP.height/HXP.screen.scaleY)*.02;

        createdText = buildCreditsTest("Created By:",baseWidth,0);
        shaneText = buildCreditsTest("Level Design/Programming: Shane King",baseWidth,baseHeight);
        calebText = buildCreditsTest("Art/Original Music/Level Design: Caleb Creed",baseWidth,baseHeight*2);
        benText = buildCreditsTest("Art/Programming: Ben Van Treese",baseWidth,baseHeight*3);

        var Status = "";

        if(Settings.Kills == 0 && Settings.Attacks == 0 && Settings.Steals == 0){
            Status = "HERO!";
        }

        if(Settings.Kills > 0){
            if(Settings.Kills < 3){
                Status += "KILLER! \n";
            } else if(Settings.Kills < 6){
                Status += "MASS MURDERER! \n";
            } else {
                Status += "BUTCHER! \n";
            }
        }
        if(Settings.Attacks > 0){
            if(Settings.Attacks < 3){
                Status += "JERK! \n";
            } else if(Settings.Attacks < 8){
                Status += "MUGGER! \n";
            } else {
                Status += "BERSERKER! \n";
            }
        }
        if(Settings.Steals > 0){
            if(Settings.Steals < 3){
                Status += "CUTPURSE!";
            } else if(Settings.Steals < 6){
                Status += "PLUNDERER!";
            } else {
                Status += "KLEPTOMANIAC!";
            }
        }

        scoreKillsText = buildCreditsTest("You killed " + Settings.Kills + (Settings.Kills == 1 ? " person" : " people"),baseWidth,baseHeight*5);
        scoreAttacksText = buildCreditsTest("and attacked people " + Settings.Attacks + (Settings.Attacks == 1 ? " time" : " times"),baseWidth,baseHeight*6);
        scoreStealsText = buildCreditsTest("and stole " + Settings.Steals + (Settings.Steals == 1 ? " banana" : " bananas"),baseWidth,baseHeight*7);
        scoreStatusText = buildCreditsTest(Status,baseWidth*50,baseHeight*5);
        scoreStatusText.size = Math.floor(2.13*Settings.TextSize);

#if android
        returnText = buildCreditsTest("Tap to return to the menu.",baseWidth,baseHeight*10);
#else
        returnText = buildCreditsTest("Press 'ESC' to return to the menu.",baseWidth,baseHeight*10);
#end

        HXP.setCamera(0,0);

        super.begin();
    }
 
    public override function update()
    {
        if(TextUtils.fadeInText(createdText)){
        if(TextUtils.fadeInText(shaneText)){
        if(TextUtils.fadeInText(calebText)){
        if(TextUtils.fadeInText(benText)){
        if(TextUtils.fadeInText(scoreKillsText)){
        if(TextUtils.fadeInText(scoreAttacksText)){
        if(TextUtils.fadeInText(scoreStealsText)){
        if(TextUtils.fadeInText(scoreStatusText)){
        if(TextUtils.fadeInText(returnText)){
        }}}}}}}}}
        super.update();
        CheckInput();
    }

    private function CheckInput(){
        if(changing) return;
        if(Input.check("exit")){
            changing = true;
            super.end();
            Settings.sfx.stop();
            HXP.scene = new MainMenu();
        }else{
            if(Lambda.count(Input.touches) > 0){
                hit = true;
            }else if(hit){
                changing = true;
                super.end();
                Settings.sfx.stop();
                HXP.scene = new MainMenu();
            }
        }
    }
    
    private function buildCreditsTest(string:String,x:Float,y:Float):Text{
        var text = new Text(string);
        text.size = Settings.TextSize;
        text.x = x;
        text.y = y;
        text.color = 0xFFFFFF;
        text.alpha = 0;
        addGraphic(text);

        return text;
    } 
}