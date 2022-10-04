package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.net.curl.CURLCode;
import flixel.graphics.FlxGraphic;
import WeekData;

using StringTools;

class StoryMenuState extends MusicBeatState
{
	public static var weekCompleted:Map<String, Bool> = new Map<String, Bool>();

	private static var lastDifficultyName:String = '';
	var curDifficulty:Int = 1;

	var txtWeekTitle:FlxText;
	var bgSprite:FlxSprite;

	private static var curWeek:Int = 0;

	var txtTracklist:FlxText;

	var grpWeekText:FlxTypedGroup<MenuItem>;
	var grpWeekCharacters:FlxTypedGroup<MenuCharacter>;

	var grpLocks:FlxTypedGroup<FlxSprite>;

	var difficultySelectors:FlxGroup;
	var sprDifficulty:FlxSprite;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;
	var upArrow:FlxSprite;
	var downArrow:FlxSprite;
	var layeringbox:FlxSprite;

	var props:FlxSprite;
	var toads:FlxSprite;
	var lock:FlxSprite;
	var streamers:FlxSprite;
	var chaptertext:FlxSprite;
	var scoreText:FlxText;
	var chapterload:FlxSprite;
	var characterbox:FlxSprite;
	var characterarrows:FlxSprite;
	var charactertext:FlxText;
	var intro:Bool = true;
	public static var notransition:Bool = false;

	var loadedWeeks:Array<WeekData> = [];

	override function create()
	{
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		PlayState.isStoryMode = true;
		WeekData.reloadWeekFiles(true);
		if(curWeek >= WeekData.weeksList.length) curWeek = 0;
		persistentUpdate = persistentDraw = true;

		scoreText = new FlxText(610, 195, 0, "SCORE: 49324858", 30);
		scoreText.setFormat("New Super Mario Font U", 30, FlxTextAlign.CENTER);
		scoreText.screenCenter(X);

		txtWeekTitle = new FlxText(FlxG.width * 0.7, 10, 0, "", 32);
		txtWeekTitle.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, RIGHT);
		txtWeekTitle.alpha = 0.7;

		var rankText:FlxText = new FlxText(0, 10);
		rankText.text = 'RANK: GREAT';
		rankText.setFormat(Paths.font("vcr.ttf"), 32);
		rankText.size = scoreText.size;
		rankText.screenCenter(X);

		var ui_tex = Paths.getSparrowAtlas('UI_assets');

		var stagebg:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('stagebackground'));
			stagebg.updateHitbox();
			stagebg.antialiasing = true;
			stagebg.active = false;
			add(stagebg);

		props = new FlxSprite(-60, -20);
					props.frames = Paths.getSparrowAtlas('stageprops');
					props.animation.addByPrefix('propboplol', "propboplol", 24);
					props.antialiasing = true;
					props.updateHitbox();
					add(props);
					props.animation.play('propboplol');
		
		var campaignstage:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('stagefloor'));
			campaignstage.updateHitbox();
			campaignstage.antialiasing = true;
			add(campaignstage);

		streamers = new FlxSprite(0, 0);
			streamers.frames = Paths.getSparrowAtlas('streamer');
			streamers.animation.addByPrefix('red', "redstreamer", 24);
			streamers.animation.addByPrefix('blue', "bluestreamer", 24);
			streamers.animation.addByPrefix('yellow', "yellowstreamer", 24);
			streamers.animation.addByPrefix('purple', "purplestreamer", 24);
			streamers.animation.addByPrefix('green', "greenstreamer", 24);
			streamers.animation.addByPrefix('locked', "lockedstreamer", 24);
			streamers.antialiasing = true;
			streamers.setGraphicSize(Std.int(props.width * 0.9));
			streamers.updateHitbox();
			add(streamers);
			streamers.animation.play('red');

		var stagecurtains:FlxSprite = new FlxSprite(0, -300).loadGraphic(Paths.image('stagecurtains', 'preload'));
			stagecurtains.updateHitbox();
			stagecurtains.antialiasing = true;
			stagecurtains.active = false;

		var curtainabove:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('curtainabove'));
			curtainabove.updateHitbox();
			curtainabove.antialiasing = true;
			curtainabove.active = false;

		toads = new FlxSprite(0, 15);
					toads.frames = Paths.getSparrowAtlas('tods');
					toads.animation.addByPrefix('todbop', "todbop", 24);
					toads.antialiasing = true;
					//toads.setGraphicSize(Std.int(toads.width * 0.505));
					toads.updateHitbox();
					toads.animation.play('todbop');

		layeringbox = new FlxSprite(425, -300).loadGraphic(Paths.image('chapterselect'));
			layeringbox.updateHitbox();
			layeringbox.antialiasing = true;
			layeringbox.active = true;

		var scorebox:FlxSprite = new FlxSprite(540, 190).loadGraphic(Paths.image('score'));
			scorebox.updateHitbox();
			scorebox.antialiasing = true;
			add(scorebox);

		characterbox= new FlxSprite(615, 345).loadGraphic(Paths.image('score'));
			characterbox.setGraphicSize(Std.int(characterbox.width * 0.9));
			characterbox.updateHitbox();
			characterbox.antialiasing = true;
			characterbox.active = false;
			characterbox.visible = false;
			add(characterbox);

		characterarrows= new FlxSprite(588, 348).loadGraphic(Paths.image('characterselectarrows'));
		characterarrows.updateHitbox();
		characterarrows.antialiasing = true;
		characterarrows.active = false;
		characterarrows.visible = false;
		add(characterarrows);

		charactertext = new FlxText(645, 350, 0, "Standard", 25);
		charactertext.setFormat("New Super Mario Font U", 25, FlxTextAlign.CENTER);
		charactertext.visible = false;
		add(charactertext);


		var bgYellow:FlxSprite = new FlxSprite(0, 56).makeGraphic(FlxG.width, 386, 0xFFF9CF51);
		bgSprite = new FlxSprite(0, 56);
		bgSprite.antialiasing = ClientPrefs.globalAntialiasing;

		grpWeekText = new FlxTypedGroup<MenuItem>();
		//add(grpWeekText);

		var blackBarThingie:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, 56, FlxColor.BLACK);
		//add(blackBarThingie);

		grpWeekCharacters = new FlxTypedGroup<MenuCharacter>();

		grpLocks = new FlxTypedGroup<FlxSprite>();
		//add(grpLocks);

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		var num:Int = 0;
		for (i in 0...WeekData.weeksList.length)
		{
			var weekFile:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[i]);
			var isLocked:Bool = weekIsLocked(WeekData.weeksList[i]);
			if(!isLocked || !weekFile.hiddenUntilUnlocked)
			{
				loadedWeeks.push(weekFile);
				WeekData.setDirectoryFromWeek(weekFile);
				var weekThing:MenuItem = new MenuItem(0, bgSprite.y + 396, WeekData.weeksList[i]);
				weekThing.y += ((weekThing.height + 20) * num);
				weekThing.targetY = num;
				grpWeekText.add(weekThing);

				weekThing.screenCenter(X);
				weekThing.antialiasing = ClientPrefs.globalAntialiasing;
				// weekThing.updateHitbox();

				// Needs an offset thingie
				num++;
			}
		}

		WeekData.setDirectoryFromWeek(loadedWeeks[0]);
		var charArray:Array<String> = loadedWeeks[0].weekCharacters;
		for (char in 0...3)
		{
			var weekCharacterThing:MenuCharacter = new MenuCharacter((FlxG.width * 0.25) * (1 + char) - 150, charArray[char]);
			weekCharacterThing.y += 70;
			grpWeekCharacters.add(weekCharacterThing);
		}

		difficultySelectors = new FlxGroup();

		leftArrow = new FlxSprite(layeringbox.x - 105, 18);
		leftArrow.frames = ui_tex;
		leftArrow.animation.addByPrefix('idle', "leftarrowidle");
		leftArrow.animation.addByPrefix('press', "leftarrowpress");
		leftArrow.setGraphicSize(Std.int(leftArrow.width * 0.65));
		leftArrow.animation.play('idle');
		leftArrow.antialiasing = ClientPrefs.globalAntialiasing;

		CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();
		if(lastDifficultyName == '')
		{
			lastDifficultyName = CoolUtil.defaultDifficulty;
		}
		curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(lastDifficultyName)));
		
		sprDifficulty = new FlxSprite(1050, 1025);
		sprDifficulty.frames = ui_tex;
		sprDifficulty.setGraphicSize(Std.int(layeringbox.width * 0.35));
		sprDifficulty.updateHitbox();
		sprDifficulty.animation.addByPrefix('easy', 'Easy');
		sprDifficulty.animation.addByPrefix('normal', 'Normal');
		sprDifficulty.animation.addByPrefix('hard', 'Hard');
		sprDifficulty.animation.play('easy');
		sprDifficulty.antialiasing = ClientPrefs.globalAntialiasing;

		rightArrow = new FlxSprite(layeringbox.x + 485, leftArrow.y + 42);
		rightArrow.frames = ui_tex;
		rightArrow.setGraphicSize(Std.int(rightArrow.width * 0.65));
		rightArrow.updateHitbox();
		rightArrow.animation.addByPrefix('idle', 'leftarrowidle');
		rightArrow.animation.addByPrefix('press', 'leftarrowpress', 24, false);
		rightArrow.flipX = true;
		rightArrow.animation.play('idle');
		rightArrow.antialiasing = ClientPrefs.globalAntialiasing;

		upArrow = new FlxSprite(1137, 420);
		upArrow.frames = ui_tex;
		upArrow.setGraphicSize(Std.int(leftArrow.width * 0.65));
		upArrow.updateHitbox();
		upArrow.animation.addByPrefix('idle', 'uparrowidle');
		upArrow.animation.addByPrefix('press', "uparrowpress", 24, false);
		upArrow.animation.play('idle');

		downArrow = new FlxSprite(upArrow.x, upArrow.y + 225);
		downArrow.frames = ui_tex;
		downArrow.setGraphicSize(Std.int(leftArrow.width * 0.65));
		downArrow.updateHitbox();
		downArrow.animation.addByPrefix('idle', 'downarrowidle');
		downArrow.animation.addByPrefix('press', "downarrowpress", 24, false);
		downArrow.animation.play('idle');

		chapterload = new FlxSprite(0, 0);
		chapterload.frames = Paths.getSparrowAtlas('chapterload');
		chapterload.animation.addByPrefix('loadin', "loadin", 13);
		chapterload.antialiasing = true;
		//chapterload.setGraphicSize(Std.int(chapterload.width * 0.65));
		chapterload.updateHitbox();

		//add(bgYellow);
		//add(bgSprite);
		add(grpWeekCharacters);
		add(stagecurtains);
		add(curtainabove);
		add(toads);
		add(layeringbox);
		add(leftArrow);
		add(rightArrow);
		add(difficultySelectors);
		difficultySelectors.add(sprDifficulty);
		difficultySelectors.add(upArrow);
		difficultySelectors.add(downArrow);

		var tracksSprite:FlxSprite = new FlxSprite(FlxG.width * 0.07, bgSprite.y + 425).loadGraphic(Paths.image('Menu_Tracks'));
		tracksSprite.antialiasing = ClientPrefs.globalAntialiasing;
		//add(tracksSprite);

		var trackbox:FlxSprite = new FlxSprite(43, 535).loadGraphic(Paths.image('track'));
			trackbox.updateHitbox();
			trackbox.antialiasing = true;
			trackbox.active = true;
			add(trackbox);

		var tracktext:FlxSprite = new FlxSprite(5, 535).loadGraphic(Paths.image('tracktext'));
			tracktext.setGraphicSize(Std.int(trackbox.width * 0.25));
			//tracktext.updateHitbox();
			tracktext.antialiasing = false;
			add(tracktext);

		txtTracklist = new FlxText(50, tracksSprite.y + 95, 0, "", 32);
		txtTracklist.font = scoreText.font;
		txtTracklist.color = 0xFFFFFFFF;
		txtTracklist.antialiasing = false;
		add(txtTracklist);
		trace(txtTracklist.x);

		// add(rankText);
		add(scoreText);
		//add(txtWeekTitle);

		changeWeek();
		changeDifficulty();

		chaptertext.x = leftArrow.x + 125;
		chaptertext.y = leftArrow.y - 225;

		FlxTween.tween(layeringbox, { y: 0 }, 0.7);
		//FlxTween.tween(lock, { y: 0 }, 1);
		FlxTween.tween(chaptertext, { y: leftArrow.y + 25 }, 0.7, {
			onComplete: function(twn:FlxTween)
			{
				intro = false;
			}
		});
		//FlxTween.tween(greychaptertext, { y: 35 }, 1); 
		FlxTween.tween(stagecurtains, { y: -17 }, 1); 

		#if android
		addVirtualPad(LEFT_FULL, A_B);
		#end
			
		super.create();
	}

	override function closeSubState() {
		persistentUpdate = true;
		changeWeek();
		super.closeSubState();
	}

	override function update(elapsed:Float)
	{
		// scoreText.setFormat('VCR OSD Mono', 32);
		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, CoolUtil.boundTo(elapsed * 30, 0, 1)));
		if(Math.abs(intendedScore - lerpScore) < 10) lerpScore = intendedScore;

		scoreText.text = "" + lerpScore;
		scoreText.screenCenter(X);

		// FlxG.watch.addQuick('font', scoreText.font);

		if (!movedBack && !selectedWeek && !intro)
		{
			var upP = controls.UI_LEFT_P;
			var downP = controls.UI_RIGHT_P;
			if (upP)
			{
				if (bfselectmode)
						changeBF(-1);	
				else
					{
						changeWeek(-1);
						leftArrow.animation.play('press');
					}

				FlxG.sound.play(Paths.sound('scrollMenu'));
			}
			else
				leftArrow.animation.play('idle');

			if (downP)
			{
				if (bfselectmode)
					changeBF(1);	
			else
				{
					changeWeek(1);
					rightArrow.animation.play('press');
				}

			FlxG.sound.play(Paths.sound('scrollMenu'));
			}
			else
				rightArrow.animation.play('idle');

			if (controls.UI_UP)
				upArrow.animation.play('press')
			else
				upArrow.animation.play('idle');

			if (controls.UI_DOWN)
				downArrow.animation.play('press');
			else
				downArrow.animation.play('idle');

			if (controls.UI_UP_P)
				changeDifficulty(1);
			else if (controls.UI_DOWN_P)
				changeDifficulty(-1);

			if(FlxG.keys.justPressed.CONTROL)
			{
				persistentUpdate = false;
				openSubState(new GameplayChangersSubstate());
			}
			else if(controls.RESET)
			{
				persistentUpdate = false;
				openSubState(new ResetScoreSubState('', curDifficulty, '', curWeek));
				//FlxG.sound.play(Paths.sound('scrollMenu'));
			}
			else if (controls.ACCEPT)
			{
				selectWeek();
			}
		}

		if (controls.BACK && !movedBack && !selectedWeek)
		{
			if (bfselectmode)
				{
					FlxG.sound.play(Paths.sound('cancelMenu'));
					bfselectmode = false;
					characterbox.visible = false;
					characterarrows.visible = false;
					charactertext.visible = false;
				}
			else
				{
					bfselectmode = false;
					FlxG.sound.play(Paths.sound('cancelMenu'));
					movedBack = true;
					MusicBeatState.switchState(new MainMenuState());
				}
		}

		super.update(elapsed);
	}

	var movedBack:Bool = false;
	var selectedWeek:Bool = false;
	var stopspamming:Bool = false;
	var bfselectmode:Bool = false;

	function selectWeek()
	{
		if (!weekIsLocked(loadedWeeks[curWeek].fileName))
		{
			if (bfselectmode && FreeplayState.canskincontinue)
				{
					bfselectmode = false;
					if (stopspamming == false)
						{
							FlxG.sound.play(Paths.sound('confirmMenu'));
			
							var bf:MenuCharacter = grpWeekCharacters.members[1];
							if(bf.character != '' && bf.hasConfirmAnimation) grpWeekCharacters.members[1].animation.play('confirm');
							stopspamming = true;
						}
			
						// We can't use Dynamic Array .copy() because that crashes HTML5, here's a workaround.
						var songArray:Array<String> = [];
						var leWeek:Array<Dynamic> = loadedWeeks[curWeek].songs;
						for (i in 0...leWeek.length) {
							songArray.push(leWeek[i][0]);
						}
			
						// Nevermind that's stupid lmao
						PlayState.storyPlaylist = songArray;
						PlayState.isStoryMode = true;
						selectedWeek = true;
			
						var diffic = CoolUtil.getDifficultyFilePath(curDifficulty);
						if(diffic == null) diffic = '';
			
						PlayState.storyDifficulty = curDifficulty;
			
						PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
						PlayState.campaignScore = 0;
						PlayState.campaignMisses = 0;

						notransition = true;

						add(chapterload);
						chapterload.animation.play('loadin');

						new FlxTimer().start(0.95, function(tmr:FlxTimer)
							{
								chapterload.animation.pause();
								LoadingState.loadAndSwitchState(new PlayState(), true);
								FreeplayState.destroyFreeplayVocals();
							});
				}

			if (!bfselectmode)
				{
					bfselectmode = true;
					characterbox.visible = true;
					characterarrows.visible = true;
					charactertext.visible = true;
				}
		} else {
			FlxG.sound.play(Paths.sound('cancelMenu'));
		}
	}

	var tweenDifficulty:FlxTween;
	function changeDifficulty(change:Int = 0):Void
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = CoolUtil.difficulties.length-1;
		if (curDifficulty >= CoolUtil.difficulties.length)
			curDifficulty = 0;

		WeekData.setDirectoryFromWeek(loadedWeeks[curWeek]);

		var diff:String = CoolUtil.difficulties[curDifficulty];
		var newImage:FlxGraphic = Paths.image('menudifficulties/' + Paths.formatToSongPath(diff));
		//trace(Paths.currentModDirectory + ', menudifficulties/' + Paths.formatToSongPath(diff));

		sprDifficulty.offset.x = 70;
		
		switch (curDifficulty)
		{
			case 0:
				sprDifficulty.animation.play('easy');
				sprDifficulty.offset.x = -20;
			case 1:
				sprDifficulty.animation.play('normal');
				sprDifficulty.offset.x = -17;
			case 2:
				sprDifficulty.animation.play('hard');
				sprDifficulty.offset.x = -20;
			default:
				curDifficulty = 0;
				sprDifficulty.animation.play('easy');
				sprDifficulty.offset.x = -20;
		}

		sprDifficulty.alpha = 0;

		// USING THESE WEIRD VALUES SO THAT IT DOESNT FLOAT UP
		sprDifficulty.y = 455;

		   FlxTween.tween(sprDifficulty, {y: 475, alpha: 1}, 0.07);


		/*if(sprDifficulty.graphic != newImage)
		{
			sprDifficulty.loadGraphic(newImage);
			sprDifficulty.x = leftArrow.x + 60;
			sprDifficulty.x += (308 - sprDifficulty.width) / 3;
			sprDifficulty.alpha = 0;
			sprDifficulty.y = leftArrow.y - 15;

			if(tweenDifficulty != null) tweenDifficulty.cancel();
			tweenDifficulty = FlxTween.tween(sprDifficulty, {y: leftArrow.y + 15, alpha: 1}, 0.07, {onComplete: function(twn:FlxTween)
			{
				tweenDifficulty = null;
			}});
		}*/
		lastDifficultyName = diff;

		#if !switch
		intendedScore = Highscore.getWeekScore(loadedWeeks[curWeek].fileName, curDifficulty);
		#end
	}

	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	function changeWeek(change:Int = 0):Void
	{
		remove(chaptertext);
		remove(lock);

		curWeek += change;

		if (curWeek >= loadedWeeks.length)
			curWeek = 0;
		if (curWeek < 0)
			curWeek = loadedWeeks.length - 1;

		var isLocked:Bool = weekIsLocked(WeekData.weeksList[curWeek]);

		if (!isLocked)
				grpWeekCharacters.members[0].color = 0xFFFFFF;

		chaptertext = new FlxSprite(leftArrow.x + 125, leftArrow.y + 25);
		chaptertext.frames = Paths.getSparrowAtlas('chapters' + isLocked);
		//chaptertext.setGraphicSize(Std.int(chaptertext.width * 0.55));

		switch (curWeek)
		{
			case 0:
				if (!isLocked)
				streamers.animation.play('red');

				chaptertext.animation.addByPrefix('chapter1', 'chapter0000');
				chaptertext.animation.play('chapter1');
			case 1:
				if (!isLocked)
				streamers.animation.play('blue');

				chaptertext.animation.addByPrefix('chapter2', 'chapter0001');
				chaptertext.offset.x = 10;
				chaptertext.animation.play('chapter2');
			case 2:
				if (!isLocked)
				streamers.animation.play('yellow');

				chaptertext.animation.addByPrefix('chapter3', 'chapter0002');
				chaptertext.offset.x = 9;
				chaptertext.animation.play('chapter3');
			case 3:
				if (!isLocked)
				streamers.animation.play('purple');

				chaptertext.animation.addByPrefix('chapter4', 'chapter0003');
				chaptertext.offset.x = 13;
				chaptertext.animation.play('chapter4');
			case 4:
				streamers.animation.play('green');
				chaptertext.animation.addByPrefix('chapter5', 'chapter0004');
				chaptertext.animation.play('chapter5');

			case 5:
				streamers.animation.play('locked');
		}

		chaptertext.antialiasing = false;
		add(chaptertext);

		if (isLocked)
			{
				grpWeekCharacters.members[0].color = 0x000000;
				streamers.animation.play('locked');

				lock = new FlxSprite(layeringbox.x - 10, layeringbox.y);
				lock.frames = Paths.getSparrowAtlas('UI_assets');
				//lock.setGraphicSize(Std.int(lock.width * 0.55));
				lock.animation.addByPrefix('lock', 'lock');
				lock.animation.play('lock');
				lock.antialiasing = ClientPrefs.globalAntialiasing;

				add(lock);
			}

		var leWeek:WeekData = loadedWeeks[curWeek];
		WeekData.setDirectoryFromWeek(leWeek);

		var leName:String = leWeek.storyName;
		txtWeekTitle.text = leName.toUpperCase();
		txtWeekTitle.x = FlxG.width - (txtWeekTitle.width + 10);

		var bullShit:Int = 0;

		var unlocked:Bool = !weekIsLocked(leWeek.fileName);
		for (item in grpWeekText.members)
		{
			item.targetY = bullShit - curWeek;
			if (item.targetY == Std.int(0) && unlocked)
				item.alpha = 1;
			else
				item.alpha = 0.6;
			bullShit++;
		}

		bgSprite.visible = true;
		var assetName:String = leWeek.weekBackground;
		if(assetName == null || assetName.length < 1) {
			bgSprite.visible = false;
		} else {
			bgSprite.loadGraphic(Paths.image('menubackgrounds/menu_' + assetName));
		}
		PlayState.storyWeek = curWeek;

		CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();
		var diffStr:String = WeekData.getCurrentWeek().difficulties;
		if(diffStr != null) diffStr = diffStr.trim(); //Fuck you HTML5
		difficultySelectors.visible = unlocked;

		if(diffStr != null && diffStr.length > 0)
		{
			var diffs:Array<String> = diffStr.split(',');
			var i:Int = diffs.length - 1;
			while (i > 0)
			{
				if(diffs[i] != null)
				{
					diffs[i] = diffs[i].trim();
					if(diffs[i].length < 1) diffs.remove(diffs[i]);
				}
				--i;
			}

			if(diffs.length > 0 && diffs[0].length > 0)
			{
				CoolUtil.difficulties = diffs;
			}
		}
		
		if(CoolUtil.difficulties.contains(CoolUtil.defaultDifficulty))
		{
			curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(CoolUtil.defaultDifficulty)));
		}
		else
		{
			curDifficulty = 0;
		}

		var newPos:Int = CoolUtil.difficulties.indexOf(lastDifficultyName);
		//trace('Pos of ' + lastDifficultyName + ' is ' + newPos);
		if(newPos > -1)
		{
			curDifficulty = newPos;
		}
		updateText();
		changeBF();
	}

	function changeBF(change:Int = 0):Void
		{
			FreeplayState.bfType += change;
	
			if (FreeplayState.bfType >= 5)
				FreeplayState.bfType = 0;
			if (FreeplayState.bfType < 0)
				FreeplayState.bfType = 4;
	
			switch (FreeplayState.bfType)
			{
				case 0:
					charactertext.text = "Standard";
					FreeplayState.canskincontinue = true;
				case 1:
					if (FlxG.save.data.poutfitunlocked)
						{
							charactertext.text = "Plumber";
							FreeplayState.canskincontinue = true;
						}
					else
						{
							charactertext.text = "???";
							FreeplayState.canskincontinue = false;
						}
				case 2:
					if (FlxG.save.data.soutfitunlocked)
						{
							charactertext.text = "Shogun";
							FreeplayState.canskincontinue = true;
						}
					else
						{
							charactertext.text = "???";
							FreeplayState.canskincontinue = false;
						}
				case 3:
					if (FlxG.save.data.goutfitunlocked)
						{
							charactertext.text = "Groovy";	
							FreeplayState.canskincontinue = true;
						}
					else
						{
							charactertext.text = "???";
							FreeplayState.canskincontinue = false;
						}
				case 4:
					if (FlxG.save.data.poutfit2unlocked)
						{
							charactertext.text = "Mafia";	
							FreeplayState.canskincontinue = true;
						}
					else
						{
							charactertext.text = "???";
							FreeplayState.canskincontinue = false;
						}
			}
		}

	function weekIsLocked(name:String):Bool {
		var leWeek:WeekData = WeekData.weeksLoaded.get(name);
		return (!leWeek.startUnlocked && leWeek.weekBefore.length > 0 && (!weekCompleted.exists(leWeek.weekBefore) || !weekCompleted.get(leWeek.weekBefore)));
	}

	function updateText()
	{
		var weekArray:Array<String> = loadedWeeks[curWeek].weekCharacters;
		for (i in 0...grpWeekCharacters.length) {
			grpWeekCharacters.members[i].changeCharacter(weekArray[i]);
		}

		var leWeek:WeekData = loadedWeeks[curWeek];
		var stringThing:Array<String> = [];
		for (i in 0...leWeek.songs.length) {
			stringThing.push(leWeek.songs[i][0]);
		}

		txtTracklist.text = '';
		for (i in 0...stringThing.length)
		{
			txtTracklist.text += stringThing[i] + '\n';
		}

		txtTracklist.text = txtTracklist.text.toUpperCase();

		//txtTracklist.screenCenter();
		trace(txtTracklist.x);

		//txtTracklist.x -= FlxG.width * 0.35;

		#if !switch
		intendedScore = Highscore.getWeekScore(loadedWeeks[curWeek].fileName, curDifficulty);
		#end
	}
}
