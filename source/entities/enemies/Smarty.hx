/**
 *  Smarty.hx
 *      - Flies in a line
 *      - Aims at the player while shooting
 */

package entities.enemies;

import flixel.FlxG;
import states.PlayState;
import flixel.math.FlxAngle;
import entities.projectiles.EnemyBullet;

class Smarty extends Enemy {
	private var _speed:Int = 50;

	public function new(?X:Float = 0, ?Y:Float = 0, playState:PlayState):Void {
		super(X, Y, playState, null);
		loadGraphic(AssetPaths.Smarty__png, true, 32, 32);
		animation.add("ship", [0, 1, 2], 12, true);
		animation.play("ship");
		_maxHealth = 5;
		_fireRate = 600;
		_points = 200;
		health = 5;
	}

	public override function update(elapsed:Float):Void {
		if (isOnScreen()) {
			y += _speed * elapsed;
		}
		super.update(elapsed);
	}

	public override function fire():Void {
		var shotAngle:Float = FlxAngle.angleBetween(this, _playState.getPlayer(), true);
		if (shotAngle > 0 && shotAngle < 180) {
			new EnemyBullet(x + 15, y + 21, _playState, Math.round(FlxAngle.angleBetween(this, _playState.getPlayer(), true)));
		}
		_lastShotTick = FlxG.game.ticks;
	}
}
