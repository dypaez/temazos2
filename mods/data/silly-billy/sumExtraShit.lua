--Some Options Lol-----------
local useVideoSprite = false
local arrowMovement = false
-----------------------------

local addedZoom = 0
local scaleBF = {0, 0}
local scaleDad = {0, 0}

function onCreatePost()
if not useVideoSprite then
   makeAnimatedLuaSprite('open','open/open', 0, 0)
   addAnimationByPrefix('open','i','open open',30,false)
   scaleObject('open', 1.5, 1.5)
   setProperty("open.antialiasing", true)
   setObjectCamera('open', 'camHUD')
   screenCenter('open','xy')
   setObjectOrder("open", 0)
end
makeLuaSprite("sillyBars", 'bars', 0, 0)
setObjectCamera("sillyBars", 'hud')
setObjectOrder("sillyBars", 1)
setProperty("sillyBars.visible", false)
addLuaSprite("sillyBars")

makeAnimatedLuaSprite('VideoPT1', 'video/SO_STAY_FINAL', 0, 0)
addAnimationByPrefix('VideoPT1', 'video', 'STAY', 12, false);
setObjectCamera('VideoPT1', 'camHUD')
scaleObject('VideoPT1', 2.23, 2.23)
setObjectOrder("VideoPT1", 1)
setProperty('VideoPT1.alpha', 0)

makeAnimatedLuaSprite('VideoPT2', 'video/SO_STAY_FINAL2', 0, 0)
addAnimationByPrefix('VideoPT2', 'video', 'STAY', 12, false);
setObjectCamera('VideoPT2', 'camHUD')
scaleObject('VideoPT2', 2.23, 2.23)
setObjectOrder("VideoPT2", 1)
setProperty('VideoPT2.alpha', 0)

makeAnimatedLuaSprite('VideoPT3', 'video/SO_STAY_FINAL3', 0, 0)
addAnimationByPrefix('VideoPT3', 'video', 'STAY', 12, false);
setObjectCamera('VideoPT3', 'camHUD')
scaleObject('VideoPT3', 2.23, 2.23)
setObjectOrder("VideoPT3", 1)
setProperty('VideoPT3.alpha', 0)

makeAnimatedLuaSprite('VideoPT4', 'video/SO_STAY_FINAL4', 0, 0)
addAnimationByPrefix('VideoPT4', 'video', 'STAY', 12, false);
setObjectCamera('VideoPT4', 'camHUD')
scaleObject('VideoPT4', 2.23, 2.23)
setObjectOrder("VideoPT4", 1)
setProperty('VideoPT4.alpha', 0)

makeAnimatedLuaSprite('VideoPT5', 'video/SO_STAY_FINAL5', 0, 0)
addAnimationByPrefix('VideoPT5', 'video', 'STAY', 12, false);
setObjectCamera('VideoPT5', 'camHUD')
scaleObject('VideoPT5', 2.23, 2.23)
setObjectOrder("VideoPT5", 1)
setProperty('VideoPT5.alpha', 0)

setProperty("VideoPT1.antialiasing", true)
setProperty("VideoPT2.antialiasing", true)
setProperty("VideoPT3.antialiasing", true)
setProperty("VideoPT4.antialiasing", true)
setProperty("VideoPT5.antialiasing", true)

makeLuaSprite("black", '', 0, 0)
setObjectCamera("black", 'hud')
setObjectOrder("black", 1)
makeGraphic("black", screenWidth, screenHeight, '000000')
addLuaSprite("black")

runHaxeCode("Paths.clearUnusedMemory();")

setVar('opCustom', getProperty('dad.Custom'))
setVar('plCustom', getProperty('boyfriend.Custom'))

if getProperty('dad.Custom') then
 setVar('dadColr', getProperty('healthBar.leftBar.color'))
end

if getProperty('boyfriend.Custom') then
   setVar('bfColr', getProperty('healthBar.rightBar.color'))
  end

for i = 0,7 do
   setPropertyFromGroup("strumLineNotes", i, 'visible', false)
end

scaleBF = {getProperty('boyfriend.scale.x'),getProperty('boyfriend.scale.y')}
scaleDad = {getProperty('dad.scale.x'),getProperty('dad.scale.y')}
end

function onSongStart()
   setObjectOrder("dadGroup", 9999)
   setObjectOrder("boyfriendGroup", 99999)
   if useVideoSprite then
   makeVideoSprite('openCut', 'open', 210, 115, 'camHUD')
   setObjectOrder("openCut_video", 2)
   scaleObject("openCut_video", 1.5, 1.5)
   else
      playAnim("open", "i", true)
      addLuaSprite('open', false)
      setObjectOrder("open", 2)
   end
   makeLuaText("sillyLyrics", "", 0, 0.0, 0.0)
   setTextFont("sillyLyrics", "Times New Roman.ttf")
   setTextSize("sillyLyrics", 48)
   setTextBorder("sillyLyrics", 2, "000000")
   setTextAlignment("sillyLyrics", 'center')
   setObjectCamera("sillyLyrics", 'hud')
   setTextColor("sillyLyrics", "cfa92d")
   setProperty("sillyLyrics.y", screenHeight-getProperty("sillyLyrics.height"))
   screenCenter("sillyLyrics", 'x')
   addLuaText("sillyLyrics")

   if getProperty("dad.Custom") then
      setProperty(getVar('iconOpponent')..'.visible', false)
      setProperty('iconP2.visible', true)
      setObjectOrder("iconP2", getObjectOrder(getVar('iconOpponent')))
      setProperty('dad.x', getProperty("dad.x")+100)
      setProperty('dad.color', getColorFromHex("c9bedb"))
   end

   if getProperty("boyfriend.Custom") then
      setProperty(getVar('iconPlayer')..'.visible', false)
      setProperty('iconP1.visible', true)
      setObjectOrder("iconP1", getObjectOrder(getVar('iconPlayer')))
      if luaSpriteExists('iconP1Small') then
         setObjectOrder("iconP1Small", getObjectOrder(getVar('iconPlayer')))
      end
      setProperty('boyfriend.y', getProperty("boyfriend.y")+50)
      setProperty('boyfriend.x', getProperty("boyfriend.x")+50)
      characterRezise('boyfriend', scaleBF[1]+0.3)
      setProperty('boyfriend.color', getColorFromHex("c9bedb"))
   end
end

function onEvent(n,v1,v2)
 if v1 == 'zoomin' then
      addedZoom = v2
      setProperty('defaultCamZoom', getProperty('defaultCamZoom')+addedZoom)
 end
 if n == 'ill make' then
   if v1 == 'pre' then
      for i = 0,7 do
         noteTweenAlpha(i, i, 0, 2, "quadIn")
      end
   end
   if v1 == 'anim' then
      runHaxeCode([[
         game.vocals.volume = 1;
         game.dad.visible = false;
         ]])
      makeAnimatedLuaSprite("daDialogue", 'characters/HSLookalikeDialogue1', 730, 350)
      addAnimationByPrefix("daDialogue", "dialogue", "HSLookalikeDialogue", 31, false)
      scaleObject("daDialogue", 2.5, 2.5)
      setObjectCamera("daDialogue", 'game')
      addLuaSprite("daDialogue")
      setObjectOrder("daDialogue", getObjectOrder('dadGroup'))
      setProperty("daDialogue.antialiasing", true)
      playAnim("daDialogue", "dialogue")

      makeAnimatedLuaSprite("daDialogueP2", 'characters/HSLookalikeDialogue2', 730, 350)
      addAnimationByPrefix("daDialogueP2", "dialogue", "HSLookalikeDialogue", 31, false)
      scaleObject("daDialogueP2", 2.5, 2.5)
      setObjectCamera("daDialogueP2", 'game')
   end
   if v1 == 'txt' then
      setTextString("sillyLyrics", v2)
      screenCenter("sillyLyrics", 'x')
   end
   if v1 == 'black' then
      doTweenAlpha("blackAppear", "black", 1, 1.125, "quadOut")
   end
   if v1 == 'vid' then
   addLuaSprite('VideoPT1', false);
   playAnim("VideoPT1", "video", true)
   setProperty('VideoPT1.alpha', 0)
   doTweenAlpha("appeared", "VideoPT1", 1, 0.125*1.5, "quadOut")
   end
   if v1 == 'hud in' then
      if arrowMovement then
      strumTweenX(732+30, 0.0001, false, 'circOut', false)
      end
      for i = 4,7 do
         noteTweenAlpha(i, i, 1, 1.5, "quadOut") 
      end
   end
   if v1 == 'die' then
      setProperty("black.alpha", 1)
      setProperty("camGame.alpha", 0)
      for i = 0,7 do
         noteTweenAlpha(i, i, 0, 4, "quadIn")
      end
   end
 end
end

function onUpdate(elapsed)
   if onlinePlay or localPlay then
      setProperty('P2scoreTxt.alpha', getProperty('scoreTxt.alpha'))
      setObjectOrder("P2scoreTxt", getObjectOrder("scoreTxt"))
      setProperty('scoreTxt.x', 213.75 - (getProperty('scoreTxt.width')/3))
   end

   if getProperty("dad.Custom") then
      setProperty('iconP2.alpha', getProperty('scoreTxt.alpha'))
   end

   if getProperty("boyfriend.Custom") then
      setProperty('iconP1.alpha', getProperty('scoreTxt.alpha'))
   end

   if not useVideoSprite then
      if getProperty("open.animation.curAnim.name") == 'i' and getProperty("open.animation.curAnim.finished") then
         doTweenAlpha("endCutsceneLQ", "open", 0, 0.3)
         doTweenAlpha("endCutscene", "black", 0, 0.3)
      end
   end

   if getProperty("daDialogue.animation.curAnim.finished") then
      addLuaSprite("daDialogueP2")
      setProperty("daDialogueP2.antialiasing", true)
      setObjectOrder("daDialogueP2", getObjectOrder('dadGroup'))
      playAnim("daDialogueP2", "dialogue")
      removeLuaSprite("daDialogue")
   end

   if getProperty("VideoPT1.animation.curAnim.finished") and getProperty("VideoPT1.alpha") == 1 then
      setProperty('VideoPT2.alpha', 1)
      playAnim("VideoPT2", "video", true)
      removeLuaSprite("VideoPT1")
   end

   if getProperty("VideoPT2.animation.curAnim.finished") and not luaSpriteExists("VideoPT1") then
      setProperty('VideoPT3.alpha', 1)
      setProperty('dad.visible', true)
      playAnim("VideoPT3", "video", true)
      removeLuaSprite("VideoPT2")
      removeLuaSprite("daDialogueP2")
   end

   if getProperty("VideoPT3.animation.curAnim.finished") and not luaSpriteExists("VideoPT2") then
      setProperty('VideoPT4.alpha', 1)
      playAnim("VideoPT4", "video", true)
      removeLuaSprite("VideoPT3")
   end

   if getProperty("VideoPT4.animation.curAnim.finished") and not luaSpriteExists("VideoPT3") then
      setProperty('VideoPT5.alpha', 1)
      playAnim("VideoPT5", "video", true)
      removeLuaSprite("VideoPT4")
   end

   if getProperty("VideoPT5.animation.curAnim.finished") and not luaSpriteExists("VideoPT4") then
      removeLuaSprite("VideoPT5")
   end

   if curStep > 3351 and curStep < 3512 then
      setProperty('camFollow.x', 1392)
      setProperty('camFollow.y', 968)
   end
end

function onUpdatePost()
 if getProperty("dad.Custom") then
   setProperty('iconP2.x', getProperty(getVar('iconOpponent')..'.x'))
   setProperty('iconP2.scale.x', 1)
   setProperty('iconP2.scale.y', 1)
   setProperty('iconP2.flipX', true)
 end

 if getProperty("boyfriend.Custom") then
   setProperty('iconP1.x', getProperty(getVar('iconPlayer')..'.x'))
   setProperty('iconP1.scale.x', 1)
   setProperty('iconP1.scale.y', 1)
   setProperty('iconP1.flipX', true)
 end
end

function onVideoFinished(tag)
 if tag == 'openCut' then
   doTweenAlpha("endCutscene", "black", 0, 0.3)
 end
end

function onStepHit()
 if curStep == 112 then
   for i = 0,7 do
      setPropertyFromGroup("strumLineNotes", i, 'visible', true)
   end 
 end

 if curStep == 126 then
   setProperty("sillyBars.visible", true)
 end
 
 if curStep == 2064 then
    setCameraBeat(1, true)
 end

 if curStep == 2192 then
    setCameraBeat(1, false)
 end

 if curStep == 3880 then
   if arrowMovement then
   strumTweenX(1068, 0.5, false, 'quadOut', false)
   end
   for i = 0,3 do
      noteTweenAlpha(i, i, 1, 0.5, "quadOut") 
   end
 end

 if curStep == 3888 then
   doTweenAlpha("blackBye", "black", 0, 0.3)
   runHaxeCode([[
      var blueShader = game.createRuntimeShader('blue');
      blueShader.setFloat('hue', 1.3);
      blueShader.setFloat('pix', 0.00001);
      game.camGame._filters = [new ShaderFilter(blueShader)];
      game.camHUD._filters = [new ShaderFilter(blueShader)];
   ]])
 end
end

function onMoveCamera(char)
 if not getVar("camZoomLock") then
   if char == 'dad' then
      setProperty('defaultCamZoom', 0.625+addedZoom) else setProperty('defaultCamZoom', 0.5+addedZoom)
   end
 end
end

function strumTweenX(target, duration, isDad, ease, isP3)
   if isDad then
      arrowArray = {[0]= 0, 1, 2, 3}
      tagArray = {[0]= 'opX0', 'opX1', 'opX2', 'opX3'}
   else
      arrowArray = {[0]= 4, 5, 6, 7}
      tagArray = {[0]= 'bfX0', 'bfX1', 'bfX2', 'bfX3'}
   end
  
   if not isDad and isP3 then
     arrowArray = {[0]= 'P3Strum0', 'P3Strum1', 'P3Strum2', 'P3Strum3'}
     tagArray = {[0]= 'p3X0', 'p3X1', 'p3X2', 'p3X3'}
   end
  
   if not isP3 then
   noteTweenX(tagArray[0], arrowArray[0], target-112*3, duration, ease)
   noteTweenX(tagArray[1], arrowArray[1], target-112*2, duration, ease)
   noteTweenX(tagArray[2], arrowArray[2], target-112, duration, ease)
   noteTweenX(tagArray[3], arrowArray[3], target, duration, ease)
   else
     doTweenX(tagArray[0], arrowArray[0], target-112*3, duration, ease)
     doTweenX(tagArray[1], arrowArray[1], target-112*2, duration, ease)
     doTweenX(tagArray[2], arrowArray[2], target-112, duration, ease)
     doTweenX(tagArray[3], arrowArray[3], target, duration, ease)
  end
  end