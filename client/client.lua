ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	RegisterNetEvent('esx:playerLoaded') -- Store the players data
    AddEventHandler('esx:playerLoaded', function(xPlayer)
        ESX.PlayerData = xPlayer
        ESX.PlayerLoaded = true
    end)
end)

local MainMenu = RageUI.CreateMenu("~g~Location", "~c~Choix des voitures");

Citizen.CreateThread(function()
	local coords = vector3(-1026.593, -2737.094, 20.16406)
    local pedName = "a_f_y_eastsa_03"
    local pedHash = GetHashKey(pedName)

    RequestModel(pedHash)
    while not HasModelLoaded(pedHash) do Citizen.Wait(0) end
    local ped = CreatePed(9, pedHash, coords, 145.53, false, false)
    Citizen.Wait(1000)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_COP_IDLES", 0, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)

    local blip = AddBlipForCoord(blipConfig.blipCoords)
    SetBlipScale(blip, 1.0)
    SetBlipSprite(blip, 326)
    SetBlipColour(blip, 2)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(blipConfig.blipName)
    EndTextCommandSetBlipName(blip)

	local interval, ped, pos, distance
	local coords = vector3(-1026.593, -2737.094, 20.16406)
	while true do
		interval = 0
		ped = PlayerPedId()
		pos = GetEntityCoords(ped)
		distance = #(pos - coords)
		if distance > 30 then
			interval = 5000
		else
			if distance < 2 then
				AddTextEntry("help", "Appuyer sur ~b~E ~s~pour accéder à cette zone")
				DisplayHelpTextThisFrame("help", false)
				if IsControlJustPressed(1, 51) then
					RageUI.Visible(MainMenu, not RageUI.Visible(MainMenu))
				end
			else
				RageUI.CloseAll()
			end
		end
		Citizen.Wait(interval)
	end
end)

function RageUI.PoolMenus:Example()
	MainMenu:IsVisible(function(Items)
		Items:AddButton("Blista", "Location Blista", { IsDisabled = false, RightBadge = RageUI.BadgeStyle.GoldMedal, 
        Color = {HighLightColor = RageUI.ItemsColour.PureWhite, BackgroundColor = RageUI.ItemsColour.Red} },function(onSelected)
			if onSelected then
				TriggerServerEvent("buyLoca")
			end
		end)
	end, function() end)
end