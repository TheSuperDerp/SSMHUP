/**
 *  Copter.hx
 *      - Basic enemy
 *      - Flys in a line
 *      - Shoots 2 bullets (-45d and 45d, for a 90degree coverage)
 */

package entities.enemies;

import flixel.FlxG;
import states.PlayState;
import entities.projectiles.EnemyBullet;

class Copter extends Enemy {
	private var _speed:Int = 100;

	public function new(?X:Float = 0, ?Y:Float = 0, playState:PlayState):Void {
		super(X, Y, playState, null);
		loadGraphic(AssetPaths.Copter__png, true, 32, 32);
		animation.add("ship", [0, 1, 2, 3], 12, true);
		animation.play("ship");
		_maxHealth = 5;
		_fireRate = 600;
		_points = 200;
		health = 5;
	}

	public override function update(elapsed:Float):Void {
		if (isOnScreen()) {
			y += 15 * elapsed;
		}
		super.update(elapsed);
	}

	public override function fire():Void {
		new EnemyBullet(x + 8, y + 26, _playState, 120);
		new EnemyBullet(x + 20, y + 26, _playState, 60);
		_lastShotTick = FlxG.game.ticks;
	}
}
