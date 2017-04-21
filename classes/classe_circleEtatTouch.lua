-----------------------------------------------------------------------------------------
-- MADE BY GABRIEL CLOUTIER
-- classe_circleEtatTouch.lua
--
-- !important display.newImageRect( [parent,] filename, [baseDir,] width, height ) pour les images
-----------------------------------------------------------------------------------------
local mCircleEtatTouch = {}
function mCircleEtatTouch:new(perso)
    local circleEtatTouch = display.newGroup() -- créer un nouveau display pour le cercle de collision

    function circleEtatTouch:init() 
        local circle = display.newCircle(display.contentWidth/2,display.contentHeight/2+400,100)
        circle: setFillColor(1,1,0.01)
        --circle.alpha = 0
        self:insert(circle)
        
        circleEtatTouch.touchBool = false -- sert à vérifier si l'usager clique sur le cercle ou non, commence a false parce que l'usager ne click pas dessus constamment
        
    end

    function circleEtatTouch:touch(e)
        if e.phase == 'began' then 
            circleEtatTouch.touchBool = true
         
            perso:changerEtat()        
        elseif e.phase == 'ended' then
            circleEtatTouch.touchBool = false
        end -- if began
    end -- touch

    function circleEtatTouch:Kill()
        self:removeEventListener('touch', circleEtatTouch)   
        self:removeSelf()
        
       
        
    end

    function print_r ( t ) 
        local print_r_cache={}
        local function sub_print_r(t,indent)
            if (print_r_cache[tostring(t)]) then
                print(indent.."*"..tostring(t))
            else
                print_r_cache[tostring(t)]=true
                if (type(t)=="table") then
                    for pos,val in pairs(t) do
                        if (type(val)=="table") then
                            print(indent.."["..pos.."] => "..tostring(t).." {")
                            sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                            print(indent..string.rep(" ",string.len(pos)+6).."}")
                        else
                            print(indent.."["..pos.."] => "..tostring(val))
                        end
                    end
                else
                    print(indent..tostring(t))
                end
            end
        end
        sub_print_r(t,"  ")
    end

    circleEtatTouch:init()
    circleEtatTouch:addEventListener('touch', circleEtatTouch)   

    return circleEtatTouch

end
return mCircleEtatTouch