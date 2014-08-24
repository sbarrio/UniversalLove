package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxVelocity;
import flixel.util.FlxAngle;
import flixel.util.FlxPoint;

class Explosion extends FlxSprite
{

    public var ttl:Int;

    public function new(X:Float, Y:Float)
    {
    	super(X,Y);
        loadGraphic(Reg.EXPLOSION, true, 10, 10, true, "explosion");
        ttl = 5;
    }

    override public function update():Void
    {
    	super.update();
    }

    override public function destroy():Void
    {
        super.destroy();
    }
}