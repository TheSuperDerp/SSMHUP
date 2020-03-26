/**
 *  DeathSquad.hx
 *      - Flies in a line
 *      - Fires 2 bullets in a line while alive
 *      - On death shoots out a 180 degrees worth of bullets
 */

package entities.enemies;

import flixel.FlxG;
import states.PlayState;
import entities.projectiles.EnemyBullet;

class DeathSquad extends Enemy {
	private var _speed:Int = 100;

	public function new(?X:Float = 0, ?Y:Float = 0, playState:PlayState):Void {
		super(X, Y, playState, null);
		loadGraphic(AssetPaths.DeathSquad__png, true, 32, 32);
		animation.add("ship", [0, 1, 2, 3], 12, true);
		animation.play("ship");
		_maxHealth = 5;
		_fireRate = 600;
		_points = 200;
		health = 5;
	}

	public override function update(elapsed:Float):Void {
		var speed = 100 * elapsed;

		if (isOnScreen()) {
			y += speed;
		}
		super.update(elapsed);
	}

	public override function fire():Void {
		// 10x28
		new EnemyBullet(x + 10, y + 28, _playState, 90);
		// 20x28
		new EnemyBullet(x + 20, y + 28, _playState, 90);
		_lastShotTick = FlxG.game.ticks;
	}

	public override function kill():Void {
		new EnemyBullet(x + 16, y + 16, _playState, 90);
		for (i in 1...6) {
			new EnemyBullet(x + 16, y + 16, _playState, 90 - (i * 9));
		}
		for (i in 1...6) {
			new EnemyBullet(x + 16, y + 16, _playState, 90 + (i * 9));
		}
		super.kill();
	}
}
