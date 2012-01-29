package attributes 
{
	/**
	 * ...
	 * @author Doug Macdonald
	 */
	public class RegenAttribute extends Attribute
	{
		public static var REGEN_BOOST:Number = 10;
		
		public function RegenAttribute() 
		{
			super();
			attributeType = ATT_REGEN;
		}
		
		override public function get name():String
		{
			return "REGEN UP";
		}
		
		override public function onAdd(character:Character):void
		{
			character.REGEN += REGEN_BOOST;
			character.updateRegen(true);
		}
		
		override public function onRemove(character:Character):void
		{
			character.REGEN -= REGEN_BOOST;
		}
	}

}