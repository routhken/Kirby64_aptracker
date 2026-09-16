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
    return has("bomb") or hasPowerCombo("fireworks") or hasPowerCombo("dynamite") or hasPowerCombo("exploding_snowman") or hasPowerCombo("exploding_gordo") or hasPowerCombo("rocket_launcher") or hasPowerCombo("lightbulb") or hasPowerCombo("exploding_shuriken")
end

function hasAnyStone()
    return has("stone") or hasPowerCombo("volcano") or hasPowerCombo("mega_stone") or hasPowerCombo("curling_stone") or hasPowerCombo("drill") or hasPowerCombo("dynamite") or hasPowerCombo("geokinesis") or hasPowerCombo("stone_friends")
end

function hasAnyNeedle()
    return has("needle") or hasPowerCombo("fire_arrow") or hasPowerCombo("drill") or hasPowerCombo("snowflake") or hasPowerCombo("clutter_needle") or hasPowerCombo("exploding_gordo") or hasPowerCombo("lightning_rod") or hasPowerCombo("bear_trap")
end

function hasNeedleVertical()
    return has("needle") or hasPowerCombo("fire_arrow") or hasPowerCombo("drill") or hasPowerCombo("snowflake") or hasPowerCombo("clutter_needle") or hasPowerCombo("exploding_gordo") or hasPowerCombo("lightning_rod")
end

function hasAnyIce()
    return has("ice") or hasPowerCombo("burning_ice_cube") or hasPowerCombo("curling_stone") or hasPowerCombo("snowball") or hasPowerCombo("snowflake") or hasPowerCombo("exploding_snowman") or hasPowerCombo("refrigerator") or hasPowerCombo("ice_skates")
end

function hasIceVertical()
    return hasPowerCombo("burning_ice_cube") or hasPowerCombo("curling_stone") or hasPowerCombo("snowball") or hasPowerCombo("snowflake") or hasPowerCombo("exploding_snowman") or hasPowerCombo("ice_skates")
end

function hasAnyBurn()
    return has("burning") or hasPowerCombo("phoenix") or hasPowerCombo("volcano") or hasPowerCombo("burning_ice_cube") or hasPowerCombo("fire_arrow") or hasPowerCombo("fireworks") or hasPowerCombo("tinder_sheet") or hasPowerCombo("flame_sword")
end

function hasAnySpark()
    return has("spark") or hasPowerCombo("tinder_sheet") or hasPowerCombo("geokinesis") or hasPowerCombo("refrigerator") or hasPowerCombo("lightning_rod") or hasPowerCombo("lightbulb") or hasPowerCombo("electrical_field") or hasPowerCombo("lightsaber")
end

function hasAnyCutter()
    return has("cutter") or hasPowerCombo("flame_sword") or hasPowerCombo("stone_friends") or hasPowerCombo("ice_skates") or hasPowerCombo("bear_trap") or hasPowerCombo("exploding_shuriken") or hasPowerCombo("lightsaber") or hasPowerCombo("great_cutter")
end

function hasCutterVertical()
    return hasPowerCombo("stone_friends") or hasPowerCombo("ice_skates") or hasPowerCombo("exploding_shuriken") or hasPowerCombo("great_cutter")
end

function powerComboEval(combo, ability1, ability2)
    return (has(combo) and (has(ability1) or has(ability2))) or 
        (has(ability1) and has(ability2) and not has("setting_split_power_combos"))
end

function hasPowerCombo(abilitycombo)
    if abilitycombo == "phoenix" then
        return has("phoenix") or (has("burning") and not has("setting_split_power_combos"))
    elseif abilitycombo == "mega_stone" then
        return has("mega_stone") or (has("stone") and not has("setting_split_power_combos"))
    elseif abilitycombo == "snowball" then
        return has("snowball") or (has("ice") and not has("setting_split_power_combos"))
    elseif abilitycombo == "clutter_needle" then
        return has("clutter_needle") or (has("needle") and not has("setting_split_power_combos"))
    elseif abilitycombo == "rocket_launcher" then
        return has("rocket_launcher") or (has("bomb") and not has("setting_split_power_combos"))
    elseif abilitycombo == "electrical_field" then
        return has("electrical_field") or (has("spark") and not has("setting_split_power_combos"))
    elseif abilitycombo == "great_cutter" then
        return has("great_cutter") or (has("cutter") and not has("setting_split_power_combos"))
    elseif abilitycombo == "volcano" then
        return powerComboEval("volcano","burning","stone")
    elseif abilitycombo == "burning_ice_cube" then
        return powerComboEval("burning_ice_cube","burning","ice")
    elseif abilitycombo == "fire_arrow" then
        return powerComboEval("fire_arrow","burning","needle")
    elseif abilitycombo == "fireworks" then
        return powerComboEval("fireworks","burning","bomb")
    elseif abilitycombo == "tinder_sheet" then
        return powerComboEval("tinder_sheet","burning","spark")
    elseif abilitycombo == "flame_sword" then
        return powerComboEval("flame_sword","burning","cutter")
    elseif abilitycombo == "curling_stone" then
        return powerComboEval("curling_stone","stone","ice")
    elseif abilitycombo == "drill" then
        return powerComboEval("drill","stone","needle")
    elseif abilitycombo == "dynamite" then
        return powerComboEval("dynamite","stone","bomb")
    elseif abilitycombo == "geokinesis" then
        return powerComboEval("geokinesis","stone","spark")
    elseif abilitycombo == "stone_friends" then
        return powerComboEval("stone_friends","stone","cutter")
    elseif abilitycombo == "snowflake" then
        return powerComboEval("snowflake","ice","needle")
    elseif abilitycombo == "exploding_snowman" then
        return powerComboEval("exploding_snowman","ice","bomb")
    elseif abilitycombo == "refrigerator" then
        return powerComboEval("refrigerator","ice","spark")
    elseif abilitycombo == "ice_skates" then
        return powerComboEval("ice_skates","ice","cutter")
    elseif abilitycombo == "exploding_gordo" then
        return powerComboEval("exploding_gordo","needle","bomb")
    elseif abilitycombo == "lightning_rod" then
        return powerComboEval("lightning_rod","needle","spark")
    elseif abilitycombo == "bear_trap" then
        return powerComboEval("bear_trap","needle","cutter")
    elseif abilitycombo == "lightbulb" then
        return powerComboEval("lightbulb","bomb","spark")
    elseif abilitycombo == "exploding_shuriken" then
        return powerComboEval("exploding_shuriken","bomb","cutter")
    elseif abilitycombo == "lightsaber" then
        return powerComboEval("lightsaber","spark","cutter")
    end
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
