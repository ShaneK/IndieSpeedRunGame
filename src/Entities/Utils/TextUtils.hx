package utils;
import com.haxepunk.graphics.Text;

class TextUtils
{
    public static function fadeInText(text:Text):Bool{
        if(text.color >= 0xFDFDFD){
            return true;
        }
        text.color = text.color + 0x020202;
        return false;
    }
}