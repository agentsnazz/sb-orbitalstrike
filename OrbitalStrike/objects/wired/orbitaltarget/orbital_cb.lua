
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
    entity.setAnimationState("beaconState", "active")
    world.spawnProjectile("carpetbomb", entity.toAbsolutePosition({ -15.0, 100.0 }))
    world.spawnProjectile("carpetbomb", entity.toAbsolutePosition({ -20.0, 100.0 }))
    world.spawnProjectile("carpetbomb", entity.toAbsolutePosition({ -25.0, 100.0 }))
    world.spawnProjectile("carpetbomb", entity.toAbsolutePosition({ -30.0, 100.0 }))
    world.spawnProjectile("carpetbomb", entity.toAbsolutePosition({ -35.0, 100.0 }))
    world.spawnProjectile("carpetbomb", entity.toAbsolutePosition({ -40.0, 100.0 }))
    -- entity.smash()
    -- world.spawnMonster("penguinUfo", entity.toAbsolutePosition({ 0.0, 32.0 }), { level = 1 })
  end
end

function hasCapability(capability)
  return false
end
