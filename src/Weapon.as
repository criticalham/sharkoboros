package  
{
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxGroup;
	import org.flixel.FlxU;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.*;
	import Character;
	
	/**
	 * ...
	 * @author Doug Macdonald
	 */
	
	public class Weapon extends FlxObject
	{
		private var weapon:FlxWeapon; 
		[Embed(source = '../data/bullet_pistol.png')] private var ImgBulletPistol:Class;
		[Embed(source = '../data/bullet_side.png')] private var ImgBulletSide:Class;
		[Embed(source = '../data/bullet_rear.png')] private var ImgBulletRear:Class;
		[Embed(source = '../data/bullet_pistol_enemy.png')] private var ImgBulletPistolEnemy:Class;
		[Embed(source = '../data/bullet_side_enemy.png')] private var ImgBulletSideEnemy:Class;
		[Embed(source = '../data/bullet_rear_enemy.png')] private var ImgBulletRearEnemy:Class;
		[Embed(source = '../data/bullet_terrible.png')] private var ImgBulletTerrible:Class;
		[Embed(source = '../data/bullet_bubble.png')] private var ImgBulletBubble:Class;
		[Embed(source = '../data/bullet_bubble_enemy.png')] private var ImgBulletBubbleEnemy:Class;
		
		public var weaponType:Number
		public const T_PISTOL:Number = 1;
		public const T_SIDE:Number = 2;
		public const T_REAR:Number = 3;
		public const T_TERRIBLE:Number = 4;
		public const T_BUBBLE:Number = 5;
		
		private var parent:Character;
		
		private var fireTimer:Number;
		private var fireDelay:Number;
		private var level:Number;
		
		public function Weapon(parent:Character, bulletGroup:FlxGroup, type:Number, speed:Number, fireRate:Number, maxBullets:Number, level:Number = 1 ) 
		{
			weapon = new FlxWeapon("weapon", parent, "x", "y");
			var bulletType:Class;
			var isPlayer:Boolean = parent == PlayState.getPlayer() ? true : false;
			switch (type)
			{
				case T_PISTOL:
				default:
					{
						bulletType = isPlayer ? ImgBulletPistol : ImgBulletPistolEnemy;
					}
					break;
				case T_REAR:
					{
						bulletType = isPlayer ? ImgBulletRear : ImgBulletRearEnemy;
					}
					break;
				case T_SIDE:
					{
						bulletType = isPlayer ? ImgBulletSide : ImgBulletSideEnemy;
					}
					break;
				case T_TERRIBLE:
					{
						bulletType = ImgBulletTerrible;
					}
					break;
				case T_BUBBLE:
					{
						bulletType = isPlayer ? ImgBulletBubble : ImgBulletBubbleEnemy;
					}
					break;
			}
			weaponType = type;
			this.parent = parent;
			
			weapon.makeImageBullet(maxBullets, bulletType);
			weapon.setBulletSpeed(speed);
			fireDelay = 100 / fireRate;
			fireTimer = 0;
			this.level = level;
			bulletGroup.add(weapon.group);
		}
		
		public function fireAngle(angle:Number, offsetX:Number=0, offsetY:Number=0): void
		{
			if (fireTimer == 0)
			{
				var originX:Number = parent.frameWidth / 2;
				var originY:Number = parent.frameHeight / 2;
				if (weaponType == T_REAR)
				{
					weapon.setBulletOffset( originX - offsetX, originY - offsetY);
					weapon.fireFromAngle(angle + 180);
					updateCurrentBullet();
				}
				else if (weaponType == T_SIDE)
				{
					weapon.setBulletOffset(originX, originY);
					weapon.fireFromAngle(angle + 90);
					updateCurrentBullet();
					weapon.fireFromAngle(angle + 270);
					updateCurrentBullet();
				}
				else if (weaponType == T_PISTOL)
				{
					weapon.setBulletOffset(originX + offsetX, originY + offsetY);
					weapon.fireFromAngle(angle);
					updateCurrentBullet();
					
					if (level > 5)
					{
						weapon.fireFromAngle(angle-15);
						updateCurrentBullet();
						weapon.fireFromAngle(angle+15);
						updateCurrentBullet();
					}
				}
				else if (weaponType == T_TERRIBLE)
				{
					weapon.setBulletOffset(originX + offsetX, originY + offsetY);
					weapon.setBulletLifeSpan(1000);
					weapon.fireFromAngle(angle);
					updateCurrentBullet();
				}
				else if (weaponType == T_BUBBLE)
				{
					weapon.setBulletOffset(originX + offsetX, originY + offsetY);
					weapon.setBulletLifeSpan(1000);
					weapon.setBulletRandomFactor(40, 30, null, 300);
					weapon.fireFromAngle(angle);
					updateCurrentBullet();
					weapon.currentBullet.alpha = 0.5;
				}
				fireTimer = fireDelay;
			}
		}
		
		public function updateCurrentBullet(): void
		{
			if (weapon.currentBullet)
			{
				weapon.currentBullet.ATK = parent.ATK;
				
				// Add your velocity to the bullet (if you're traveling in the same direction)
				// (bad physics, but it looks weird otherwise)
				if (weapon.currentBullet.velocity.x * parent.velocity.x > 0)
					weapon.currentBullet.velocity.x += parent.velocity.x;
				if (weapon.currentBullet.velocity.y * parent.velocity.y > 0)
					weapon.currentBullet.velocity.y += parent.velocity.y;
			}
		}
		
		public function fireVector(vector:FlxPoint, offsetX:Number=0, offsetY:Number=0): void
		{
			fireAngle(FlxU.getAngle(vector, new FlxPoint(0, 0)) + 90, offsetX, offsetY);
		}
		
		public override function update(): void
		{
			if (fireTimer > 0)
			{
				fireTimer -= FlxG.elapsed;
			}
			if (fireTimer < 0)
			{
				fireTimer = 0;
			}
		}
	}

}