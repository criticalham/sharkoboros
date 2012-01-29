package
{
	
	/**
	 * ...
	 * @author emedine
	 */
	import org.flixel.*;

	public class Enviro extends FlxSprite
	{
		[Embed(source = '../data/foreground_lg.png')] private var ForegroundSprite:Class;
		
		/// game board info
		public static const FRAME_WIDTH:int = 2000;
		public static const FRAME_HEIGHT:int = 2000;

		
		public function Enviro():void
		{
			
			spawnForeground();
			
	
			
		}
		private function spawnForeground():void{
			loadGraphic(ForegroundSprite, true, false, FRAME_WIDTH, FRAME_HEIGHT);
		}
			
		/////
	}
}
