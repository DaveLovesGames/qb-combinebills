local QBCore = exports['qb-core']:GetCoreObject()

-- Function to load the animation dictionary
function LoadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(100)  -- Wait for 100 milliseconds before checking again
    end
end

-- Register the command to combine marked bills
RegisterCommand('combinebills', function()
    -- Load a gender-neutral animation dictionary
    local animDict = "anim@amb@business@bgen@bgen_no_work@"
    LoadAnimDict(animDict)  -- Load the animation dictionary

    -- Start the progress bar and animation
    QBCore.Functions.Progressbar("combine_bills", "Combining Marked Bills...", 5000, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = animDict,  -- Animation dictionary
        anim = "idle_a",  -- Animation name (neutral idle)
    }, {}, {}, function()  -- onFinish
        -- Trigger the server event after the progress bar completes
        TriggerServerEvent('qb-combinebills:server:combineMarkedBills')  -- Trigger the server event
    end, function()  -- onCancel
        QBCore.Functions.Notify('You canceled the combining process.', 'error')
    end)
end)

-- Event to handle the completion of the progress bar
RegisterNetEvent('progressbar:complete', function()
    -- Notify the player that the process is complete
    QBCore.Functions.Notify('You have combined the marked bills!', 'success')
end)
