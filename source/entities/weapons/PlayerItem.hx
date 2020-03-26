/**
 *  PlayerItem.hx - Base class for all items a player can own
 */

package entities.weapons;

class PlayerItem {
	/**
	 *  Returns the name of the weapon
	 *
	 *  @return  name of the weapon as a string
	 */
	public function getName():String {
		return "NULL";
	}

	/**
	 *  Gets the store cost of an item
	 *
	 *  @return  Cost of weapon as an int
	 */
	public function getCost():Int {
		return 4;
	}

	/**
	 *  Gets the sale price of an item
	 *
	 *  @return  Sale price for an item
	 */
	public function getSalePrice():Int {
		return cast(getCost() / 2, Int);
	}
}
