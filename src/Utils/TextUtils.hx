package utils;
import com.haxepunk.graphics.Text;
import com.haxepunk.HXP;

class TextUtils
{
    public static function fadeInText(text:Text):Bool{
    	if(text.alpha >= 1){
    		return true;
    	}
    	text.alpha += HXP.elapsed;
        // if(text.color >= 0xFDFDFD){
        //     return true;
        // }
        // text.color = text.color + 0x020202;
        return false;
    }
}