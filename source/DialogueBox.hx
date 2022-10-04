package;

import flixel.system.FlxSound;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import openfl.display.BitmapData;
import openfl.media.Sound;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';
	var curAnim:String = '';
	var canpress:Bool = true;
	var jojoanimate:Bool = false;
	var gfshake:Bool = false;
	var pencilrepeat:Bool = false;

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	var skipText:FlxText;
	var tbctxt:FlxText;


	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;
	var endingText:FlxTypeText;

	var dropText:FlxText;
	var cutsceneImage:FlxSprite;
	var fadeImage:FlxSprite;
	var sound:FlxSound;

	public var finishThing:Void->Void;
	private var curSong:String = "";

	var iconangle:Int = 0;
	var holdtime:Int = 0;

	var icons:FlxSprite;

	var bf6:FlxSprite;
	var pausanpiker:FlxSprite;
	var black6:FlxSprite;
	var enemies6:FlxSprite;
	var flash6:FlxSprite;
	var gf6:FlxSprite;
	var jojo16:FlxSprite;
	var jojo26:FlxSprite;
	var ohduck6:FlxSprite;
	var surprise6:FlxSprite;
	var bg6:FlxSprite;

	var bf10:FlxSprite;
	var gf10:FlxSprite;
	var bg10:FlxSprite;
	var pencils10:FlxSprite; // make these a low opacity
	var light10:FlxSprite; // make this 30% opacity
	var lines10:FlxSprite;
	var ohduck10:FlxSprite;
	var jojo102:FlxSprite;
	var jojo10:FlxSprite;

	var boat13:FlxSprite;
	var sea13:FlxSprite;
	var sky13:FlxSprite;
	var circle_island13:FlxSprite;
	var clover_island13:FlxSprite;
	var heart_island13:FlxSprite;
	var pica_island13:FlxSprite;
	var rocks_113:FlxSprite;
	var rocks_213:FlxSprite;
	var skull_island13:FlxSprite;
	var cloudsback13:FlxSprite;

	var bf16happy:FlxSprite;
	var bf16scared:FlxSprite;
	var smoke16:FlxSprite;
	var bg16:FlxSprite;
	var holepuncher:FlxSprite;
	var people16:FlxSprite;
	var microphone16:FlxSprite;
	var shocked16:FlxSprite;

	var bg31pt1:FlxSprite;
	var fg31pt1:FlxSprite;
	var risingtape31:FlxSprite;

	var bg31pt2:FlxSprite;
	var lines31:FlxSprite;
	var risingtape31pt2:FlxSprite;
	var jojo311:FlxSprite;
	var jojo312:FlxSprite;
	var jojo313:FlxSprite;
	var jojo314:FlxSprite;


	var blackShit:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		blackShit = new FlxSprite(-FlxG.width * FlxG.camera.zoom,
			-FlxG.height * FlxG.camera.zoom).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
		blackShit.scrollFactor.set();
		add(blackShit);

		cutsceneImage = new FlxSprite(0, 0);
		cutsceneImage.visible = false;
		add(cutsceneImage);

		fadeImage = new FlxSprite(0, 0);
		fadeImage.visible = false;
		add(fadeImage);

		box = new FlxSprite(-20, 45);
		
		box.frames = Paths.getSparrowAtlas('cutscenes/dialoguebox-paper', 'shared');
		box.animation.addByPrefix('normalOpen', 'dialoguebox-paper', 24, false);
		box.animation.addByIndices('normal', 'dialoguebox-paper', [6], "", 24);
		box.setGraphicSize(Std.int(box.width * 0.67));
		box.y += 230;

		this.dialogueList = dialogueList;

		switch (Paths.formatToSongPath(PlayState.SONG.song))
		{


		case 'red-streamer-battle':
		pausanpiker = new FlxSprite(-150, 0).makeGraphic(FlxG.width * 4, FlxG.height * 4, FlxColor.BLACK);
		add(pausanpiker);
		pausanpiker.visible = false;

		bg6 = new FlxSprite(-320, -180).loadGraphic(Paths.image('cutscenes/cutscene6parts/bg'));
		bg6.setGraphicSize(Std.int(bg6.width * 0.67));
		add(bg6);	
		bg6.visible = false;

		bf6 = new FlxSprite(-770, -177).loadGraphic(Paths.image('cutscenes/cutscene6parts/bf1'));
		bf6.setGraphicSize(Std.int(bg6.width * 0.33));
		add(bf6);	
		bf6.visible = false;

		enemies6 = new FlxSprite(780, -110).loadGraphic(Paths.image('cutscenes/cutscene6parts/enemies'));
		enemies6.setGraphicSize(Std.int(enemies6.width * 0.65));
		add(enemies6);	
		enemies6.visible = false;

		ohduck6 = new FlxSprite(20, -30).loadGraphic(Paths.image('cutscenes/cutscene6parts/ohDuck'));
		ohduck6.setGraphicSize(Std.int(ohduck6.width * 0.67));
		add(ohduck6);	
		ohduck6.visible = false;

		gf6 = new FlxSprite(-450, 800).loadGraphic(Paths.image('cutscenes/cutscene6parts/gf'));
		gf6.setGraphicSize(Std.int(gf6.width * 0.67));
		add(gf6);	
		gf6.visible = false;

		black6 = new FlxSprite(-320, -180).loadGraphic(Paths.image('cutscenes/cutscene6parts/black'));
		black6.setGraphicSize(Std.int(black6.width * 0.67));
		add(black6);	
		black6.visible = false;

		flash6 = new FlxSprite(340, -179).loadGraphic(Paths.image('cutscenes/cutscene6parts/flash'));
		flash6.setGraphicSize(Std.int(flash6.width * 0.67));
		add(flash6);	
		flash6.visible = false;

		jojo16 = new FlxSprite(1150, 570).loadGraphic(Paths.image('cutscenes/cutscene6parts/jojo1'));
		jojo16.setGraphicSize(Std.int(jojo16.width * 0.67));
		add(jojo16);	
		jojo16.visible = false;

		jojo26 = new FlxSprite(-50, -50).loadGraphic(Paths.image('cutscenes/cutscene6parts/jojo2'));
		jojo26.setGraphicSize(Std.int(jojo26.width * 0.67));
		add(jojo26);	
		jojo26.visible = false;

		case 'missile-maestro':

		bg10 = new FlxSprite(-320, -180).loadGraphic(Paths.image('cutscenes/cutscene10parts/bg10'));
		bg10.setGraphicSize(Std.int(bg10.width * 0.67));
		add(bg10);	
		bg10.visible = false;

		light10 = new FlxSprite(-320, -180).loadGraphic(Paths.image('cutscenes/cutscene10parts/light'));
		light10.setGraphicSize(Std.int(light10.width * 0.67));
		add(light10);	
		light10.alpha = 0.37;
		light10.visible = false;

		pencils10 = new FlxSprite(-320, -150).loadGraphic(Paths.image('cutscenes/cutscene10parts/pencils'));
		pencils10.setGraphicSize(Std.int(pencils10.width * 0.67));
		pencils10.alpha = 0;
		add(pencils10);	
		pencils10.visible = false;

		gf10 = new FlxSprite(700, 800).loadGraphic(Paths.image('cutscenes/cutscene10parts/GF'));
		gf10.setGraphicSize(Std.int(gf10.width * 0.67));
		add(gf10);	
		gf10.visible = false;

		ohduck10 = new FlxSprite(525, 870).loadGraphic(Paths.image('cutscenes/cutscene10parts/OhDuck10'));
		ohduck10.setGraphicSize(Std.int(ohduck10.width * 0.67));
		add(ohduck10);	
		ohduck10.visible = false;

		bf10 = new FlxSprite(270, 700).loadGraphic(Paths.image('cutscenes/cutscene10parts/BF'));
		bf10.setGraphicSize(Std.int(bf10.width * 0.67));
		add(bf10);	
		bf10.visible = false;

		lines10 = new FlxSprite(-350, -210).loadGraphic(Paths.image('cutscenes/cutscene10parts/lines'));
		lines10.setGraphicSize(Std.int(lines10.width * 0.67));
		add(lines10);	
		lines10.visible = false;

		jojo102 = new FlxSprite(1020, 430).loadGraphic(Paths.image('cutscenes/cutscene10parts/jojo102'));
		jojo102.setGraphicSize(Std.int(jojo102.width * 0.67));
		add(jojo102);	
		jojo102.visible = false;

		jojo10 = new FlxSprite(-10, 0).loadGraphic(Paths.image('cutscenes/cutscene10parts/jojo10'));
		jojo10.setGraphicSize(Std.int(jojo10.width * 0.67));
		add(jojo10);	
		jojo10.visible = false;

		case 'disco-devil':

		bg16 = new FlxSprite(-320, -180).loadGraphic(Paths.image('cutscenes/cutscene16parts/16_BG'));
		bg16.setGraphicSize(Std.int(bg16.width * 0.68));
		add(bg16);	
		bg16.visible = false;

		people16 = new FlxSprite(-300, 500).loadGraphic(Paths.image('cutscenes/cutscene16parts/16_people'));
		people16.setGraphicSize(Std.int(people16.width * 0.67));
		add(people16);	
		people16.visible = false;

		holepuncher = new FlxSprite(100, -550).loadGraphic(Paths.image('cutscenes/cutscene16parts/16_holepunch'));
		holepuncher.setGraphicSize(Std.int(holepuncher.width * 0.27));
		add(holepuncher);	
		holepuncher.visible = false;

		smoke16 = new FlxSprite(-320, 200).loadGraphic(Paths.image('cutscenes/cutscene16parts/16_smoke'));
		smoke16.setGraphicSize(Std.int(smoke16.width * 0.67));
		smoke16.alpha = 0;
		add(smoke16);

		bf16happy = new FlxSprite(-70, -10).loadGraphic(Paths.image('cutscenes/cutscene16parts/16_BF_HAPPY'));
		bf16happy.setGraphicSize(Std.int(bf16happy.width * 0.67));
		add(bf16happy);	
		bf16happy.visible = false;

		bf16scared = new FlxSprite(-70, 50).loadGraphic(Paths.image('cutscenes/cutscene16parts/16_BF_SCARED'));
		bf16scared.setGraphicSize(Std.int(bf16scared.width * 0.67));
		add(bf16scared);	
		bf16scared.visible = false;

		microphone16 = new FlxSprite(300, 400).loadGraphic(Paths.image('cutscenes/cutscene16parts/16_mic'));
		microphone16.setGraphicSize(Std.int(microphone16.width * 0.67));
		add(microphone16);	
		microphone16.visible = false;

		shocked16 = new FlxSprite(150, 300).loadGraphic(Paths.image('cutscenes/cutscene16parts/16_WA'));
		shocked16.setGraphicSize(Std.int(shocked16.width * 0.67));
		add(shocked16);	
		shocked16.visible = false;

		jojo102 = new FlxSprite(1000, 390).loadGraphic(Paths.image('cutscenes/cutscene10parts/jojo102'));
		jojo102.setGraphicSize(Std.int(jojo102.width * 0.67));
		jojo102.angle = 10;
		add(jojo102);	
		jojo102.visible = false;

		jojo10 = new FlxSprite(-25, 100).loadGraphic(Paths.image('cutscenes/cutscene10parts/jojo10'));
		jojo10.setGraphicSize(Std.int(jojo10.width * 0.34));
		jojo10.angle = -10;
		add(jojo10);	
		jojo10.visible = false;

		jojo16 = new FlxSprite(1060, 210).loadGraphic(Paths.image('cutscenes/cutscene6parts/jojo1'));
		jojo16.setGraphicSize(Std.int(jojo16.width * 0.50));
		jojo16.angle = 15;
		add(jojo16);	
		jojo16.visible = false;

		case 'shifty-sticker':

		bg31pt1 = new FlxSprite(0, 0).loadGraphic(Paths.image('cutscenes/cutscene31parts/31_part1/bg_31_1'));
		add(bg31pt1);
		bg31pt1.visible = false;

		risingtape31 = new FlxSprite(230, 450).loadGraphic(Paths.image('cutscenes/cutscene31parts/31_part1/tape_31_1'));
		add(risingtape31);
		risingtape31.visible = false;

		fg31pt1 = new FlxSprite(0, 0).loadGraphic(Paths.image('cutscenes/cutscene31parts/31_part1/bg_31_1_2'));
		add(fg31pt1);
		fg31pt1.visible = false;

		bg31pt2 = new FlxSprite(0, 0).loadGraphic(Paths.image('cutscenes/cutscene31parts/31_part2/bg_31_2'));
		add(bg31pt2);
		bg31pt2.visible = false;

		risingtape31pt2 = new FlxSprite(0, -200).loadGraphic(Paths.image('cutscenes/cutscene31parts/31_part2/tape_31_2'));
		risingtape31pt2.setGraphicSize(Std.int(risingtape31pt2.width / 1.5));
		add(risingtape31pt2);
		risingtape31pt2.visible = false;

		jojo311 = new FlxSprite(-25, 370).loadGraphic(Paths.image('cutscenes/cutscene31parts/31_part2/jojo_31_1'));
		jojo311.setGraphicSize(Std.int(jojo311.width / 1.5));
		add(jojo311);
		jojo311.visible = false;

		jojo312 = new FlxSprite(100, 420).loadGraphic(Paths.image('cutscenes/cutscene31parts/31_part2/jojo_31_2'));
		jojo312.setGraphicSize(Std.int(jojo312.width / 1.5));
		add(jojo312);
		jojo312.visible = false;

		jojo313 = new FlxSprite(1000, 40).loadGraphic(Paths.image('cutscenes/cutscene31parts/31_part2/jojo_31_3'));
		jojo313.setGraphicSize(Std.int(jojo313.width / 1.5));
		add(jojo313);
		jojo313.visible = false;

		jojo314 = new FlxSprite(990, 0).loadGraphic(Paths.image('cutscenes/cutscene31parts/31_part2/jojo_31_4'));
		jojo314.setGraphicSize(Std.int(jojo314.width / 1.5));
		add(jojo314);
		jojo314.visible = false;

		lines31 = new FlxSprite(0, 0).loadGraphic(Paths.image('cutscenes/cutscene31parts/31_part2/bg_LINES_31'));
		add(lines31);
		lines31.visible = false;

		case 'vellumental-battle':
		
		sky13 = new FlxSprite(-50, 0).loadGraphic(Paths.image('cutscenes/cutscene13parts/sky_13'));
		add(sky13);
		sky13.visible = false;

		cloudsback13 = new FlxSprite(-7500, -300).loadGraphic(Paths.image('cutscenes/cutscene13parts/clouds/allclouds'));
		add(cloudsback13);
		cloudsback13.visible = false;

		circle_island13 = new FlxSprite(-800, 190).loadGraphic(Paths.image('cutscenes/cutscene13parts/islands/circle_island'));
		add(circle_island13);
		circle_island13.setGraphicSize(Std.int(circle_island13.width * 0.7));
		circle_island13.visible = false;

		clover_island13 = new FlxSprite(-800, 165).loadGraphic(Paths.image('cutscenes/cutscene13parts/islands/clover_island'));
		add(clover_island13);
		clover_island13.setGraphicSize(Std.int(clover_island13.width * 0.7));
		clover_island13.visible = false;

		heart_island13 = new FlxSprite(-800, 60).loadGraphic(Paths.image('cutscenes/cutscene13parts/islands/heart_island'));
		add(heart_island13);
		heart_island13.setGraphicSize(Std.int(heart_island13.width * 0.7));	
		heart_island13.visible = false;

		pica_island13 = new FlxSprite(-800, 190).loadGraphic(Paths.image('cutscenes/cutscene13parts/islands/pica_island'));
		add(pica_island13);
		pica_island13.setGraphicSize(Std.int(pica_island13.width * 0.7));	
		pica_island13.visible = false;

		rocks_113 = new FlxSprite(-800, 245).loadGraphic(Paths.image('cutscenes/cutscene13parts/islands/rocks_1'));
		add(rocks_113);
		rocks_113.setGraphicSize(Std.int(rocks_113.width * 0.7));	
		rocks_113.visible = false;

		rocks_213 = new FlxSprite(-800, 289).loadGraphic(Paths.image('cutscenes/cutscene13parts/islands/rocks_2'));
		rocks_213.setGraphicSize(Std.int(rocks_213.width * 0.7));	
		add(rocks_213);
		rocks_213.visible = false;

		skull_island13 = new FlxSprite(-800, 10).loadGraphic(Paths.image('cutscenes/cutscene13parts/islands/skull_island'));
		skull_island13.setGraphicSize(Std.int(skull_island13.width * 0.7));	
		add(skull_island13);
		skull_island13.visible = false;

		boat13 = new FlxSprite(-200, -190);
		boat13.frames = Paths.getSparrowAtlas('cutscenes/cutscene13parts/boat');
		boat13.animation.addByPrefix('steam', 'boat idle', 12, true);	
		boat13.setGraphicSize(Std.int(boat13.width * 0.8));
		add(boat13);
		boat13.animation.play('steam');
		boat13.visible = false;

		sea13 = new FlxSprite(-2150, -190); //-400, 
		sea13.frames = Paths.getSparrowAtlas('cutscenes/cutscene13parts/sea');
		sea13.animation.addByPrefix('waves', 'sea idle', 12, true);
		sea13.setGraphicSize(Std.int(sea13.width * 0.8));	
		add(sea13);
		sea13.animation.play('waves');
		sea13.visible = false;

		}
	


		
		box.animation.play('normalOpen');
		box.updateHitbox();
		box.screenCenter(X);
		box.alpha = 0.8;
		add(box);

		icons = new HealthIcon('bf', false);
		add(icons);
		icons.visible = false;


		if (!talkingRight)
		{
			// box.flipX = true;
		}

		skipText = new FlxText(5, 695, 640, "Press SPACE to skip.\n", 40);
		skipText.scrollFactor.set(0, 0);
		skipText.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		skipText.borderSize = 2;
		skipText.borderQuality = 1;
		add(skipText);

		dropText = new FlxText(282, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'FOT-PopJoy Std B';
		dropText.color = 0xFFFFFFFF;
		add(dropText);

		swagDialogue = new FlxTypeText(280, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'FOT-PopJoy Std B';
		swagDialogue.color = 0xFF000000;
		//swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	function resetangle()
	{
	new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			icons.angle = -5;
			new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			icons.angle = 10;
			resetangle();
		});
		});
	}

	var onetime:Bool = true;
	var shake:Bool = false;
	var okflippinstopdashake:Bool = false;
	var c13:Bool = false;

	override function update(elapsed:Float)
	{
		if (c13)
			{
				if (circle_island13.x == -800)
					{
						circle_island13.x = 1200;
						new FlxTimer().start(FlxG.random.float(1, 2), function(tmr:FlxTimer)
							{
								FlxTween.tween(circle_island13, { x: -800 }, FlxG.random.int(4, 5));
							});

					}

				if (pica_island13.x == -800)
					{
						pica_island13.x = 1200;
						new FlxTimer().start(FlxG.random.float(3, 4), function(tmr:FlxTimer)
							{
								FlxTween.tween(pica_island13, { x: -800 }, FlxG.random.int(4, 5));
							});

					}

				if (rocks_113.x == -800)
					{
						rocks_113.x = 1200;
						new FlxTimer().start(FlxG.random.float(5, 6), function(tmr:FlxTimer)
							{
								FlxTween.tween(rocks_113, { x: -800 }, FlxG.random.int(4, 5));
							});

					}

				if (skull_island13.x == -800)
					{
						skull_island13.x = 1200;
						new FlxTimer().start(FlxG.random.float(7, 8), function(tmr:FlxTimer)
							{
								FlxTween.tween(skull_island13, { x: -800 }, FlxG.random.int(4, 5));
							});

					}

				if (rocks_213.x == -800)
					{
						rocks_213.x = 1200;
						new FlxTimer().start(FlxG.random.float(9, 10), function(tmr:FlxTimer)
							{
								FlxTween.tween(rocks_213, { x: -800 }, FlxG.random.int(4, 5));
							});

					}

				if (clover_island13.x == -800)
					{
						clover_island13.x = 1200;
						new FlxTimer().start(FlxG.random.float(11, 12), function(tmr:FlxTimer)
							{
								FlxTween.tween(clover_island13, { x: -800 }, FlxG.random.int(4, 5));
							});
					}

				if (heart_island13.x == -800)
					{
						heart_island13.x = 1200;
						new FlxTimer().start(FlxG.random.float(13, 14), function(tmr:FlxTimer)
							{
								FlxTween.tween(heart_island13, { x: -800 }, FlxG.random.int(4, 5));
							});
					}

				if (cloudsback13.x == -7500)
					{
						cloudsback13.x = 500;
						FlxTween.tween(cloudsback13, { x: -7500 }, FlxG.random.int(10, 15));
					}

				if (sea13.x == -2150)
					{
						sea13.x = -400;
						FlxTween.tween(sea13, { x: -2150 }, 5);
					}
			}


		if (pencilrepeat == true)
			{
				pencilrepeat = false;
				FlxTween.tween(pencils10, {y: -180}, 1, {
					ease: FlxEase.quadInOut,
					onComplete: function(twn:FlxTween)
					{
						FlxTween.tween(pencils10, {y: -150}, 1, {
						ease: FlxEase.quadInOut,
						onComplete: function(twn:FlxTween)
						{
							pencilrepeat = true;
						}
					});
				}
			});
			}

		if (jojoanimate == true)
			{
				jojoanimate = false;
				switch (Paths.formatToSongPath(PlayState.SONG.song))
				{
		
				case 'red-streamer-battle':
				jojo16.x = FlxG.random.int(1149, 1151);
				jojo16.y = FlxG.random.int(569, 571);
				jojo26.x = FlxG.random.int(-51, -49);
				jojo26.y = FlxG.random.int(-51, -49);
				new FlxTimer().start(0.05, function(tmr:FlxTimer)
					{
						jojoanimate = true;
					});
		
				case 'missile-maestro':
				jojo102.x = FlxG.random.int(1019, 1021);
				jojo102.y = FlxG.random.int(429, 431);
				jojo10.x = FlxG.random.int(-9, -11);
				jojo10.y = FlxG.random.int(-1, 1);
				new FlxTimer().start(0.05, function(tmr:FlxTimer)
					{
						jojoanimate = true;
					});
		
				case 'disco-devil':
				jojo102.x = FlxG.random.int(1000, 1002);
				jojo102.y = FlxG.random.int(389, 391);
				jojo10.x = FlxG.random.int(-26, -24);
				jojo10.y = FlxG.random.int(99, 101);
				jojo16.x = FlxG.random.int(1059, 1061);
				jojo16.y = FlxG.random.int(209, 211);
				new FlxTimer().start(0.05, function(tmr:FlxTimer)
					{
						jojoanimate = true;
					});

				case 'shifty-sticker':
				jojo311.x = FlxG.random.int(-24, -26);
				jojo311.y = FlxG.random.int(369, 371);
				jojo312.x = FlxG.random.int(99, 101);
				jojo312.y = FlxG.random.int(419, 421);
				jojo313.x = FlxG.random.int(999, 1001);
				jojo313.y = FlxG.random.int(39, 41);
				jojo314.x = FlxG.random.int(989, 991);
				jojo314.y = FlxG.random.int(-1, 1);
				risingtape31pt2.x = FlxG.random.int(-1, 1);
				risingtape31pt2.y = FlxG.random.int(-201, -199);
				lines31.x = FlxG.random.int(-1, 1);
				lines31.y = FlxG.random.int(-1, 1);
				new FlxTimer().start(0.05, function(tmr:FlxTimer)
					{
						jojoanimate = true;
					});
		
				}
			}
		
			if (gfshake == true)
			{
				gfshake = false;
				switch (Paths.formatToSongPath(PlayState.SONG.song))
			{
				case 'red-streamer-battle':
				gf6.x = FlxG.random.int(-101, -99);
				gf6.y = FlxG.random.int(349, 351);
				new FlxTimer().start(0.05, function(tmr:FlxTimer)
					{
						gfshake = true;
					});
		
				case 'missile-maestro':
				bf10.x = FlxG.random.int(269, 271);
				bf10.y = FlxG.random.int(369, 371);
				new FlxTimer().start(0.05, function(tmr:FlxTimer)
					{
						gfshake = true;
					});
			}
			}

		if (zoosh == true)
		{
			cutsceneImage.x = FlxG.random.int(-20, 20);
			cutsceneImage.y = FlxG.random.int(-20, 20);
		}

		if (shake == true)
		{
			shake = false;

			switch (Paths.formatToSongPath(PlayState.SONG.song))
				{
					case 'disco-devil':
					bg16.x = FlxG.random.int(-326, -314);
					bg16.y = FlxG.random.int(-173, -186);
					bf16happy.x = FlxG.random.int(-76, -64);
					bf16happy.y = FlxG.random.int(-4, -16);
					bf16scared.x = FlxG.random.int(-76, -64);
					bf16scared.y = FlxG.random.int(56, 44);
					holepuncher.x = FlxG.random.int(74, 85);
					holepuncher.y = FlxG.random.int(-94, -106);
				}

		new FlxTimer().start(0.005, function(tmr:FlxTimer)
			{
				if (okflippinstopdashake == false)
				shake = true;
			});
		}

		if (onetime == true)
		{
		resetangle();
		onetime = false;	
		}
		else
		{

		}

		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')

		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		

		#if android
		var justTouched:Bool = false;

		for (touch in FlxG.touches.list)
		{
			justTouched = false;
			
			if (touch.justReleased){
				justTouched = true;
			}
		}
		#end

		if (FlxG.keys.justPressed.ANY  && dialogueStarted == true && canpress == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;
					endDialogue();
					
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;
	var animatedCutscene:Bool = false;
	var firstimage:Bool = true;

	function endDialogue()
	{
				if (this.sound != null) this.sound.stop();

				FlxG.sound.music.fadeOut(2, 0);

				canpress = false;

				if (PlayState.textcontinue == false)
				FlxTween.tween(blackShit, {alpha: 0}, 2, {ease: FlxEase.circOut});

					switch (Paths.formatToSongPath(PlayState.SONG.song))
				{
					case 'red-streamer-battle':
					FlxTween.tween(bg6, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(pausanpiker, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(flash6, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(black6, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(bf6, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(enemies6, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(ohduck6, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(gf6, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(jojo16, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(jojo26, {alpha: 0}, 2, {ease: FlxEase.circOut});

					case 'missile-maestro':
					FlxTween.tween(bg10, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(light10, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(pencils10, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(gf10, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(ohduck10, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(bf10, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(lines10, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(jojo102, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(jojo10, {alpha: 0}, 2, {ease: FlxEase.circOut});

					case 'disco-devil':
					FlxTween.tween(bg16, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(bf16scared, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(holepuncher, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(bf16happy, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(smoke16, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(people16, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(microphone16, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(shocked16, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(jojo102, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(jojo16, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(jojo10, {alpha: 0}, 2, {ease: FlxEase.circOut});

					case 'shifty-sticker':
					FlxTween.tween(bg31pt1, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(risingtape31, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(fg31pt1, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(bg31pt2, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(lines31, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(jojo311, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(jojo312, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(jojo313, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(jojo314, {alpha: 0}, 2, {ease: FlxEase.circOut});
					FlxTween.tween(risingtape31pt2, {alpha: 0}, 2, {ease: FlxEase.circOut});

				}


					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						FlxTween.tween(box, {alpha: 0}, 2, {ease: FlxEase.circOut});
						FlxTween.tween(cutsceneImage, {alpha: 0}, 2, {ease: FlxEase.circOut});
						FlxTween.tween(swagDialogue, {alpha: 0}, 2, {ease: FlxEase.circOut});
						FlxTween.tween(icons, {alpha: 0}, 2, {ease: FlxEase.circOut});
						FlxTween.tween(dropText, {alpha: 0}, 2, {ease: FlxEase.circOut});
						FlxTween.tween(skipText, {alpha: 0}, 2, {ease: FlxEase.circOut});
					}, 5);
					
					trace(PlayState.textcontinue);
					if (PlayState.textcontinue == true)
					{
						PlayState.textcontinue = false;
						
						if (Paths.formatToSongPath(PlayState.SONG.song) != 'shifty-sticker')
						FlxG.sound.play(Paths.sound('tbc'));
						else
						FlxG.sound.play(Paths.sound('4-tbc'));

						switch(Paths.formatToSongPath(PlayState.SONG.song))
						{
							case 'missile-maestro':
							FlxG.save.data.shop = true;
							tbctxt = new FlxText(0, 0, FlxG.width,
							"To be continued in chapter 2...",
							64);
							case 'elastic-entertainer':
							FlxG.save.data.beatchapter2 = true;
							tbctxt = new FlxText(0, 0, FlxG.width,
							"To be continued in chapter 3...",
							64);
							case 'disco-devil':
							FlxG.save.data.beatchapter3 = true;
							tbctxt = new FlxText(0, 0, FlxG.width,
							"To be continued in chapter 4...",
							64);
							case 'shifty-sticker':
							FlxG.save.data.beatchapter4 = true;
							tbctxt = new FlxText(0, 0, FlxG.width,
							"To be continued in the final update...",
							64);


						}

					tbctxt.setFormat(Paths.font("mario.ttf"), 64, CENTER);
					tbctxt.borderColor = FlxColor.BLACK;
					tbctxt.borderSize = 3;
					tbctxt.borderStyle = FlxTextBorderStyle.OUTLINE;
					tbctxt.screenCenter();
					tbctxt.alpha = 0;
					add(tbctxt);
					
					FlxTween.tween(tbctxt, {alpha: 1}, 10, {ease: FlxEase.circOut});

					if (Paths.formatToSongPath(PlayState.SONG.song) == 'shifty-sticker')
					{

						var sorrylol:FlxText;
						sorrylol = new FlxText(0, 0, FlxG.width,
							"We promise it won't take as long...",
							64);
						sorrylol.setFormat(Paths.font("mario.ttf"), 32, CENTER);
						sorrylol.borderColor = FlxColor.BLACK;
						sorrylol.borderSize = 3;
						sorrylol.borderStyle = FlxTextBorderStyle.OUTLINE;
						sorrylol.screenCenter();
						sorrylol.y += 200;
						sorrylol.x += 200;
						sorrylol.alpha = 0;
						add(sorrylol);

						new FlxTimer().start(4, function(tmr:FlxTimer)
						{
							FlxTween.tween(sorrylol, {alpha: 1}, 6, {ease: FlxEase.circOut});
						});

						new FlxTimer().start(9, function(tmr:FlxTimer)
						{
							FlxTween.tween(sorrylol, {alpha: 0}, 4, {ease: FlxEase.circOut});
						});
					}

					new FlxTimer().start(10, function(tmr:FlxTimer)
					{	
						FlxTween.tween(tbctxt, {alpha: 0}, 4, {
				onComplete: function(twn:FlxTween)
				{
					new FlxTimer().start(1, function(tmr:FlxTimer)
						{
							var newshit:FlxSprite = new FlxSprite().loadGraphic(Paths.image('newstuff', 'shared'));
							newshit.setGraphicSize(Std.int(newshit.width * 0.1));	
							newshit.alpha = 0;
							newshit.screenCenter();	
							add(newshit);
							FlxG.sound.play(Paths.sound('luigi'));
							FlxTween.tween(newshit, {alpha: 1}, 1, {ease: FlxEase.circOut});
							new FlxTimer().start(2, function(tmr:FlxTimer)
								{
									FlxTween.tween(newshit, {alpha: 0}, 1, {
										onComplete: function(twn:FlxTween)
										{
											new FlxTimer().start(1, function(tmr:FlxTimer)
												{
													finishThing();
													kill();
													FlxG.sound.music.stop();
													FlxG.sound.playMusic(Paths.music('freakyMenu'));
												});
										}
										});
								});
						});
				}
				});
					});
					}
					else
					{
					new FlxTimer().start(2, function(tmr:FlxTimer)
					{
					finishThing();
					kill();
					FlxG.sound.music.stop();
					});
					}
	}

	var zoosh = false;
	var whitehere = false;
	var white:FlxSprite;

	function startDialogue():Void
	{
		var setDialogue = false;
		var skipDialogue = false;
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case "bg":
				skipDialogue = true;

				if (whitehere == true)
				{
				whitehere = false;
				FlxTween.tween(white, {alpha: 0}, 1, {
				onComplete: function(twn:FlxTween)
				{
					remove(white);
				}
				});	
				}
				switch(curAnim){
					case "hide":
						cutsceneImage.visible = false;
						cutsceneImage.alpha = 0;
					case "white":
					white = new FlxSprite(0, 0).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.WHITE);
					white.scrollFactor.set();
					white.alpha = 0;
					remove(box);
				remove(swagDialogue);
				remove(dropText);
					add(white);	
					add(box);
					add(dropText);
				add(swagDialogue);
					whitehere = true;
					FlxTween.tween(white, {alpha: 1}, 1);
					case "flash":
						white = new FlxSprite(0, 0).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.WHITE);
					white.scrollFactor.set();
					add(white);	
					FlxTween.tween(white, {alpha: 0}, 0.5, {
				onComplete: function(twn:FlxTween)
				{
					remove(white);
				}
				});
					case "tear":
						cutsceneImage.width = 1.2;
						zoosh = true;
						new FlxTimer().start(0.25, function(tmr:FlxTimer)
					{
					zoosh = false;
					cutsceneImage.width = 1;
					cutsceneImage.x = 0;
					cutsceneImage.y = 0;
					}); 
					default:
					if (firstimage == true)
				{
					firstimage = false;
					cutsceneImage.visible = true;
					cutsceneImage.alpha = 0;
					cutsceneImage.loadGraphic(BitmapData.fromFile("assets/shared/images/cutscenes/dialogue/images/bg/" + curAnim + ".png"));
					FlxTween.tween(cutsceneImage, {alpha: 1}, 1, {ease: FlxEase.circOut});
				}
				else
				{
					cutsceneImage.visible = true;
					cutsceneImage.loadGraphic(BitmapData.fromFile("assets/shared/images/cutscenes/dialogue/images/bg/" + curAnim + ".png"));
					FlxTween.tween(cutsceneImage, {alpha: 1}, 1, {ease: FlxEase.circOut});
				}
				}

			case "fade":
				skipDialogue = true;
				fadeImage.visible = true;
				fadeImage.loadGraphic(BitmapData.fromFile("assets/shared/images/cutscenes/dialogue/images/bg/" + curAnim + ".png"));
				FlxTween.tween(fadeImage, {alpha: 0}, 1, {
				onComplete: function(twn:FlxTween)
				{
					fadeImage.visible = false;
					fadeImage.alpha = 1;
				}
				});

			case "music":
				skipDialogue = true;
				switch(curAnim){
					case "stop":
						FlxG.sound.music.volume = 0;
					case "fadeIn":
						FlxG.sound.music.fadeIn(1, 0, 0.8);
					case "tapefadeIn":
						new FlxTimer().start(2.5, function(tmr:FlxTimer)
							{
								FlxG.sound.music.fadeIn(1, 0, 0.8);	
							});
					default:
						FlxG.sound.playMusic(Sound.fromFile("assets/shared/images/cutscenes/dialogue/music/" + curAnim + ".ogg"), Std.parseFloat(dialogueList[0]));
						FlxG.sound.music.volume = 0;
				}

			case "sound":
				skipDialogue = true;
				if (this.sound != null) this.sound.stop();
				sound = new FlxSound().loadEmbedded(Sound.fromFile("assets/shared/images/cutscenes/dialogue/sounds/" + curAnim + ".ogg"));
				sound.play();
				
			case "cutscenesix":
				holdtime = 2;
				animatedCutscene = true;
				skipDialogue = true;
				canpress = false;
				if (!bg6.visible)
				{
					pausanpiker.visible = true;
					bg6.visible = true;
					flash6.visible = true;
					new FlxTimer().start(0.25, function(tmr:FlxTimer)
			{
					var white:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.WHITE);
					white.scrollFactor.set();
					add(white);	
					FlxTween.tween(white, {alpha: 0}, 0.5, {
				onComplete: function(twn:FlxTween)
				{
					remove(white);
				}
				});
					black6.visible = true;
					bf6.visible = true;
					enemies6.visible = true;
					ohduck6.visible = true;
					gf6.visible = true;
					jojo16.visible = true;
					jojo26.visible = true;
					jojoanimate = true;
					FlxTween.tween(bf6, { x: -40 }, 0.25); 
					FlxTween.tween(enemies6, { x: 340 }, 0.25); 
					FlxTween.tween(ohduck6, { x: 520 }, 0.2); 

					new FlxTimer().start(0.25, function(tmr:FlxTimer)
			{
					FlxTween.tween(bf6, { x: -100 }, 0.2); 
					FlxTween.tween(enemies6, { x: 410 }, 0.2);
			}); 
					new FlxTimer().start(0.2, function(tmr:FlxTimer)
			{
					FlxTween.tween(bf6, { x: -70 }, 0.2); 
					FlxTween.tween(enemies6, { x: 380 }, 0.2); 
			}); 
					new FlxTimer().start(1, function(tmr:FlxTimer)
			{
					FlxTween.tween(gf6, { x: -100, y: 350}, 0.5); 
					new FlxTimer().start(0.6, function(tmr:FlxTimer)
			{
					gfshake = true;
			}); 
			}); 
			}); 
			}

			case "cutsceneten":
				holdtime = 1;
				animatedCutscene = true;
				skipDialogue = true;
				canpress = false;
				if (!bg10.visible)
				{
					bg10.visible = true;
					light10.visible = true;
					pencils10.visible = true;
					pencilrepeat = true;
					gf10.visible = true;
					ohduck10.visible = true;
					bf10.visible = true;
					lines10.visible = true;
					jojo102.visible = true;
					jojo10.visible = true;

					FlxTween.tween(pencils10, { alpha: 0.8}, 1); 
					jojoanimate = true;
					var white:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.WHITE);
					white.scrollFactor.set();
					add(white);	
					FlxTween.tween(white, {alpha: 0}, 0.5, {
					onComplete: function(twn:FlxTween)
					{
						gfshake = true;
					}
					});
					FlxTween.tween(bf10, { y: 370}, 0.5); 
					FlxTween.tween(ohduck10, { x: 500 }, 0.5); 
					new FlxTimer().start(0.25, function(tmr:FlxTimer)
			{
					FlxTween.tween(gf10, { y: 470}, 0.5); 
			}); 
				}

			case "cutscenethirteen":
				animatedCutscene = true;
				skipDialogue = true;
				if (!sky13.visible)
					{
						boat13.visible = true;
						sea13.visible = true;
						sky13.visible = true;
						circle_island13.visible = true;
						clover_island13.visible = true;
						heart_island13.visible = true;
						pica_island13.visible = true;
						rocks_113.visible = true;
						rocks_213.visible = true;
						skull_island13.visible = true;
						cloudsback13.visible = true;
						c13 = true;
					}

			case "removecutscenethirteen":
				skipDialogue = true;
				boat13.visible = false;
				sea13.visible = false;
				sky13.visible = false;
				circle_island13.visible = false;
				clover_island13.visible = false;
				heart_island13.visible = false;
				pica_island13.visible = false;
				rocks_113.visible = false;
				rocks_213.visible = false;
				skull_island13.visible = false;
				cloudsback13.visible = false;
				c13 = false;

			case "cutscenethirtyone":
				holdtime = 3;
				animatedCutscene = true;
				skipDialogue = true;
				canpress = false;

				if (!bg31pt1.visible)
					{
						bg31pt1.visible = true;
						risingtape31.visible = true;
						fg31pt1.visible = true;

						FlxTween.tween(risingtape31, {y: 120}, 1.8, {
						onComplete: function(twn:FlxTween)
					{

						FlxTween.tween(risingtape31, {y: 130}, 0.1, {
							onComplete: function(twn:FlxTween)
						{
							FlxTween.tween(risingtape31, {y: 120}, 0.1, {
								onComplete: function(twn:FlxTween)
							{
								new FlxTimer().start(0.5, function(tmr:FlxTimer)
									{
										var white:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.WHITE);
										white.scrollFactor.set();
										add(white);	
		
										bg31pt1.visible = false;
										risingtape31.visible = false;
										fg31pt1.visible = false;
										bg31pt2.visible = true;
										lines31.visible = true;
										jojo311.visible = true;
										jojo312.visible = true;
										jojo313.visible = true;
										jojo314.visible = true;
										risingtape31pt2.visible = true;
							FlxTween.tween(white, {alpha: 0}, 0.5, {
							onComplete: function(twn:FlxTween)
							{
								jojoanimate = true;
							}
							});
									}); 
							}
								});
						}
							});
					}
						});
					}
				

			case "cutscenesixteen":
				holdtime = 2;
				animatedCutscene = true;
				skipDialogue = true;
				canpress = false;
				if (!bg16.visible)
				{
					bg16.visible = true;
					bf16happy.visible = true;
					new FlxTimer().start(1, function(tmr:FlxTimer)
			{
					holepuncher.visible = true;
					FlxTween.tween(holepuncher.scale, {x:0.67, y:0.67}, 0.5);
					//FlxTween.tween(holepuncher, {scale: x:1, y:1}, 0.5);
					FlxTween.tween(holepuncher, { y: -100}, 0.5, {ease: FlxEase.quadOut}); 
					FlxTween.tween(holepuncher, {x: 80}, 0.5, {
					onComplete: function(twn:FlxTween)
					{
						shake = true;
						jojoanimate = true;
						jojo16.visible = true;
						jojo102.visible = true;
						jojo10.visible = true;
						people16.visible = true;
						shocked16.visible = true;
						microphone16.visible = true;
						FlxTween.tween(smoke16, {alpha: 1}, 0.5);
						FlxTween.tween(smoke16, {y: 100}, 0.5);
						FlxTween.tween(people16, {y: -50}, 0.7, {ease: FlxEase.quadOut});
						FlxTween.tween(microphone16, {angle: -3}, 0.5);
						FlxTween.tween(microphone16, {x: 180}, 0.5);
						FlxTween.tween(shocked16, {x: 100}, 0.5);
						FlxTween.tween(microphone16, {y: 450}, 0.5);
						bf16happy.visible = false;
						bf16scared.visible = true;
						var white:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.WHITE);
						white.scrollFactor.set();
						add(white);	
						FlxTween.tween(white, {alpha: 0}, 0.5, {
						onComplete: function(twn:FlxTween)
					{
						okflippinstopdashake = true;
						bf16scared.x = -70;
						bf16scared.y = 50;
						bg16.x = -320;
						bg16.y = -180;
						bg16.width = 0.67;
					}
						});
					}
					});
			}); 
				}



			case "bf":
				remove(icons);
				icons = new HealthIcon('bf', false);
				changeposition();
				add(icons);
				changeSound('bftext',0.5);

			case "gf":
				remove(icons);
				icons = new HealthIcon('gf', false);
				changeposition();
				add(icons);

			case "toad":
				remove(icons);
				icons = new HealthIcon('toad', false);
				changeposition();
				add(icons);
				changeSound('toadtext',0.6);

			case "nerdtoad":
				remove(icons);
				icons = new HealthIcon('nerdemoji', false);
				changeposition();
				add(icons);
				changeSound('toadtext',0.6);

			case "tode":
				remove(icons);
				icons = new HealthIcon('tode', false);
				changeposition();
				add(icons);
				changeSound('toadtext',0.6);

			case "luigi":
				remove(icons);
				icons = new HealthIcon('luigi', false);
				changeposition();
				add(icons);
				changeSound('luigisup',0.8);

			case "captain":
				remove(icons);
				icons = new HealthIcon('Captain', false);
				changeposition();
				add(icons);
				changeSound('toadtext',0.6);

			case "picnic":
			if (animatedCutscene == true)
			{
				animatedCutscene = false;
				remove(icons);
				icons = new HealthIcon('picnic', false);
				changeposition();
				remove(box);
				remove(swagDialogue);
				remove(dropText);
				new FlxTimer().start(holdtime, function(tmr:FlxTimer)
			{
				box.animation.play('normalOpen');
				add(box);	
				add(icons);	
				add(dropText);
				add(swagDialogue);
				changeSound('FoldedText',0.6);
				canpress = true;
			}); 
			}
			else
			{
				remove(icons);
				icons = new HealthIcon('picnic', false);
				changeposition();
				add(icons);
				changeSound('FoldedText',0.6);
			}

			case "tape":
			if (animatedCutscene == true)
			{
				animatedCutscene = false;
				remove(icons);
				icons = new HealthIcon('Tape', false);
				changeposition();
				remove(box);
				remove(swagDialogue);
				remove(dropText);
				new FlxTimer().start(holdtime, function(tmr:FlxTimer)
			{
				box.animation.play('normalOpen');
				add(box);	
				add(icons);	
				add(dropText);
				add(swagDialogue);
				changeSound('FoldedText',0.6);
				canpress = true;
			}); 
			}
			else
			{
				remove(icons);
				icons = new HealthIcon('Tape', false);
				changeposition();
				add(icons);
				changeSound('FoldedText',0.6);
			}

			case "colors":
			if (animatedCutscene == true)
			{
				animatedCutscene = false;
				remove(icons);
				icons = new HealthIcon('colors', false);
				changeposition();
				remove(box);
				remove(swagDialogue);
				remove(dropText);
				new FlxTimer().start(holdtime, function(tmr:FlxTimer)
			{
				box.animation.play('normalOpen');
				add(box);	
				add(icons);	
				add(dropText);
				add(swagDialogue);
				changeSound('colorsText',0.6);
				canpress = true;
			}); 
			}
			else
			{
				remove(icons);
				icons = new HealthIcon('colors', false);
				changeposition();
				add(icons);
				changeSound('colorsText',0.6);
			}

			case "narrator":
				remove(icons);
				changeposition();
				changeSound('pixelText',0.6);

			case "yellowtoad":
				remove(icons);
				icons = new HealthIcon('yellowtoad', false);
				changeposition();
				add(icons);
				changeSound('toadtext',0.6);

			case "prof":
			remove(icons);
				icons = new HealthIcon('prof', false);
				changeposition();
				add(icons);
				changeSound('toadtext',0.6);

			case "dj":
			remove(icons);
				icons = new HealthIcon('dj', false);
				changeposition();
				add(icons);
				changeSound('toadtext',0.6);
			
			case "olivia":
				remove(icons);
				icons = new HealthIcon('olivia', false);
				changeposition();
				add(icons);
				changeSound('oliviatext',0.8);

			case "autumn":
			remove(icons);
				icons = new HealthIcon('autumn', false);
				changeposition();
				add(icons);
				changeSound('FoldedText',0.6);

			case "gondol":

			remove(icons);
				icons = new HealthIcon('gondol', false);
				changeposition();
				add(icons);
				changeSound('toadtext',0.6);

			case "rubber":
			switch (curAnim)
			{
				case "blackened":
				remove(icons);
				icons = new HealthIcon('rubber', false);
				icons.color = 0x000000;
				changeposition();
				add(icons);
				changeSound('rubberText',0.6);

				default:
				remove(icons);
				icons = new HealthIcon('rubber', false);
				changeposition();
				add(icons);
				changeSound('rubberText',0.6);
				canpress = true;
			}

			case "devil":
			switch (curAnim)
			{
				case "blackened":
				remove(icons);
				icons = new HealthIcon('holepunch', false);
				icons.color = 0x000000;
				changeposition();
				add(icons);
				changeSound('devilText',0.6);

				default:
				if (animatedCutscene == true)
			{
				animatedCutscene = false;
				remove(icons);
				icons = new HealthIcon('holepunch', false);
				changeposition();
				remove(box);
				remove(swagDialogue);
				remove(dropText);
				new FlxTimer().start(holdtime, function(tmr:FlxTimer)
			{
				box.animation.play('normalOpen');
				add(box);	
				add(icons);	
				add(dropText);
				add(swagDialogue);
				changeSound('devilText',0.6);
				canpress = true;
			}); 
			}
			else
			{
				remove(icons);
				icons = new HealthIcon('holepunch', false);
				changeposition();
				add(icons);
				changeSound('devilText',0.6);
			}
			}
		}

		if(!skipDialogue){
			if(!setDialogue){
				swagDialogue.resetText(dialogueList[0]);
			}

			swagDialogue.start(0.04, true);
		}
		else{

			dialogueList.remove(dialogueList[0]);
			startDialogue();
			
		}
	}

	function changeposition():Void
	{
		remove(swagDialogue);
		remove(dropText);
		switch (curCharacter)
	{
		case "narrator":
		
		dropText = new FlxText(202, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'FOT-PopJoy Std B';
		dropText.color = 0xFFFFFFFF;
		add(dropText);

		swagDialogue = new FlxTypeText(200, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'FOT-PopJoy Std B';
		swagDialogue.color = 0xFF000000;
		swagDialogue.finishSounds = false;
		//swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		case "olivia":

		icons.x = 130;
		icons.y = 480;

		dropText = new FlxText(282, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'FOT-PopJoy Std B';
		dropText.color = 0xFFFFFFFF;
		add(dropText);

		swagDialogue = new FlxTypeText(280, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'FOT-PopJoy Std B';
		swagDialogue.color = 0xFF000000;
		swagDialogue.finishSounds = true;
		//swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		case "luigi":

		icons.x = 130;
		icons.y = 480;

		dropText = new FlxText(282, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'FOT-PopJoy Std B';
		dropText.color = 0xFFFFFFFF;
		add(dropText);

		swagDialogue = new FlxTypeText(280, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'FOT-PopJoy Std B';
		swagDialogue.color = 0xFF000000;
		swagDialogue.finishSounds = true;
		//swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		default:

		icons.x = 130;
		icons.y = 480;

		dropText = new FlxText(282, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'FOT-PopJoy Std B';
		dropText.color = 0xFFFFFFFF;
		add(dropText);

		swagDialogue = new FlxTypeText(280, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'FOT-PopJoy Std B';
		swagDialogue.color = 0xFF000000;
		swagDialogue.finishSounds = false;
		//swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);
	}

	}

	function cleanDialog():Void
	{
		while(dialogueList[0] == ""){
			dialogueList.remove(dialogueList[0]);
		}

		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		curAnim = splitName[2];
	
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + splitName[2].length  + 3).trim();
		
		
	}

	function changeSound(sound:String, volume:Float){
	swagDialogue.sounds = [FlxG.sound.load(Paths.sound('cutscenes/dialogue/sounds/' + sound, 'shared'), volume)];
	}
}
