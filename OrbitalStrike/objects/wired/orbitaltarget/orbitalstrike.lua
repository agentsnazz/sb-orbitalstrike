
function goodReception()
  if world.underground(entity.position()) then
    return false
  end
  
  local ll = entity.toAbsolutePosition({ -4.0, 1.0 })
  local tr = entity.toAbsolutePosition({ 4.0, 32.0 })
  
  local bounds = {0, 0, 0, 0}
  bounds[1] = ll[1]
  bounds[2] = ll[2]
  bounds[3] = tr[1]
  bounds[4] = tr[2]
  
  return not world.rectCollision(bounds, true)
end

function init(args)
  entity.setInteractive(true)
  if not goodReception() then
    entity.setAnimationState("beaconState", "idle")
  else
    entity.setAnimationState("beaconState", "active")
  end
end

function onInteraction(args)
  if not goodReception() then
    entity.setAnimationState("beaconState", "idle")
    return { "ShowPopup", { message = "No signal! Please activate on planet surface." } }
  else
    world.logInfo("[ORBITALSTRIKE] Firing Ze Missilez!")
    entity.setAnimationState("beaconState", "active")
    if string.match(entity.configParameter("orbitaltype"), "carpet") then
      for volley=1, entity.configParameter("volleys") do
        for missile=1, entity.configParameter("missiles") do
          -- holy crap this is a bullshit way of staggering the missiles...
          dir = -1 --hard coded "left"
          jitter = math.random(-1 * entity.configParameter("orbitalaccuracy"), entity.configParameter("orbitalaccuracy"))
          xdist = dir * 2 * ( missile + 3 ) + jitter
          ydist = 20 + 2 * ((10 + volley * entity.configParameter("missiles")) + missile)
          world.logInfo("[ORBITALSTRIKE] firing missile " .. volley .. "." .. missile .. ": " .. xdist .. ", " .. ydist)
          world.spawnProjectile(entity.configParameter("projectiletype"), entity.toAbsolutePosition({ xdist, ydist }))
        end
      end
    elseif string.match(entity.configParameter("orbitaltype"), "point") then
      for volley=1, entity.configParameter("volleys") do
        for missile=1, entity.configParameter("missiles") do
          -- holy crap this is a bullshit way of staggering the missiles...
          dir = -1 --hard coded "left"
          jitter = math.random(-1 * entity.configParameter("orbitalaccuracy"), entity.configParameter("orbitalaccuracy"))
          xdist = dir * (25 + jitter)
          ydist = 20 + 2 * ((10 + volley * entity.configParameter("missiles")) + missile)
          world.logInfo("[ORBITALSTRIKE] firing missile " .. volley .. "." .. missile .. ": " .. xdist .. ", " .. ydist)
          world.spawnProjectile(entity.configParameter("projectiletype"), entity.toAbsolutePosition({ xdist, ydist }))
        end
      end
    else
      world.logInfo("[ORBITALSTRIKE] ERROR: invalid orbitaltype")
    end
  end
end

function hasCapability(capability)
  return false
end
