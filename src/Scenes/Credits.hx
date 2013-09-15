package scenes;

import classes.Settings;
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
        var screen = HXP.screen;
        screen.color = 0x000000;
        screen.scale = 1;
        thingText = buildCreditsTest("This game was developed as part of Indie Speed Run 2013 (www.indiespeedrun.com).",20,0);
        thingText.size = 18;
        createdText = buildCreditsTest("Created By:",20,50);
        shaneText = buildCreditsTest("Level Design/Programming: Shane King",20,120);
        calebText = buildCreditsTest("Art/Music/Level Design: Caleb Creed",20,180);
        benText = buildCreditsTest("Art/Programming: Ben Van Treese",20,240);

        var Status = "";

        Settings.Kills = 1;
        Settings.Attacks = 7;
        Settings.Steals = 4;
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


        scoreKillsText = buildCreditsTest("You killed " + Settings.Kills + " people",20,360);
        scoreAttacksText = buildCreditsTest("and attacked people " + Settings.Attacks + " times",20,400);
        scoreStealsText = buildCreditsTest("and stole " + Settings.Steals + " bananas.",20,440);
        scoreStatusText = buildCreditsTest(Status,540,300);
        scoreStatusText.size = 64;

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