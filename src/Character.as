package  
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxGroup;
	import org.flixel.FlxG;
	import attributes.Attribute;
	/**
	 * ...
	 * @author Jason Hamilton
	 */
	public class Character extends FlxSprite
	{
		// Array of special attributes that modify stats
		public var attributes:Array;
		public var attributeVal:Array;
		
		public static const FRAME_WIDTH:int = 0;
		public static const FRAME_HEIGHT:int = 0;
		public var bulletGroup:FlxGroup;
		protected var MAX_HP:int = 0;
		
		// ATTRIBUTE MODIFIABLE VARIABLES
		public var SPEED:Number;
		public var ATK:Number;
		public var DEF:Number;
		public var REGEN:Number;
		
		public var WEAPON_PISTOL:Number;
		public var WEAPON_SIDE:Number;
		public var WEAPON_REAR:Number;
		public var WEAPON_BUBBLE:Number;
				
		// WEAPONS
		public var wpnPistol:Weapon;
		public var wpnSide:Weapon;
		public var wpnRear:Weapon;
		public var wpnTerrible:Weapon;
		public var wpnBubble:Weapon;
		public var weapons:FlxGroup;

		public var regenTimer:Number;
		private const regenAmount:Number = 1;
		
		/**
		 * Constructor
		 * 
		 * @param	x
		 * @param	y
		 */
		public function Character(x:Number, y:Number):void
		{
			super(x, y);
			attributes = new Array();
			attributeVal = new Array();
			weapons = new FlxGroup();
			regenTimer = 0;
			REGEN = 0;
		}
		
		public function dropItem():void
		{
			var item:Item = new Item(x, y);
			item.copyAttributes(this);
			item.updateImage();
			PlayState.addToGroup(item, PlayState.items);
		}
		
		/**
		 * Copy attributes from another character.
		 * Currently uses the same instances, not copies,
		 * under the assumption that Attributes don't have
		 * any internal state that varies per character.
		 * 
		 * @param	character
		 */
		public function copyAttributes(character:Character):void
		{
			var attribute:Attribute;
			for each (attribute in character.attributes)
			{
				addAttribute(attribute);
			}
		}
		
		/**
		 * Copy the attributes of the player
		 */
		public function copyPlayerAttributes():void
		{
			copyAttributes(PlayState.getPlayer());
		}
		
		/**
		 * Clear all attributes
		 */
		public function clearAttributes():void
		{
			var attribute:Attribute;
			for each (attribute in attributes)
			{
				attribute.onRemove(this);
			}
			attributes = new Array();
		}
		
		/**
		 * Have the attributes do their thing on update
		 */
		override public function update():void
		{
			var attribute:Attribute;
			for each (attribute in attributes)
			{
				attribute.onUpdate(this);
			}
			
			updateRegen();
			
			super.update();
		}
		
		public function updateRegen(forceStart:Boolean = false):void
		{
			if (regenTimer > 0 && REGEN > 0)
			{
				regenTimer -= FlxG.elapsed;
			}
			if (regenTimer <= 0 && REGEN > 0)
			{
				health += regenAmount;
				health = Math.min(health, MAX_HP);
				regenTimer = 25 / REGEN;
			}
		}
		
		/**
		 * Get the position as a FlxPoint
		 */
		public function get position():FlxPoint
		{
			return new FlxPoint(x, y);
		}
		
		public function addAttributes(newAttributes:Array):void
		{
			var attribute:Attribute;
			for each (attribute in newAttributes)
			{
				addAttribute(attribute);
			}
		}
		
		/**
		 * Add a new attribute, and do whatever it does on adding
		 * 
		 * @param	attribute
		 */
		public function addAttribute(attribute:Attribute):void
		{
			// Getting weird compile errors if I don't cast to Array.
			// It'll do for now.
			(attributes as Array).push(attribute);
			attribute.onAdd(this);
		}
		
		/**
		 * Remove an attribute, and do whatever it does on removing
		 * 
		 * @param	attribute
		 */
		public function removeAttribute(attribute:Attribute):void
		{
			// Getting weird compile errors if I don't cast to Array.
			// It'll do for now.
			(attributes as Array).splice((attributes as Array).indexOf(attribute), 1);
			attribute.onRemove(this);
		}
	}

}