package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxVelocity;
import flixel.util.FlxAngle;
import flixel.util.FlxPoint;

class Love extends FlxSprite
{

    public var SPEED:Float;
    public var LOVE:Int;
    public var targetObject:FlxSprite;
    public var parentObject:Planet;

    public function new(X:Float, Y:Float, Target:FlxSprite, Parent:Planet)
    {
        super(X,Y);
        SPEED = 50;
        LOVE = 10;
        targetObject = Target;
        parentObject = Parent;
        loadGraphic(Reg.LOVE, true, 5, 5, true, "love");
        FlxVelocity.moveTowardsObject(this, Target, SPEED);
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