native= term.current()
reactor = peripheral.wrap("fissionReactorLogicAdapter_2")
monitor = peripheral.find("monitor")
monitor.setTextScale(2)
term.redirect(monitor)
mWidth, mHeight = term.getSize()
term.setBackgroundColor(colors.gray)
term.clear()

local rMaxTemp = 300
local rStatus
local rTemperature 
local cButtonStartx, cButtonStarty = 1, 6
local cButtonSizex, cButtonSizey = 4, 9

wStatusWindow = window.create(term.current(), 1, 1,  mWidth, 6)
wButtonWindow = window.create(term.current(), cButtonStartx, cButtonStarty,  cButtonSizex, cButtonSizey)
wBurnRateWindow = window.create(term.current(), cButtonStartx, cButtonStarty+cButtonSizey+1, cButtonSizex, 2)

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
	if rTemperature >= rMaxTemp then
		wStatusWindow.setTextColor(colors.red)
	else
		wStatusWindow.setTextColor(colors.lime)
	end
	wStatusWindow.write(string.format("%.2f", rTemperature).."°C")
	wStatusWindow.setTextColor(colors.white)

	wStatusWindow.setCursorPos(1, 5)
	wStatusWindow.write("Burn Rate: ")
	wStatusWindow.write(string.format("%.2f", rBurnRate))
end

function drawButtonWindow(wButtonWindow, rStatus)
	if rStatus then
		wButtonWindow.setBackgroundColor(colors.lime)
		wButtonWindow.clear()
		wButtonWindow.setCursorPos(cButtonSizex/2, cButtonSizey/2)
		wButtonWindow.write("ON")
	else
		wButtonWindow.setBackgroundColor(colors.red)
		wButtonWindow.clear()
		wButtonWindow.setCursorPos(cButtonSizex/2, cButtonSizey/2)
		wButtonWindow.write("OFF")
	end
end

function drawBurnRateWindow(wButtonWindow)
	-- Display the buttons for increasing and decreasing the burn rate
	wButtonWindow.setBackgroundColor(colors.lightGray)
	wButtonWindow.clear()
	wButtonWindow.setCursorPos(1, 1)
	wButtonWindow.write("<")
	wButtonWindow.setCursorPos(cButtonSizex-1, 1)
	wButtonWindow.write(">")
end

function check_button(x, y)

	-- Check if the Toggling button is pressed 
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
	
	-- Check if the burn rate decrease button is pressed
	elseif y >= cButtonStarty+cButtonSizey+1
	and y <=  cButtonStarty+cButtonSizey+1+cButtonSizey
	and x >= cButtonStartx
	and x <= cButtonStartx + (cButtonSizex/2)
	then
		-- Increase the burn rate by 0.1
		rBurnRate = rBurnRate - 0.1
	
	-- Check if the burn rate increase button is pressed
	elseif y >= cButtonStarty+cButtonSizey+1
	and y <=  cButtonStarty+cButtonSizey+1+cButtonSizey
	and x >= cButtonStartx + (cButtonSizex/2)
	and x <= cButtonStartx + cButtonSizex
	then
	-- Increase the burn rate by 0.1
	rBurnRate = rBurnRate + 0.1
	-- Boundary check for the burn rate
	if rBurnRate < 0 then
		rBurnRate = 0
	end
	end
end



function update_display()
	while true do
		rStatus = reactor.getStatus()
		rTemperature = reactor.getTemperature()-273.15
		rBurnRate = reactor.getBurnRate()
		if rTemperature >= 300 and rStatus then
			reactor.scram()
		end
		drawStatusWindow(wStatusWindow, rStatus, rTemperature)
		drawButtonWindow(wButtonWindow, rStatus)
		drawBurnRateWindow(wBurnRateWindow)
	end
end

function get_events()
	while true do
		local event, button, x, y = os.pullEvent("monitor_touch")
		check_button(x,y)
	end
end

parallel.waitForAny(get_events, update_display)