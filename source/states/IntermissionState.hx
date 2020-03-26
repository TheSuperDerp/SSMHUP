/**
 *  IntermissionState.hx - This fucking class....
 *  Handles the store and setting up the playstate
 *
 *  TODO: Needs a massive code cleanup pass
 */
package states;

import systems.Levels;
import systems.GameVars;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import flixel.addons.ui.FlxButtonPlus;

class IntermissionState extends FlxState
{
    private var _gameVars:GameVars;
    private var _txt_money:FlxText;

    private var _btn_exit:FlxButtonPlus;

    private var _levelData:LevelData;

    private var _lifeCost:Int = 100;

    override public function create():Void
	{
		super.create();
        FlxG.mouse.visible = true;

        if (_gameVars == null) {
            _gameVars = new GameVars();
        }

        _levelData = new LevelData();

        var init_y:Float = 10;
        var init_x:Int = Math.floor(FlxG.width / 2 - 40);

        _txt_money = new FlxText(init_x, init_y, -1, "Score: " + _gameVars.score, 16, true);
        init_y += _txt_money.height + 25;
        _txt_money.screenCenter(FlxAxes.X);
        add(_txt_money);

        var _play_btn = new FlxButtonPlus(init_x, init_y, playLevel, "PLAY", 64, 16);
        init_y += _play_btn.height + 15;
        add(_play_btn);

        _btn_exit = new FlxButtonPlus(init_x, init_y, exit, "Back", 64, 16);
        add(_btn_exit);

        updateUI();
    }

    private function updateUI():Void
    {
        _txt_money.text = "Score: " + _gameVars.score;
        _txt_money.screenCenter(FlxAxes.X);
    }

    public function setGameVars(gameVars:GameVars):Void
    {
        _gameVars = gameVars;
    }

    private function exit():Void
    {
        FlxG.switchState(new MenuState());
    }

    private function playLevel():Void
    {
        if (_levelData.getLevel(_gameVars.completedLevel) == null) {
            _gameVars.completedLevel = 0;
        }
        _gameVars.level = _levelData.getLevel(_gameVars.completedLevel);

        var playState:PlayState = new PlayState();
        playState.gameVars = _gameVars;
        FlxG.switchState(playState);
    }
}