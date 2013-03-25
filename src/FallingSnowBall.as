package  
{
	import org.flixel.*;
	/**
	$(CBI)* ...
	$(CBI)* @author Ozan Yıldız
	$(CBI)*/
	
	/*Snowball that moves horizontally*/
	
	public class FallingSnowBall extends FlxSprite
	{
		[Embed(source = "../assets/snow32x32.png")] public var snowballPNG:Class;

		private var isGoingDown:Boolean;
		private var player:Player;
		private var startPointX:Number;
		private var startPointY:Number;
		private var delay:Number;
		private var limitY:Number = 464;
		
		public function FallingSnowBall(player:Player, X:Number, Y:Number, speed:Number, accelerationY:Number, delay:Number)
		{
			super(X, Y);
			startPointX = X;
			startPointY = Y;
			maxVelocity.y = speed;
			acceleration.y = accelerationY;
			loadGraphic(snowballPNG);
			
			immovable = true;
			this.player = player;
			this.delay = delay;
		}
	
		override public function update():void {
			
			angle -= (180 * FlxG.elapsed) % 360;
						
			if (y >= limitY) {
				y = startPointY + delay;
			}
		}
		
		public function resetSnowBall():void {
			x = startPointX;
			y = startPointY;
		}
		
	}

}