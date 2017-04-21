-----------------------------------------------------------------------------------------
-- MADE BY GABRIEL CLOUTIER ON 6TH APRIL 2017
-- classe_obstacle.lua
---------------------------------------------------------------------------------------------
local mObstacle={}

function mObstacle:new()
    local obstacle = display.newGroup()
    function obstacle:init() -- init d'un seul obstacle
        -- propriétés locales
        local width = 200 -- largeur d'un obstacle
        local height = 50 -- hauteur d'un obstacle
        local posX = {display.contentWidth/2-display.contentWidth/3,display.contentWidth/2,display.contentWidth/2+display.contentWidth/3} -- {128, 384, 640} sur ipad mini
        local posY = -50
        local colActuelle = math.random(3) -- 1 à 3
        -- mouvement
        self.x = posX[colActuelle]
        self.y = posY
        
        -- rectangle
        self.rect = display.newRect( 0, 0, width, height ) -- représentation graphique de l'obstacle
        self.rect:setFillColor(1,1,1)
        self:insert(self.rect)
        
        -- propriétés
        self.vitesse = 15
        self.alive = true -- boolean qui sert à ne pas appeler la fonction kill si self.alive est true
        
        -- état
        self.currentEtat =  1 -- math.random(3)
        self:setEtat()
        
        -- physX
        physics.addBody(self, {density = 1.0, bounce = 0.3});
        self:setLinearVelocity( 0, 1000 )
        
    end
    
    function obstacle:setEtat()
        if self.currentEtat == 1 then
            self.rect:setFillColor(1,0,0) -- rouge
        elseif self.currentEtat == 2 then
            self.rect:setFillColor(0,1,0) -- vert
        elseif self.currentEtat == 3 then
            self.rect:setFillColor(0,0,1) -- bleu
        else
            print('etat a autre que 1,2,3 thats not normal')
        end
    end
    
    
    function obstacle:render()
        if self.y > display.contentHeight + self.height*2 and self.alive then -- si est en dehors de la hauteur de l'écran + sa propre hauteur, kill()
            --self:kill()
        end
    end
    
    function obstacle:kill()
        self:removeSelf() -- appele la méthode remove self de l'objet
        self.alive = false -- mets la variable bool a false
        print('kill')
    end
    
    obstacle:init()
    return obstacle
end
return mObstacle