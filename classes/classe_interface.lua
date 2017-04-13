-----------------------------------------------------------------------------------------
--
-- classe_interface.lua
--
-- !important display.newImageRect( [parent,] filename, [baseDir,] width, height ) pour les images
-----------------------------------------------------------------------------------------
local mInterface = {}
function mInterface:new(perso)
    local circleEtatTouch = display.newGroup() -- créer un nouveau display pour le cercle de collision
    local interface = display.newGroup() -- créer un nouveau display groupe pour le interface
    local test = display.newImageRect('test.png',200,200)
    test.fill.effect = "filter.invert"
    test.fill.effect = "filter.sobel"
    test.x = display.contentWidth/2
    test.y = display.contentHeight/2
    function interface:new() -- déclaration de la fonction init
        --score
        self.startScore = 0
        self.currentScore = self.startScore
        
        function circleEtatTouch:init() 
            local circle = display.newCircle(display.contentWidth/2,display.contentHeight/2+400,100)
            circle: setFillColor(0.01,0.01,0.01)
            --circle.alpha = 0
            self:insert(circle)
            
            
        end

        function circleEtatTouch:touch(e)
            if e.phase == 'began' then 
               -- print(perso)
                perso:changerEtat()        
            end -- if began
        end -- touch

    end

    function interface:touch(e) -- appele la fonction render à chaque fois qu'un nouveau frame est créé
        
        if e.phase == 'began' then -- si le click commence, alors
            local vx = e.x - display.contentWidth/2 -- déclare un vecteur qui est le x du click - le centre de l'écran
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


    

    interface:new()
    Runtime:addEventListener('touch', interface) -- fonction qui va éventuellement appeler les render récursivement dans la classe niveau
    circleEtatTouch:init()
    circleEtatTouch:addEventListener('touch', circleEtatTouch) 

    return interface

end
return mInterface