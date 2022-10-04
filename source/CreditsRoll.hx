package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;

#if windows
import Discord.DiscordClient;
#end

class CreditsRoll extends MusicBeatState
{
	var origamiLogo:FlxSprite;
	var credtxt:FlxText;
	var unlocktxt:FlxText;

	override function create()
	{
		super.create();

		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Watching The Credits", null);
		#end
		
		origamiLogo = new FlxSprite(-1100, 1000).loadGraphic(Paths.image('TheOrigamiKingLogo'));
		origamiLogo.screenCenter(X);
		add(origamiLogo);

		
		credtxt = new FlxText(0, 800, FlxG.width,
			"DEV TEAM\n\n\nNinKey - Director/Lead Artist/Animator\n\nArtPanz - Artist/Animator\n\nSnak - Musician/Storywriter\n\nant0nal0g - Programmer\n\nDoodlz - Artist\n\nDiscWraith - Charter\n\nAguaCrunch - Musician\n\nAizakku - Portugese Translator\n\nSoulegal - Portuguese Translator\n\nFireMarioFan - Composer of [Coming Soon! ;)]\n\nJuno Songs - Voice Acting\n\nMan on the Internet - Yape\n\nHostKal - Background Help\n\nHenrySL - Chromatics Help\n\nFlarewire - Chromatics Help\n\nMargetalt - Chromatics Help\n\n\n\nBETA TESTERS\n\n\nJuno Songs\n\nNiffirg\n\nSirDusterBuster\n\nLemmySS\n\nVivaderus\n\nFruityDaLei\n\nDivergentWhiz\n\n\n\n'Paper Mario The Origami King' by Nintendo\n\n\n\n'Friday Night Funkin' by Ninjamuffin99 & crew\n\n\n\nPsych Engine by Shadow Mario\n\n\n\n\n\nThanks for playing! We really appreciate it :)\n\n\n\n'MONOTOAD' has been unlocked in Freeplay!\nShop + 'Origami Korigami' = special surprise ;)",
			64);	
	
		credtxt.setFormat(Paths.font("mario.ttf"), 50, CENTER);
		credtxt.borderColor = FlxColor.BLACK;
		credtxt.borderSize = 3;
		credtxt.borderStyle = FlxTextBorderStyle.OUTLINE;
		add(credtxt);

		var entertxt:FlxText = new FlxText(450, 650, FlxG.width,
			"Press Enter To Skip! ",
			32);
		entertxt.setFormat(Paths.font("mario.ttf"), 32, CENTER);
		entertxt.borderColor = FlxColor.BLACK;
		entertxt.borderSize = 3;
		entertxt.borderStyle = FlxTextBorderStyle.OUTLINE;
		add(entertxt);

		#if android
		addVirtualPad(NONE, A);
		#end
			
		begincredits();
	}

	var lolspin = false;

	function begincredits():Void
	{
		FlxG.sound.playMusic(Paths.music('freakyMenu'));
		FlxTween.tween(origamiLogo, {y: 0}, 1.5, {
			ease: FlxEase.quadInOut,
			onComplete: function(twn:FlxTween)
			{
				lolspin = true;
				spin();
				new FlxTimer().start(8, function(tmr:FlxTimer)
			{
				lolspin = false;
				origamiLogo.angle = 0;
				FlxTween.tween(origamiLogo, {y: -600}, 4, {
					onComplete: function(twn:FlxTween)
					{
						FlxTween.tween(credtxt, {y: -4400}, 57, {
					onComplete: function(twn:FlxTween)
					{
						FlxG.switchState(new MainMenuState());
					}
					});
					}
					});
			});
			}
			});
	}

	function spin():Void
	{

		FlxTween.tween(origamiLogo, {angle: 3}, 1.5, {
					onComplete: function(twn:FlxTween)
					{
						FlxTween.tween(origamiLogo, {angle: -3}, 1.5, {
					onComplete: function(twn:FlxTween)
					{
						if(lolspin == true)
						spin();
						else
						origamiLogo.angle = 0;
					}
					});
					}
					});
	}

	override function update(elapsed:Float)
	{
		if (controls.ACCEPT)
		{
			FlxG.switchState(new MainMenuState());
		}
		super.update(elapsed);
	}
}
