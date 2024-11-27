local playerAddiction = {}

RegisterNetEvent('updateAddiction')
AddEventHandler('updateAddiction', function(data)
    playerAddiction = data
end)

local itemLabels = {
    ['coke_pure'] = {label = 'Kokainas', icon = 'cubes-stacked'},
    ['bluedream_joint'] = {label = 'Marihuana', icon = 'cannabis'}, 
    ['purplehaze_joint'] = {label = 'Marihuana', icon = 'cannabis'}, 

}

RegisterCommand('narkotikai', function()
    local contextOptions = {
        id = 'addiction_menu',
        title = 'Narkotikų priklausomybė',
        options = {}
    }

    if next(playerAddiction) == nil then
        table.insert(contextOptions.options, {
            title = 'Jūsų organizmas švarus',
            description = 'Šiuo metu jūs nesate priklausomas jokiai psichoaktyviai medžiagai !',
            icon = 'user-check',
            iconColor = '#17DB82'
        })
    else
        for item, percent in pairs(playerAddiction) do
            local itemData = itemLabels[item] or {label = item, icon = 'question-circle'}
            table.insert(contextOptions.options, {
                title = itemData.label,
                description = "Šiam narkotikui jūs esate priklausomas ".. percent .. "%",
                icon = itemData.icon,
                progress = percent,
                colorScheme = '#FA5252'
            })
        end
    end

    lib.registerContext(contextOptions)
    lib.showContext('addiction_menu')
end)

InitCubes = function()
  for i=1,50,1 do
    local r = math.random(5,255)
    local g = math.random(5,255)
    local b = math.random(5,255)
    local a = math.random(50,100)

    local x = math.random(1,180)
    local y = math.random(1,359)
    local z = math.random(15,35)

    Cubes[i] = {pos=PointOnSphere(x,y,z),points={x=x,y=y,z=z},col={r=r, g=g, b=b, a=a}}
  end  
  --local playerPed = PlayerPedId()
  --SetPedIsDrunk(playerPed, true)
  --ShakeGameplayCam('DRUNK_SHAKE', 1.0) 
  --SetTimecycleModifierStrength(0.0) 
  --SetTimecycleModifier("BikerFilter")
  SetPedMotionBlur(GetPlayerPed(-1), true)

  local counter = 4000
  local tick = 0
  while tick < counter do
    tick = tick + 1
    local plyPos = GetEntityCoords(GetPlayerPed(-1))
    local adder = 0.1 * (tick/40)
    --SetTimecycleModifierStrength(math.min(0.1 * (tick/(counter/40)),1.5))
    ShakeGameplayCam('DRUNK_SHAKE', math.min(0.1 * (tick/(counter/40)),1.5))  
    for k,v in pairs(Cubes) do
      local pos = plyPos + v.pos
      DrawBox(pos.x+adder,pos.y+adder,pos.z+adder,pos.x-adder,pos.y-adder,pos.z-adder, v.col.r,v.col.g,v.col.g,v.col.a)
      local points = {x=v.points.x+0.1,y=v.points.y+0.1,z=v.points.z}
      Cubes[k].points = points
      Cubes[k].pos = PointOnSphere(points.x,points.y,points.z)
    end
    Wait(0)
  end
end

DrawCubes = function()
  local position = GetEntityCoords(GetPlayerPed(-1))
  local adder = 10
  for k,v in pairs(Cubes) do
    local addX = 0.1
    local addY = 0.1

    if k%4 == 0 then
      addY = -0.1
    elseif k%3 == 0 then
      addX = -0.1
    elseif k%2 == 0 then
      addX = -0.1
      addY = -0.1
    end

    local pos = position + v.pos
    DrawBox(pos.x+adder,pos.y+adder,pos.z+adder,pos.x-adder,pos.y-adder,pos.z-adder, v.col.r,v.col.g,v.col.g,v.col.a)
    local points = {x=v.points.x+addX,y=v.points.y+addY,z=v.points.z}
    Cubes[k].points = points
    Cubes[k].pos = PointOnSphere(points.x,points.y,points.z)
  end
end

DrawToons = function()
  local position = GetEntityCoords(GetPlayerPed(-1))
  local plyPed = GetPlayerPed(-1)
  local plyPos = GetEntityCoords(plyPed)

  local infront = vector3(position.x+35.0, position.y-8.0,position.z)
  local behind  = vector3(position.x-35.0, position.y-8.0,position.z)

  if (GetGameTimer() - MarioTimer) > 1000 then
    MarioTimer = GetGameTimer()
    MarioState = MarioState + MarioAdder

    if MarioState > #Mario.bits then
      MarioAdder = -1
      MarioState = 2
    elseif MarioState <= 0 then
      MarioState = 2
      MarioAdder = 1
    end
  end


end

GetVecDist = function(v1,v2)
  if not v1 or not v2 or not v1.x or not v2.x then return 0; end
  return math.sqrt(  ( (v1.x or 0) - (v2.x or 0) )*(  (v1.x or 0) - (v2.x or 0) )+( (v1.y or 0) - (v2.y or 0) )*( (v1.y or 0) - (v2.y or 0) )+( (v1.z or 0) - (v2.z or 0) )*( (v1.z or 0) - (v2.z or 0) )  )
end

PointOnSphere = function(alt,azu,radius,orgX,orgY,orgZ)
  local toradians = 0.017453292384744
  alt,azu,radius,orgX,orgY,orgZ = ( tonumber(alt or 0) or 0 ) * toradians, ( tonumber(azu or 0) or 0 ) * toradians, tonumber(radius or 0) or 0, tonumber(orgX or 0) or 0, tonumber(orgY or 0) or 0, tonumber(orgZ or 0) or 0
  if      vector3
  then
      return
      vector3(
           orgX + radius * math.sin( azu ) * math.cos( alt ),
           orgY + radius * math.cos( azu ) * math.cos( alt ),
           orgZ + radius * math.sin( alt )
      )
  end
end



Citizen.CreateThread(function()
    local addictionThreshold = 40 -- kiek procentu gali but priklausomas? virsytas skaicius uzdes efekta
    
    while true do
        Citizen.Wait(900000) -- kas 15 min uzdeda
        
        local playerPed = PlayerPedId()
        local playerStillAddicted = false
        
        for drug, percent in pairs(playerAddiction) do
            if percent > addictionThreshold then
                playerStillAddicted = true
                
                -- uzdeda efekta, jeigu zaidejas yra 50proc priklausomas kazkam
                SetTimecycleModifier("spectator5")
                SetPedMotionBlur(playerPed, true)
                SetPedIsDrunk(playerPed, true)
                SetPedMoveRateOverride(playerPed, 10.0)
                AnimpostfxPlay("DrugsMichaelAliensFight", 10000001, true)
                ShakeGameplayCam("DRUNK_SHAKE", 3.0)
                
                
                -- zinute pranesanti kad yra priklausomas
                lib.notify({
                    id = 'priklausomas',
                    title = 'HALIUCIONACIJOS',
                    description = 'Jūsų priklausomybė narkotikams pradėjo reikštis.',
                    position = 'bottom',
                    duration = 10000,
                    style = {
                        backgroundColor = '#ffffff',
                        color = '#121212',
                        ['.description'] = {
                          color = '#212121'
                        }
                    },
                    icon = 'pills',
                    iconColor = '#1788DB'
                })


                Cubes = {}

                LastPedInteraction = 0
                LastPedTurn = nil
                MarioInit = nil
                PedSpawned = nil
                EvilPed = nil
              
                MarioState = 1
                MarioTimer = 0
                MarioLength = 15
                MarioAlpha = 0
                MarioAdder = 1
                MarioZOff = -20.0
                MarioZAdd = 0.01
                SetPedToRagdoll(GetPlayerPed(-1), 5000, 5000, 0, 0, 0, 0)
                
                -- 
                Citizen.Wait(30000)
                SetPedToRagdoll(GetPlayerPed(-1), 5000, 5000, 0, 0, 0, 0)
                
                Citizen.Wait(30000)
                SetPedToRagdoll(GetPlayerPed(-1), 5000, 5000, 0, 0, 0, 0)
                InitCubes()
                DrawToons()
                DrawCubes()
                DrawMario(infront)
                DrawMario(behind)
                Citizen.Wait(30000)
                lib.notify({
                    id = 'priklausomas2',
                    title = 'PRIKLAUSOMYBĖ',
                    description = 'Išsigydykite priklausomybę pas medikus !',
                    position = 'bottom',
                    duration = 7000,
                    style = {
                        backgroundColor = '#ffffff',
                        color = '#121212',
                        ['.description'] = {
                          color = '#212121'
                        }
                    },
                    icon = 'tablets',
                    iconColor = '#D63A3A'
                })

                -- efekto naikinimas
                ClearTimecycleModifier()
                SetPedMotionBlur(playerPed, false)
                ResetPedMovementClipset(playerPed, 0)
                SetPedIsDrunk(playerPed, false)
                SetPedMoveRateOverride(playerPed, 1.0)
                SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
                AnimpostfxStop("DrugsMichaelAliensFight")
                ShakeGameplayCam("DRUNK_SHAKE", 0.0)
                break
            end
        end
        if playerStillAddicted then
            Citizen.Wait(900000) -- kiek laiko laukti pries vel uzdedant efekta
        end
    end
end)




-- Narkotikų sistema usable with effects

ESX = exports["es_extended"]:getSharedObject()

function PlayFrontendSound(soundName, soundSetName)
  PlaySoundFrontend(-1, soundName, soundSetName, 1)
end

RegisterNetEvent('narkotikai:kokainas') -- palikt
AddEventHandler('narkotikai:kokainas', function()
  
  local playerPed = GetPlayerPed(-1)
  local playerPed = PlayerPedId()
  
    RequestAnimSet("MOVE_M@QUICK") 
    while not HasAnimSetLoaded("MOVE_M@QUICK") do
      Citizen.Wait(0)
    end    
    PlayFrontendSound("CHALLENGE_UNLOCKED", "HUD_AWARDS")
    lib.notify({
      id = 'kokaino_vartojimas',
      title = 'KOKAINAS',
      description = 'Suvartojote kokaino..',
      position = 'top',
      style = {
          backgroundColor = '#141517',
          color = '#C1C2C5',
          ['.description'] = {
            color = '#909296'
          }
      },
      icon = 'cubes-stacked',
      iconColor = '#4085cf'
  })
  local animDict = "anim@amb@nightclub@peds@"
  local animName = "missfbi3_party_snort_coke_b_male3"
  RequestAnimDict(animDict)
  while not HasAnimDictLoaded(animDict) do
    Citizen.Wait(100)
end
TaskPlayAnim(playerPed, animDict, animName, 8.0, -8.0, -1, 1, 0, false, false, false)
    --TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    Citizen.Wait(3000) -- laikas kol suveiks
    PlayFrontendSound("Crash", "DLC_HEIST_HACKING_SNAKE_SOUNDS")
    ClearPedTasksImmediately(playerPed)
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "MOVE_M@QUICK", true)
    SetPedIsDrunk(playerPed, true)
	  SetPedMoveRateOverride(PlayerId(),10.0)
    SetRunSprintMultiplierForPlayer(PlayerId(),0.29)
    AnimpostfxPlay("DrugsMichaelAliensFight", 10000001, true)
    ShakeGameplayCam("DRUNK_SHAKE", 3.0)
    Citizen.Wait(100000) -- efekto laikas
    lib.notify({
      id = 'pasibaige_efektas_kokainas',
      title = 'KOKAINAS',
      description = 'Pasibaigė kokaino efektas.',
      position = 'top',
      style = {
          backgroundColor = '#141517',
          color = '#C1C2C5',
          ['.description'] = {
            color = '#909296'
          }
      },
      icon = 'ban',
      iconColor = '#C53030'
  })
    SetPedMoveRateOverride(PlayerId(),1.0)
    SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
    SetPedIsDrunk(GetPlayerPed(-1), false)		
    SetPedMotionBlur(playerPed, false)
    ResetPedMovementClipset(GetPlayerPed(-1))
    AnimpostfxStopAll()
    ShakeGameplayCam("DRUNK_SHAKE", 0.0)
    SetTimecycleModifierStrength(0.0)
end)

RegisterNetEvent('narkotikai:whoonga') -- palikt
AddEventHandler('narkotikai:whoonga', function()
  
  local playerPed = GetPlayerPed(-1)
  local playerPed = PlayerPedId()
  
    RequestAnimSet("MOVE_M@QUICK") 
    while not HasAnimSetLoaded("MOVE_M@QUICK") do
      Citizen.Wait(0)
    end    
    PlayFrontendSound("CHALLENGE_UNLOCKED", "HUD_AWARDS")
    lib.notify({
      id = 'whoonga_vartojimas',
      title = 'Narkotikai',
      description = 'Suvartojote whoonga..',
      position = 'top',
      style = {
          backgroundColor = '#141517',
          color = '#C1C2C5',
          ['.description'] = {
            color = '#909296'
          }
      },
      icon = 'cubes-stacked',
      iconColor = '#4085cf'
  })
  local animDict = "anim@amb@nightclub@peds@"
  local animName = "missfbi3_party_snort_coke_b_male3"
  RequestAnimDict(animDict)
  while not HasAnimDictLoaded(animDict) do
    Citizen.Wait(100)
end
TaskPlayAnim(playerPed, animDict, animName, 8.0, -8.0, -1, 1, 0, false, false, false)
    --TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    Citizen.Wait(3000) -- laikas kol suveiks
    PlayFrontendSound("Crash", "DLC_HEIST_HACKING_SNAKE_SOUNDS")
    ClearPedTasksImmediately(playerPed)
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "MOVE_M@QUICK", true)
    SetPedIsDrunk(playerPed, true)
	  SetPedMoveRateOverride(PlayerId(),10.0)
    SetRunSprintMultiplierForPlayer(PlayerId(),0.29)
    AnimpostfxPlay("DrugsMichaelAliensFight", 10000001, true)
    ShakeGameplayCam("DRUNK_SHAKE", 3.0)
    Citizen.Wait(100000) -- efekto laikas
    lib.notify({
      id = 'pasibaige_efektas_kokainas',
      title = 'Narkotikai',
      description = 'Pasibaigė narkotiku efektas.',
      position = 'top',
      style = {
          backgroundColor = '#141517',
          color = '#C1C2C5',
          ['.description'] = {
            color = '#909296'
          }
      },
      icon = 'ban',
      iconColor = '#C53030'
  })
    SetPedMoveRateOverride(PlayerId(),1.0)
    SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
    SetPedIsDrunk(GetPlayerPed(-1), false)		
    SetPedMotionBlur(playerPed, false)
    ResetPedMovementClipset(GetPlayerPed(-1))
    AnimpostfxStopAll()
    ShakeGameplayCam("DRUNK_SHAKE", 0.0)
    SetTimecycleModifierStrength(0.0)
end)

RegisterNetEvent('narkotikai:crack') -- palikt
AddEventHandler('narkotikai:crack', function()
  
  local playerPed = GetPlayerPed(-1)
  local playerPed = PlayerPedId()
  
    RequestAnimSet("MOVE_M@QUICK") 
    while not HasAnimSetLoaded("MOVE_M@QUICK") do
      Citizen.Wait(0)
    end    
    PlayFrontendSound("CHALLENGE_UNLOCKED", "HUD_AWARDS")
    lib.notify({
      id = 'crack_vartojimas',
      title = 'Narkotikai',
      description = 'Suvartojote kreka..',
      position = 'top',
      style = {
          backgroundColor = '#141517',
          color = '#C1C2C5',
          ['.description'] = {
            color = '#909296'
          }
      },
      icon = 'cubes-stacked',
      iconColor = '#4085cf'
  })
  local animDict = "anim@amb@nightclub@peds@"
  local animName = "missfbi3_party_snort_coke_b_male3"
  RequestAnimDict(animDict)
  while not HasAnimDictLoaded(animDict) do
    Citizen.Wait(100)
end
TaskPlayAnim(playerPed, animDict, animName, 8.0, -8.0, -1, 1, 0, false, false, false)
    --TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    Citizen.Wait(3000) -- laikas kol suveiks
    PlayFrontendSound("Crash", "DLC_HEIST_HACKING_SNAKE_SOUNDS")
    ClearPedTasksImmediately(playerPed)
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "MOVE_M@QUICK", true)
    SetPedIsDrunk(playerPed, true)
	  SetPedMoveRateOverride(PlayerId(),10.0)
    SetRunSprintMultiplierForPlayer(PlayerId(),0.29)
    AnimpostfxPlay("DrugsMichaelAliensFight", 10000001, true)
    ShakeGameplayCam("DRUNK_SHAKE", 3.0)
    Citizen.Wait(100000) -- efekto laikas
    lib.notify({
      id = 'pasibaige_efektas_kokainas',
      title = 'Narkotikai',
      description = 'Pasibaigė narkotiku efektas.',
      position = 'top',
      style = {
          backgroundColor = '#141517',
          color = '#C1C2C5',
          ['.description'] = {
            color = '#909296'
          }
      },
      icon = 'ban',
      iconColor = '#C53030'
  })
    SetPedMoveRateOverride(PlayerId(),1.0)
    SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
    SetPedIsDrunk(GetPlayerPed(-1), false)		
    SetPedMotionBlur(playerPed, false)
    ResetPedMovementClipset(GetPlayerPed(-1))
    AnimpostfxStopAll()
    ShakeGameplayCam("DRUNK_SHAKE", 0.0)
    SetTimecycleModifierStrength(0.0)
end)

RegisterNetEvent('narkotikai:heroin') -- palikt
AddEventHandler('narkotikai:heroin', function()
  
  local playerPed = GetPlayerPed(-1)
  local playerPed = PlayerPedId()
  
    RequestAnimSet("MOVE_M@QUICK") 
    while not HasAnimSetLoaded("MOVE_M@QUICK") do
      Citizen.Wait(0)
    end    
    PlayFrontendSound("CHALLENGE_UNLOCKED", "HUD_AWARDS")
    lib.notify({
      id = 'heroin_vartojimas',
      title = 'Narkotikai',
      description = 'Suvartojote herojina..',
      position = 'top',
      style = {
          backgroundColor = '#141517',
          color = '#C1C2C5',
          ['.description'] = {
            color = '#909296'
          }
      },
      icon = 'cubes-stacked',
      iconColor = '#4085cf'
  })
  local animDict = "anim@amb@nightclub@peds@"
  local animName = "missfbi3_party_snort_coke_b_male3"
  RequestAnimDict(animDict)
  while not HasAnimDictLoaded(animDict) do
    Citizen.Wait(100)
end
TaskPlayAnim(playerPed, animDict, animName, 8.0, -8.0, -1, 1, 0, false, false, false)
    --TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    Citizen.Wait(3000) -- laikas kol suveiks
    PlayFrontendSound("Crash", "DLC_HEIST_HACKING_SNAKE_SOUNDS")
    ClearPedTasksImmediately(playerPed)
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "MOVE_M@QUICK", true)
    SetPedIsDrunk(playerPed, true)
	  SetPedMoveRateOverride(PlayerId(),10.0)
    SetRunSprintMultiplierForPlayer(PlayerId(),0.29)
    AnimpostfxPlay("DrugsMichaelAliensFight", 10000001, true)
    ShakeGameplayCam("DRUNK_SHAKE", 3.0)
    Citizen.Wait(100000) -- efekto laikas
    lib.notify({
      id = 'pasibaige_efektas_kokainas',
      title = 'Narkotikai',
      description = 'Pasibaigė narkotiku efektas.',
      position = 'top',
      style = {
          backgroundColor = '#141517',
          color = '#C1C2C5',
          ['.description'] = {
            color = '#909296'
          }
      },
      icon = 'ban',
      iconColor = '#C53030'
  })
    SetPedMoveRateOverride(PlayerId(),1.0)
    SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
    SetPedIsDrunk(GetPlayerPed(-1), false)		
    SetPedMotionBlur(playerPed, false)
    ResetPedMovementClipset(GetPlayerPed(-1))
    AnimpostfxStopAll()
    ShakeGameplayCam("DRUNK_SHAKE", 0.0)
    SetTimecycleModifierStrength(0.0)
end)
RegisterNetEvent('narkotikai:heroin_syringe') -- palikt
AddEventHandler('narkotikai:heroin_syringe', function()
  
  local playerPed = GetPlayerPed(-1)
  local playerPed = PlayerPedId()
  
    RequestAnimSet("MOVE_M@QUICK") 
    while not HasAnimSetLoaded("MOVE_M@QUICK") do
      Citizen.Wait(0)
    end    
    PlayFrontendSound("CHALLENGE_UNLOCKED", "HUD_AWARDS")
    lib.notify({
      id = 'heroins_vartojimas',
      title = 'Narkotikai',
      description = 'Suvartojote herojina..',
      position = 'top',
      style = {
          backgroundColor = '#141517',
          color = '#C1C2C5',
          ['.description'] = {
            color = '#909296'
          }
      },
      icon = 'cubes-stacked',
      iconColor = '#4085cf'
  })
  local animDict = "anim@amb@nightclub@peds@"
  local animName = "missfbi3_party_snort_coke_b_male3"
  RequestAnimDict(animDict)
  while not HasAnimDictLoaded(animDict) do
    Citizen.Wait(100)
end
TaskPlayAnim(playerPed, animDict, animName, 8.0, -8.0, -1, 1, 0, false, false, false)
    --TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    Citizen.Wait(3000) -- laikas kol suveiks
    PlayFrontendSound("Crash", "DLC_HEIST_HACKING_SNAKE_SOUNDS")
    ClearPedTasksImmediately(playerPed)
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "MOVE_M@QUICK", true)
    SetPedIsDrunk(playerPed, true)
	  SetPedMoveRateOverride(PlayerId(),10.0)
    SetRunSprintMultiplierForPlayer(PlayerId(),0.29)
    AnimpostfxPlay("DrugsMichaelAliensFight", 10000001, true)
    ShakeGameplayCam("DRUNK_SHAKE", 3.0)
    Citizen.Wait(100000) -- efekto laikas
    lib.notify({
      id = 'pasibaige_efektas_kokainas',
      title = 'Narkotikai',
      description = 'Pasibaigė narkotiku efektas.',
      position = 'top',
      style = {
          backgroundColor = '#141517',
          color = '#C1C2C5',
          ['.description'] = {
            color = '#909296'
          }
      },
      icon = 'ban',
      iconColor = '#C53030'
  })
    SetPedMoveRateOverride(PlayerId(),1.0)
    SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
    SetPedIsDrunk(GetPlayerPed(-1), false)		
    SetPedMotionBlur(playerPed, false)
    ResetPedMovementClipset(GetPlayerPed(-1))
    AnimpostfxStopAll()
    ShakeGameplayCam("DRUNK_SHAKE", 0.0)
    SetTimecycleModifierStrength(0.0)
end)
RegisterNetEvent('narkotikai:zole') -- palikt
AddEventHandler('narkotikai:zole', function()
  
  local playerPed = GetPlayerPed(-1)
  local playerPed = PlayerPedId()
  
    RequestAnimSet("MOVE_M@DRUNK@VERYDRUNK") 
    while not HasAnimSetLoaded("MOVE_M@DRUNK@VERYDRUNK") do
      Citizen.Wait(0)
    end    
    PlayFrontendSound("LOSER", "HUD_AWARDS")
    lib.notify({
      id = 'zoles_vartojimas',
      title = 'ŽOLĖ',
      description = 'Pradėjote rūkyti žolę..',
      position = 'top',
      style = {
          backgroundColor = '#141517',
          color = '#C1C2C5',
          ['.description'] = {
            color = '#909296'
          }
      },
      icon = 'cannabis',
      iconColor = '#43c467'
  })
    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    Citizen.Wait(3000) -- laikas kol suveiks
    PlayFrontendSound("Crash", "DLC_HEIST_HACKING_SNAKE_SOUNDS")
    ClearPedTasksImmediately(playerPed)
    SetTimecycleModifier("spectator6")
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "MOVE_M@DRUNK@VERYDRUNK", true)
    SetPedIsDrunk(playerPed, true)
    AnimpostfxPlay("ChopVision", 10000001, true)
    ShakeGameplayCam("DRUNK_SHAKE", 1.0)
    SetEntityHealth(GetPlayerPed(-1), 200)
    SetPedArmour(PlayerPedId(), 50)
    Citizen.Wait(100000) -- efekto laikas
    lib.notify({
      id = 'pasibaige_efektas',
      title = 'ŽOLĖ',
      description = 'Pasibaigė žolės efektas.',
      position = 'top',
      style = {
          backgroundColor = '#141517',
          color = '#C1C2C5',
          ['.description'] = {
            color = '#909296'
          }
      },
      icon = 'ban',
      iconColor = '#C53030'
  })
    SetPedMoveRateOverride(PlayerId(),1.0)
    SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
    SetPedIsDrunk(GetPlayerPed(-1), false)		
    SetPedMotionBlur(playerPed, false)
    ResetPedMovementClipset(GetPlayerPed(-1))
    AnimpostfxStopAll()
    ShakeGameplayCam("DRUNK_SHAKE", 0.0)
    SetTimecycleModifierStrength(0.0)
end)


RegisterNetEvent('narkotikai:opiumas')
AddEventHandler('narkotikai:opiumas', function()
  
  local playerPed = GetPlayerPed(-1)
  local playerPed = PlayerPedId()
  
    RequestAnimSet("move_m@buzzed") 
    while not HasAnimSetLoaded("move_m@buzzed") do
      Citizen.Wait(0)
    end
    PlayFrontendSound("LOSER", "HUD_AWARDS")
    lib.notify({
      id = 'opiumo_vartojimas',
      title = 'OPIUMAS',
      description = 'Suvartojote opiumo..',
      position = 'top',
      style = {
          backgroundColor = '#141517',
          color = '#C1C2C5',
          ['.description'] = {
            color = '#909296'
          }
      },
      icon = 'tablets',
      iconColor = '#c9323f'
  })
    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    Citizen.Wait(3000) -- laikas kol suveiks
    PlayFrontendSound("Crash", "DLC_HEIST_HACKING_SNAKE_SOUNDS")
    ClearPedTasksImmediately(playerPed)
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "move_m@buzzed", true)
    SetPedIsDrunk(playerPed, true)
    SetTimecycleModifier("spectator5")
    AnimpostfxPlay("Rampage", 10000001, true)
    ShakeGameplayCam("DRUNK_SHAKE", 1.5)	
    SetEntityHealth(GetPlayerPed(-1), 200)
    Citizen.Wait(100000) -- efekto laikas
    lib.notify({
      id = 'pasibaige_efektas_opiumas',
      title = 'OPIUMAS',
      description = 'Pasibaigė opiumo efektas.',
      position = 'top',
      style = {
          backgroundColor = '#141517',
          color = '#C1C2C5',
          ['.description'] = {
            color = '#909296'
          }
      },
      icon = 'ban',
      iconColor = '#C53030'
  })
    SetPedMoveRateOverride(PlayerId(),1.0)
    SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
    SetPedIsDrunk(GetPlayerPed(-1), false)		
    SetPedMotionBlur(playerPed, false)
    ResetPedMovementClipset(GetPlayerPed(-1))
    AnimpostfxStopAll()
    ShakeGameplayCam("DRUNK_SHAKE", 0.0)
    SetTimecycleModifierStrength(0.0)
end)


function PlayFrontendSound(soundName, soundSetName)
  PlaySoundFrontend(-1, soundName, soundSetName, 1)
end

RegisterNetEvent('narkotikai:vaistas') -- palikt
AddEventHandler('narkotikai:vaistas', function(source)

  TriggerServerEvent('priklausomybe:vaistas')

    lib.notify({
      id = 'vaistai',
      title = 'Vaistai',
      description = 'Jūsų priklausomybės visiškai išgydytos.',
      position = 'top',
      style = {
          backgroundColor = '#141517',
          color = '#C1C2C5',
          ['.description'] = {
            color = '#909296'
          }
      },
      icon = 'ban',
      iconColor = '#C53030'
  })
    SetPedMoveRateOverride(PlayerId(),1.0)
    SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
    SetPedIsDrunk(GetPlayerPed(-1), false)		
    SetPedMotionBlur(playerPed, false)
    ResetPedMovementClipset(GetPlayerPed(-1))
    AnimpostfxStopAll()
    ShakeGameplayCam("DRUNK_SHAKE", 0.0)
    SetTimecycleModifierStrength(0.0)
    
end)