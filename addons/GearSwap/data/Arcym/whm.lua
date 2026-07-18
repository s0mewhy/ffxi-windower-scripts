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
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
end

-- Setup vars that are user-dependent.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')

	state.MagicBurst = M(true, 'Magic Burst')
	
	pick_tp_weapon()
	blink = true

    select_default_macro_book()
	fashion_particulars()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
	enh_telchine_head = { name="Telchine Cap" }--, augments={'Enh. Mag. eff. dur. +10',}}
	enh_telchine_body = { name="Telchine Chasuble" }--, augments={'Enh. Mag. eff. dur. +10',}}
	enh_telchine_legs = { name="Telchine Braconi" }--, augments={'Enh. Mag. eff. dur. +10',}}
	enh_telchine_hands = { name="Telchine Gloves" }--, augments={'Enh. Mag. eff. dur. +9',}}
    -- Precast Sets
	
    -- Fast cast sets for spells
	-- FC cap 80, Light Arts gives 10 FC
	-- FC 74(cap 80), Haste 26(cap 25), QM=5
	sets.precast.FC = {main="Grioavolr", --FC 10
		sub="Umbra strap",ammo="Impatiens", --QM 2
		head="Ebers cap +3", --FC 13
		neck="Cleric's torque +2", --(not done)FC 2 
		ear1="Etiolation earring", --FC 1
		ear2="Malignance earring", --FC 4
		body="Inyanga jubbah +2", --FC 14
		hands="Gendewitha gages +1", --FC 7
		ring1="Defending ring",ring2="Kishar ring", --FC 4
		back="Fi follet cape +1", --FC 10
		waist="Witful belt", --FC 3, QM 3
		legs="Ebers pantaloons +3", --DT
		feet="Volte gaiters"} --FC 6
        --Lebeche ring for Quick Magic
		
    sets.precast.FC.StatusRemoval = sets.precast.FC
	-- Divine Benison (FC/Enmity down for -na spells)
	sets.precast.FC.StatusRemoval = set_combine(sets.precast.FC,
		{main="Yagrush",sub="Ammurapi shield",legs="Ebers pantaloons +3"})
		
	-- Enh. duration in precast for spells that cast too quickly to swap midcast gear
	sets.EnhancingDuration = {main="Gada",sub="Ammurapi shield", 
		waist="Embla sash", legs=enh_telchine_legs, feet="Theophany duckbills +3"}
	--sets.precast.FC.Haste = set_combine(sets.precast.FC, sets.EnhancingDuration)
	
	-- Special FC for spells from gear
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Ammurapi shield"})
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {body="Crepuscular cloak"})
	
    -- CureMelee spell map should default back to Healing Magic.
    
    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {body="Piety bliaut +3"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
    
    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    gear.default.weaponskill_neck = ""
    gear.default.weaponskill_waist = ""
    sets.precast.WS = {
		ammo="Oshasha's treatise",
		head="Nyame helm", 
		neck="Fotia gorget", --Latent(Skillchain): WS fTP +10%, TP not depleted 1%
		ear1="Ishvara earring", --WSD 2%
		ear2="Moonshade earring", --TP bonus +250
		body="Nyame mail", --MND +37, STR +35, Acc +40, Att +30
		hands="Nyame gauntlets", 
		ring1="Ilabrat ring", --DEX +10, Att +25
		ring2="Ephramad's ring",
		back="Alaunus's cape", 
		waist="Famine sash", --Acc+10, Att+10
		legs="Nyame flanchard", --Aug WSD+4/Att+12
		feet="Nyame sollerets" --Aug WSD+6/Att+20
	}
    
	-- fTP = fTP replicating WS, elemental gorgets/belts more effective
	-- Mystic Boon = 70% MND / 30% STR, SC: None
    sets.precast.WS['Mystic Boon'] = {
		ammo="Oshasha's treatise",
		head="Nyame helm", --MND +25, STR +26, Acc +40, Att +30
		neck="Lissome necklace", --DA 1%, Acc +8
		ear1="Regal earring", --MND +10
		ear2="Moonshade earring", --TP bonus +250
		body="Nyame mail", --MND +37, STR +35, Acc +40, Att +30
		hands="Nyame gauntlets", --MND +40, STR +17, Acc +40, Att +30
		ring1="Stikini ring", --MND +5
		ring2="Metamorph ring +1", --MND +6
		back="Alaunus's cape", --MND +20
		waist="Famine sash", --Acc+10, Att+10
		legs="Nyame flanchard", --Aug WSD+4/Att+12
		feet="Nyame sollerets" --Aug WSD+6/Att+20
	}

    -- Midcast Sets
    
    sets.midcast.FastRecast = sets.precast.FC
    
    -- Cure sets
    gear.default.obi_waist = ""
    gear.default.obi_back = ""

	--Divine skill=57, MP=1613
	sets.midcast['Divine Magic'] = {main="Daybreak",sub="Ammurapi shield",ammo="Pemphredo tathlum",
		head="Theophany cap +3",neck="Jokushu chain",ear1="Regal earring",ear2="Malignance earring",
		body="Theophany bliaut +3",hands="Inyanga dastanas +2",ring1="Stikini ring",ring2="Stikini ring",
		back="Alaunus's cape",waist="Acuity belt +1",legs="Theophany pantaloons +3",feet="Theophany duckbills +3"}

	-- Enf. skill=78, MP=1659
	sets.midcast['Enfeebling Magic'] = {main="Bunzi's rod",sub="Ammurapi shield",ammo="Pemphredo tathlum",
		head="Theophany cap +3",neck="Null loop",ear1="Regal earring",ear2="Ebers earring +2",
		body="Theophany bliaut +3",hands="Regal cuffs",ring1="Kishar ring",ring2="Stikini ring",
		back="Alaunus's cape",waist="Obstinate sash",legs="Chironic hose",feet="Theophany duckbills +3"}

	-- 110 total Enhancing Magic Skill caps even without Light Arts
	-- Enh skill 83, duration +30%, MP=1648
	sets.midcast['Enhancing Magic'] = {main="Gada", --Enh.dur.+5
		sub="Ammurapi shield", --Enh.dur.+10
		ammo="Pemphredo tathlum",
		head=enh_telchine_head,neck="Incanter's torque",ear1="Regal earring",ear2="Mimir earring",
		body=enh_telchine_body,hands=enh_telchine_hands,ring1="Stikini ring",ring2="Mephitas's ring +1",
		back="Fi follet cape +1",waist="Embla sash",legs=enh_telchine_legs,feet="Theophany duckbills +3"}

	--sets.midcast['Dark Magic'] = {}

	-- Healing skill=73, MP=1620
	sets.midcast['Healing Magic'] = {main="Gada",
		sub="Thuellaic ecu +1", --CMP+4
		ammo="Pemphredo tathlum",
		head="Theophany cap +3",neck="Incanter's torque",ear1="Mendicant's earring",ear2="Ebers earring +2",
		body="Ebers bliaut +3",hands="Theophany mitts +3",ring1="Menelaus's ring",ring2="Mephitas's ring +1",
		back="Alaunus's cape",waist="Hachirin-no-obi",legs="Piety pantaloons +3",feet="Vanya clogs"}
	
	-- Cure Potency=50/50, Cure Potency II=9/30, Healing skill=72, MP=1588
    sets.midcast.CureSolace = {main="Raetic rod +1", 
		sub="Thuellaic ecu +1", --CMP+4
		ammo="Pemphredo tathlum",
		head="Kaykaus mitra +1", --CP+11%,SIRD 12%, set bonus CP2 4%
		neck="Cleric's torque +2", 
		ear1="Mendicant's earring", --CMP+2
		ear2="Glorious earring", --CP2+2%,Enm-5
		body="Ebers bliaut +3", --AS+18
		hands="Theophany mitts +3",ring1="Defending ring",ring2="Mephitas's ring +1",
		back="Alaunus's cape",waist="Hachirin-no-obi",legs="Ebers pantaloons +3",
		feet="Kaykaus boots +1" --CureP+17%,CMP+7%, set bonus CP2 4%
	}
	--Naji's loop Cure Potency II

    sets.midcast.Cure = sets.midcast.CureSolace

    sets.midcast.Curaga = set_combine(sets.midcast.CureSolace,
		{body="Theophany bliaut +3",back="Twilight cape"})

    sets.midcast.CureMelee = sets.midcast.CureSolace
	
	--sets.midcast.CureWeather = {main="Chatoyant staff",sub="Wizzan grip", waist="Hachirin-no-obi"}
	sets.midcast.CureWeather = {waist="Hachirin-no-obi"}
	
	-- Divine Veil (AoE -na spells)
	sets.midcast.StatusRemoval = set_combine(sets.midcast['Healing Magic'], 
		{main="Yagrush", -- Makes all status removal spells Party AoE 
		sub="Thuellaic ecu +1",
		hands="Ebers mitts +3", legs="Ebers pantaloons +3"})
		
	-- Cursna=67, healing skill=73
    sets.midcast.Cursna = {
		main="Yagrush",sub="Thuellaic ecu +1",ammo="Pemphredo tathlum",
		head="Vanya hood",neck="Debilis medallion",ear1="Mendicant's earring",ear2="Ebers earring +2",
		body="Ebers bliaut +3",hands="Theophany mitts +3",ring1="Menelaus's ring",ring2="Haoma's ring",
		back="Alaunus's cape",waist="Hachirin-no-obi",legs="Theophany pantaloons +3",feet="Vanya clogs"}

	sets.midcast.Erase = set_combine(sets.midcast.StatusRemoval, 
		{neck="Cleric's torque +2",
		legs="Ebers pantaloons +3"}) -- Erase+1

	-- Stoneskin +30
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], 
		{neck="Nodens gorget"})

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], 
		{main="Vadose rod",sub="Ammurapi shield"})

    sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'],{feet="Ebers duckbills +3"})
	--use FC (Haste-capped) for fast recast, plus duration
	
	sets.midcast.Raise = sets.midcast.FastRecast

	-- barspells have enh. magic cap of 500
    sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'],
		{main="Beneficus",sub="Ammurapi shield",head="Ebers cap +3",
		body="Ebers bliaut +3",hands="Ebers mitts +3",ring1="Stikini ring",ring2="Mephitas's ring +1",
		back="Alaunus's cape",legs="Piety pantaloons +3",feet="Ebers duckbills +3"})
		
	-- Add sroda when you get more enh. duration
	sets.midcast.BarStatus = set_combine(sets.midcast['Enhancing Magic'], {neck="Sroda necklace"})

	-- Regen potency and duration
    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], 
		{main="Bolelabunga",sub="Ammurapi shield",
		head="Inyanga tiara +2",body="Piety bliaut +3",
		hands="Ebers mitts +3",waist="Embla sash",legs="Theophany pantaloons +3"})
		
	sets.midcast.Haste = sets.midcast['Enhancing Magic']

    sets.midcast.Protectra = sets.midcast['Enhancing Magic']

    sets.midcast.Shellra = sets.midcast['Enhancing Magic']

    -- Custom spell classes
    sets.midcast.MndEnfeebles = sets.midcast['Enfeebling Magic']

    sets.midcast.IntEnfeebles = sets.midcast['Enfeebling Magic']
	
	sets.midcast.Flash = {
		main="Daybreak",sub="Ammurapi shield",ammo="Pemphredo tathlum",
		head="Theophany cap +3",neck="Jokushu chain",ear1="Regal earring",ear2="Ebers earring +2",
		body="Theophany bliaut +3",hands="Bunzi's gloves",ring1="Stikini ring",ring2="Stikini ring",
		back="Alaunus's cape",waist="Obstinate sash",legs="Theophany pantaloons +3",feet="Theophany duckbills +3"}
	
	sets.midcast.Repose = sets.midcast.Flash

	sets.midcast.Holy = {
		main="Daybreak",sub="Ammurapi shield",ammo="Ghastly tathlum +1",
		head="Bunzi's hat",neck="Sanctity necklace",ear1="Regal earring",ear2="Malignance earring",
		body="Bunzi's robe",hands="Bunzi's gloves",ring1="Freke ring",ring2="Mephitas's ring +1",
		back="Alaunus's cape",waist="Eschan stone",legs="Bunzi's pants",feet="Bunzi's sabots"}
		
	sets.midcast.Banish = sets.midcast.Holy
	
	sets.midcast.MagicBurst = {
		main="Daybreak",
		sub="Ammurapi shield",
		ammo="Ghastly tathlum +1",
		head="Bunzi's hat", --MBD+7, MAB+30, MAcc+40
		neck="Sanctity necklace",
		ear1="Regal earring",
		ear2="Malignance earring",
		body="Bunzi's robe", --MBD+10, MAB+30, MAcc+40
		hands="Bunzi's gloves", --MBD+8, MAB+30, MAcc+40
		ring1="Locus ring",
		ring2="Freke ring",
		back="Alaunus's cape",
		waist="Eschan stone",
		legs="Bunzi's pants", --MBD+9, MAB+30, MAcc+40
		feet="Bunzi's sabots" --MBD+6, MAB+30, MAcc+40
	}
	
	-- midcast spells from gear
	sets.midcast.Dispelga = set_combine(sets.midcast['Enfeebling Magic'], {main="Daybreak",sub="Ammurapi shield"})
	sets.midcast.Impact = {
		main="Bunzi's rod",sub="Ammurapi shield",ammo="Ghastly tathlum +1",
		neck="Sanctity necklace",ear1="Regal earring",ear2="Malignance earring",
		body="Crepuscular cloak",hands="Bunzi's gloves", ring1="Stikini ring",ring2="Mephitas's ring +1",
		back="Alaunus's cape",waist="Acuity belt +1",legs="Bunzi's pants",feet="Bunzi's sabots" 
	}
	
	sets.midcast.Sneak = sets.midcast['Enhancing Magic']
	sets.midcast.Invisible = sets.midcast['Enhancing Magic']


    -- Sets to return to when not performing an action.
    
    -- Resting sets
    --sets.resting = {}
	
    -- Idle sets (default idle set not needed since the other three are defined)
	-- PDT 53/50, MDT 51/50, Refresh 4~5, Regen 2
	sets.idle = {
		main="Daybreak", --Refresh +1, MEva +30, Main hand: Dispelga
		sub="Genmei shield", --PDT -10%, Eva +10
		ammo="Homiliary", --Refresh +1
		head="Bunzi's hat", --DT -7, MEva+123
		--neck="Bathy choker +1", --Regen +3, Eva
		neck="Loricate torque +1", --DT -6%, DEF 10~15
		ear1="Etiolation earring", --MDT -3%, HP +50, MP +50, Resist silence +15
		ear2="Ethereal earring", --Convert 3% of DT to MP, Eva +5, HP +15
		body="Shamash robe", -- resist silence +90
		hands="Ebers mitts +3", --DT -11, MEva +87
		ring1="Defending ring", --DT -10%
		ring2="Shneddick ring", --run fast
		back="Archon cape", -- 12% chance to negate dmg if >=85% of HP
		--back="Alaunus's cape", --PDT -10%, MEva +10
		waist="Carrier's sash",
		legs="Ebers pantaloons +3", --DT -12%, Meva +147
		feet="Volte gaiters" -- Refresh +1, MEva +142
	}

    -- Defense
	sets.defense.PDT = sets.idle
    sets.defense.MDT = sets.idle
    sets.Kiting = {ring2="Shneddick ring"}
    sets.latent_refresh = {waist="Fucho-no-obi"} -- Latent effect: MP<50%

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {} 

	sets.engaged.Normal = {main="Maxentius",sub="Genmei shield",ammo="Homiliary",
		head="Nyame helm",neck="Lissome necklace",ear1="Telos earring",ear2="Crepuscular earring",
		body="Ayanmo corazza +2",hands="Bunzi's gloves",ring1="Ilabrat ring",ring2="Chirich ring +1",
		back="Alaunus's cape",waist="Null belt",legs="Nyame flanchard",feet="Nyame sollerets"}
		
	-- Set if dual-wielding
    sets.engaged.DW = {
		main="Maxentius",sub="Cath palug hammer",ammo="Homiliary",
        head="Nyame helm", --Aug. Bunzi's hat
		neck="Lissome necklace",ear1="Telos earring",ear2="Suppanomimi",
        body="Ayanmo corazza +2",hands="Bunzi's gloves",ring1="Chirich ring +1",ring2="Ilabrat Ring",
        back="Alaunus's cape",waist="Null belt",legs="Nyame flanchard",feet="Nyame sollerets"}
	
    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Ebers mitts +3"} --,back="Mending Cape"}
	
	-- Fashion sets
	sets.fashion = {}

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 12)
end

function fashion_particulars()
	send_command('wait 1;input /lockstyleset 16;wait 1;gs equip sets.idle')
end
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    --if spell.english == "Paralyna" and buffactive.Paralyzed then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        --eventArgs.handled = true
    --end
	
	-- if spell.skill == 'Healing Magic' then
        -- gear.default.obi_back = "Mending Cape"
    -- else
        -- gear.default.obi_back = "Toro Cape"
    -- end
end

function job_post_midcast(spell, action, spellMap, eventArgs)

	if (state.MagicBurst.value and spell.name ~= 'Impact' and 
		(spell.skill == 'Divine Magic' or spell.skill == 'Elemental Magic')) then
		equip(sets.midcast.MagicBurst)
	end
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
	end
	
	if (spellMap == 'CureMelee' or spellMap == 'CureSolace') and 
		(world.weather_element == 'Light' or world.day_element == 'Light') then
		equip(sets.midcast.CureWeather)
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end

function job_buff_change(buff,gain)

	if buff == 'Doom' then
		if gain then
			send_command('@input /p Doomed.')
		else
			send_command('@input /p Doom off.')
		end
	end

	if buff == 'Charm' then
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

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if (default_spell_map == 'Cure' or default_spell_map == 'Curaga') and player.status == 'Engaged' then
            return "CureMelee"
        elseif default_spell_map == 'Cure' and state.Buff['Afflatus Solace'] then
            return "CureSolace"
        elseif spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end


function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
        local needsArts = 
            player.sub_job:lower() == 'sch' and
            not buffactive['Light Arts'] and
            not buffactive['Addendum: White'] and
            not buffactive['Dark Arts'] and
            not buffactive['Addendum: Black']
            
        if not buffactive['Afflatus Solace'] and not buffactive['Afflatus Misery'] then
            if needsArts then
                send_command('@input /ja "Afflatus Solace" <me>;wait 1.2;input /ja "Light Arts" <me>')
            else
                send_command('@input /ja "Afflatus Solace" <me>')
            end
        end
    end
end

-- Examine equipment to determine what our current TP weapon is.
function pick_tp_weapon() 
        if S{'NIN','DNC'}:contains(player.sub_job) then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
end

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
	-- toggle DressUP blinking on/off
	-- gs c toggle blink
    if cmdParams[1]:lower() == 'blink' then
        blink = not blink
		if blink then
			add_to_chat('Blink prevention: OFF')
			send_command('wait 1;du blinking self all off;')
		else
			add_to_chat('Blink prevention: ON')
			send_command('wait 1;du blinking self all on;')
		end
        eventArgs.handled = true
	-- gs c megabuff
	elseif cmdParams[1]:lower() == 'megabuff' then
		send_command('@input /ja "Light Arts" <me>;wait 1;\
						input /ja "Afflatus Solace" <me>;wait 2;\
						input /ma "Aurorastorm" <me>;wait 5;\
						input /ma "Protectra V" <me>;wait 5;\
						input /ma "Shellra V" <me>')
		eventArgs.handled = true
    end
end
