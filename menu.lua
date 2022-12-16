native = term.current()
monitor = peripheral.find("monitor")

term.redirect(monitor)

width,height = term.getSize()

function drawMenu()
	native.write("width: "..tostring(width).." height: "..tostring(height))
	term.setBackgroundColor(colors.gray)
	term.setTextColor(colors.white)
	term.clear()
	term.setCursorPos(1,1)
end

