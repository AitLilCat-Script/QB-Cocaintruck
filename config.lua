-- Sends you a message of where and what car to get
notification = true
showAboveHead = true        -- Shows up above the NPCs head, otherwise in HUD

-- NPC spawn location
showNpc = true
npcHeading = 205.9
npcCoords = vector3(264.19, -3244.43, 5.79)
showblip = false

-- XP related settings
rankPenalty = -120         -- XP penalty for keeping or destroying the vehicle
xpGain = 100               -- XP gain for completing the job

-- Start circle size
startSize = 5

-- Cooldown in seconds after job completion to prevent re-taking the job immediately
cooldown = 120

-- Ability to keep the vehicle after the job
abilityToKeepVehicle = false

-- If set to true, the car will spawn with a driver, who will drive it around (currently non-functional)
driveAround = false

-- Time in seconds to decide whether to keep the vehicle
choiceTimer = 20

-- Change the string to have a different NPC model (use appropriate model hash)
pedModel = GetHashKey("g_m_y_lost_01")

-- Cop car settings: controls whether a cop car chases the player
copSpawn = false
chanceToSpawnCop = 5       -- Chance of a cop car spawning (e.g., 5 means 1 in 5 chance)

-- XP goal for different levels, add more levels as needed
levelXpGoal = {
    4000,  -- Level 2
    8000,  -- Level 3
    9000,  -- Level 4
}

-- Vehicle models for each level; replace with server-specific models if needed
vehicles = {
    { -- Level 1
        {model="pounder", name="Cocaine Truck"},
        {model="pounder", name="Cocaine Truck"},
        {model="pounder", name="Cocaine Truck"},
    },
    { -- Level 2
        {model="pounder", name="Cocaine Truck"},
        {model="pounder", name="Cocaine Truck"},
        {model="pounder", name="Cocaine Truck"},
    },
    { -- Level 3
        {model="pounder", name="Cocaine Truck"},
        {model="pounder", name="Cocaine Truck"},
        {model="pounder", name="Cocaine Truck"},
    },
    { -- Level 4
        {model="pounder", name="Cocaine Truck"},
        {model="pounder", name="Cocaine Truck"},
        {model="pounder", name="Cocaine Truck"},
    },
}

-- Locations for parked vehicles and cop car spawn points
parked_spawns = { 
    {name="Airfield", x=1402.25, y=2999.21, z=40.55, heading=264.75, copHeading=332.55, copx=741.46, copy=-1766.14, copz=28.29},
    {name="Desert", x=2707.01, y=4148.92, z=43.75, heading=280, copx=656.72, copy=-2791.2, copz=5.87, copHeading=289.29},
    {name="Paleto", heading=180, x=203.68, y=6385.48, z=31.4, copHeading=332.55, copx=741.46, copy=-1766.14, copz=28.29},
}

-- Locations where driving vehicles spawn (these should be realistic places for the job)
drive_spawns = {
    {name="Example Drive", heading=179, x=-789.6, y=-821.9, z=20.43},
}

-- Delivery locations for stolen vehicles (range determines the payout)
destinations = { 
    {name="Police Station", x=451.44, y=-903.54, z=28.45, from=1200, to=1400},
    {name="Hotel", x=292.6, y=-694.63, z=29.3, from=1500, to=1700},
    {name="Train Yard", x=490.19, y=-542.02, z=24.75, from=1800, to=2000},
    {name="Fire Station", x=180.87, y=-1671.47, z=29.57, from=2000, to=2200},
}

-- Optional Improvements / Future Expansion Ideas:
-- 1. Add more levels to `levelXpGoal` for further progression.
-- 2. Customize vehicle models per rank to diversify gameplay.
-- 3. Enable `driveAround` functionality for dynamic vehicle behavior.
-- 4. Consider adding additional cop spawn chances based on player actions or job progression.
