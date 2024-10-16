var everBeat:Int = 4;
var isBeat:Bool = false;

createGlobalCallback('setCameraBeat', function(beat:Int, enabled:Bool){
  if (beat > 0) {
    game.camZooming = true;
  } else {
    game.camZooming = false;
  }
   isBeat = enabled;
   everBeat = beat;
});

function onBeatHit(){
    if (isBeat){
     if (curBeat % everBeat == 0){
        FlxG.camera.zoom += 0.015 * game.camZoomingMult;
        game.camHUD.zoom += 0.03 * game.camZoomingMult;
     }
    }
}