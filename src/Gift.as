package  
{
	import org.flixel.*;
	/**
	$(CBI)* ...
	$(CBI)* @author Ozan Yıldız
	$(CBI)*/
	public class Gift extends FlxSprite
	{
		[Embed(source = "../assets/gift.png")] public var giftPNG:Class;
		private var startPoint:Number;
		private var endPoint:Number;
		
		public function Gift(X:Number, Y:Number) 
		{
			super(X, Y);
			loadGraphic(giftPNG);
			immovable = true;
						
			startPoint = X;
			endPoint = startPoint - 96;
		}
		
		public function move():void {
			if (x < endPoint)
			{
				x = endPoint;
				velocity.x = -velocity.x;
			}
			else if (x > startPoint)
			{
				x = startPoint;
				velocity.x = -velocity.x;
			}
		}
		
		public function resetGift():void 
		{
			x = startPoint;
			velocity.x = -80;
		}
		
	}

}