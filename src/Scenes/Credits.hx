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
    var returnText:Text;

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
        shaneText = buildCreditsTest("Level Design/Programming: Shane King",20,120);
        calebText = buildCreditsTest("Art/Original Music/Level Design: Caleb Creed",20,180);
        benText = buildCreditsTest("Art/Programming: Ben Van Treese",20,240);

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

        scoreKillsText = buildCreditsTest("You killed " + Settings.Kills + (Settings.Kills == 1 ? " person" : " people"),20,360);
        scoreAttacksText = buildCreditsTest("and attacked people " + Settings.Attacks + (Settings.Attacks == 1 ? " time" : " times"),20,400);
        scoreStealsText = buildCreditsTest("and stole " + Settings.Steals + (Settings.Steals == 1 ? " banana" : " bananas"),20,440);
        scoreStatusText = buildCreditsTest(Status,540,300);
        scoreStatusText.size = 64;


        returnText = buildCreditsTest("Press 'ESC' to return to the menu.",20,520);

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
        if(TextUtils.fadeInText(returnText)){
        }}}}}}}}}}
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