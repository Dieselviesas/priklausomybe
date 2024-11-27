ESX = exports["es_extended"]:getSharedObject()

local playerAddiction = {}

RegisterServerEvent('priklausomybe:coke_pure')
AddEventHandler('priklausomybe:coke_pure', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(source)
    --debuginimui
    --if not xPlayer then
        --print(('priklausomybe:coke_pure - Žaidėjas nerastas source: %s'):format(source))
       --return
   -- end
   
    local playerId = xPlayer.source
    local inv = playerId
    exports.ox_inventory:RemoveItem(inv, "coke_pure", "1")
    --print(playerId)
    --print(xPlayer.source)
    playerAddiction[playerId] = playerAddiction[playerId] or {}
    playerAddiction[playerId]['coke_pure'] = (playerAddiction[playerId]['coke_pure'] or 0) + 10
    
    TriggerClientEvent('updateAddiction', playerId, playerAddiction[playerId])
    TriggerClientEvent('esx:showNotification', playerId, 'Tapote priklausomas kokainui 10%')
    --TriggerClientEvent('narkotikai:kokainas', playerId)
end)
RegisterServerEvent('priklausomybe:whoonga')
AddEventHandler('priklausomybe:whoonga', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(source)
    --debuginimui
    --if not xPlayer then
        --print(('priklausomybe:coke_pure - Žaidėjas nerastas source: %s'):format(source))
       --return
   -- end
   
    local playerId = xPlayer.source
    local inv = playerId
    exports.ox_inventory:RemoveItem(inv, "whoonga", "1")
    --print(playerId)
    --print(xPlayer.source)
    playerAddiction[playerId] = playerAddiction[playerId] or {}
    playerAddiction[playerId]['whoonga'] = (playerAddiction[playerId]['whoonga'] or 0) + 10
    
    TriggerClientEvent('updateAddiction', playerId, playerAddiction[playerId])
    TriggerClientEvent('esx:showNotification', playerId, 'Tapote priklausomas whoonga 10%')
    --TriggerClientEvent('narkotikai:kokainas', playerId)
end)

RegisterServerEvent('priklausomybe:crack')
AddEventHandler('priklausomybe:crack', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(source)
    --debuginimui
    --if not xPlayer then
        --print(('priklausomybe:coke_pure - Žaidėjas nerastas source: %s'):format(source))
       --return
   -- end
   
    local playerId = xPlayer.source
    local inv = playerId
    exports.ox_inventory:RemoveItem(inv, "crack", "1")
    --print(playerId)
    --print(xPlayer.source)
    playerAddiction[playerId] = playerAddiction[playerId] or {}
    playerAddiction[playerId]['crack'] = (playerAddiction[playerId]['crack'] or 0) + 10
    
    TriggerClientEvent('updateAddiction', playerId, playerAddiction[playerId])
    TriggerClientEvent('esx:showNotification', playerId, 'Tapote priklausomas krekui 10%')
    --TriggerClientEvent('narkotikai:kokainas', playerId)
end)

RegisterServerEvent('priklausomybe:heroin')
AddEventHandler('priklausomybe:heroin', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(source)
    --debuginimui
    --if not xPlayer then
        --print(('priklausomybe:coke_pure - Žaidėjas nerastas source: %s'):format(source))
       --return
   -- end
   
    local playerId = xPlayer.source
    local inv = playerId
    exports.ox_inventory:RemoveItem(inv, "heroin", "1")
    --print(playerId)
    --print(xPlayer.source)
    playerAddiction[playerId] = playerAddiction[playerId] or {}
    playerAddiction[playerId]['heroin'] = (playerAddiction[playerId]['heroin'] or 0) + 10
    
    TriggerClientEvent('updateAddiction', playerId, playerAddiction[playerId])
    TriggerClientEvent('esx:showNotification', playerId, 'Tapote priklausomas heroinui 10%')
    --TriggerClientEvent('narkotikai:kokainas', playerId)
end)

RegisterServerEvent('priklausomybe:heroin_syringe')
AddEventHandler('priklausomybe:heroin_syringe', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(source)
    --debuginimui
    --if not xPlayer then
        --print(('priklausomybe:coke_pure - Žaidėjas nerastas source: %s'):format(source))
       --return
   -- end
   
    local playerId = xPlayer.source
    local inv = playerId
    exports.ox_inventory:RemoveItem(inv, "heroin_syringe", "1")
    --print(playerId)
    --print(xPlayer.source)
    playerAddiction[playerId] = playerAddiction[playerId] or {}
    playerAddiction[playerId]['heroin_syringe'] = (playerAddiction[playerId]['heroin_syringe'] or 0) + 10
    
    TriggerClientEvent('updateAddiction', playerId, playerAddiction[playerId])
    TriggerClientEvent('esx:showNotification', playerId, 'Tapote priklausomas heroinui 10%')
    --TriggerClientEvent('narkotikai:kokainas', playerId)
end)



RegisterServerEvent('priklausomybe:bluedream_joint')
AddEventHandler('priklausomybe:bluedream_joint', function(playerI)
    local xPlayer = ESX.GetPlayerFromId(source)
    --debuginimui
    --if not xPlayer then
        --print(('priklausomybe:coke_pure - Žaidėjas nerastas source: %s'):format(source))
       --return
   -- end
   
    local playerId = xPlayer.source
    local inv = playerId
    exports.ox_inventory:RemoveItem(inv, "bluedream_joint", "1")
    playerAddiction[playerId] = (playerAddiction[playerId] or {})
    playerAddiction[playerId]['bluedream_joint'] = (playerAddiction[playerId]['bluedream_joint'] or 0) + 10
    TriggerClientEvent('updateAddiction', playerId, playerAddiction[playerId])
    TriggerClientEvent('esx:showNotification', playerId, 'Tapote priklausomas žolei 10%')
    --TriggerClientEvent('narkotikai:zole', source)
end)

ESX.RegisterServerCallback('getAddiction', function(source, cb)
    local playerId = source
    cb(playerAddiction[playerId] or {})
end)

RegisterServerEvent('priklausomybe:vaistas')
AddEventHandler('priklausomybe:vaistas', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(source)
    --debuginimui
    --if not xPlayer then
        --print(('priklausomybe:coke_pure - Žaidėjas nerastas source: %s'):format(source))
       --return
   -- end
   
    local playerId = xPlayer.source
    local inv = playerId
    exports.ox_inventory:RemoveItem(inv, "universal_cure", "1")
    playerAddiction[playerId] = {}
    TriggerClientEvent('updateAddiction', playerId, {})
    --xPlayer.removeInventoryItem('universal_cure', 1)
    --TriggerClientEvent('esx:showNotification', playerId, 'Jūsų priklausomybės visiškai išgydytos !')
end)

RegisterServerEvent('priklausomybe:purplehaze_joint')
AddEventHandler('priklausomybe:purplehaze_joint', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(source)
    --debuginimui
    --if not xPlayer then
        --print(('priklausomybe:coke_pure - Žaidėjas nerastas source: %s'):format(source))
       --return
   -- end
   
    local playerId = xPlayer.source
    local inv = playerId
    exports.ox_inventory:RemoveItem(inv, "opium_clean", "1")
    playerAddiction[playerId] = (playerAddiction[playerId] or {})
    playerAddiction[playerId]['purplehaze_joint'] = (playerAddiction[playerId]['purplehaze_joint'] or 0) + 10
    TriggerClientEvent('updateAddiction', playerId, playerAddiction[playerId])
    TriggerClientEvent('esx:showNotification', playerId, 'Tapote priklausomas opiumui 10%')
    --TriggerClientEvent('narkotikai:zole', source)
end)



--[[ESX.RegisterUsableItem('opium', function(source)       
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem('opium', 1)
    TriggerClientEvent('narkotikai:opiumas', source)
end)]]


-- Narkotikų sistema

-- KOKAINAS

--[[ESX.RegisterUsableItem('coke_pure', function(source)       
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem('coke_pure', 1)
    TriggerClientEvent('narkotikai:kokainas', source)
end)

-- ŽOLĖ

ESX.RegisterUsableItem('bluedream_joint', function(source)    
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem('bluedream_joint', 1)
    TriggerClientEvent('narkotikai:zole', source)
end)
ESX.RegisterUsableItem('bluedream_joint', function(source)    
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem('bluedream_joint', 1)
    TriggerClientEvent('narkotikai:zole', source)
end)
ESX.RegisterUsableItem('bluedream_joint', function(source)    
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem('bluedream_joint', 1)
    TriggerClientEvent('narkotikai:zole', source)
end)
ESX.RegisterUsableItem('bluedream_joint', function(source)    
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem('bluedream_joint', 1)
    TriggerClientEvent('narkotikai:zole', source)
end)

-- OPIUMAS

ESX.RegisterUsableItem('opium_clean', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem('opium_clean', 1)
    TriggerClientEvent('narkotikai:opiumas', source)
end)]]

