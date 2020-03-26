/**
 *  ChainGun.hx - THe starting player weapon
 */

package entities.weapons;

import flixel.FlxG;
import entities.projectiles.Bullet;

class ChainGun extends Weapon {
	public function new() {}

	public override function getName():String {
		return "Chain Gun";
	}

	public override function fire(playState:states.PlayState):Bool {
		if (FlxG.game.ticks >= _lastShotTick + 40) {
			var bX:Float = playState.getPlayer().getGraphicMidpoint().x;
			var bY:Float = playState.getPlayer().getGraphicMidpoint().y - 8;
			new Bullet(bX, bY, 0, playState);
			_lastShotTick = FlxG.game.ticks;
			return true;
		} else {
			return false;
		}
	}
}
