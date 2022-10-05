package;

import flixel.util.FlxAxes;
import flixel.FlxSubState;
import flixel.input.FlxInput;
import flixel.input.keyboard.FlxKey;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;
import flixel.math.FlxPoint;
import flixel.addons.display.shapes.FlxShapeBox;
import flixel.addons.display.shapes.FlxShapeLine;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import flixel.math.FlxMath;
import flixel.text.FlxText;


using StringTools;

class CoinsScreen extends MusicBeatSubstate
{

    var coinwhite1:FlxSprite;
    var okpressnowlol:Bool = false;
    var coinwhite2:FlxSprite;
    var coinwhite3:FlxSprite;
    var cointotal:FlxSprite;
    var hardbonus:FlxSprite;
    var blackBox:FlxShapeBox;
    var line1:FlxShapeLine;
    var line2:FlxShapeLine;
    var line3:FlxShapeLine;
    var line4:FlxShapeLine;
    var infoText:FlxText;
    var coinxText:FlxText;
    var accuracycoinText:FlxText;
    var sickcoinText:FlxText;
    var missescoinText:FlxText;
    var songBonus:FlxText;
    var dropShadow:FlxText;
    var enterText:FlxText;
    var cointotaltext:FlxText;
    var xtext:FlxText;
    var totalText:FlxText;
    var sickscore:Float = 0;
    var accuracyscore:Float = 0;
    var falseaccuraacy:Float = 0;
    var coinamount:Float = 0;
    var missescore:Float = 0;

    var boundarycolor:FlxColor = 0xff454545;

    var coinicon:FlxSprite;
	var coinsavetext:FlxText;
	var xcointext:FlxText;

    public static var lolnocoins:Bool = false;

	public function new(x:Float, y:Float)
	{	
        super();

        //PlayState.persistentUpdate = true;

        accuracyscore = PlayState.ratingPercent * 100 / 2;
        accuracyscore = Math.round(accuracyscore * Math.pow(10, 0));

        sickscore = PlayState.sicks / 6;
        sickscore = Math.round(sickscore * Math.pow(10, 0));

        missescore = PlayState.songMisses / 2;
        missescore = Math.round(missescore * Math.pow(10, 0));

        coinamount = sickscore + accuracyscore - missescore;     
        coinamount = Math.round(coinamount * Math.pow(10, 0));
        
        if (ClientPrefs.getGameplaySetting('botplay', false))
        coinamount = 0;

        if (coinamount <= 0)
        {
        coinamount = 0;
        lolnocoins = true;
        }

        blackBox = new FlxShapeBox(200, 90, 800, 350, {}, FlxColor.BLACK);
		blackBox.updateHitbox();
		blackBox.alpha = 0;
		blackBox.scrollFactor.set();
		add(blackBox);

        dropShadow = new FlxText(6, 49, FlxG.width, ("Song Bonus!"), 120);
		dropShadow.scrollFactor.set(0, 0);
		dropShadow.setFormat(Paths.font("mario.ttf"), 64, FlxColor.BLACK, FlxTextAlign.CENTER);
        dropShadow.alpha = 0;
        dropShadow.antialiasing = true;
        add(dropShadow);

        songBonus = new FlxText(0, 45, FlxG.width, ("Song Bonus!"), 120);
		songBonus.scrollFactor.set(0, 0);
		songBonus.setFormat(Paths.font("mario.ttf"), 64, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, boundarycolor);
		songBonus.borderSize = 4;
		songBonus.borderQuality = 3;
        songBonus.antialiasing = true;
        songBonus.alpha = 0;
        add(songBonus);

        infoText = new FlxText(290, 120, FlxG.width, "Accuracy \n\n\nSick Bonus \n\n\nMisses", 120);
		infoText.scrollFactor.set(0, 0);
		infoText.setFormat(Paths.font("paperfont.otf"), 20, FlxColor.WHITE, FlxTextAlign.LEFT);
		//infoText.borderSize = 2;
		//infoText.borderQuality = 3;
        infoText.antialiasing = true;
        infoText.alpha = 0;
        add(infoText);

        coinxText = new FlxText(780, 115, FlxG.width, "x\n\nx\n\nx", 120);
		coinxText.scrollFactor.set(0, 0);
		coinxText.setFormat(Paths.font("mario.ttf"), 30, FlxColor.WHITE, FlxTextAlign.LEFT);
        coinxText.antialiasing = true;
        coinxText.alpha = 0;
        add(coinxText);

        accuracycoinText = new FlxText(800, 105, FlxG.width, (accuracyscore + ""), 120);
		accuracycoinText.scrollFactor.set(0, 0);
		accuracycoinText.setFormat(Paths.font("mario.ttf"), 50, FlxColor.WHITE, FlxTextAlign.LEFT);
        accuracycoinText.antialiasing = true;
        accuracycoinText.alpha = 0;
        add(accuracycoinText);

        sickcoinText = new FlxText(800, 110, FlxG.width, ("\n" + sickscore + ""), 120);
		sickcoinText.scrollFactor.set(0, 0);
		sickcoinText.setFormat(Paths.font("mario.ttf"), 50, FlxColor.WHITE, FlxTextAlign.LEFT);
        sickcoinText.antialiasing = true;
        sickcoinText.alpha = 0;
        add(sickcoinText);

        if (PlayState.songMisses != 0)
        missescoinText = new FlxText(800, 120, FlxG.width, ("\n\n-" + missescore + ""), 120);
        else
        missescoinText = new FlxText(800, 120, FlxG.width, ("\n\n" + missescore + ""), 120);
		missescoinText.scrollFactor.set(0, 0);
		missescoinText.setFormat(Paths.font("mario.ttf"), 50, FlxColor.WHITE, FlxTextAlign.LEFT);
        missescoinText.antialiasing = true;
        missescoinText.alpha = 0;
        add(missescoinText);

        totalText = new FlxText(280, 370, FlxG.width, "Total", 120);
		totalText.scrollFactor.set(0, 0);
		totalText.setFormat(Paths.font("paperfont.otf"), 24, FlxColor.WHITE, FlxTextAlign.LEFT);
		//totalText.borderSize = 2;
		//totalText.borderQuality = 3;
        totalText.alpha = 0;
        totalText.antialiasing = true;
        add(totalText);

        cointotaltext = new FlxText(770, 335, FlxG.width, (coinamount + ""), 120);
		cointotaltext.scrollFactor.set(0, 0);
		cointotaltext.setFormat(Paths.font("mario.ttf"), 72, boundarycolor, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		cointotaltext.borderSize = 2;
		cointotaltext.borderQuality = 3;
        cointotaltext.antialiasing = true;
        cointotaltext.alpha = 0;
        add(cointotaltext);

        xtext = new FlxText(750, 350, FlxG.width, "x", 120);
		xtext.scrollFactor.set(0, 0);
		xtext.setFormat(Paths.font("mario.ttf"), 56, boundarycolor, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		xtext.borderSize = 2;
		xtext.borderQuality = 3;
        xtext.antialiasing = true;
        xtext.alpha = 0;
        add(xtext);

        enterText = new FlxText(250, 415, FlxG.width, ("(Press enter to continue!)"), 120);
		enterText.scrollFactor.set(0, 0);
		enterText.setFormat(Paths.font("mario.ttf"), 20, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		enterText.borderSize = 2;
		enterText.borderQuality = 3;
        enterText.alpha = 0;
        enterText.antialiasing = true;
        add(enterText);

        coinwhite1 = new FlxSprite(760, 125).loadGraphic(Paths.image('coinwhite', 'shared'));
        coinwhite1.scrollFactor.set(0, 0);
		coinwhite1.antialiasing = true;
		coinwhite1.alpha = 0;
		add(coinwhite1);

        coinwhite2 = new FlxSprite(760, 185).loadGraphic(Paths.image('coinwhite', 'shared'));
        coinwhite2.scrollFactor.set(0, 0);
		coinwhite2.antialiasing = true;
		coinwhite2.alpha = 0;
		add(coinwhite2);

        coinwhite3 = new FlxSprite(760, 248).loadGraphic(Paths.image('coinwhite', 'shared'));
        coinwhite3.scrollFactor.set(0, 0);
		coinwhite3.antialiasing = true;
		coinwhite3.alpha = 0;
		add(coinwhite3);

        cointotal = new FlxSprite(705, 360).loadGraphic(Paths.image('cointotal', 'shared'));
        cointotal.scrollFactor.set(0, 0);
		cointotal.antialiasing = true;
		cointotal.alpha = 0;
		add(cointotal);

        line1 = new FlxShapeLine(300, 150, new FlxPoint(0, 0), new FlxPoint(600, 0), {thickness:4, color: FlxColor.WHITE});
		line1.alpha = 0;
		line1.scrollFactor.set();
        line1.antialiasing = true;
		add(line1);

        line2 = new FlxShapeLine(300, 210, new FlxPoint(0, 0), new FlxPoint(600, 0), {thickness:4, color: FlxColor.WHITE});
		line2.alpha = 0;
		line2.scrollFactor.set();
        line2.antialiasing = true;
		add(line2);

        line3 = new FlxShapeLine(300, 273, new FlxPoint(0, 0), new FlxPoint(600, 0), {thickness:4, color: FlxColor.WHITE});
		line3.alpha = 0;
		line3.scrollFactor.set();
        line3.antialiasing = true;
		add(line3);

        line4 = new FlxShapeLine(300, 410, new FlxPoint(0, 0), new FlxPoint(600, 0), {thickness:4, color: FlxColor.WHITE});
		line4.alpha = 0;
		line4.scrollFactor.set();
        line4.antialiasing = true;
		add(line4);

        coinicon = new FlxSprite(100, 600).loadGraphic(Paths.image('cointotal', 'shared'));
        coinicon.scrollFactor.set();
		coinicon.antialiasing = true;

		coinsavetext = new FlxText(160, 580, FlxG.width, (FlxG.save.data.coins + ""), 120);
		coinsavetext.setFormat(Paths.font("mario.ttf"), 72, boundarycolor, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		coinsavetext.borderSize = 2;
		coinsavetext.borderQuality = 3;
        coinsavetext.antialiasing = true;
        coinsavetext.scrollFactor.set();

		xcointext = new FlxText(140, 590, FlxG.width, "x", 120);
		xcointext.setFormat(Paths.font("mario.ttf"), 56, boundarycolor, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		xcointext.borderSize = 2;
		xcointext.borderQuality = 3;
        xcointext.antialiasing = true;
        xcointext.scrollFactor.set();
        add(coinicon);
        add(xcointext);
        add(coinsavetext);

        hardbonus = new FlxSprite(880, 260).loadGraphic(Paths.image('hardbonus', 'shared'));
        hardbonus.scrollFactor.set(0, 0);
		hardbonus.antialiasing = true;
        hardbonus.setGraphicSize(Std.int(hardbonus.width * 1.2));
		hardbonus.alpha = 0;
		add(hardbonus);

		#if android
		addVirtualPad(NONE, A);
		#end
			
        blackBox.alpha = 0;

        FlxTween.tween(blackBox, {alpha: 0.5}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(coinicon, {alpha: 1}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(coinsavetext, {alpha: 1}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(xcointext, {alpha: 1}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(dropShadow, {alpha: 1}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(coinwhite1, {alpha: 1}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(coinwhite2, {alpha: 1}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(coinwhite3, {alpha: 1}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(cointotal, {alpha: 1}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(line1, {alpha: 0.7}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(line2, {alpha: 0.7}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(line3, {alpha: 0.7}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(line4, {alpha: 0.7}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(songBonus, {alpha: 1}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(coinxText, {alpha: 1}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(infoText, {alpha: 1}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(xtext, {alpha: 1}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(totalText, {alpha: 1}, 1, {ease: FlxEase.expoInOut});

        new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				FlxTween.tween(accuracycoinText, {alpha: 1}, 1, {ease: FlxEase.expoInOut});
			});

        new FlxTimer().start(2, function(tmr:FlxTimer)
			{
				FlxTween.tween(sickcoinText, {alpha: 1}, 1, {ease: FlxEase.expoInOut});
			});

        new FlxTimer().start(3, function(tmr:FlxTimer)
			{
				FlxTween.tween(missescoinText, {alpha: 1}, 1, {ease: FlxEase.expoInOut});
			});

        new FlxTimer().start(4, function(tmr:FlxTimer)
			{
                FlxTween.tween(cointotaltext, {alpha: 1}, 1, {ease: FlxEase.expoInOut});
                FlxTween.tween(hardbonus.scale, {x:0.9, y:0.9}, 0.2, {ease: FlxEase.expoInOut,
                onComplete: function(twn:FlxTween)
                {
                FlxTween.tween(hardbonus.scale, {x:1, y:1}, 0.2);
                
                if (PlayState.storyDifficulty == 2)
                coinamount *= 1.5;
                
                coinamount = Math.round(coinamount * Math.pow(10, 0));
                trace("coins earned:" + coinamount);
                FlxG.save.data.coins += coinamount;
                trace("new coin amount:" + FlxG.save.data.coins);
                }
                });

                if (PlayState.storyDifficulty == 2)
                {
                    FlxG.sound.play(Paths.sound('stamp'));
                    FlxTween.tween(hardbonus, {alpha: 1}, 0.5, {ease: FlxEase.expoInOut});
                }

                new FlxTimer().start(1, function(tmr:FlxTimer)
			{
                cointotaltext.text = (coinamount + "");
                coinsavetext.text = FlxG.save.data.coins;
                okpressnowlol = true;
                FlxTween.tween(enterText, {alpha: 1}, 1, {ease: FlxEase.expoInOut});
			});
	});

        /*new FlxTimer().start(8, function(tmr:FlxTimer)
			{
                if (PlayState.hasendingdialog)
                {
                    PlayState.ratingPercent = 0.00;
                    close();
                }
			});*/
    }

	override function update(elapsed:Float)
	{
        super.update(elapsed);

        if(controls.ACCEPT)
        {
            if (okpressnowlol == true)
            {
                okpressnowlol = false;
            PlayState.ratingPercent = 0.00;
            PlayState.songMisses = 0;
            PlayState.sicks = 0;
            FlxTween.tween(blackBox, {alpha: 0}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(dropShadow, {alpha: 0}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(coinwhite1, {alpha: 0}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(coinwhite2, {alpha: 0}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(coinwhite3, {alpha: 0}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(cointotal, {alpha: 0}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(line1, {alpha: 0}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(line2, {alpha: 0}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(line3, {alpha: 0}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(line4, {alpha: 0}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(songBonus, {alpha: 0}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(hardbonus, {alpha: 0}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(infoText, {alpha: 0}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(cointotaltext, {alpha: 0}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(xtext, {alpha: 0}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(totalText, {alpha: 0}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(enterText, {alpha: 0}, 1, {ease: FlxEase.expoInOut}); 
        FlxTween.tween(accuracycoinText, {alpha: 0}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(sickcoinText, {alpha: 0}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(missescoinText, {alpha: 0}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(coinicon, {alpha: 0}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(coinsavetext, {alpha: 0}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(xcointext, {alpha: 0}, 1, {ease: FlxEase.expoInOut});
        FlxTween.tween(coinxText, {alpha: 0}, 1, {ease: FlxEase.expoInOut,
         	onComplete: function(twn:FlxTween)
             {
            if (!PlayState.isStoryMode)
            {
                kill();  
                LoadingState.loadAndSwitchState(new FreeplayState());
                lolnocoins = false;
            }	
            else if (!PlayState.hasendingdialog)
            {
		    
                kill();   
                LoadingState.loadAndSwitchState(new PlayState());
                lolnocoins = false;
            }
            else
                {
                    kill();
                    PlayState.endingintro = true; 
                    lolnocoins = false;
                }
    
             }
             });
            }   
        }
		
	}

}
