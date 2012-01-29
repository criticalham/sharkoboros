package 
{
	/**
	 * ...
	 * @author Doug Macdonald
	 */
	import org.flixel.*;
	
	public class MenuState extends FlxState
	{
		public var title:FlxText;
		public var subTitle:FlxText;
		public var instruction:FlxText;
		public var instruction2:FlxText;
		
		public function MenuState(): void
		{
			
		}
		
		override public function create():void 
		{
			super.create();
			/*
			var bulletGroup:FlxGroup = new FlxGroup;
			var enemyGroup:FlxGroup = new FlxGroup;
			
			for (var i:int = 0; i < 40; ++i)
			{
				var fish:Enemy = new Enemy(FlxG.random() * FlxG.width, FlxG.random() * FlxG.height, bulletGroup, false);
				var attribute:Class = PlayState.getRandomAttribute();
				fish.addAttribute(new attribute);
				enemyGroup.add(fish);
			}
			add(bulletGroup);
			add(enemyGroup);
			*/
			
			title = new FlxText(0, 32, FlxG.width, "SHARKOBOROS", false);
			title.setFormat("Arial Black", 32, 0x333333, "center", 0x666666);
			add(title);
			
			subTitle = new FlxText(0, 72, FlxG.width, "There is always a bigger fish.", false);
			subTitle.setFormat("Arial Black", 12, 0x333333, "center", 0);
			add(subTitle);
			
			var text:String = "Move with WASD and attack with the ARROW KEYS.\n\nKill the shark to usurp his watery throne.\n\nPress any key to play.";
			instruction = new FlxText(0, FlxG.height - 128, FlxG.width, text, false);
			instruction.setFormat("Arial Black", 12, 0x333333, "center", 0);
			add(instruction);
		}
		
		override public function update(): void
		{
			if (FlxG.keys.any())
			{
				FlxG.switchState(new PlayState);
			}
			super.update();
		}
		
	}

}