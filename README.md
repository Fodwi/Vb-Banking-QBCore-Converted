# Vb-Banking-QbCore-Converted
Vb-Banking script converted to QBCore, all credits to Visbait for original code 

If you want to use this script you need to add this into your qb-core functions [resources\[qb]\qb-core\client\functions.lua]


QBCore.ShowFloatingHelpNotification = function(msg, coords)
    AddTextEntry('qbcoreFloatingHelpNotification', msg)
    SetFloatingHelpTextWorldPosition(1, coords)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp('qbcoreFloatingHelpNotification')
    EndTextCommandDisplayHelp(2, false, false, -1)
end
