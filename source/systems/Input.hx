/**
 *  Input.hx - Handles player input during the game state
 */

package systems;

import flixel.FlxG;
import flixel.math.FlxPoint;
import states.PlayState;

class Input {
	private var _playState:PlayState;

	private var _speed:Float = 300;
	private var _up:Bool = false;
	private var _down:Bool = false;
	private var _left:Bool = false;
	private var _right:Bool = false;
	private var _canFire:Bool = true;
	private var _fireRate:Float = 0.1;
	private var _fireTime:Float = 0.0;
	private var _leftBounds:Float = 18;
	private var _rightBounds:Float = 0;

	public function new(?playState:PlayState):Void {
		_playState = playState;
		_playState.getPlayer().drag.x = _playState.getPlayer().drag.y = 1600;
		_rightBounds = FlxG.width - _playState.getPlayer().width - 18;
	}

	private function updateKeyboard(elapsed:Float):Void {
		_up = FlxG.keys.anyPressed([UP]);
		_down = FlxG.keys.anyPressed([DOWN]);
		_left = FlxG.keys.anyPressed([LEFT]);
		_right = FlxG.keys.anyPressed([RIGHT]);

		if (_up && _down)
			_up = _down = false;
		if (_left && _right)
			_left = _right = false;

		if (_playState.getPlayer().x <= _leftBounds) {
			_left = false;
			_playState.getPlayer().x = _leftBounds;
		}
		if (_playState.getPlayer().x >= _rightBounds) {
			_right = false;
			_playState.getPlayer().x = _rightBounds;
		}
		if (_playState.getPlayer().y <= FlxG.camera.scroll.y + 48)
			_up = false;
		if (_playState.getPlayer().y >= FlxG.camera.scroll.y + (FlxG.height - 64))
			_down = false;

		if (_up || _down || _left || _right) {
			var mA:Float = 0;

			if (_up) {
				mA = -90;
				if (_left)
					mA -= 45;
				else if (_right)
					mA += 45;
			} else if (_down) {
				mA = 90;
				if (_left)
					mA += 45;
				else if (_right)
					mA -= 45;
			} else if (_left) {
				mA = 180;
			} else if (_right) {
				mA = 0;
			}

			_playState.getPlayer().velocity.set(_speed * (elapsed * 50), 0);
			_playState.getPlayer().velocity.rotate(FlxPoint.weak(0, 0), mA);
		}

		if (FlxG.keys.pressed.CONTROL) {
			_playState.getPlayer().fire(_playState);
		}
	}

	public function update(elapsed:Float):Void {
		updateKeyboard(elapsed);

		if (!_canFire) {
			_fireTime += elapsed;
			if (_fireTime >= _fireRate) {
				_canFire = true;
				_fireTime = 0.0;
			}
		}
	}
}
