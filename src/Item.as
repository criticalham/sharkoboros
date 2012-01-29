package  
{
	import org.flixel.FlxSprite;
	import attributes.Attribute;
	
	/**
	 * ...
	 * @author Doug Macdonald
	 */
	public class Item extends Character
	{
		[Embed(source = '../data/item_pistol.png')] private var ImgItemPistol:Class;
		[Embed(source = '../data/item_side.png')] private var ImgItemSide:Class;
		[Embed(source = '../data/item_rear.png')] private var ImgItemRear:Class;
		[Embed(source = '../data/item_atk.png')] private var ImgItemATK:Class;
		[Embed(source = '../data/item_def.png')] private var ImgItemDEF:Class;
		[Embed(source = '../data/item_spd.png')] private var ImgItemSPD:Class;
		[Embed(source = '../data/item_regen.png')] private var ImgItemRegen:Class;
		[Embed(source = '../data/item_atk_down.png')] private var ImgItemATKDown:Class;
		[Embed(source = '../data/item_def_down.png')] private var ImgItemDEFDown:Class;
		[Embed(source = '../data/item_spd_down.png')] private var ImgItemSPDDown:Class;
		[Embed(source = '../data/item_regen_down.png')] private var ImgItemRegenDown:Class;
		[Embed(source = '../data/item_bubble.png')] private var ImgItemBubble:Class;
		
		public function Item(x:Number, y:Number)
		{
			super(x, y);
		}
		
		public function dropAttributeText():void
		{
			var attribute:Attribute;
			for each (attribute in attributes)
			{
				PlayState.dropText(x, y, attribute.name);
			}
		}
		
		public function updateImage(fakeImage:Number=-1):void
		{
			// This bit is totally hacky -- used to force an image, so we can throw
			// these items onto the hud
			var imageType:Number = 0;
			var isDebuff:Boolean = false;
			if (fakeImage > -1)
			{
				imageType = fakeImage;
			}
			else
			{
				if ((attributes as Array).length >= 1)
				{
					imageType = (attributes[0] as attributes.Attribute).getType();
					isDebuff = (attributes[0] as attributes.Attribute).ISDEBUFF;
				}
			}
			
			// Only called after an item's attributes change (probably only immediately after creation)
			if (imageType == Attribute.ATT_ATK)
			{
				if (isDebuff)
				{
					loadGraphic(ImgItemATKDown);
				}
				else
				{
					loadGraphic(ImgItemATK);
				}
			}
			else if (imageType == Attribute.ATT_SPD)
			{
				if (isDebuff)
				{
					loadGraphic(ImgItemSPDDown);
				}
				else
				{
					loadGraphic(ImgItemSPD);
				}
			}
			else if (imageType == Attribute.ATT_DEF)
			{
				if (isDebuff)
				{
					loadGraphic(ImgItemDEFDown);
				}
				else
				{
					loadGraphic(ImgItemDEF);
				}
			}
			else if (imageType == Attribute.ATT_REGEN)
			{
				if (isDebuff)
				{
					loadGraphic(ImgItemRegenDown);
				}
				else
				{
					loadGraphic(ImgItemRegen);
				}
			}
			else if (imageType == Attribute.ATT_PISTOL)
			{
				loadGraphic(ImgItemPistol);
			}
			else if (imageType == Attribute.ATT_REAR)
			{
				loadGraphic(ImgItemRear);
			}
			else if (imageType == Attribute.ATT_SIDE)
			{
				loadGraphic(ImgItemSide);
			}
			else if (imageType == Attribute.ATT_BUBBLE)
			{
				loadGraphic(ImgItemBubble);
			}
		}
	}
}