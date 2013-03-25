package  
{
	import org.flixel.*;
	/**
	$(CBI)* ...
	$(CBI)* @author Ozan Yıldız
	$(CBI)*/
	
	/*Snowball that moves horizontally*/
	
	public class SnowBallH extends FlxSprite
	{
		[Embed(source = "../assets/snow32x32.png")] public var snowballPNG:Class;
		
		protected var startPointX:Number;
		public var endPointX:Number;
		protected var isGoingRight:Boolean;
		protected var player:Player;
		protected var range:Number;
		protected var delay:Number;
		private var rotationDirection:Number = 1;
		
		public function SnowBallH(player:Player, X:Number, Y:Number, speed:Number, accelerationX:Number, isGoingRight:Boolean, range:Number, delay:Number)
		{
			super(X, Y);
			startPointX = X;
			maxVelocity.x = speed;

			loadGraphic(snowballPNG);
			
			immovable = true;
			this.isGoingRight = isGoingRight;
			this.player = player;
			this.range = range;
			this.delay = delay;
			
			if (isGoingRight) {
				endPointX = X + range;
				acceleration.x = accelerationX;
			}
			else {
				endPointX = X - range;
				acceleration.x = -accelerationX;
			}
			
			if (!isGoingRight) {
				rotationDirection = -1;
			}
		}
	
		override public function update():void {
			
			angle += (180 * FlxG.elapsed * rotationDirection) % 360;			
			
			if (isGoingRight) {
				if (x  >= endPointX)  {
					x = startPointX + delay;
				}
			}
			else {
				if (x  <= endPointX) {
					x = startPointX - delay;
					range -= delay;
				}
			}
		}
		
		public function resetSnowBall():void {
			x = startPointX;
		}
	}

}