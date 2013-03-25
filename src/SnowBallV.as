package  
{
	import org.flixel.*;
	/**
	$(CBI)* ...
	$(CBI)* @author Ozan Yıldız
	$(CBI)*/
	
	/*Snowball that moves vertically*/
	
	public class SnowBallV extends FlxSprite
	{
		[Embed(source = "../assets/snow20x20.png")] public var snowballPNG:Class;
		private var startPointY:Number;
		private var isGoingDown:Boolean;
		private var firstStatePositionY:Number;
		private var firstStateOfGoing:Boolean;
		private var player:Player;
		private var limitY:Number = 464;
		public function SnowBallV(player:Player, X:Number, Y:Number, speed:Number, accelerationY:Number, isGoingDown:Boolean)
		{
			super(X, Y);
			firstStatePositionY = Y;
			startPointY = Y;
			maxVelocity.y = speed;
			acceleration.y = accelerationY;
			loadGraphic(snowballPNG);
			
			immovable = true;
			this.isGoingDown = isGoingDown;
			this.firstStateOfGoing = isGoingDown;
			this.player = player;
		}
	
		override public function update():void {
			
			angle -= (180 * FlxG.elapsed) % 360;
			
			if (FlxG.collide(this, player)) {
				FlxG.resetState();
			}
			
			if (!isGoingDown) {
				if (y  >= startPointY) 
				{
					y = startPointY;
					velocity.y -= maxVelocity.y;
				}
			}
			
			else {
				if (y >= limitY) {
					y = limitY;
					isGoingDown = false;
					startPointY = 480;
				}
			}
		}
		
		public function resetSnowBall():void {
			y = firstStatePositionY;
			isGoingDown = firstStateOfGoing;
			velocity.y = 0;
		}
	}

}