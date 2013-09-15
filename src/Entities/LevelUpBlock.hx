package entities;

import com.haxepunk.Entity;
import classes.Settings;

class LevelUpBlock extends Entity
{
    public function new(xi:Float, yi:Float)
    {
        super(xi, yi);
        width = 16;
 		height = 16;
        setHitbox(16,16);
        type = "test";
    }

    public override function update(){
        var player = scene.collideRect("player", x, y, 16, 16);
        if(player != null){
            var p = cast(player, entities.Player);
            if(Settings.Level == 1){
                Settings.Health = Settings.MaxHealth;
            }
            p.levelUp();
        }
    }
}