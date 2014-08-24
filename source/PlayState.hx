package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxPoint;
import flixel.util.FlxTimer;
import flixel.ui.FlxBar;
import flixel.util.FlxSave;
import flixel.util.FlxRandom;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	public var _bg:FlxSprite;

	public var _planets:FlxTypedGroup<Planet>;
	public var _missiles:FlxTypedGroup<Missile>;
	public var _love:FlxTypedGroup<Love>;

	public var _explosions:FlxTypedGroup<Explosion>;

	// Player
	public var _player:Planet;
	public var _playerTimerBar:FlxBar;
	public var _playerHealthBar:FlxBar;

	//HUD
	public var _hudElements:FlxTypedGroup<FlxSprite>;
		//Control Panel
	public var _actionBoxBG:FlxSprite;
	public var _attackLabel:FlxText;
	public var _loveLabel:FlxText;

	public var _targetHud:FlxSprite;
	public var _actionCursor:FlxSprite;

	public var _controlPanelShowing:Bool;
	public var _selectingTargetShowing:Bool;
	public var _currentAction:Int;

	public var _currentTarget:Int;


	public var _messageArray:List<String>;
	public var _messageBoardSlot1:FlxText;
	public var _messageBoardSlot2:FlxText;
	public var _messageBoardSlot3:FlxText;

	public var MESSAGE_SPEED:Float;

	//Timing
	public var _messageBoardTimer:FlxTimer;
	public var _playerTurnTimer:FlxTimer;

	//game constants
	public var LEVEL_1:Int = 1;
	public var LEVEL_2:Int = 2;
	public var LEVEL_3:Int = 3;
	public var HEALTH_LEVEL_1:Int = 100;
	public var HEALTH_LEVEL_2:Int = 200;
	public var HEALTH_LEVEL_3:Int = 300;
	public var MAX_HEALTH:Int = 400;

	public var _survivalTarget:Planet = null;
	public var _destructionTarget:Planet = null;
	public var _healthPlanetTarget:Planet = null;
	public var _isGameOver = false;

	public var _gameOverTitle:FlxText;
	public var _gameOverSubTitle:FlxText;

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();

		//inits groups
		_planets = new FlxTypedGroup<Planet>();
		_missiles = new FlxTypedGroup<Missile>();
		_love = new FlxTypedGroup<Love>();
		_hudElements = new FlxTypedGroup<FlxSprite>();

		_explosions = new FlxTypedGroup<Explosion>();

		//inits message array
		_messageArray = new List<String>();


		var scenario = 0;
		var _gameSave = new FlxSave(); // initialize
		_gameSave.bind("Shared"); 
		scenario = _gameSave.data.scenario;


		//Loading of Scenario

		//MAX HEALTH
		if (scenario == 0){
			//bg
			_bg = new FlxSprite();
			_bg.x = 0;
			_bg.y = 0;
			_bg.loadGraphic(Reg.BG_1);
			add(_bg);


			//player
			_player = new Planet(220,428,HEALTH_LEVEL_2,10,10, "Home", 5, Reg.PLAYER_PLANET_1,195,53,LEVEL_2);
			add(_player);

			//adds planets
			var _planet = new Planet(50, 200, HEALTH_LEVEL_1, 10, 10, "SR388",7,Reg.PLANET_1,25,25, LEVEL_1);
			_planets.add(_planet);

			_planet._timer = new FlxTimer(_planet._coolDownTime, NPCPlanetAI,0);

			var _planet2 = new Planet(500, 200, HEALTH_LEVEL_1, 10, 10, "Omicron",6,Reg.PLANET_2,100,100, LEVEL_1);
			_planets.add(_planet2);

			_planet2._timer = new FlxTimer(_planet2._coolDownTime, NPCPlanetAI,0);

			var _planet3 = new Planet(300, 70, HEALTH_LEVEL_1, 10, 10, "Corneria",3,Reg.PLANET_6,100,100, LEVEL_1);
			_planets.add(_planet3);

			_planet3._timer = new FlxTimer(_planet3._coolDownTime, NPCPlanetAI,0);

			//Objectives
			_survivalTarget = null;
			_healthPlanetTarget = _player;
			_destructionTarget = null;
		}

		//Bodyguarding
		if (scenario == 1){

			//bg
			_bg = new FlxSprite();
			_bg.x = 0;
			_bg.y = 0;
			_bg.loadGraphic(Reg.BG_2);
			add(_bg);

			//player
			_player = new Planet(220,428,HEALTH_LEVEL_1,10,10, "Home", 3, Reg.PLAYER_PLANET_1,195,53,LEVEL_1);
			add(_player);

			//adds planets
			var _planet = new Planet(50, 200, HEALTH_LEVEL_2, 10, 10, "Woodstock 69",5,Reg.PLANET_3,25,25, LEVEL_2);
			_planets.add(_planet);

			_planet._timer = new FlxTimer(_planet._coolDownTime, NPCPlanetAI,0);

			var _planet2 = new Planet(500, 200, HEALTH_LEVEL_1, 10, 10, "Robonia",4,Reg.PLANET_4,70,70, LEVEL_1);
			_planets.add(_planet2);

			_planet2._timer = new FlxTimer(_planet2._coolDownTime, NPCPlanetAI,0);

			var _planet3 = new Planet(300, 50, HEALTH_LEVEL_1, 10, 10, "Monen",6,Reg.PLANET_5,70,70, LEVEL_1);
			_planets.add(_planet3);

			_planet3._timer = new FlxTimer(_planet3._coolDownTime, NPCPlanetAI,0);

			//Objectives
			_healthPlanetTarget = null;
			_survivalTarget = _planet3;
			_destructionTarget = _planet;

			
		}

		if (scenario == 2){

			//bg
			_bg = new FlxSprite();
			_bg.x = 0;
			_bg.y = 0;
			_bg.loadGraphic(Reg.BG_1);
			add(_bg);

			//player
			_player = new Planet(220,428,HEALTH_LEVEL_1,10,10, "Home", 3, Reg.PLAYER_PLANET_1,195,53,LEVEL_1);
			add(_player);

			//adds planets
			var _planet = new Planet(50, 200, HEALTH_LEVEL_1, 10, 10, "Arcturus",5,Reg.PLANET_6,50,50, LEVEL_1);
			_planets.add(_planet);

			_planet._timer = new FlxTimer(_planet._coolDownTime, NPCPlanetAI,0);

			var _planet2 = new Planet(500, 200, HEALTH_LEVEL_1, 10, 10, "Tarsonis",4,Reg.PLANET_7,90,90, LEVEL_1);
			_planets.add(_planet2);

			_planet2._timer = new FlxTimer(_planet2._coolDownTime, NPCPlanetAI,0);

			var _planet3 = new Planet(300, 50, HEALTH_LEVEL_3, 10, 10, "Char",6,Reg.PLANET_8,40,40, LEVEL_2);
			_planets.add(_planet3);

			_planet3._timer = new FlxTimer(_planet3._coolDownTime, NPCPlanetAI,0);

			//Objectives
			_healthPlanetTarget = _player;
			_survivalTarget = _planet2;
			_destructionTarget = _planet3;

			
		}

		if (scenario == 3){

			//bg
			_bg = new FlxSprite();
			_bg.x = 0;
			_bg.y = 0;
			_bg.loadGraphic(Reg.BG_2);
			add(_bg);

			//player
			_player = new Planet(220,428,HEALTH_LEVEL_1,10,10, "Home", 3, Reg.PLAYER_PLANET_1,195,53,LEVEL_1);
			add(_player);

			//adds planets
			var _planet = new Planet(50, 200, HEALTH_LEVEL_1, 10, 10, "Dogon",5,Reg.PLANET_9,90,90, LEVEL_1);
			_planets.add(_planet);

			_planet._timer = new FlxTimer(_planet._coolDownTime, NPCPlanetAI,0);

			var _planet2 = new Planet(150, 50, HEALTH_LEVEL_3, 10, 10, "Smokeon",4,Reg.PLANET_10,100,100, LEVEL_3);
			_planets.add(_planet2);

			_planet2._timer = new FlxTimer(_planet2._coolDownTime, NPCPlanetAI,0);

			var _planet3 = new Planet(450, 50, HEALTH_LEVEL_2, 10, 10, "Zebeth",6,Reg.PLANET_11,60,60, LEVEL_2);
			_planets.add(_planet3);

			_planet3._timer = new FlxTimer(_planet3._coolDownTime, NPCPlanetAI,0);

			var _planet4 = new Planet(500, 200, HEALTH_LEVEL_1, 10, 10, "Ludum",4,Reg.PLANET_12,80,80, LEVEL_1);
			_planets.add(_planet4);

			_planet4._timer = new FlxTimer(_planet4._coolDownTime, NPCPlanetAI,0);

			//Objectives
			_healthPlanetTarget = null;
			_destructionTarget = _planet2;

			
		}

		add(_planets);
		add(_missiles);
		add(_love);
		add(_explosions);

		//Timers
		_messageBoardTimer = new FlxTimer(2.0, updateMessageBoard, 0);
		_playerTurnTimer = new FlxTimer(_player._coolDownTime, showControlPanel,0);


		//HUD
		_playerTimerBar = new FlxBar (475, 465, FlxBar.FILL_LEFT_TO_RIGHT,100, 10, _playerTurnTimer,"progress",0, 1, true);
		add(_playerTimerBar);

		_playerHealthBar = new FlxBar(270,420, FlxBar.FILL_LEFT_TO_RIGHT,100,5, _player,"_health",0,MAX_HEALTH,false);
		add(_playerHealthBar);

		_actionBoxBG = new FlxSprite();
		_actionBoxBG.x = 420;
		_actionBoxBG.y = 360;
		_actionBoxBG.loadGraphic(Reg.ACTION_BOX_BG);
		_hudElements.add(_actionBoxBG);

		_targetHud = new FlxSprite();	
		_targetHud.loadGraphic(Reg.TARGET_HUD);
		_hudElements.add(_targetHud);
		

		_attackLabel = new FlxText(433,380,100,"ATTACK", 14);
		_loveLabel = new FlxText(545,380,100,"LOVE", 14);
		_hudElements.add(_attackLabel);
		_hudElements.add(_loveLabel);

		_actionCursor = new FlxSprite();
		_actionCursor.x = 430;
		_actionCursor.y = 375;
		_actionCursor.loadGraphic(Reg.ACTION_CURSOR_HUD);
		_hudElements.add(_actionCursor);

		_currentAction = 0;
		_currentTarget = 0;

		//creates health and labelname for every planet
		for (p in _planets){
			var newLabel = new FlxText(p.x,p.y + p.height + 5,100,p._name + "  LV" + p._level ,10);
			p._nameLabel = newLabel;
			_hudElements.add(newLabel);

			var newBar = new FlxBar(p.x,p.y + p.height + 20, FlxBar.FILL_LEFT_TO_RIGHT,80,3, p,"_health",0,MAX_HEALTH,false);
			p._lifeBar = newBar;
			_hudElements.add(newBar);
		}

		var newLabel = new FlxText(475,425,100, _player._name + "  LV" + _player._level ,14);
		_player._nameLabel = newLabel;
		add(newLabel);


		//hides all hud elements
		for(sprite in _hudElements){
			sprite.alpha = 0.0;
		}
		add(_hudElements);


		//Message board
		_messageBoardSlot1 = new FlxText(10,35,300,"", 9);
		_messageBoardSlot2 = new FlxText(10,20,300,"", 9);
		_messageBoardSlot3 = new FlxText(10,5,300,"", 9);

		add(_messageBoardSlot1);
		add(_messageBoardSlot2);
		add(_messageBoardSlot3);



		//initial messages
		if (_survivalTarget != null){
			addMessage("OBJECTIVE: Planet " + _survivalTarget._name + " must NOT be destroyed.");
		}

		if (_destructionTarget != null){
			addMessage("OBJECTIVE: Planet " + _destructionTarget._name + " must be destroyed.");
		}

		if (_healthPlanetTarget!= null){
			if (_healthPlanetTarget == _player){
				addMessage("OBJECTIVE: Reach FULL health to win");	
			}else{
				addMessage("OBJECTIVE: Planet " + _healthPlanetTarget._nameLabel+ " + must reach FULL health to win");
			}
			
		}

		_controlPanelShowing = false;
		_selectingTargetShowing = false;

		//DEBUG
		FlxG.debugger.visible = false;
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

		if (_isGameOver){
			if (FlxG.keys.justPressed.SPACE){
				FlxG.switchState(new MenuState());
			}
		}

		if (_controlPanelShowing){
			//selects action
			if (!_selectingTargetShowing){
				if (FlxG.keys.justPressed.LEFT){
					if (_currentAction == 1){
						_actionCursor.x = 430;
						_currentAction = 0;
						FlxG.sound.play(Reg.SND_BLIP);
					}
				}

				if (FlxG.keys.justPressed.RIGHT){
					if (_currentAction == 0){
						_actionCursor.x = 530;
						_currentAction = 1;
						FlxG.sound.play(Reg.SND_BLIP);
					}
				}
			}else{
				//selects target
				if (FlxG.keys.justPressed.RIGHT){
					if (_currentTarget == 0){
						_currentTarget = _planets.members.length -1;
					}else{
						_currentTarget--;
					}
					var centerTarget:FlxPoint = _planets.members[_currentTarget].getMidpoint(FlxPoint.get());
					_targetHud.x = centerTarget.x - _targetHud.width / 2;
					_targetHud.y = centerTarget.y - _targetHud.height / 2;
					FlxG.sound.play(Reg.SND_BLIP);
				}

				if (FlxG.keys.justPressed.LEFT){
					if (_currentTarget == _planets.members.length -1){
						_currentTarget = 0;
					}else{
						_currentTarget++;
					}
					var centerTarget:FlxPoint = _planets.members[_currentTarget].getMidpoint(FlxPoint.get());
					_targetHud.x = centerTarget.x - _targetHud.width / 2;
					_targetHud.y = centerTarget.y - _targetHud.height / 2;
					FlxG.sound.play(Reg.SND_BLIP);
				}

				//cancels attack
				if (FlxG.keys.justPressed.ESCAPE){
					_selectingTargetShowing = false;
					_targetHud.alpha = 0.0;
					FlxG.sound.play(Reg.SND_BLOP);
				}
			}

			if (FlxG.keys.justPressed.SPACE){
				if (!_selectingTargetShowing){
					_selectingTargetShowing = true;	
					_targetHud.alpha = 1.0;

					//selects first target
					_currentTarget = 0;
					var centerTarget:FlxPoint = _planets.members[_currentTarget].getMidpoint(FlxPoint.get());
					_targetHud.x = centerTarget.x - _targetHud.width / 2;
					_targetHud.y = centerTarget.y - _targetHud.height / 2;

				}else{
					_selectingTargetShowing = false;	
					_targetHud.alpha = 0.0;
					hideControlPanel();

					//performs action
					if (_currentAction == 0){
						attackPlanet(_player, _planets.members[_currentTarget]);
					}
					if (_currentAction == 1){
						lovePlanet(_player, _planets.members[_currentTarget]);
					}

					//resets turn player timer and progress bar
					_playerTurnTimer = new FlxTimer(_player._coolDownTime, showControlPanel,0);
					_playerTimerBar.setParent(_playerTurnTimer, "progress");
				}
			}
		}

		//Missile collisions with planets
		FlxG.overlap(_missiles, _planets, null, overlapped);

		//Missiles collisions with player
		FlxG.overlap(_missiles, _player, null, overlapped);

		//Missiles collisiones with Love
		FlxG.overlap(_love, _missiles, null, overlapped);

		//Love with planets
		FlxG.overlap(_love, _planets, null, overlapped);

		//Love with player
		FlxG.overlap(_love, _player, null, overlapped);

		//Missiles and love out of bounds?
		for (m in _missiles){
			if ((m.x < 0) || (m.x > 640) || (m.y <0) || (m.y >480)){
				_missiles.remove(m,true);
				m.destroy();
			}
		}

		for (l in _love){
			if ((l.x < 0) || (l.x > 640) || (l.y <0) || (l.y >480)){
				_love.remove(l,true);
				l.destroy();
			}
		}

		//explosions ttl
		for (e in _explosions){
			e.ttl--;
			if (e.ttl <0){
				_explosions.remove(e);
				e.destroy();
			}
		}

	}	

	private function NPCPlanetAI(Timer:FlxTimer):Void{

		if (_isGameOver){
			return;
		}

		var currentPlanet:Planet = null;
		for (p in _planets){
			if (p._timer == Timer){
				currentPlanet = p;
			}
		}

		//timer does not belong to anybody -> cancel it
		if (currentPlanet == null){
			Timer.cancel();
			return;
		}

		//decides target
		var target:Planet = null;

		//loves or attacks
		if (FlxRandom.chanceRoll()){
			if (currentPlanet._lastLover != null){
				target = currentPlanet._lastLover;
			}else{
				target = chooseTargetExceptFor(currentPlanet);
			}
			lovePlanet(currentPlanet, target);
		}else{
			if (currentPlanet._lastAttacker != null){
				target = currentPlanet._lastAttacker;
			}else{
				target = chooseTargetExceptFor(currentPlanet);
			}
			attackPlanet(currentPlanet, target);
		}

		if (currentPlanet._health < 50){

		}

	}

	private function overlapped(Sprite1:FlxObject, Sprite2:FlxObject):Bool{
		var sprite1ClassName:String = Type.getClassName(Type.getClass(Sprite1));
		var sprite2ClassName:String = Type.getClassName(Type.getClass(Sprite2));

		//Missile and planet
		if ((sprite1ClassName == "Missile") && (sprite2ClassName == "Planet")){
			var m: Dynamic = cast(Sprite1,Missile);
			var p: Dynamic = cast(Sprite2,Planet);

			//avoid collision with own origin planet!
			if (m.parentObject != p){
				createExplosionAt(m.x,m.y);
				hurtPlanet(p,m);
				_missiles.remove(m,true);	
				Sprite1.destroy();
				return true;
			}	
		}

		//Love and planet
		if ((sprite1ClassName == "Love") && (sprite2ClassName == "Planet")){
			var l: Dynamic = cast(Sprite1,Love);
			var p: Dynamic = cast(Sprite2,Planet);

			//avoid collision with own origin Planet
			if (l.parentObject != p){
				upgradePlanet(p,l);
				_love.remove(l,true);	
				Sprite1.destroy();
				return true;
			}	
		}

		//Love and missile
		if ((sprite1ClassName == "Love") && (sprite2ClassName == "Missile")){
			var l: Dynamic = cast(Sprite1,Love);
			var m: Dynamic = cast(Sprite2,Missile);
			
			createExplosionAt(l.x,l.y);

			_love.remove(l,true);	
			Sprite1.destroy();
			_missiles.remove(m,true);
			Sprite2.destroy();

			FlxG.sound.play(Reg.SND_MISSILE_VS_LOVE);
			return true;	
		}

		return false;
	}

	private function attackPlanet(attacker:Planet, planet:Planet):Void{

		if (_isGameOver){
			return;
		}
		
		if (planet == null || attacker == null){
			return;
		}

		var origin:FlxPoint = attacker.getMidpoint(FlxPoint.get());

		if (attacker._level == LEVEL_1 && origin != null && planet != null && attacker != null){
			var missile = new Missile(origin.x, origin.y, planet, attacker);
			_missiles.add(missile);
		}
		if (attacker._level == LEVEL_2 && origin != null && planet != null && attacker != null){
			var missile = new Missile(origin.x,origin.y, planet, attacker);	
			_missiles.add(missile);

			var missile2 = new Missile(origin.x+10,origin.y+10, planet, attacker);	
			_missiles.add(missile2);

			var missile3 = new Missile(origin.x-10,origin.y+10, planet, attacker);	
			_missiles.add(missile3);
		}

		if (attacker._level == LEVEL_3 && origin != null && planet != null && attacker != null){
			var missile = new Missile(origin.x,origin.y, planet, attacker);	
			_missiles.add(missile);

			var missile2 = new Missile(origin.x+10,origin.y+10, planet, attacker);	
			_missiles.add(missile2);

			var missile3 = new Missile(origin.x-10,origin.y+10, planet, attacker);	
			_missiles.add(missile3);

			var missile4 = new Missile(origin.x-10,origin.y-10, planet, attacker);	
			_missiles.add(missile4);

			var missile5 = new Missile(origin.x+10,origin.y-10, planet, attacker);	
			_missiles.add(missile5);
		}

		FlxG.sound.play(Reg.SND_MISSILE_LAUNCH);
		// addMessage(attacker._name + " hates " + planet._name);
	}

	private function lovePlanet(attacker:Planet, planet:Planet):Void{
		if (_isGameOver){
			return;
		}

		if (planet == null || attacker == null){
			return;
		}

		var origin:FlxPoint = attacker.getMidpoint(FlxPoint.get());

		if (attacker._level == LEVEL_1 && origin != null && planet != null && attacker != null){
			var love = new Love(origin.x,origin.y, planet, attacker);	
			_love.add(love);
		}
		if (attacker._level == LEVEL_2 && origin != null && planet != null && attacker != null){
			var love = new Love(origin.x,origin.y, planet, attacker);	
			_love.add(love);

			var love2 = new Love(origin.x+10,origin.y+10, planet, attacker);	
			_love.add(love2);

			var love3 = new Love(origin.x-10,origin.y+10, planet, attacker);	
			_love.add(love3);
		}

		if (attacker._level == LEVEL_3 && origin != null && planet != null && attacker != null){
			var love = new Love(origin.x,origin.y, planet, attacker);	
			_love.add(love);

			var love2 = new Love(origin.x+10,origin.y+10, planet, attacker);	
			_love.add(love2);

			var love3 = new Love(origin.x-10,origin.y+10, planet, attacker);	
			_love.add(love3);

			var love4 = new Love(origin.x-10,origin.y-10, planet, attacker);	
			_love.add(love4);

			var love5 = new Love(origin.x+10,origin.y-10, planet, attacker);	
			_love.add(love5);
		}

		FlxG.sound.play(Reg.SND_LOVE_LAUNCH);
		// addMessage(attacker._name + " loves " + planet._name);
	}

	private function hurtPlanet(planet:Planet,missile:Missile):Void{
		if (_isGameOver){
			return;
		}

		planet._health -= missile.DAMAGE;
		planet._lastAttacker = missile.parentObject;

		upgradePlanetLevel(planet);

		if (planet._health < 0){
			destroyPlanet(planet);
		}

		FlxG.sound.play(Reg.SND_MISSILE_HITS);

	}

	private function upgradePlanet(planet:Planet,love:Love){
		
		if (_isGameOver){
			return;
		}

		planet._health += love.LOVE;
		if (planet._health > MAX_HEALTH){
			planet._health = MAX_HEALTH;
		}

		//Checks for health win condition
		if (_healthPlanetTarget != null){
			if (_healthPlanetTarget == planet && planet._health == MAX_HEALTH){

				gameOverByWinHealth();
			}
		}

		planet._lastLover = love.parentObject;
		
		upgradePlanetLevel(planet);

		FlxG.sound.play(Reg.SND_LOVE_HITS);
	}

	private function upgradePlanetLevel(planet:Planet):Void{
		planet._level = LEVEL_1;

		if (planet._health > HEALTH_LEVEL_2){
			planet._level = LEVEL_2;
		}

		if (planet._health > HEALTH_LEVEL_3){
			planet._level = LEVEL_3;
		}

		if (planet._nameLabel != null){
			planet._nameLabel.text = planet._name + "  LV" + planet._level; 	
		}
	}

	private function destroyPlanet(planet:Planet):Void{
		addMessage("Planet " + planet._name + " was destroyed.");

		if (planet._timer != null){
			planet._timer.cancel();	
		}

		if (planet._nameLabel != null){
			_hudElements.remove(planet._nameLabel);
			planet._nameLabel.destroy();
		}

		if (planet._lifeBar != null){
			_hudElements.remove(planet._lifeBar);
			planet._lifeBar.destroy();
		}

		//Check if player is the one being destroyed
		if (planet == _player){
			gameOverByPlayerDestruction();
		}

		//Check if destroyed planet should have survived
		if (_survivalTarget != null && planet == _survivalTarget){
			_survivalTarget = null;
			gameOverBySurvivorDestroyed();
		}

		if (_destructionTarget != null && planet == _destructionTarget){
			_destructionTarget = null;
			gameOverByWinDestruction();
		}

		//if cursor is showing and targeting destroyed planet we swap it
		if (_selectingTargetShowing && _planets.members[_currentTarget] == planet){
			_selectingTargetShowing = false;
			_targetHud.alpha = 0.0;
		}

		createExplosionAt(planet.x,planet.y);
		createExplosionAt(planet.x,planet.y+10);
		createExplosionAt(planet.x,planet.y-10);
		createExplosionAt(planet.x,planet.y+5);
		createExplosionAt(planet.x,planet.y-5);
		createExplosionAt(planet.x+10,planet.y);
		createExplosionAt(planet.x-10,planet.y);
		createExplosionAt(planet.x+5,planet.y);
		createExplosionAt(planet.x-5,planet.y);
		createExplosionAt(planet.x+5,planet.y+5);
		createExplosionAt(planet.x+5,planet.y-5);
		createExplosionAt(planet.x-5,planet.y+5);
		createExplosionAt(planet.x-5,planet.y-5);
		createExplosionAt(planet.x+10,planet.y+10);
		createExplosionAt(planet.x+10,planet.y-10);
		createExplosionAt(planet.x-10,planet.y+10);
		createExplosionAt(planet.x-10,planet.y-10);

		_planets.remove(planet,true);
		planet.destroy();
	}

	public function createExplosionAt(x:Float,y:Float){
		var newExplosion = new Explosion(x,y);
		_explosions.add(newExplosion);
	}

	private function gameOver(){

		_gameOverTitle = new FlxText(200,200,300,"GAME OVER", 40);
		add(_gameOverTitle);
		_gameOverSubTitle = new FlxText(130,300,500,"Press SPACE to go back to menu", 20);
		add(_gameOverSubTitle);

		if (_controlPanelShowing){
			hideControlPanel();
		}
		addMessage("GAME OVER");
		_isGameOver = true;
	}

	private function gameOverByPlayerDestruction(){
		_gameOverTitle = new FlxText(200,200,300,"GAME OVER", 40);
		add(_gameOverTitle);
		_gameOverSubTitle = new FlxText(130,300,500,"Press SPACE to go back to menu", 20);
		add(_gameOverSubTitle);

		if (_controlPanelShowing){
			hideControlPanel();
		}
		addMessage("Your planet was destroyed");
		addMessage("GAME OVER");
		_isGameOver = true;
	}

	private function gameOverBySurvivorDestroyed(){
		_gameOverTitle = new FlxText(200,200,300,"GAME OVER", 40);
		add(_gameOverTitle);
		_gameOverSubTitle = new FlxText(130,300,500,"Press SPACE to go back to menu", 20);
		add(_gameOverSubTitle);

		if (_controlPanelShowing){
			hideControlPanel();
		}
		addMessage("GAME OVER");
		_isGameOver = true;
	}

	private function gameOverByWinHealth(){
		_gameOverTitle = new FlxText(210,200,300,"YOU WIN", 40);
		add(_gameOverTitle);
		_gameOverSubTitle = new FlxText(130,300,500,"Press SPACE to go back to menu", 20);
		add(_gameOverSubTitle);

		if (_controlPanelShowing){
			hideControlPanel();
		}
		addMessage("SUCCESS!");
		_isGameOver = true;
	}

	private function gameOverByWinDestruction(){
		_gameOverTitle = new FlxText(210,200,300,"YOU WIN", 40);
		add(_gameOverTitle);
		_gameOverSubTitle = new FlxText(130,300,500,"Press SPACE to go back to menu", 20);
		add(_gameOverSubTitle);

		if (_controlPanelShowing){
			hideControlPanel();
		}
		addMessage("SUCCESS!");
		_isGameOver = true;
	}



	private function updateMessageBoard(Timer:FlxTimer):Void{
		if (_messageArray.length > 0){
			var newMessage:String = _messageArray.last();
			_messageArray.remove(newMessage);
			_messageBoardSlot3.text = _messageBoardSlot2.text;
			_messageBoardSlot2.text = _messageBoardSlot1.text;
			_messageBoardSlot1.text = newMessage;
		}else{
			_messageBoardSlot3.text = _messageBoardSlot2.text;
			_messageBoardSlot2.text = _messageBoardSlot1.text;
			_messageBoardSlot1.text = "";
		}
	}

	private function addMessage(message:String){
		_messageArray.push(message);
	}

	private function showControlPanel(Timer:FlxTimer):Void{
		if (!_isGameOver){
			if (!_controlPanelShowing){
				//cancels timer
				_playerTurnTimer.cancel();
				//shows control panel and allows interaction
				for(sprite in _hudElements){
					sprite.alpha = 1.0;
				}
				_targetHud.alpha = 0.0;
				_controlPanelShowing = true;
			}
		}
	}

	private function hideControlPanel():Void{
		if (_controlPanelShowing){
			//hides control panel and allows interaction
			for(sprite in _hudElements){
				sprite.alpha = 0.0;
			}
			_controlPanelShowing = false;
			_selectingTargetShowing = false;
		}
	}

	private function planetStillExists(planet:Planet):Bool{
		for (p in _planets){
			if (p == planet){
				return true;
			}
		}
		return false;
	}

	private function chooseTargetExceptFor(planet:Planet):Planet{
		var avoidIndex:Array<Int> = new Array<Int>();

		//targets player with 20% chance
		if (FlxRandom.chanceRoll(20)){
			return _player;
		}

		for(i in 0..._planets.members.length){
			if (_planets.members[i] == planet){
				avoidIndex[0] = i;
			}
		}

		if (avoidIndex.length == 0){
			return null;
		}

		var index =  FlxRandom.intRanged(0, _planets.members.length,avoidIndex);
		
		return _planets.members[index];
	}

}