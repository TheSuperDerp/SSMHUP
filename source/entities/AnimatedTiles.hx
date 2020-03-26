/**
 *  AnimatedTiles.hx - Handles animation of tiles.
 *
 *  TODO: Extend to allow player to destroy tiles
 */

package entities;

import flixel.addons.editors.ogmo.FlxOgmo3Loader.EntityData;
import flixel.FlxSprite;

class AnimatedTiles extends FlxSprite {
	public function new(entityData:EntityData):Void {
		var OffSetX = entityData.values.offsetX;
		var OffSetY = entityData.values.offsetY;
		var X = entityData.x - OffSetX;
		var Y = entityData.y - OffSetY;
		var FrameRate = entityData.values.frameRate;
		var Frames:Array<Int> = new Array();
		for (x in 0...entityData.values.totalFrame) {
			Frames.push(x);
		}

		super(X, Y);
		loadGraphic(entityData.values.assetPath, true, 16 + OffSetX, 16 + OffSetY);

		animation.add("loop", Frames, FrameRate, true);
		animation.play("loop");
	}
}
