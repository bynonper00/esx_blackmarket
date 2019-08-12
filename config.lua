Config                            = {}
Config.DrawDistance               = 20.0
Config.Locale = 'tr'
Config.DeliveryTime = 67 -- SİPARİŞ EDİLEN SİLAHLARIN GELECEĞİ SÜREYİ BELİRLER ( SANİYE )
Config.CutOnRobbery = 10 -- IN PERCENTAGE FROM THE TARGET SHOP

---------------------------------------

Config.PolisiAra           = true -- Silahları teslim alırken polis alarmını aktif etmek için true ayarlayın
Config.PolisiAramaYuzdesi    = 1 -- 1=100%, 2=50%, 3=33%, 4=25%, 5=20%.
Config.BeklemeSuresi = 10 --Polislerin gördüğü bliplerin arasindaki süre uzunluğunu ayarlar (saniye)
Config.BlipSayisi = 10 --Silahları alınca polislere haritadan kaç kere blip gösterileceğini ayarlar

---------------------------------------

-- KARA MARKETTEKİ İTEMLERİ AŞAĞIDAN DÜZENLEYEBİLİRSİNİZ
-- İTEM EKLEMEK VEYA ÇIKARMAK İSTERSENİZ LABEL SIRALARINA DİKKAT EDİN AYNI OLMAMASI VE ATLAMA OLMAMASI ÖNEMLİDİR ( [1] , [2] ) 


--[[ 

Config.Items = {
		[1] = {label = "Pistol",      item = "weapon_pistol",       price = 5},
}

--]]


Config.ItemsSaldiri = {
    	[1] = {label = "Assault Rifle",      item = "weapon_assaultrifle",       price = 5},
		[2] = {label = "Carbine Rifle",      item = "weapon_carbinerifle",       price = 5},
		[3] = {label = "Advanced Rifle",      item = "weapon_advancedrifle",       price = 5},
		[4] = {label = "Special Carbine",      item = "weapon_specialcarbine",       price = 5},
}

Config.ItemsTaramali = {
    	[1] = {label = "Micro SMG",      item = "weapon_microsmg",       price = 5},
		[2] = {label = "SMG",      item = "weapon_smg",       price = 5},
		[3] = {label = "CombatPDW",      item = "weapon_combatpdw",       price = 5},
		[4] = {label = "Assault SMG",      item = "weapon_assaultsmg",       price = 5},
}

Config.ItemsKeskin = {
    	[1] = {label = "Sniper Rifle",      item = "weapon_sniperrifle",       price = 5},
		[2] = {label = "Heavy Sniper",      item = "weapon_heavysniper",       price = 5},
		[3] = {label = "Marksman Rifle",      item = "weapon_marksmanrifle",       price = 5},
}

Config.ItemsPompali = {
    	[1] = {label = "Pump Shotgun",      item = "weapon_PumpShotgun",       price = 5},
		[2] = {label = "Sawn Off Shotgun",      item = "weapon_SawnoffShotgun",       price = 5},
		[3] = {label = "Assault Shotgun",      item = "weapon_AssaultShotgun",       price = 5},
		[4] = {label = "Musket",      item = "weapon_Musket",       price = 5},
}

Config.ItemsUzunPatla = {
    	[1] = {label = "RPG",      item = "weapon_RPG",       price = 5},
		[2] = {label = "Firework",      item = "Firework",       price = 5},
}

Config.ItemsPatla = {
    	[1] = {label = "Yapiskan Bomba",      item = "WEAPON_STICKYBOMB",       price = 5},
		[2] = {label = "Molotof",      item = "WEAPON_MOLOTOV",       price = 5},
		[3] = {label = "Bomba",      item = "WEAPON_GRENADE",       price = 5},
		[4] = {label = "Mayın",      item = "WEAPON_PROXMINE",       price = 5},
}

Config.ItemsMuhimmat = {
		[1] = {label = "Tabanca Sarjor",      item = "sarjorpistol",       price = 5},
		[2] = {label = "Taramali Sarjor",      item = "sarjortaramali",       price = 5},
		[3] = {label = "Agir Taramali Sarjor",      item = "sarjoragirtaramali",       price = 5},
    	[4] = {label = "Keskin Nisanci Sarjor",      item = "sarjorkeskin",       price = 5},
		[5] = {label = "Pompali Sarjor",      item = "sarjorpompali",       price = 5},
		[6] = {label = "Roket",      item = "sarjorroket",       price = 5},
}



-- X, Y, Z KOORDİNATLARI İLE KARA MARKETİN KONUMUNU AYARLAYABİLİRSİNİZ

Config.Zones = {
  Shop1 = {
    Pos   = {x = 411.39,   y = 2678.47,  z = 42.9, number = 1},
  },
}