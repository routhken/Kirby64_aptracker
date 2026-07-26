ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/helper_definitions.lua")
Tracker.AllowDeferredLogicUpdate = true


CURRENT_INDEX = -1

function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
end

Set = {}

function Set.new (t)
    local set = {}
    for _, l in ipairs(t) do set[l] = true end
    return set
end

function tableMerge(result, ...)
  for _, t in ipairs({...}) do
    for _, v in ipairs(t) do
      table.insert(result, v)
    end
  end
end

function onClear(slotData)
    print("DEBUG settings set to initialize as false")
    Tracker.BulkUpdate = true
    CURRENT_INDEX = -1

    -- Reset Locations
    for _, layoutLocationPath in pairs(LOCATION_MAPPING) do
        -- if layoutLocationPath[1] then
        --     local layoutLocationObject = Tracker:FindObjectForCode(layoutLocationPath[1])

        --     if layoutLocationObject then
        --         if layoutLocationPath[1]:sub(1, 1) == "@" then
        --             layoutLocationObject.AvailableChestCount = layoutLocationObject.ChestCount
        --         else
        --             layoutLocationObject.Active = false
        --         end
        --     end
        -- end

        if  layoutLocationPath and layoutLocationPath[1] then
            
            for _,layoutLocationElement in pairs(layoutLocationPath) do
                local layoutLocationObject = Tracker:FindObjectForCode(layoutLocationElement)

                if layoutLocationObject then
                    if layoutLocationElement:sub(1, 1) == "@" then
                        layoutLocationObject.AvailableChestCount = layoutLocationObject.ChestCount
                    else
                        layoutLocationObject.Active = false
                    end
                end
            end
        end

    end

    -- Reset Items
    for _, layoutItemData in pairs(ITEM_MAPPING) do
        if layoutItemData[1] and layoutItemData[2] then
            local layoutItemObject = Tracker:FindObjectForCode(layoutItemData[1])

            if layoutItemObject then
                if layoutItemData[2] == "toggle" then
                    layoutItemObject.Active = false
                elseif layoutItemData[2] == "progressive" then
                    layoutItemObject.CurrentStage = 0
                    layoutItemObject.Active = false
                elseif layoutItemData[2] == "consumable" then
                    layoutItemObject.AcquiredCount = 0
                elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                    print(string.format("onClear: Unknown item type %s for code %s", layoutItemData[2], layoutItemData[1]))
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: Could not find object for code %s", layoutItemData[1]))
            end
        end
    end

    -- Reset Settings
    Tracker:FindObjectForCode("setting_goal_speed").CurrentStage = 0
    Tracker:FindObjectForCode("setting_split_power_combos").Active = false
    Tracker:FindObjectForCode("setting_1up_sanity").Active = false
    Tracker:FindObjectForCode("setting_food_sanity").Active = false
    Tracker:FindObjectForCode("setting_star_sanity").Active = false
    Tracker:FindObjectForCode("setting_auto_tab").Active = true
    Tracker:FindObjectForCode("crystal_shard").AcquiredCount = 0
    Tracker:FindObjectForCode("setting_pop_1_level").AcquiredCount = 1
    Tracker:FindObjectForCode("setting_pop_2_level").AcquiredCount = 2
    Tracker:FindObjectForCode("setting_pop_3_level").AcquiredCount = 3
    Tracker:FindObjectForCode("setting_rock_1_level").AcquiredCount = 4
    Tracker:FindObjectForCode("setting_rock_2_level").AcquiredCount = 5
    Tracker:FindObjectForCode("setting_rock_3_level").AcquiredCount = 6
    Tracker:FindObjectForCode("setting_rock_4_level").AcquiredCount = 7
    Tracker:FindObjectForCode("setting_aqua_1_level").AcquiredCount = 8
    Tracker:FindObjectForCode("setting_aqua_2_level").AcquiredCount = 9
    Tracker:FindObjectForCode("setting_aqua_3_level").AcquiredCount = 10
    Tracker:FindObjectForCode("setting_aqua_4_level").AcquiredCount = 11
    Tracker:FindObjectForCode("setting_neo_1_level").AcquiredCount = 12
    Tracker:FindObjectForCode("setting_neo_2_level").AcquiredCount = 13
    Tracker:FindObjectForCode("setting_neo_3_level").AcquiredCount = 14
    Tracker:FindObjectForCode("setting_neo_4_level").AcquiredCount = 15
    Tracker:FindObjectForCode("setting_shiv_1_level").AcquiredCount = 16
    Tracker:FindObjectForCode("setting_shiv_2_level").AcquiredCount = 17
    Tracker:FindObjectForCode("setting_shiv_3_level").AcquiredCount = 18
    Tracker:FindObjectForCode("setting_shiv_4_level").AcquiredCount = 19
    Tracker:FindObjectForCode("setting_rip_1_level").AcquiredCount = 20
    Tracker:FindObjectForCode("setting_rip_2_level").AcquiredCount = 21
    Tracker:FindObjectForCode("setting_rip_3_level").AcquiredCount = 22
    Tracker:FindObjectForCode("setting_required_crystals_1").AcquiredCount = 1
    Tracker:FindObjectForCode("setting_required_crystals_2").AcquiredCount = 2
    Tracker:FindObjectForCode("setting_required_crystals_3").AcquiredCount = 3
    Tracker:FindObjectForCode("setting_required_crystals_4").AcquiredCount = 4
    Tracker:FindObjectForCode("setting_required_crystals_5").AcquiredCount = 5
    Tracker:FindObjectForCode("setting_required_crystals_6").AcquiredCount = 6
    Tracker:FindObjectForCode("setting_required_crystals_7").AcquiredCount = 7
    print("DEBUG settings set to initialize as false")
    print("DEBUG Pop 1 Level: " .. Tracker:FindObjectForCode("setting_pop_1_level").AcquiredCount)

    --------------------------------------------------------------------------------
    if slotData['goal_speed'] == 1 then
        Tracker:FindObjectForCode("setting_goal_speed").CurrentStage = 1
    end
    if slotData['split_power_combos'] == 1 then
        Tracker:FindObjectForCode("setting_split_power_combos").Active = true
    end
    -- print("Index for player levels in slot data:")
    -- print(tostring(slotData['player_levels']))
    --Lua is 1 indexed
    Tracker:FindObjectForCode("setting_pop_1_level").AcquiredCount = slotData['player_levels']["1"][1]
    Tracker:FindObjectForCode("setting_pop_2_level").AcquiredCount = slotData['player_levels']["1"][2]
    Tracker:FindObjectForCode("setting_pop_3_level").AcquiredCount = slotData['player_levels']["1"][3]
    Tracker:FindObjectForCode("setting_rock_1_level").AcquiredCount = slotData['player_levels']["2"][1]
    Tracker:FindObjectForCode("setting_rock_2_level").AcquiredCount = slotData['player_levels']["2"][2]
    Tracker:FindObjectForCode("setting_rock_3_level").AcquiredCount = slotData['player_levels']["2"][3]
    Tracker:FindObjectForCode("setting_rock_4_level").AcquiredCount = slotData['player_levels']["2"][4]
    Tracker:FindObjectForCode("setting_aqua_1_level").AcquiredCount = slotData['player_levels']["3"][1]
    Tracker:FindObjectForCode("setting_aqua_2_level").AcquiredCount = slotData['player_levels']["3"][2]
    Tracker:FindObjectForCode("setting_aqua_3_level").AcquiredCount = slotData['player_levels']["3"][3]
    Tracker:FindObjectForCode("setting_aqua_4_level").AcquiredCount = slotData['player_levels']["3"][4]
    Tracker:FindObjectForCode("setting_neo_1_level").AcquiredCount = slotData['player_levels']["4"][1]
    Tracker:FindObjectForCode("setting_neo_2_level").AcquiredCount = slotData['player_levels']["4"][2]
    Tracker:FindObjectForCode("setting_neo_3_level").AcquiredCount = slotData['player_levels']["4"][3]
    Tracker:FindObjectForCode("setting_neo_4_level").AcquiredCount = slotData['player_levels']["4"][4]
    Tracker:FindObjectForCode("setting_shiv_1_level").AcquiredCount = slotData['player_levels']["5"][1]
    Tracker:FindObjectForCode("setting_shiv_2_level").AcquiredCount = slotData['player_levels']["5"][2]
    Tracker:FindObjectForCode("setting_shiv_3_level").AcquiredCount = slotData['player_levels']["5"][3]
    Tracker:FindObjectForCode("setting_shiv_4_level").AcquiredCount = slotData['player_levels']["5"][4]
    Tracker:FindObjectForCode("setting_rip_1_level").AcquiredCount = slotData['player_levels']["6"][1]
    Tracker:FindObjectForCode("setting_rip_2_level").AcquiredCount = slotData['player_levels']["6"][2]
    Tracker:FindObjectForCode("setting_rip_3_level").AcquiredCount = slotData['player_levels']["6"][3]

    Tracker:FindObjectForCode("setting_required_crystals_1").AcquiredCount = slotData['boss_requirements'][1]
    Tracker:FindObjectForCode("setting_required_crystals_2").AcquiredCount = slotData['boss_requirements'][2]
    Tracker:FindObjectForCode("setting_required_crystals_3").AcquiredCount = slotData['boss_requirements'][3]
    Tracker:FindObjectForCode("setting_required_crystals_4").AcquiredCount = slotData['boss_requirements'][4]
    Tracker:FindObjectForCode("setting_required_crystals_5").AcquiredCount = slotData['boss_requirements'][5]
    Tracker:FindObjectForCode("setting_required_crystals_6").AcquiredCount = slotData['boss_requirements'][6]
    Tracker:FindObjectForCode("setting_required_crystals_7").AcquiredCount = slotData['required_crystals']

    --Deathlink is not in slotdata
    -- if slotData['deathlink'] == 1 then
    --     Tracker:FindObjectForCode("setting_deathlink").Active = true
    -- end
    
    --1up, food, and star sanity are not in slot data, so need to check if locations exist
    
    local location_table = {}
    tableMerge(location_table, Archipelago.CheckedLocations, Archipelago.MissingLocations)
    local location_set = Set.new(location_table)

    if location_set[0x0431] then -- Pop Star 2 - 1-Up
        Tracker:FindObjectForCode("setting_1up_sanity").Active = true
    end
    if location_set[0x0402] then -- Pop Star 1 - Maxim Tomato 1
        Tracker:FindObjectForCode("setting_food_sanity").Active = true
    end
    if location_set[0x0400] then -- Pop Star 1 - Star 1
        Tracker:FindObjectForCode("setting_star_sanity").Active = true
    end

    --print("Slotdata: ") --debug
    --print(dump(slotData)) --debug
    
	PLAYER_ID = Archipelago.PlayerNumber or -1
	TEAM_NUMBER = Archipelago.TeamNumber or 0

    if Archipelago.PlayerNumber > -1 then
        HINTS_ID = "_read_hints_"..TEAM_NUMBER.."_"..PLAYER_ID
        DATA_STORAGE_ID = "K64_"..TEAM_NUMBER.."_"..PLAYER_ID
		CurrentLocID = "K64_current_map_"..TEAM_NUMBER.."_"..PLAYER_ID

        if Highlight then
            Archipelago:SetNotify({CurrentLocID, HINTS_ID, DATA_STORAGE_ID})
            Archipelago:Get({CurrentLocID, HINTS_ID, DATA_STORAGE_ID})
        else
            Archipelago:SetNotify({CurrentLocID, DATA_STORAGE_ID})
            Archipelago:Get({CurrentLocID, DATA_STORAGE_ID})
        end
    end

    Tracker.BulkUpdate = false
end

function OnNotify(key, value, old_value)
	if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
		print(string.format("called onNotify: %s, %s, %s", key, dump(value), old_value))
	end

	if value == old_value then
		return
	end

	if key == HINTS_ID and Highlight then
		for _, hint in ipairs(value) do
			if not hint.found and hint.finding_player == Archipelago.PlayerNumber then
				UpdateHints(hint.location, hint.status)
			else
				ClearHints(hint.location)
			end
		end
        --Autotab not implemented yet because there are no submaps
    -- elseif key == CurrentLocID then
    --     print("Current location: " .. tostring(value))
    --     if Tracker:FindObjectForCode("setting_auto_tab").Active == true then
    --         if MapIDToTab[value] then
    --             for _, room in ipairs(MapIDToTab[value]) do
    --                 Tracker:UiHint("ActivateTab", room)
    --             end
    --         end
    --     end
	elseif key == DATA_STORAGE_ID and value ~= nil then
		for k, v in pairs(value) do
			if (DataStorageLocationTable[k]) then
				Tracker:FindObjectForCode(DataStorageLocationTable[k]).AvailableChestCount = v and 0 or 1
			elseif (DataStorageItemTable[k]) then
				Tracker:FindObjectForCode(DataStorageItemTable[k]).Active = v or false
			end
		end
		Tracker:FindObjectForCode(HiddenSetting).Active = not Tracker:FindObjectForCode(HiddenSetting).Active
	end
end

-- called when a location is hinted or the status of a hint is changed
function UpdateHints(locationID, status)
	if not Highlight then
		return
	end
	local locations = LOCATION_MAPPING[locationID]
	-- print("Hint", dump(locations), status)
	for _, location in ipairs(locations) do
		local section = Tracker:FindObjectForCode(location)
		---@cast section LocationSection
		if section then
			section.Highlight = PriorityToHighlight[status]
		else
			print(string.format("No object found for code: %s", location))
		end
	end
end

function ClearHints(locationID)
	if not Highlight then
		return
	end
	local locations = LOCATION_MAPPING[locationID]
	if (not locations) then
		return
	end
	for _, location in ipairs(locations) do
		local section = Tracker:FindObjectForCode(location)
		---@cast section LocationSection
		if section then
			section.Highlight = Highlight.None
		else
			print(string.format("No object found for code: %s", location))
		end
	end
end

function OnNotifyLaunch(key, value)
	if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
		print(string.format("called onNotifyLaunch: %s, %s", key, dump(value)))
	end
	OnNotify(key, value)
end


function onItem(index, itemId, itemName, playerNumber)
    if index <= CURRENT_INDEX then
        return
    end

    CURRENT_INDEX = index

    local itemObject = ITEM_MAPPING[itemId]
    
    if not itemObject or not itemObject[1] then
        return
    end

    local trackerItemObject = Tracker:FindObjectForCode(itemObject[1])

    if trackerItemObject then
        if itemObject[2] == "toggle" then
            trackerItemObject.Active = true
        elseif itemObject[2] == "progressive" then
            if trackerItemObject.Active then
                trackerItemObject.CurrentStage = trackerItemObject.CurrentStage + 1
            else
                trackerItemObject.Active = true
            end
        elseif itemObject[2] == "consumable" then
            trackerItemObject.AcquiredCount = trackerItemObject.AcquiredCount + trackerItemObject.Increment
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onItem: Unknown item type %s for code %s", itemObject[2], itemObject[1]))
        end
    else
        print(string.format("onItem: Could not find object for code %s", itemObject[1]))
    end
end


function onLocation(locationId, locationName)
    local locationObject = LOCATION_MAPPING[locationId]

    if not locationObject or not locationObject[1] then
        return
    end

    for _,layoutLocationElement in pairs(locationObject) do

        local trackerLocationObject = Tracker:FindObjectForCode(layoutLocationElement)

        if trackerLocationObject then
            if layoutLocationElement:sub(1, 1) == "@" then
                trackerLocationObject.AvailableChestCount = trackerLocationObject.AvailableChestCount - 1
            else
                trackerLocationObject.Active = false
            end
        else
            print(string.format("onLocation: Could not find object for code %s", layoutLocationElement))
        end
    end
end


Archipelago:AddClearHandler("Clear", onClear)
Archipelago:AddItemHandler("Item", onItem)
Archipelago:AddLocationHandler("Location", onLocation)
Archipelago:AddSetReplyHandler("notify handler", OnNotify)
Archipelago:AddRetrievedHandler("notify launch handler", OnNotifyLaunch)

PriorityToHighlight = {}
if Highlight then
	PriorityToHighlight = {
		[0] = Highlight.Unspecified,
		[10] = Highlight.NoPriority,
		[20] = Highlight.Avoid,
		[30] = Highlight.Priority,
		[40] = Highlight.None -- found
	}
end