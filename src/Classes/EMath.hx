package classes;

import com.haxepunk.HXP;

class EMath
{
    public static function clamp(a:Float, min:Float, max:Float){
        if(a > max) return max;
        if(a < min) return min;
        return a;
    }

    public static function randomSign(){
        return HXP.random > .5 ? 1 : -1;
    }

    public static function getAngle(x:Float, y:Float, rX:Float, rY:Float) {
        var angle:Float = radToDeg(Math.atan2(rX - x, rY - y)) + 90;

        if(angle < 0){
            angle += 360;
        }else if(angle > 360){
            angle -= 360;
        }

        return angle;
    }

    public static function radToDeg(rad:Float):Float
    {
        return 180 / Math.PI * rad;
    }

    public static function getLengthOfVector(arr:Array<Float>){
        var k:Float = 0;
        for(x in arr){
            k += Math.pow(x, 2);
        }
        return Math.sqrt(k);
    }
}