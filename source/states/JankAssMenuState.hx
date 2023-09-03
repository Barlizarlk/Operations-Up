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

class JankAssMenuState extends MusicBeatState
{
	var nextMsg:Bool = false;
	var sinMod:Float = 0;
	var txt:FlxText;

	public static var leftState:Bool = false;

	override function create()
	{

		txt = new FlxText(0, 360, FlxG.width,
			"WARNING:\nThis menu is unfinished or highly unstable.\n\n"
			+ "It may crash, give bugs or issues when used in certain ways"
			+ " If any issues happen. report them to the operation's up gamebanana."
			+ " Please note this menu may be removed in future versions if deemed too buggy or not updatable.\n\n"
			+ "You have been warned.\nBarlizarlk out.\nPress ENTER to proceed",
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
			MusicBeatState.switchState(new EndlessState());
		}

		super.update(elapsed);
	}
}
