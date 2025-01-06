local function isWeaponAllowed(weapon)
    for _, allowedWeapon in ipairs(Config.AllowedWeapons) do
        if weapon == allowedWeapon then
            return true
        end
    end
    return false
end

-- Ana döngü
CreateThread(function()
    while true do
        Wait(0)

        local ped = PlayerPedId() -- Oyuncu
        local vehicle = GetVehiclePedIsIn(ped, false) -- Oyuncunun içinde bulunduğu araç

        if vehicle ~= 0 then -- Oyuncu bir araçtayken
            local weapon = GetSelectedPedWeapon(ped) -- Oyuncunun seçili silahı

            if isWeaponAllowed(weapon) then
                -- Drive-by ateş etmeyi etkinleştir
                SetPlayerCanDoDriveBy(PlayerId(), true)

                -- Silah pozisyonunu düzelt (araç içinden doğru ateş etmesini sağlar)
                if IsControlPressed(0, 24) then -- Ateş etme tuşu (varsayılan: sol fare tuşu)
                    TaskDriveBy(ped, vehicle, 0, 0.0, 0.0, 0.0, 500.0, 1, true, `FIRING_PATTERN_FULL_AUTO`)
                end
            else
                -- Yasaklı silahları devre dışı bırak
                SetPlayerCanDoDriveBy(PlayerId(), false)
            end
        else
            -- Araç dışında drive-by devre dışı
            SetPlayerCanDoDriveBy(PlayerId(), false)
        end
    end
end)
