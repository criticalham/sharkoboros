package attributes 
{
	/**
	 * ...
	 * @author Doug Macdonald
	 */
	public class WeaponPistolAttribute extends Attribute
	{
		public static var PISTOL_BOOST:Number = 1;
		
		public function WeaponPistolAttribute() 
		{
			super();
			attributeType = ATT_PISTOL;
		}
		
		override public function get name():String
		{
			return "FRONT ATK UP";
		}
		
		override public function onAdd(character:Character):void
		{
			character.WEAPON_PISTOL += PISTOL_BOOST;
			updateWeapon(character);
		}
		
		override public function onRemove(character:Character):void
		{
			character.WEAPON_PISTOL -= PISTOL_BOOST;
			updateWeapon(character);
		}
		
		public function updateWeapon(character:Character): void
		{
			var newPistol:Weapon;
			if (character.wpnPistol)
			{
				character.weapons.remove(character.wpnPistol, true);
				character.wpnPistol = null;
			}
			if (character.WEAPON_PISTOL > 0)
			{
				newPistol = new Weapon(character, character.bulletGroup, 1, 200 + 50 * character.WEAPON_PISTOL, 200 + 50 * character.WEAPON_PISTOL, 50, character.WEAPON_PISTOL);
				character.weapons.add(newPistol);
				character.wpnPistol = newPistol;	
			}
		}
	}

}