local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local function openPathFinderGUI()
    local elements = {
        {label = Config.GUI.SpeedLabel, name = 'speed', type = 'slider', value = Config.DefaultSpeed, min = 0.1, max = 5.0, step = 0.1},
        {label = Config.GUI.TweenLabel, name = 'tween', type = 'checkbox', value = true},
        {label = Config.GUI.FlyLabel, name = 'fly', type = 'checkbox', value = false},
        {label = Config.GUI.HeightLabel, name = 'height', type = 'slider', value = Config.DefaultFlyHeight, min = 5.0, max = 50.0, step = 1.0}
    }

    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'path_finder', {
        title = Config.GUI.Title
    }, function(data, menu)
        local targetName = data.value
        if targetName and targetName ~= '' then
            menu.close()
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'path_finder_settings', {
                title = Config.GUI.Subtitle,
                align = 'top-left',
                elements = elements
            }, function(data2, menu2)
                local speed = data2.current.speed
                local tween = data2.current.tween
                local fly = data2.current.fly
                local height = data2.current.height
                menu2.close()
                TriggerServerEvent('pathfinder:savePath', targetName, speed, tween, fly, height)
                findPath(targetName, speed, tween, fly, height)
            end, function(data2, menu2)
                menu2.close()
            end)
        else
            ESX.ShowNotification('Please enter a target name')
        end
    end, function(data, menu)
        menu.close()
    end)
end

local function findPath(targetName, speed, tween, fly, height)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local targetPed = GetPlayerFromName(targetName)
    if targetPed then
        local targetCoords = GetEntityCoords(targetPed)
        if tween then
            local tweenTime = Config.DefaultTweenTime
            local tweenCoords = vector3(targetCoords.x, targetCoords.y, targetCoords.z)
            if fly then
                tweenCoords = vector3(targetCoords.x, targetCoords.y, height)
            end
            local tweenTask = CreateSynchronizedScene(playerCoords, vector3(0, 0, 0), GetGameTimer() + tweenTime)
            TaskSynchronizedScene(playerPed, tweenTask, 'anim@mp_point', 'enter', 1.0, -4.0, 1, 16, 1000.0, 0)
            PlaySynchronizedEntityAnim(playerPed, tweenTask, 'anim@mp_point', 'enter', 1.0, -4.0, 1, 16, 1000.0, 0)
            Citizen.Wait(tweenTime)
            SetEntityCoords(playerPed, tweenCoords.x, tweenCoords.y, tweenCoords.z, false, false, false, true)
        else
            if fly then
                SetEntityCoords(playerPed, targetCoords.x, targetCoords.y, height, false, false, false, true)
            else
                SetEntityCoords(playerPed, targetCoords.x, targetCoords.y, targetCoords.z, false, false, false, true)
            end
        end
    else
        ESX.ShowNotification('Target not found')
    end
end

RegisterCommand('pathfinder', function()
    openPathFinderGUI()
end, false)

RegisterNetEvent('pathfinder:openGUI')
AddEventHandler('pathfinder:openGUI', function()
    openPathFinderGUI()
end)