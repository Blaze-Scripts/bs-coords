local displayUI = Config.DefaultVisible
local lastCoords = nil

---@param message string The message to display
---@param type string The type of notification (success, error, info)
---@param duration number Duration in ms
local function Notify(message, type, duration)
    if not message then return end

    -- Add your notification resource here
    print('[BS-COORDS] ' .. message)

end

---@param coords vector3 The coordinates to format
---@param decimals number Number of decimal places
---@return string Formatted coordinates string
local function FormatCoords(coords, decimals)
    if not coords then return "N/A" end
    decimals = decimals or 4
    local x = string.format("%." .. decimals .. "f", coords.x)
    local y = string.format("%." .. decimals .. "f", coords.y)
    local z = string.format("%." .. decimals .. "f", coords.z)
    return x .. ", " .. y .. ", " .. z
end

---@param heading number The heading to format
---@param decimals number Number of decimal places
---@return string Formatted heading string
local function FormatHeading(heading, decimals)
    if not heading then return "N/A" end
    decimals = decimals or 4
    return string.format("%." .. decimals .. "f", heading)
end

---@return table Current player position and heading information
local function GetCurrentPositionInfo()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local heading = GetEntityHeading(playerPed)
    
    return {
        coords = coords,
        heading = heading,
        vector3 = string.format("vector3(%.4f, %.4f, %.4f)", coords.x, coords.y, coords.z),
        vector4 = string.format("vector4(%.4f, %.4f, %.4f, %.4f)", coords.x, coords.y, coords.z, heading),
        x = coords.x,
        y = coords.y,
        z = coords.z
    }
end

-- Update position information
local function UpdatePositionInfo()
    if not displayUI then return end
    
    local posInfo = GetCurrentPositionInfo()
    lastCoords = posInfo
    
    SendNUIMessage({
        type = 'updateCoords',
        info = posInfo
    })
end

---@param format string Format to copy ('vector3', 'vector4', 'x', 'y', 'z', 'heading')
local function CopyInfo(format)
    if not displayUI then return end
    
    if not lastCoords then 
        Notify("No coordinate information available", "error", 3000)
        return 
    end
    
    SendNUIMessage({
        type = 'copyFormat',
        format = format,
        info = lastCoords
    })
end

-- Toggle display visibility
local function ToggleDisplay()
    displayUI = not displayUI
    
    SendNUIMessage({
        type = 'setVisible',
        visible = displayUI
    })
    
    if isActive then
        local status = displayUI and "visible" or "hidden"
        Notify("Display " .. status, "primary", 2000)
    end
end

-- NUI Callbacks
RegisterNUICallback('clipboardResult', function(data, cb)
    if not data.success then
        Notify("Failed to copy to clipboard", "error", 3000)
    end
    cb('ok')
end)

RegisterNUICallback('copyToClipboard', function(data, cb)
    local text = data.text
    if text and text ~= '' then
        SendNUIMessage({
            type = 'execCopy',
            text = text,
            format = data.format
        })

        Notify('Copied to clipboard: ' .. data.format, 'success', 1000)
    else
        Notify('Failed to copy text', 'error', 1000)
    end
    cb('ok')
end)

-- Main loop
CreateThread(function()
    while true do
        UpdatePositionInfo()
        Wait(Config.RefreshRate)
    end
end)

-- Key controls
CreateThread(function()
    while true do
        Wait(0)
        
        -- Toggle display visibility
        if IsControlJustPressed(0, Config.Keys.display) then
            ToggleDisplay()
            Wait(200)
        end
        
        -- Copy vector3
        if IsControlJustPressed(0, Config.Keys.copyVector3) then
            CopyInfo('vector3')
            Wait(200)
        end
        
        -- Copy vector4
        if IsControlJustPressed(0, Config.Keys.copyVector4) then
            CopyInfo('vector4')
            Wait(200)
        end
        
        -- Copy X coordinate
        if IsControlJustPressed(0, Config.Keys.copyX) then
            CopyInfo('x')
            Wait(200)
        end
        
        -- Copy Y coordinate
        if IsControlJustPressed(0, Config.Keys.copyY) then
            CopyInfo('y')
            Wait(200)
        end
        
        -- Copy Z coordinate
        if IsControlJustPressed(0, Config.Keys.copyZ) then
            CopyInfo('z')
            Wait(200)
        end
        
        -- Copy heading
        if IsControlJustPressed(0, Config.Keys.copyHeading) then
            CopyInfo('heading')
            Wait(200)
        end
    end
end)

-- Initialize
CreateThread(function()
    Wait(500)
    SendNUIMessage({
        type = 'init',
        visible = displayUI,
        position = Config.Position
    })
end)
