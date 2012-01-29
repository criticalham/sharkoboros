package attributes 
{
	/**
	 * ...
	 * @author Jason Hamilton
	 */
	public class SpeedAttribute extends Attribute
	{
		public static var SPEED_BOOST:Number = 10;
		
		public function SpeedAttribute() 
		{
			super();
			attributeType = ATT_SPD;
		}
		
		override public function get name():String
		{
			return "SPEED UP";
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