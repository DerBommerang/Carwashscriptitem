ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

RegisterNetEvent('carwash:washCar')
AddEventHandler('carwash:washCar', function()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local vehicle = ESX.Game.GetClosestVehicle(coords)

    if DoesEntityExist(vehicle) then
        -- Animation abspielen
        local dict = "amb@world_human_maid_clean@"
        local anim = "base"
        loadAnimDict(dict)
        TaskPlayAnim(playerPed, dict, anim, 8.0, -8.0, -1, 1, 0, false, false, false)

        -- Wartezeit für Animation
        Citizen.Wait(5000)

        -- Animation stoppen
        ClearPedTasks(playerPed)

        -- Fahrzeug waschen
        SetVehicleDirtLevel(vehicle, 0)
        ESX.ShowNotification("Das Fahrzeug wurde gewaschen!")
    else
        ESX.ShowNotification("Kein Fahrzeug in der Nähe!")
    end
end)