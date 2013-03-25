package  
{
	/**
	$(CBI)* ...
	$(CBI)* @author Ozan Yıldız
	$(CBI)*/
	
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
	
		[Embed(source = "../assets/background.png")] public var backgroundPNG:Class;
		[Embed(source = "../assets/tileset.png")] public var tilesetPNG:Class;
		[Embed(source = "../assets/levels/level1.csv", mimeType = "application/octet-stream")] public var level1CSV:Class;
		[Embed(source = "../assets/levels/level2.csv", mimeType = "application/octet-stream")] public var level2CSV:Class;
		[Embed(source = "../assets/levels/level3.csv", mimeType = "application/octet-stream")] public var level3CSV:Class;
		[Embed(source = "../assets/levels/level4.csv", mimeType = "application/octet-stream")] public var level4CSV:Class;
		[Embed(source = "../assets/levels/level5.csv", mimeType = "application/octet-stream")] public var level5CSV:Class;
		[Embed(source = "../assets/levels/level6.csv", mimeType = "application/octet-stream")] public var level6CSV:Class;
		[Embed(source = "../assets/levels/level7.csv", mimeType = "application/octet-stream")] public var level7CSV:Class;
		[Embed(source = "../assets/levels/level8.csv", mimeType = "application/octet-stream")] public var level8CSV:Class;
		[Embed(source = "../assets/levels/level9.csv", mimeType = "application/octet-stream")] public var level9CSV:Class;
		[Embed(source = "../assets/levels/level10.csv", mimeType = "application/octet-stream")] public var level10CSV:Class;
		[Embed(source = "../assets/levels/level11.csv", mimeType = "application/octet-stream")] public var level11CSV:Class;
		[Embed(source = "../assets/levels/level12.csv", mimeType = "application/octet-stream")] public var level12CSV:Class;
		[Embed(source = "../assets/levels/level13.csv", mimeType = "application/octet-stream")] public var level13CSV:Class;
		[Embed(source = "../assets/levels/level14.csv", mimeType = "application/octet-stream")] public var level14CSV:Class;
		[Embed(source = "../assets/levels/level15.csv", mimeType = "application/octet-stream")] public var level15CSV:Class;
		[Embed(source = "../assets/sounds/Game Music.mp3")] public var gameMusicMp3:Class;
		[Embed(source = "../assets/sounds/Positive 2.mp3")] public var positive2Mp3:Class;
		[Embed(source = "../assets/sounds/Negative 2.mp3")] public var negative2Mp3:Class;
		
		private var currentLevel:Level;		
		public var levels:Vector.<Level> = new Vector.<Level>();
		public var currentLevelIndex:Number = 0;
		private var player:Player;
		private var levelNoText:FlxText;

		override public function create():void
		{	
			var background:FlxSprite = new FlxSprite().loadGraphic(backgroundPNG);
			add(background);

			addLevels();
			addInGameObjects();
			
			currentLevel = levels[currentLevelIndex];
			add(currentLevel);
			
			player = new Player(currentLevel.playerStartX, currentLevel.playerStartY);
			add(player);
			
			FlxG.play(gameMusicMp3, 0.2,  true);
			//FlxG.playMusic(gameMusicMp3, 0.2);
			levelNoText = new FlxText(0, 0, 550, (currentLevelIndex + 1) + "/15");
			levelNoText.size = 18;
			add(levelNoText);
			
		}
		
		override public function update():void
		{
			super.update();
			FlxG.collide(player, currentLevel.level);
			
			if (FlxG.collide(player, currentLevel.gift)) {
				FlxG.play(positive2Mp3);
				goToTheNextLevel();
			}
			
			if (player.y >= 480 || player.x >= 640 + 32 || player.x <= -32) {
				FlxG.play(negative2Mp3, 0.35);
				resetLevel();
			}
			
			for each (var elevator:MovingPlatform in currentLevel.elevators) {
				FlxG.collide(player, elevator);
			}
			
			for each (var snowballH:SnowBallH in currentLevel.snowballsH) {
				if (FlxG.collide(player, snowballH)) {
					FlxG.play(negative2Mp3, 0.35);
					resetLevel();
				}
			}
			
			for each (var snowballV:SnowBallV in currentLevel.snowballsV) {
				if (FlxG.collide(player, snowballV)) {
					FlxG.play(negative2Mp3, 0.35);
					resetLevel();
				}
			}
			
			for each (var fallingSnowball:FallingSnowBall in currentLevel.fallingSnowballs) {
				if (FlxG.collide(player, fallingSnowball)) {
					FlxG.play(negative2Mp3, 0.35);
					resetLevel();
				}
			}	
			
			if (currentLevelIndex == 14) {
				currentLevel.gift.move();
			}
			
			currentLevel.stopLimitText.text = "x " + player.stopLimit.toString();
		}
		
		private function goToTheNextLevel():void {
			currentLevel.kill();
			currentLevelIndex++;
			if (currentLevelIndex == 15) {
				FlxG.switchState(new FinalState);
			}
			else {
				add(levels[currentLevelIndex]);
				currentLevel = levels[currentLevelIndex];
				if (currentLevelIndex == 14) {
					currentLevel.gift.velocity.x = -80;
					player.canMove = false;
				}
				player.resetPlayer(currentLevel);
				player.stopLimit = currentLevel.playerStopLimit;
				levelNoText.text = (currentLevelIndex + 1) + "/15";
			}
		}
		
		private function resetLevel():void {
			player.resetPlayer(levels[currentLevelIndex]);
			for each (var elevator:MovingPlatform in currentLevel.elevators) {
				elevator.resetMovingPlatform();
			}
			for each (var snowballH:SnowBallH in currentLevel.snowballsH) {
				snowballH.resetSnowBall();
			}		
			for each (var snowballV:SnowBallV in currentLevel.snowballsV) {
				snowballV.resetSnowBall();
			}
			for each (var fallingSnowball:FallingSnowBall in currentLevel.fallingSnowballs) {
				fallingSnowball.resetSnowBall();
			}				
				
			if (currentLevelIndex == 14) {
				currentLevel.gift.resetGift();
			}			
			
		}
		
		private function addLevels():void {
			levels.push(new Level(level1CSV, tilesetPNG, 1, 12, 18, 13));
			levels.push(new Level(level2CSV, tilesetPNG, 1, 12, 17, 1));
			levels.push(new Level(level3CSV, tilesetPNG, 1, 12, 9.5, 1));
			levels.push(new Level(level4CSV, tilesetPNG, 1, 12, 18.5, 13));
			levels.push(new Level(level5CSV, tilesetPNG, 1, 12, 1.5, 6, 2));
			levels.push(new Level(level6CSV, tilesetPNG, 1, 12, 1, 1, 1));
			levels.push(new Level(level7CSV, tilesetPNG, 9, 0, 0, 9));
			levels.push(new Level(level8CSV, tilesetPNG, 0, 12, 19, 13, 1));
			levels.push(new Level(level9CSV, tilesetPNG, 7, 0, 11, 1, 2));
			levels.push(new Level(level10CSV, tilesetPNG, 0, 12, 18, 1, 1));
			levels.push(new Level(level11CSV, tilesetPNG, 0, 12, 18, 0, 0));
			levels.push(new Level(level12CSV, tilesetPNG, 18, 12, 18, 1, 1));
			levels.push(new Level(level13CSV, tilesetPNG, 1, 12, 18, 3, 1));
			levels.push(new Level(level14CSV, tilesetPNG, 0, 1, 10, 1, 1));
			levels.push(new Level(level15CSV, tilesetPNG, 8, 0, 17, 0));
		}
		
		private function addInGameObjects():void {
			// Add stop signs
			for (var i:Number = 4; i < 15; i++)
			{
				levels[i].addStopSignAndText();
			}
			//level 5
			levels[4].addElevator(17, 14, 0, 128, 40);
			//level 7
			levels[6].addElevator(9, 13, 0, 0, 0);
			//level 8
			levels[7].addSnowballV(player, 5, 15, 300, 200, false);
			levels[7].addSnowballV(player, 12, 15, 300, 200, false);
			levels[7].addSnowballV(player, 15, 8, 300, 200, true);
			//level 9
			levels[8].addFallingSnowball(player, 3, -1, 300, 200, 0);
			levels[8].addFallingSnowball(player, 5, -10, 300, 200, 9);
			//level 10
			levels[9].addFallingSnowball(player, 8, -1, 300, 200, 0);
			levels[9].addFallingSnowball(player, 11, -9, 300, 200, 8);
			//level 11
			levels[10].addSnowballH(player, 19, 9, 200, 100, false, 20, 0);
			levels[10].addSnowballH(player, 0, 6, 200, 100, true, 20, 0);
			levels[10].addSnowballH(player, 19, 3, 200, 100, false, 20, 0);
			levels[10].addSnowballH(player, 0, 0, 200, 100, true, 20, 0);
			//level 12
			levels[11].addSnowballH(player, 20, 9, 100, 100, false, 20, 0);
			levels[11].addSnowballH(player, 27, 9, 100, 100, false, 27, 6);
			levels[11].addSnowballH(player, 0, 5, 200, 100, true, 20, 0);
			levels[11].addSnowballH(player, 19, 1, 200, 100, false, 20, 0);
			//level 13
			levels[12].addSnowballH(player, 0, 10, 200, 100, true, 20, 0);
			levels[12].addSnowballH(player, 0, 7, 200, 100, true, 20, 0);
			levels[12].addSnowballH(player, 0, 3, 200, 100, true, 20, 0);
			levels[12].addSnowballV(player, 7.65, 15, 100, 40, false);
			//level 14
			levels[13].addElevator(7, 12, 5, 0, 80);
			levels[13].addElevator(15, 12, 0, 5, 80);
			//level 15
			levels[14].addElevator(8, 2, 8, 0, 80);
			levels[14].addElevator(17, 12, 17, 0, 140);
			levels[14].addElevator(17, 8, 8, 0, 100);
			levels[14].addElevator(17, 4, 7, 0, 140);
			levels[14].addElevator(17, 1, 3, 0, 80);
		}
		
	}

}