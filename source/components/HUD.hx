/**
 *  HUD.hx - Handles drawing and updating the games hud.
 *  It's a FlxSpriteGroup so any you need to draw that
 *  is not a basic Flx type should be created in components
 *  and then should be added in here
 */

package components;

import flixel.FlxG;
import flixel.ui.FlxBar;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxAxes;
import flixel.group.FlxSpriteGroup;
import states.PlayState;

class HUD extends FlxSpriteGroup {
	private var _playState:PlayState;
	private var _health:FlxBar;
	private var _scoreTxt:FlxText;
	private var _scoreNum:FlxText;

	public function new(playState:PlayState):Void {
		super();
		_playState = playState;

		_health = new FlxBar((FlxG.width - 5), 0, BOTTOM_TO_TOP, 5, FlxG.height);
		_health.createFilledBar(FlxColor.fromRGB(158, 35, 38), FlxColor.GREEN);
		_health.setRange(0, 100);

		_scoreTxt = new FlxText(0, 0, -1, "SCORE", 8, true);
		_scoreTxt.screenCenter(FlxAxes.X);
		_scoreNum = new FlxText(0, _scoreTxt.height, -1, "" + _playState.score, 8, true);
		_scoreNum.text = StringTools.lpad(_scoreNum.text, "0", 6);
		_scoreNum.screenCenter(FlxAxes.X);
		add(_scoreTxt);
		add(_scoreNum);
		add(_health);

		scrollFactor.x = 0;
		scrollFactor.y = 0;
	}

	public override function update(elapsed:Float):Void {
		_scoreNum.text = "" + _playState.score;
		_scoreNum.text = StringTools.lpad(_scoreNum.text, "0", 10);
		_scoreNum.screenCenter(FlxAxes.X);

		_health.percent = _playState.getPlayer().health;
		super.update(elapsed);
	}
}
