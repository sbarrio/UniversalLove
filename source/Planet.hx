package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.ui.FlxBar;
import flixel.text.FlxText;


class Planet extends FlxSprite
{

    public var _health:Int;
    public var _love:Int;
    public var _missiles:Int;
    public var _name:String;
    public var _level:Int;
    public var _coolDownTime:Float;
    public var _timer:FlxTimer;
    public var _lifeBar:FlxBar;
    public var _nameLabel:FlxText;
    public var _lastAttacker:Planet;
    public var _lastLover:Planet;

    public function new(X:Float, Y:Float, Health: Int, Missiles: Int, Love:Int, Name:String, CoolDownTime:Float,Sprites:String, Width: Int, Height: Int, Level: Int)
    {
    	super(X,Y);

        // init
        _health = Health;
        _love = Love;
        _missiles = Missiles;
        _name = Name;
        _level = Level;
        _coolDownTime = CoolDownTime;
        width = Width;
        height = Height;
        _lastAttacker = null;
        _lastLover = null;
        loadGraphic(Sprites);
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