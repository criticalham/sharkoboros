package 
{
	/**
	 * ...
	 * @author Doug Macdonald
	 */
	import org.flixel.*;
	import attributes.*
	import DummyEnemy;
	import Bground;
	
	public class MenuState extends FlxState
	{
		public var title:FlxText;
		public var subTitle:FlxText;
		public var instruction:FlxText;
		public var instruction2:FlxText;
		public var credits:FlxText;
		
		public function MenuState(): void
		{
			
		}
		
		override public function create():void 
		{
			super.create();
			
			var bground:Bground = new Bground();
			add(bground);
			
			var enemyGroup:FlxGroup = new FlxGroup;
			
			for (var i:int = 0; i < 40; ++i)
			{
				var fish:DummyEnemy = new DummyEnemy(FlxG.random() * FlxG.width, FlxG.random() * FlxG.height, false);
				var attribute:Class;
				
				switch (Math.floor(FlxG.random() * (8)))
				{
					default:
					case 0:
						attribute = AttackAttribute;
						break;
					case 1:
						attribute = DefenseAttribute;
						break;
					case 2:
						attribute = RegenAttribute;
						break;
					case 3:
						attribute = SpeedAttribute;
						break;
					case 4:
						attribute = AttackDebuffAttribute;
						break;
					case 5:
						attribute = DefenseDebuffAttribute;
						break;
					case 6:
						attribute = RegenDebuffAttribute;
						break;
					case 7:
						attribute = SpeedDebuffAttribute;
						break;
				}
					
				fish.addAttribute(new attribute);
				enemyGroup.add(fish);
			}
			
			var dummyBoss:DummyEnemy = new DummyEnemy(FlxG.width / 2, FlxG.height / 2, true);
			enemyGroup.add(dummyBoss);
			
			add(enemyGroup);
			
			
			
			
			title = new FlxText(0, 32, FlxG.width, "SHARKOBOROS", false);
			title.setFormat("Arial Black", 32, 0x333333, "center", 0x666666);
			add(title);
			
			subTitle = new FlxText(0, 72, FlxG.width, "There is always a bigger fish.", false);
			subTitle.setFormat("Arial Black", 12, 0x666666, "center", 0);
			add(subTitle);
			
			var text:String = "Move with WASD and attack with the ARROW KEYS.\n\nKill the shark to usurp his watery throne.\n\nPress any key to play.";
			instruction = new FlxText(0, FlxG.height - 128, FlxG.width, text, false);
			instruction.setFormat("Arial Black", 12, 0x666666, "center", 0);
			add(instruction);
			
			
			subTitle = new FlxText(0, FlxG.height - 16, FlxG.width, "© 2012 Doug Macdonald, Jason Hamilton, and Eric Medine", false);
			subTitle.setFormat("Arial", 10, 0x666666, "left", 0);
			add(subTitle);
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