/**
 *  Enemy.hx - Base class used for all enemies
 */

package entities.enemies;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.ui.FlxBar;
import states.PlayState;
import flixel.system.FlxAssets;

class Enemy extends FlxSprite {
	private var _maxHealth:Int;
	private var _healthBar:FlxBar;
	private var _playState:PlayState;
	private var _lastShotTick:Int;
	private var _fireRate:Int;
	private var _points:Int;
	private var _derp:Bool;
	private var _immune:Bool;
	private var _healthHeight:Int;

	public function new(?X:Float = 0, ?Y:Float = 0, playState:PlayState, ?simpleGraphic:FlxGraphicAsset):Void {
		super(X, Y, simpleGraphic);
		// hack for bosses
		_healthHeight = 3;
		_playState = playState;
		_immune = false;
		_maxHealth = 1;

		if (graphic == null) {
			_healthBar = new FlxBar(0, 0, LEFT_TO_RIGHT, 32, _healthHeight);
		} else {
			_healthBar = new FlxBar(0, 0, LEFT_TO_RIGHT, graphic.width, _healthHeight);
		}
		_healthBar.createFilledBar(FlxColor.fromRGB(158, 35, 38), FlxColor.GREEN);
		_healthBar.setRange(0, _maxHealth);

		_playState.entities.add(_healthBar);

		_lastShotTick = 0;
		_fireRate = 999;
		_points = 0;
		_derp = false;
	}

	public override function update(elapsed:Float):Void {
		super.update(elapsed);

		if (y >= FlxG.camera.scroll.y && _derp && y <= FlxG.camera.scroll.y + FlxG.height) {
			_healthBar.setRange(0, _maxHealth);
			_healthBar.value = health;
			_healthBar.x = x;
			_healthBar.y = y - 7;

			if (FlxG.game.ticks >= _lastShotTick + _fireRate) {
				fire();
			}
		}

		if (y >= FlxG.camera.scroll.y + FlxG.height && _derp) {
			// _playState.hurtPlayer(10); // This is unfair
			kill();
		}

		// One frame hack
		if (FlxG.camera.scroll.y == 0 && !_derp) {
			_derp = true;
		}
	}

	public override function kill():Void {
		super.kill();
		_healthBar.kill();
	}

	public function fire():Void {}

	public function getImmune():Bool {
		return _immune;
	}

	public function getPointWorth():Int {
		return _points;
	}
}
