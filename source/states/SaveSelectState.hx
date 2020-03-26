/**
 *  SaveSelectState.hx
 *      - Loads a game and sets up GameVars before moving on to the intermission state
 */
package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;
import flixel.addons.ui.FlxButtonPlus;

import systems.SaveLoad;
import systems.GameVars;

class SaveSelectState extends FlxState
{
    private var _loadGame:Bool = false;

    private var _txt_title:FlxText;
    private var _btn_slot1:FlxButtonPlus;
    private var _btn_slot2:FlxButtonPlus;
    private var _btn_slot3:FlxButtonPlus;
    private var _btn_slot4:FlxButtonPlus;
    private var _btn_slot5:FlxButtonPlus;
    private var _btn_slot6:FlxButtonPlus;

    override public function create():Void
	{
        super.create();
        FlxG.mouse.visible = true;

        var init_x:Int = Math.floor(FlxG.width / 2 - 40);
        var y:Float = 10;
        _txt_title = new FlxText(0, y, -1, "Select Slot");
        _txt_title.setFormat("Indie Flower", 32, FlxColor.LIME);
        _txt_title.setBorderStyle(OUTLINE, FlxColor.GRAY, 2, 1);
        _txt_title.screenCenter(FlxAxes.X);
        y = y + _txt_title.height + 20;

        _btn_slot1 = new FlxButtonPlus(init_x, y, slot1, "Slot 1", 64, 16);
        y = y + _btn_slot1.height + 5;
        _btn_slot2 = new FlxButtonPlus(init_x, y, slot2, "Slot 2", 64, 16);
        y = y + _btn_slot2.height + 5;
        _btn_slot3 = new FlxButtonPlus(init_x, y, slot3, "Slot 3", 64, 16);
        y = y + _btn_slot3.height + 5;
        _btn_slot4 = new FlxButtonPlus(init_x, y, slot4, "Slot 4", 64, 16);
        y = y + _btn_slot4.height + 5;
        _btn_slot5 = new FlxButtonPlus(init_x, y, slot5, "Slot 5", 64, 16);
        y = y + _btn_slot5.height + 5;
        _btn_slot6 = new FlxButtonPlus(init_x, y, slot6, "Slot 6", 64, 16);
        y = y + _btn_slot6.height + 5;

        add(_txt_title);
        add(_btn_slot1);
        add(_btn_slot2);
        add(_btn_slot3);
        add(_btn_slot4);
        add(_btn_slot5);
        add(_btn_slot6);
	}
	
	override function update(elapsed:Float) {
		if (FlxG.keys.pressed.ESCAPE) {
			FlxG.switchState(new MenuState());
		}
		super.update(elapsed);
	}

    public function loadGame():Void
    {
        _loadGame = true;
    }

    private function loadSlot(slot:Int = 1):Void
    {
        var gameVars:GameVars;
        if (_loadGame) {
            gameVars = SaveLoad.loadGame(slot);
        } else {
            // TODO pop up confirm
            gameVars = new GameVars();
			gameVars.slot = slot;
			SaveLoad.saveGame(gameVars);
        }
        var intermissionState:IntermissionState = new IntermissionState();
        intermissionState.setGameVars(gameVars);
        FlxG.switchState(intermissionState);
    }

    private function slot1():Void
    {
        loadSlot(1);
    }

    private function slot2():Void
    {
        loadSlot(2);
    }

    private function slot3():Void
    {
        loadSlot(3);
    }

    private function slot4():Void
    {
        loadSlot(4);
    }

    private function slot5():Void
    {
        loadSlot(5);
    }

    private function slot6():Void
    {
        loadSlot(6);
    }
}