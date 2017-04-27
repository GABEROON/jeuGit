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

    
    
    
    local timerRythm = 400
    local timerObst
    
    local function spawn()
        local obstacle = mObstacle:new()--self:spawn()
        
        -- print('timer rythm en dedans', timerRythm)
        niveau:insert(obstacle)
    
    end
    
    local function update()
        if timerObst ~= nil then
            timer.cancel(timerObst)    
        end
        if timerRythm >= 200 then
            timerRythm = timerRythm - 1
        end
        
       
        timerObst = timer.performWithDelay(timerRythm,function () spawn() update()  end,-1) -- à chaque seconde, appelle la fonction spawn et répète à l'infini    
    end
    
    update()
    
    
    
    
   
    
    self.gameOverBool = false
    

    local mInterface = require('classes.classe_interface')
    local interface = mInterface:new(perso, obstacle)
    perso:setInterface(interface)
    niveau:insert(interface)
        
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
        
        self.gameOverBool = true
        -- print('numChildren debut', self.numChildren)
        timer.cancel(timerObst) 
--        perso:kill()
--        interface:kill()
        local function recurseKill(obj)
            if obj.numChildren ~= nil then
               for i=obj.numChildren, 1, -1 do
                   recurseKill(obj[i]) 
                end -- for
            end -- if
            if obj.kill ~= nil then   -- est ce que la methode existe, si oui, appele là
               obj:kill() 
            end
        end
        
        --self:removeSelf()
        Runtime:removeEventListener('touch', interface)
        Runtime:removeEventListener('enterframe', self)
        Runtime:removeEventListener('enterFrame', niveau)
        recurseKill(self)
        -- print('numChildren fin', self.numChildren)
        local againTimer = function() return self:startAgain() end
        timer.performWithDelay( 1100, againTimer, 1 ) 
    end -- gamveOver end
    
    function niveau:startAgain()
        if self.gameOverBool then
           --  print('start again')
            mNiveau:new()
        else
            
        end
    end
    
    Runtime:addEventListener('enterFrame', niveau) -- le seul enterframe du jeu, gère les render de obstacle et personnage avec une fonction récursive
    
    return niveau

end
return mNiveau