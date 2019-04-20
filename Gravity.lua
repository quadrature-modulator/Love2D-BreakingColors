Gravity={}
local tilemap = require 'tilemap'
funtion loop()

   for i =0, tilemap.width-1 do 


    for j=0,tilemap.height-2 do
        if tilemap.get(i,j-1).type ==0 then
            repeat 
                for i =0, tilemap.width-1 do 


                    for j=0,tilemap.height-2 do
                        if tilemap.get(i,j-1).type ==0
            
        end
   end
    end
   
 
end
Gravity.fall = funtion()
     
end
return Gravity