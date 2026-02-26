-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    gs c toggle LuzafRing -- Toggles use of Luzaf Ring on and off
    
    Offense mode is melee or ranged.  Used ranged offense mode if you are engaged
    for ranged weaponskills, but not actually meleeing.
    
    Weaponskill mode, if set to 'Normal', is handled separately for melee and ranged weaponskills.
--]]


-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
--     -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    -- Whether to use Luzaf's Ring
    state.LuzafRing = M(true, "Luzaf's Ring")
    -- Whether a warning has been given for low ammo
    state.warned = M(false)

    define_roll_values()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Ranged', 'Melee')
    state.RangedMode:options('Normal')
    state.WeaponskillMode:options('Normal')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal')

    bullet = "Eminent bullet"
    gear.RAbullet = bullet
    gear.WSbullet = bullet
    gear.MAbullet = bullet
    gear.QDbullet = bullet
    options.ammo_warning_limit = 15
	
	state.CombatWeapon = M{['description']='Weapon Selection','Savage','Daggers'}--,'Nusku','Baby'}

    -- Additional local binds
    send_command('bind ^` input /ja "Double-up" <me>')
    send_command('bind !` input /ja "Bolter\'s Roll" <me>')

    select_default_macro_book()
	fashion_particulars()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
	
	-- Augmented ambuscade JSE capes
	agi_wsd_cape = { name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Damage taken-5%',}}

    -- Precast Sets

    -- Precast sets to enhance JAs
    
    sets.precast.JA['Triple Shot'] = {body="Navarch's Frac +2"}
    sets.precast.JA['Snake Eye'] = {legs="Lanun trews +1"}
    sets.precast.JA['Wild Card'] = {feet="Lanun bottes +4"}
    sets.precast.JA['Random Deal'] = {body="Lanun frac +1"}


    sets.precast.CorsairRoll = {
		head="Lanun tricorne +1", neck="Regal necklace", hands="Chasseur's gants +3"}
		--Rostam path C
		
	sets.precast.CorsairRoll.Duration = {range="Compensator",
		head="Lanun tricorne +1", hands="Chasseur's gants +3", back=agi_wsd_cape}
    
    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Navarch's Culottes +2"})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Navarch's Bottes +2"})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Navarch's Tricorne +2"})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Navarch's Frac +2"})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's gants +3"})
    
    sets.precast.LuzafRing = {ring2="Luzaf's ring"}
    sets.precast.FoldDoubleBust = {hands="Lanun gants +3"}
    
    sets.precast.CorsairShot = {head="Blood Mask"}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Whirlpool Mask",
        body="Iuitl Vest",hands="Iuitl Wristbands",
        legs="Nahtirah Trousers",feet="Iuitl Gaiters +1"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {head="Haruspex Hat",ear2="Loquacious Earring",hands="Thaumas Gloves",ring1="Prolix Ring"}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


    sets.precast.RA = {ammo=gear.RAbullet,
        head="Malignance chapeau",neck="Commodore charm +2",ear1="Telos earring",ear2="Crepuscular earring",
        body="Malignance tabard",hands="Lanun gants +3",ring1="Ilabrat ring",ring2="Crepuscular ring",
        back="Null shawl",waist="Null belt",legs="Volte tights",feet="Malignance boots"}

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo=gear.WSbullet,
        head="Nyame helm",neck="Commodore charm +2",ear1="Moonshade earring",ear2="Ishvara earring",
        body="Nyame mail",hands="Chasseur's gants +3",ring1="Regal ring",ring2="Ephramad's ring",
        back=agi_wsd_cape,waist="Sailfi belt +1",legs="Nyame flanchard",feet="Lanun bottes +4"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS['Last Stand'] = {ammo=gear.WSbullet,
	    head="Lanun tricorne +1",neck="Fotia gorget",ear1="Moonshade earring",ear2="Ishvara earring",
        body="Nyame mail",hands="Chasseur's gants +3",ring1="Regal ring",ring2="Dingir ring",
        back=agi_wsd_cape,waist="Fotia belt",legs="Nyame flanchard",feet="Lanun bottes +4"}
		
	sets.precast.WS['Leaden Salute'] = {ammo=gear.MAbullet,
	    head="Pixie hairpin +1",neck="Commodore charm +2",ear1="Moonshade earring",ear2="Friomisi earring",
        body="Nyame mail",hands="Nyame gauntlets",ring1="Archon ring",ring2="Dingir ring",
        back=agi_wsd_cape,waist="Eschan stone",legs="Nyame flanchard",feet="Lanun bottes +4"}
		
	sets.precast.WS['Savage Blade'] = {ammo=gear.WSbullet,
        head="Nyame helm",neck="Republican platinum medal",ear1="Moonshade earring",ear2="Ishvara earring",
        body="Nyame mail",hands="Chasseur's gants +3",ring1="Regal ring",ring2="Ephramad's ring",
        back=agi_wsd_cape,waist="Sailfi belt +1",legs="Nyame flanchard",feet="Nyame sollerets"}
    
    -- Midcast Sets
    sets.midcast.FastRecast = {
        head="Whirlpool Mask",
        body="Iuitl Vest",hands="Iuitl Wristbands",
        legs="Manibozho Brais",feet="Iuitl Gaiters +1"}
        
    -- Specific spells
    sets.midcast.Utsusemi = sets.midcast.FastRecast

    sets.midcast.CorsairShot = {ammo=gear.QDbullet,
        head="Corsair's tricorne",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Lanun Frac",hands="Schutzen Mittens",ring1="Hajduk Ring",ring2="Demon's Ring",
        back="Toro Cape",waist="Aquiline Belt",legs="Iuitl Tights",feet="Lanun bottes +4"}

    sets.midcast.CorsairShot['Light Shot'] = {ammo=gear.QDbullet,
        head="Corsair's tricorne",neck="Stoicheion Medal",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body="Lanun Frac",hands="Schutzen Mittens",ring1="Stormsoul Ring",ring2="Sangoma Ring",
        back="Navarch's Mantle",waist="Aquiline Belt",legs="Iuitl Tights",feet="Lanun bottes +4"}

    sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot['Light Shot']

    -- Ranged gear
    sets.midcast.RA = {ammo=gear.RAbullet,
        head="Malignance chapeau",neck="Null loop",ear1="Telos earring",ear2="Crepuscular earring",
        body="Malignance tabard",hands="Malignance gloves",ring1="Ilabrat ring",ring2="Crepuscular ring",
        back="Null shawl",waist="Null belt",legs="Malignance tights",feet="Malignance boots"}

    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}

    -- Idle sets
    sets.idle = {ammo=gear.RAbullet,
        head="Nyame helm",neck="Warder's charm +1",ear1="Infused earring",ear2="Eabani earring",
        body="Adamantite armor",hands="Nyame gauntlets",ring1="Defending ring",ring2="Shneddick ring",
        back="Archon cape",waist="Carrier's sash",legs="Nyame flanchard",feet="Nyame sollerets"}
	
    sets.Kiting = {ring2="Shneddick ring"}
	
	--------------------------------------
	-- Weapons
	--------------------------------------
	sets.weapons = {}
	sets.weapons.Savage = {main="Naegling",sub="Gleti's knife"}
	sets.weapons.Daggers = {main="Tauret",sub="Gleti's knife"}
	sets.weapons.Nusku = {main="Naegling",sub="Nusku shield"}
	sets.weapons.Baby = {main="Joyeuse",sub="Bone knife"}
	
    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged.Melee = {ammo=gear.RAbullet,
        head="Malignance chapeau",neck="Null loop",ear1="Telos earring",ear2="Suppanomimi",
        body="Malignance tabard",hands="Malignance gloves",ring1="Ilabrat ring",ring2="Defending ring",--"Chirich ring +1",
        back="Null shawl",waist="Reiki yotai",legs="Malignance tights",feet="Malignance boots"}
		
    sets.engaged.Melee.DW = {ammo=gear.RAbullet,
        head="Malignance chapeau",neck="Null loop",ear1="Telos earring",ear2="Suppanomimi",
        body="Malignance tabard",hands="Malignance gloves",ring1="Ilabrat ring",ring2="Defending ring",--"Chirich ring +1",
        back="Null shawl",waist="Reiki yotai",legs="Malignance tights",feet="Malignance boots"}
    
	sets.engaged.Ranged = {ammo=gear.RAbullet,
        head="Malignance chapeau",neck="Null loop",ear1="Telos earring",ear2="Suppanomimi",
        body="Malignance tabard",hands="Malignance gloves",ring1="Ilabrat ring",ring2="Defending ring",
        back="Null shawl",waist="Reiki yotai",legs="Malignance tights",feet="Malignance boots"}
		
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 19)
end

function fashion_particulars()
	send_command('wait 1;input /lockstyleset 30;wait 1;gs equip sets.idle')
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Check that proper ammo is available if we're using ranged attacks or similar.
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        do_bullet_checks(spell, spellMap, eventArgs)
    end

    -- gear sets
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") then
	
		equip(sets.precast.CorsairRoll.Duration)
		
		if state.LuzafRing.value then
			equip(sets.precast.LuzafRing)
		end
    elseif spell.type == 'CorsairShot' and state.CastingMode.value == 'Resistant' then
        classes.CustomClass = 'Acc'
    elseif spell.english == 'Fold' and buffactive['Bust'] == 2 then
        if sets.precast.FoldDoubleBust then
            equip(sets.precast.FoldDoubleBust)
            eventArgs.handled = true
        end
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairRoll' and not spell.interrupted then
        display_roll_info(spell)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, spellMap, default_wsmode)
    if buffactive['Transcendancy'] then
        return 'Brew'
    end
end


-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    if newStatus == 'Engaged' and player.equipment.main == 'Chatoyant Staff' then
        state.OffenseMode:set('Ranged')
    end
end


-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''
    
    msg = msg .. 'Off.: '..state.OffenseMode.current
    msg = msg .. ', Rng.: '..state.RangedMode.current
    msg = msg .. ', WS.: '..state.WeaponskillMode.current
    msg = msg .. ', QD.: '..state.CastingMode.current

    if state.DefenseMode.value ~= 'None' then
        local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
        msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
    end
    
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end
    
    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value then
        msg = msg .. ', Target NPCs'
    end

    msg = msg .. ', Roll Size: ' .. ((state.LuzafRing.value and 'Large') or 'Small')
    
    add_to_chat(201, msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function define_roll_values()
    rolls = {
        ["Corsair's Roll"]   = {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"]       = {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"]    = {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"]       = {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"]     = {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"]    = {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Puppet Roll"]      = {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"]      = {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"]      = {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"]       = {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"]     = {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"]    = {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"]     = {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"]   = {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Drachen Roll"]     = {lucky=3, unlucky=7, bonus="Pet Accuracy"},
        ["Gallant's Roll"]   = {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"]    = {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"]    = {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"]   = {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Bolter's Roll"]    = {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"]    = {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"]   = {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"]   = {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] = {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies's Roll"]    = {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"]     = {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] = {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"]   = {lucky=4, unlucky=8, bonus="Counter Rate"},
    }
end

function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    local rollsize = (state.LuzafRing.value and 'Large') or 'Small'

    if rollinfo then
        add_to_chat(201, spell.english..' provides a bonus to '..rollinfo.bonus..'.  Roll size: '..rollsize)
        add_to_chat(201, 'Lucky roll is '..tostring(rollinfo.lucky)..', Unlucky roll is '..tostring(rollinfo.unlucky)..'.')
    end
end


-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
    local bullet_name
    local bullet_min_count = 1
    
    if spell.type == 'WeaponSkill' then
        if spell.skill == "Marksmanship" then
            if spell.element == 'None' then
                -- physical weaponskills
                bullet_name = gear.WSbullet
            else
                -- magical weaponskills
                bullet_name = gear.MAbullet
            end
        else
            -- Ignore non-ranged weaponskills
            return
        end
    elseif spell.type == 'CorsairShot' then
        bullet_name = gear.QDbullet
    elseif spell.action_type == 'Ranged Attack' then
        bullet_name = gear.RAbullet
        if buffactive['Triple Shot'] then
            bullet_min_count = 3
        end
    end
    
    local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]
    
    -- If no ammo is available, give appropriate warning and end.
    if not available_bullets then
        if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
            add_to_chat(201, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
            return
        elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
            add_to_chat(201, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
            return
        else
            add_to_chat(201, 'No ammo ('..tostring(bullet_name)..') available for that action.')
            eventArgs.cancel = true
            return
        end
    end
    
    -- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
    if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and available_bullets.count <= bullet_min_count then
        add_to_chat(201, 'No ammo will be left for Quick Draw.  Cancelling.')
        eventArgs.cancel = true
        return
    end
    
    -- Low ammo warning.
    if spell.type ~= 'CorsairShot' and state.warned.value == false
        and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
        local msg = '*****  LOW AMMO WARNING: '..bullet_name..' *****'
        --local border = string.repeat("*", #msg)
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end
        
        add_to_chat(201, border)
        add_to_chat(201, msg)
        add_to_chat(201, border)

        state.warned:set()
    elseif available_bullets.count > options.ammo_warning_limit and state.warned then
        state.warned:reset()
    end
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
