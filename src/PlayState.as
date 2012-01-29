package
{
	import attributes.*;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	
	public class PlayState extends FlxState
	{
		public var player:Player;
		public var playerBullets:FlxGroup;
		
		public var SoundEffect:SoundFx;
		public var obstac:Obstac;
		public var bground:Bground;
		
		public var enemies:FlxGroup;
		public var enemyBullets:FlxGroup;
		
		public var boss:Enemy;
		
		public static var items:FlxGroup;
		public var emitters:FlxGroup;
		
		private var healthBar:FlxBar;
		private var bossHealthBar:FlxBar;
		
		private var debugText:FlxText;
		public var hud:Hud;
		
		public static const SPAWN_RANGE:Number = 100;
		private var spawnPoints:Array;
		
		public static const RESTART_TIME:Number = 4;
		public static var restartTime:Number = 0;
		public static var restarting:Boolean = false;
		public static var fadeValue:Number = 0;
		
		[Embed(source = '../data/particle.png')] private var ImgParticle:Class;
		
		public static function getRandomAttribute():Class
		{
			var isDebuff:Boolean = FlxG.random() < 0.3;
			switch (Math.floor(FlxG.random() * (Attribute.LAST+1)))
			{
				default:
				case 0:
					return isDebuff ? AttackDebuffAttribute : AttackAttribute;
				case 1:
					return isDebuff ? DefenseDebuffAttribute : DefenseAttribute;
				case 2:
					return isDebuff ? RegenDebuffAttribute : RegenAttribute;
				case 3:
					return isDebuff ? SpeedDebuffAttribute : SpeedAttribute;
				case 4:
					return WeaponPistolAttribute;
				case 5:
					return WeaponSideAttribute;
				case 6:
					return WeaponRearAttribute;
				case 7:
					return WeaponBubbleAttribute;
			}
		}
		
		public static function win():void
		{
			var player:Player = getPlayer();
			Player.invulnerableTimer = RESTART_TIME;

			restartTime = RESTART_TIME;
			restarting = true;
			fadeValue = 0;
			player.color = 0x030303;
			
			var boss:Enemy = getBoss();
			boss.shadow.alpha = 0;
		
			//return PlayState(FlxG.state).resetLevel(true);
		}
		
		
		public static function lose():void
		{
			return PlayState(FlxG.state).resetLevel(false);
			
		}
		
		public static function getPlayer():Player
		{
			return PlayState(FlxG.state).player;
		}
				
		public static function getBoss():Enemy
		{
			return PlayState(FlxG.state).boss;
		}
		
		public static function dropText(x:Number, y:Number, text:String):void
		{
			PlayState(FlxG.state).add(new DropText(x, y, text));
		}
		
		public static function addToGroup(object:FlxObject, group:FlxGroup):void
		{
			if (!group)
			{
				group = new FlxGroup();
			}
			
			group.add(object);
		}
		
		public function addEmitter(character:Character, particles:Number = 10 ): void
		{
			var emitter:FlxEmitter = new FlxEmitter(character.x + character.width / 2, character.y + character.height / 2, particles); //x and y of the emitter
			var particle:FlxParticle;
			 
			for(var i:int = 0; i < particles; i++)
			{
				particle = new FlxParticle();
				particle.makeGraphic(3, 3);
				emitter.add(particle);
			}
			
			emitters.add(emitter);
			character.setEmitter(emitter);
			emitter.setXSpeed(-30, 30);
			emitter.setYSpeed(-30, 30);
			emitter.start(false, 0.3, 0.02, 0);
		}
		
		override public function create():void
		{
			FlxG.volume = 0.5;
			/// Create sounds
			SoundEffect = new SoundFx();
					/// intro sound
			SoundEffect.SoundHorns();
			/// 
			restartTime = 0;
			restarting = false;
			spawnPoints = new Array();
			spawnPoints.push(new FlxPoint(429, 1562));
			spawnPoints.push(new FlxPoint(344, 999));
			spawnPoints.push(new FlxPoint(456, 470));
			spawnPoints.push(new FlxPoint(993, 203));
			spawnPoints.push(new FlxPoint(1389, 201));
			spawnPoints.push(new FlxPoint(1537, 562));
			spawnPoints.push(new FlxPoint(1604, 1056));
			spawnPoints.push(new FlxPoint(1396, 1621));
			spawnPoints.push(new FlxPoint(1042, 1778));
			
			FlxG.width = 2000;
			FlxG.height = 2000;
			FlxG.worldBounds = new FlxRect(0, 0, 2000,2000);
			
			//Set the background color to light gray (0xAARRGGBB)
			FlxG.bgColor = 0xff000000;
	
			/// Create enviro
			bground = new Bground();
			add(bground);
			
			/// Create enviro
			obstac = new Obstac();

			emitters = new FlxGroup;
			
			//Create player
			playerBullets = new FlxGroup();
			player = new Player(FlxG.width/2, FlxG.height/2, playerBullets);
			addEmitter(player, 50);
			
			var hudGroup:FlxGroup = new FlxGroup;
			hud = new Hud(hudGroup, player);
			
			FlxG.camera.follow(player, FlxCamera.STYLE_TOPDOWN);
			
			// Create health barwd
			healthBar = new FlxBar(16, 64, FlxBar.FILL_LEFT_TO_RIGHT, 64, 8, player, "health");
			healthBar.trackParent(0, -24);

			
			enemies = new FlxGroup();
			enemyBullets = new FlxGroup();

			
			items = new FlxGroup;

			
			debugText = new FlxText(0, 100, 400, "");
			debugText.scrollFactor.x = 0;
			debugText.scrollFactor.y = 0;
			
			add(obstac);
			add(emitters);
			add(items);
			add(enemies);
			add(enemyBullets);
			add(player);
			add(playerBullets);	
			add(healthBar);	
			add(hudGroup);
			add(debugText);
			
			resetLevel(true);
		}
		
		override public function update():void
		{
			if (!restarting)
			{
				FlxG.collide(player, enemies, collidePlayerEnemies);
				FlxG.collide(playerBullets, enemies, collidePlayerBulletsEnemies);
				FlxG.overlap(player, enemyBullets, collidePlayerEnemyBullets);
				FlxG.collide(player, items, collidePlayerItems);
				FlxG.collide(enemies, enemies);
				
				FlxG.collide(player, obstac);
				FlxG.collide(enemies, obstac);
				
				//Updates all the objects appropriately
				super.update();
				
				debugText.text = player.DEF.toString();
				
				if (FlxG.keys.SPACE)
				{
					trace(debugText.text);
				}
			}
			else
			{
				boss.visible = false;
				bossHealthBar.visible = false;
				
				fadeValue += FlxG.elapsed / RESTART_TIME;
				player.color -= 0x010101
				
				boss.shadow.alpha = 0.32 * ((RESTART_TIME - restartTime) / RESTART_TIME);
				boss.shadow.angle = player.angle;
				boss.shadow.x = player.x;
				boss.shadow.y = player.y;
				restartTime -= FlxG.elapsed;
				if (restartTime <= 0)
				{
					resetLevel();
				}
			}
		}
		
		private function collidePlayerEnemies(player:Player, enemy:Enemy): void
		{
			SoundEffect.SoundPlayerHit();
			player.hurt(enemy.ATK);
		}
		
		private function collidePlayerEnemyBullets(player:Player, bullet:Bullet): void
		{
			SoundEffect.SoundPlayerHit();
			player.hurt(bullet.ATK);
			bullet.kill();
		}
		
		private function collidePlayerBulletsEnemies(bullet:Bullet, enemy:Enemy): void
		{
			
			/// put sound with the enemy
			/// so it will change
			/// if it's the boss
			enemy.hurt(bullet.ATK);
			bullet.kill();
		}
		
		private function collidePlayerItems(player:Player, item:Item): void
		{
			SoundEffect.SoundPowerUpLong();
			item.dropAttributeText();
			player.copyAttributes(item);
			item.kill();
			
			hud.update();
		}
		
		public function resetLevel(advanceLevel:Boolean = false):void
		{
			if(advanceLevel == false){
				SoundEffect.SoundHonk();
			}
			
			restartTime = 0;
			restarting = false;
			
			emitters.clear();
			addEmitter(player, 50);
			
			var bossAttributes:Array = new Array();
			if (boss != null)
			{
				boss.clearShadow();
				bossAttributes = boss.attributes;
			}
			
			player.clearAttributes();
			
			items.clear();
			enemies.clear();
			enemyBullets.clear();
			playerBullets.clear();
			
			var spawnPoint:FlxPoint;
			var randomX:Number;
			var randomY:Number;
			var enemy:Enemy;
			var primaryAttribute:Class;
			var attributeClass:Class;
			for each (spawnPoint in spawnPoints)
			{
				primaryAttribute = PlayState.getRandomAttribute();
				
				for (var i:int = 0; i < 10; ++i) {
					randomX = spawnPoint.x + (FlxG.random() * SPAWN_RANGE*2) - SPAWN_RANGE;
					randomY = spawnPoint.y + (FlxG.random() * SPAWN_RANGE*2) - SPAWN_RANGE;
					
					enemy = new Enemy(randomX, randomY, enemyBullets);
					if (FlxG.random() * 100 < 80)
					{
						enemy.addAttribute(new primaryAttribute);
					}
					else
					{
						// Something weird is going on here with the compiler...
						attributeClass = primaryAttribute;
						primaryAttribute = PlayState.getRandomAttribute();
						enemy.addAttribute(new primaryAttribute);
						primaryAttribute = attributeClass;
					}
					//addEmitter(enemy);
					enemies.add(enemy);
				}
			}
			boss = new Enemy(300, 300, enemyBullets, true);
			boss.addAttributes(bossAttributes);
			addEmitter(boss, 50);
			enemies.add(boss);
			
			// Create boss health bar
			if (bossHealthBar)
			{
				bossHealthBar.kill();
			}
			bossHealthBar = new FlxBar(0, 64, FlxBar.FILL_LEFT_TO_RIGHT, 64, 16, boss, "health");
			bossHealthBar.createFilledBar(0xFF000000, 0xFFFF0000, true, 0xFF990000);
			bossHealthBar.trackParent(-8, -24);
			add(bossHealthBar);
			
			player.x = FlxG.width / 2;
			player.y = FlxG.height / 2;
			player.health = Player.INITIAL_HEALTH;
			player.addAttribute(new WeaponPistolAttribute);
			player.color = 0xffffff;
			//player.wpnTerrible = new Weapon(player, player.bulletGroup, 4, 200, 200, 30, 1);
			//player.weapons.add(player.wpnTerrible);
			hud.update();
		}
	}
}