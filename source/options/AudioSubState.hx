package options;

import objects.Character;

class AudioSubState extends BaseOptionsMenu
{
	var antialiasingOption:Int;
	var boyfriend:Character = null;
	public function new()
	{
		title = 'Audio';
		rpcTitle = 'Audio Settings Menu'; //for Discord Rich Presence

		var option:Option = new Option('Global Sound Effects Volume',
			'Sets the volume of the Sound Effects of the menus.',
			'soundVolume',
			'int');
		addOption(option);	
		option.scrollSpeed = 60;
		option.minValue = 0;
		option.maxValue = 100;
		option.changeValue = 1;
		option.decimals = 1;

		var option:Option = new Option('Vocal Track Volume',
			'Sets the volume of the vocal track for in-game songs.',
			'vocalsVolume',
			'int');
		addOption(option);	
		option.scrollSpeed = 60;
		option.minValue = 0;
		option.maxValue = 100;
		option.changeValue = 1;
		option.decimals = 1;

		var option:Option = new Option('Mute Vocal When Missing',
			'If unchecked, Missing will not mute BF.',
			'muteVocalsOnMiss',
			'bool');
		addOption(option);

		super();
	}

	function onChangeAntiAliasing()
	{
		for (sprite in members)
		{
			var sprite:FlxSprite = cast sprite;
			if(sprite != null && (sprite is FlxSprite) && !(sprite is FlxText)) {
				sprite.antialiasing = ClientPrefs.data.antialiasing;
			}
		}
	}

	override function changeSelection(change:Int = 0)
	{
		super.changeSelection(change);
	}
}