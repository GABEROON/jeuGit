-----------------------------------------------------------------------------------------
--
-- perso.lua
--
-- 
-----------------------------------------------------------------------------------------
local mPerso = {}
function mPerso:new()
    local perso = display.newGroup() -- créer un nouveau display groupe pour le perso

    function perso:init() -- déclaration de la fonction init
        self = display.newCircle(display.contentWidth/2,display.contentHeight/2+display.contentWidth/2,50)
        self: setFillColor(0.9,0.3,0.8)
        print('x')
    end

    function perso:enterFrame() -- appele la fonction render à chaque fois qu'un nouveau frame est créé
       self.render() 
    end

    function perso:render() -- est appelé à chaque enterFrame

    end


    perso.init()
    Runtime:addEventListener('enterFrame', perso) -- fonction qui va éventuellement appeler les render récursivement dans la classe niveau

end