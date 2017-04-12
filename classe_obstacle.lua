local mObstacle={}

function mObstacle:new()
    local obstacle = display.newGroup()
    function obstacle:init()
        --print('spawn')
        local width = 200 -- largeur d'un obstacle
        local height = 50 -- hauteur d'un obstacle
        local posX = {display.contentWidth/2-display.contentWidth/3,display.contentWidth/2,display.contentWidth/2+display.contentWidth/3} -- {128, 384, 640} sur ipad mini
        local posY = -50
        local colActuelle = math.random(3) -- 1 à 3
        
        self.rect = display.newRect( posX[colActuelle], posY, width, height ) -- représentation graphique de l'obstacle
        self.rect:setFillColor(1,1,1)
        self:insert(self.rect)
        self.vitesse = 15
        self.alive = true -- boolean qui sert à ne pas appeler la fonction kill si self.alive est true
    end
    function obstacle:enterFrame()
        if self.alive then --si l'obstacle existe
            obstacle:render()
        end
    end
    function obstacle:render()
        self.y = self.y + self.vitesse -- déplacement de l'obstacle selon sa vitesse
        if self.y > display.contentHeight + self.height*2 and self.alive then -- si est en dehors de la hauteur de l'écran + sa propre hauteur, kill()
            self:kill()
        end
    end
    function obstacle:kill()
        self:removeSelf() -- appele la méthode remove self de l'objet
        self.alive = false -- mets la variable bool a false
        --print('kill()')
    end
    obstacle:init()
    Runtime:addEventListener('enterFrame', obstacle)
    return obstacle
end
return mObstacle