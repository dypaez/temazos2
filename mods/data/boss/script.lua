local cutsceneSkip = false --the true/false statement for the control
local allowCountdown = false;
function onCreate()
    if not isStoryMode then
        makeLuaText('text', 'Press Space to skip intro', '700', 275, 500) --the text
        setTextAlignment('text', 'center')
        setTextSize('text', '40')
        addLuaText('text', true)
        setProperty('text.alpha', 0)
        setObjectCamera('text', 'other')
    end
end

function onSongStart() --activates control
    seenCutscene=false
    if not isStoryMode then
        doTweenAlpha('texttween1', 'text', 1, 0.5, 'linear');
    end
    cutsceneSkip = true;
    runTimer('timerlol', 5)
end

function onUpdate()
    if cutsceneSkip == true and keyJustPressed('space') and not isStoryMode then --turns off control
        setPropertyFromClass('Conductor', 'songPosition', getPropertyFromClass('Conductor', 'songPosition') + 22000)
        setPropertyFromClass('flixel.FlxG', 'sound.music.time', getPropertyFromClass('Conductor', 'songPosition'))
        setProperty('vocals.time', getPropertyFromClass('Conductor', 'songPosition'))
        cutsceneSkip = false;
        doTweenAlpha('texttween2', 'text', 0, 0.2, 'linear');
    end
end

function onTimerCompleted(tag)
    if tag == 'timerlol' and cutsceneSkip == true and not isStoryMode then --timer to turn off control if you don't press space
        doTweenAlpha('texttween2', 'text', 0, 0.5, 'linear');
        cutsceneSkip = false;
    end
end

function onTweenCompleted(tag)
    if tag == 'texttween2' and not isStoryMode then
        removeLuaText('text') --removes the sprite lmaoaoaoaoaoaaoaoaoao
    end
end
function onStartCountdown()
	if not allowCountdown and isStoryMode and not seenCutscene then
		startVideo('BosS');
		allowCountdown = true;
		playDialogue = true;
		return Function_Stop;
	end
	return Function_Continue;
end
function onEndSong()
    if isStoryMode and not seenCutscene then
        startVideo('Week2End');
        seenCutscene = true
        return Function_Stop
    end
    return Function_Continue
end