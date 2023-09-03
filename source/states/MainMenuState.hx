package states;

import backend.WeekData;
import backend.Achievements;

import flixel.FlxObject;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;

import flixel.input.keyboard.FlxKey;
import lime.app.Application;

import objects.AchievementPopup;
import states.editors.MasterEditorMenu;
import options.OptionsState;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxGradient;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.7h'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;
	
	var optionShit:Array<String> = [
		'play',
		#if MODS_ALLOWED 'mods', #end
		'credits',
		'options'
	];

	var magenta:FlxSprite;
	var bg:FlxSprite;
	var camFollow:FlxObject;

	var checker:FlxBackdrop = new FlxBackdrop(Paths.image('Main_Checker'), 0.2, 0.2, true, true);
	var gradientBar:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, 300, 0xFFAA00AA);

	var camLerp:Float = 0.1;

	override function create()
	{
		#if MODS_ALLOWED
		Mods.pushGlobalMods();
		#end
		Mods.loadTopMod();

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement, false);
		FlxG.cameras.setDefaultDrawTarget(camGame, true);

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		var yScroll:Float = Math.max(0.25 - (0.05 * (optionShit.length - 4)), 0.1);
		//var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuBG'));
		//bg.antialiasing = ClientPrefs.data.antialiasing;
		//bg.scrollFactor.set(0, yScroll);
		//bg.setGraphicSize(Std.int(bg.width * 1.175));
		//bg.updateHitbox();
		//bg.screenCenter();
		//add(bg);

        	bg = new FlxSprite(-80).loadGraphic(Paths.image('mBG_Main'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.16;
		bg.setGraphicSize(Std.int(bg.width * 1.225));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		bg.angle = 179;
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		gradientBar = FlxGradient.createGradientFlxSprite(Math.round(FlxG.width), 512, [0x00ff0000, 0x55AE59E4, 0xAA19ECFF], 1, 90, true);
		gradientBar.y = FlxG.height - gradientBar.height;
		add(gradientBar);
		gradientBar.scrollFactor.set(0, 0);

		add(checker);
		checker.scrollFactor.set(0, 0.07);

		var side:FlxSprite = new FlxSprite(0).loadGraphic(Paths.image('Main_Side'));
		side.scrollFactor.x = 0;
		side.scrollFactor.y = 0;
		side.antialiasing = true;
		add(side);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		magenta.antialiasing = ClientPrefs.data.antialiasing;
		magenta.scrollFactor.set(0, yScroll);
		magenta.setGraphicSize(Std.int(magenta.width * 1.175));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.color = 0xFFfd719b;
		add(magenta);
		
		// magenta.scrollFactor.set();

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var scale:Float = 1;
		/*if(optionShit.length > 6) {
			scale = 6 / optionShit.length;
		}*/

		for (i in 0...optionShit.length)
		{
			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			// var menuItem:FlxSprite = new FlxSprite(curoffset, (i * 140) + offset);
			   var menuItem:FlxSprite = new FlxSprite(-800, 40 + (i * 200) + offset);
			// menuItem.scale.x = scale;
			// menuItem.scale.y = scale;
			menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[i]);
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			FlxTween.tween(menuItem, {x: menuItem.width / 4 + (i * 180) - 30}, 1.3, {ease: FlxEase.expoInOut});
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if(optionShit.length < 6) scr = 0;
			menuItem.scrollFactor.set(0, scr);
			menuItem.antialiasing = ClientPrefs.data.antialiasing;
			menuItem.updateHitbox();
		}

		FlxG.camera.follow(camFollow, null, 0);

		FlxG.camera.zoom = 3;
		side.alpha = 0;
		FlxTween.tween(FlxG.camera, {zoom: 1}, 1.1, {ease: FlxEase.expoInOut});
		FlxTween.tween(bg, {angle: 0}, 1, {ease: FlxEase.quartInOut});
		FlxTween.tween(side, {alpha: 1}, 0.9, {ease: FlxEase.quartInOut});

		var versionShit:FlxText = new FlxText(12, FlxG.height - 44, 0, "Psych Engine v" + psychEngineVersion, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();

		changeItem();

		#if ACHIEVEMENTS_ALLOWED
		Achievements.loadAchievements();
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18) {
			var achieveID:Int = Achievements.getAchievementIndex('friday_night_play');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) { //It's a friday night. WEEEEEEEEEEEEEEEEEE
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement();
				ClientPrefs.saveSettings();
			}
		}
		#end

		super.create();

		new FlxTimer().start(1.1, function(tmr:FlxTimer)
			{
				selectable = true;
			});
	}

	var selectable:Bool = false;

	#if ACHIEVEMENTS_ALLOWED
	// Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement() {
		add(new AchievementPopup('friday_night_play', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), ClientPrefs.data.soundVolume / 100);
		trace('Giving achievement "friday_night_play"');
	}
	#end

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{

		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * elapsed;
			if(FreeplayState.vocals != null) FreeplayState.vocals.volume += 0.5 * elapsed;
		}
		FlxG.camera.followLerp = FlxMath.bound(elapsed * 9 / (FlxG.updateFramerate / 60), 0, 1);

		checker.x -= 0.45 / (ClientPrefs.data.framerate / 60);
		checker.y -= 0.16 / (ClientPrefs.data.framerate / 60);

		if (!selectedSomethin && selectable)
		{
			if (controls.UI_UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'), ClientPrefs.data.soundVolume / 100);
				changeItem(-1);
			}

			if (controls.UI_DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'), ClientPrefs.data.soundVolume / 100);
				changeItem(1);
			}

			if(FlxG.mouse.wheel != 0)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'), ClientPrefs.data.soundVolume / 100 - 0.6);
				changeItem(-FlxG.mouse.wheel);
			}

			if (controls.BACK || FlxG.mouse.justPressedRight)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				DiscordClient.changePresence("Back to the Title Screen.", null);
				MusicBeatState.switchState(new TitleState());
			}

			if (controls.ACCEPT || FlxG.mouse.justPressed)
			{
				if (optionShit[curSelected] == 'donate')
				{
					CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'), ClientPrefs.data.soundVolume / 100);
					DiscordClient.changePresence("Chosen: " + optionShit[curSelected].toUpperCase(), null);

					// if(ClientPrefs.data.flashing) FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
						FlxTween.tween(FlxG.camera, {zoom: 5}, 0.8, {ease: FlxEase.expoIn});
						FlxTween.tween(bg, {angle: 45}, 0.8, {ease: FlxEase.expoIn});

							FlxTween.tween(spr, {alpha: 0}, 0.4, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							// FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							new FlxTimer().start(0.35, function(tmr:FlxTimer)
							{
								var daChoice:String = optionShit[curSelected];

								switch (daChoice)
								{
									case 'play':
										MusicBeatState.switchState(new PlaySelection());
									DiscordClient.changePresence("Going to the play selection.", null);
									#if MODS_ALLOWED
									case 'mods':
										MusicBeatState.switchState(new ModsMenuState());
									DiscordClient.changePresence("Going to the mods menu.", null);
									#end
									case 'awards':
										MusicBeatState.switchState(new AchievementsMenuState());
									case 'credits':
										MusicBeatState.switchState(new CreditsState());
									DiscordClient.changePresence("Gonna check some cool ppl.", null);
									case 'options':
										LoadingState.loadAndSwitchState(new OptionsState());
									DiscordClient.changePresence("Gonna set some options brb.", null);
										OptionsState.onPlayState = false;
										if (PlayState.SONG != null)
										{
											PlayState.SONG.arrowSkin = null;
											PlayState.SONG.splashSkin = null;
										}
								}
							});
						}
					});
				}
			}
			#if desktop
			else if (controls.justPressed('debug_1'))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
			//spr.screenCenter(X);

			spr.scale.set(FlxMath.lerp(spr.scale.x, 0.6, camLerp / (ClientPrefs.data.framerate / 60)), FlxMath.lerp(spr.scale.y, 0.6, 0.4 / (ClientPrefs.data.framerate / 60)));
			spr.y = FlxMath.lerp(spr.y, -40 + (spr.ID * 175), 0.4 / (ClientPrefs.data.framerate / 60));

			if (spr.ID == curSelected)
			{
				spr.scale.set(FlxMath.lerp(spr.scale.x, 0.9, camLerp / (ClientPrefs.data.framerate / 60)), FlxMath.lerp(spr.scale.y, 0.9, 0.4 / (ClientPrefs.data.framerate / 60)));
				spr.y = FlxMath.lerp(spr.y, -90 + (spr.ID * 175), 0.4 / (ClientPrefs.data.framerate / 60));
			}

		});
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');
			//spr.updateHitbox();
			// spr.scale.x = 0.7;
			// spr.scale.y = 0.7;

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				// spr.scale.x = 1.0;
				// spr.scale.y = 1.0;
				var add:Float = 0;
				if(menuItems.length > 4) {
					add = menuItems.length * 8;
				}
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y - add);
				//spr.centerOffsets();
			}
		});
		DiscordClient.changePresence("Main Menu: " + optionShit[curSelected].toUpperCase(), null);
	}
}
