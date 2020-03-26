/**
 *  Kamikaze.hx
 *      - Doesn't shoot
 *      - Flies at the player and tries to hit them
 */

package entities.enemies;

import flixel.FlxG;
import flixel.FlxObject;
import states.PlayState;
import flixel.math.FlxPoint;

class Kamikaze extends Enemy {
	private var _speed:Int = 100;

	public function new(?X:Float = 0, ?Y:Float = 0, playState:PlayState):Void {
		super(X, Y, playState, null);
		loadGraphic(AssetPaths.Kamikaze__png, true, 32, 32);
		animation.add("ship", [0, 1, 2, 3], 12, true);
		animation.play("ship");
		_maxHealth = 5;
		_fireRate = 600;
		_points = 200;
		health = 5;
		facing = FlxObject.LEFT;
	}

	public override function update(elapsed:Float):Void {
		var speed = 100 * elapsed;

		if (isOnScreen()) {
			if (!(getScreenPosition(FlxPoint.get(x, y)).y >= FlxG.height - (FlxG.height * 0.33))) {
				if (_playState.getPlayer().x > x)
					x += speed;
				if (_playState.getPlayer().x < x)
					x -= speed;
			} /* else if (getScreenPosition(FlxPoint.get(x, y)).y >= FlxG.height-64) {
				// EXPLODE
				var explosion = new EnemyBullet(x, y, _playState, 90);
				explosion.scale.set(25, 25);
				kill();
			}*/
			y += speed;
		}
		super.update(elapsed);
	}
}
