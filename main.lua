-----------------------------------------------------------------------------------------
-- MADE BY GABRIEL CLOUTIER ON 6TH APRIL 2017
-- main.lua
--
-- !important display.newImageRect( [parent,] filename, [baseDir,] width, height ) pour les images
-- arrayIndex =((arrayIndex+1)%3)+1 -- permet de naviguer de 3,2,1
-- self.fonction() C'EST MAL ----> self:fonction ---> C'EST BIEN
-- https://coronalabs.com/blog/2014/03/25/tutorial-using-particle-designer-in-corona/
-- http://onebyonedesign.com/flash/particleeditor/
-----------------------------------------------------------------------------------------

-- local machineInterface = require('classe_interface')
-- local machinePerso = require('classe_perso')

--creation de l'interface
--print(machineInterface)
--local monInterface = machineInterface:new()
-- creation d'un ogre
--local monPerso = machineOgre:new()
local circleEtatTouch = display.newGroup() -- créer un nouveau display pour le cercle de collision
local perso = display.newGroup() -- créer un nouveau display groupe pour le perso
local obstacle = display.newGroup() -- créer un nouveau display groupe obstacle


------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- ETAT TOUCH -----------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
function circleEtatTouch:init() 
    local circle = display.newCircle(display.contentWidth/2,display.contentHeight/2,200)
    circle: setFillColor(1,1,0.8)
    self:insert(circle)
end

function circleEtatTouch:touch(e)
    if e.phase == 'began' then 
        perso:changerEtat()        
    end -- if began
end -- touch


------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- OBSTACLE -----------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
function obstacle:init()
    print('init')
    
    timer.performWithDelay(1000,self:spawn(),-1)
    
end
function obstacle:spawn()
    print('spawn')
    
    local posX = {display.contentWidth/2-display.contentWidth/3,display.contentWidth/2,display.contentWidth/2+display.contentWidth/3} -- {128, 384, 640}
    local posY = math.random(150) -- 1 à 150
    local colActuelle = math.random(3) -- 1 à 3
    local width = 200
    local height = 50
    self.rect = display.newRect( posX[colActuelle], posY, width, height )
    self.rect:setFillColor(1,1,1)
    self:insert(self.rect)
    self.vitesse = 15
    self.alive = true
end
function obstacle:enterFrame()
    if self.alive then --si l'obstacle existe
        obstacle:render()
    end
end
function obstacle:render()
    self.y = self.y + self.vitesse
    if self.y > display.contentHeight + self.height and self.alive then -- si est en dehors de la hauteur de l'écran + sa propre hauteur, kill()
        obstacle:kill()
    end
end
function obstacle:kill()
    self:removeSelf()
    self.alive = false
    print('kill')
end

------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------ PERSO -----------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------

function perso:init() -- déclaration de la fonction init
    -- graphique 
    self.circle = display.newCircle(0,display.contentHeight/2+display.contentWidth/2,50)
    self.circle: setFillColor(0.9,0.3,0.8) 
    self:insert(self.circle) -- insère le cercle dans le groupe parce que le cercle et perso sont deus entités différentes
    -- mouvement
    self.currentPos = 2
    self.tPositions = {display.contentWidth/2-display.contentWidth/3,display.contentWidth/2,display.contentWidth/2+display.contentWidth/3} -- {128, 384, 640}
    self.vitesse = 40

    -- etat
    self.tEtat = {1,2,3}
    self.currentEtat = 1
    

   
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
    self.x = self.tPositions[self.currentPos] -- place son x par rapport a currentPos à l'intérieur de tPositions
   
end
function perso:touch(e) -- appele la fonction render à chaque fois qu'un nouveau frame est créé
    if e.phase == 'began' then
        if(e.x>display.contentWidth/2) then
           
            if self.currentPos ~= 3 then
                self.currentPos = self.currentPos + 1
            end
        elseif(e.x<display.contentWidth/2) then

            if self.currentPos ~= 1 then
                self.currentPos = self.currentPos - 1
            end
        else -- si usager clique au centre
            print('centre')
        end -- if
    end -- if
end -- function

------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------ RUNTIME ET INIT -------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------


-- interface:init()



perso:init()
obstacle:init()

circleEtatTouch:init()

Runtime:addEventListener('enterFrame', perso) 
Runtime:addEventListener('enterFrame', obstacle) 
Runtime:addEventListener('touch', perso) 
circleEtatTouch:addEventListener('touch', circleEtatTouch) 


