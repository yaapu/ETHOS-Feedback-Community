-- Lua FLVSS widget

local function create()
  local sensor = system.getSource("LiPo")
  return {sensor=sensor, value=nil}
end

local function paint(widget)
  if widget.sensor ~= nil then
    lcd.font(FONT_L)
    local y = 10
    lcd.drawText(10, y, "Total = " .. widget.sensor:stringValue() .. " (" .. widget.sensor:stringValue(OPTION_CELL_COUNT) .. " cells)")
    y = y + 30
    for i = 1, widget.sensor:value(OPTION_CELL_COUNT) do
      lcd.drawText(10, y, "Cell[" .. i .."] = " .. widget.sensor:stringValue(OPTION_CELL_INDEX(i)))
      y = y + 30
    end
  end
end

local function wakeup(widget)
  local newValue = nil
  if widget.sensor == nil then
    widget.sensor = system.getSource("LiPo")
  end
  if widget.sensor ~= nil then
    newValue = widget.sensor:stringValue()
  end
  if widget.value ~= newValue then
    widget.value = newValue
    lcd.invalidate()
  end
end

local function init()
  system.registerWidget({key="flvss", name="Lua Flvss", create=create, paint=paint, wakeup=wakeup})
end

return {init=init}
