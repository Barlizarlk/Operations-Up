package states;

import lime.app.Application;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import openfl.Lib;
import flixel.addons.transition.TransitionData;
import flixel.addons.transition.Transition;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;

using StringTools;

class NotAvalibleState extends MusicBeatState
{
	var nextMsg:Bool = false;
	var sinMod:Float = 0;
	var txt:FlxText;

	public static var leftState:Bool = false;

	override function create()
	{

		txt = new FlxText(0, 360, FlxG.width,
			"This menu is not avalible at the moment.\n\n"
			+ "It may take a while before this menu is worked on and fully devloped"
			+ " Please note this menu may be fully removed in future versions if deemed too difficult.\n\n"
			+ "Barlizarlk out.\nPress ENTER to go back",
			32);
		txt.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		add(txt);

		super.create();
	}

	override function update(elapsed:Float)
	{
		var no:Bool = false;
		sinMod += 0.007;
		txt.y = Math.sin(sinMod) * 60 + 100;

		if (FlxG.keys.justPressed.ENTER)
		{
			leftState = true;
			MusicBeatState.switchState(new PlaySelection());
		}

		super.update(elapsed);
	}
}
