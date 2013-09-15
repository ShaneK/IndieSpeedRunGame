package classes;

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

	//Player
    public static var Player:entities.PhysicalBody;

    public static function getNextScene(level:Int){
    	if(level == 1){
    		return new scenes.Credits();
    	}
    	return new scenes.Credits();
    }
}