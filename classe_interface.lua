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

    function interface:new() -- déclaration de la fonction init
        function circleEtatTouch:init() 
            local circle = display.newCircle(display.contentWidth/2,display.contentHeight/2,100)
            circle: setFillColor(1,1,0.8)
            self:insert(circle)
        end

        function circleEtatTouch:touch(e)
            if e.phase == 'began' then 
                print(perso)
                perso:changerEtat()        
            end -- if began
        end -- touch

    end

    function interface:touch(e) -- appele la fonction render à chaque fois qu'un nouveau frame est créé
        ---print(e)
        if(e.x>display.contentWidth/2) then
            -- print('droite')

        else
            --print('gauche') 
        end
    end


    

    interface:new()
    Runtime:addEventListener('touch', interface) -- fonction qui va éventuellement appeler les render récursivement dans la classe niveau
    circleEtatTouch:init()
    circleEtatTouch:addEventListener('touch', circleEtatTouch) 

    return interface

end
return mInterface