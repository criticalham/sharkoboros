package attributes 
{
	/**
	 * ...
	 * @author Jason Hamilton
	 */
	public class SpeedDebuffAttribute extends Attribute
	{
		public static var SPEED_BOOST:Number = -10;
		public static var ISDEBUFF:Boolean = true;
		
		public function SpeedDebuffAttribute() 
		{
			super();
			attributeType = ATT_SPD;
			ISDEBUFF = true;
		}
		
		override public function get name():String
		{
			return "SPEED DOWN...";
		}
		
		override public function onAdd(character:Character):void
		{
			character.SPEED += SPEED_BOOST;
		}
		
		override public function onRemove(character:Character):void
		{
			character.SPEED -= SPEED_BOOST;
		}
	}

}