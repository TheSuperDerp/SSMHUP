/**
 *  DerpBoss.hx:
 *      - Another test boss
 */

package entities.enemies.bosses;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import states.PlayState;
import entities.projectiles.EnemyBullet;

class DerpBoss extends Boss {
	private var _speed:Int = 100;

	public function new(?X:Float = 0, ?Y:Float = 0, ?Direction:Int = FlxObject.RIGHT, playState:PlayState):Void {
		_healthHeight = 15;
		super(X, Y, playState, AssetPaths.DerpBoss__png);
		_playState.entities.remove(_healthBar);
		_maxHealth = 500;
		_fireRate = 700;
		_points = 10000;
		health = 500;
		this.facing = Direction;
	}

	public override function update(elapsed:Float):Void {
		if (_inPosition) {
			if (this.facing == FlxObject.RIGHT) {
				x += elapsed * _speed;
				if (x >= FlxG.width - (width + 16)) {
					this.facing = FlxObject.LEFT;
				}
			} else if (this.facing == FlxObject.LEFT) {
				x -= elapsed * _speed;
				if (x <= 16) {
					this.facing = FlxObject.RIGHT;
				}
			}
		}

		super.update(elapsed);
	}

	public override function fire():Void {
		if (!_inPosition)
			return;
		var bullet:EnemyBullet;

		for (i in 1...10) {
			bullet = new EnemyBullet(x + 11, y + 25, _playState);
			bullet.velocity.set(100, 0);
			bullet.velocity.rotate(FlxPoint.weak(0, 0), 90 - (i * 2));
		}
		for (i in 1...10) {
			bullet = new EnemyBullet(x + width - 11, y + 25, _playState);
			bullet.velocity.set(100, 0);
			bullet.velocity.rotate(FlxPoint.weak(0, 0), 90 + (i * 2));
		}
		_lastShotTick = FlxG.game.ticks;
	}
}
