------------------------------------------------------------------------------------------------------------------------------------------------------------
--classe_menu.lua
------------------------------------------------------------------------------------------------------------------------------------------------------------

local mJeu = {}
function mJeu:new()

    
    local jeu = display.newGroup()
    
    local mNiveau = require('classes.classe_niveau')
    local niveau = mNiveau:new()
    
    Runtime:addEventListener('enterFrame', jeu) 
    
    return jeu

end
return mJeu