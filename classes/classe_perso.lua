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
        --self.CBE.listPresets()
        self.radius = 50
        self.circle = display.newCircle(0,0,self.radius)
        self.circle: setFillColor(1,0,0) 
        self:insert(self.circle) -- insère le cercle dans le groupe parce que le cercle et perso sont deus entités différentes


        -- mouvement
        self.currentPos = 2
        self.nextPos = 1
        self.tPositions = {display.contentWidth/2-display.contentWidth/3,display.contentWidth/2,display.contentWidth/2+display.contentWidth/3} -- {128, 384, 640} tableau des coordonnées x des colonnes
        self.vitesse = 5
        self.x = self.tPositions[2] -- set le x à la colonne du centre
        self.endX = self.x
        self.y = display.contentHeight/2+display.contentWidth/10 

        --etat
        self.currentEtat = 1

        --physX
        physics.addBody(self, {density = 1, radius = self.radius, bounce = 1});
        self.gravityScale = 0
        -- physics.setDrawMode('hybrid');
        
        self.vent = self.CBE.newVent({
                preset = "fountain",

                physics = {
                    angles = {{0, 360}},
                    scaleRateX = 0.98,
                    scaleRateY = 0.98,
                    gravityY = 0.3
                }
            })
        --self:changerEtat
        self:toFront()


    end
    function perso:setInterface(interface)
        self.interface = interface    
    end
    
    function perso:changerEtat()
        print('changerEtat')
        if self.currentEtat == 1 then -- 1 rouge
            self.currentEtat = 2
           
        elseif self.currentEtat == 2 then -- 2 vert
            self.currentEtat = 3
          
        elseif self.currentEtat == 3 then -- 3 bleu
            self.currentEtat = 1
             
           
        end
        self:changerCouleur()        

    end
    
    function perso:changerCouleur()
       -- print()
        local tClrs = {0,0,0}
        tClrs[self.currentEtat] = 1
        self.circle: setFillColor(tClrs[1], tClrs[2], tClrs[3])
    end

    function perso:render() -- est appelé à chaque enterFrame
        --self.x = self.tPositions[self.currentPos] -- place son x par rapport a currentPos à l'intérieur de tPositions
        local vx = self.endX - self.x
        self.x = self.x + vx/self.vitesse
        self.vent.emitX = self.x
        self.vent.emitY = self.y
    end
    
    function perso:preCollision(event)
        local obstColl = event.other
        --print(event.other)
        if ( obstColl.currentEtat == self.currentEtat ) or self.y>display.contentHeight then
            if event.contact == nil then
                --fais rien
            else 
                event.contact.isEnabled = false  -- désactive cette collision précise
            end
        end
    end
    
    function perso:collision(e)
        self.interface:cancelTimer()
       
        print('perso',self.parent)
        self.parent:gameOver()
        if e.phase == 'began' then
            self.vent:start()
        elseif e.phase == 'ended' then
            self.vent:stop()
        end
    end
    
    

    perso:init()
    -- écouteurs globaux
    Runtime:addEventListener('collision', perso)
    -- écouteurs locaux 
    perso:addEventListener('preCollision', perso)    
    return perso
end -- mPerso
return mPerso