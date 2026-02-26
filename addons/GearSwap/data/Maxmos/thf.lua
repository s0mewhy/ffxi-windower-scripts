-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:

    gs c cycle treasuremode (set on ctrl-= by default): Cycles through the available treasure hunter modes.
    
    Treasure hunter modes:
        None - Will never equip TH gear
        Tag - Will equip TH gear sufficient for initial contact with a mob (either melee, ranged hit, or Aeolian Edge AOE)
        SATA - Will equip TH gear sufficient for initial contact with a mob, and when using SATA
        Fulltime - Will keep TH gear equipped fulltime

--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
    state.Buff['Trick Attack'] = buffactive['trick attack'] or false
    state.Buff['Feint'] = buffactive['feint'] or false
    
    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Mod')
    --state.HybridMode:options('DT','Normal')--'Evasion'
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.PhysicalDefenseMode:options('Evasion', 'PDT')

    select_default_macro_book()
	fashion_particulars()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Special sets (required by rules)
    --------------------------------------
	-- Augmented ambuscade JSE capes
	tp_cape = {name="Toutatis's Cape", 
		augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}}
	ws_cape = {name="Toutatis's Cape", 
		augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}}

	-- TH cap = 5
    sets.TreasureHunter = {ammo="Perfect lucky egg",
		hands="Plunderer's armlets +2",feet="Skulker's poulaines +3"}
    -- sets.ExtraRegen = {head="Ocelomeh Headpiece +1"}
    -- sets.Kiting = {feet="Skadi's Jambeaux +1"}

    sets.buff['Sneak Attack'] = {back=tp_cape}

    sets.buff['Trick Attack'] = {}

    -- Actions we want to use to tag TH.
    sets.precast.Step = sets.TreasureHunter
    sets.precast.Flourish1 = sets.TreasureHunter
    sets.precast.JA.Provoke = sets.TreasureHunter

    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Collaborator'] = {head="Skulker's bonnet +3"}
    sets.precast.JA['Accomplice'] = {head="Skulker's bonnet +3"}
    sets.precast.JA['Flee'] = {feet="Pillager's poulaines +3"}
    --sets.precast.JA['Hide'] = {body="Pillager's vest +2"}
	--must be worn fulltime to receive conspirator benefit
    --sets.precast.JA['Conspirator'] = {body="Skulker's vest +2"}
    sets.precast.JA['Steal'] = {feet="Pillager's poulaines +3"}
    sets.precast.JA['Despoil'] = {feet="Skulker's poulaines +3"}
    sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's armlets +2"}
    -- sets.precast.JA['Feint'] = {} -- {legs="Assassin's Culottes +2"}

    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']

    -- Waltz set (chr and vit)
	sets.precast.Waltz = {
		--body="Pillager's vest +2", 
		legs="Pillager's culottes +2"
	}
	
	-- Ranged attack sets
	sets.precast.RA = {
	}

    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="", 
		head="Rogue's bonnet",
		neck="Peacock amulet", 
		ear1="Tortoise earring", 
		ear2="Bone earring", 
		body="Rogue's vest",
		hands="Rogue's armlets", 
		ring1="Soil ring", 
		ring2="Amethyst ring", 
        back="Jaguar mantle", 
		waist="Speed belt", 
		legs="Phlegethon's trousers",
		feet="Rogue's poulaines" 
	}
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

	-- Aeolian Edge = 40% DEX / 40% INT, fTP, SC: Gravitation / Transfixion
    sets.precast.WS['Aeolian Edge'] = {
		-- --range="Malevolence", --MAB +41, INT +3 
		-- ammo="Seething bomblet", --Acc +12, Att +12, MAB +6
        -- head="Nyame helm", --MAB +30, DEX +25, INT +28
		-- neck="Sibyl scarf",
		-- --ear1="Sherida earring", --DA 5%, STR +5, DEX +5 
		-- ear1="Hermetic earring", --MAB +3, MAcc +7
		-- ear2="Moonshade earring", --TP bonus +250, Att +4
        -- body="Nyame mail", 
		-- hands="Nyame gauntlets", --MAB +30, MAcc +40, DEX +42, INT +28
		-- --hands="Leyline gloves", --MAB +30, MAcc +32, DEX +35, INT +12
		-- ring1="Ephramad's ring", --STR +10, DEX +10, AGI +10, Acc/Att/Racc/Ratt +20, PDL +10
		-- ring2="Dingir ring", --MAB+10
        -- back=ws_cape, --TA Dmg +20, DEX +20, Acc +30/Att +20, WSD+10%, DT -5%
		-- waist="Eschan stone",
		-- legs="Nyame flanchard", --MAB +30, INT +44
		-- feet="Nyame sollerets" --MAB +30, INT +25, DEX +26
	}

	-- Evisceration = 50% DEX, 5 hits, fTP, SC: Gravitation / Transfixion
    sets.precast.WS['Evisceration'] = {
		-- ammo="Ginsen",
        -- head="Nyame helm",
		-- neck="Fotia gorget", --Latent(Skillchain): WS fTP +10%, TP not depleted 1%
		-- ear1="Sherida earring",
		-- ear2="Odr earring",
        -- body="Skulker's vest +3", 
		-- hands="Nyame gauntlets", 
		-- ring1="Ephramad's ring", --STR +10, DEX +10, AGI +10, Acc/Att/Racc/Ratt +20, PDL +10
		-- ring2="Gere ring",
        -- back=ws_cape, --TA Dmg +20, DEX +20, Acc +30/Att +20, WSD+10%, DT -5%
		-- waist="Sailfi belt +1", --Haste 9%, TA 2%, Att +10~15, STR+15, DA 5%
		-- legs="Nyame flanchard", 
		-- feet="Nyame sollerets" 
	}

	-- Rudra's Storm = 80% DEX, fTP, SC: Gravitation / Transfixion
    sets.precast.WS["Rudra's Storm"] = {
		-- ammo="Coiste bodhar",
        -- --head="Adhemar bonnet +1", --DEX +33, Acc +56, SB +8, TA 4%, CDmg 6%, STR +19
		-- head="Nyame helm",
		-- neck="Assassin's gorget +2",
		-- ear1="Odr earring", --DEX +10, Acc +10, CR 5%
		-- ear2="Moonshade earring", --TP bonus +250, Att +4
        -- body="Skulker's vest +3", 
		-- hands="Nyame gauntlets", 
		-- ring1="Ephramad's ring", --STR +10, DEX +10, AGI +10, Acc/Att/Racc/Ratt +20, PDL +10
		-- ring2="Regal ring",
        -- back=ws_cape, --TA Dmg +20, DEX +20, Acc +30/Att +20, WSD+10%, DT -5%
		-- waist="Kentarch belt +1",
		-- legs="Nyame flanchard", 
		-- feet="Nyame sollerets" 
	}
	
	-- Savage Blade = 50% STR/50% MND, SC: Fragmentation / Scission
    sets.precast.WS["Savage Blade"] = {
		-- ammo="Seething bomblet", --Acc +12, Att +12, MAB +6
		-- head="Nyame helm",
		-- neck="Republican platinum medal",
		-- ear1="Sherida earring", --DEX +10, Acc +10, CR 5%
		-- ear2="Moonshade earring", --TP bonus +250, Att +4
        -- body="Skulker's vest +3", 
		-- hands="Nyame gauntlets", 
		-- ring1="Ephramad's ring", --STR +10, DEX +10, AGI +10, Acc/Att/Racc/Ratt +20, PDL +10
		-- ring2="Gere ring", 
        -- back=ws_cape, --TA Dmg +20, DEX +20, Acc +30/Att +20, WSD+10%, DT -5%
		-- waist="Sailfi belt +1", --Haste 9%, TA 2%, Att +10~15, STR+15, DA 5%
		-- legs="Nyame flanchard", 
		-- feet="Nyame sollerets" 
	}

    sets.precast.WS["Shark Bite"] = {
		-- ammo="Coiste bodhar",
		-- head="Nyame helm",
		-- neck="Assassin's gorget +2",
		-- ear1="Sherida earring", --DEX +10, Acc +10, CR 5%
		-- ear2="Moonshade earring", --TP bonus +250, Att +4
        -- body="Skulker's vest +3", 
		-- hands="Nyame gauntlets", 
		-- ring1="Ephramad's ring", --STR +10, DEX +10, AGI +10, Acc/Att/Racc/Ratt +20, PDL +10
		-- ring2="Regal ring", 
        -- back=ws_cape, --TA Dmg +20, DEX +20, Acc +30/Att +20, WSD+10%, DT -5%
		-- waist="Sailfi belt +1", --Haste 9%, TA 2%, Att +10~15, STR+15, DA 5%
		-- legs="Nyame flanchard", 
		-- feet="Nyame sollerets" 
	}
	
	-- midcast sets
	sets.midcast.RA = {}

    -- Idle sets
    sets.idle = {
		ammo="", 
		head="Rogue's bonnet",
		neck="Peacock amulet", 
		ear1="Tortoise earring", 
		ear2="Bone earring", 
		body="Rogue's vest",
		hands="Rogue's armlets", 
		ring1="Soil ring", 
		ring2="Amethyst ring", 
        back="Jaguar mantle", 
		waist="Speed belt", 
		legs="Rogue's culottes",
		feet="Rogue's poulaines" 
	}
		
    --------------------------------------
    -- Melee sets
    --------------------------------------

    -- Normal melee group
    sets.engaged = {
		ammo="", 
		head="Rogue's bonnet",
		neck="Peacock amulet", 
		ear1="Tortoise earring", 
		ear2="Bone earring", 
		body="Rogue's vest",
		hands="Rogue's armlets", 
		ring1="Soil ring", 
		ring2="Amethyst ring", 
        back="Jaguar mantle", 
		waist="Speed belt", 
		legs="Rogue's culottes",
		feet="Rogue's poulaines" 
	}
	
	-- Fashion sets
	sets.fashion = {}
	
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 2)
end

function fashion_particulars()
	send_command('wait 1;input /lockstyleset 1;wait 1;gs equip sets.idle;')
--	send_command('wait 1;input /lockstyleset 1;wait 1;gs equip sets.idle;wait 1;gs c set treasuremode Fulltime')
end
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then
        equip(sets.TreasureHunter)
    elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' or spell.type == 'WeaponSkill' then
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
    end
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
        equip(sets.TreasureHunter)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
    if spell.type == 'WeaponSkill' and not spell.interrupted then
        state.Buff['Sneak Attack'] = false
        state.Buff['Trick Attack'] = false
        state.Buff['Feint'] = false
    end
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
    -- If Feint is active, put that gear set on on top of regular gear.
    -- This includes overlaying SATA gear.
    check_buff('Feint', eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, spellMap, defaut_wsmode)
    local wsmode

    if state.Buff['Sneak Attack'] then
        wsmode = 'SA'
    end
    if state.Buff['Trick Attack'] then
        wsmode = (wsmode or '') .. 'TA'
    end

    return wsmode
end


-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
    -- Check that ranged slot is locked, if necessary
    check_range_lock()

    -- Check for SATA when equipping gear.  If either is active, equip
    -- that gear specifically, and block equipping default gear.
    check_buff('Sneak Attack', eventArgs)
    check_buff('Trick Attack', eventArgs)
end


function customize_idle_set(idleSet)
    if player.hpp < 80 then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end

    return idleSet
end


function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end

    return meleeSet
end


-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    th_update(cmdParams, eventArgs)
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end
    
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end
    
    msg = msg .. ', TH: ' .. state.TreasureMode.value

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end


-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    if category == 2 or -- any ranged attack
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then return true
    end
end


-- Function to lock the ranged slot if we have a ranged weapon equipped.
function check_range_lock()
    if player.equipment.range ~= 'empty' then
        disable('range', 'ammo')
    else
        enable('range', 'ammo')
    end
end


