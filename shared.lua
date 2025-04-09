-- Shared variables between client and server

-- Cooldown for job (boolean, whether the job is on cooldown or not)
cdCooldown = false

-- Timer for cooldown in seconds
secondsLeft = 0

-- Store player XP data for tracking levels and experience (can be expanded)
playerXP = {
    currentXP = 0,           -- Current XP
    level = 1,               -- Current level
    nextLevelXP = 4000,      -- XP needed to level up (could vary per level)
    totalXP = 0,             -- Total XP earned across all sessions
}

-- Settings related to the job (customizable for future scaling)
jobSettings = {
    -- Time in seconds to cancel the job (e.g., if the player doesn't keep the car)
    jobCancelTime = choiceTimer, 

    -- Time to wait for vehicle to spawn or load
    vehicleLoadTimeout = 60,  -- seconds

    -- Minimum XP required to take a job at different levels
    minXPForJob = {
        level1 = 0,   -- Level 1 job can be taken without any XP
        level2 = 4000,
        level3 = 8000,
        level4 = 12000,
    },
}

-- Track NPC-related information (for NPC spawn and behavior)
npcInfo = {
    model = pedModel,               -- NPC model
    spawnCoords = npcCoords,        -- NPC spawn location
    heading = npcHeading,           -- NPC facing direction
    showAboveHead = showAboveHead,  -- Whether NPC shows name above their head
}

-- Locations for the delivery job (parked and driving vehicle locations)
deliveryLocations = {
    parked = parked_spawns,         -- Where parked vehicles are located
    driving = drive_spawns,         -- Where the driving vehicles spawn
}

-- Delivery locations (can be expanded based on game requirements)
deliveryDestinations = destinations

-- Custom vehicles by level (can be added or modified as the game scales)
vehiclesByLevel = vehicles

-- Functions to calculate and handle XP or job progress (can be extended)
function getXPForLevel(level)
    return playerXP.totalXP >= jobSettings.minXPForJob["level"..level]
end

-- Function to check cooldown status
function checkCooldownStatus()
    return cdCooldown
end

-- Function to reduce cooldown time (this can be triggered periodically in client or server)
function reduceCooldown()
    if secondsLeft > 0 then
        secondsLeft = secondsLeft - 1
    else
        cdCooldown = false
    end
end
