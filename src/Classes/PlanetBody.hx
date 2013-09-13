package classes;

import nape.phys.Body;

class PlanetBody
{
    public var body:Body;
    public var x:Float;
    public var y:Float;
    public var width:Float;
    public var height:Float;

    public function new(planetBody:Body, xi:Float, yi:Float, widthi:Float, heighti:Float){
        body = planetBody;
        x = xi;
        y = yi;
        width = widthi;
        height = heighti;
    }
}