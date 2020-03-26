/**
 *  GameVars.hx
 *      - Stores game specific vars, all this is saved when saving the game
 */

package systems;

import js.Browser;
import haxe.Serializer;
import haxe.Unserializer;
import lime.app.Application;

class SaveLoad {
	public static function saveGame(gameVars:GameVars):Void {
		var serializer = new Serializer();
		serializer.serialize(gameVars);
		var company = "";
		var file = "";
		if (Application.current != null) {
			if (Application.current.meta.exists("company")) {
				company = Application.current.meta.get("company");
			}

			if (Application.current.meta.exists("file")) {
				file = Application.current.meta.get("file");
			}
		}
		var saveName = company + "." + file + ".save" + gameVars.slot;
		var storage = Browser.getLocalStorage();
		if (storage != null) {
			storage.setItem(saveName, serializer.toString());
		}
	}

	public static function loadGame(?slot:Int = 1):GameVars {
		var gameVars:GameVars = null;
		var company = "";
		var file = "";
		if (Application.current != null) {
			if (Application.current.meta.exists("company")) {
				company = Application.current.meta.get("company");
			}

			if (Application.current.meta.exists("file")) {
				file = Application.current.meta.get("file");
			}
		}
		var saveName = company + "." + file + ".save" + slot;
		var storage = Browser.getLocalStorage();
		if (storage != null) {
			var data = storage.getItem(saveName);
			if (data != "") {
				var unserializer = new Unserializer(data);
				gameVars = unserializer.unserialize();
			}
		}

		if (gameVars == null) {
			gameVars = new GameVars();
			gameVars.slot = slot;
		}
		return gameVars;
	}
}
