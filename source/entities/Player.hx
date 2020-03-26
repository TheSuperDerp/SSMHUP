/**
 *  Player.hx - THe player class
 *  Simple FlxSprite that handles weapon swapping
 *  and animation, for everything else see systems/Input.hx
 *  and states/PlayState.hx
 */

package entities;

import flixel.FlxG;
import flixel.FlxSprite;
import states.PlayState;
import entities.weapons.Weapon;

class Player extends FlxSprite {
	private var _weapons:Array<Weapon>;
	private var _playState:PlayState;
	private var _hasDerped:Bool;
	private var _isDead:Bool;

	public function new(?X:Float = 0, ?Y:Float = 0, playState:PlayState) {
		super(X, Y);
		_playState = playState;
		_weapons = new Array<Weapon>();
		for (item in _playState.gameVars.playerItems) {
			if (Std.is(item, Weapon)) {
				_weapons.push(cast(item, Weapon));
			}
		}

		loadGraphic(AssetPaths.Player__png, true, 32, 32);
		animation.add("ship", [0, 1, 2, 3], 12, true);
		animation.add("death", [0, 1, 0, 1], 1, false);
		animation.add("idle", [0], 0, true);
		animation.play("ship");
		health = 100;
		_hasDerped = false;
		_isDead = false;
	}

	public override function update(elapsed:Float) {
		super.update(elapsed);
		if (animation.curAnim.name != "death") {
			if (FlxG.camera.scroll.y != 0) {
				y -= 75 * elapsed;
			} else {
				if (!_hasDerped) {
					// There is a 1 frame window at the start where this will get called.
					_hasDerped = true;
				} else {
					if (!animation.finished) {
						animation.play("idle");
					}
				}
			}
		} else if (animation.finished) {
			animation.play("idle");
		}
	}

	public override function kill():Void {
		animation.play("death");
	}

	public function fire(playState:PlayState):Void {
		for (wP in _weapons) {
			wP.fire(playState);
		}
	}

	public function resetWeapons():Void {
		for (wP in _weapons) {
			wP.resetShots();
		}
	}
}
