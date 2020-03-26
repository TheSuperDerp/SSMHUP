/**
 *  MenuState.hx - Title screen, allows loading and starting a new game
 */

package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;
import flixel.addons.ui.FlxButtonPlus;

class MenuState extends FlxState {
	private var _txt_title:FlxText;
	private var _txt_confirm:FlxText;
	private var _btn_new:FlxButtonPlus;
	private var _btn_load:FlxButtonPlus;
	#if sys
	private var _btn_exit:FlxButtonPlus;
	private var _btn_confirmYes:FlxButtonPlus;
	private var _btn_confirmNo:FlxButtonPlus;
	#end

	override public function create():Void {
		super.create();
		FlxG.mouse.visible = true;
		var init_x:Int = Math.floor(FlxG.width / 2 - 40);

		var y:Float = 10;
		_txt_title = new FlxText(0, y, -1, "SSHMUP");
		_txt_title.setFormat("Indie Flower", 32, FlxColor.LIME);
		_txt_title.setBorderStyle(OUTLINE, FlxColor.GRAY, 2, 1);
		_txt_title.screenCenter(FlxAxes.X);
		y = y + _txt_title.height + 20;

		_btn_new = new FlxButtonPlus(init_x, y, onNew, "New game", 64, 16);
		y = y + _btn_new.height + 5;
		_btn_load = new FlxButtonPlus(init_x, y, onLoad, "Load", 64, 16);
		y = y + _btn_load.height + 5;
		#if sys
		_btn_exit = new FlxButtonPlus(init_x, y, onExit, "Exit", 64, 16);
		y = y + _btn_exit.height + 5;
		#end

		add(_txt_title);
		add(_btn_new);
		add(_btn_load);

		#if sys
		add(_btn_exit);

		_txt_confirm = new FlxText(0, 0, -1, "Are you sure you want to quit?", 8, true);
		_txt_confirm.screenCenter();
		_txt_confirm.y = _txt_confirm.y - (_txt_confirm.height / 2) - 5;

		_btn_confirmYes = new FlxButtonPlus(0, 0, onConfirmYes, "Yes", 64, 16);
		_btn_confirmYes.screenCenter();
		_btn_confirmYes.y = _btn_confirmYes.y + (_btn_confirmYes.height / 2) + 5;
		_btn_confirmYes.x = (FlxG.width / 2) - (_txt_confirm.width / 2);

		_btn_confirmNo = new FlxButtonPlus(0, 0, onConfirmNo, "No", 64, 16);
		_btn_confirmNo.screenCenter();
		_btn_confirmNo.y = _btn_confirmNo.y + (_btn_confirmNo.height / 2) + 5;
		_btn_confirmNo.x = (FlxG.width / 2) + (_txt_confirm.width / 2) - _btn_confirmNo.width;
		#end

		if (FlxG.sound.music == null)
			FlxG.sound.playMusic(AssetPaths.MenuSong__wav, .25, true);
	}

	private function onNew():Void {
		// FlxG.sound.music.stop();
		FlxG.switchState(new SaveSelectState());
	}

	private function onLoad():Void {
		var saveSelectState:SaveSelectState = new SaveSelectState();
		saveSelectState.loadGame();
		FlxG.switchState(saveSelectState);
	}

	#if sys
	private function onExit():Void {
		remove(_btn_new);
		remove(_btn_load);
		remove(_btn_exit);
		add(_txt_confirm);
		add(_btn_confirmYes);
		add(_btn_confirmNo);
	}
	#end

	#if sys
	private function onConfirmYes():Void {
		Sys.exit(0);
	}

	private function onConfirmNo():Void {
		remove(_txt_confirm);
		remove(_btn_confirmYes);
		remove(_btn_confirmNo);
		add(_btn_new);
		add(_btn_load);
		add(_btn_exit);
	}
	#end
}
