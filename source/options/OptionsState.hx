package options;

import states.MainMenuState;
import backend.StageData;

import flixel.util.FlxGradient;
import flixel.addons.display.FlxBackdrop;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class OptionsState extends MusicBeatState
{
	var options:Array<String> = ['Note Colors', 'Controls', 'Adjust Delay and Combo', 'Graphics', 'Visuals and UI', 'Gameplay', 'Modifiers', 'Audio'];
	private var grpOptions:FlxTypedGroup<Alphabet>;
	private static var curSelected:Int = 0;
	public static var menuBG:FlxSprite;
	public static var onPlayState:Bool = false;
	var bg:FlxSprite;
	var checker:FlxBackdrop;
	var gradientBar:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, 300, 0xFFAA00AA);
	var side:FlxSprite;

	function openSelectedSubstate(label:String) {
		switch(label) {
			case 'Note Colors':
				openSubState(new options.NotesSubState());
			case 'Controls':
				openSubState(new options.ControlsSubState());
			case 'Graphics':
				openSubState(new options.GraphicsSettingsSubState());
			case 'Visuals and UI':
				openSubState(new options.VisualsUISubState());
			case 'Gameplay':
				openSubState(new options.GameplaySettingsSubState());
			case 'Modifiers':
				openSubState(new options.ModifiersSubState());
			case 'Audio':
				openSubState(new options.AudioSubState());
			case 'Adjust Delay and Combo':
				MusicBeatState.switchState(new options.NoteOffsetState());
		}
	}

	var selectorLeft:Alphabet;
	var selectorRight:Alphabet;

	override function create() {
		#if desktop
		DiscordClient.changePresence("Options Menu", null);
		#end

		bg = new FlxSprite().loadGraphic(Paths.image('oBG'));
		bg.antialiasing = ClientPrefs.data.antialiasing;
		// bg.color = 0xFFea71fd;
		bg.updateHitbox();

		bg.screenCenter();
		add(bg);

		gradientBar = FlxGradient.createGradientFlxSprite(Math.round(FlxG.width), 512, [0x00ff0000, 0x55FFBDF8, 0xAAFFFDF3], 1, 90, true);
		gradientBar.y = FlxG.height - gradientBar.height;
		add(gradientBar);
		gradientBar.scrollFactor.set(0, 0);

		checker = new FlxBackdrop(Paths.image('Options_Checker'), 0.2, 0.2, true, true);
		add(checker);
		checker.scrollFactor.set(0, 0.07);

		side = new FlxSprite(0).loadGraphic(Paths.image('Options_Side'));
		side.scrollFactor.x = 0;
		side.scrollFactor.y = 0;
		side.antialiasing = true;
		side.screenCenter();
		// side.flipX = true;
		add(side);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		for (i in 0...options.length)
		{
			var optionText:Alphabet = new Alphabet(0, 0, options[i], true);
			optionText.screenCenter(Y);
			optionText.y += (80 * (i - (options.length / 2))) + 50;
			optionText.x += 1200;
			optionText.alignment = RIGHT;
			grpOptions.add(optionText);
		}

		selectorLeft = new Alphabet(0, 0, '>', true);
		// add(selectorLeft);

		selectorRight = new Alphabet(0, 0, '<', true);
		// add(selectorRight);

		changeSelection();
		ClientPrefs.saveSettings();

		super.create();
	}

	override function closeSubState() {
		super.closeSubState();
		ClientPrefs.saveSettings();
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		checker.x -= -0.27 / (ClientPrefs.data.framerate / 60);
		checker.y -= 0.63 / (ClientPrefs.data.framerate / 60);

		if (controls.UI_UP_P) {
			changeSelection(-1);
		}
		if (controls.UI_DOWN_P) {
			changeSelection(1);
		}

			if(FlxG.mouse.wheel != 0)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'), ClientPrefs.data.soundVolume / 100 - 0.6);
				changeSelection(-FlxG.mouse.wheel);
			}

		if (controls.BACK || FlxG.mouse.justPressedRight) {
			FlxG.sound.play(Paths.sound('cancelMenu'), ClientPrefs.data.soundVolume / 100);
			if(onPlayState)
			{
				StageData.loadDirectory(PlayState.SONG);
				LoadingState.loadAndSwitchState(new PlayState());
				FlxG.sound.music.volume = 0;
			}
			else MusicBeatState.switchState(new MainMenuState());


				FlxTween.tween(FlxG.camera, { zoom: 2}, 0.4, { ease: FlxEase.expoIn});
				FlxTween.tween(bg, { y: 0-bg.height}, 0.4, { ease: FlxEase.expoIn });
				FlxTween.tween(checker, { alpha:0}, 0.4, { ease: FlxEase.quartInOut});

		}
		else if (controls.ACCEPT || FlxG.mouse.justPressed) openSelectedSubstate(options[curSelected]);
	}
	
	function changeSelection(change:Int = 0) {
		curSelected += change;
		if (curSelected < 0)
			curSelected = options.length - 1;
		if (curSelected >= options.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpOptions.members) {
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			if (item.targetY == 0) {
				item.alpha = 1;
				selectorLeft.x = item.x - 63;
				selectorLeft.y = item.y;
				selectorRight.x = item.x + item.width + 15;
				selectorRight.y = item.y;
			}
		}
		FlxG.sound.play(Paths.sound('scrollMenu'), ClientPrefs.data.soundVolume / 100);
	}

	override function destroy()
	{
		ClientPrefs.loadPrefs();
		super.destroy();
	}
}