package attributes 
{
	/**
	 * ...
	 * @author Doug Macdonald
	 */
	public class DefenseDebuffAttribute extends Attribute
	{
		public static var DEFENSE_BOOST:Number = 1.25;
		public static var ISDEBUFF:Boolean = true;
		
		public function DefenseDebuffAttribute() 
		{
			super();
			attributeType = ATT_DEF;
			ISDEBUFF = true;
		}
		
		override public function get name():String
		{
			return "DEF DOWN...";
		}
		
		override public function onAdd(character:Character):void
		{
			character.DEF /= DEFENSE_BOOST;
		}
		
		override public function onRemove(character:Character):void
		{
			character.DEF *= DEFENSE_BOOST;
		}
	}

}