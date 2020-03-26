/**
 *  PlayState.hx - Handles the actual game state
 *  
 *  TODO: Code clean/doc pass
 */
package states;

import systems.SaveLoad;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.util.FlxAxes;
import flixel.text.FlxText;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;

import systems.Input;
import systems.GameVars;
import components.HUD;
import entities.Player;
import entities.enemies.Enemy;
import entities.enemies.bosses.Boss;
import entities.projectiles.Bullet;
import entities.projectiles.EnemyBullet;
import entities.AnimatedTiles;

class PlayState extends FlxState
{
	public var score:Int;
	public var entities:FlxTypedGroup<FlxBasic>;
	public var gameVars:GameVars;

	private var _money:Int = 0;
	private var _hud:HUD;
	private var _player:Player;
	private var _input:Input;

	private var _target:FlxSprite;
	private var _levelComplete:Bool;

	private var _map:FlxOgmo3Loader;
 	private var _mWalls:FlxTilemap;

	private var _animatedTiles:FlxTypedGroup<AnimatedTiles>;

	private var _enemies:FlxTypedGroup<Enemy>;
	private var _bullets:FlxTypedGroup<Bullet>;
	private var _enemyBullets:FlxTypedGroup<EnemyBullet>;

	private var _bossTrigger:FlxSprite;
	private var _bossSpawned:Bool;
	private var _bossNum:Int;
	private var _bossX:Float;
	private var _bossY:Float;

#if CHEATS
	public var cheats:Bool;
	public var godMode:Bool;
	public var dumbEnemyAI:Bool;
#end

	override public function create():Void
	{
		#if CHEATS
			cheats = false;
			godMode = false;
			dumbEnemyAI = false;
		#end

		FlxG.mouse.visible = false;
		_bossSpawned = false;
		_levelComplete = false;

		entities = new FlxTypedGroup<FlxBasic>();

		_animatedTiles = new FlxTypedGroup<AnimatedTiles>();
		_enemies = new FlxTypedGroup<Enemy>();
		_bullets = new FlxTypedGroup<Bullet>();
		_enemyBullets = new FlxTypedGroup<EnemyBullet>();
		_map = new FlxOgmo3Loader(AssetPaths.SSHMUP__ogmo, gameVars.level.getPath()); 

		var tileSet = gameVars.level.getTileset();
		_mWalls = _map.loadTilemap(tileSet.getPath(), "walls");
		_mWalls.follow();
		tileSet.setProperties(_mWalls);
		_map.loadEntities(placeAnimatedTiles, "animatedTiles");

		add(_mWalls);
		add(_animatedTiles);

		_map.loadEntities(placeEntities, "entities");

		_target = new FlxSprite(_player.x, _player.y - 100);

		score = 0;

		entities.add(cast(_bullets, FlxBasic));
		entities.add(cast(_enemyBullets, FlxBasic));
		entities.add(cast(_player, FlxBasic));
		entities.add(cast(_enemies, FlxBasic));
		add(entities);

		_hud = new HUD(this);
		add(_hud);

		_input = new Input(this);
		_player.resetWeapons();

		FlxG.camera.follow(_target, TOPDOWN_TIGHT, 1);

		super.create();
	}

	private var _yTest:Float = 0;
	private var _playerRespawn:Bool = false;
	override public function update(elapsed:Float):Void
	{
		if (!playerRespawning(elapsed)) return;

		if (_levelComplete) {
			handleLevelComplete(elapsed);
			return;
		}
		_input.update(elapsed);

		if (FlxG.keys.pressed.ESCAPE) {
			backToIntermission();
		}

		#if CHEATS
			if (FlxG.keys.pressed.F5) {
				cheats = true;
				var chtText = new FlxText(0, 0, -1, "DEVCHEATS", 16, true);
				chtText.x = FlxG.width - chtText.width;
				chtText.y = FlxG.height - chtText.height;
				chtText.scrollFactor.x = 0;
				chtText.scrollFactor.y = 0;
				add(chtText);
			}
			if (FlxG.keys.pressed.F7 && cheats) {
				godMode = true;
			}
			if (FlxG.keys.pressed.F8 && cheats) {
				dumbEnemyAI = true;
			}
		#end

		FlxG.collide(_player, _mWalls);
		FlxG.overlap(_bullets, _enemies, bulletHitEnemy);
		FlxG.overlap(_player, _enemyBullets, enemyBulletHitPlayer);
		FlxG.overlap(_player, _enemies, playerHitEnemy);
		FlxG.overlap(_bossTrigger, _player, bossTriggered);

		//_target.x = _player.x;
		if (_player.isOnScreen()) {
			_target.y -= 75*elapsed;
		}

		super.update(elapsed);
	}

	private function playerRespawning(elapsed:Float):Bool
	{
		if (_playerRespawn == true) {
			if (_player.animation.curAnim.name != "death") {
				if (_player.health == 0) {
					// todo play boom animation
					entities.remove(_player);
					_player = new Player(FlxG.width/2-16, _target.y+140, this);
					_player.health = 1;
					entities.add(_player);
					_input = new Input(this);
				}
				if (_player.health != 100) {
					_player.health++;
					_hud.update(elapsed);
				}

				if (_player.y != _target.y + 100) {
					_player.y -= 150*elapsed;
					if (_player.y < _target.y + 100) {
						_player.y = _target.y + 100;
					}
				}

				if (_player.health == 100 && _player.y == _target.y + 100) {
					_playerRespawn = false;
				}
			} else {
				_player.update(elapsed);
			}

			return false;
		}
		return true;
	}

	private function bossTriggered(trigger:FlxSprite, player:Player)
	{
		_bossTrigger.kill();
		switch _bossNum {
			case 0:
				_enemies.add(new entities.enemies.bosses.DerpBoss(_bossX, _bossY, 1, this));
			case 1:
				_enemies.add(new entities.enemies.bosses.Boss1(_bossX, _bossY, 1, this));
			default:
				_enemies.add(new entities.enemies.bosses.DerpBoss(_bossX, _bossY, 1, this));
		}
		_bossSpawned = true;
	}

	public function addBullet(bullet:Bullet):Void
	{
		_bullets.add(bullet);
	}

	public function addEnemyBullet(bullet:EnemyBullet):Void
	{
		_enemyBullets.add(bullet);
	}

	public function bulletHitEnemy(bullet:Bullet, enemy:Enemy):Void
	{
		if (!FlxG.pixelPerfectOverlap(bullet, enemy)) return;
		if (!enemy.getImmune()) {
			enemy.health -= bullet.damage;

			if (enemy.health <= 0) {
				score += enemy.getPointWorth();
				enemy.kill();
			}

			bullet.kill();
		}
	}

	public function playerHitEnemy(player:Player, enemy:Enemy):Void
	{
		if (!FlxG.pixelPerfectOverlap(player, enemy)) return;
		if (Std.is(enemy, Boss)) {
			hurtPlayer(1);
		} else {
			hurtPlayer(25);
			enemy.kill();
		}
	}

	public function enemyBulletHitPlayer(player:Player, enemyBullet:EnemyBullet):Void
	{
		if (!FlxG.pixelPerfectOverlap(player, enemyBullet)) return;
		hurtPlayer(enemyBullet.damage);

		enemyBullet.kill();
	}

	public function hurtPlayer(damage:Int):Void
	{
		#if CHEATS
			if (!godMode)
			{
		#end
				_player.health -= damage;
		#if CHEATS
			}
		#end
		
		if (_player.health <= 0) {
			var gameOverState = new GameOver();
			gameOverState.setGameVars(gameVars);
			FlxG.switchState(gameOverState);
		}
	}
	
	public function getPlayer():Player
	{
		return _player;
	}

	public function endLevel():Void
	{
		var winText = new FlxText(0, 0, -1, "LEVEL COMPLETE", 16, true);
		winText.screenCenter(FlxAxes.XY);
		add(winText);
		_levelComplete = true;
		gameVars.completedLevel++;
	}

	private function placeEntities(entityData:EntityData):Void
	{
		var x:Int = entityData.x;
		var y:Int = entityData.y;
		if (entityData.name == "player") {
			_player = new Player(x, y, this);
		} else if (entityData.name == "drone") {
			_enemies.add(new entities.enemies.Drone(x, y, entityData.values.direction, this));
		} else if (entityData.name == "stealth") {
			_enemies.add(new entities.enemies.Stealth(x, y, entityData.values.direction, this));
		} else if (entityData.name == "copter") {
			_enemies.add(new entities.enemies.Copter(x, y, this));
		} else if (entityData.name == "kamikaze") {
			_enemies.add(new entities.enemies.Kamikaze(x, y, this));
		} else if (entityData.name == "smarty") {
			_enemies.add(new entities.enemies.Smarty(x, y, this));
		} else if (entityData.name == "deathsquad") {
			_enemies.add(new entities.enemies.DeathSquad(x, y, this));
		} else if (entityData.name == "boss") {
			_bossX = x;
			_bossY = y;
			_bossNum = entityData.values.bossnum;
		} else if (entityData.name == "bossspawn") {
			_bossTrigger = new FlxSprite(x, y);
			_bossTrigger.width = 640;
			_bossTrigger.height = 16;
		}
	}

	private function placeAnimatedTiles(entityData:EntityData):Void
	{
		_animatedTiles.add(new AnimatedTiles(entityData));
	}

	private var _goingLeft:Int = -1;
	private function handleLevelComplete(elapsed:Float):Void
	{
		if (_goingLeft == -1) {
			for (eB in _enemyBullets) {
				eB.kill();
			}
			for (pB in _bullets) {
				pB.kill();
			}
		}

		if (_player.x != (FlxG.width/2)-(_player.width/2)) {
			if (_player.x > (FlxG.width/2)-(_player.width/2)) {
				if (_goingLeft < 0) {
					_goingLeft = 1;
				}
				if (_goingLeft == 0) {
					_player.x = (FlxG.width/2)-(_player.width/2);
				} else {
					_player.x -= 100 * elapsed;
				}
			} else {
				if (_goingLeft < 0) {
					_goingLeft = 0;
				}
				if (_goingLeft == 1) {
					_player.x = (FlxG.width/2)-(_player.width/2);
				} else {
					_player.x += 100 * elapsed;
				}
			}
		} else {
			_player.y -= 100 * elapsed;
		}
		super.update(elapsed);
		if (_player.y <= 0-_player.height) {
			backToIntermission();
		}
	}

	private function backToIntermission():Void
	{
		gameVars.score += score;
		SaveLoad.saveGame(gameVars);

		var newState = new IntermissionState();
		newState.setGameVars(gameVars);
		FlxG.switchState(newState);
	}
}