package entities.weapons;

class Weapon extends PlayerItem {
	private var _lastShotTick:Int = 0;

	/**
	 *  Handles firing of the weapon, playState is needed
	 *  to spawn bullets in the game
	 *
	 *  @param   playState The current playstate
	 *  @return  Returns false if we were unable to fire this tick
	 */
	public function fire(playState:states.PlayState):Bool {
		return false;
	}

	/**
	 *  Used for intermission just so that the lastShotTick
	 *  does not get out of sync.
	 */
	public function resetShots():Void {
		_lastShotTick = 0;
	}
}
