/**
 *  Stealth.hx
 *      - Fires 2 bullets while alive
 *      - Crosses the screen then heads down
 */

package entities.enemies;

import flixel.FlxG;
import flixel.FlxObject;
import states.PlayState;
import flixel.math.FlxPoint;
import entities.projectiles.EnemyBullet;

class Stealth extends Enemy {
	private var _speed:Int = 100;

	public function new(?X:Float = 0, ?Y:Float = 0, ?Direction:Int = FlxObject.RIGHT, playState:PlayState):Void {
		super(X, Y, playState, null);
		loadGraphic(AssetPaths.Stealth__png, true, 32, 32);
		animation.add("ship", [3, 2, 1, 0], 12, true);
		animation.play("ship");
		_maxHealth = 5;
		_fireRate = 600;
		_points = 200;
		health = 5;
		facing = Direction;
	}

	public override function update(elapsed:Float):Void {
		var speed = 100 * elapsed;

		if (isOnScreen()) {
			if (getScreenPosition(FlxPoint.get(x, y)).y >= (FlxG.height * 0.33) && facing != FlxObject.DOWN) {
				y -= speed;
				switch (facing) {
					case FlxObject.RIGHT:
						x += speed;
						if (x >= FlxG.width * 0.66) {
							facing = FlxObject.DOWN;
						}
					case FlxObject.LEFT:
						x -= speed;
						if (x <= FlxG.width * 0.33) {
							facing = FlxObject.DOWN;
						}
				}
			} else {
				y += speed;
			}
		}
		super.update(elapsed);
	}

	public override function fire():Void {
		new EnemyBullet(x + 9, y + 26, _playState, 90);
		new EnemyBullet(x + 19, y + 26, _playState, 90);
		_lastShotTick = FlxG.game.ticks;
	}
}
