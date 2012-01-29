package attributes 
{
	/**
	 * ...
	 * @author Doug Macdonald
	 */
	public class AttackDebuffAttribute extends Attribute
	{
		public static var ATTACK_BOOST:Number = -10;
		
		public function AttackDebuffAttribute() 
		{
			super();
			attributeType = ATT_ATK;
			ISDEBUFF = true;
		}
		
		override public function get name():String
		{
			return "ATK DOWN...";
		}
		
		override public function onAdd(character:Character):void
		{
			character.ATK += ATTACK_BOOST;
		}
		
		override public function onRemove(character:Character):void
		{
			character.ATK -= ATTACK_BOOST;
		}
	}
}