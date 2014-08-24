package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxColor;
import flixel.util.FlxSave;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{

	private var numScenarios:Int;
	private var currentScenario:Int;
	private var _txtChoose:FlxText;
	private var _txtScenario1:FlxText;
	private var _txtScenario2:FlxText;
	private var _txtScenario3:FlxText;
	private var _txtScenario4:FlxText;
	private var _chooserIcon:FlxSprite;

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();

		var _bgMenu = new FlxSprite(0,0);
		_bgMenu.loadGraphic(Reg.BG_TITLE);
		add(_bgMenu);

		_txtChoose = new FlxText(150,80,500,"Choose your star system:",20);
		add(_txtChoose);

		_txtScenario1 = new FlxText(200,150,500,"Newb nebula",18);
		add(_txtScenario1);

		_txtScenario2 = new FlxText(200,200,500,"Bodyguard cluster",18);
		add(_txtScenario2);

		_txtScenario3 = new FlxText(200,250,500,"Busy sector",18);
		add(_txtScenario3);

		_txtScenario4 = new FlxText(200,300,500,"Death rim",18);
		add(_txtScenario4);

		var _txtEscape = new FlxText(160,430,500, "ESC: cancel/exit",12);
		add(_txtEscape);
		var _txtConfirm = new FlxText(300,430,500, "SPACE: confirm",12);
		add(_txtConfirm);

		_chooserIcon = new FlxSprite(180, 155);
		_chooserIcon.loadGraphic(Reg.CHOOSER);
		add(_chooserIcon);

		numScenarios = 4;
		currentScenario = 0;
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
		if (FlxG.keys.justPressed.UP && currentScenario > 0){
			moveUpSelector();
			FlxG.sound.play(Reg.SND_BLIP);
		}
		if (FlxG.keys.justPressed.DOWN && currentScenario < numScenarios-1){
			moveDownSelector();
			FlxG.sound.play(Reg.SND_BLIP);
		}

		if (FlxG.keys.justPressed.SPACE){
			loadScenario(currentScenario);
			FlxG.sound.play(Reg.SND_CONFIRM);
		}

		if (FlxG.keys.justPressed.ESCAPE){
			FlxG.switchState(new TitleState());
			FlxG.sound.play(Reg.SND_BLOP);
		}
	}	

	public function loadScenario(index:Int):Void{
		var _gameSave = new FlxSave(); // initialize
		_gameSave.bind("Shared"); // bind to the named save slot
		_gameSave.data.scenario = index;
		// save data
		_gameSave.flush();

		FlxG.switchState(new PlayState());
	}

	public function moveUpSelector():Void{
		currentScenario--;
		_chooserIcon.y -=50;
	}

	public function moveDownSelector():Void{
		currentScenario++;
		_chooserIcon.y +=50;
	}
}