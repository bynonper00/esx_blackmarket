local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
ESX 			    			= nil
local showblip = false
local displayedBlips = {}
local AllBlips = {}
local number = nil
local pedIsTryingToChopVehicle  = false


---------





-------------------------------

local timer = 1 --in minutes - Set the time during the player is outlaw
local showOutlaw = true --Set if show outlaw act on map
local blipTime = 2 --in second
local showcopsmisbehave = true --show notification when cops steal too

local timing = timer * 60000 --Don't touche it


-------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
        Wait(100)
        if NetworkIsSessionStarted() then
            DecorRegister("IsOutlaw",  3)
            DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 1)
            return
        end
    end
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

Citizen.CreateThread( function()
    while true do
        Wait(100)
        local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
        local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
        local street1 = GetStreetNameFromHashKey(s1)
        local street2 = GetStreetNameFromHashKey(s2)
        if pedIsTryingToChopVehicle then
            DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 2)
            if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'police' and 0 > 1 then
            elseif ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'police' then
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                    local sex = nil
                    if skin.sex == 0 then
                        sex = "male" --male/change it to your language
                    else
                        sex = "female" --female/change it to your language
                    end
                    
                    if s2 == 0 then
                        TriggerServerEvent('esx_blackmarket:ChopInProgressS1', street1, sex)
                    elseif s2 ~= 0 then
                        TriggerServerEvent('esx_blackmarket:ChopInProgress', street1, street2, sex)
                    end
					
					local kere = Config.BlipSayisi
					
					while kere <= kere and kere > 0 do
					plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
					
					TriggerServerEvent('esx_blackmarket:ChoppingInProgressPos', plyPos.x, plyPos.y, plyPos.z)
					
					kere = kere - 1
					
					Citizen.Wait(Config.BeklemeSuresi * 1000)
					
					end
					
                end)
                Wait(3000)
                pedIsTryingToChopVehicle = false
            else
                --[[ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                    local sex = nil
                    if skin.sex == 0 then
                        sex = "male"
                    else
                        sex = "female"
                    end
                    TriggerServerEvent('esx_blackmarket:ChoppingInProgressPos', plyPos.x, plyPos.y, plyPos.z)
                    if s2 == 0 then
                        TriggerServerEvent('esx_blackmarket:ChopInProgressS1', street1, sex)
                    elseif s2 ~= 0 then
                        TriggerServerEvent('esx_blackmarket:ChopInProgress', street1, street2, sex)
                    end
                end)--]]
                
            end
        end
    end
end)


RegisterNetEvent('esx_blackmarket:Choplocation')
AddEventHandler('esx_blackmarket:Choplocation', function(tx, ty, tz)
    if ESX.PlayerData.job.name == 'police' then
        local transT = 250
        local Blip = AddBlipForCoord(tx, ty, tz)
        SetBlipSprite(Blip,  10)
        SetBlipColour(Blip,  1)
        SetBlipAlpha(Blip,  transT)
        SetBlipAsShortRange(Blip,  false)
        while transT ~= 0 do
            Wait(blipTime * 4)
            transT = transT - 1
            SetBlipAlpha(Blip,  transT)
            if transT == 0 then
                SetBlipSprite(Blip,  2)
                return
            end
        end
    end
end)


GetPlayerName()
RegisterNetEvent('esx_blackmarket:outlawNotify')
AddEventHandler('esx_blackmarket:outlawNotify', function(alert)
		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'police' then
			TriggerEvent('esx_blackmarket:notify2')
			PlaySoundFrontend(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0)
    end
end)

function Notify(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, false)
end

RegisterNetEvent("esx_blackmarket:notify2")
AddEventHandler("esx_blackmarket:notify2", function(msg, target)
		ESX.ShowAdvancedNotification(_U('911'), _U('chop'), _U('call'), 'CHAR_CALL911', 7)
end)


AddEventHandler('esx:onPlayerDeath', function(data)
    isDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
    isDead = false
end)

function CreateBlipCircle(coords, text, radius, color, sprite)

	local blip = AddBlipForCoord(coords)
	SetBlipSprite(blip, sprite)
	SetBlipColour(blip, color)
	SetBlipScale(blip, 0.8)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(text)
	EndTextCommandSetBlipName(blip)

end

Citizen.CreateThread(function()
	if Config.EnableBlips == true then
	  for k,zone in pairs(Config.Zones) do
        CreateBlipCircle(zone.coords, zone.name, zone.radius, zone.color, zone.sprite)
	  end
   end
end)

RegisterNetEvent('esx_blackmarket:chopEnable')
AddEventHandler('esx_blackmarket:chopEnable', function()
	pedIsTryingToChopVehicle = true
end)

----------------------------------------------------------------------------------------------------------------------














AddEventHandler('onResourceStop', function(resource)
	  if resource == GetCurrentResourceName() then
		  SetNuiFocus(false, false)
	  end
end)
  
RegisterNUICallback('escape', function(data, cb)
	 
	  SetNuiFocus(false, false)
  
	  SendNUIMessage({
		  type = "close",
	  })
end)


--alarm-------------------------------------------------



				

---------------------------------------------------------


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
   ESX.PlayerData = xPlayer
end)

local ShopId           = nil
local Msg        = nil
local HasAlreadyEnteredMarker = false
local LastZone                = nil





AddEventHandler('esx_blackmarket:hasEnteredMarker', function(zone)
	if zone == 'center' then
		ShopId = zone
		number = zone
		Msg  = _U('press_to_open_center')
	elseif zone <= 100 then
		ShopId = zone
		number = zone
		Msg  = _U('press_to_open')
	elseif zone >= 100 then
		ShopId = zone
		number = zone
		Msg  = _U('press_to_rob')
	end
end)

AddEventHandler('esx_blackmarket:hasExitedMarker', function(zone)
	ShopId = nil
end)





Citizen.CreateThread(function ()
 	 while true do
		Citizen.Wait(0)

		if ShopId ~= nil then

			SetTextComponentFormat('STRING')
			AddTextComponentString(Msg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)

				if IsControlJustReleased(0, Keys['E']) then




					OpenShipments(number)




	 	 		end
		end
	end
 end)






function OpenShipments(id)

	local elements = {}
	
	table.insert(elements, {label = 'Saldırı Tüfekleri', value = 'buySaldiri'})
	table.insert(elements, {label = 'Taramalı Tüfekler', value = 'buyTara'})
	table.insert(elements, {label = 'Keskin Nişancı Tüfekleri', value = 'buyKeskin'})
	table.insert(elements, {label = 'Pompalı Tüfekler', value = 'buyPompa'})
	table.insert(elements, {label = 'Uzun Menzilli Patlayıcılar', value = 'buyUzunPatla'})
	table.insert(elements, {label = 'Patlayıcılar', value = 'buyPatla'})
	table.insert(elements, {label = 'Zırhlar', value = 'buyZirh'})
	table.insert(elements, {label = 'Mühimmatlar', value = 'buyMuhimmat'})
	--table.insert(elements, {label = 'Yasadışı silah ve mühimmat siparişi', value = 'sipVer'})	
	--table.insert(elements, {label = 'Sipariş edilen yasadışı silah ve mühimmalar', value = 'shipments'})
	

	ESX.UI.Menu.Open(
  	'default', GetCurrentResourceName(), 'shipments',
	{
		title    = 'Yasadışı Silah Kaçakçılığı',
		align    = 'left',
		elements = { 
		{label = 'Yasadışı silah ve mühimmat siparişi', value = 'sipVer'},
		{label = 'Sipariş edilen yasadışı silah ve mühimmatlar', value = 'shipments'}	
					}
	},
	  function(data, menu)
	  ESX.UI.Menu.CloseAll()
	  
	  if data.current.value == 'sipVer' then
	  
	  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sipVer', {
				title    = 'Yasadışı Silah Kaçakçılığı',
				align    = 'left',
				elements = elements
			}
		, function(data, menu)
				ESX.UI.Menu.CloseAll()
				
		if data.current.value == 'buySaldiri' then
			ESX.UI.Menu.CloseAll()
			OpenSaldiri(id)
		elseif data.current.value == 'buyTara' then
			ESX.UI.Menu.CloseAll()
			OpenTaramali(id)
		elseif data.current.value == 'buyKeskin' then
			ESX.UI.Menu.CloseAll()
			OpenKeskin(id)
		elseif data.current.value == 'buyPompa' then
			ESX.UI.Menu.CloseAll()
			OpenPompali(id)
		elseif data.current.value == 'buyUzunPatla' then
			ESX.UI.Menu.CloseAll()
			OpenUzunPatla(id)
		elseif data.current.value == 'buyPatla' then
			ESX.UI.Menu.CloseAll()
			OpenPatla(id)
		elseif data.current.value == 'buyMuhimmat' then
			ESX.UI.Menu.CloseAll()
			OpenMuhimmat(id)    -- ZIRH VE MÜHİMMAT SEÇENEKLERİNE SALDIRI TÜFEKLERİNİN FONKSİYONUNU EKLEDİM ONLAR İÇİN DE AYRI FONKSİYON AÇIP DÜZELTİRİZ [[ MÜHİMMATTA SİLAHLARIN MERMİLERİ, RPGLERİN ROKETİ VS OLACAK BAK BU YAPILIR :D ]]
		end	
	end,
		function(data, menu)
			menu.close()
		end)
		
		elseif data.current.value == 'shipments' then
			ESX.UI.Menu.CloseAll()
			GetAllShipments(id)
		end
	end)
end






function GetAllShipments(id)

	local elements = {}



	ESX.TriggerServerCallback('esx_blackmarket:getTime', function(time)
	ESX.TriggerServerCallback('esx_blackmarket:getAllShipments', function(items)
	ESX.TriggerServerCallback('esx_blackmarket:getMuhShipments', function(esyalar)
	


	local once = true
	local once2 = true
	local falan = false
	local filan = false

		for i=1, #items, 1 do
		
			if time - items[i].time <= Config.DeliveryTime and once then
				--table.insert(elements, {label = '--SİPARİŞLER BEKLENİYOR--'})
				filan = true
				once = false
			end
		
			

			if time - items[i].time <= Config.DeliveryTime then
				times = time - items[i].time
				table.insert(elements, {label = items[i].label .. ' kalan süre: ' .. math.floor((Config.DeliveryTime - times) / 60) .. ' dakika' })
			end
			
			if time - items[i].time >= Config.DeliveryTime then
				table.insert(elements, {label = items[i].label,	value = items[i].item, price = items[i].price})
			end

			if time - items[i].time >= Config.DeliveryTime and once2 then
				--table.insert(elements, {label = 'Tüm Siparişleri Al', value = 'pickup'})
			once2 = false
			falan = true
			end
			
			
			

		end
		
		for i=1, #esyalar, 1 do
		
			if time - esyalar[i].time <= Config.DeliveryTime and once then
				--table.insert(elements, {label = '--SİPARİŞLER BEKLENİYOR--'})
				filan = true
				once = false
			end
		
		
			

			if time - esyalar[i].time <= Config.DeliveryTime then
				times = time - esyalar[i].time
				table.insert(elements, {label = esyalar[i].label .. ' kalan süre: ' .. math.floor((Config.DeliveryTime - times) / 60) .. ' dakika' })
			end
			
			if time - esyalar[i].time >= Config.DeliveryTime then
				table.insert(elements, {label = esyalar[i].label,	value = esyalar[i].item, price = esyalar[i].price})
			end

			if time - esyalar[i].time >= Config.DeliveryTime and once2 then
				--table.insert(elements, {label = 'Tüm Siparişleri Al', value = 'pickup'})
			once2 = false
			falan = true
			end
			
		
			
			
			
		end
		
		if falan == true and filan == false then
		
			table.insert(elements, {label = 'Tüm Siparişleri Al', value = 'pickup'})
			falan = false
		
		
		end
		

	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'allshipments',
	{
	  title    = 'Shop',
	  align    = 'left',
	  elements = elements
	},
	  function(data, menu)
		
		if data.current.value == 'pickup' then
		
		
		
							if Config.PolisiAra then
								local randomReport = math.random(1, Config.PolisiAramaYuzdesi)

								if randomReport == Config.PolisiAramaYuzdesi then
									TriggerServerEvent('esx_blackmarket:chopNotify')
								end
							end
			TriggerServerEvent('esx_blackmarkets:GetAllItems', id)
			TriggerServerEvent('esx_blackmarkets:GetMuhimItem', id)	
			menu.close()
				end
	end,
		function(data, menu)
		menu.close()
		end)

	end, id)
	end, id)
	
	end)
end






------ YORUMLU SATIR VARSAYILAN FUNCTION AŞAĞISINDAKİLER DÜZENLENMİŞ HALİ.

--[[function OpenShipmentDelivery(id)
	ESX.UI.Menu.CloseAll()
	local elements = {}

		for i=1, #Config.Items, 1 do
			table.insert(elements, {labels =  Config.Items[i].label, label =  Config.Items[i].label .. ' $' .. Config.Items[i].price .. ' ',	value = Config.Items[i].item, price = Config.Items[i].price})
		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'shipitem',
			{
			title    = 'Yasadışı Silah Kaçakçılığı',
			align    = 'left',
			elements = elements
			},
			function(data, menu)
				menu.close()
				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'krille', {
				title = 'How much do you want to buy?'
				}, function(data2, menu2)
					menu2.close()
					TriggerServerEvent('esx_blackmarket:MakeShipment', id, data.current.value, data.current.price, tonumber(data2.value), data.current.labels)

				end, function(data2, menu2)
					menu2.close()
				end)

		end,
		function(data, menu)
		menu.close()
	end)
end--]]

function OpenMuhimmat(id)
	ESX.UI.Menu.CloseAll()
	local elements = {}

		for i=1, #Config.ItemsMuhimmat, 1 do
			table.insert(elements, {labels =  Config.ItemsMuhimmat[i].label, label =  Config.ItemsMuhimmat[i].label .. ' $' .. Config.ItemsMuhimmat[i].price .. ' ',	value = Config.ItemsMuhimmat[i].item, price = Config.ItemsMuhimmat[i].price})
		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'shipitem',
			{
			title    = 'Yasadışı Mühimmat Ticareti',
			align    = 'left',
			elements = elements
			},
			function(data, menu)
					menu.close()
					TriggerServerEvent('esx_blackmarket:MakeShipmentMuh', id, data.current.value, data.current.price, tonumber(1), data.current.labels)

				end, function(data2, menu2)
					menu2.close()
				end)
		end

---------------- KATEGORİ FONKSİYONLARI AŞAĞIDA -------------------

function OpenSaldiri(id)
	ESX.UI.Menu.CloseAll()
	local elements = {}

		for i=1, #Config.ItemsSaldiri, 1 do
			table.insert(elements, {labels =  Config.ItemsSaldiri[i].label, label =  Config.ItemsSaldiri[i].label .. ' $' .. Config.ItemsSaldiri[i].price .. ' ',	value = Config.ItemsSaldiri[i].item, price = Config.ItemsSaldiri[i].price})
		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'shipitem',
			{
			title    = 'Yasadışı Saldırı Tüfekleri',
			align    = 'left',
			elements = elements
			},
			function(data, menu)
				menu.close()
					TriggerServerEvent('esx_blackmarket:MakeShipment', id, data.current.value, data.current.price, tonumber(1), data.current.labels)

				end, function(data2, menu2)
					menu2.close()
				end)
		end

function OpenTaramali(id)
	ESX.UI.Menu.CloseAll()
	local elements = {}

		for i=1, #Config.ItemsTaramali, 1 do
			table.insert(elements, {labels =  Config.ItemsTaramali[i].label, label =  Config.ItemsTaramali[i].label .. ' $' .. Config.ItemsTaramali[i].price .. ' ',	value = Config.ItemsTaramali[i].item, price = Config.ItemsTaramali[i].price})
		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'shipitem',
			{
			title    = 'Yasadışı Taramalı Tüfekler',
			align    = 'left',
			elements = elements
			},
			function(data, menu)
					menu.close()
					TriggerServerEvent('esx_blackmarket:MakeShipment', id, data.current.value, data.current.price, tonumber(1), data.current.labels)

				end, function(data2, menu2)
					menu2.close()
				end)

end

function OpenKeskin(id)
	ESX.UI.Menu.CloseAll()
	local elements = {}

		for i=1, #Config.ItemsKeskin , 1 do
			table.insert(elements, {labels =  Config.ItemsKeskin [i].label, label =  Config.ItemsKeskin [i].label .. ' $' .. Config.ItemsKeskin [i].price .. ' ',	value = Config.ItemsKeskin [i].item, price = Config.ItemsKeskin [i].price})
		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'shipitem',
			{
			title    = 'Yasadışı Nişancı Tüfekleri',
			align    = 'left',
			elements = elements
			},
			function(data, menu)
					menu.close()
					TriggerServerEvent('esx_blackmarket:MakeShipment', id, data.current.value, data.current.price, tonumber(1), data.current.labels)

				end, function(data2, menu2)
					menu2.close()
				end)

end

function OpenPompali(id)
	ESX.UI.Menu.CloseAll()
	local elements = {}

		for i=1, #Config.ItemsPompali , 1 do
			table.insert(elements, {labels =  Config.ItemsPompali [i].label, label =  Config.ItemsPompali [i].label .. ' $' .. Config.ItemsPompali [i].price .. ' ',	value = Config.ItemsPompali [i].item, price = Config.ItemsPompali [i].price})
		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'shipitem',
			{
			title    = 'Yasadışı Pompalilar',
			align    = 'left',
			elements = elements
			},
			function(data, menu)
					menu.close()
					TriggerServerEvent('esx_blackmarket:MakeShipment', id, data.current.value, data.current.price, tonumber(1), data.current.labels)

				end, function(data2, menu2)
					menu2.close()
				end)

end

function OpenUzunPatla(id)
	ESX.UI.Menu.CloseAll()
	local elements = {}

		for i=1, #Config.ItemsUzunPatla , 1 do
			table.insert(elements, {labels =  Config.ItemsUzunPatla [i].label, label =  Config.ItemsUzunPatla [i].label .. ' $' .. Config.ItemsUzunPatla [i].price .. ' ',	value = Config.ItemsUzunPatla [i].item, price = Config.ItemsUzunPatla [i].price})
		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'shipitem',
			{
			title    = 'Yasadışı Uzun Menzilli Patlayıcılar',
			align    = 'left',
			elements = elements
			},
			function(data, menu)
					menu.close()
					TriggerServerEvent('esx_blackmarket:MakeShipment', id, data.current.value, data.current.price, tonumber(1), data.current.labels)

				end, function(data2, menu2)
					menu2.close()
				end)

end

function OpenPatla(id)
	ESX.UI.Menu.CloseAll()
	local elements = {}

		for i=1, #Config.ItemsPatla , 1 do
			table.insert(elements, {labels =  Config.ItemsPatla [i].label, label =  Config.ItemsPatla [i].label .. ' $' .. Config.ItemsPatla [i].price .. ' ',	value = Config.ItemsPatla [i].item, price = Config.ItemsPatla [i].price})
		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'shipitem',
			{
			title    = 'Yasadışı Patlayıcılar',
			align    = 'left',
			elements = elements
			},
			function(data, menu)
					menu.close()
					TriggerServerEvent('esx_blackmarket:MakeShipment', id, data.current.value, data.current.price, tonumber(1), data.current.labels)

				end, function(data2, menu2)
					menu2.close()
				end)

end

---------------- KATEGORİ FONKSİYONLARI YUKARIDA -------------------



Citizen.CreateThread(function ()
  while true do
	Citizen.Wait(1)

	local coords = GetEntityCoords(GetPlayerPed(-1))
--				DrawMarker(type, posX, posY, posZ, dirX, dirY, dirZ, rotX, rotY, rotZ, scaleX, scaleY, scaleZ, colorR, colorG, colorB, alpha, bobUpAndDown, faceCamera, unknown, rotate, *textureDict, *textureName, drawOnEnts)
		for k,v in pairs(Config.Zones) do
			if(27 ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 20.0 ) then
				if v.Pos.red then
					DrawMarker(23, v.Pos.x, v.Pos.y, v.Pos.z + 0.05, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.2, 180, 0, 0, 200, false, true, 2, false, false, false, false)
					DrawMarker(29, v.Pos.x, v.Pos.y, v.Pos.z + 1.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 180, 0, 0, 200, false, true, 2, false, false, false, false)		
				else
					DrawMarker(23, v.Pos.x, v.Pos.y, v.Pos.z + 0.05, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.2, 255, 0, 0, 200, false, true, 2, false, false, false, false)
					DrawMarker(29, v.Pos.x, v.Pos.y, v.Pos.z + 1.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 0, 0, 200, false, true, 2, false, false, false, false)
				end
	        end
	    end
    end
end)


Citizen.CreateThread(function ()
  while true do
	Citizen.Wait(25)

	local coords      = GetEntityCoords(GetPlayerPed(-1))
	local isInMarker  = false
	local currentZone = nil

	for k,v in pairs(Config.Zones) do
	  if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.2) then
		isInMarker  = true
		currentZone = v.Pos.number
	  end
	end

	if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
	  HasAlreadyEnteredMarker = true
	  LastZone                = currentZone
	  TriggerEvent('esx_blackmarket:hasEnteredMarker', currentZone)
	end

	if not isInMarker and HasAlreadyEnteredMarker then
	  HasAlreadyEnteredMarker = false
	  TriggerEvent('esx_blackmarket:hasExitedMarker', LastZone)
	end
  end
end)

RegisterNetEvent('esx_blackmarkets:setBlip')
AddEventHandler('esx_blackmarkets:setBlip', function()

  	ESX.TriggerServerCallback('esx_blackmarket:getOwnedBlips', function(blips)

		if blips ~= nil then
			createBlip(blips)
	  	end
   	end)
end)

RegisterNetEvent('esx_blackmarkets:removeBlip')
AddEventHandler('esx_blackmarkets:removeBlip', function()

	for i=1, #displayedBlips do
    	RemoveBlip(displayedBlips[i])
	end

end)

AddEventHandler('playerSpawned', function(spawn)
	Citizen.Wait(500)

	ESX.TriggerServerCallback('esx_blackmarket:getOwnedBlips', function(blips)

		if blips ~= nil then
			createBlip(blips)
		end
	end)
end)



Citizen.CreateThread(function()
	Citizen.Wait(500)

	ESX.TriggerServerCallback('esx_blackmarket:getOwnedBlips', function(blips)

		if blips ~= nil then
			createBlip(blips)
		end
	end)
end)


function createBlip(blips)
	for i=1, #blips, 1 do
  		for k,v in pairs(Config.Zones) do
			if v.Pos.number == blips[i].ShopNumber then
				local blip = AddBlipForCoord(vector3(v.Pos.x, v.Pos.y, v.Pos.z))
					SetBlipSprite (blip, 52)
					SetBlipDisplay(blip, 4)
					SetBlipScale  (blip, 0.7)
					SetBlipColour (blip, 2)
					SetBlipAsShortRange(blip, true)
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString(blips[i].ShopName)
                    EndTextCommandSetBlipName(blip)
					table.insert(displayedBlips, blip)
			end
 		end
	end
end




RegisterNetEvent("mt:missiontext") -- credits: https://github.com/schneehaze/fivem_missiontext/blob/master/MissionText/missiontext.lua
AddEventHandler("mt:missiontext", function(text, time)
		ClearPrints()
		SetTextEntry_2("STRING")
		AddTextComponentString(text)
		DrawSubtitleTimed(time, 1)
end)
