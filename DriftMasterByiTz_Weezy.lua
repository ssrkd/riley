script_name("Drift Master")
script_author("iTz_WEEZY")
script_dependencies("SAMP")
require "lib.moonloader"

----------/D/R/I/F/T/----------

function main()
  if not isSampLoaded() and isSampAvailable() then return end
  while true do
    wait(0)
    if isCharInAnyCar(playerPed) then 
			local car = storeCarCharIsInNoSave(playerPed)
			local speed = getCarSpeed(car)
			isCarInAirProper(car)
			setCarCollision(car, true)
				if isKeyDown(VK_LSHIFT) and isVehicleOnAllWheels(car) and doesVehicleExist(car) and speed > 5.0 then
				setCarCollision(car, false)
					if isCarInAirProper(car) then setCarCollision(car, true)
					if isKeyDown(VK_A)
					then 
					addToCarRotationVelocity(car, 0, 0, 0.15)
					end
					if isKeyDown(VK_D)
					then 			
					addToCarRotationVelocity(car, 0, 0, -0.15)	
					end
				end
			end
		end
	end
end
