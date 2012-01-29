package Actors
{
	import org.flixel.FlxSprite;
	
	public class BaseBoss extends FlxSprite
	{
		
		private var _target:Hero;
		
		public function BaseBoss(target:Hero, X:Number=0, Y:Number=0)
		{
			_target = target;
			super(X, Y, null);
			makeGraphic(15,15,0xff3f3f3f);
			maxVelocity.x = 100;
			maxVelocity.y = 200;
			acceleration.y = 200;						
		}
		
		
		public override function update():void {
			if (_target.x < x)
				velocity.x = -maxVelocity.x;
			else
				velocity.x = maxVelocity.x;
			
			if (_target.y < y)
				velocity.y = -maxVelocity.y;
			else
				velocity.y = maxVelocity.y;
			
			super.update();
		}
	}
}