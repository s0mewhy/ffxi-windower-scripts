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
    state.Buff.Footwork = buffactive.Footwork or false
    state.Buff.Impetus = buffactive.Impetus or false
	state.Buff.Boost = buffactive.Boost or false

    state.FootworkWS = M(false, 'Footwork on WS')

    --info.impetus_hit_count = 0
    --windower.raw_register_event('action', on_action_for_impetus)
end


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal','Counter')
    state.WeaponskillMode:options('Midbuff','Normal') --Normal is Highbuff

    state.HybridMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT','HP')

    update_combat_form()
    update_melee_groups()

    select_default_macro_book()
	fashion_particulars()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
	--sets.weapon = "Godhands" --auto-equip
	
	-- Augmented ambuscade JSE capes
	dex_da_cape = {name="Segomo's Mantle", 
		augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}}
		
	str_da_cape = {name="Segomo's Mantle", 
		augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Damage taken-5%',}}
	
	str_crit_cape = { name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Damage taken-5%',}}
	
	vit_wsd_cape = { name="Segomo's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%','Damage taken-5%',}}
	
    -- Precast Sets
    -- Precast sets to enhance JAs on use
    sets.precast.JA['Hundred Fists'] = {legs="Hesychast's Hose +3"} --Increases HF duration 15s
    sets.precast.JA['Boost'] = {
		hands="Anchorite's Gloves +2", --Boost +8, increase STR modifier by ?
		waist="Ask sash" --Regain +200
	}
    sets.precast.JA['Dodge'] = {feet="Anchorite's gaiters +4"} --Dodge +19 Evasion
    sets.precast.JA['Focus'] = {head="Anchorite's Crown +2"} --Focus +19 Acc/RAcc
    --sets.precast.JA['Counterstance'] = {feet="Hesychast's Gaiters +1"}
    sets.precast.JA['Footwork'] = {feet="Bhikku gaiters +3"}
    --sets.precast.JA['Formless Strikes'] = {body="Hesychast's Cyclas"}
    --sets.precast.JA['Mantra'] = {feet="Hesychast's Gaiters +1"}
	sets.precast.JA['Perfect Counter'] = {head="Bhikku crown +3"}

	-- Chi Blast DMG = MND, # times Boosted
    sets.precast.JA['Chi Blast'] = {head="Hesychast's crown +4"}

    sets.precast.JA['Chakra'] = {
		neck="Unmoving collar +1",
		body="Anchorite's cyclas +2",
		feet="Bhikku gaiters +3"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    sets.precast.Step = {}
    sets.precast.Flourish1 = {}

    -- Fast cast sets for spells
    sets.precast.FC = {}
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})
	
	sets.precast.MaxTP = {ear1="Sherida earring"} -- swap out moonshade earring

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Coiste bodhar", 
		head="Mpaca's cap", 
		neck="Fotia gorget", 
		ear1="Schere earring", 
		ear2="Sherida earring",
		body="Mpaca's doublet", 
		hands="Mpaca's gloves",
		ring1="Gere ring", 
		ring2="Niqmaddu ring", 
		back=str_da_cape,
		waist="Moonbow belt +1", 
		legs="Mpaca's hose", 
		feet="Mpaca's boots" 
	}    

    -- Specific weaponskill sets.
	
	-- fTP = fTP replicating WS, elemental gorgets/belts more effective
	-- Ascetic's Fury = 50% STR / 50% VIT, Crit, fTP. SC: Fusion / Transfixion
    sets.precast.WS["Ascetic's Fury"] = {ammo="Crepuscular pebble",
		head="Adhemar bonnet +1",
		neck="Fotia gorget",
		ear1="Schere earring", 
		ear2="Sherida earring",
		body="Bhikku cyclas +3",
		hands="Bhikku gloves +3",
		ring1="Gere ring", 
		ring2="Niqmaddu ring", 
		back=str_crit_cape,
		waist="Fotia belt",
		legs="Mpaca's hose", 
		feet="Kendatsuba sune-ate +1" 
	}

	-- Asuran Fists = 15% STR / 15% VIT, fTP. SC: Gravitation / Liquefaction
	sets.precast.WS['Asuran Fists'] = {ammo="Crepuscular pebble",
		head="Hesychast's crown +4", 
		neck="Monk's nodowa +2",
		ear1="Schere earring", 
		ear2="Sherida earring",
		body="Nyame mail",
		hands="Bhikku gloves +3",
		ring1="Gere ring", --Sroda ring
		ring2="Niqmaddu ring", 
		back=str_da_cape,
		waist="Fotia belt",
		legs="Mpaca's hose", 
		feet="Nyame sollerets" 
	}
	
	sets.precast.WS['Asuran Fists'].Midbuff = {ammo="Coiste bodhar",
		head="Hesychast's crown +4",
		neck="Fotia gorget",
		ear1="Schere earring", 
		ear2="Bhikku earring +2",
		body="Bhikku cyclas +3",
		hands="Bhikku gloves +3",
		ring1="Gere ring", 
		ring2="Regal ring", 
		back=str_da_cape,
		waist="Fotia belt",
		legs="Nyame flanchard", 
		feet="Nyame sollerets" 
	}
	
	-- Dragon Kick = 50% STR / 50% VIT, fTP, Kick attack+. SC: Fragmentation
	sets.precast.WS['Dragon Kick'] = {ammo="Crepuscular pebble",
		head="Mpaca's cap",
		neck="Monk's nodowa +2",
		ear1="Schere earring", 
		ear2="Moonshade earring", 
		body="Nyame mail",
		hands="Bhikku gloves +3",
		ring1="Gere ring", 
		ring2="Niqmaddu ring",
		back=str_da_cape,
		waist="Moonbow belt +1", 
		legs="Mpaca's hose", 
		feet="Anchorite's gaiters +4"}
		
	sets.precast.WS['Dragon Kick'].Midbuff = {ammo="Coiste bodhar",
		head="Mpaca's cap",
		neck="Monk's nodowa +2",
		ear1="Schere earring", 
		ear2="Moonshade earring", 
		body="Nyame mail",
		hands="Nyame gauntlets",
		ring1="Gere ring",
		ring2="Niqmaddu ring", 
		back=str_da_cape,
		waist="Moonbow belt +1", 
		legs="Nyame flanchard", 
		feet="Anchorite's gaiters +4"}
		
	-- Final Heaven = 80% VIT. SC: Light / Fusion
	sets.precast.WS['Final Heaven'] = {ammo="Crepuscular pebble",
		head="Hesychast's crown +4", 
		neck="Monk's nodowa +2",
		ear1="Schere earring", 
		ear2="Sherida earring", 
		body="Nyame mail",
		hands="Bhikku gloves +3",
		ring1="Gere ring",
		ring2="Niqmaddu ring",
		back=vit_wsd_cape,
		waist="Moonbow belt +1", 
		legs="Mpaca's hose", 
		feet="Nyame sollerets" 
	}
	
	sets.precast.WS['Final Heaven'].Midbuff = {ammo="Knobkierrie",
		head="Hesychast's crown +4", 
		neck="Monk's nodowa +2",
		ear1="Schere earring", 
		ear2="Bhikku earring +2", 
		body="Bhikku cyclas +3",
		hands="Nyame gauntlets",
		ring1="Gere ring",
		ring2="Niqmaddu ring",
		back=vit_wsd_cape,
		waist="Moonbow belt +1", 
		legs="Nyame flanchard", 
		feet="Nyame sollerets" 
	}
	-- Maru Kala = 80% VIT??? SC: Detonation / Compression / Distortion
	sets.precast.WS['Maru Kala'] = {ammo="Knobkierrie",
		head="Mpaca's cap", 
		neck="Monk's nodowa +2",
		ear1="Moonshade earring", 
		ear2="Sherida earring", 
		body="Bhikku cyclas +3",
		hands="Bhikku gloves +3",
		ring1="Ephramad's ring",
		ring2="Niqmaddu ring",
		back=str_wsd_cape,
		waist="Moonbow belt +1", 
		legs="Nyame flanchard", 
		feet="Nyame sollerets" 
	}
	
	sets.precast.WS['Maru Kala'].Midbuff = {ammo="Knobkierrie",
		head="Mpaca's cap", 
		neck="Republican platinum medal",
		ear1="Moonshade earring", 
		ear2="Schere earring", 
		body="Bhikku cyclas +3",
		hands="Bhikku gloves +3",
		ring1="Ephramad's ring",
		ring2="Regal ring",
		back=str_wsd_cape,
		waist="Moonbow belt +1", 
		legs="Nyame flanchard", 
		feet="Nyame sollerets" 
	}
	
	
	-- Howling Fist = 50% VIT / 20% STR, fTP. SC: Light / Fusion
	sets.precast.WS['Howling Fist'] = {ammo="Crepuscular pebble",
		head="Mpaca's cap",
		neck="Monk's nodowa +2",
		ear1="Schere earring", 
		ear2="Moonshade earring", 
		body="Nyame mail",
		hands="Bhikku gloves +3", 
		ring1="Gere ring", 
		ring2="Niqmaddu ring", 
		back=str_da_cape,
		waist="Moonbow belt +1",
		legs="Mpaca's hose", 
		feet="Nyame sollerets" 
	}
	
	sets.precast.WS['Howling Fist'].Midbuff = {ammo="Coiste bodhar",
		head="Mpaca's cap",
		neck="Republican platinum medal",
		ear1="Schere earring", 
		ear2="Moonshade earring", 
		body="Nyame mail",
		hands="Bhikku gloves +3", 
		ring1="Gere ring",
		ring2="Niqmaddu ring", 
		back=str_da_cape,
		waist="Moonbow belt +1", 
		legs="Mpaca's hose", 
		feet="Nyame sollerets" 
	}
	-- Raging Fists = 30% STR / 30% DEX, fTP. SC: Impaction
    sets.precast.WS['Raging Fists'] = {ammo="Crepuscular pebble",
		head="Mpaca's cap",
		neck="Monk's nodowa +2",
		ear1="Schere earring", 
		ear2="Moonshade earring",
		body="Malignance tabard",
		hands="Bhikku gloves +3",
		ring1="Gere ring",
		ring2="Niqmaddu ring", 
		back=str_da_cape,
		waist="Moonbow belt +1", 
		legs="Mpaca's hose",
		feet="Mpaca's boots" 
	}
	
	sets.precast.WS['Raging Fists'].Midbuff = {ammo="Coiste bodhar",
		head="Mpaca's cap",
		neck="Fotia gorget",
		ear1="Schere earring", 
		ear2="Moonshade earring",
		body="Bhikku cyclas +3",
		hands="Bhikku gloves +3",
		ring1="Gere ring", 
		ring2="Ephramad's ring", 
		back=str_da_cape,
		waist="Moonbow belt +1", 
		legs="Nyame flanchard",
		feet="Mpaca's boots" 
	}
	-- Shijin Spiral = 73-85% DEX, fTP. SC: Light / Fusion / Reverberation
    sets.precast.WS['Shijin Spiral'] = {ammo="Crepuscular pebble", 
		head="Mpaca's cap", --Ken. jinpachi +1
		neck="Monk's nodowa +2",
		ear1="Mache earring +1", 
		ear2="Sherida earring", 
		body="Adhemar jacket +1",
		hands="Bhikku gloves +3", 
		ring1="Gere ring", 
		ring2="Niqmaddu ring", 
		back=dex_da_cape,
		waist="Moonbow belt +1", 
		legs="Mpaca's hose",
		feet="Kendatsuba sune-ate +1"
	}
	
	sets.precast.WS['Shijin Spiral'].Midbuff = {ammo="Coiste bodhar", 
		head="Mpaca's cap",
		neck="Fotia gorget",
		ear1="Schere earring", 
		ear2="Sherida earring", 
		body="Bhikku cyclas +3",
		hands="Bhikku gloves +3", 
		ring1="Gere ring", 
		ring2="Niqmaddu ring", 
		back=dex_da_cape,
		waist="Moonbow belt +1", 
		legs="Nyame flanchard",
		feet="Mpaca's boots"
	}
	-- Tornado Kick = 40% VIT / STR 40% , fTP, Kick attack+. SC: Induration / Impaction / Detonation
    sets.precast.WS['Tornado Kick'] = {ammo="Crepuscular pebble",
		head="Mpaca's cap",
		neck="Monk's nodowa +2",
		ear1="Schere earring", 
		ear2="Moonshade earring", 
		body="Nyame mail",
		hands="Bhikku gloves +3",
		ring1="Gere ring", 
		ring2="Niqmaddu ring",
		back=str_da_cape,
		waist="Moonbow belt +1", 
		legs="Mpaca's hose", 
		feet="Anchorite's gaiters +4"}
		
	sets.precast.WS['Tornado Kick'].Midbuff = {ammo="Coiste bodhar",
		head="Mpaca's cap",
		neck="Monk's nodowa +2",
		ear1="Schere earring", 
		ear2="Moonshade earring", 
		body="Nyame mail",
		hands="Nyame gauntlets",
		ring1="Gere ring", 
		ring2="Niqmaddu ring",
		back=str_da_cape,
		waist="Moonbow belt +1", 
		legs="Nyame flanchard", 
		feet="Anchorite's gaiters +4"}
		
	-- Victory Smite = 80% STR, Crit, fTP. SC: Light / Fragmentation
    sets.precast.WS["Victory Smite"] = {ammo="Crepuscular pebble",
		head="Blistering sallet +1",
		neck="Monk's nodowa +2",
		ear1="Schere earring",
		ear2="Sherida earring",
		body="Bhikku cyclas +3",
		hands="Bhikku gloves +3",
		ring1="Gere ring", 
		ring2="Niqmaddu ring", 
		back=str_crit_cape,
		waist="Moonbow belt +1", 
		legs="Mpaca's hose",
		feet="Mpaca's boots"
	}
	
	sets.precast.WS["Victory Smite"].Midbuff = {ammo="Crepuscular pebble",
		head="Adhemar bonnet +1",
		neck="Fotia gorget",
		ear1="Schere earring",
		ear2="Sherida earring",
		body="Bhikku cyclas +3",
		hands="Bhikku gloves +3",
		ring1="Gere ring", 
		ring2="Niqmaddu ring", 
		back=dex_da_cape,
		waist="Moonbow belt +1", 
		legs="Mpaca's hose",
		feet="Kendatsuba sune-ate +1"
	}

    sets.precast.WS['Cataclysm'] = {}
    
    -- Midcast Sets
    sets.midcast.FastRecast = {}
        
    -- Specific spells
    sets.midcast.Utsusemi = {}
	
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets
    sets.idle = {		
		--main=sets.weapon,
		ammo="Staunch tathlum +1",
		head="Nyame helm", 
		neck="Warder's charm +1",
		ear1="Infused earring", 
		ear2="Eabani earring", 
		body="Nyame mail", 
		hands="Nyame gauntlets", 
		ring1="Murky ring",
		ring2="Shneddick ring", 
		back="Archon cape", 
		waist="Null belt",
		legs="Nyame flanchard", 
		feet="Nyame sollerets" 
	}

    -- Defense sets
    -- sets.defense.PDT = {}
    -- sets.defense.HP = {}
    -- sets.defense.MDT = {}

    sets.Kiting = {ring2="Shneddick ring"} --Movement speed +18%

    sets.ExtraRegen = {}

    -- Engaged sets
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee sets
	
	-- Martial arts needed w/ capped magic haste:
	--spharai/varga: 4.56
	--glanzfaust: 8.16
	--verethragna: -8.04
	--godhands: 12.48 (Mache earring +1)

    -- Defensive melee hybrid sets
	-- PDT 46/50, MDT 31/50
	-- (15 SB caps for monk, 25 SB2 hits total SB cap of 75)
	-- Caps: Haste=25, Subtle blow(SB)=15, Subtle blow II(SB2)=50.
	-- Focus: Acc, Store TP, MultiAttack

    sets.engaged = {
		ammo="Coiste bodhar", 
		head="Bhikku crown +3", 
		neck="Monk's nodowa +2",
		ear1="Schere earring", 
		ear2="Sherida earring",
		body="Mpaca's doublet", 
		hands="Malignance gloves", 
		ring1="Gere ring", 
		ring2="Niqmaddu ring", 
		back="Null shawl", 
		waist="Moonbow belt +1", 
		legs="Bhikku hose +3", 
		feet="Malignance boots"
	}
		
    -- Defensive melee hybrid sets
	-- PDT 46/50, MDT 31/50
	-- (15 SB caps for monk, 25 SB2 hits total SB cap of 75)
	-- Caps: Haste=25, Subtle blow(SB)=15, Subtle blow II(SB2)=50.
	-- Focus: Acc, Store TP, MultiAttack
	
	--Spharai
    sets.engaged.Counter = {
		ammo="Coiste bodhar", 
		head="Bhikku crown +3", 
		neck="Bathy choker +1", 
		ear1="Sherida earring", 
		ear2="Bhikku earring +2", 
		body="Mpaca's doublet", 
		hands="Malignance gloves", 
		ring1="Gere ring", 
		ring2="Niqmaddu ring", 
		back=dex_da_cape, 
		waist="Moonbow belt +1", 
		legs="Bhikku hose +3", 
		feet="Anchorite's gaiters +4" 
	}
		
    -- Hundred Fists/Impetus melee set mods
	sets.engaged.Impetus = set_combine(sets.engaged, {body="Bhikku cyclas +3"})
	sets.engaged.HF = set_combine(sets.engaged, {legs="Hesychast's Hose +3"})
    sets.engaged.HF.Impetus = set_combine(sets.engaged, {body="Bhikku cyclas +3",legs="Hesychast's Hose +3"})
    sets.engaged.Counter.Impetus = set_combine(sets.engaged.Counter, {body="Bhikku cyclas +3"})
	sets.engaged.Counter.HF = set_combine(sets.engaged.Counter,{legs="Hesychast's Hose +3"})
    sets.engaged.Counter.HF.Impetus = set_combine(sets.engaged.Counter, {body="Bhikku cyclas +3",legs="Hesychast's Hose +3"})

    -- Footwork combat form
    sets.engaged.Footwork = set_combine(sets.engaged, {back=dex_da_cape,legs="Bhikku hose +3",feet="Anchorite's gaiters +4"})
        
    -- Quick sets for post-precast adjustments, listed here so that the gear can be Validated.
	sets.default_waist = {waist="Moonbow belt +1"}
	sets.boost_waist = {waist="Ask sash"} --Regain +200
    sets.impetus_body = {body="Bhikku cyclas +3"}
    sets.footwork_kick = {back=dex_da_cape,legs="Bhikku hose +3",feet="Anchorite's gaiters +4"}
	
	-- glamor sets
	sets.fashion = {}
	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 3)
end

function fashion_particulars()
	--send_command('wait 1;gs equip fashion.af;wait 1;input /lockstyle on')
	send_command('wait 1;input /lockstyleset 33;gs equip sets.idle;')
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Don't gearswap for weaponskills when Defense is on.
    if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
        eventArgs.handled = true
    end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
        if state.Buff.Impetus and (spell.english == "Ascetic's Fury" or spell.english == "Victory Smite") then
            equip(sets.impetus_body)
        elseif state.Buff.Footwork and (spell.english == "Dragon's Kick" or spell.english == "Tornado Kick") then
            equip(sets.footwork_kick)
        end
		
		if state.Buff.Boost then
			equip(sets.boost_waist)
		end
        
        -- Replace Moonshade Earring if we're at cap TP
		-- Max 3000 minus Godhands' 500 TP bonus
        if player.tp == 2500 then
            equip(sets.precast.MaxTP)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' and not spell.interrupted and state.FootworkWS and state.Buff.Footwork then
        --send_command('cancel Footwork')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)

    -- Set Footwork as combat form any time it's active and Hundred Fists is not.
    if buff == 'Footwork' and gain and not buffactive['hundred fists'] then
        state.CombatForm:set('Footwork')
    elseif buff == "Hundred Fists" and not gain and buffactive.footwork then
        state.CombatForm:set('Footwork')
    else
        state.CombatForm:reset()
    end
    
    -- Hundred Fists and Impetus modify the custom melee groups
    if buff == "Hundred Fists" or buff == "Impetus" then
        classes.CustomMeleeGroups:clear()
        
        if (buff == "Hundred Fists" and gain) or buffactive['hundred fists'] then
            classes.CustomMeleeGroups:append('HF')
        end
        
        if (buff == "Impetus" and gain) or buffactive.impetus then
            classes.CustomMeleeGroups:append('Impetus')
        end
    end
	
    -- Update gear if any of the above changed
    if buff == "Hundred Fists" or buff == "Impetus" or buff == "Footwork" then
        handle_equipping_gear(player.status)
    end
	
	if buff == "Boost" and gain then
		equip(sets.boost_waist)
	elseif buff == "Boost" and not gain then
		equip(sets.default_waist)
	end
	
	if buff == "Doom" then
		if gain then
			send_command('@input /p Doomed.')
		else
			send_command('@input /p Doom off.')
		end
	end

	if buff == "Charm" then
		if gain then
			send_command('@input /p Charmed~ <3')
        else
            send_command('@input /p Charm off. </3')
		end
	end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
    if player.hpp < 75 then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end
    
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    update_combat_form()
    update_melee_groups()
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    if buffactive.footwork and not buffactive['hundred fists'] then
        state.CombatForm:set('Footwork')
    else
        state.CombatForm:reset()
    end
end

function update_melee_groups()
    classes.CustomMeleeGroups:clear()
    
    if buffactive['hundred fists'] then
        classes.CustomMeleeGroups:append('HF')
    end
    
    if buffactive.impetus then
        classes.CustomMeleeGroups:append('Impetus')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Custom event hooks.
-------------------------------------------------------------------------------------------------------------------

-- Keep track of the current hit count while Impetus is up.
function on_action_for_impetus(action)
    if state.Buff.Impetus then
        -- count melee hits by player
        if action.actor_id == player.id then
            if action.category == 1 then
                for _,target in pairs(action.targets) do
                    for _,action in pairs(target.actions) do
                        -- Reactions (bitset):
                        -- 1 = evade
                        -- 2 = parry
                        -- 4 = block/guard
                        -- 8 = hit
                        -- 16 = JA/weaponskill?
                        -- If action.reaction has bits 1 or 2 set, it missed or was parried. Reset count.
                        if (action.reaction % 4) > 0 then
                            info.impetus_hit_count = 0
                        else
                            info.impetus_hit_count = info.impetus_hit_count + 1
                        end
                    end
                end
            elseif action.category == 3 then
                -- Missed weaponskill hits will reset the counter.  Can we tell?
                -- Reaction always seems to be 24 (what does this value mean? 8=hit, 16=?)
                -- Can't tell if any hits were missed, so have to assume all hit.
                -- Increment by the minimum number of weaponskill hits: 2.
                for _,target in pairs(action.targets) do
                    for _,action in pairs(target.actions) do
                        -- This will only be if the entire weaponskill missed or was parried.
                        if (action.reaction % 4) > 0 then
                            info.impetus_hit_count = 0
                        else
                            info.impetus_hit_count = info.impetus_hit_count + 2
                        end
                    end
                end
            end
        elseif action.actor_id ~= player.id and action.category == 1 then
            -- If mob hits the player, check for counters.
            for _,target in pairs(action.targets) do
                if target.id == player.id then
                    for _,action in pairs(target.actions) do
                        -- Spike effect animation:
                        -- 63 = counter
                        -- ?? = missed counter
                        if action.has_spike_effect then
                            -- spike_effect_message of 592 == missed counter
                            if action.spike_effect_message == 592 then
                                info.impetus_hit_count = 0
                            elseif action.spike_effect_animation == 63 then
                                info.impetus_hit_count = info.impetus_hit_count + 1
                            end
                        end
                    end
                end
            end
        end
        
        --add_to_chat(123,'Current Impetus hit count = ' .. tostring(info.impetus_hit_count))
    else
        info.impetus_hit_count = 0
    end
    
end
