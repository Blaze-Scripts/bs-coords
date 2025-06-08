Config = {}

-- Default settings
Config.DefaultVisible = true -- UI is visible by default
Config.RefreshRate = 100 -- Update rate in ms

-- Keybindings
-- If you change any keybindings, make sure to update the html/index.html file
Config.Keys = {
    display = 0x4AF4D473, -- DEL - Toggle display visibility
    copyVector3 = 0xCEFD9220, -- E - Copy vector3
    copyVector4 = 0xE30CD707, -- R - Copy vector4 
    copyX = 0x760A9C6F, -- G - Copy X coordinate
    copyY = 0x24978A28, -- H - Copy Y coordinate 
    copyZ = 0xF3830D8E, -- J - Copy Z coordinate
    copyHeading = 0x80F28E95, -- L - Copy heading
}

-- UI Settings
Config.Position = "center-right" -- Position of the coordinate display: top-left, top-right, bottom-left, bottom-right, center-left, center-right