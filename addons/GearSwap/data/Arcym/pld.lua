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
    state.Buff.Sentinel = buffactive.sentinel or false
    state.Buff.Cover = buffactive.cover or false
    state.Buff.Doom = buffactive.Doom or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal')
    state.HybridMode:options('Normal')
    state.WeaponskillMode:options('Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.MagicalDefenseMode:options('MDT', 'HP', 'Charm')
    state.PhysicalDefenseMode:options('PDT', 'HP', 'Charm')
	state.IdleMode:options('DT','Refresh','MDB')
    
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'MP', 'Knockback', 'MP_Knockback'}
	state.EquipShield = M(false, 'Equip Shield w/Defense')
	
	state.CombatWeapon = M{['description']='Weapon Selection','PDT','Savage','Aminon'}

    update_defense_mode()
    
    select_default_macro_book()
	fashion_particulars()
end

function user_unload()

end


-- Define sets and vars used by this job file.
function init_gear_sets()
    ----------------------------------------------------------------
	-- /BLU SPELLS:		EFFECT							TRAIT
	----------------------------------------------------------------
	-- Cocoon			Defense buff
	-- Jettatura		Conal enmity terror
	-- Sheep Song		Center-AoE enmity sleep			Auto-regen
	-- Blank Gaze		Single-target enmity dispel
	-- Geist Wall		Center-AoE enmity dispel		
	-- Soporific		Center-AoE enmity sleep
	-- Wild Carrot		Heal							HP+5
	-- Healing Breeze	AoE heal						Auto-regen
	-- Wild Oats										HP+10
	-- Screwdriver										HP+10
	-- Refueling		10% Haste (normal is 15%)
	-- Feather Storm									HP+5
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
	
	sets.precast.JA['Chivalry'] = {hands="Caballarius gauntlets +3"}
	sets.precast.JA['Cover'] = {head="Gallant coronet"}
	sets.precast.JA['Divine Emblem'] = {feet="Chevalier's sabatons +3"}
	--sets.precast.JA['Fealty'] = {body="Caballarius Surcoat"}
    sets.precast.JA['Holy Circle'] = {feet="Gallant leggings"}
	sets.precast.JA['Palisade'] = {sub="Diamond aspis"}
    sets.precast.JA['Rampart'] = {sub="Diamond aspis", head="Caballarius coronet +3"}
	sets.precast.JA['Sentinel'] = {sub="Diamond aspis", feet="Caballarius leggings +3"}
    sets.precast.JA['Shield Bash'] = {hands="Caballarius gauntlets +3"}


    -- Fast cast sets for spells (FC: 52)
    sets.precast.FC = {
	ammo="Sapience orb", --2% FC
    head="Carmine mask", --12% FC
	neck="Knight's bead necklace +2", --"Voltsurge Torque", --4% FC
	ear1={name="Etiolation Earring", priority=7}, --1% but good HP boost
	ear2="Chevalier's earring +2", --"Loquacious Earring", --2% FC
    body="Reverence surcoat +3", --10%
    hands="Leyline gloves", --8% aug 
	ring1="Prolix ring", --2% FC
    ring2="Kishar ring", --4% FC
	--back
	waist={name="Platinum moogle belt", priority=10}, --Solely for the sake of bumping HP
    --legs="Eschite Cuisses", --5% aug
    feet={name="Chevalier's sabatons +3", priority=8},--13%
	}
 
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Coiste bodhar",
		head="Nyame helm",
		neck="Fotia gorget",
		ear1="Moonshade earring",
		ear2="Chevalier's earring +2",
		body="Nyame mail",
		hands="Nyame gauntlets",
		ring1="Ephramad's ring",
		ring2="Regal ring",
		back=str_ws_cape,
		waist="Sailfi belt +1",
		legs="Nyame flanchard",
		feet="Nyame sollerets" 
	}
		
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {})
	
	-- Excalibur
	sets.precast.WS['Knights of the Round'] = {
		ammo="Coiste bodhar",
		head="Nyame helm",
		neck="Republican platinum medal",
		ear1="Moonshade earring", --Lugra earring +1
		ear2="Chevalier's earring +2", --Thrud earring
		body="Nyame mail",
		hands="Nyame gauntlets",
		ring1="Ephramad's ring", --Epaminondas's ring
		ring2="Regal ring",
		back=str_ws_cape,
		waist="Kentarch belt +1",
		legs="Nyame flanchard",
		feet="Nyame sollerets" 
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
		ammo="Coiste bodhar",
		head="Nyame helm",
		neck="Republican platinum medal",
		ear1="Moonshade earring",
		ear2="Chevalier's earring +2", --Thrud earring
		body="Nyame mail",
		hands="Nyame gauntlets",
		ring1="Ephramad's ring", --Epaminondas's ring
		ring2="Regal ring",
		back=str_ws_cape,
		waist="Sailfi belt +1", --Kentarch belt +1
		legs="Nyame flanchard",
		feet="Nyame sollerets" 
	}
		
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
	--SIRD set with some FC remains
    --range="kaja bow",
    ammo="Staunch tathlum +1",
    head="Souveran schaller +1",
	neck="Moonlight necklace",
	ear1="Etiolation earring",
    ear2="Chevalier's earring +2", --"Loquacious Earring", --2% FC
    body="Sakpata's plate",
    hands="Sakpata's gauntlets",
	ring1="Prolix ring",
    ring2="Defending ring",
	back=tank_cape,
	waist="Audumbla sash",
    legs="Founder's hose",
    feet="Souveran schuhs +1" --feet="Odyssean greaves",
	}
	
    sets.midcast.Enmity = { --SIRD+93
		ammo="Staunch tathlum +1", --SIRD+11
		head="Souveran schaller +1", --Enmity+9, SIRD+20
		neck="Moonlight necklace", --Enmity+10, SIRD+10
		ear1="Cryptic earring", --Enmity+4
		ear2="Knightly earring", --SIRD+9
		body="Chevalier's cuirass +3", --Enmity+16, SIRD+20
		hands="Regal gauntlets", --Enh. dur. +20, SIRD +10 --"Caballarius Gauntlets +3",
		ring1="Vexer ring +1", --Enmity+4 --"Supershear Ring",
		ring2="Defending ring", 
		back=tank_cape,
		waist="Audumbla Sash", --SIRD+10
		legs="Chevalier's cuisses +3", --DT-13, Enmity retention
		feet="Chevalier's sabatons +3" --Enmity+15
	}
	
    sets.midcast.Flash = {sets.midcast.Enmity}
    
    sets.midcast.Stun = {sets.midcast.Enmity}
    
	-- only need 92% SIRD due to merits
    sets.midcast.Cure = {
	--SIRD set, Cure Received caps at 30%, Cure Potency caps at 50%
		ammo="Staunch tathlum +1", --11% SIRD
		head="Souveran schaller +1", --20% SIRD, 15% Cure received
		neck="Moonlight necklace", --10% SIRD
		ear1="Nourishing earring +1", --6% Potency, 3/5% SIRD
		ear2="Chevalier's earring +2", --12% Potency 
		body="Souveran cuirass +1", --15% Cure received, 11% Potency, Enmity+9
		hands="Regal gauntlets", --Enh. dur. +20, SIRD +10
		ring1="Moonlight ring",
		ring2="Defending ring",
		back=tank_cape,
		waist="Audumbla Sash", --10% SIRD
		legs="Founder's hose", --30% SIRD
		feet="Chevalier's sabatons +3" --Enmity+15
	--Current stats in this setup, 94% SIRD, 30% Cure received, 31% Potency, 49% PDT
	}
	
    sets.midcast['Stoneskin'] = {
		ammo="Staunch tathlum +1", --11% SIRD
		head="Souveran schaller +1", --20% SIRD, 15% Cure received
		neck="Stone gorget", -- SS +30
		ear1="Mendicant's earring", --5% Potency
		ear2="Earthcry earring", -- SS +10
		body="Souveran cuirass +1", --15% Cure received, 11% Potency
		hands="Regal gauntlets", --Enh. dur. +20, SIRD +10 --"Stone mufflers", -- SS +30
		ring1="Moonlight ring",
		ring2="Defending ring",
		back=tank_cape,
		waist="Siegel Sash", -- SS +20
		legs="Haven hose", -- SS +20
		feet="Chevalier's sabatons +3" --Enmity+15
	}

    sets.midcast['Enhancing Magic'] = {
		ammo="Staunch tathlum +1",
		head="Souveran schaller +1",
		neck="Moonlight necklace",
		ear1="Andoaa earring",
		--ear2="Tuisto Earring",
		--body="Shabti Cuirass",
		hands="Regal gauntlets", --Enh. dur. +20, SIRD +10
		ring1="Moonlight ring",
		ring2="Defending ring",
		back=tank_cape,
		waist="Audumbla Sash",
		legs="Founder's hose",
		--feet="Odyssean Greaves",
	}
    
	sets.midcast['Enhancing Magic']['Phalanx'] = {
	--range="Kaja Bow",
    ammo="Staunch tathlum +1",
    head="Yorium barbuta",
    body="Yorium cuirass",
    hands="Souveran handschuhs +1",
    legs="Sakpata's cuisses",
    feet="Souveran schuhs +1",
    neck="Moonlight necklace",
    waist="Audumbla sash",
    left_ear="Andoaa earring",
    right_ear="Tuisto earring",
    left_ring="Defending ring",
    right_ring="Moonlight ring",
    back="Weard mantle",
	}
	
    sets.midcast.Protect = sets.midcast['Enhancing Magic']
    sets.midcast.Shell = sets.midcast['Enhancing Magic']
	
	---------- BLU Spell	--------------
	
    sets.midcast['Geist Wall'] = sets.midcast.Enmity

    sets.midcast['Jettatura'] = sets.midcast.Enmity
	
	sets.midcast['Blank Gaze'] = sets.midcast.Enmity
	
	sets.midcast['Soporific'] = sets.midcast.Enmity
	
	sets.midcast['Sheep Song'] = sets.midcast.Enmity
    
	sets.midcast['Cocoon'] = sets.midcast.Enmity

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- Idle sets
	
    sets.idle.DT = {
		ammo="Staunch tathlum +1", 
		head="Sakpata's helm", 
		neck="Knight's bead necklace +2", --"Warder's charm +1",
		ear1="Infused earring", --"Etiolation earring", --"Odnowa earring +1",
		ear2="Chevalier's earring +2", --"Tuisto earring",
		body="Adamantite armor", --"Sakpata's breastplate", 
		hands="Sakpata's gauntlets", 
		ring1="Moonlight ring",
		ring2="Shneddick ring", 
		back=tank_cape,
		waist="Carrier's sash",
		legs="Sakpata's cuisses",
		feet="Sakpata's leggings", 
	}
	
	sets.idle.Refresh = {
		ammo="Homiliary", --Refresh+1
		head="Sakpata's helm", 
		neck="Knight's bead necklace +2", 
		ear1="Infused earring", --"Etiolation earring", --"Odnowa earring +1",
		ear2="Chevalier's earring +2", 
		body="Adamantite armor", --"Sakpata's breastplate", 
		hands="Regal gauntlets", --Regen+10, refresh+1
		ring1="Moonlight ring", --Stinky rings+1
		ring2="Shneddick ring", 
		back=tank_cape,
		waist="Fucho-no-obi", --Latent refresh
		legs="Sakpata's cuisses",
		feet="Sakpata's leggings", 
	}
	
	--Max Magic Defense Bonus (MDB)// Aminon set
	-- Excalibur/Aegis
	sets.idle.MDB = {
		ammo="Staunch tathlum +1", --"Vanir battery", 
		head="Sakpata's helm", 
		neck="Warder's charm +1", --"Coatyl gorget",
		ear1="Infused earring", --"Spellbreaker earring",
		ear2="Chevalier's earring +2", --"Sanare earring",
		body="Adamantite armor",
		hands="Sakpata's gauntlets", 
		ring1="Vexer ring +1", 
		ring2="Moonlight ring", --"Shadow ring",
		back=tank_cape, --Change tank cape to "Resist+10"
		waist="Creed baudrier", --"Asklepian belt", 
		legs="Sakpata's cuisses", 
		feet="Sakpata's leggings", 
	}

    --------------------------------------
    -- Defense sets
    --------------------------------------
    
    -- Extra defense sets.  Apply these on top of melee or defense sets.
    -- sets.Knockback = {back="Repulse Mantle"}
    -- sets.MP = {neck="Creed Collar",waist="Flume Belt"}
    -- sets.MP_Knockback = {neck="Creed Collar",waist="Flume Belt",back="Repulse Mantle"}
    
    -- If EquipShield toggle is on (Win+F10 or Win+F11), equip the weapon/shield combos here
    -- when activating or changing defense mode:
    -- sets.PhysicalShield = {main="Anahera Sword",sub="Killedar Shield"} -- Ochain
    -- sets.MagicalShield = {main="Anahera Sword",sub="Beatific Shield +1"} -- Aegis

    -- Basic defense sets.
	
	--------------------------------------
	-- Weapons
	--------------------------------------
	sets.weapons = {}
	sets.weapons.Aminon = {main="Excalibur",sub="Aegis"}
	sets.weapons.PDT = {main="Excalibur",sub="Duban"}
	sets.weapons.Savage = {main="Naegling",sub="Blurred shield +1"}
    --------------------------------------
    -- Engaged sets
    --------------------------------------
	    
    sets.engaged = {
		ammo="Coiste bodhar",
		head="Sakpata's helm",
		neck="Sanctity necklace",
		ear1="Telos earring", --"Odnowa earring +1"
		ear2="Chevalier's earring +2", --"Tuisto earring",
		body="Sakpata's breastplate",
		hands="Sakpata's gauntlets",
		ring1="Moonlight ring",
		ring2="Moonlight ring",
		back=tp_cape,
		waist="Sailfi belt +1",
		legs="Sakpata's cuisses",
		feet="Sakpata's leggings"
	}
	
    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Doom = {}
    sets.buff.Cover = {head="Gallant coronet",body="Valor surcoat"}
	
	sets.fashion = {}

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1,4)
end

function fashion_particulars()
	send_command('wait 1;input /lockstyleset 27;wait 1;gs equip sets.idle.DT')
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_midcast(spell, action, spellMap, eventArgs)
    -- If DefenseMode is active, apply that gear over midcast
    -- choices.  Precast is allowed through for fast cast on
    -- spells, but we want to return to def gear before there's
    -- time for anything to hit us.
    -- Exclude Job Abilities from this restriction, as we probably want
    -- the enhanced effect of whatever item of gear applies to them,
    -- and only one item should be swapped out.
    if state.DefenseMode.value ~= 'None' and spell.type ~= 'JobAbility' then
        handle_equipping_gear(player.status)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
    classes.CustomDefenseGroups:clear()
    classes.CustomDefenseGroups:append(state.ExtraDefenseMode.current)
    if state.EquipShield.value == true then
        classes.CustomDefenseGroups:append(state.DefenseMode.current .. 'Shield')
    end

    classes.CustomMeleeGroups:clear()
    classes.CustomMeleeGroups:append(state.ExtraDefenseMode.current)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_defense_mode()
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
	
	idleSet = set_combine(idleSet, sets.weapons[state.CombatWeapon.value])
    
    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
	
	meleeSet = set_combine(meleeSet, sets.weapons[state.CombatWeapon.value])
    
    return meleeSet
end

function customize_defense_set(defenseSet)
    if state.ExtraDefenseMode.value ~= 'None' then
        defenseSet = set_combine(defenseSet, sets[state.ExtraDefenseMode.value])
    end
    
    if state.EquipShield.value == true then
        defenseSet = set_combine(defenseSet, sets[state.DefenseMode.current .. 'Shield'])
    end
    
    if state.Buff.Doom then
        defenseSet = set_combine(defenseSet, sets.buff.Doom)
    end
	
	defenseSet = set_combine(defenseSet, sets.weapons[state.CombatWeapon.value])
    
    return defenseSet
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