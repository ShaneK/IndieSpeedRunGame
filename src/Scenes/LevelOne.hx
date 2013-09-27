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
                HXP.camera.x = 109*64;
                HXP.camera.y = 53*64;
                heldCameraTime = 2;

                for(i in 0...7){
                    add(new GroundEmitter((113+i+1)*64, 58*64, Settings.Space));
                }
            }
            // "windlaunch" => function(){
            //      add(new AirEmitter(10, 100, 233 * 16, 9 * 16, 10,  Settings.Space));
            // }
        ];
        placeTotems(totemMap);
        placeElevators(7);
    }
}