package
{
     /**
     * ...
     * @author Jason Seip
     */
     import org.flixel.*;
	
     public class Bground extends FlxSprite
     {
		[Embed(source = '../data/background_alt.png')] private var BackGroundSprite:Class;
		
				/// game board info
		public static const FRAME_WIDTH:int = 2000;
		public static const FRAME_HEIGHT:int = 2000;
		
          public function Bground()
          {
               // super(x, y);
               loadGraphic(BackGroundSprite, true, false, FRAME_WIDTH,FRAME_HEIGHT );					//False parameteer means this is not a sprite sheet
               scrollFactor.x = scrollFactor.y = 1.15;
               solid = false;  //Just to make sure no collisions with the backdrop ever take place
          }
     }
}