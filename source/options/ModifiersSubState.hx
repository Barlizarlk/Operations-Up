package options;

import objects.Character;

class ModifiersSubState extends BaseOptionsMenu
{
	var antialiasingOption:Int;
	var boyfriend:Character = null;
	public function new()
	{
		title = 'Modifiers';
		rpcTitle = 'Modifiers Settings Menu'; //for Discord Rich Presence

		var option:Option = new Option('PRACTICE',
			"Baby mode initiate. Practice your songs however you want, you won't be dying anytime soon. Can be switched on or off.",
			'Practice',
			'bool');
		addOption(option);

		var option:Option = new Option('SINGLE DIGITS',
			"You can count the amount of misses on your hand. Miss 10 times and it's over for you. Can be switched on or off.",
			'SingleDigits',
			'bool');
		addOption(option);

		var option:Option = new Option('PERFECT',
			"You have quite a thing to deal with today. Miss only once and it's game over for you. Can be switched on or off.",
			'Perfect',
			'bool');
		addOption(option);

		var option:Option = new Option('SHITTY ENDING',
			"Well this will result in a trip to the toilet. Score one shit rating and it's over. Can be switched on or off.",
			'ShittyEnding',
			'bool');
		addOption(option);

		var option:Option = new Option('BAD TRIP',
			"Locomotion issues. I get it. Score one bad rating and it's over. Can be switched on or off.",
			'BadTrip',
			'bool');
		addOption(option);

		var option:Option = new Option('TRUE PERFECT',
			"Good luck. Seriously, you need it. Score one good rating and it's over. Can be switched on or off.",
			'TruePerfect',
			'bool');
		addOption(option);

		var option:Option = new Option('HEALTH LOSS',
			"Why are you bruising so hard? Set how fast you can lose your health, or not lose any at all. The higher, the faster you can lose health. Can be changed numerically.",
			'HPLoss',
			'float');
		addOption(option);
		option.minValue = 0;
		option.maxValue = 10;

		var option:Option = new Option('HEALTH GAIN',
			"Nice health boost, my guy. Set how fast you can regain your health. The highter, the faster you can regenerate. You can even not do that at all. Can be changed numerically.",
			'HPGain',
			'float');
		addOption(option);
		option.minValue = 0;
		option.maxValue = 10;

		var option:Option = new Option('MAX HEALTH',
			"Expanding your health now eh? Set your max health. The highter, the more max health you get. Can be changed numerically.",
			'MaxHealth',
			'float');
		addOption(option);
		option.changeValue = 0.1;
		option.minValue = 1.5;
		option.maxValue = 10;

		var option:Option = new Option('LIVES',
			"Set how many lives you can give yourself to save your butt from death itself. The higher, the more lives you have. Can be changed numerically.",
			'Lives',
			'int');
		addOption(option);
		option.changeValue = 1;
		option.minValue = 1;
		option.maxValue = 15;

		var option:Option = new Option('ASS WHOOPIN',
			"How much ass whoopin do you want? Change how much enemies should damage Boyfriend per note. Can be changed numerically. WARNING: CAN BLUE BALL YOU IF YOU SET IT TOO HIGH.",
			'mustDie',
			'float');
		addOption(option);
		option.minValue = 0;
		option.maxValue = 500;

		var option:Option = new Option('MORE WIDE',
			"Thicc notes are so funny, hahaha... *sarcasm* How wide notes should be? The higher the wider. Can be changed numerically.",
			'wideNotes',
			'float');
		addOption(option);
		option.minValue = 0;
		option.maxValue = 400;

		var option:Option = new Option('MORE STRETCHED',
			"Tall notes are so funny, hahaha... *sarcasm* How tall notes should be? The higher the taller. Can be changed numerically.",
			'tallNotes',
			'float');
		addOption(option);
		option.minValue = 0;
		option.maxValue = 400;

		var option:Option = new Option('ENIGMA',
			"Your vision is blind, woooow. You won't be able to see your mistakes. Set if you want your health to be invisible. Can be switched on or off.",
			'enigma',
			'bool');
		addOption(option);

		var option:Option = new Option('BRIGHTNESS',
			"Did you do anything to the lights? Set how bright or dark the game is. Positive values are brighter, negative - darker. Can be changed numerically.",
			'brightness',
			'float');
		addOption(option);
		option.changeValue = 0.1;
		option.minValue = -100;
		option.maxValue = 100;

		var option:Option = new Option('MORE START HEALTH',
			"How much slapping did you get before going here? Set how high your health should be at the start. The higher, the higher. Can be changed numerically.",
			'StartHealth',
			'float');
		addOption(option);
		option.minValue = 0;
		option.maxValue = 10;
		option.changeValue = 0.1;

		var option:Option = new Option('RANDOM LOSS',
			"It's time to test your luck today. Set how likely you are to lose health by hitting a note instead of gaining. The higher, the more likely. Can be changed numerically.",
			'RandomLoss',
			'int');
		addOption(option);
		option.minValue = 0;
		option.maxValue = 10;
		option.changeValue = 1;

		var option:Option = new Option('INVISIBLE NOTES',
			"Today we're relying on memory. Switch notes visible or invisible. Can be switched on or off.",
			'InvisibleNotes',
			'bool');
		addOption(option);

		var option:Option = new Option('QUAKING',
			"This is some tokyo nonsense. Set how big of an earthquake you want to play with. The higher, the bigger. Can be changed numerically.",
			'Earthquake',
			'float');
		addOption(option);
		option.minValue = 0;
		option.maxValue = 500;
		option.changeValue = 0.5;

		var option:Option = new Option('MORE LOVE',
			"Girlfriend loves you very much. How much health do you want to regenerate gradually? The higher, the more love, support and all of that. Can be changed numerically.",
			'Love',
			'float');
		addOption(option);
		option.minValue = 0;
		option.maxValue = 500;
		option.changeValue = 0.5;

		var option:Option = new Option('POISON DOSE',
			"Please don't be scared. How much health do you want to drain gradually? The higher, the more poison, fear and all of that. Can be changed numerically. WARNING: CAN BLUE BALL YOU IF YOU SET IT TOO HIGH.",
			'Fright',
			'float');
		addOption(option);
		option.minValue = 0;
		option.maxValue = 500;
		option.changeValue = 0.5;

		var option:Option = new Option('SEASICK',
			"Ship feel go swoosh and barf. How much do you want the camera to swing like a ship? The higher, the more they swing. Can be changed numerically.",
			'Seasick',
			'float');
		addOption(option);
		option.minValue = 0;
		option.maxValue = 500;
		option.changeValue = 0.5;

		var option:Option = new Option('DRUNK NOTES',
			"Ohhh. What the funk did you drink? Set how much notes should swing up and down. The higher, the more they swing. Can be changed numerically.",
			'DrunkNotes',
			'float');
		addOption(option);
		option.minValue = 0;
		option.maxValue = 400;
		option.changeValue = 0.5;

		var option:Option = new Option('SNAKE NOTES',
			"Ayyyy. I guess we're becoming snakes today. Set how much should notes swing left and right. The higher, the more they swing. Can be changed numerically.",
			'SnakeNotes',
			'float');
		addOption(option);
		option.minValue = 0;
		option.maxValue = 400;
		option.changeValue = 0.5;

		var option:Option = new Option('HYPER NOTES',
			"...How much sugar did you eat? Come on... Give your notes a bit of sugar rush and shake them as much as possible. The higher, the more shaking. Can be changed numerically. WARNING: REALLY DIFFICULT AT HIGH VALUES.",
			'HyperNotes',
			'float');
		addOption(option);
		option.minValue = 0;
		option.maxValue = 400;
		option.changeValue = 0.5;

		var option:Option = new Option('FLIPPED NOTES',
			"Oooh no. All around your head. Flip how your notes look. Left is right, up is down. Can be switched on or off.",
			'FlippedNotes',
			'bool');
		addOption(option);

		var option:Option = new Option('MIRROR',
			"Mirror your own screen. Fun for everyone. Can be switched on or off.",
			'Mirror',
			'bool');
		addOption(option);

		var option:Option = new Option('UPSIDE DOWN',
			"Flip everything upside down. Not zero-gravity. Can be switched on or off.",
			'UpsideDown',
			'bool');
		addOption(option);

		var option:Option = new Option('CAMERA SPIN',
			"Wooooah. My head's spinning. Choose how much you can the cameras to spin around. The higher, the more they spin. Can be changed numerically.",
			'CameraSpin',
			'float');
		addOption(option);
		option.minValue = 0;
		option.maxValue = 500;
		option.changeValue = 0.5;

		var option:Option = new Option('WAVY GAMEPLAY',
			"Make your entire game wiggle around. Can be switched on or off.",
			'wavyGame',
			'bool');
		addOption(option);

		var option:Option = new Option('WAVY HUD',
			"Make your hud wiggle around. Can be switched on or off.",
			'wavyHud',
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