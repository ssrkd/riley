function main()
	repeat wait(0) until isSampAvailable()
	while true do
		wait(0)
		if isKeyJustPressed(76) and not sampIsChatInputActive() and not sampIsDialogActive() then
			printStringNow("The machine is open/closed.", 250)
			sampSendChat("/lock")
		end
	end
end