/**
 *  GameOver.hx - Handles death with 0 lives left
 *  AKA GameOver
 *  
 *  TODO: Infinite lives and just take them back to intermission
 */
package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

import systems.GameVars;

class GameOver extends FlxState
{
    private var _gameVars:GameVars;

    override public function create():Void
    {
        FlxG.camera.fade(FlxColor.BLACK, 1.5, true);
        var gameOver:FlxText = new FlxText(FlxG.width, FlxG.height, -1, "GAME OVER", 16, true);
        gameOver.screenCenter();
        add(gameOver);
        var pressEscape:FlxText = new FlxText(0, 0, -1, "Press Escape to return to the intermission", 10, true);
        pressEscape.screenCenter();
        pressEscape.y = gameOver.y + gameOver.height + 15;
        add(pressEscape);
        super.create();
    }

    public function setGameVars(gameVars:GameVars):Void
    {
        _gameVars = gameVars;
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        if (FlxG.keys.pressed.ESCAPE) {
            var intermissionState:IntermissionState = new IntermissionState();
            intermissionState.setGameVars(_gameVars);
            FlxG.switchState(intermissionState);
		}
    }
}
