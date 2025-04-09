QBCore = exports['qb-core']:GetCoreObject()
levelXpGoal = {200, 500, 1000, 2000, 3000} -- XP required for each level
text_adminXPEditCommand = 'adminxpedit'
text_add = 'add'
text_reduce = 'reduce'
text_set = 'set'
text_number = 'number'
text_option = 'option'
text_noSuchParameter = 'No such parameter.'
text_notEveryArgumentWasEntered = 'Not every argument was entered.'
text_adminXPEditDescription = 'Command to edit admin XP, usage: /adminxpedit [add/reduce/set] [number].'
text_getXpCommand = 'getxp'
text_level = 'Your level:'
text_noPermission = 'You do not have permission to perform this command.'

-- No need to check every time, just set it once when the player joins
QBCore.Functions.CreateCallback('qb-core:server:playerLoaded', 'adminXP', function(source)
    RefreshCommands(source)
end)

function RefreshCommands(source)
    local suggestions = {}
    if QBCore.Functions.IsPlayerAdmin(source) then
        for command, info in pairs(QBCore.Commands.List) do
            suggestions[#suggestions + 1] = {
                name = '/' .. command,
                help = info.help,
                params = info.arguments
            }
        end
        TriggerClientEvent('chat:addSuggestions', source, suggestions)
    end
end

-- Adding an admin XP command to the QBCore Commands system
QBCore.Commands.Add(text_adminXPEditCommand, text_adminXPEditDescription, {
    { name = text_option, help = 'Option: add, reduce or set' },
    { name = text_number, help = 'Number of XP points to add/reduce/set.' }
}, false, function(source, args)
    if QBCore.Functions.IsPlayerAdmin(source) then
        if not next(args) then
            return TriggerClientEvent('QBCore:Notify', source, text_notEveryArgumentWasEntered, 'error')
        end
        local Player = QBCore.Functions.GetPlayer(source)
        local metadata = Player.PlayerData.metadata[text_adminXPEditCommand] or 0
        if args[1] == text_add then
            return UpdateRank(Player, tonumber(args[2]))
        elseif args[1] == text_set then
            return SetRank(Player, tonumber(args[2]))
        elseif args[1] == text_reduce then
            return UpdateRank(Player, -tonumber(args[2]))
        else
            return TriggerClientEvent('QBCore:Notify', source, text_noSuchParameter, 'error')
        end
    end
end)

function UpdateRank(Player, change, metadata)
    if not metadata then return end
    change = tonumber(change) or 0
    if (metadata + change) < 0 then
        return SetRank(Player, 0)
    else
        return setMetaData(Player, text_adminXPEditCommand, metadata + change)
    end
end

function SetRank(Player, change)
    change = tonumber(change) or 0
    return setMetaData(Player, text_adminXPEditCommand, change)
end

function setMetaData(Player, meta, data)
    if not Player then return end
    data = tonumber(data) or 0
    TriggerClientEvent('qb-core:client:setPlayerMetadata', -1, {
        [meta] = data
    }, true)
    return TriggerClientEvent('QBCore:Notify', source, 'Admin XP updated.')
end
