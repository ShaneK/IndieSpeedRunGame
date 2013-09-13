package entities;
 
import com.haxepunk.Entity;
import nape.phys.Body;

class PhysicalBody extends Entity
{
	private var body:Body;

    public function getBody(){
    	return body;
    }
}