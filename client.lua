ESX = nil

local autodo_active = false
local autodo_text = nil
  
Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    Citizen.Wait(10000)
end)

Citizen.CreateThread(function()
    while true do
        if autodo_active then
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

            if closestPlayer == -1 or closestDistance > 6.0 then
                
            else
                ExecuteCommand("do " .. autodo_text)
            end
        end
        Citizen.Wait(Config.Time)
    end
end)

RegisterCommand(Config.Command, function(source, args)
    if autodo_active then
        autodo_active = false
        TriggerEvent("chatMessage", "^0[^5AUTODO^0]", {0, 0, 0}, " ^0Has desactivado el DO automático")

    else
        args = table.concat(args, ' ')
        autodo_text = tostring(args)
        autodo_active = true

        TriggerEvent("chatMessage", "^0[^5AUTODO^0]", {0, 0, 0}, " ^0Has añadido un DO automático")
    end 
end, false)

RegisterCommand(Config.CommandText, function()
    if autodo_active then
        TriggerEvent("chatMessage", "^0[^5AUTODO^0]", {0, 0, 0}, " ^0" .. string.format(""..autodo_text..""))
    else
        TriggerEvent("chatMessage", "^0[^5AUTODO^0]", {0, 0, 0}, " ^0No tienes ningún DO automático")
    end 
end, false)