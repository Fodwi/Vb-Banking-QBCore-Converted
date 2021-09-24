QBCore = nil 

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Functions.CreateCallback('vb-banking:server:GetPlayerName', function(source, cb)
	local _char = QBCore.Functions.GetPlayer(source)
	local _charname = _char.PlayerData.charinfo.firstname .. ' ' .. _char.PlayerData.charinfo.lastname
	cb(_charname)
end)

RegisterServerEvent('vb-banking:server:depositvb')
AddEventHandler('vb-banking:server:depositvb', function(amount, inMenu)
	local _src = source
	local _char = QBCore.Functions.GetPlayer(_src)
	amount = tonumber(amount)
	Wait(50)
	if amount == nil or amount <= 0 or amount > _char.PlayerData.money['cash'] then
		TriggerClientEvent('chatMessage', _src, "Cantidad Inválida.")
	else
		_char.Functions.RemoveMoney('cash', amount, "Bank")
		_char.Functions.AddMoney('bank', tonumber(amount), "Bank")
		TriggerClientEvent('QBCore:Notify', "Has ingresado $".. amount)
	end
end)

RegisterServerEvent('vb-banking:server:withdrawvb')
AddEventHandler('vb-banking:server:withdrawvb', function(amount, inMenu)
	local _src = source
	local _char = QBCore.Functions.GetPlayer(_src)
	local _base = 0
	amount = tonumber(amount)
	_base = _char.PlayerData.money['bank']
	Wait(100)
	if amount == nil or amount <= 0 or amount > _base then
		TriggerClientEvent('chatMessage', _src, "Cantidad Inválida")
	else
		_char.Functions.RemoveMoney('bank', amount, "Bank")
		_char.Function.AddMoney('bank', amount, "Bank")
		TriggerClientEvent('QBCore:Notify', "Has retirado $".. amount)
	end
end)

RegisterServerEvent('vb-banking:server:balance')
AddEventHandler('vb-banking:server:balance', function(inMenu)
	local _src = source
	local _char = QBCore.Functions.GetPlayer(_src)
	local balance =_char.PlayerData.money['bank']
	TriggerClientEvent('vb-banking:client:refreshbalance', _src, balance)
end)

RegisterServerEvent('vb-banking:server:transfervb')
AddEventHandler('vb-banking:server:transfervb', function(to, amountt, inMenu)
	local _src = source
	local Player = QBCore.Functions.GetPlayer(_src)
	local zPlayer = QBCore.Functions.GetPlayer(tonumber(to))
	local bankAmount = Player.PlayerData.money['bank']
	local balance = 0
	if zPlayer ~= nil then
		balance = bankAmount
		if tonumber(_src) == tonumber(to) then
			TriggerClientEvent('chatMessage', _src, "No te puedes transferir dinero a ti mismo")	
		else
			if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <= 0 then
				TriggerClientEvent('chatMessage', _src, "No tienes suficiente dinero en el banco.")
			else
				Player.Functions.RemoveMoney('bank', tonumber(amountt), "Bank Transfer")
				zPlayer.Functions.AddMoney('bank', tonumber(amountt), "Bank Transfer")
				
				TriggerClientEvent('QBCore:Notify', Player, "Has enviado una transferencia de "..amountt.."$ a la ID: "..to)
				TriggerClientEvent('QBCore:Notify', zPlayer, "Te han enviado una transferencia de "..amountt.."$ por parte de la ID: ".._src)			
			end
		end
	else
		TriggerClientEvent('chatMessage', _src, "That Wallet ID is invalid or doesn't exist")
	end
end)