package scenes;

import entities.emitters.WaterEmitter;
import entities.emitters.FireEmitter;
import entities.emitters.AirEmitter;
import entities.emitters.GroundEmitter;
import nape.space.Space;
import com.haxepunk.HXP;
import classes.Settings;

class LevelOne extends Level
{
    public function new()
    {
        super("maps/Level_1.tmx", "sfx/haunted.mp3");

        //Totems
        var totemMap = [
            "earthbridge" => function(){
                
                freeCamera = false;
                HXP.camera.x = 129*16;
                HXP.camera.y = 17*16;
                heldCameraTime = 2;

                add(new GroundEmitter(133*16, 20*16, Settings.Space));
                add(new GroundEmitter(134*16, 20*16, Settings.Space));
                add(new GroundEmitter(135*16, 20*16, Settings.Space));
                add(new GroundEmitter(136*16, 20*16, Settings.Space));
                add(new GroundEmitter(137*16, 20*16, Settings.Space));
                add(new GroundEmitter(138*16, 20*16, Settings.Space));
                add(new GroundEmitter(139*16, 20*16, Settings.Space));
            },
            "windlaunch" => function(){
                 add(new AirEmitter(10, 100, 233 * 16, 9 * 16, 10,  Settings.Space));
            }

        ];
        placeTotems(totemMap);
        placeElevators(7);
    }
}