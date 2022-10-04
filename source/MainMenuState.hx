package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;

import GameJolt.GameJoltAPI;
import GameJolt.GameJoltLogin;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = 'v 0.65 - Modified Psych Engine by ant0nal0g';

	var Checkerboard:FlxSprite;
	var FadeStuff:FlxSprite;
	var Image:FlxSprite;
	var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;

	#if !switch
	var optionShit:Array<String> = ['story mode', 'freeplay', 'shop', 'settings', 'credits', 'settings'];
	#else
	var optionShit:Array<String> = ['story mode', 'freeplay', 'shop'];
	#end

	var newGaming:FlxText;
	var newGaming2:FlxText;
	public static var firstStart:Bool = true;
	var canselect:Bool;

	public static var nightly:String = "";

	public static var kadeEngineVer:String = "1.5.2" + nightly;
	public static var gameVer:String = "";

	var magenta:FlxSprite;
	var debugKeys:Array<FlxKey>;
	public static var finishedFunnyMove:Bool = false;

	override function create()
	{
		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		FlxG.mouse.visible = false;

		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		if (FlxG.save.data.coins == null)
			FlxG.save.data.coins = 0;
		
		persistentUpdate = persistentDraw = true;

		Image = new FlxSprite(-13.5, -10.8);
		Image.frames = Paths.getSparrowAtlas('fadestuff');
		//Image.setGraphicSize(Std.int(Image.width * 0.38));
		Image.animation.addByPrefix('story', 'story', 24);
		Image.animation.addByPrefix('freeplay', 'freeplay', 24);
		Image.animation.addByPrefix('credits', 'credits', 24);
		Image.animation.addByPrefix('shop', 'shop', 24);
		Image.animation.addByPrefix('settings', 'settings', 24);
		Image.animation.play('story');
		Image.updateHitbox();
		add(Image);


		FadeStuff = new FlxSprite(-13.5, -10.8);
		FadeStuff.frames = Paths.getSparrowAtlas('fadestuff');
		//FadeStuff.setGraphicSize(Std.int(Image.width));
		FadeStuff.animation.addByPrefix('story', 'story', 24);
		FadeStuff.animation.addByPrefix('freeplay', 'freeplay', 24);
		FadeStuff.animation.addByPrefix('credits', 'credits', 24);
		FadeStuff.animation.addByPrefix('shop', 'shop', 24);
		FadeStuff.animation.addByPrefix('settings', 'settings', 24);
		FadeStuff.alpha = 0;
		FadeStuff.animation.play('story');
		FadeStuff.updateHitbox();
		add(FadeStuff);

		Checkerboard = new FlxSprite(-100).loadGraphic(Paths.image('Pp'));
		//Checkerboard.setGraphicSize(Std.int(Image.width));
		Checkerboard.updateHitbox();
		Checkerboard.screenCenter();
		Checkerboard.antialiasing = true;
		add(Checkerboard);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var tex = Paths.getSparrowAtlas('FNF_main_menu_assets');

		for (i in 0...optionShit.length)
		{
			var menuItem:FlxSprite = new FlxSprite(-1000, 30 + (i * 185));
			menuItem.frames = tex;
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.setGraphicSize(Std.int(menuItem.width * 0.23));
			menuItem.ID = i;
			switch (menuItem.ID)
			{
				case 2:
				menuItem.y -= 90;
				menuItem.setGraphicSize(Std.int(menuItem.width * 0.2));

				case 3:
				menuItem.y -= 120;

				case 4:
				menuItem.y -= 190;
			}
			//menuItem.screenCenter(X);
			menuItems.add(menuItem);
			menuItem.scrollFactor.set();
			menuItem.antialiasing = true;
			if (firstStart)
			{
				canselect = false;
				FlxTween.tween(menuItem,{x: 70},1 + (i * 0.25) ,{ease: FlxEase.expoInOut, onComplete: function(flxTween:FlxTween) 
					{ 
						finishedFunnyMove = true; 
						changeItem();
					}});
				canselect = true;
			}
			else
			{
				menuItem.y = 30 + (i * 185);
				menuItem.x = 70;

				switch (menuItem.ID)
			{
				case 2:
				menuItem.y -= 90;
				menuItem.setGraphicSize(Std.int(menuItem.width * 0.2));

				case 3:
				menuItem.y -= 120;

				case 4:
				menuItem.y -= 190;
			}
				canselect = true;
			}
		}

		firstStart = false;

		var versionShit:FlxText = new FlxText(5, FlxG.height - 18, 0, gameVer +  (psychEngineVersion), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();

		changeItem();

				#if android
		addVirtualPad(UP_DOWN, A_B);
		#end	
		super.create();
	}

	var selectedSomethin:Bool = false;
	var firsttime = true;
	var canfade = true;

	override function update(elapsed:Float)
	{

		#if debug
		if (FlxG.keys.justPressed.U)
			{
				FlxG.save.data.beatchapter1 = true;
				FlxG.save.data.beatchapter2 = true;
				FlxG.save.data.beatchapter3 = true;
				FlxG.save.data.shop = true;
			}

		if (FlxG.keys.justPressed.N)
			{
				FlxG.save.data.beatchapter1 = false;
				FlxG.save.data.beatchapter2 = false;
				FlxG.save.data.beatchapter3 = false;
				FlxG.save.data.shop = false;
			}

		if (FlxG.keys.justPressed.C)
				{
					FlxG.save.data.coins += 300;
				}
		#end

		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (canfade == true)
	{
		canfade = false;

		switch (curSelected)
		{
			case 0:
			FadeStuff.animation.play('story');
			FlxTween.tween(FadeStuff, {alpha: 1}, 0.15, {
					//ease: FlxEase.expoInOut,
					onComplete: function(twn:FlxTween)
					{
						Image.animation.play('story');
						FadeStuff.alpha = 0;
					}
					});

			case 1:
			FadeStuff.animation.play('freeplay');
			FlxTween.tween(FadeStuff, {alpha: 1}, 0.15, {
					//ease: FlxEase.expoInOut,
					onComplete: function(twn:FlxTween)
					{
						Image.animation.play('freeplay');
						FadeStuff.alpha = 0;
					}
					});
			case 2:
			FadeStuff.animation.play('shop');
			FlxTween.tween(FadeStuff, {alpha: 1}, 0.15, {
					//ease: FlxEase.expoInOut,
					onComplete: function(twn:FlxTween)
					{
						Image.animation.play('shop');
						FadeStuff.alpha = 0;
					}
					});
			case 3:
			FadeStuff.animation.play('settings');
			FlxTween.tween(FadeStuff, {alpha: 1}, 0.15, {
					//ease: FlxEase.expoInOut,
					onComplete: function(twn:FlxTween)
					{
						Image.animation.play('settings');
						FadeStuff.alpha = 0;
					}
					});
			case 4:
			FadeStuff.animation.play('credits');
			FlxTween.tween(FadeStuff, {alpha: 1}, 0.15, {
					//ease: FlxEase.expoInOut,
					onComplete: function(twn:FlxTween)
					{
						Image.animation.play('credits');
						FadeStuff.alpha = 0;
					}
					});
		}
	}


		if (!selectedSomethin)
		{
			if (controls.UI_UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
				canfade = true;
			}

			if (controls.UI_DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
				canfade = true;
			}

			if (controls.BACK)
			{
				FlxG.switchState(new GameJoltLogin());
			}

			if (controls.ACCEPT && canselect == true)
			{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));

					menuItems.forEach(function(spr:FlxSprite)
					{
							FlxTween.tween(spr, {x: -1000}, 1.3, {
								ease: FlxEase.expoInOut,
								onComplete: function(twn:FlxTween)
								{
									goToState();
								}
							});
					});
			}

			#if desktop
			else if (FlxG.keys.anyJustPressed(debugKeys))
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
		});
	}
	
	function goToState()
	{
		var daChoice:String = optionShit[curSelected];

		switch (daChoice)
		{
			case 'story mode':
				MusicBeatState.switchState(new StoryMenuState());
				trace("Story Menu Selected");
			case 'freeplay':
				MusicBeatState.switchState(new FreeplayState());
				trace("Freeplay Menu Selected");
			case 'shop':
				MusicBeatState.switchState(new ShopState());
			case 'credits':
				MusicBeatState.switchState(new CreditsState());
			case 'settings':
				LoadingState.loadAndSwitchState(new options.OptionsState());
		}
	}

	function changeItem(huh:Int = 0)
	{
		if (finishedFunnyMove)
		{
			curSelected += huh;

			if (curSelected >= 5)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = 4;
		}
		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');

			if (spr.ID == curSelected && finishedFunnyMove)
			{
				spr.animation.play('selected');
			}

			spr.updateHitbox();
		});
	}
}
