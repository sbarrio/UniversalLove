package;

import flixel.util.FlxSave;

/**
 * Handy, pre-built Registry class that can be used to store 
 * references to objects and other things for quick-access. Feel
 * free to simply ignore it or change it in any way you like.
 */
class Reg
{

	//Background graphics
	public static inline var BG_TITLE:String = "assets/images/bg/titleBG.png";
	public static inline var BG_1:String = "assets/images/bg/bg1.png";
	public static inline var BG_2:String = "assets/images/bg/bg2.png";
	

	//HUD
	public static inline var ACTION_BOX_BG:String = "assets/images/hud/actionsBox.png";
	public static inline var TARGET_HUD:String = "assets/images/hud/target.png";
	public static inline var ACTION_CURSOR_HUD:String = "assets/images/hud/actionCursor.png";
	public static inline var CHOOSER:String = "assets/images/hud/chooser.png";

	//Planet graphics
	public static inline var PLANET_1:String = "assets/images/planets/planet1.png";
	public static inline var PLANET_2:String = "assets/images/planets/planet2.png";
	
	public static inline var PLANET_3:String = "assets/images/planets/planet3.png";
	public static inline var PLANET_4:String = "assets/images/planets/planet4.png";
	public static inline var PLANET_5:String = "assets/images/planets/planet5.png";

	public static inline var PLANET_6:String = "assets/images/planets/planet6.png";
	public static inline var PLANET_7:String = "assets/images/planets/planet7.png";
	public static inline var PLANET_8:String = "assets/images/planets/planet8.png";

	public static inline var PLANET_9:String = "assets/images/planets/planet9.png";
	public static inline var PLANET_10:String = "assets/images/planets/planet10.png";
	public static inline var PLANET_11:String = "assets/images/planets/planet11.png";
	public static inline var PLANET_12:String = "assets/images/planets/planet12.png";

	//Player planet
	public static inline var PLAYER_PLANET_1:String = "assets/images/planets/player/planet1.png";
	public static inline var PLAYER_PLANET_2:String = "assets/images/planets/player/planet2.png";
	public static inline var PLAYER_PLANET_3:String = "assets/images/planets/player/planet3.png";
	public static inline var PLAYER_PLANET_4:String = "assets/images/planets/player/planet4.png";

	//Items
	public static inline var LOVE:String = "assets/images/objects/love.png";
	public static inline var MISSILE:String = "assets/images/objects/missile.png";	
	public static inline var EXPLOSION:String = "assets/images/objects/explosion.png";	

	//Sounds
	public static inline var SND_LOVE_LAUNCH:String = "assets/sounds/loveLaunch.wav";
	public static inline var SND_MISSILE_LAUNCH:String = "assets/sounds/missileLaunch.wav";
	public static inline var SND_LOVE_HITS:String = "assets/sounds/loveHits.wav";
    public static inline var SND_MISSILE_HITS:String = "assets/sounds/missileHits.wav";
    public static inline var SND_MISSILE_VS_LOVE:String = "assets/sounds/missileVsLove.wav";
    public static inline var SND_BLIP:String = "assets/sounds/Blip_Select.wav";
    public static inline var SND_BLOP:String = "assets/sounds/cancelBlip.wav";
    public static inline var SND_CONFIRM:String = "assets/sounds/menuBlip.wav";


	/**
	 * Generic levels Array that can be used for cross-state stuff.
	 * Example usage: Storing the levels of a platformer.
	 */
	public static var levels:Array<Dynamic> = [];
	/**
	 * Generic level variable that can be used for cross-state stuff.
	 * Example usage: Storing the current level number.
	 */
	public static var level:Int = 0;
	/**
	 * Generic scores Array that can be used for cross-state stuff.
	 * Example usage: Storing the scores for level.
	 */
	public static var scores:Array<Dynamic> = [];
	/**
	 * Generic score variable that can be used for cross-state stuff.
	 * Example usage: Storing the current score.
	 */
	public static var score:Int = 0;
	/**
	 * Generic bucket for storing different FlxSaves.
	 * Especially useful for setting up multiple save slots.
	 */
	public static var saves:Array<FlxSave> = [];
}