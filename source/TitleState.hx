package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxColor;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class TitleState extends FlxState
{
	private var _txtTitle:FlxText;
	private var _txtPressText:FlxText;
	private var _txtAuthor:FlxText;

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();

		var _bgTitle = new FlxSprite(0,0);
		_bgTitle.loadGraphic(Reg.BG_TITLE);
		add(_bgTitle);

		_txtTitle = new FlxText(150, 180, "UNIVERSAL LOVE",35);
		_txtTitle.setBorderStyle(FlxText.BORDER_SHADOW, FlxColor.BLUE, 3, 3);
		_txtPressText = new FlxText(220, 340, "Press SPACE to play", 16);
		_txtAuthor =  new FlxText(260, 400, "2014 sbarrio",14);
		
		add(_txtTitle);
		add(_txtPressText);
		add(_txtAuthor);
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
        if (FlxG.keys.pressed.SPACE)
        {
        	FlxG.sound.play(Reg.SND_CONFIRM);
            goToMenuState();
        }
	}	

	public function goToMenuState():Void{
		FlxG.switchState(new MenuState());
	}
}