/**
 *  Boss.hx - This is the base Boss class.
 *  All bosses should extend this class
 */

package entities.enemies.bosses;

import states.PlayState;
import entities.enemies.Enemy;
import flixel.system.FlxAssets;

class Boss extends Enemy {
	private var _inPosition:Bool = false;

	public function new(?X:Float = 0, ?Y:Float = 0, playState:PlayState, ?simpleGraphic:FlxGraphicAsset):Void {
		super(X, Y, playState, simpleGraphic);
		_immune = true;
	}

	public override function update(elapsed:Float):Void {
		if (!_inPosition) {
			y += 50 * elapsed;
			if (y >= get_height() + 35) {
				y = get_height() + 35;
				_inPosition = true;
				_immune = false;
				_playState.entities.add(_healthBar);
			}
		}

		super.update(elapsed);
	}

	public override function kill():Void {
		super.kill();
		_playState.endLevel();
	}
}
