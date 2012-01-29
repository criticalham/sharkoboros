package  
{
	import org.flixel.FlxPoint;
	/**
	 * Supe lazy vector utility class, because I don't feel like looking for a library.
	 */
	public class VecUtil 
	{
		public static function scale(vector:FlxPoint, scale:Number):FlxPoint
		{
			return new FlxPoint(vector.x * scale, vector.y * scale);
		}
		
		public static function add(v1:FlxPoint, v2:FlxPoint):FlxPoint
		{
			return new FlxPoint(v1.x + v2.x, v1.y + v2.y);
		}
		
		public static function subtract(v1:FlxPoint, v2:FlxPoint):FlxPoint
		{
			return new FlxPoint(v1.x - v2.x, v1.y - v2.y);
		}
		
		public static function length(vector:FlxPoint):Number
		{
			return Math.sqrt((vector.x * vector.x) + (vector.y * vector.y));
		}
		
		public static function normalize(vector:FlxPoint):FlxPoint
		{
			var length:Number = length(vector);
			return new FlxPoint(vector.x/length, vector.y/length);
		}
	}

}