package scenes;

import entities.emitters.WaterEmitter;
import entities.emitters.FireEmitter;
import entities.emitters.AirEmitter;
import entities.emitters.GroundEmitter;
import nape.space.Space;
import com.haxepunk.HXP;
import classes.Settings;

class LevelTwo extends Level
{
    public function new()
    {
        super("maps/Level_2.tmx", "sfx/haunted.mp3");

        var totemMap = [
            "landbridge" => function(){
                add(new GroundEmitter(110*64,40*64,Settings.Space));
                for(i in 0...3){
                    add(new GroundEmitter((111+i)*64,39*64,Settings.Space));
                }
            }
        ];
        placeTotems(totemMap);
        placeElevators(6);
    }
}