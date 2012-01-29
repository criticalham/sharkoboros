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
	public class Splat extends FlxSprite
	{
		// [Embed(source = '../data/simple_splat.png')] private var SplatSprite:Class;
		// [Embed(source = '../data/splat_double.png')] private var SplatSimpSprite:Class;
		
		[Embed(source = '../data/box.png')] private var ImgSprite:Class;
		
		/*
		[Embed(source="../data/assets.swf", symbol="box_gfx")]
		private var BoxClass:Class;
		*/
		

		public static const FRAME_WIDTH:int = 96;
		public static const FRAME_HEIGHT:int = 96;
		
		
		/**
		 * Constructor
		 * 
		 * @param	X
		 * @param	Y
		 */
		public function Splat(): void
		{
			// (BoxImg);
			var rnd:Number =  Math.random()*10 +1;
			loadGraphic(ImgSprite, true, false, FRAME_WIDTH, FRAME_HEIGHT);
			/*
			if(rnd<10){
				loadGraphic(SplatSprite, true, false, FRAME_WIDTH, FRAME_HEIGHT);
			} else {
				loadGraphic(SplatSimpSprite, true, false, FRAME_WIDTH, FRAME_HEIGHT);
			}
			*/
			
		}
		
		
/////////
	}

}