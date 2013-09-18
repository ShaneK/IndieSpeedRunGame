package classes;
import nape.space.Space;
import com.haxepunk.Scene;
import com.haxepunk.Sfx;

class Settings {
	public static var Paused:Bool = false;

	//Sound data
	public static var MaxVolume:Int = 11;
	public static var Volume:Int = 11;
	public static var SfxMuted:Bool = false;
	public static var SoundMuted:Bool = false;

	//Game data
#if debug
	public static var MaxHealth:Int = 100000;
#else
	public static var MaxHealth:Int = 100;
#end
	public static var Health:Int = 100;
	public static var Kills:Int = 0;
	public static var Attacks:Int = 0;
	public static var Steals:Int = 0;
	public static var Level:Int = 1;

	public static var sfx:Sfx;
	
	//Player
    public static var Player:entities.PhysicalBody;

    public static function getNextScene(level:Int):com.haxepunk.Scene {
    	if(level == 2){
    		return new scenes.LevelOne();
    	}else if(level == 3){
    		return new scenes.LevelTwo();
    	}
    	return new scenes.Credits();
    }

#if android
    public static var TextSize = 30;
#else
    public static var TextSize = 8;
#end

    //Space
    public static var Space:Space;
    public static var Scene:Scene;

#if android
    public static var IsMobile:Bool = true;
#else
    public static var IsMobile:Bool = false;
#end

    public static function restoreDefault(){
		Paused = false;
		Health = 100;
		Kills = 0;
		Attacks = 0;
		Steals = 0;
		Level = 1;
    }
}