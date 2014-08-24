package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxVelocity;
import flixel.util.FlxAngle;
import flixel.util.FlxPoint;

class Missile extends FlxSprite
{

    public var SPEED:Float;
    public var DAMAGE:Int;
    public var targetObject:Planet;
    public var parentObject:Planet;


    public function new(X:Float, Y:Float, Target:Planet, Parent:Planet)
    {
    	super(X,Y);
        SPEED = 50;
        DAMAGE = 10;
        targetObject = Target;
        parentObject = Parent;
        loadGraphic(Reg.MISSILE, true, 10, 10, true, "missile");
        FlxVelocity.moveTowardsObject(this, Target, SPEED);
    }

    override public function update():Void
    {
    	super.update();
        //updates sprite angle
        angle = angleTowardsTarget() + 270;
    }

    override public function destroy():Void
    {
        super.destroy();
    }

    private function angleTowardsTarget():Float{
        var currPoint:FlxPoint;
        currPoint = new FlxPoint(x,y);
        return FlxAngle.getAngle(currPoint,targetObject.getMidpoint(FlxPoint.get()));
    }
}