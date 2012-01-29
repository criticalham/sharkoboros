package
{
	import org.flixel.*;
	[SWF(width="640", height="480", backgroundColor="#000000")]	
	public class Main extends FlxGame
	{
		public function Main()
		{
			trace("Hello World");
			super(640, 480, MenuState, 1);
			forceDebugger = true;
		}
	}
}
