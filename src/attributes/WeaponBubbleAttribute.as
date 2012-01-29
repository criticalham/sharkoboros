package attributes 
{
	/**
	 * ...
	 * @author Doug Macdonald
	 */
	public class WeaponBubbleAttribute extends Attribute
	{
		public static var BUBBLE_BOOST:Number = 1;
		
		public function WeaponBubbleAttribute() 
		{
			super();
			attributeType = ATT_BUBBLE;
		}
		
		override public function get name():String
		{
			return "BUBBLE ATK UP";
		}
		
		override public function onAdd(character:Character):void
		{
			character.WEAPON_BUBBLE += BUBBLE_BOOST;
			updateWeapon(character);
		}
		
		override public function onRemove(character:Character):void
		{
			character.WEAPON_BUBBLE -= BUBBLE_BOOST;
			updateWeapon(character);
		}
		
		public function updateWeapon(character:Character): void
		{
			var newBubble:Weapon;
			if (character.wpnBubble)
			{
				character.weapons.remove(character.wpnBubble, true);
				character.wpnBubble = null;
			}
			if (character.WEAPON_BUBBLE > 0)
			{
				newBubble = new Weapon(character, character.bulletGroup, 5, 100 + 25 * character.WEAPON_BUBBLE, 400 + 50 * character.WEAPON_BUBBLE, 75, character.WEAPON_BUBBLE);
				character.weapons.add(newBubble);
				character.wpnBubble = newBubble;	
			}
		}
	}

}