package scenes;

import entities.emitters.WaterEmitter;
import entities.emitters.FireEmitter;
import entities.emitters.AirEmitter;
import entities.emitters.GroundEmitter;
import classes.Settings;

class Tutorial extends Level
{
    public function new()
    {
        super("maps/Test.tmx");
        var totemMap = [
            "Example" => function(){
                add(new WaterEmitter(512, 512, 95*64, 25*64, 10, 5));
            }
        ];
        placeTotems(totemMap);
        placeElevators(2);
        placeFloatingDialogs();
    }

    public function placeFloatingDialogs(){
        if(Settings.IsMobile){
            add(new entities.Dialog(9*64, 12*64, 140, 30, "Welcome to Do No Harm!\nUse the joypad in the lower\nleft to move!"));
            add(new entities.Dialog(18*64, 12*64, 160, 20, "Press the attack button to attack"));
            add(new entities.Dialog(49*64, 12*64, 170, 30, "Run by moving further away from the\njoypad while holding onto it"));
            add(new entities.Dialog(62*64, 12*64, 130, 20, "Use the jump button to jump"));
            add(new entities.Dialog(79*64, 12*64, 90, 20, "Avoid hazards!"));
            add(new entities.Dialog(95*64, 12*64, 170, 30, "Totems control the elements.\nStand by them and click on them to\ninteract"));
        }else{
            add(new entities.Dialog(9*64, 12*64, 450, 75, "Welcome to Do No Harm!\nUse your arrow keys to move!"));
            add(new entities.Dialog(18*64, 12*64, 400, 65, "Press x to attack"));
            add(new entities.Dialog(48*64, 12*64, 120, 20, "Use shift to run"));
            add(new entities.Dialog(62*64, 12*64, 120, 20, "Use space to jump"));
            add(new entities.Dialog(79*64, 12*64, 90, 20, "Avoid hazards!"));
            add(new entities.Dialog(100*64, 12*64, 140, 30, "Totems control the elements.\nHit up to interact"));
        }
        add(new entities.Dialog(113*64, 12*64, 140, 20, "Don't let your health hit zero!"));
        add(new entities.Dialog(128*64, 12*64, 90, 20, "Have fun!"));
    }
}