-----------------------------------------------------------------------------------------
-- MADE BY GABRIEL CLOUTIER
-- classe_interface.lua
--
-- !important display.newImageRect( [parent,] filename, [baseDir,] width, height ) pour les images
-----------------------------------------------------------------------------------------
local mNiveau = {}
function mNiveau:new()

    
    local niveau = display.newGroup()
    

    local mPerso = require('classes.classe_perso')
    local perso = mPerso:new()
    niveau:insert(perso)

    local mObstacle = require('classes.classe_obstacle')

    local function spawn()
        local obstacle = mObstacle:new()--self:spawn()
        niveau:insert(obstacle)
    end
    local timerObst = timer.performWithDelay(200,spawn,-1) -- à chaque seconde, appelle la fonction spawn et répète à l'infini

    local mInterface = require('classes.classe_interface')
    local interface = mInterface:new(perso)
    perso:setInterface(interface)
    niveau:insert(interface)
    
    print('niveau', self)
    
    function niveau:enterFrame()
        local function recurseRender(obj)
            if obj.numChildren ~= nil then
               for i=obj.numChildren, 1, -1 do
                   recurseRender(obj[i]) 
                end -- for
            end -- if
            if obj.render ~= nil then   -- est ce que la methode existe, si oui, appele là
               obj:render() 
            end
        end
        recurseRender(self)
    end
    
    function niveau:gameOver()
        print('game over')
        Runtime:removeEventListener('enterframe', self)
        
        timer.cancel(timerObst) 
        local function recurseKill(obj)
            if obj.numChildren ~= nil then
               for i=obj.numChildren, 1, -1 do
                   recurseKill(obj[i]) 
                end -- for
            end -- if
            if obj.Kill ~= nil then   -- est ce que la methode existe, si oui, appele là
               obj:Kill() 
            end
        end
        recurseKill(self)
        self:removeSelf()        
    end
    
    Runtime:addEventListener('enterFrame', niveau) -- le seul enterframe du jeu, gère les render de obstacle et personnage avec une fonction récursive
    
    return niveau

end
return mNiveau