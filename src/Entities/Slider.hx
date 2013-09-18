package entities;
 
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.utils.Touch;
import com.haxepunk.graphics.Text;
import classes.Settings;
import classes.EMath;
 
class Slider extends Entity
{
	//Paramter data
	private var maximumValue:Int;
	private var currentValue:Int;
	private var interactive:Int;

	//Graphic Storage
	private var stroke:Image;
	private var foreground:Image;
	private var sliderText:Text;

	public function new(x:Float, y:Float, width:Int, height:Int, textSize:Int, maxValue:Int, value:Int, strokeColor:Int = 0x999999, backgroundColor:Int = 0xDDDDDD, textColor:Int = 0x000000){
		super(x, y);

		maximumValue = maxValue;
		currentValue = value;

		stroke = Image.createRect(width, height, strokeColor);
		stroke.scrollX = 0;
		stroke.scrollY = 0;
		addGraphic(stroke);

		var offset:Int = 4;
		foreground = Image.createRect(width-offset, height-offset, backgroundColor);
		foreground.x = stroke.x + offset/2;
		foreground.y = stroke.y + offset/2;
		foreground.scrollX = 0;
		foreground.scrollY = 0;
		addGraphic(foreground);

        sliderText = new Text(Math.ceil((value/maxValue)*100) + "%");
        sliderText.size = textSize;
        var sliderTextWidthOffset = (sliderText.textWidth*.5);
        var sliderTextHeightOffset = (sliderText.textHeight*.5);
        if(Settings.IsMobile){
            sliderTextWidthOffset /= HXP.screen.scale;
            sliderTextHeightOffset /= HXP.screen.scale;
        }
        sliderText.x = foreground.x + (foreground.scaledWidth/2) - sliderTextWidthOffset;
        sliderText.y = foreground.y + (foreground.scaledHeight/2) - sliderTextHeightOffset;
        sliderText.color = textColor;
		sliderText.scrollX = 0;
		sliderText.scrollY = 0;
        addGraphic(sliderText);

        type = "slider";
        layer = 0;
	}

	public override function update(){
		foreground.scaleX = EMath.clamp(currentValue/maximumValue, 0, 1);
		super.update();
	}

	public function updateSlider(newValue:Int = -2000){
		if(newValue != -2000){
			currentValue = newValue;
		}
		sliderText.text = Math.ceil((currentValue/maximumValue)*100) + "%";
	}

	public function updateMaximumValue(newMaximumValue:Int, newCurrentValue:Int = -2000){
		maximumValue = newMaximumValue;
		updateSlider(newCurrentValue);
	}
}