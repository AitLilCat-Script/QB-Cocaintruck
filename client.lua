local QBCore = exports['qb-core']:GetCoreObject()

-- Global variables (organized into tables)
local playerData = {
    isWorking = false,
    player = nil,
    isLoggedIn = false,
    timeout = 0,
    rank = nil,
    npc = nil,
    cop = nil,
    copVehicle = nil,
    vehicle = nil,
    vehicleChoice = nil,
    spawnLocation = nil,
    destinationLocation = nil,
    ped = nil,
    spawns = nil,
    spawnDriving = false
}

local models = {
    tableModel = GetHashKey("prop_table_03b"),
    laptopModel = GetHashKey("prop_laptop_01a"),
    vehicleHash = GetHashKey("police4"),
    pedHash = GetHashKey("s_m_y_cop_01")
}

local npcCoords = vector3(0, 0, 0)  -- Define appropriate coordinates here
local drive_spawns = {}  -- Define your spawn locations
local parked_spawns = {}  -- Define your parked spawn locations
local destinations = {}  -- Define your destination locations

-- Event Handlers
RegisterNetEvent('qb-cocaintruck:client-receive-rank')
AddEventHandler('qb-cocaintruck:client-receive-rank', function(rank_in)
    playerData.rank = rank_in
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    TriggerServerEvent("qb-clothes:loadPlayerSkin")
    playerData.isLoggedIn = true
    playerData.player = PlayerPedId()

    if not playerData.npc then
        spawnEntities()
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    playerData.isLoggedIn = false
end)

-- Helper function to spawn entities
function spawnEntities()
    RequestModel(models.tableModel)
    while not HasModelLoaded(models.tableModel) do Citizen.Wait(5) end

    RequestModel(models.laptopModel)
    while not HasModelLoaded(models.laptopModel) do Citizen.Wait(5) end

    -- Spawn table and laptop
    playerData.table = CreateObject(models.tableModel, npcCoords.x, npcCoords.y, npcCoords.z - 0.99, false, true, false)
    playerData.laptop = CreateObject(models.laptopModel, npcCoords.x, npcCoords.y, npcCoords.z - 0.2, false, true, false)
    FreezeEntityPosition(playerData.table, true)
    FreezeEntityPosition(playerData.laptop, true)

    -- Spawn NPC if not already spawned
    if not playerData.npc then
        RequestModel(models.pedHash)
        while not HasModelLoaded(models.pedHash) do Citizen.Wait(5) end

        playerData.npc = CreatePed(4, models.pedHash, npcCoords.x, npcCoords.y, npcCoords.z - 1, 0, false, true)
        FreezeEntityPosition(playerData.npc, true)
        SetEntityInvincible(playerData.npc, true)
        SetBlockingOfNonTemporaryEvents(playerData.npc, true)
        TaskStartScenarioInPlace(playerData.npc, "WORLD_HUMAN_DRUG_DEALER", 0, true)
    end
end

-- Handles spawning a cop car
function spawnCopCar()
    RequestModel(models.vehicleHash)
    while not HasModelLoaded(models.vehicleHash) do Citizen.Wait(5) end

    local spawn = playerData.spawnDriving and drive_spawns[playerData.spawnLocation] or parked_spawns[playerData.spawnLocation]
    playerData.copVehicle = CreateVehicle(models.vehicleHash, spawn.copx, spawn.copy, spawn.copz, spawn.copHeading, true, true)

    SetModelAsNoLongerNeeded(models.vehicleHash)
    playerData.cop = CreatePed(4, models.pedHash, 0, 0, 0, 0, true, true)
    GiveWeaponToPed(playerData.cop, "weapon_pistol", 999, false, true)
    SetPedIntoVehicle(playerData.cop, playerData.copVehicle, -1)
end

-- Function for spawning a vehicle with AI
function carWithAi()
    CreateThread(function()
        TriggerServerEvent("hiype_cardelivery:start_cooldown")
        TriggerServerEvent('qb-cocaintruck:GetMetaData')
        playerData.vehicleChoice = math.random(1, #vehicles[playerData.rank])
        local model = GetHashKey(vehicles[playerData.rank][playerData.vehicleChoice].model)

        RequestModel(model)
        local modelLoadingTimeout = 5000
        while not HasModelLoaded(model) do
            Citizen.Wait(10)
            modelLoadingTimeout = modelLoadingTimeout - 10
            if modelLoadingTimeout <= 0 then
                QBCore.Functions.Notify("Car model loading timed out", "error", 6000)
                playerData.isWorking = false
                return
            end
        end

        -- Decide if the car should spawn parked or driving
        playerData.spawns = (math.random(0, 10) % 2 == 1) and drive_spawns or parked_spawns
        playerData.spawnLocation = math.random(1, #playerData.spawns)

        playerData.vehicle = CreateVehicle(model, playerData.spawns[playerData.spawnLocation].x, playerData.spawns[playerData.spawnLocation].y, playerData.spawns[playerData.spawnLocation].z, playerData.spawns[playerData.spawnLocation].heading, true, true)

        local netid = NetworkGetNetworkIdFromEntity(playerData.vehicle)
        SetVehicleHasBeenOwnedByPlayer(playerData.vehicle, true)
        SetNetworkIdCanMigrate(netid, true)
        SetEntityAsMissionEntity(playerData.vehicle, true, true)

        SetModelAsNoLongerNeeded(model)

        -- Lock doors and set hotwiring
        if playerData.spawnDriving then
            SetVehicleDoorsLocked(playerData.vehicle, 1)
            SetVehicleNeedsToBeHotwired(playerData.vehicle, false)
        else
            SetVehicleDoorsLocked(playerData.vehicle, 2)
            SetVehicleNeedsToBeHotwired(playerData.vehicle, true)
        end

        -- Handle NPC pedestrian if vehicle is driving
        if playerData.spawnDriving then
            playerData.ped = CreatePed(4, models.pedHash, playerData.spawns[playerData.spawnLocation].x, playerData.spawns[playerData.spawnLocation].y, playerData.spawns[playerData.spawnLocation].z, 0, true, true)
            SetPedIntoVehicle(playerData.ped, playerData.vehicle, -1)
            TaskVehicleDriveWander(playerData.ped, playerData.vehicle, 15.0, 786603)
        end

        -- Add blip to vehicle
        local vehBlip = AddBlipForEntity(playerData.vehicle)
        SetBlipRoute(vehBlip, true)
        SetBlipColour(vehBlip, 5)
        SetBlipRouteColour(vehBlip, 5)

        -- Handle vehicle interaction and navigation
        local playerCoords = GetEntityCoords(PlayerPedId())
        while not IsPedInVehicle(PlayerPedId(), playerData.vehicle, true) and playerData.isWorking and IsVehicleDriveable(playerData.vehicle, true) do
            Citizen.Wait(5)
            -- Logic for NPC pathfinding and interaction
        end

        SetBlipRoute(vehBlip, false)
        RemoveBlip(vehBlip)
    end)
end

-- Main loop for checking proximity and interaction
CreateThread(function()
    while true do
        Citizen.Wait(10)
        local pCoords = GetEntityCoords(PlayerPedId())

        if Vdist2(npcCoords, pCoords) < 10.0 and playerData.isLoggedIn then
            if IsControlPressed(0, 38) then
                if not playerData.isWorking then
                    playerData.isWorking = true
                    QBCore.Functions.Notify("You started a job", "success", 6000)
                    carWithAi()
                else
                    playerData.isWorking = false
                    QBCore.Functions.Notify("You quit the job", "error", 6000)
                end
            end
        end
    end
end)
