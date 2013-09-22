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
        super("maps/Tut.tmx");
        var totemMap = [
            "Example" => function(){
                for(i in 0...8){
                    add(new GroundEmitter((71+i+1)*64, 15*64, Settings.Space));
                }
            }
        ];
        placeTotems(totemMap);
        placeElevators(2);
        placeFloatingDialogs();
    }

    public function placeFloatingDialogs(){
        if(Settings.IsMobile){
            add(new entities.Dialog(9*64, 12*64, 450, 75, "Welcome to Do No Harm!\nUse the joypad in the lower\nleft to move!"));
            add(new entities.Dialog(18*64, 12*64, 350, 65, "Press the attack button\nto attack"));
            add(new entities.Dialog(Math.floor(23.5*64), 12*64, 300, 65, "Use the jump button\nto jump"));
            add(new entities.Dialog(30*64, 12*64, 550, 65, "Run by moving further away from the\njoypad while holding onto it"));
            add(new entities.Dialog(40*64, 12*64, 230, 65, "Avoid hazards!"));
            add(new entities.Dialog(68*64, 12*64, 500, 75, "Totems control the elements.\nStand by them and click on them to\ninteract"));
        }else{
            add(new entities.Dialog(9*64, 12*64, 450, 75, "Welcome to Do No Harm!\nUse your arrow keys to move!"));
            add(new entities.Dialog(18*64, 12*64, 300, 65, "Press x to attack"));
            add(new entities.Dialog(Math.floor(23.5*64), 12*64, 300, 65, "Use space to jump"));
            add(new entities.Dialog(30*64, 12*64, 300, 65, "Use shift to run"));
            add(new entities.Dialog(41*64, 12*64, 230, 65, "Avoid hazards!"));
            add(new entities.Dialog(68*64, 12*64, 450, 75, "Totems control the elements.\nHit up to interact"));
        }
        add(new entities.Dialog(53*64, 12*64, 450, 65, "Don't let your health hit zero!"));
        add(new entities.Dialog(85*64, 12*64, 200, 65, "Have fun!"));
    }
}