/**
 *  Boss1.hx
 *      - Test boss
 */

package entities.enemies.bosses;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.ui.FlxBar;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import states.PlayState;
import entities.projectiles.EnemyBullet;

class Boss1 extends Boss {
	private var _speed:Int = 100;

	public function new(?X:Float = 0, ?Y:Float = 0, ?Direction:Int = FlxObject.RIGHT, playState:PlayState):Void {
		super(X, Y, playState, null);
		loadGraphic(AssetPaths.Boss1__png, true, 164, 47);
		animation.add("flyin", [4, 5], 12, true);
		animation.add("ship", [0, 1, 2, 3,], 12, true);

		animation.play("flyin");
		x = (FlxG.width / 2) - (width / 2);
		_playState.entities.remove(_healthBar);
		_maxHealth = 150;
		_fireRate = 150;
		_points = 1000;
		health = _maxHealth;
		this.facing = Direction;

		playState.entities.remove(_healthBar);
		_healthBar = new FlxBar(0, 0, LEFT_TO_RIGHT, 164, 3);
		_healthBar.createFilledBar(FlxColor.fromRGB(158, 35, 38), FlxColor.GREEN);
		_healthBar.setRange(0, 150);
		_healthBar.value = 150;
	}

	public override function update(elapsed:Float):Void {
		if (_inPosition) {
			if (animation.curAnim.name != "ship") {
				animation.play("ship", true);
			}
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
		// 50x43
		bullet = new EnemyBullet(x + 50, y + 43, _playState);
		bullet.velocity.set(600, 0);
		bullet.velocity.rotate(FlxPoint.weak(0, 0), 90);
		// 114x43
		bullet = new EnemyBullet(x + 114, y + 43, _playState);
		bullet.velocity.set(600, 0);
		bullet.velocity.rotate(FlxPoint.weak(0, 0), 90);

		_lastShotTick = FlxG.game.ticks;
	}
}
