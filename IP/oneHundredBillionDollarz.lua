--[[
Author: Joey Brown
Class: CSC 442, Digitial Image Processing
Asgmnt: PA #2
Description: 

Acknowledgements:
  * 
--]]

require "ip"
local viz = require "visual"
local il = require "il"

local imgs = {...}
for i, fname in ipairs(imgs) do loadImage(fname) end


---------------
-- functions --
---------------

-- average the pixels with a 440x160 mask to get the index value

-- average the pixels with a 260x210 mask to get the color of the solution

-- create a lookup table with the average color values mapped to parameter values mapped 

local function getpH( img )
  -- convert to grayscale to measure intensities
  img = il.RGB2YIQ( img )
  
  -- array/table of location centers (x,y)
  local locationX= {}
  local locationY= {}
  -- 6.0
  table.insert(locationX, 1427)
  table.insert(locationY, 1419)
  -- 6.4
  table.insert(locationX, 1409)
  table.insert(locationY, 1727)
  -- 6.6
  table.insert(locationX, 1411)
  table.insert(locationY, 2043)
  -- 6.8
  table.insert(locationX, 1415)
  table.insert(locationY, 2351)
  -- 7.0
  table.insert(locationX, 1409)
  table.insert(locationY, 2661)
  -- 7.2
  table.insert(locationX, 1397)
  table.insert(locationY, 2977)
  -- 7.6
  table.insert(locationX, 1393)
  table.insert(locationY, 3303)
  -- Test solution
  table.insert(locationX, 2001)
  table.insert(locationY, 3221)
  
  -- get average neighborhood intensities and store in array
  local avg = {}
  -- iterate through location array and average the neighborhoods.
  -- Store results in avg array.
  for loc = 1, 8 do
    local sum = 0
    
    -- mask = 81x81
    for i = (locationX[loc]-40), (locationX[loc]+40) do
      for j = (locationY[loc]-40), (locationY[loc]+40) do
        -- columns and rows of the image data are swapped in Paint
        sum = sum + img:at(j,i).y
      end
    end
    
    -- calculate average
    sum = (sum / (81*81*255))*255
    
    -- store average in avg array
    avg[loc] = sum
    --print(avg[loc])
  end  
  
  -- create LUT for index and fill it with corresponding average values.
  -- Whichever average has the smallest different between the index and the solution is the match
  --[[local pHIndex = {
      [ 6.0 ] =  avg[1] ,
      [ 6.4 ] =  avg[2] ,
      [ 6.6 ] =  avg[3] ,
      [ 6.8 ] =  avg[4] ,
      [ 7.0 ] =  avg[5] ,
      [ 7.2 ] =  avg[6] ,
      [ 7.6 ] =  avg[2] 
    }
    --]]
    
    local pHIndex = {
      [ avg[1] ] =  6.0 ,
      [ avg[2] ] =  6.4 ,
      [ avg[3] ] =  6.6 ,
      [ avg[4] ] =  6.8 ,
      [ avg[5] ] =  7.0 ,
      [ avg[6] ] =  7.2 ,
      [ avg[7] ] =  7.6
    }
  
  local test = avg[8]
  local pH = 110
  local min, max = avg[7], avg[1]
  -- check for highest
  if max < test then
    pH = pHIndex[max]
  -- check for lowest
  elseif min > test then
    pH = pHIndex[avg[7]]
  else
    for h = 2, 6 do
      if avg[h] < avg[8] then
        pH = pHIndex[avg[h-1]]
      end
      
    end
  end
  
  
  print("Your pH is: ", pH)
  
  return il.YIQ2RGB( img )
end
--------------------------------------

local function getAmmonia( img )
  -- convert to grayscale to measure intensities
  img = il.RGB2YIQ( img )
  
  -- array/table of location centers (x,y)
  local locationX= {}
  local locationY= {}
  -- 0.0
  table.insert(locationX, 1519)
  table.insert(locationY, 1541)
  -- 0.25
  table.insert(locationX, 1555)
  table.insert(locationY, 1807)
  -- 0.50
  table.insert(locationX, 1547)
  table.insert(locationY, 2343)
  -- 1.0
  table.insert(locationX, 1523)
  table.insert(locationY, 2343)
  -- 2.0
  table.insert(locationX, 1409)
  table.insert(locationY, 2661)
  -- 4.0
  table.insert(locationX, 1533)
  table.insert(locationY, 2621)
  -- 8.0
  table.insert(locationX, 1421)
  table.insert(locationY, 3149)
  -- Test solution
  table.insert(locationX, 2000)
  table.insert(locationY, 3070)
  
  -- get average neighborhood intensities and store in array
  local avg = {}
  -- iterate through location array and average the neighborhoods.
  -- Store results in avg array.
  for loc = 1, 8 do
    local sum = 0
    
    -- mask = 81x81
    for i = (locationX[loc]-40), (locationX[loc]+40) do
      for j = (locationY[loc]-40), (locationY[loc]+40) do
        -- columns and rows of the image data are swapped in Paint
        sum = sum + img:at(j,i).y
      end
    end
    
    -- calculate average
    sum = (sum / (81*81*255))*255
    
    -- store average in avg array
    avg[loc] = sum
    --print(avg[loc])
  end  
  
  local ammoniaIndex = {
      [ avg[1] ] =  0.0 ,
      [ avg[2] ] =  0.25 ,
      [ avg[3] ] =  0.50 ,
      [ avg[4] ] =  1.00 ,
      [ avg[5] ] =  2.00 ,
      [ avg[6] ] =  4.00 ,
      [ avg[7] ] =  8.00
  }
  
  local test = avg[8]
  local ammonia = 110
  local min, max = avg[7], avg[1]
  -- check for highest
  if max < test then
    ammonia = ammoniaIndex[max]
  -- check for lowest
  elseif min > test then
    ammonia = ammoniaIndex[avg[7]]
  else
    for h = 2, 6 do
      if avg[h] < avg[8] then
        ammonia = ammoniaIndex[avg[h-1]]
      end
      
    end
  end
  
  
  print("Your Ammonia is: ", ammonia, " ppm")
  
  return il.YIQ2RGB( img )
end
--------------------------------------


local function getNitrite( img )
  -- convert to grayscale to measure intensities
  img = il.RGB2YIQ( img )
  
  -- array/table of location centers (x,y)
  local locationX= {}
  local locationY= {}
  -- 0.0
  table.insert(locationX, 214)
  table.insert(locationY, 108)
  -- 0.25
  table.insert(locationX, 238)
  table.insert(locationY, 374)
  -- 0.50
  table.insert(locationX, 243)
  table.insert(locationY, 650)
  -- 1.0
  table.insert(locationX, 250)
  table.insert(locationY, 880)
  -- 2.0
  table.insert(locationX, 220)
  table.insert(locationY, 1140)
  -- 5.0
  table.insert(locationX, 210)
  table.insert(locationY, 1390)
  -- Test Solution
  table.insert(locationX, 580)
  table.insert(locationY, 1550)
  
  -- get average neighborhood intensities and store in array
  local avg = {}
  -- iterate through location array and average the neighborhoods.
  -- Store results in avg array.
  for loc = 1, 7 do
    local sum = 0
    
    -- mask = 81x81
    for i = (locationX[loc]-10), (locationX[loc]+10) do
      for j = (locationY[loc]-10), (locationY[loc]+10) do
        -- columns and rows of the image data are swapped in Paint
        sum = sum + img:at(j,i).y
      end
    end
    
    -- calculate average
    sum = (sum / (21*21*255))*255
    
    -- store average in avg array
    avg[loc] = sum
    --print(avg[loc])
  end  
  
  local ammoniaIndex = {
      [ avg[1] ] =  0.0 ,
      [ avg[2] ] =  0.25 ,
      [ avg[3] ] =  0.50 ,
      [ avg[4] ] =  1.00 ,
      [ avg[5] ] =  2.00 ,
      [ avg[6] ] =  5.00
  }
  
  local test = avg[7]
  local ammonia = 110
  local min, max = avg[6], avg[1]
  -- check for highest
  if max < test then
    ammonia = ammoniaIndex[max]
  -- check for lowest
  elseif min > test then
    ammonia = ammoniaIndex[avg[6]]
  else
    for h = 2, 5 do
      if avg[h] < avg[7] then
        ammonia = ammoniaIndex[avg[h-1]]
      end
      
    end
  end
  
  
  print("Your Nitrite is: ", ammonia, " ppm")
  
  return il.YIQ2RGB( img )
end
-------------------------------------------


local function dSlick( img )
  -- convert to grayscale to measure intensities
  img = il.RGB2YIQ( img )
  
  -- array/table of location centers (x,y)
  local locationX= {}
  local locationY= {}
  -- 0.0
  table.insert(locationX, 445)
  table.insert(locationY, 110)
  -- 0.25
  table.insert(locationX, 525)
  table.insert(locationY, 325)
  -- 0.50
  table.insert(locationX, 430)
  table.insert(locationY, 560)
  -- 1.0
  table.insert(locationX, 430)
  table.insert(locationY, 765)
  -- 2.0
  table.insert(locationX, 440)
  table.insert(locationY, 990)
  -- 4.0
  table.insert(locationX, 440)
  table.insert(locationY, 1200)
  -- 8.0
  table.insert(locationX, 520)
  table.insert(locationY, 1410)
  -- Test solution
  table.insert(locationX, 190)
  table.insert(locationY, 1400)
  
  -- get average neighborhood intensities and store in array
  local avg = {}
  -- iterate through location array and average the neighborhoods.
  -- Store results in avg array.
  for loc = 1, 8 do
    local sum = 0
    
    -- mask = 81x81
    for i = (locationX[loc]-40), (locationX[loc]+40) do
      for j = (locationY[loc]-40), (locationY[loc]+40) do
        -- columns and rows of the image data are swapped in Paint
        sum = sum + img:at(j,i).y
      end
    end
    
    -- calculate average
    sum = (sum / (81*81*255))*255
    
    -- store average in avg array
    avg[loc] = sum
    print(avg[loc])
  end  
  
  local ammoniaIndex = {
      [ avg[1] ] =  0.0 ,
      [ avg[2] ] =  0.25 ,
      [ avg[3] ] =  0.50 ,
      [ avg[4] ] =  1.00 ,
      [ avg[5] ] =  2.00 ,
      [ avg[6] ] =  4.00 ,
      [ avg[7] ] =  8.00
  }
  
  local test = avg[8]
  local ammonia = -1
  local min, max = avg[7], avg[1]
  -- check for highest
  if max < test then
    ammonia = ammoniaIndex[max]
  -- check for lowest
  elseif min > test then
    ammonia = ammoniaIndex[min]
  else
    for h = 1, 7 do
      if test > avg[h] then
        ammonia = ammoniaIndex[avg[h-1]]
        break
      end
      
    end
  end
  
  
  print("Your Ammonia is: ", ammonia, " ppm")
  
  return il.YIQ2RGB( img )
end

----------
-- menus--
----------

imageMenu("Read Parameters", 
  {
    {"pH", getpH},
    {"Ammonia", getAmmonia},
    {"Nitrite", getNitrite},
    {"D-Slick's Ammonia", dSlick}
  }
)


start()