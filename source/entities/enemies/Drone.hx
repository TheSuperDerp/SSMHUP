/**
 *  Drone.hx
 *      - Dumb
 *      - Doesn't do anything
 *      - First enemy
 */

package entities.enemies;

import flixel.FlxG;
import flixel.FlxObject;
import states.PlayState;

class Drone extends Enemy {
	private var _speed:Int = 100;

	public function new(?X:Float = 0, ?Y:Float = 0, ?Direction:Int = FlxObject.RIGHT, playState:PlayState):Void {
		super(X, Y, playState, null);
		loadGraphic(AssetPaths.Drone__png, true, 32, 32);
		animation.add("ship", [0, 1, 2, 3], 24, true);
		animation.play("ship");
		_maxHealth = 5;
		// _fireRate = 400;
		_points = 100;
		health = 5;
		this.facing = Direction;
	}

	public override function update(elapsed:Float):Void {
		if (isOnScreen()) {
			if (this.facing == FlxObject.RIGHT) {
				x += elapsed * _speed;
				if (x >= FlxG.width - 32 - 16) {
					this.facing = FlxObject.LEFT;
				}
			} else if (this.facing == FlxObject.LEFT) {
				x -= elapsed * _speed;
				if (x <= 16) {
					this.facing = FlxObject.RIGHT;
				}
			}

			y += 15 * elapsed;
		}
		super.update(elapsed);
	}
}
