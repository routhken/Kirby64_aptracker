-- Core Functions
function has(item)
    return Tracker:ProviderCountForCode(item) > 0
end

function has_not(item)
    return Tracker:ProviderCountForCode(item) == 0
end

-- Item Accessibilty Rules
function hasCrystalShard(amount)
    return Tracker:ProviderCountForCode("crystal_shard") >= amount
end

function hasWaddleDee()
    return has("waddle_dee")
end

function hasAdeleine()
    return has("adeleine")
end

function hasKingDedede()
    return has("king_dedede")
end

function hasAnyBomb()
    return has("bomb") or has("fireworks") or has("dynamite") or has("exploding_snowman") or has("exploding_gordo") or has("rocket_launcher") or has("lightbulb") or has("exploding_shuriken")
end

function hasAnyStone()
    return has("stone") or has("volcano") or has("mega_stone") or has("curling_stone") or has("drill") or has("dynamite") or has("geokinesis") or has("stone_friends")
end

function hasAnyNeedle()
    return has("needle") or has("fire_arrow") or has("drill") or has("snowflake") or has("clutter_needle") or has("exploding_gordo") or has("lightning_rod") or has("bear_trap")
end

function hasAnyIce()
    return has("ice") or has("burning_ice_cube") or has("curling_stone") or has("snowball") or has("snowflake") or has("exploding_snowman") or has("refrigerator") or has("ice_skates")
end

function hasAnyBurn()
    return has("burning") or has("phoenix") or has("volcano") or has("burning_ice_cube") or has("fire_arrow") or has("fireworks") or has("tinder_sheet") or has("flame_sword")
end

function hasAnySpark()
    return has("spark") or has("tinder_sheet") or has("geokinesis") or has("refrigerator") or has("lightning_rod") or has("lightbulb") or has("electrical_field") or has("lightsaber")
end

function hasAnyCutter()
    return has("cutter") or has("flame_sword") or has("stone_friends") or has("ice_skates") or has("bear_trap") or has("exploding_shuriken") or has("lightsaber") or has("great_cutter")
end

function hasGreatCutter()
    return has("great_cutter") or (has("cutter") and not has("setting_split_power_combos"))
end

function hasGeokinesis()
    return (has("geokinesis") and (has("spark") or has("stone"))) or 
        (has("spark") and has("stone") and not has("setting_split_power_combos"))
end

function hasLightbulb()
    return (has("lightbulb") and (has("spark") or has("bomb"))) or 
        (has("spark") and has("bomb") and not has("setting_split_power_combos"))
end

function hasExplodingSnowman()
    return (has("exploding_snowman") and (has("ice") or has("bomb"))) or 
        (has("ice") and has("bomb") and not has("setting_split_power_combos"))
end

function hasVolcano()
    return (has("volcano") and (has("burning") or has("stone"))) or 
        (has("burning") and has("stone") and not has("setting_split_power_combos"))
end

function hasShurikens()
    return (has("exploding_shuriken") and (has("cutter") or has("bomb"))) or 
        (has("cutter") and has("bomb") and not has("setting_split_power_combos"))
end

function hasStoneFriends()
    return (has("stone_friends") and (has("cutter") or has("stone"))) or 
        (has("cutter") and has("stone") and not has("setting_split_power_combos"))
end

function hasDynamite()
    return (has("dynamite") and (has("stone") or has("bomb"))) or 
        (has("stone") and has("bomb") and not has("setting_split_power_combos"))
end

function hasLightningRod()
    return (has("lightning_rod") and (has("spark") or has("needle"))) or 
        (has("spark") and has("needle") and not has("setting_split_power_combos"))
end

function hasDrill()
    return (has("drill") and (has("stone") or has("needle"))) or 
        (has("stone") and has("needle") and not has("setting_split_power_combos"))
end

function hasLightsaber()
    return (has("lightsaber") and (has("spark") or has("cutter"))) or 
        (has("spark") and has("cutter") and not has("setting_split_power_combos"))
end

function hasExplodingGordo()
    return (has("exploding_gordo") and (has("bomb") or has("needle"))) or 
        (has("bomb") and has("needle") and not has("setting_split_power_combos"))
end

function hasFireArrows()
    return (has("fire_arrow") and (has("burning") or has("needle"))) or 
        (has("burning") and has("needle") and not has("setting_split_power_combos"))
end

-- Location Accessibilty Rules

function findWorldForLevel(level_string)
    level_number = tonumber(level_string)
    if Tracker:FindObjectForCode("setting_pop_1_level").AcquiredCount == level_number then
        return 1
    elseif Tracker:FindObjectForCode("setting_pop_2_level").AcquiredCount == level_number then
        return 1
    elseif Tracker:FindObjectForCode("setting_pop_3_level").AcquiredCount == level_number then
        return 1
    elseif Tracker:FindObjectForCode("setting_rock_1_level").AcquiredCount == level_number then
        return 2
    elseif Tracker:FindObjectForCode("setting_rock_2_level").AcquiredCount == level_number then
        return 2
    elseif Tracker:FindObjectForCode("setting_rock_3_level").AcquiredCount == level_number then
        return 2
    elseif Tracker:FindObjectForCode("setting_rock_4_level").AcquiredCount == level_number then
        return 2
    elseif Tracker:FindObjectForCode("setting_aqua_1_level").AcquiredCount == level_number then
        return 3
    elseif Tracker:FindObjectForCode("setting_aqua_2_level").AcquiredCount == level_number then
        return 3
    elseif Tracker:FindObjectForCode("setting_aqua_3_level").AcquiredCount == level_number then
        return 3
    elseif Tracker:FindObjectForCode("setting_aqua_4_level").AcquiredCount == level_number then
        return 3
    elseif Tracker:FindObjectForCode("setting_neo_1_level").AcquiredCount == level_number then
        return 4
    elseif Tracker:FindObjectForCode("setting_neo_2_level").AcquiredCount == level_number then
        return 4
    elseif Tracker:FindObjectForCode("setting_neo_3_level").AcquiredCount == level_number then
        return 4
    elseif Tracker:FindObjectForCode("setting_neo_4_level").AcquiredCount == level_number then
        return 4
    elseif Tracker:FindObjectForCode("setting_shiv_1_level").AcquiredCount == level_number then
        return 5
    elseif Tracker:FindObjectForCode("setting_shiv_2_level").AcquiredCount == level_number then
        return 5
    elseif Tracker:FindObjectForCode("setting_shiv_3_level").AcquiredCount == level_number then
        return 5
    elseif Tracker:FindObjectForCode("setting_shiv_4_level").AcquiredCount == level_number then
        return 5
    elseif Tracker:FindObjectForCode("setting_rip_1_level").AcquiredCount == level_number then
        return 6
    elseif Tracker:FindObjectForCode("setting_rip_2_level").AcquiredCount == level_number then
        return 6
    elseif Tracker:FindObjectForCode("setting_rip_3_level").AcquiredCount == level_number then
        return 6
    end
    return 0
end

function hasAccessToLevel(level_number)
    world_number = findWorldForLevel(level_number)
    --print("DEBUG World Number: " .. world_number)
    if world_number == 0 then
        print("DEBUG World Number ERROR")
        return false
    elseif world_number == 1 then
        return true
    end
    return (Tracker:ProviderCountForCode("crystal_shard") >= Tracker:FindObjectForCode("setting_required_crystals_" .. tostring(world_number - 1)).AcquiredCount)
end

function hasAccessToBoss(boss_number)
    return (Tracker:ProviderCountForCode("crystal_shard") >= Tracker:FindObjectForCode("setting_required_crystals_" .. tostring(boss_number)).AcquiredCount)
end
