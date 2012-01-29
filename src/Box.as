package  
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author emedine
	 */
	public class Box extends FlxSprite
	{
		[Embed(source = '../data/box.png')] private var ImgSprite:Class;
		
		/*
		[Embed(source="../data/assets.swf", symbol="box_gfx")]
		private var BoxClass:Class;
		*/
		

		public static const FRAME_WIDTH:int = 20;
		public static const FRAME_HEIGHT:int = 20;
		
		
		/**
		 * Constructor
		 * 
		 * @param	X
		 * @param	Y
		 */
		public function Box(): void
		{
			// (BoxImg);
			loadGraphic(ImgSprite, true, false, FRAME_WIDTH, FRAME_HEIGHT);
			
		}
		
		
/////////
	}

}