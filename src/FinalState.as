package  
{
	import org.flixel.*;
	/**
	$(CBI)* ...
	$(CBI)* @author Ozan Yıldız
	$(CBI)*/
	public class FinalState extends FlxState
	{
		[Embed(source = "../assets/finalbg1.png")] public var background1PNG:Class;
		[Embed(source = "../assets/finalbg2.png")] public var background2PNG:Class;
		[Embed(source = "../assets/sounds/Credits Music.mp3")] public var creditMusicMp3:Class;
		
		private var background1:FlxSprite;
		private var background2:FlxSprite;
		private var timePassed:Number = 0;
		private var firstBackground:Boolean = false;
		protected var text:FlxText;
		
		override public function create():void
		{
			FlxG.play(creditMusicMp3, 1,  true);
			background1 = new FlxSprite().loadGraphic(background1PNG);
			add(background1);
			background2 = new FlxSprite().loadGraphic(background2PNG);
			add(background2);
			background2.visible = false;
			
			text = new FlxText(205, 375, FlxG.width, "Thanks for playing!");
			text.size = 18;
			add(text);
		}
		
		override public function update():void
		{
			timePassed += FlxG.elapsed;
			if (timePassed >= 0.2 && firstBackground == false) {
				background1.visible = false;
				background2.visible = true;
				timePassed = 0;
				firstBackground = true;
			}
			
			else if (timePassed >= 0.2 && firstBackground == true) {
				background2.visible = false;
				background1.visible = true;
				timePassed = 0;
				firstBackground = false;
			}
		}
		
	}

}