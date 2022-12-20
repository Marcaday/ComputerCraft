native= term.current()
reactor = peripheral.wrap("fissionReactorLogicAdapter_2")
monitor = peripheral.find("monitor")
monitor.setTextScale(2)
term.redirect(monitor)
mWidth, mHeight = term.getSize()
term.setBackgroundColor(colors.gray)
term.clear()

local rStatus
local rTemperature 
local cButtonStartx, cButtonStarty = 1, 6
local cButtonSizex, cButtonSizey = 4, 9

wStatusWindow = window.create(term.current(), 1, 1,  mWidth, 6)
wButtonWindow = window.create(term.current(), cButtonStartx, cButtonStarty,  cButtonSizex, cButtonSizey)

function drawStatusWindow(wStatusWindow, rStatus, rTemperature)
	wStatusWindow.setBackgroundColor(colors.gray)
	wStatusWindow.clear()

	-- Display the current status of the reactor
	wStatusWindow.setCursorPos(1, 1)
	wStatusWindow.write("Reactor Status: ")
	if rStatus then
		wStatusWindow.setTextColor(colors.lime)
		wStatusWindow.write("ON")
	else
		wStatusWindow.setTextColor(colors.red)
		wStatusWindow.write("OFF")
	end
	wStatusWindow.setTextColor(colors.white)
	
	-- Display the current temperature of the reactor
	wStatusWindow.setCursorPos(1, 3)
	wStatusWindow.write("Temperature: ")
	if rTemperature >= 400 then
		wStatusWindow.setTextColor(colors.red)
	else
		wStatusWindow.setTextColor(colors.lime)
	end
	wStatusWindow.write(string.format("%.2f", rTemperature).."°C")
	wStatusWindow.setTextColor(colors.white)
end
-- Function to draw the on/off button
function drawButtonWindow(wButtonWindow, rStatus)
	wButtonWindow.clear()

	-- Draw the button outline
	wButtonWindow.setBackgroundColor(colors.gray)
	wButtonWindow.setCursorPos(1, 1)
	wButtonWindow.write(" ")
	for i = 1, cButtonSizex-2 do
		wButtonWindow.write("-")
	end
	wButtonWindow.write(" ")
	for i = 2, cButtonSizey-1 do
		wButtonWindow.setCursorPos(1, i)
		wButtonWindow.write("|")
		wButtonWindow.setCursorPos(cButtonSizex, i)
		wButtonWindow.write("|")
	end
	wButtonWindow.setCursorPos(1, cButtonSizey)
	wButtonWindow.write(" ")
	for i = 1, cButtonSizex-2 do
		wButtonWindow.write("-")
	end
	wButtonWindow.write(" ")

	-- Fill the button with the appropriate color and display the label
	if rStatus then
		wButtonWindow.setBackgroundColor(colors.lime)
		wButtonWindow.setCursorPos(cButtonSizex/2-1, cButtonSizey/2)
		wButtonWindow.write(" ON ")
	else
		wButtonWindow.setBackgroundColor(colors.red)
		wButtonWindow.setCursorPos(cButtonSizex/2-1, cButtonSizey/2)
		wButtonWindow.write(" OFF ")
	end
end





function check_button(x,y)
	if y >= cButtonStarty 
	and y <= cButtonStarty + cButtonSizey
	and x >=  cButtonStartx
	and x <= cButtonStartx + cButtonSizex 
	then
		if rStatus then
			reactor.scram()
		else
			reactor.activate()
		end
	end

end

function update_display()
	while true do
		rStatus = reactor.getStatus()
		rTemperature = reactor.getTemperature()-273.15
		if rTemperature >= 300 and rStatus then
			reactor.scram()
		end
		drawStatusWindow(wStatusWindow, rStatus, rTemperature)
		drawButtonWindow(wButtonWindow, rStatus)
	end
end

function get_events()
	while true do
		local event, button, cx, cy = os.pullEvent("monitor_touch")
		rStatus = reactor.getStatus()
	end
end

parallel.waitForAny(get_events, update_display)