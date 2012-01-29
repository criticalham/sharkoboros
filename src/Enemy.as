package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	import org.flixel.FlxG;
	import attributes.*;
	import org.flixel.plugin.photonstorm.FlxSpecialFX;
	import org.flixel.plugin.photonstorm.FX.BlurFX;
	
	/**
	 * ...
	 * @author Jason Hamilton
	 */
	public class Enemy extends Character
	{
		[Embed(source = '../data/fish_red.png')] private var RedSprite:Class;
		[Embed(source = '../data/fish_orange.png')] private var OrangeSprite:Class;
		[Embed(source = '../data/fish_yellow.png')] private var YellowSprite:Class;
		[Embed(source = '../data/fish_green.png')] private var GreenSprite:Class;
		[Embed(source = '../data/fish_blue.png')] private var BlueSprite:Class;
		[Embed(source = '../data/fish_teal.png')] private var TealSprite:Class;
		[Embed(source = '../data/fish_purple.png')] private var PurpleSprite:Class;
		[Embed(source = '../data/fish_pink.png')] private var PinkSprite:Class;
		[Embed(source = '../data/fish_brown.png')] private var BrownSprite:Class;
		[Embed(source = '../data/fish_gray.png')] private var GraySprite:Class;
		[Embed(source = '../data/shark_boss.png')] private var BossImgSprite:Class;
		
		// SPRITE INFO
		public static const FRAME_WIDTH:int = 40;
		public static const FRAME_HEIGHT:int = 40;
		public static const SPRITE_WIDTH:int = 20;
		public static const SPRITE_HEIGHT:int = 20;
		public static const SPRITE_SCALE:Number = 2.0;
		
		// DEFAULT STATS
		public static const DEFAULT_SPEED:Number = 50;
		public static const DEFAULT_MAX_SPEED:Number = DEFAULT_SPEED * 2;
		public static const INITIAL_HEALTH:int = 20;
		public static const INITIAL_BOSS_HEALTH:int = 100;
		
		public static const FOLLOW_DISTANCE:Number = FRAME_WIDTH * 5;
		
		public var personalSpaceDistance:Number = FRAME_WIDTH;
		
		// BLINKING
		public var blinkTimer:Number;
		public static const BLINK_TIME:Number = 1;
		
		// ETC
		public var maxspeed:Number;
		
		public var isBoss:Boolean;
		public var shadow:BossShadow;
		
		// what am i doing
		// i am so tired
		public var evenOddFlag:Boolean;
		public var turnSpeed:Number = 1.0;
		
		// Current state
		private var currentState:Function;
		
		/**
		 * Constructor
		 * 
		 * @param	X
		 * @param	Y
		 */
		public function Enemy(X:Number, Y:Number, bulletGroup:FlxGroup, boss:Boolean = false): void
		{
			isBoss = boss;
			super(X, Y);
			
			angle = Math.random() * 360;		

			if (isBoss)
			{
				loadGraphic(BossImgSprite, true, false, Player.SPRITE_WIDTH, Player.SPRITE_HEIGHT);
				scale.x = SPRITE_SCALE;
				scale.y = SPRITE_SCALE;
				width = Player.FRAME_WIDTH;
				height = Player.FRAME_HEIGHT;
				//offset.x = Player.SPRITE_WIDTH;
				//offset.y = Player.SPRITE_HEIGHT;
				MAX_HP = health = INITIAL_BOSS_HEALTH;
				shadow = new BossShadow(x, y, this);
				FlxG.state.add(shadow);
				color = 0x33333333;
			}
			else
			{
				loadGraphic(GraySprite, true, false, SPRITE_WIDTH, SPRITE_HEIGHT);
				MAX_HP = health = INITIAL_HEALTH;
			}
			
			addAnimation("default", [0,1,0,2], 10);
			addAnimation("hurt", [3,4,3,5], 10);
			
			SPEED = DEFAULT_SPEED;
			maxspeed = DEFAULT_MAX_SPEED;
			
			DEF = 1.25;
			WEAPON_PISTOL = 1;
			WEAPON_SIDE = 0;
			WEAPON_REAR = 0;
			WEAPON_BUBBLE = 0;
			
			if (!isBoss)
			{
				personalSpaceDistance = FRAME_WIDTH * (Math.random() * 3);
			}
			
			this.bulletGroup = bulletGroup;
			
			if (isBoss)
			{
				changeState("followPlayer");
			}
			else
			{
				switch (Math.floor(FlxG.random() * 3))
				{
					default:
						changeState("idle");
						break;
					case 0:
						changeState("spinLeft");
						break;
					case 1:
						changeState("spinRight");
						break;
					case 2:
						changeState("followPlayer");
						break;
				}
			}
			changeState("followPlayer");
			
			ATK = 20;
		}
		
		override public function addAttribute(attribute:Attribute):void
		{
			if (!isBoss)
			{
				if (attribute is AttackAttribute)
				{
					loadGraphic(RedSprite, true, false, SPRITE_WIDTH, SPRITE_HEIGHT);
				}
				else if (attribute is AttackDebuffAttribute)
				{
					loadGraphic(RedSprite, true, false, SPRITE_WIDTH, SPRITE_HEIGHT);
					alpha = 0.5;
				}
				else if (attribute is DefenseAttribute)
				{
					loadGraphic(BlueSprite, true, false, SPRITE_WIDTH, SPRITE_HEIGHT);
				}
				else if (attribute is DefenseDebuffAttribute)
				{
					loadGraphic(BlueSprite, true, false, SPRITE_WIDTH, SPRITE_HEIGHT);
					alpha = 0.5;
				}
				else if (attribute is RegenAttribute)
				{
					loadGraphic(PinkSprite, true, false, SPRITE_WIDTH, SPRITE_HEIGHT);
				}
				else if (attribute is RegenDebuffAttribute)
				{
					loadGraphic(PinkSprite, true, false, SPRITE_WIDTH, SPRITE_HEIGHT);
					alpha = 0.5;
				}
				else if (attribute is SpeedAttribute)
				{
					loadGraphic(GreenSprite, true, false, SPRITE_WIDTH, SPRITE_HEIGHT);
				}
				else if (attribute is SpeedDebuffAttribute)
				{
					loadGraphic(GreenSprite, true, false, SPRITE_WIDTH, SPRITE_HEIGHT);
					alpha = 0.5;
				}
				else if (attribute is WeaponPistolAttribute)
				{
					loadGraphic(BrownSprite, true, false, SPRITE_WIDTH, SPRITE_HEIGHT);
				}
				else if (attribute is WeaponRearAttribute)
				{
					loadGraphic(TealSprite, true, false, SPRITE_WIDTH, SPRITE_HEIGHT);
				}
				else if (attribute is WeaponSideAttribute)
				{
					loadGraphic(TealSprite, true, false, SPRITE_WIDTH, SPRITE_HEIGHT);
				}
				else if (attribute is attributes.WeaponBubbleAttribute)
				{
					loadGraphic(PurpleSprite, true, false, SPRITE_WIDTH, SPRITE_HEIGHT);
				}
				scale.x = SPRITE_SCALE;
				scale.y = SPRITE_SCALE;
				width = FRAME_WIDTH;
				height = FRAME_HEIGHT;
				offset.x = -SPRITE_WIDTH/2;
				offset.y = -SPRITE_HEIGHT/2;
			}
			super.addAttribute(attribute);
		}
		
		public function clearShadow():void
		{
			if (shadow)
			{
				shadow.kill();
				shadow = null;
			}
		}
		
		public override function hurt(damage:Number): void
		{
			super.hurt(damage / DEF);
			blinkTimer = BLINK_TIME;
		}
		
		public override function kill():void
		{
			if (isBoss)
			{
				clearAttributes();
				copyAttributes(player);
				health = Player.INITIAL_HEALTH;
				revive();
				if (shadow)
				{
					var player:Player = PlayState.getPlayer();
					shadow.x = player.x;
					shadow.y = player.y;
					shadow.angle = player.angle;
					alpha = 0;
				}
				PlayState.win();
			}
			else
			{
				dropItem();
				super.kill();
			}
		}
		
		/**
		 * Change the current state.
		 * Using callbacks for now, until the AI needs something more complex.
		 * 
		 * @param	stateName
		 */
		public function changeState(stateName:String):void
		{
			currentState = this[stateName + "State"];
		}
		
		/**
		 * Call the current state update function.
		 */
		override public function update(): void
		{
			if (blinkTimer > 0)
			{
				blinkTimer = Math.max(blinkTimer - FlxG.elapsed, 0);
				play("hurt");
			}
			else
			{
				play("default");
			}
			currentState();
			super.update();
		}
		
		private function faceVelocity():void
		{
			angle = FlxU.getAngle(velocity, new FlxPoint(0, 0)) + 90;
		}
		
		private function faceDirection(direction:FlxPoint):void
		{
			angle = FlxU.getAngle(direction, new FlxPoint(0, 0)) + 90;
		}
		
		private function get player():Player
		{
			return PlayState.getPlayer();
		}
		
		public function get currentDirection():FlxPoint
		{
			var radians:Number = angle / (180 / Math.PI);
			return new FlxPoint(Math.cos(radians), Math.sin(radians));
		}
		
		// ===================================================================================
		// STATES -- Set currentState to one of these state functions to change the behavior.
		// ===================================================================================
		
		/**
		 * Do nothing.
		 */
		public function idleState(): void
		{
			velocity = VecUtil.scale(currentDirection, SPEED);
			faceVelocity();
			fireWeapons();
			
			var direction:FlxPoint = VecUtil.subtract(player.position, position);
			var distance:Number = VecUtil.length(direction);
			
			if (distance <= FOLLOW_DISTANCE)
			{
				changeState("followPlayer");
			}
		}
		
		public function circleState():void
		{
			angle += FlxG.elapsed * 50 * turnSpeed * (evenOddFlag ? -1 : 1);
			velocity = VecUtil.scale(currentDirection, SPEED);
			fireWeapons();
			
			var direction:FlxPoint = VecUtil.subtract(player.position, position);
			var distance:Number = VecUtil.length(direction);
			
			if (distance <= FOLLOW_DISTANCE)
			{
				changeState("followPlayer");
			}
		}
		
		/**
		 * Dummy testing state. Spin left!
		 */
		public function spinLeftState():void
		{
			angle -= FlxG.elapsed;
		}
		
		/**
		 * Dummy testing state. Spin right!
		 */
		public function spinRightState():void
		{
			angle += FlxG.elapsed;
		}
		
		/**
		 * Follow the player
		 */
		public function followPlayerState():void
		{
			var direction:FlxPoint = VecUtil.subtract(player.position, position);
			var distance:Number = VecUtil.length(direction);
			
			if (!isBoss && distance > FOLLOW_DISTANCE)
			{
				velocity.x = 0;
				velocity.y = 0;
				evenOddFlag = (Math.floor(FlxG.random() * 2)) > 1;
				turnSpeed = Math.random() * 2 + 0.5;
				changeState("circle");
				return;
			}
			
			// Normalize the direction
			direction = VecUtil.scale(direction, 1 / distance);
			
			if (distance > personalSpaceDistance)
			{
				velocity = VecUtil.scale(direction, SPEED);
				faceVelocity();
			}
			else
			{
				velocity.x = 0;
				velocity.y = 0;
				faceDirection(direction);
			}
			
			fireWeapons();
		}
		
		public function fireWeapons():void
		{
			var direction:FlxPoint = VecUtil.subtract(player.position, position);
			var distance:Number = VecUtil.length(direction);
			
			if (isBoss || distance < FOLLOW_DISTANCE * 1.5)
			{
				for (var i:Number = 0; i < weapons.length; i++)
				{
					var weapon:Weapon = weapons.members[i];
					weapon.update();
					weapon.fireAngle(angle, -offset.x, -offset.y);
				}
			}
		}
	}
}