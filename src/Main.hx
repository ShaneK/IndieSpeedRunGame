import com.haxepunk.Engine;
import com.haxepunk.HXP;

import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class Main extends Engine
{
	override public function init()
	{
        Input.define("run",[Key.SHIFT]);
		Input.define("left", [Key.LEFT, Key.A]);
        Input.define("right", [Key.RIGHT, Key.D]);
        Input.define("jump", [Key.W, Key.SPACE]);
        Input.define("start", [Key.ENTER]);
        Input.define("exit", [Key.ESCAPE]);
        Input.define("credits",[Key.C]);
        Input.define("attack",[Key.X]);

#if debug
		HXP.console.enable();
#end
		HXP.scene = new scenes.MainMenu();				
	}

	public static function main() { new Main(); }

}