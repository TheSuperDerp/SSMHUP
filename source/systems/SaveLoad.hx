/**
 *  GameVars.hx
 *      - Stores game specific vars, all this is saved when saving the game
 */

package systems;

import sys.io.File;
import sys.FileSystem;
import haxe.Serializer;
import haxe.Unserializer;

class SaveLoad {
	public static function saveGame(gameVars:GameVars):Void {
		var serializer = new Serializer();
		serializer.serialize(gameVars);
		if (!FileSystem.exists("saves")) {
			FileSystem.createDirectory("saves");
		}
		// TODO: Save Slots
		var saveFile = File.write("saves/slot.00" + gameVars.slot, true);
		saveFile.writeString(serializer.toString());
		saveFile.flush();
		saveFile.close();
	}

	public static function loadGame(?slot:Int = 1):GameVars {
		var gameVars:GameVars;
		if (!FileSystem.exists("saves/slot.00" + slot)) {
			gameVars = new GameVars();
			gameVars.slot = slot;
			return gameVars;
		}
		var saveFile = File.read("saves/slot.00" + slot, true);
		var unserializer = new Unserializer(saveFile.readLine());
		gameVars = unserializer.unserialize();
		saveFile.close();
		return gameVars;
		return gameVars;
	}
}
