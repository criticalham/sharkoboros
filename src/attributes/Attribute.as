package attributes
{
	/**
	 * ...
	 * @author Jason Hamilton
	 */
	public class Attribute 
	{
		public static const ATT_ATK:Number 		= 0;
		public static const ATT_DEF:Number 		= 1;
		public static const ATT_SPD:Number 		= 2;
		public static const ATT_REGEN:Number 	= 3;
		
		public static const ATT_PISTOL:Number 	= 4;
		public static const ATT_SIDE:Number 	= 5;
		public static const ATT_REAR:Number	 	= 6;
		public static const ATT_BUBBLE:Number	= 7;
		
		public static const LAST:Number = ATT_BUBBLE;
		
		protected var attributeType:Number;
		public var ISDEBUFF:Boolean = false;
		
		public function Attribute() 
		{
		}
		
		public function get name():String
		{
			return "Attribute";
		}
		
		public function onAdd(character:Character):void
		{
		}
		
		public function onRemove(character:Character):void
		{
		}
		
		public function onUpdate(character:Character):void
		{
		}
		
		public function getType():Number
		{
			return attributeType;
		}
	}

}