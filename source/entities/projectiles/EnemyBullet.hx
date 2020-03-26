/**
 *  EnemyBullet.hx - Basic Enemy projectile
 */

package entities.projectiles;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import states.PlayState;

class EnemyBullet extends FlxSprite {
	public var damage:Int;

	public function new(?X:Float = 0, ?Y:Float = 0, playState:PlayState, ?Angle:Int = 90):Void {
		super(X, Y);
		loadGraphic(AssetPaths.EnemyBullet__png);
		health = 1;
		angle = Angle;
		damage = 1;
		velocity.set(500, 0);
		velocity.rotate(FlxPoint.weak(0, 0), angle);

		playState.addEnemyBullet(this);
	}

	public override function update(elapsed:Float):Void {
		super.update(elapsed);

		if (y >= FlxG.camera.scroll.y + FlxG.height) {
			kill();
		}
	}
}
