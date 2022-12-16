native = term.current()
monitor = peripheral.find("monitor")

term.redirect(monitor)

width,height = term.getSize()

function drawMenu()
	native.write("width: "..width.tostring().." height: "..height.tostring())
	term.setBackgroundColor(colors.gray)
	term.setTextColor(colors.white)
	term.clear()
	term.setCursorPos(1,1)
end

