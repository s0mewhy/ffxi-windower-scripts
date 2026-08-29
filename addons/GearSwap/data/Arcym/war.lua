-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal')
	state.IdleMode:options('Normal')
    
	state.CombatWeapon = M{['description']='Weapon Selection',
		'Chango','Naegling','ShiningOne'}
    
    select_default_macro_book()
	fashion_particulars()
end

function user_unload()
	
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
    -- Precast sets
    --------------------------------------
	-- Augmented ambuscade JSE capes
	tank_cape = { name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}}
	
	str_ws_cape = { name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}
	
	--not done
	tp_cape = { name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}}
    
    -- Precast sets to enhance JAs
    --sets.precast.JA['Invincible'] = {legs="Caballarius Breeches"}
	sets.precast.JA.Aggressor = {sub="Diamond aspis", body="Pummeler's mask +2"}
	sets.precast.JA.Berserk = {sub="Diamond aspis", body="Pummeler's lorica +2"}
	sets.precast.JA.Restraint = {sub="Diamond aspis"}
	sets.precast.JA.Retaliation = {body="Pummeler's mufflers +2"}
	sets.precast.JA.Warcry = {sub="Diamond aspis"}

    -- Fast cast sets for spells (FC: )
    sets.precast.FC = {
	ammo="Sapience orb", --2% FC
    head="Carmine mask", --12% FC
	--neck
	ear1={name="Etiolation Earring", priority=7}, --1% but good HP boost
	--ear2
    --body
    hands="Leyline gloves", --8% aug 
	ring1="Prolix ring", --2% FC
    --ring2
	--back
	waist={name="Platinum moogle belt", priority=10}, --Solely for the sake of bumping HP
	--feet
	}
 
	-- Weaponskill sets
    sets.precast.WS = {
		ammo="Knobkierrie",
		head="Nyame helm",
		neck="Warrior's bead necklace +2",
		ear1="Schere earring",
		ear2="Boii earring +1", --Thrud earring
		body="Nyame mail",
		hands="Nyame gauntlets",
		ring1="Niqmaddu ring", 
		ring2="Ephramad's ring", --Epaminondas's ring
		back="Atheling mantle",
		waist="Sailfi belt +1", --Kentarch belt +1
		legs="Nyame flanchard",
		feet="Nyame sollerets" 
	}
		
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Fell Cleave'] = {
		ammo="Knobkierrie",
		head="Nyame helm",
		neck="Warrior's bead necklace +2",
		ear1="Moonshade earring",
		ear2="Boii earring +1",
		body="Nyame mail",
		hands="Nyame gauntlets",
		ring1="Niqmaddu ring",
		ring2="Ephramad's ring",
		back="Atheling mantle",
		waist="Sailfi belt +1",
		legs="Nyame flanchard",
		feet="Nyame sollerets"
	}
	
	sets.precast.WS['Raging Rush'] = {
		ammo="Knobkierrie", --Yetshila +1
		head="Nyame helm", --Boii mask +3
		neck="Warrior's bead necklace +2",
		ear1="Schere earring",
		ear2="Boii earring +1", 
		body="Sakpata's breastplate",
		hands="Sakpata's gauntlets", 
		ring1="Niqmaddu ring", 
		ring2="Ephramad's ring", --Sroda ring
		back="Atheling mantle",
		waist="Sailfi belt +1", --Kentarch belt +1
		legs="Nyame flanchard", -- Boii cuisses +3
 		feet="Nyame sollerets" -- Boii calligae +3
	}

    sets.precast.WS['Sanguine Blade'] = {
		ammo="Ghastly tathlum +1",
		head="Pixie hairpin +1",
		neck="Sibyl scarf",
		ear1="Regal earring",
		ear2="Malignance earring",
		body="Nyame mail",
		hands="Nyame gauntlets",
		ring1="Archon ring",
		ring2="Regal ring",
		back=str_ws_cape,
		waist="Eschan stone",
		legs="Nyame flanchard",
		feet="Nyame sollerets" 
	}
	
	sets.precast.WS['Savage Blade'] = {
		ammo="Knobkierrie",
		head="Nyame helm",
		neck="Warrior's bead necklace +2",
		ear1="Schere earring",
		ear2="Chevalier's earring +2", --Thrud earring
		body="Nyame mail",
		hands="Nyame gauntlets",
		ring1="Niqmaddu ring", 
		ring2="Ephramad's ring", --Epaminondas's ring
		back="Atheling mantle",
		waist="Sailfi belt +1", --Kentarch belt +1
		legs="Nyame flanchard",
		feet="Nyame sollerets" 
	}
	
	sets.precast.WS['Stardiver'] = {
		ammo="Knobkierrie", --Yetshila +1
		head="Nyame helm", --Boii mask +3
		neck="Fotia gorget",
		ear1="Moonshade earring",
		ear2="Boii earring +1", 
		body="Sakpata's breastplate",
		hands="Sakpata's gauntlets", 
		ring1="Niqmaddu ring", 
		ring2="Ephramad's ring", --Sroda ring
		back="Atheling mantle",
		waist="Sailfi belt +1", --Kentarch belt +1
		legs="Nyame flanchard", -- Boii cuisses +3
 		feet="Nyame sollerets" -- Boii calligae +3
	}
	
	sets.precast.WS["Ukko's Fury"] = {
		ammo="Knobkierrie", --Yetshila +1
		head="Nyame helm", --Boii mask +3
		neck="Warrior's bead necklace +2",
		ear1="Schere earring",
		ear2="Boii earring +1", 
		body="Sakpata's breastplate",
		hands="Sakpata's gauntlets", 
		ring1="Niqmaddu ring", 
		ring2="Ephramad's ring", --Sroda ring
		back="Atheling mantle",
		waist="Sailfi belt +1", --Kentarch belt +1
		legs="Nyame flanchard", -- Boii cuisses +3
 		feet="Nyame sollerets" -- Boii calligae +3
	}
	
	sets.precast.WS['Upheaval'] = {
		ammo="Knobkierrie", 
		head="Sakpata's helm", 
		neck="Warrior's bead necklace +2",
		ear1="Moonshade earring",
		ear2="Boii earring +1", --Thrud earring
		body="Sakpata's breastplate",
		hands="Sakpata's gauntlets", 
		ring1="Niqmaddu ring", 
		ring2="Regal ring", --Sroda ring
		back="Atheling mantle",
		waist="Sailfi belt +1", --Kentarch belt +1
		legs="Nyame flanchard", -- Boii cuisses +3
 		feet="Nyame sollerets" -- Boii calligae +3
	}
		
    --------------------------------------
    -- Midcast sets
    --------------------------------------
	

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------	
    sets.idle = {
		ammo="Staunch tathlum +1", 
		head="Sakpata's helm", 
		neck="Warder's charm +1",
		ear1="Infused earring", 
		ear2="Etiolation earring", 
		body="Sakpata's breastplate", 
		hands="Sakpata's gauntlets", 
		ring1="Defending ring",
		ring2="Shneddick ring", 
		back="Archon cape",
		waist="Carrier's sash",
		legs="Sakpata's cuisses",
		feet="Sakpata's leggings", 
	}
	
	--------------------------------------
	-- Weapons
	--------------------------------------
	sets.weapons = {}
	sets.weapons.Chango = {main="Chango",sub="Utu grip"}
	sets.weapons.Naegling = {main="Naegling",sub="Blurred shield +1"}
	sets.weapons.ShiningOne = {main="Shining one",sub="Utu grip"}
    --------------------------------------
    -- Engaged sets
    --------------------------------------
	    
    sets.engaged = {
		ammo="Coiste bodhar",
		head="Sakpata's helm",
		neck="Warrior's bead necklace +2",
		ear1="Schere earring", 
		ear2="Boii earring +1", 
		body="Sakpata's breastplate",
		hands="Sakpata's gauntlets",
		ring1="Niqmaddu ring",
		ring2="Moonlight ring",
		back="Atheling mantle",
		waist="Sailfi belt +1",
		legs="Pummeler's cuisses +2",
		feet="Pummeler's calligae +2"
	}
	
    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Doom = {}
	
	sets.fashion = {}

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1,9)
end

function fashion_particulars()
	send_command('wait 1;input /lockstyleset 34;wait 1;gs equip sets.idle')
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_midcast(spell, action, spellMap, eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)

end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)

end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
	
	if state.CombatWeapon.value == 'Chango' then
		idleSet = set_combine(idleSet, sets.weapons.Chango)
	end

	if state.CombatWeapon.value == 'Naegling' then
		idleSet = set_combine(idleSet, sets.weapons.Naegling)
	end
	
	if state.CombatWeapon.value == 'ShiningOne' then
		idleSet = set_combine(idleSet, sets.weapons.ShiningOne)
	end
    
    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
	
	if state.CombatWeapon.value == 'Chango' then
		meleeSet = set_combine(meleeSet, sets.weapons.Chango)
	end

	if state.CombatWeapon.value == 'Naegling' then
		meleeSet = set_combine(meleeSet, sets.weapons.Naegling)
	end
	
	if state.CombatWeapon.value == 'ShiningOne' then
		meleeSet = set_combine(meleeSet, sets.weapons.ShiningOne)
	end
    
    return meleeSet
end

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
        msg = msg .. ', Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end

    if state.ExtraDefenseMode.value ~= 'None' then
        msg = msg .. ', Extra: ' .. state.ExtraDefenseMode.value
    end
    
    if state.EquipShield.value == true then
        msg = msg .. ', Force Equip Shield'
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

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_defense_mode()
    -- if player.equipment.main == 'Kheshig Blade' and not classes.CustomDefenseGroups:contains('Kheshig Blade') then
        -- classes.CustomDefenseGroups:append('Kheshig Blade')
    -- end
    
    -- if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        -- if player.equipment.sub and not player.equipment.sub:contains('Shield') and
           -- player.equipment.sub ~= 'Aegis' and player.equipment.sub ~= 'Ochain' then
            -- state.CombatForm:set('DW')
        -- else
            -- state.CombatForm:reset()
        -- end
    -- end
end

function job_self_command(cmdParams, eventArgs)
	-- toggle DressUP blinking on/off
	-- gs c toggle blink
end