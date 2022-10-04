package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import flixel.input.keyboard.FlxKey;

import flixel.system.FlxSound;

import GameJolt.GameJoltAPI;

#if windows
import Discord.DiscordClient;
#end

class ShopState extends MusicBeatState
{
	public static var leftState:Bool = false;
	public static var currChanges:String = "dk";
	var yapehard:Int = 2;
	var current:Int = 0;
	var cointxt:FlxText;
	var coinsavetext:FlxText;
	var xcointext:FlxText;
	var coinicon:FlxSprite;
	var dontdoitagain:Bool = false;
	var konamicode:Array<String> = ['O', 'R', 'I', 'G', 'A', 'M', 'I', 'K', 'O', 'R', 'I', 'G', 'A', 'M', 'I'];
	var currentpress:String;
	var bg:FlxSprite;
	var purchased:FlxSprite;
	var boundarycolor:FlxColor = 0xff454545;
	var menuItems:FlxTypedGroup<FlxSprite>;
	var skinItems:FlxTypedGroup<FlxSprite>;
	var curSelected:Int = 0;
	var optionShit:Array<String>;
	var skinShit:Array<String>;

	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;

	var list:Int = 0;


	override function create()
	{
		super.create();

		if (FlxG.save.data.shop == null)
			FlxG.save.data.shop = false;

		if (FlxG.save.data.beatchapter1 == null)
			FlxG.save.data.beatchapter1 = false;

		if (FlxG.save.data.beatchapter2 == null)
			FlxG.save.data.beatchapter2 = false;

		if (FlxG.save.data.beatchapter3 == null)
			FlxG.save.data.beatchapter3 = false;

		if (FlxG.save.data.beatchapter4 == null)
			FlxG.save.data.beatchapter4 = false;

		trace(FlxG.save.data.beatchapter4);

		if (FlxG.save.data.toadbbqunlocked == null)
			FlxG.save.data.toadbbqunlocked = false;

		if (FlxG.save.data.autumnmountainunlocked == null)
			FlxG.save.data.autumnmountainunlocked = false;

		if (FlxG.save.data.bluestreamerunlocked == null)
			FlxG.save.data.bluestreamerunlocked = false;
		
		if (FlxG.save.data.shogunstudiosunlocked == null)
			FlxG.save.data.shogunstudiosunlocked = false;
		
		if (FlxG.save.data.maxpowerunlocked == null)
			FlxG.save.data.maxpowerunlocked = false;

		if (FlxG.save.data.poutfitunlocked == null)
			FlxG.save.data.poutfitunlocked = false;

		if (FlxG.save.data.soutfitunlocked == null)
			FlxG.save.data.soutfitunlocked = false;

		if (FlxG.save.data.goutfitunlocked == null)
			FlxG.save.data.goutfitunlocked = false;

		if (FlxG.save.data.poutfit2unlocked == null)
			FlxG.save.data.poutfit2unlocked = false;

		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In The Shop", null);
		#end

	/*if (FlxG.save.data.beatchapter4 == true)
		{
			optionShit = ['toadbbq', 'autumn', 'bluestreamer', 'shogun', 'max'];
			skinShit = ['poutfit', 'soutfit', 'goutfit', 'poutfit2'];	
		}*/

	if (FlxG.save.data.beatchapter4 == true)
		{
			optionShit = ['toadbbq', 'bluestreamer', 'shogun', 'max', 'autumn'];
			skinShit = ['poutfit', 'soutfit', 'goutfit', 'poutfit2'];	

			trace(optionShit);
		}
	else if (FlxG.save.data.beatchapter3 == true)
		{
			optionShit = ['toadbbq', 'bluestreamer', 'shogun', 'max'];
			skinShit = ['poutfit', 'soutfit', 'goutfit'];	
		}
	else if (FlxG.save.data.beatchapter2 == true)
		{
			optionShit = ['toadbbq', 'bluestreamer', 'shogun'];
			skinShit = ['poutfit', 'soutfit'];
		}
	else if (FlxG.save.data.beatchapter1 == true)
		{
			optionShit = ['toadbbq'];
			skinShit = ['poutfit'];
		}
	else
		{
			optionShit = ['toadbbq'];
			skinShit = ['poutfit'];
		}

		if (FlxG.save.data.shop == true || FlxG.save.data.beatchapter1 == true)
		{
		bg = new FlxSprite();
		bg.frames = Paths.getSparrowAtlas('shopbgreal');
		bg.animation.addByPrefix('bounce', 'shopbg', 24);
		//bg.setGraphicSize(Std.int(bg.width * 0.55));	
		bg.animation.play('bounce');
		//bg.updateHitbox();
		bg.screenCenter();
		add(bg);

		var shopui:FlxSprite = new FlxSprite(50, 50).loadGraphic(Paths.image('Shop_UI'));	
		//shopui.setGraphicSize(Std.int(shopui.width * 0.45));	
		shopui.updateHitbox();
		add(shopui);

		coinicon = new FlxSprite(50, 580).loadGraphic(Paths.image('cointotal'));
        coinicon.scrollFactor.set();
		coinicon.antialiasing = true;
		add(coinicon);

		coinsavetext = new FlxText(110, 560, FlxG.width, (FlxG.save.data.coins + ""), 120);
		coinsavetext.setFormat(Paths.font("mario.ttf"), 72, boundarycolor, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		coinsavetext.borderSize = 2;
		coinsavetext.borderQuality = 3;
        coinsavetext.antialiasing = true;
        coinsavetext.scrollFactor.set();
		add(coinsavetext);

		xcointext = new FlxText(85, 570, FlxG.width, "x", 120);
		xcointext.setFormat(Paths.font("mario.ttf"), 56, boundarycolor, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		xcointext.borderSize = 2;
		xcointext.borderQuality = 3;
        xcointext.antialiasing = true;
        xcointext.scrollFactor.set();
        add(xcointext);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		skinItems = new FlxTypedGroup<FlxSprite>();
		add(skinItems);

		var tex = Paths.getSparrowAtlas('shopbuttons');
		var skintex = Paths.getSparrowAtlas('shopbuttons2');
		var ui_tex = Paths.getSparrowAtlas('UI_assets');

		for (i in 0...optionShit.length)
		{
			var menuItem:FlxSprite = new FlxSprite(58, 140 + (i * 57));
			menuItem.frames = tex;
			menuItem.animation.addByPrefix('idle', optionShit[i] + " unselected", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " selected", 24);
			menuItem.animation.addByPrefix('outofstock', optionShit[i] + " outofstock", 24);
			menuItem.animation.play('idle');
			menuItem.setGraphicSize(Std.int(menuItem.width * 0.46));
			menuItem.ID = i;

			if (FlxG.save.data.toadbbqunlocked == true && menuItem.ID == 0 || FlxG.save.data.bluestreamerunlocked == true && menuItem.ID == 1 || FlxG.save.data.shogunstudiosunlocked == true && menuItem.ID == 2 || FlxG.save.data.maxpowerunlocked == true && menuItem.ID == 3 || FlxG.save.data.autumnmountainunlocked == true && menuItem.ID == 4)
			menuItem.animation.play('outofstock');

			menuItems.add(menuItem);
			menuItem.scrollFactor.set();
			menuItem.antialiasing = true;
		}

		for (i in 0...skinShit.length)
			{
				var skinItem:FlxSprite = new FlxSprite(58, 140 + (i * 57));
				skinItem.frames = skintex;
				skinItem.animation.addByPrefix('idle', skinShit[i] + " unselected", 24);
				skinItem.animation.addByPrefix('selected', skinShit[i] + " selected", 24);
				skinItem.animation.addByPrefix('outofstock', skinShit[i] + " outofstock", 24);
				skinItem.animation.play('idle');
				skinItem.setGraphicSize(Std.int(skinItem.width * 0.46));
				skinItem.ID = i;

				if (FlxG.save.data.poutfitunlocked == true && skinItem.ID == 0 || FlxG.save.data.soutfitunlocked == true && skinItem.ID == 1 || FlxG.save.data.goutfitunlocked == true && skinItem.ID == 2 || FlxG.save.data.poutfit2unlocked == true && skinItem.ID == 3)
					skinItem.animation.play('outofstock');

					skinItems.add(skinItem);
					skinItem.scrollFactor.set();
					skinItem.antialiasing = true;
			}

			leftArrow = new FlxSprite(70, 460);
			leftArrow.frames = ui_tex;
			leftArrow.setGraphicSize(Std.int(leftArrow.width * 0.5));
			leftArrow.animation.addByPrefix('idle', "leftarrowidle");
			leftArrow.animation.play('idle');
			leftArrow.updateHitbox();
			skinItems.add(leftArrow);

			rightArrow = new FlxSprite(leftArrow.x + 300, leftArrow.y);
		rightArrow.frames = ui_tex;
		rightArrow.setGraphicSize(Std.int(rightArrow.width * 0.5));
		rightArrow.animation.addByPrefix('idle', 'rightarrowidle');
		rightArrow.animation.play('idle');
		rightArrow.updateHitbox();
		menuItems.add(rightArrow);

		purchased = new FlxSprite();
		purchased.frames = Paths.getSparrowAtlas('purchased');
		purchased.animation.addByPrefix('yay', 'boom', 24, false);
		purchased.setGraphicSize(Std.int(purchased.width * 0.3));	
		purchased.updateHitbox();
		purchased.screenCenter();
		purchased.visible = false;
		add(purchased);

		leftArrow.visible = false;
		skinItems.visible = false;

		cointxt = FlxG.save.data.coins;

		cointxt = new FlxText(0, 0, FlxG.width, FlxG.save.data.coins, 64); 
		trace("coins:" + FlxG.save.data.coins);

		changeItem();

		}
		else
		{
		bg = new FlxSprite().loadGraphic(Paths.image('EmptyShop'));		
		//bg.setGraphicSize(Std.int(bg.width * 0.6));	
		//bg.updateHitbox();
		bg.screenCenter();
		add(bg);
			
		#if android
		addVirtualPad(LEFT_FULL, A_B);
		#end	
		}

		if (FlxG.sound.music != null && FlxG.save.data.shop == false)
			FlxG.sound.music.stop();
	}

	function checkpress():Void
	{
		if (currentpress == konamicode[0])
		{
			FlxG.sound.play(Paths.sound('unlock'));
		konamicode.remove(konamicode[0]);
		if (konamicode.length == 0)
		{
		FlxG.save.data.yape = true;
			persistentUpdate = false;
			//var poop:String = Highscore.formatSong('the-almighty-yape-hard', 2);
			//trace(poop);

			PlayState.SONG = Song.loadFromJson('the-almighty-yape-hard', 'the-almighty-yape');
			PlayState.isStoryMode = false;
			PlayState.storyDifficulty = 2;

			#if windows 
			GameJoltAPI.getTrophy(150047);
                        #end
				
			LoadingState.loadAndSwitchState(new PlayState());

			FlxG.sound.music.volume = 0;
		}
		}
		else
		{
		konamicode = ['O', 'R', 'I', 'G', 'A', 'M', 'I', 'K', 'O', 'R', 'I', 'G', 'A', 'M', 'I'];	
		FlxG.sound.play(Paths.sound('locked'));
		}
	}

	function changeItem(huh:Int = 0)
	{
			curSelected += huh;
			
			if (list == 0)
				{
					if (curSelected >= optionShit.length)
						curSelected = 0;
					if (curSelected < 0)
						curSelected = optionShit.length - 1;	
				}
			else
				{
					if (curSelected >= skinShit.length)
						curSelected = 0;
					if (curSelected < 0)
						curSelected = skinShit.length - 1;
				}

		menuItems.forEach(function(spr:FlxSprite)
		{
			
			if (spr.ID == curSelected)
				{
				spr.animation.play('idle');
				if (FlxG.save.data.toadbbqunlocked == true && curSelected == 0 || FlxG.save.data.bluestreamerunlocked == true && curSelected == 1 || FlxG.save.data.shogunstudiosunlocked == true && curSelected == 2 || FlxG.save.data.maxpowerunlocked == true && curSelected == 3 || FlxG.save.data.autumnmountainunlocked == true && curSelected == 4)
				{
				spr.animation.play('outofstock');
				spr.alpha = 1;
				}
				else
				spr.animation.play('selected');
				}

			if (spr.ID != curSelected)
				if (spr.animation.curAnim.name != 'outofstock')
				spr.animation.play('idle');
				else
				spr.alpha = 0.75;

			spr.updateHitbox();
		});

		skinItems.forEach(function(spr:FlxSprite)
			{
				if (spr.ID == curSelected)
					{
					spr.animation.play('idle');
					if (FlxG.save.data.poutfitunlocked == true && curSelected == 0 || FlxG.save.data.soutfitunlocked == true && curSelected == 1 || FlxG.save.data.goutfitunlocked == true && curSelected == 2 || FlxG.save.data.poutfit2unlocked == true && curSelected == 3)
					{
					spr.animation.play('outofstock');
					spr.alpha = 1;
					}
					else
					spr.animation.play('selected');
					}
	
				if (spr.ID != curSelected)
					if (spr.animation.curAnim.name != 'outofstock')
					spr.animation.play('idle');
					else
					spr.alpha = 0.75;
	
				spr.updateHitbox();
			});
	}

	function locked():Void
		{
			FlxG.sound.play(Paths.sound('locked'));
					coinsavetext.x += 5;
					xcointext.x += 5;
					coinicon.x += 5;
					new FlxTimer().start(0.1, function(tmr:FlxTimer)
				{
					coinsavetext.x -= 10;
					xcointext.x -= 10;
					coinicon.x -= 10;
				});
					new FlxTimer().start(0.1, function(tmr:FlxTimer)
				{
					coinsavetext.x += 5;
					xcointext.x += 5;
					coinicon.x += 5;
				});
		}

		function bought():Void
			{
				if (FlxG.save.data.poutfitunlocked == true && FlxG.save.data.poutfit2unlocked == true && FlxG.save.data.soutfitunlocked == true && FlxG.save.data.goutfitunlocked == true)
					GameJoltAPI.getTrophy(173486);

				if (FlxG.save.data.toadbbqunlocked == true && FlxG.save.data.autumnmountainunlocked == true && FlxG.save.data.shogunstudiosunlocked == true && FlxG.save.data.maxpowerunlocked == true && FlxG.save.data.bluestreamerunlocked == true)
					GameJoltAPI.getTrophy(173487);

				purchased.visible = true;
				purchased.animation.play('yay');
				FlxG.sound.play(Paths.sound('purchased'));
				FlxG.sound.play(Paths.sound('stamp'));
				coinsavetext.text = FlxG.save.data.coins;
				new FlxTimer().start(0.83, function(tmr:FlxTimer){purchased.visible = false;});
			}

	function goToState()
	{
		var daChoice:String = optionShit[curSelected];

		switch (daChoice)
		{
			case 'toadbbq':
			if (FlxG.save.data.toadbbqunlocked == false)
			{
				if (FlxG.save.data.coins >= 300)
				{
					FlxG.save.data.toadbbqunlocked = true;
					FlxG.save.data.coins -= 300;
					bought();
				}
				else
					locked();
			}
			case 'autumn':
				if (FlxG.save.data.autumnmountainunlocked == false)
			{
				if (FlxG.save.data.coins >= 300)
				{
					FlxG.save.data.autumnmountainunlocked = true;
					FlxG.save.data.coins -= 300;
					bought();
				}
				else
					locked();
			}
			case 'shogun':
				if (FlxG.save.data.shogunstudiosunlocked == false)
			{
				if (FlxG.save.data.coins >= 200)
				{
					FlxG.save.data.shogunstudiosunlocked = true;
					FlxG.save.data.coins -= 200;
					bought();
				}
				else
					locked();
			}
			case 'max':
				if (FlxG.save.data.maxpowerunlocked == false)
			{
				if (FlxG.save.data.coins >= 500)
				{
					FlxG.save.data.maxpowerunlocked = true;
					FlxG.save.data.coins -= 500;
					bought();
				}
				else
					locked();
			}

			case 'bluestreamer':
				if (FlxG.save.data.bluestreamerunlocked == false)
					{
						if (FlxG.save.data.coins >= 300)
						{
							FlxG.save.data.bluestreamerunlocked = true;
							FlxG.save.data.coins -= 300;
							bought();
						}
						else
							locked();
					}
		}

		changeItem();
	}

	function goToState2()
		{
			var daChoice2:String = skinShit[curSelected];

			switch (daChoice2)
			{
				case 'poutfit':
					if (FlxG.save.data.poutfitunlocked == false)
				{
					if (FlxG.save.data.coins >= 50)
					{
						FlxG.save.data.poutfitunlocked = true;
						FlxG.save.data.coins -= 50;
						bought();
					}
					else
						locked();
				}
				case 'soutfit':
					if (FlxG.save.data.soutfitunlocked == false)
				{
					if (FlxG.save.data.coins >= 50)
					{
						FlxG.save.data.soutfitunlocked = true;
						FlxG.save.data.coins -= 50;
						bought();
					}
					else
						locked();
				}
				case 'goutfit':
					if (FlxG.save.data.goutfitunlocked == false)
				{
					if (FlxG.save.data.coins >= 75)
					{
						FlxG.save.data.goutfitunlocked = true;
						FlxG.save.data.coins -= 75;
						bought();
					}
					else
						locked();
				}
				case 'poutfit2':
					if (FlxG.save.data.poutfit2unlocked == false)
				{
					if (FlxG.save.data.coins >= 75)
					{
						FlxG.save.data.poutfit2unlocked = true;
						FlxG.save.data.coins -= 75;
						bought();
					}
					else
						locked();
				}
			}	
			changeItem();
		}

	override function update(elapsed:Float)
	{
		if (FlxG.save.data.shop == true)
			{
				if (FlxG.keys.justPressed.O)
					{
						currentpress = O;
						checkpress();
					}
			
					if (FlxG.keys.justPressed.R)
					{
						currentpress = R;
						checkpress();
					}
			
					if (FlxG.keys.justPressed.I)
					{
						currentpress = I;
						checkpress();
					}
			
					if (FlxG.keys.justPressed.G)
					{
						currentpress = G;
						checkpress();
					}
			
					if (FlxG.keys.justPressed.A)
					{
						currentpress = A;
						checkpress();
					}
			
					if (FlxG.keys.justPressed.M)
					{
						currentpress = M;
						checkpress();
					}
			
					if (FlxG.keys.justPressed.K)
					{
						currentpress = K;
						checkpress();
					}
			
					if (controls.UI_RIGHT_P)
						{
							menuItems.visible = false;
							skinItems.visible = true;
							leftArrow.visible = true;
							rightArrow.visible = false;
							list = 1;
							changeItem();
							FlxG.sound.play(Paths.sound('scrollMenu'));
						}
			
						if (controls.UI_LEFT_P)
							{
								menuItems.visible = true;
								skinItems.visible = false;
								rightArrow.visible = true;
								leftArrow.visible = false;
								list = 0;
								changeItem();
								FlxG.sound.play(Paths.sound('scrollMenu'));
							}
			
					if (FlxG.save.data.shop == true)
					{
						if (controls.UI_UP_P)
						{
							FlxG.sound.play(Paths.sound('scrollMenu'));
							changeItem(-1);
						}
			
						if (controls.UI_DOWN_P)
						{
							FlxG.sound.play(Paths.sound('scrollMenu'));
							changeItem(1);
						}
			
					if (controls.ACCEPT)
						{
							switch (list)
							{
								case 0:
									menuItems.forEach(function(spr:FlxSprite)
										{
											goToState();
										});	
			
								case 1:
									skinItems.forEach(function(spr:FlxSprite)
										{
											goToState2();
										});	
							}
						}
			}

		}

		if (controls.BACK)
			{
				leftState = true;

				FlxG.sound.playMusic(Paths.music('freakyMenu'));
	
				FlxG.switchState(new MainMenuState());
			}

		super.update(elapsed);
	}
}
