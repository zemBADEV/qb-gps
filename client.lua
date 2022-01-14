local QBCore = exports['qb-core']:GetCoreObject()



RegisterNetEvent('qb-GPS:disable') 
AddEventHandler('qb-GPS:disable', function()
  local closestplayer = GetClosestPlayer(2)
  local target = GetPlayerServerId(closestplayer)
  TriggerServerEvent("qb-GPS:disableduty", target)
end)



RegisterNetEvent('qb-GPS:gpsoff', function(playerId)
            onDuty = not onDuty
            TriggerServerEvent("police:server:UpdateCurrentCops")
            TriggerServerEvent("police:server:UpdateBlips")
            TriggerServerEvent("QBCore:ToggleDuty")
            QBCore.Functions.Notify("Police GPS is disabled", "error")
end)


function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end


function GetClosestPlayer(radius)
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords['x'], targetCoords['y'], targetCoords['z'], plyCoords['x'], plyCoords['y'], plyCoords['z'], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
	print("closest player is dist: " .. tostring(closestDistance))
	if closestDistance <= radius then
		return closestPlayer
	else
		return nil
	end
end
