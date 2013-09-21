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
                add(new GroundEmitter(192*16,34*16,Settings.Space));
                add(new GroundEmitter(193*16,33*16,Settings.Space));
                add(new GroundEmitter(194*16,33*16,Settings.Space));
            }
        ];
        placeTotems(totemMap);
        placeElevators(5);
    }
}