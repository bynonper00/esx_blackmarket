ESX               = nil
local ItemsLabels = {}
local GunShopPrice = Config.EnableClip.GunShop.Price
local GunShopLabel = Config.EnableClip.GunShop.Label
local BlackWeashopPrice = Config.EnableClip.BlackWeashop.Price
local BlackWeashopLabel = Config.EnableClip.BlackWeashop.Label

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function LoadLicenses (source)
  TriggerEvent('esx_license:getLicenses', source, function (licenses)
    TriggerClientEvent('esx_weashop:loadLicenses', source, licenses)
  end)
end

if Config.EnableLicense == true then
  AddEventHandler('esx:playerLoaded', function (source)
    LoadLicenses(source)
  end)
end

RegisterServerEvent('esx_weashop:buyLicense')
AddEventHandler('esx_weashop:buyLicense', function ()
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(source)

  if xPlayer.get('money') >= Config.LicensePrice then
    xPlayer.removeMoney(Config.LicensePrice)

    TriggerEvent('esx_license:addLicense', _source, 'weapon', function ()
      LoadLicenses(_source)
    end)
  else
    TriggerClientEvent('esx:showNotification', _source, _U('not_enough'))
  end
end)


ESX.RegisterServerCallback('esx_weashop:requestDBItems', function(source, cb)

  MySQL.Async.fetchAll(
    'SELECT * FROM weashops',
    {},
    function(result)

      local shopItems  = {}

      for i=1, #result, 1 do

        if shopItems[result[i].name] == nil then
          shopItems[result[i].name] = {}
        end

        table.insert(shopItems[result[i].name], {
          name  = result[i].item,
          price = result[i].price,
          label = ESX.GetWeaponLabel(result[i].item)
        })
      end
	  
	  if Config.EnableClipGunShop == true then
		table.insert(shopItems["GunShop"], {
          name  = "clip",
          price = GunShopPrice,--Config.EnableClip.GunShop.Price,
          label = GunShopLabel--Config.EnableClip.GunShop.label
        })
		end
		
		if Config.EnableClipGunShop == true then
		table.insert(shopItems["BlackWeashop"], {
          name  = "clip",
          price = BlackWeashopPrice,--Config.EnableClip.BlackWeashop.Price,
          label = BlackWeashopLabel--Config.EnableClip.BlackWeashop.label
        })
		end
      cb(shopItems)

    end
  )

end)


RegisterServerEvent('esx_weashop:buyItem')
AddEventHandler('esx_weashop:buyItem', function(itemName, price, zone)

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)
  local account = xPlayer.getAccount('black_money')

  if zone=="BlackWeashop" then
    if account.money >= price then
		if itemName == "clip" then
			xPlayer.addInventoryItem(itemName, 1)
			TriggerClientEvent('esx:showNotification', _source, _U('buy') .. "chargeur")
		else
			xPlayer.addWeapon(itemName, 42)
			TriggerClientEvent('esx:showNotification', _source, _U('buy') .. ESX.GetWeaponLabel(itemName))
		end
		xPlayer.removeAccountMoney('black_money', price)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_black'))
	end

  else if xPlayer.get('money') >= price then
		if itemName == "clip" then
			xPlayer.addInventoryItem(itemName, 1)
			TriggerClientEvent('esx:showNotification', _source, _U('buy') .. "chargeur")
		else
			
			xPlayer.addWeapon(itemName, 42)
			TriggerClientEvent('esx:showNotification', _source, _U('buy') .. ESX.GetWeaponLabel(itemName))
		end
		xPlayer.removeMoney(price)
  else
    TriggerClientEvent('esx:showNotification', _source, _U('not_enough'))
  end
  end

end)

-- thx to Pandorina for script
RegisterServerEvent('esx_weashop:remove')
AddEventHandler('esx_weashop:remove', function(silahSarjor)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(silahSarjor, 1)
end)

ESX.RegisterUsableItem('sarjorpistol', function(source)
	TriggerClientEvent('esx_weashop:clipcli', source, 453432689, 'sarjorpistol', 50)
end)

ESX.RegisterUsableItem('sarjortaramali', function(source)
	TriggerClientEvent('esx_weashop:clipcli', source, 324215364, 'sarjortaramali', 80)
end)

ESX.RegisterUsableItem('sarjoragirtaramali', function(source)
	TriggerClientEvent('esx_weashop:clipcli', source, 3220176749, 'sarjoragirtaramali', 60)
end)

ESX.RegisterUsableItem('sarjorroket', function(source)
	TriggerClientEvent('esx_weashop:clipcli', source, 2982836145, 'sarjorroket', 1)
end)

ESX.RegisterUsableItem('sarjorpompali', function(source)
	TriggerClientEvent('esx_weashop:clipcli', source, 487013001, 'sarjorpompali', 16)
end)

ESX.RegisterUsableItem('sarjorkeskin', function(source)
	TriggerClientEvent('esx_weashop:clipcli', source, 205991906, 'sarjorkeskin', 8)
end)
