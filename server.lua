local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('pathfinder:getPlayerCoords', function(source, cb, targetName)
    local xPlayers = ESX.GetPlayers()
    for _, playerId in ipairs(xPlayers) do
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer.getName() == targetName then
            local playerPed = GetPlayerPed(playerId)
            local playerCoords = GetEntityCoords(playerPed)
            cb(playerCoords)
            return
        end
    end
    cb(nil)
end)

RegisterServerEvent('pathfinder:savePath')
AddEventHandler('pathfinder:savePath', function(targetName, speed, tween, fly, height)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        MySQL.Async.execute('INSERT INTO pathfinder_paths (player_id, target_name, speed, tween_time, fly_height) VALUES (@player_id, @target_name, @speed, @tween_time, @fly_height)', {
            ['@player_id'] = xPlayer.identifier,
            ['@target_name'] = targetName,
            ['@speed'] = speed,
            ['@tween_time'] = Config.DefaultTweenTime,
            ['@fly_height'] = height
        }, function(rowsChanged)
            if rowsChanged > 0 then
                print('Path saved for player ' .. xPlayer.identifier)
            else
                print('Failed to save path for player ' .. xPlayer.identifier)
            end
        end)
    end
end)