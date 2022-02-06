local QBCore = exports["qb-core"]:GetCoreObject()
local metaDataName = "cardeliveryxp"

RegisterNetEvent("QB-CD_cardelivery:start_cooldown")
AddEventHandler("QB-CD_cardelivery:start_cooldown", function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	cdCooldown = true
	TriggerClientEvent("qb-cocaintruck:update-cooldown", -1, cdCooldown)

	if Player.PlayerData.metadata[metaDataName] ~= nil then
		TriggerClientEvent("qb-cocaintruck:client-receive-rank", src, Player.PlayerData.metadata[metaDataName])
	else
		TriggerClientEvent("qb-cocaintruck:client-receive-rank", src, 0)
	end

	CreateThread(function()
		for cooldownTime = cooldown, 0, -1 do
			Citizen.Wait(1000)
			secondsLeft = cooldownTime
		end
		cdCooldown = false
		TriggerClientEvent("qb-cocaintruck:update-cooldown", -1, cdCooldown)
	end)
end)

RegisterNetEvent("qb-cocaintruck:cooldown-request")
AddEventHandler("qb-cocaintruck:cooldown-request", function()
	local src = source
	TriggerClientEvent("qb-cocaintruck:update-cooldown", src, cdCooldown)
end)

RegisterNetEvent("qb-cocaintruck:request-cooldown-time")
AddEventHandler("qb-cocaintruck:request-cooldown-time", function()
	TriggerClientEvent("QBCore:Notify", source, (text_cooldown .. " - " .. secondsLeft .. " " .. text_secondsLeft), "primary", 3000)
end)


--- Change here at "Cokebaggy" and "['cokebaggy'] Your item, if you want to change the random math Chance the 100,200, 
RegisterNetEvent('qb-cocaintruck:server:receiveCB', function()
	local xPlayer = QBCore.Functions.GetPlayer(tonumber(source))
	xPlayer.Functions.AddItem("cokebaggy", math.random(100, 200), false)
	TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['cokebaggy'], "add")
end)



RegisterNetEvent("qb-cocaintruck:GetMetaData")
AddEventHandler("qb-cocaintruck:GetMetaData", function()
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
		
	if Player.PlayerData.metadata[metaDataName] ~= nil then
		TriggerClientEvent("qb-cocaintruck:client-receive-rank", src, Player.PlayerData.metadata[metaDataName])
	else
		TriggerClientEvent("qb-cocaintruck:client-receive-rank", src, 0)
	end
end)

RegisterNetEvent("qb-cocaintruck:SetMetaData", function(meta, data)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player then
		Player.Functions.SetMetaData(meta, data)
		TriggerClientEvent("qb-cocaintruck:client-receive-rank", src, data)
	end
end)

function setMetaData(Player, meta, data)
	if Player then
		Player.Functions.SetMetaData(meta, data)
		TriggerClientEvent("qb-cocaintruck:client-receive-rank", src, data)
	end
end

function UpdateRank(Player, change, metadata)
	change = tonumber(change)
	if metadata + change < 0 then
		change = metadata * (-1)
	end
	setMetaData(Player, metaDataName, metadata + change)
end

function SetRank(Player, change)
	change = tonumber(change)
	if change < 0 then
		change = 0
	end
	setMetaData(Player, metaDataName, change)
end

QBCore.Commands.Add(text_adminXPEditCommand, text_adminXPEditDescription, {
	{
		name = text_option,
		help = text_optionHelp
	},
	{
		name = text_number,
		help = text_numberHelp
	}
}, true, function(source, args)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local metadata = Player.PlayerData.metadata[metaDataName]
	if args[1] and args[2] then
		if args[1] == text_add then
			UpdateRank(Player, args[2], metadata)
		elseif args[1] == text_set then
			SetRank(Player, args[2])
		elseif args[1] == text_reduce then
			UpdateRank(Player, tonumber(args[2]) * -1, metadata)
		else
			TriggerClientEvent("QBCore:Notify", source, text_noSuchParameter, "error")
		end
	else
		TriggerClientEvent("QBCore:Notify", source, text_notEveryArgumentWasEntered, "error")
	end
end, "admin")

QBCore.Commands.Add(text_getXpCommand, text_getXpDescription, {}, true, function(source, args)
	local src = source
	local level = 1
	local Player = QBCore.Functions.GetPlayer(src)
	local metadata = Player.PlayerData.metadata[metaDataName]

	if metadata ~= nil then
		-- Loop that checks player level
		for i=1, #levelXpGoal, 1 do
			if metadata >= levelXpGoal[i] then
				level = i + 1
			end
		end

		TriggerClientEvent("QBCore:Notify", source, (text_level .. " " .. level .. " (" .. metadata .. ")"), "primary")
	end
end)

function RefreshCommands(source)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local suggestions = {}
	if Player then
		for command, info in pairs(QBCore.Commands.List) do
			local isGod = QBCore.Functions.HasPermission(src, "god")
			local hasPerm = QBCore.Functions.HasPermission(src, QBCore.Commands.List[command].permission)
			local isPrincipal = IsPlayerAceAllowed(src, "command")
			if isGod or hasPerm or isPrincipal then
				suggestions[#suggestions + 1] = {
					name = ("/" .. command),
					help = info.help,
					params = info.arguments
				}
			end
		end
		TriggerClientEvent("chat:addSuggestions", tonumber(source), suggestions)
	end

end

RefreshCommands(source)