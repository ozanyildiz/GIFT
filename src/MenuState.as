package  
{
	import org.flixel.*;
	/**
	$(CBI)* ...
	$(CBI)* @author Ozan Yıldız
	$(CBI)*/
	
	public class MenuState extends FlxState
	{
		[Embed(source = "../assets/menu.png")] public var menuPNG:Class;
		[Embed(source = "../assets/sounds/Menu Music.mp3")] public var menuMusicMp3:Class;
		private var menuSprite:FlxSprite;

		override public function create():void
		{	
			FlxG.play(menuMusicMp3, 1,  true);
			menuSprite = new FlxSprite(0, 0).loadGraphic(menuPNG);
			add(menuSprite);
		}
		
		override public function update():void 
		{
			if (FlxG.keys.justPressed("SPACE")) {
				FlxG.switchState(new PlayState);
			}
		}
	}

}