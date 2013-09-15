package scenes;

import classes.Settings;
import com.haxepunk.Entity;
import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
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
        screen.color = 0x000000;
        screen.scale = 1;
        thingText = buildCreditsTest("This game was developed as part of Indie Speed Run 2013 (www.indiespeedrun.com).",20,0);
        thingText.size = 18;
        createdText = buildCreditsTest("Created By:",20,50);
        shaneText = buildCreditsTest("Programming: Shane King",20,120);
        calebText = buildCreditsTest("Music / Level Design: Caleb Creed",20,180);
        benText = buildCreditsTest("Art / Programming: Ben Van Treese",20,240);

        var wasMean = Settings.Kills > 0 || Settings.Attacks > 0 || Settings.Steals > 0;
        scoreKillsText = buildCreditsTest("You killed " + Settings.Kills + " people",20,360);
        scoreAttacksText = buildCreditsTest("and hurt " + Settings.Attacks + " people",20,400);
        scoreStealsText = buildCreditsTest("and stole " + Settings.Steals + " bananas.",20,440);
        scoreStatusText = buildCreditsTest(wasMean ? " JERK!" : " HERO!",480,380);
        scoreStatusText.size = 92;

        HXP.setCamera(0,0);

        super.begin();
    }
 
    public override function update()
    {
        if(TextUtils.fadeInText(thingText)){
        if(TextUtils.fadeInText(createdText)){
        if(TextUtils.fadeInText(shaneText)){
        if(TextUtils.fadeInText(calebText)){
        if(TextUtils.fadeInText(benText)){
        if(TextUtils.fadeInText(scoreKillsText)){
        if(TextUtils.fadeInText(scoreAttacksText)){
        if(TextUtils.fadeInText(scoreStealsText)){
        if(TextUtils.fadeInText(scoreStatusText)){
        }}}}}}}}}
        super.update();
        CheckInput();
    }

    private function CheckInput(){
        if(Input.check("exit")){
            super.end();
            Settings.sfx.stop();
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