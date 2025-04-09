-- For other languages, translate these strings
blipName = "Truck Delivery"
NoSpawnLocationInConfigFile = "No spawn locations found in the config file, quitting the job"
KeepTheCar_JobIsCancelled = "Keep the truck, job is canceled"
VehicleHasBeenDestroyed_JobIsCancelled = "The truck was destroyed! Job has been canceled."
JobQuit = "Truck delivery job has been quit"
JobStarted = "Truck delivery job started"
StartJob = "Press E to start the job"
QuitJob = "Press E to quit the job"
CarModelLoadingTimeout = "Truck model loading has timed out, please check if the model names are correct"
text_adminXPEditDescription = "(Admin) Edit truck delivery rank"
text_adminXPEditCommand = "cardeliveryxp"
text_option = "Option"
text_optionHelp = "Option type (add, reduce, set)"
text_add = "add"
text_reduce = "reduce"
text_set = "set"
text_number = "Number"
text_level = "Level"
text_levelUp = "Level up"
text_levelLost = "Level lost"
text_numberHelp = "Number of changes"
text_noSuchParameter = "No such parameter found"
text_notEveryArgumentWasEntered = "Not all arguments were entered"
text_getXpCommand = "deliveryxp"
text_getXpDescription = "Displays your truck delivery XP"
text_added = "Added"
text_xpToCarDeliveryRank = "XP to next truck delivery rank"
text_cooldown = "Cooldown"
text_secondsLeft = "seconds left"

-- Dynamic Texts for Vehicle and Job Information
KeepTheCar = "In the next " .. choiceTimer .. " seconds, press U to keep the truck and leave the job"
SubtractedXP = tostring(rankPenalty) .. " XP subtracted from truck delivery rank"

-- Function for finding a car
function text_GoFindCar(spawns, level, vehicleChoice, spawnLocation)
    return string.format("Go find the ~g~%s~w~ somewhere around ~g~%s~w~!", vehicles[level][vehicleChoice].name, spawns[spawnLocation].name)
end

-- Function for finding a parked car
function text_GoFindParkedCar(spawns, level, vehicleChoice, spawnLocation)
    return string.format("Go find the parked ~g~%s~w~ at ~g~%s~w~!", vehicles[level][vehicleChoice].name, spawns[spawnLocation].name)
end
