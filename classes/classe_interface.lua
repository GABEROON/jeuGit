-----------------------------------------------------------------------------------------
-- MADE BY GABRIEL CLOUTIER
-- classe_interface.lua
--
-- !important display.newImageRect( [parent,] filename, [baseDir,] width, height ) pour les images
-----------------------------------------------------------------------------------------
local mInterface = {}
function mInterface:new(perso)
    local mCircleEtatTouch = require('classes.classe_CircleEtatTouch')
    local circleEtatTouch = mCircleEtatTouch:new(perso, obstacle)
    
    local interface = display.newGroup() -- créer un nouveau display groupe pour le interface
    interface:insert(circleEtatTouch)
--    local test = display.newImageRect('test.png',200,200)
--    test.fill.effect = "filter.invert"
--    test.fill.effect = "filter.sobel"
--    test.x = display.contentWidth/2
--    test.y = display.contentHeight/2
    function interface:new() -- déclaration de la fonction init
       
        --score
        self.startScore = 0
        self.currentScore = self.startScore
       
        self.inArow = 1
        self.timerInc = 1
        self.scoreCurrentMultiplier = 1
        self.tScoreMultiplier = {5,10,20,50,100,500,1000,1500,5000,10000}
        self.scoreObst = self.tScoreMultiplier[self.scoreCurrentMultiplier]
        
        self.scText = display.newText('Score:'..self.currentScore,125,50,native.system)
        self.scText:setFillColor( 1, 1, 1 )
        
        local function scoreTimer()
            self.currentScore = self.currentScore + 1
            self.scText.text = self.currentScore
            
        end
        
        self.timerScore = timer.performWithDelay(20, scoreTimer, -1)
        
        
        
    end -- interface:new
    
    function interface:cancelTimer()
        timer.cancel(self.timerScore) 
    end
    
    function interface:resetInArow()
       self.inArow = 1
    end
    
    function interface:checkScore()
        --print('checkScore called')
        self.inArow = self.inArow + 1/5
        print('self.inArow = ', self.inArow)
        self.timerInArow = timer.performWithDelay(1000, resetInArow, 1)
        if self.inArow >= 1 and self.inArow >= 5 then
           self.scoreCurrentMultiplier = 1 
        elseif self.inArow >= 6 and self.inArow >= 10 then
           self.scoreCurrentMultiplier = 2
        elseif self.inArow >= 11 and self.inArow >= 20 then
           self.scoreCurrentMultiplier = 3 
        elseif self.inArow >= 21 and self.inArow >= 40 then
           self.scoreCurrentMultiplier = 4
        elseif self.inArow >= 41 and self.inArow >= 70 then
           self.scoreCurrentMultiplier = 5
        elseif self.inArow >= 71 and self.inArow >= 90 then
           self.scoreCurrentMultiplier = 6
        elseif self.inArow >= 91 and self.inArow >= 110 then
           self.scoreCurrentMultiplier = 7
        elseif self.inArow >= 111 and self.inArow >= 130 then
           self.scoreCurrentMultiplier = 8
        elseif self.inArow >= 131 and self.inArow >= 150 then
           self.scoreCurrentMultiplier = 9
        elseif self.inArow >= 151 and self.inArow >= 170 then
           self.scoreCurrentMultiplier = 10 
        end
        interface:scoreAdd()
    end
    
   
    
    function interface:scoreAdd()
        self.currentScore = self.currentScore + self.scoreObst
    end

    function interface:touch(e) -- appele la fonction render à chaque fois qu'un nouveau frame est créé
        
        if e.phase == 'began' and circleEtatTouch.touchBool == false then -- si le click commence et que le click sur circleEtatTouc est false,
            local vx = e.x - perso.x -- déclare un vecteur qui est le x du click - le centre de l'écran
            if vx ~= 0 then -- évite une erreur quand on click directemment dans le centre
                perso.nextPos = vx/math.abs(vx) -- la prochaine position dans le tableau est égal à vx / |vx| renvoie 1 ou -1
                if perso.currentPos + perso.nextPos > 3 or perso.currentPos + perso.nextPos < 1 then -- si la position actuelle est plus grande que 3 ou plus petite que 1
                    perso.nextPos = 0 -- mets la prochaine à position à 0, (currentPos + 0 = 0)
                end
                perso.currentPos = perso.currentPos + perso.nextPos
                perso.endX = perso.tPositions[perso.currentPos]
            else
                vx = 1
            end

        end -- if
    end
    
    function interface:Kill()
        self:removeSelf() 
        Runtime:removeEventListener('touch', interface) -- fonction qui va éventuellement appeler les render récursivement dans la classe niveau
        --circleEtatTouch:Kill() -- appelle la méthode kill de là parce que le recurseKill de niveau ne se rend pas à circleEtatTouch
    end


    

    interface:new()
    Runtime:addEventListener('touch', interface) -- fonction qui va éventuellement appeler les render récursivement dans la classe niveau
    

    return interface

end
return mInterface