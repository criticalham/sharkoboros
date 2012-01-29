package attributes 
{
	/**
	 * ...
	 * @author Doug Macdonald
	 */
	public class WeaponRearAttribute extends Attribute
	{
		public static var REAR_BOOST:Number = 1;
		
		public function WeaponRearAttribute() 
		{
			super();
			attributeType = ATT_REAR;
		}
		
		override public function get name():String
		{
			return "REAR ATK UP";
		}
		
		override public function onAdd(character:Character):void
		{
			character.WEAPON_REAR += REAR_BOOST;
			updateWeapon(character);
		}
		
		override public function onRemove(character:Character):void
		{
			character.WEAPON_REAR -= REAR_BOOST;
			updateWeapon(character);
		}
		
				
		public function updateWeapon(character:Character): void
		{
			var newRear:Weapon;
			if (character.wpnRear)
			{
				character.weapons.remove(character.wpnRear, true);
				character.wpnRear = null;
			}
			if (character.WEAPON_REAR > 0)
			{
				newRear = new Weapon(character, character.bulletGroup, 3, 100 + 25 * character.WEAPON_REAR, 100 + 25 * character.WEAPON_REAR, 50, character.WEAPON_REAR);
				character.weapons.add(newRear);
				character.wpnRear = newRear;	
			}
		}
	}

}