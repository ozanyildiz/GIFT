package  
{
	import flash.display.GraphicsTrianglePath;
	import org.flixel.*;
	/**
	$(CBI)* ...
	$(CBI)* @author Ozan Yıldız
	$(CBI)*/
	
	public class Level extends FlxGroup
	{
		public var level:FlxTilemap;
		
		public var playerStartX:Number;
		public var playerStartY:Number;
		public var giftX:Number;
		public var giftY:Number;
		public var gift:Gift;
		
		public var elevators:Vector.<MovingPlatform> = new Vector.<MovingPlatform>();
		public var snowballsH:Vector.<SnowBallH> = new Vector.<SnowBallH>();
		public var snowballsV:Vector.<SnowBallV> = new Vector.<SnowBallV>();
		public var fallingSnowballs:Vector.<FallingSnowBall> = new Vector.<FallingSnowBall>();
		public var playerStopLimit:Number;
		
		[Embed(source = "../assets/stop_sign25x25.png")] public var stopPNG:Class;
		public var stopLimitText:FlxText;
		private var stopSign:FlxSprite;
				
		public function Level(levelCSV:Class, tilesetPNG:Class, playerStartX:Number, playerStartY:Number, giftX:Number, giftY:Number, playerStopLimit:Number = 0) 
		{
			this.playerStartX = playerStartX * 32;
			this.playerStartY = playerStartY * 32 + 20;
			this.playerStopLimit = playerStopLimit;
			
			this.giftX = giftX * 32;
			this.giftY = giftY * 32;
			
			level = new FlxTilemap().loadMap(new levelCSV, tilesetPNG);
			add(level);
			
			gift = new Gift(this.giftX, this.giftY);
			add(gift);
			
			stopSign = new FlxSprite(295, 5).loadGraphic(stopPNG);
			
			stopLimitText = new FlxText(325, 5, FlxG.width, "x " + playerStopLimit.toString());
			stopLimitText.size = 18;
		}
		
		public function addStopSignAndText():void {
			add(stopSign);
			add(stopLimitText);
		}
		
		public function addElevator(X:Number, Y:Number, Width:Number, Height:Number, speed:Number):void {
			elevators.push(new MovingPlatform(X * 32, Y * 32, Width * 32, Height * 32, speed));
			add(elevators[elevators.length - 1]);
		}
		
		public function addSnowballH(player:Player, X:Number, Y:Number, speed:Number, accelerationX:Number, isGoingRight:Boolean, range:Number, delay:Number):void {
			snowballsH.push(new SnowBallH(player, X * 32, Y * 32, speed, accelerationX, isGoingRight, range * 32, delay * 32));
			add(snowballsH[snowballsH.length - 1]);
		}
		
		public function addSnowballV(player:Player, X:Number, Y:Number, speed:Number, accelerationY:Number, isGoingDown:Boolean):void {
			snowballsV.push(new SnowBallV(player, X * 32, Y * 32, speed, accelerationY, isGoingDown));
			add(snowballsV[snowballsV.length - 1]);
		}
		
		public function addFallingSnowball(player:Player, X:Number, Y:Number, speed:Number, accelerationY:Number, delay:Number):void {
			fallingSnowballs.push(new FallingSnowBall(player, X * 32, Y * 32, speed, accelerationY, delay * 32));
			add(fallingSnowballs[fallingSnowballs.length - 1]);
		}
		
	}

}