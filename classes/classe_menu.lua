------------------------------------------------------------------------------------------------------------------------------------------------------------
--classe_menu.lua
------------------------------------------------------------------------------------------------------------------------------------------------------------

local mMenu = {}
function mMenu:new()

    
    local menu = display.newGroup()
    
    
    
    
        self.boutonJeu = display.newRect( 0, 0, display.contentWidth/2, display.contentHeight/2 )
        menu:insert(self.boutonJeu)    
    
    
    function menu:jouer()
        local mJeu = require('classes.classe_jeu')
        local jeu = mJeu:new()
    end
    
    
    
    
    
    
    
    
   
    --Runtime:addEventListener('enterFrame', menu) 
    self.boutonJeu:addEventListener('touch', jouer)
    
    return menu

end
return mMenu