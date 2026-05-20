function main()
    while not isSampAvailable() do wait(0) end
    while true do
        wait(0)
        if testCheat('r') and isCharInAnyCar(PLAYER_PED) then switchCarSiren(storeCarCharIsInNoSave(PLAYER_PED), not isCarSirenOn(storeCarCharIsInNoSave(PLAYER_PED))) end 
    end
end