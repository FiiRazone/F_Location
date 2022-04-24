ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("buyLoca")
AddEventHandler("buyLoca", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer.getMoney() >= priceConfig.price) then
		if hasLoc then
			TriggerClientEvent('esx:showNotification', source, '~r~Tu as déjà reçu ta voiture !~s~')
			return
		else
			hasLoc = true
			TriggerClientEvent('esx:showNotification', source, '~g~Tu as reçu ta voiture !~s~')
			xPlayer.removeMoney(priceConfig.price)
			local modelHash = GetHashKey("Blista")
			local pos = vector3(-1033.57, -2730.23, 20.07)
			CreateVehicle(modelHash, pos, 244.09, false, false)
		end
    else
		TriggerClientEvent('esx:showNotification', source, '~r~Pas assez de sous.~s~')
    end
end)