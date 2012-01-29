package attributes 
{
	/**
	 * ...
	 * @author Doug Macdonald
	 */
	public class RegenDebuffAttribute extends Attribute
	{
		public static var REGEN_BOOST:Number = -10;
		public static var ISDEBUFF:Boolean = true;
		
		public function RegenDebuffAttribute() 
		{
			super();
			attributeType = ATT_REGEN;
			ISDEBUFF = true;
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