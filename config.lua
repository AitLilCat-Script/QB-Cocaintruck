-- Sends you a message of where and what car to get
notification = true
showAboveHead = true        -- Shows up above the npcs head, otherwise in HUD

-- Npc spawn location
showNpc = true
npcHeading = 205.9
npcCoords = vector3(264.19, -3244.43, 5.79)
showblip = false

-- The amount of xp subtracted for keeping the car or destroying it
rankPenalty = -120
xpGain = 100

-- The size of the circle where player enters to start the job
startSize = 5

-- Cooldown in seconds that forbids players to take this job again if it was recently taken
cooldown = 120

-- Set true if you want to be able to keep the vehicle and cancel the job
abilityToKeepVehicle = false

-- DOES NOT WORK YET if set to true, but does not break the script, the job can still be completed
-- Should the stealable car be spawned with a driver so it drives around
driveAround = false

-- Time in seconds in which you need to choose to keep the vehicle
choiceTimer = 20

-- Change the string to have a different npc model
pedModel = GetHashKey("g_m_y_lost_01")

-- The possibility for a cop car to spawn that chases after player
copSpawn = false
chanceToSpawnCop = 5        -- The chance that the cop spawns, for example 2 means 1/2 chance, 5 would be 1/5 chance and so on

-- Xp you need to reach that level, you can add more
levelXpGoal = {
    4000, -- Level 2
    8000, -- Level 3
    9000, -- Level 4
}

-- You should replace these custom vehicles if your server does not have them
-- You can add more levels
vehicles = {
    { -- Level 1
        {model="pounder", name="cocain truck"},
        {model="pounder", name="cocain truck"},
        {model="pounder", name="cocain truck"},
    },
    { -- Level 2
        {model="pounder", name="cocain truck"},
        {model="pounder", name="cocain truck"},
        {model="pounder", name="cocain truck"},
    },
    { -- Level 3
        {model="pounder", name="cocain truck"},
        {model="pounder", name="cocain truck"},
        {model="pounder", name="cocain truck"},
    },
    { -- Level 4
        {model="pounder", name="cocain truck"},
        {model="pounder", name="cocain truck"},
        {model="pounder", name="cocain truck"},
    },
}

-- Locations where parked vehicles spawn and cop cars
parked_spawns = { 
    {name="Airfield", x=1402.25, y=2999.21, z=40.55, heading=264.75, copHeading=332.55, copx=741.46, copy=-1766.14, copz=28.29},
    {name="Desert", x=2707.01, y=4148.92, z=43.75, heading=280, copx=656.72, copy=-2791.2, copz=5.87, copHeading=289.29},
    {name="Paleto", heading=180, x=203.68, y=6385.48, z=31.4, copHeading=332.55, copx=741.46, copy=-1766.14, copz=28.29},
}

-- Locations where driving vehicles spawn
drive_spawns = {
    {name="example", heading=179, x=-789.6, y=-821.9, z=20.43},
}

-- Delivery locations for stolen vehicles
-- From - to is the range of the payout for delivering the vehicle
destinations = { 
    {name="Police Station", x=451.44, y=-903.54, z=28.45, from=1200, to=1400},
    {name="Hotel", x=292.6, y=-694.63, z=29.3, from=1500, to=1700},
    {name="Train Yard", x=490.19, y=-542.02, z=24.75, from=1800, to=2000},
    {name="Fire Station", x=180.87, y=-1671.47, z=29.57, from=2000, to=2200},
}
