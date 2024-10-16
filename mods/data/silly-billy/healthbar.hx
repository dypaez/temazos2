import flixel.ui.FlxBar;
import flixel.ui.FlxBarFillDirection;

var bar:FlxSprite;
var iconOpp:FlxSprite;
var iconP:FlxSprite;
var barFill:FlxSprite;
var actualBar:FlxBar;
var evilBar:FlxBar;
var evilHealth:Float = 1;


function onCreatePost(){
    bar = new FlxSprite().loadGraphic(Paths.image("Bar/Silly_Healthbar"));
    bar.cameras = [game.camHUD];
    bar.scale.set(0.5, 0.5);
    bar.updateHitbox();
    bar.screenCenter();
    bar.x -= 250;
    bar.y = (game.healthBar.y - (bar.height / 2)) - 15;

    actualBar = new FlxBar(0, 0, FlxBarFillDirection.LEFT_TO_RIGHT, 327.805, 28);
    actualBar.cameras = [game.camHUD];
    if (getVar('plCustom') == false) {
    actualBar.createGradientBar([0xFF000000, 0xFF000000], [0xFF1565C0, 0xFFFFFFFF], 1, 90);
    } else {
    actualBar.createGradientBar([0xFF000000, 0xFF000000], [getVar('bfColr'), 0xFFFFFFFF], 1, 90);}
    actualBar.updateBar();
    actualBar.setPosition(420, 615.8);
    add(actualBar);
    evilBar = new FlxBar(0, 0, FlxBarFillDirection.RIGHT_TO_LEFT, 330.805, 36);
    evilBar.cameras = [game.camHUD];
    if (getVar('opCustom') == false) {
    evilBar.createGradientBar([0xFF000000, 0xFF000000], [0xFF8A0101, 0xFF000000], 1, 90);
    } else {
    evilBar.createGradientBar([0xFF000000, 0xFF000000], [getVar('dadColr'), 0xFF000000], 1, 90);}
    evilBar.updateBar();
    evilBar.setPosition(405 - evilBar.width - 25, 623.8);
    add(evilBar);
    add(bar);

    iconP = new FlxSprite().loadGraphic(Paths.image("Bar/icons/bficon"));
    iconP.loadGraphic(Paths.image("Bar/icons/bficon"), true, Math.floor(iconP.width / 2), Math.floor(iconP.height));
    iconP.animation.add('bf', [0, 1], 0, false, true);
    iconP.animation.play('bf');
    iconP.cameras = [game.camHUD];
    iconP.setPosition(400, (bar.y + (bar.height / 2) - (iconP.height / 2)));
    iconP.flipX = true;
    add(iconP);

    iconOpp = new FlxSprite();
    iconOpp.loadGraphic(Paths.image("Bar/icons/billyicon"));
    iconOpp.loadGraphic(Paths.image("Bar/icons/billyicon"), true, Math.floor(iconOpp.width / 5), Math.floor(iconOpp.height));
    iconOpp.animation.add('0', [0], 0, false, false);
    iconOpp.animation.add('1', [1], 0, false, false);
    iconOpp.animation.add('2', [2], 0, false, false);
    iconOpp.animation.add('3', [3], 0, false, false);
    iconOpp.animation.add('4', [4], 0, false, false);
    iconOpp.animation.play('1');
    iconOpp.cameras = [game.camHUD];
    iconOpp.setPosition(405 - iconOpp.width, (bar.y + (bar.height / 2) - (iconOpp.height / 2)));
    add(iconOpp);

    iconOpp.centerOffsets();
    iconP.centerOffsets();

    if (ClientPrefs.data.downScroll) {
        bar.y += 25;
        iconP.y += 25;
        iconOpp.y += 25;
        actualBar.y = game.healthBar.y;
        evilBar.y = actualBar.y;
    }

    remove(game.scoreTxt);
    insert(50,game.scoreTxt);

    game.healthBar.visible = false;
    game.iconP1.visible = false;
    game.iconP2.visible = false;
    game.scoreTxt.y += 20;

    var hudLmao = [bar, actualBar, evilBar, iconP, iconOpp];
    for(h in hudLmao){ FlxTween.tween(h, {alpha: 0}, 0.0001, {ease: FlxEase.quadIn});}

    setVar('iconPlayer', iconP);
    setVar('iconOpponent', iconOpp);
}

function onUpdate(elapsed){
    actualBar.percent = game.healthBar.percent;
    evilBar.percent = 100 - game.healthBar.percent;

    var percent = (game.health / 2) * 100;
    if (percent < 20){
        iconP.animation.curAnim.curFrame = 1;
    }
    else{
        iconP.animation.curAnim.curFrame = 0;
    }

    game.scoreTxt.alpha = actualBar.alpha;
    game.timeBar.alpha = actualBar.alpha;
    game.timeTxt.alpha = actualBar.alpha;

    if (curStep == 128) {
        var hudLmao = [bar, actualBar, evilBar, iconP, iconOpp];
        for(h in hudLmao){ FlxTween.tween(h, {alpha: 1}, 0.125, {ease: FlxEase.quadIn});}
    }
}


function onEvent(eventName, value1, value2){
    if(eventName == 'ill make'){
        switch(value1){
            case 'pre':
                var hud = [bar, actualBar, evilBar, iconP, iconOpp];
                for(h in hud){ FlxTween.tween(h, {alpha: 0}, 2, {ease: FlxEase.quadIn});}
            case 'die':
                var hud = [bar, actualBar, evilBar, iconP, iconOpp];
                for(h in hud){ FlxTween.tween(h, {alpha: 0}, 4, {ease: FlxEase.quadIn});}
        }
    }else if (eventName == 'icon switch'){
        trace(value1);
        iconOpp.animation.play(value1);
        if(game.health > 0.5) FlxTween.num(game.health, 0.5, 1, {ease: FlxEase.quadOut, onUpdate: (t:FlxTween)->{evilHealth = t.value;}});
    }
}

function goodNoteHit(note){
}

function opponentNoteHit(note){
    if(game.health >= 0.1)
        game.health -= note.hitHealth * 0.5;
}