-----------------------------------------------------------------------------------------
--
-- classe_interface.lua
--
-- !important display.newImageRect( [parent,] filename, [baseDir,] width, height ) pour les images
-----------------------------------------------------------------------------------------
local mInterface = {}
function mInterface:new()
    local interface = display.newGroup() -- créer un nouveau display groupe pour le interface

    function interface:init() -- déclaration de la fonction init
       
    end

    function interface:touch(e) -- appele la fonction render à chaque fois qu'un nouveau frame est créé
       ---print(e)
        if(e.x>display.contentWidth/2) then
            print('droite')

        else
           print('gauche') 
        end
    end




    interface.init()
    Runtime:addEventListener('touch', interface) -- fonction qui va éventuellement appeler les render récursivement dans la classe niveau

end