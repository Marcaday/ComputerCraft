-- Define constants for the monitor and reactor sides
local monitorSide = "right"
local reactorSide = "left"

-- Connect to the monitor and reactor
local monitor = peripheral.wrap(monitorSide)
local reactor = peripheral.wrap(reactorSide)

-- Clear the monitor
monitor.clear()

-- Main loop
while true do
  -- Get the current status, burn rate, and temperature of the reactor
  local status = reactor.getStatus()
  local burnRate = reactor.getBurnRate()
  local temperature = reactor.getTemperature()

  -- Display the current status, burn rate, and temperature on the monitor
  monitor.setCursorPos(1, 1)
  monitor.write("Reactor Status: " .. status)
  monitor.setCursorPos(1, 2)
  monitor.write("Burn Rate: " .. burnRate)
  monitor.setCursorPos(1, 3)
  monitor.write("Temperature: " .. temperature .. "C")

  -- Draw the buttons on the monitor
  drawButton(2, 4, 4, 1, "Increase Burn Rate", colors.green)
  drawButton(8, 4, 4, 1, "Decrease Burn Rate", colors.red)
  drawButton(5, 6, 6, 1, "Toggle Reactor", colors.orange)

  -- Wait 1 second before updating the display again
  sleep(1)

  -- Check for button events
  local event, side, x, y = os.pullEvent("monitor_touch")
  if x >= 2 and x <= 6 and y == 4 then
    -- Increase burn rate button was pressed
    reactor.setBurnRate(burnRate + 1)
  elseif x >= 8 and x <= 12 and y == 4 then
    -- Decrease burn rate button was pressed
    reactor.setBurnRate(burnRate - 1)
  elseif x >= 5 and x <= 11 and y == 6 then
    -- Toggle reactor button was pressed
    if status == "ACTIVE" then
      reactor.scram()
    else
      reactor.activate()
    end
  end
end

-- Draws a button on the monitor with the given position, size, label, and color
function drawButton(x, y, width, height, label, color)
  monitor.setBackgroundColor(color)
  for i = 0, width - 1 do
    for j = 0, height - 1 do
      monitor.setCursorPos(x + i, y + j)
      monitor.write(" ")
    end
  end
  monitor.setCursorPos(x + math.floor(width / 2) - math.floor(#label / 2), y + math.floor(height / 2))
  monitor.write(label)
end
