function onCreate()
    if getProperty('dad.Custom') then
        getCharacterX('dad', setCharacterX('dad', 0))
        getCharacterY('dad', setCharacterY('dad', 100))
    end
    if getProperty('boyfriend.Custom') then
        getCharacterX('boyfriend', setCharacterX('boyfriend', 770))
        getCharacterY('boyfriend', setCharacterY('boyfriend', 100))
    end
end
