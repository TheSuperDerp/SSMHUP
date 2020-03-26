/**
 *  Bullet.hx - Basic player projectile
 */

package entities.projectiles;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import states.PlayState;

class Bullet extends FlxSprite {
	public var damage:Int;

	public function new(?X:Float = 0, ?Y:Float = 0, ?Angle:Float = 0, playState:PlayState):Void {
		super(X, Y);
		loadGraphic(AssetPaths.Bullet__png);
		x = playState.getPlayer().getGraphicMidpoint().x - 4;
		y = playState.getPlayer().y - 4;

		health = 1;
		angle = Angle;
		damage = 1;
		velocity.set(500, 0);
		velocity.rotate(FlxPoint.weak(0, 0), Angle + 270);

		playState.addBullet(this);
	}

	public override function update(elapsed:Float):Void {
		super.update(elapsed);

		if (y < FlxG.camera.scroll.y - graphic.height) {
			kill();
		}
	}
}
