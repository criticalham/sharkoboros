package attributes 
{
	/**
	 * ...
	 * @author Jason Hamilton
	 */
	public class AttackAttribute extends Attribute
	{
		public static var ATTACK_BOOST:Number = 10;
		
		public function AttackAttribute() 
		{
			super();
			attributeType = ATT_ATK;
		}
		
		override public function get name():String
		{
			return "ATK UP";
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