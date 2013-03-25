package
{
	import org.flixel.*;
	
	public class MovingPlatform extends FlxSprite
	{
		[Embed(source = '../assets/movingplatform.png')] private var elevatorPNG:Class;
		
		public var moveX:Boolean = false;
		public var moveY:Boolean = false;
		private var startPoint:FlxPoint;
		private var endPoint:FlxPoint;	

		// Up is positive on vertical movement
		// Right is positive on horizontal movement
		
		public function MovingPlatform(X:Number, Y:Number, Width:Number, Height:Number, speed:Number)
		{
			super(X, Y, elevatorPNG);
			
			startPoint = new FlxPoint(X, Y);
			endPoint = new FlxPoint(X - Width, Y - Height);
			
			if (Width > 0) {
				moveX = true;
				velocity.x = speed;
			}
			
			if (Height > 0) {
				moveY = true;
				velocity.y = speed;
			}
			
			immovable = true;
		}
		
		public function resetMovingPlatform():void {
			x = startPoint.x;
			y = startPoint.y;
		}
		
		override public function update():void {			
			if (moveX) {
				if (x < endPoint.x) {
					x = endPoint.x;
					velocity.x = -velocity.x;
				}
				else if (x > startPoint.x) {
					x = startPoint.x;
					velocity.x = -velocity.x;
				}
			}
			
			if (moveY) {
				if (y < endPoint.y) {
					y = endPoint.y;
					velocity.y = -velocity.y;
				}
				else if (y > startPoint.y) {
					y = startPoint.y;
					velocity.y = -velocity.y;
				}
				
			}
		}
		
	}
}