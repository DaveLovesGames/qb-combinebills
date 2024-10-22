local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-combinebills:server:combineMarkedBills', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        local markedBills = Player.Functions.GetItemsByName('markedbills')
        if markedBills and #markedBills > 0 then
            local totalWorth = 0
            for _, bill in ipairs(markedBills) do
                totalWorth = totalWorth + (bill.info.worth or 0)
            end
            if totalWorth > 0 then
                for _, bill in ipairs(markedBills) do
                    Player.Functions.RemoveItem('markedbills', 1, bill.slot)
                end
                Player.Functions.AddItem('markedbills', 1, nil, {worth = totalWorth})
                TriggerClientEvent('QBCore:Notify', src, 'Marked bills combined successfully.', 'success')
            else
                TriggerClientEvent('QBCore:Notify', src, 'No valid worth found in marked bills.', 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', src, 'You have no marked bills to combine.', 'error')
        end
    end
end)
