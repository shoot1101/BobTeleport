local lastTeleportTime = 0
local teleportCooldown = 5000 -- 5 secondes

local function teleportPlayerToLocation(location, teleportVehicle)
    local currentTime = GetGameTimer()
    if currentTime - lastTeleportTime < teleportCooldown then
        lib.notify({
            title = _U('notif3'),
            description = _U('cld'),
            type = "error"
        })
        return
    end
    lastTeleportTime = currentTime

    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    -- Jouer un son
    local beepCount = 1 
    for i = 1, beepCount do
        PlaySoundFromEntity(-1, "LIMIT", GetPlayerPed(-1), "GTAO_APT_DOOR_DOWNSTAIRS_GLASS_SOUNDS", 0, 1.0)

        Wait(200) 
        
        Wait(70) 
    end

    DoScreenFadeOut(900) 
    Wait(900) 
    SetEntityCoords(playerPed, location)
    if teleportVehicle and DoesEntityExist(vehicle) then
        SetEntityCoords(vehicle, location)
        SetPedIntoVehicle(playerPed, vehicle, -1)
    end
    Wait(500) 
    DoScreenFadeIn(900) 
end

local function menu(fconf)
    if Config.Debug then
        print(fconf)
    end
    local teleportoptions = {}
    local tpv = false
    for conf, telep in pairs(Config.teleport) do
        for key, value in pairs(telep) do
            if fconf == conf and key == 'teleportvehicle' then
                if Config.Debug then
                    print(value.val)
                end
                tpv = value.val
            end
            Wait(0)
            if fconf == conf and key ~= 'teleportvehicle' then
                table.insert(teleportoptions, {
                    label = key,
                    icon = value.icon,
                    args = {
                        location = value.loc,
                        label = key,
                        teleportVehicle = tpv  
                    }
                })
            end
        end
    end
    lib.registerMenu({
        id = "main_menu",
        title = Config.menu.title,
        position = Config.menu.position,
        options = teleportoptions
    }, function(selected, scrollIndex, args)
        lib.notify({
            title = _U('notif1'),
            description = _U('tpc'),
            type = "info"
        })
        teleportPlayerToLocation(args.location, args.teleportVehicle)  
        lib.notify({
            title = _U('notif2'),
            description = _U('tpr') .. args.label,
            type = "success"
        })
    end)
    lib.showMenu("main_menu")
end

local function createMenuPoint(location, conf)
    local point = lib.points.new({
        coords = location,
        distance = 3,
    })
    function point:onEnter()
        lib.showTextUI(_U('open'))
    end
    function point:onExit()
        if lib.isTextUIOpen() then
            lib.hideTextUI()
        end
    end
    function point:nearby()
        local inveh = IsPedInAnyVehicle(PlayerPedId(), 1)
        local ifveh = false
        for mconf, mtelep in pairs(Config.teleport) do
            for key, value in pairs(mtelep) do
                if mconf == conf and key == 'teleportvehicle' then
                    if Config.Debug then
                        print(value.val)
                    end
                    ifveh = value.val
                end
            end
        end
        if inveh and not ifveh then
            lib.showTextUI(_U('impv'))
        elseif inveh and (GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) ~= PlayerPedId()) then
            lib.showTextUI(_U('impp'))
        else
            DrawMarker(27, location, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 0, 106, 254, 100, false, true, 2, false, nil, nil, false)
            if IsControlJustPressed(0, 38) then
                menu(conf)
            end
        end
    end    
end

for conf, telep in pairs(Config.teleport) do
    for k, v in pairs(telep) do
        if k ~= 'teleportvehicle' then
            createMenuPoint(v.loc, conf)
        end
    end
end

RegisterCommand("teleports", function()
    menu()
end)

