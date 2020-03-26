/**
 *  GameVars.hx
 *      - Stores game specific vars, all this is saved when saving the game
 */

package systems;

class GameVars {
	public var lives:Int;
	public var score:Int;
	public var completedLevel:Int;
	public var level:systems.Levels.Level;
	public var playerItems:Array<entities.weapons.PlayerItem>;

	public var slot:Int;

	public function new():Void {
		lives = 0;
		score = 0;
		completedLevel = 0;
		level = new systems.Levels.Level1();
		playerItems = new Array<entities.weapons.PlayerItem>();
		playerItems.push(new entities.weapons.ChainGun());
	}
}
