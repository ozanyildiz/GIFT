package  
{
	/**
	$(CBI)* ...
	$(CBI)* @author Ozan Yıldız
	$(CBI)*/
	
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{		
		[Embed(source = "../assets/TimmySpriteSheet.png")] public var playerPNG:Class;
		[Embed(source = "../assets/sounds/Jumping.mp3")] public var jumpMP3:Class;
		[Embed(source = "../assets/sounds/skating2.mp3")] public var skatingMP3:Class;
		
		private var jumpSound:FlxSound;
		private var skatingSound:FlxSound;
		
		private var jumped:Boolean = false;
		public var stopLimit:Number = 0;
		public var state:String = "stand";
		public var canMove:Boolean = true;
		public var isSkating:Boolean = false;
		
		private var isStopActivated:Boolean = false;
		
		public function Player(X:Number, Y:Number)
		{
			super(X, Y);
			loadGraphic(playerPNG, false, true, 32, 32);
			maxVelocity.x = 200;
			maxVelocity.y = 600;
			acceleration.y = 550;
			drag.x = maxVelocity.x * 8;
			facing = RIGHT;
			addAnimation("skate", [0, 1, 2, 3, 4, 5, 6, 7], 6, true);
			addAnimation("jump", [8], 1, false);
			addAnimation("stop", [9], 1, false);
			addAnimation("stand", [9], 1, false);
			play("stand");
			
			jumpSound = new FlxSound();
			jumpSound.loadEmbedded(jumpMP3);
			
			skatingSound = new FlxSound();
			skatingSound.loadEmbedded(skatingMP3);
			
			width = 20;
			height = 32;
			offset.x = 4;
		}
		
		private var everyT:Number = 0.75;
		private var timePassed:Number = 0.75;
		
		override public function update():void
		{			
			if (isSkating) {
				timePassed += FlxG.elapsed;
				if (timePassed >= everyT) {
					FlxG.play(skatingMP3, 0.5);
					//skatingSound.play();
					timePassed = 0;
				}
			}
			
			if (!isTouching(FlxObject.FLOOR)) {
				isSkating = false;
				play("jump");
			}
			
			else {			
				if (state == "walk") {
					isSkating = true;
					play("skate");
				}
				else if (state == "stop") {
					play("stop");
				}
				else if (state == "stand") {
					play("stand");
				}
			}
			
			if (FlxG.keys.LEFT && isTouching(FlxObject.FLOOR) && canMove)
			{
				state = "walk";
				acceleration.x = -maxVelocity.x * 4;
				facing = LEFT;
				isSkating = true;
			}	
			if (FlxG.keys.RIGHT && isTouching(FlxObject.FLOOR) && canMove)
			{
				state = "walk";
				acceleration.x = maxVelocity.x * 4;
				facing = RIGHT;
				isSkating = true;
			}
			if (FlxG.keys.UP && isTouching(FlxObject.FLOOR))
			{
				velocity.y -= maxVelocity.y / 1.5;
				//FlxG.play(jumpMP3);
				skatingSound.pause();
				jumpSound.play();
				isSkating = false;
				timePassed = 0.75;
			}
			if (!isStopActivated && FlxG.keys.pressed("DOWN") && isTouching(FlxObject.FLOOR) && stopLimit > 0)
			{
				isStopActivated = true;
				state = "stop";
				stopLimit--;
				acceleration.x = 0;
				isSkating = false;
			}
			if (FlxG.keys.justReleased("DOWN") && state == "stop") 
			{
				isStopActivated = false;
			}
		}
		
		public function resetPlayer(currentLevel:Level):void {
			stopLimit = currentLevel.playerStopLimit;
			x = currentLevel.playerStartX;
			y = currentLevel.playerStartY;
			acceleration.x = 0;
			velocity.x = 0;
			velocity.y = 0;
			jumped = false;
			facing = RIGHT;
			state = "stand";
			everyT = 0.75;
			timePassed = 0.75;
			isSkating = false;
		}
	
	}

}