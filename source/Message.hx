package;

import flixel.FlxG;
import flixel.FlxObject;

class Message extends FlxObject
{

    private var _text: String;
    public function new(X:Float, Y:Float, Text:String)
    {
    	super(X,Y);
        _text = Text;
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