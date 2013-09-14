import com.haxepunk.Engine;
import com.haxepunk.HXP;

import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class Main extends Engine
{

	override public function init()
	{
        
		Input.define("left", [Key.LEFT, Key.A]);
        Input.define("right", [Key.RIGHT, Key.D]);
        Input.define("jump", [Key.W, Key.SPACE]);

#if debug
		HXP.console.enable();
#end
		HXP.scene = new scenes.Test();
		HXP.screen.scale = 4;
	}

	public static function main() { new Main(); }

}