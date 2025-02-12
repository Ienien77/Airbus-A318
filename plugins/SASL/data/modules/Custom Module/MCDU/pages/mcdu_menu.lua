-- PAGE KEY: 1

local options = {
    left = {
        {"<FMGS", 2},
        {"<ATSU", 1},
        {"<ACMS", 1},
        {"", 1},
        {"<SAT", 1}
    },
    right = {
        {"", 1},
        {"", 1},
        {"", 1},
        {"", 1},
        {"", 1},
        {"RETURN>", 1}
    }
}


function mcdu_menu_key_input(side, key)
    if side == 'l' then
        if key == 1 then
            set(MCDU_CURRENT_PAGE, 10)
            print(get(MCDU_CURRENT_PAGE))
        end
    else
        if key == 5 then
            checkCurrentVersion()
            set(updatePageType, 1)
            set(MCDU_CURRENT_PAGE, 3)
        end
        if key == 1 then
            processCustomAptData()
        end
        if key == 2 then
            set(MCDU_CURRENT_PAGE, 800)
        end
        if key == 4 then
            if isUpdateAvailable() then
                set(updatePageType, 0)
                set(MCDU_CURRENT_PAGE, 3)
            end
        end
        if key == 6 then
            set(MCDU_CURRENT_PAGE, 2)
        end
    end
end

function update_mcdu_menu()
end

local function drawOptions()
    -- draw left options
    for i = 1, table.getn(options.left), 1 do
        local option = options.left[i]
        sasl.gl.drawText(MCDU_FONT, 10, mdcu_positons[i], option[1], mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[option[2]])
    end
    for i = 1, table.getn(options.right), 1 do
        local option = options.right[i]
        sasl.gl.drawText(MCDU_FONT, 469, mdcu_positons[i], option[1], mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[option[2]])
    end
end

local hasCheckedUpdate = false
function draw_mcdu_menu()
    sasl.gl.drawText(MCDU_FONT, title_location.x, title_location.y, "MCDU MENU", title_location.font_size, false, false, TEXT_ALIGN_CENTER, {1, 1, 1, 1})
    drawOptions()
    if not hasCheckedUpdate then
        checkForUpdate()
        hasCheckedUpdate = true
    end
    sasl.gl.drawText(MCDU_FONT_BOLD, 462, option_heading_locations[2], "EXPERIMENTAL", option_heading_font_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[4])
    sasl.gl.drawText(MCDU_FONT, 469, mdcu_positons[2], "WAYPOINT LOOKUP>", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[4])
    if isUpdateAvailable() then
        sasl.gl.drawText(MCDU_FONT, 469, mdcu_positons[4], "UPDATE AVAILABLE*>", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[4])
    end
    sasl.gl.drawText(MCDU_FONT, 469, mdcu_positons[5], "SOFTWARE VERSION>", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[1])
end