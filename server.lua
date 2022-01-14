local QBCore = exports['qb-core']:GetCoreObject()




QBCore.Functions.CreateUseableItem("radioscanner", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('qb-GPS:disable', source, item) 
end)

RegisterNetEvent('qb-GPS:disableduty', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local MaskedPlayer = QBCore.Functions.GetPlayer(playerId)
    if (MaskedPlayer.PlayerData.metadata["ishandcuffed"] or MaskedPlayer.PlayerData.metadata["inlaststand"] or MaskedPlayer.PlayerData.metadata["isdead"]) then
        if (MaskedPlayer.PlayerData.job.name == "police" and MaskedPlayer.PlayerData.job.onduty) then 
            if Player.Functions.GetItemByName("radioscanner") then
                TriggerClientEvent("qb-GPS:gpsoff", MaskedPlayer.PlayerData.source, Player.PlayerData.source)
                TriggerClientEvent('QBCore:Notify', src, "GPS Disabled", 'success')
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "He is not a cop!!", 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "He is not cuffed nor dead", 'error')
    end
end)