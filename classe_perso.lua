-----------------------------------------------------------------------------------------
--
-- perso.lua
--
-----------------------------------------------------------------------------------------
local mPerso = {}
function mPerso:new()
    local perso = display.newGroup() -- créer un nouveau display groupe pour le perso
    function perso:init() -- déclaration de la fonction init
        -- graphique 
        self.CBE = require("CBE.CBE")
        --local particleDesigner = require('particleDesigner')
        --local emitter = particleDesigner.newEmitter('emitter.rg')

        self.CBE.listPresets()
        -- emitter.x = self.x
        self.circle = display.newCircle(0,0,50)
        self.circle: setFillColor(0.9,0.3,0.8) 
        self:insert(self.circle) -- insère le cercle dans le groupe parce que le cercle et perso sont deus entités différentes
        --self:insert(emitter) -- insère le cercle dans le groupe parce que le cercle et perso sont deus entités différentes

        -- mouvement
        self.currentPos = 2
        self.nextPos = 1
        self.tPositions = {display.contentWidth/2-display.contentWidth/3,display.contentWidth/2,display.contentWidth/2+display.contentWidth/3} -- {128, 384, 640} tableau des coordonnées x des colonnes
        self.vitesse = 5
        self.x = self.tPositions[2] -- set le x à la colonne du centre
        self.endX = self.x
        self.y = display.contentHeight/2+display.contentWidth/2        
        -- etat
        -- self.tEtat = {1,2,3}
        self.currentEtat = 1

        self.vent = self.CBE.newVent({
                preset = "fountain",

                physics = {
                    angles = {{80, 100}},
                    scaleRateX = 0.98,
                    scaleRateY = 0.98,
                    gravityY = 0.3
                }
            })
        


    end

    function perso:changerEtat()
        if self.currentEtat == 3 then
            self.currentEtat = self.currentEtat -2
            self.circle: setFillColor(0.6,0.1,0.2) 
        elseif self.currentEtat == 2 then
            self.currentEtat = self.currentEtat+1 
            self.circle: setFillColor(0.1,0.9,0.3) 
        elseif self.currentEtat == 1 then
            self.currentEtat = self.currentEtat+1 
            self.circle: setFillColor(0.7,0.2,0.6) 
        end


    end


    function perso:enterFrame() -- appele la fonction render à chaque fois qu'un nouveau frame est créé
        self:render()

    end

    function perso:render() -- est appelé à chaque enterFrame
        --self.x = self.tPositions[self.currentPos] -- place son x par rapport a currentPos à l'intérieur de tPositions
        local vx = self.endX - self.x
        self.x = self.x + vx/self.vitesse
        self.vent.emitX = self.x
        self.vent.emitY = self.y

    end
    function perso:touch(e) -- appele la fonction render à chaque fois qu'un nouveau frame est créé

        self.vent:start()

        if e.phase == 'began' then -- si le click commence, alors
            local vx = e.x - display.contentWidth/2 -- déclare un vecteur qui est le x du click - le centre de l'écran
            if vx ~= 0 then -- évite une erreur quand on click directemment dans le centre
                self.nextPos = vx/math.abs(vx) -- la prochaine position dans le tableau est égal à vx / |vx| renvoie 1 ou -1
                if self.currentPos + self.nextPos > 3 or self.currentPos + self.nextPos < 1 then -- si la position actuelle est plus grande que 3 ou plus petite que 1
                    self.nextPos = 0 -- mets la prochaine à position à 0, (currentPos + 0 = 0)
                end
                self.currentPos = self.currentPos + self.nextPos
                self.endX = self.tPositions[self.currentPos]
                print(self.endX)
            else
                vx = 1
            end


        end -- if

        --    if e.phase == 'began' then
        --        if(e.x>display.contentWidth/2) then
        --           
        --            if self.currentPos ~= 3 then
        --                self.currentPos = self.currentPos + 1
        --            end
        --        elseif(e.x<display.contentWidth/2) then
        --
        --            if self.currentPos ~= 1 then
        --                self.currentPos = self.currentPos - 1
        --            end
        --        else -- si usager clique au centre
        --            print('centre')
        --        end -- if
        --    end -- if

    end -- function
    perso:init()
    Runtime:addEventListener('enterFrame', perso) 
    Runtime:addEventListener('touch', perso) 
    return perso
end -- mPerso
return mPerso