-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:
    
    ExtraSongsMode may take one of three values: None, Dummy, FullLength
    
    You can set these via the standard 'set' and 'cycle' self-commands.  EG:
    gs c cycle ExtraSongsMode
    gs c set ExtraSongsMode Dummy
    
    The Dummy state will equip the bonus song instrument and ensure non-duration gear is equipped.
    The FullLength state will simply equip the bonus song instrument on top of standard gear.
    
    
    Simple macro to cast a dummy Daurdabla song:
    /console gs c set ExtraSongsMode Dummy
    /ma "Shining Fantasia" <me>
    
    To use a Terpander rather than Daurdabla, set the info.ExtraSongInstrument variable to
    'Terpander', and info.ExtraSongs to 1.
--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.ExtraSongsMode = M{['description']='Extra Songs', 'None', 'Dummy', 'FullLength'}

    state.Buff['Pianissimo'] = buffactive['pianissimo'] or false

    -- For tracking current recast timers via the Timers plugin.
    custom_timers = {}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

    brd_daggers = S{'Kali', 'Twashtar', 'Carnwenhan', "Gleti's Knife", 'Centovente', 'Aeneas', 'Tauret', 'Naegling'}
    pick_tp_weapon()
    
    -- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Daurdabla'
    -- How many extra songs we can keep from Daurdabla/Terpander
    info.ExtraSongs = 2
    
    -- Set this to false if you don't want to use custom timers.
    state.UseCustomTimers = M(false, 'Use Custom Timers')
    
    -- Additional local binds
    send_command('bind ^numpad7 input /ws "Savage Blade" <t>')
    include('Global-Binds.lua') -- OK to remove this line	
	--send_command('bind ^` gs c cycle ExtraSongsMode')
    --send_command('bind !` input /ma "Chocobo Mazurka" <me>')

    select_default_macro_book()
	set_lockstyle()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    --send_command('unbind ^`')
    --send_command('unbind !`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {
		head="Bunzi's Hat", -- FC 10
		body="Inyanga Jubbah +2", -- FC 14
		hands="Gendewitha Gages +1", -- FC 7
		legs="Kaykaus Tights", -- FC 6
		feet="Fili Cothurnes +3", -- FC 13
		waist="Embla Sash", -- FC 5
		left_ear="Loquac. Earring", -- FC 5
		left_ring="Defending Ring",
		right_ring="Kishar Ring", -- FC 4
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}}, -- FC 10
		}

    --sets.precast.FC.Cure = set_combine(sets.precast.FC, {body="Heka's Kalasiris"})
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})
	
    --sets.precast.FC.Stoneskin = set_combine(sets.precast.FC, {head="Umuthi Hat"})
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC, {})

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Embla Sash"})
	--sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC.BardSong = {
		head="Fili Calot +3", -- SC 16
		body="Inyanga Jubbah +2", -- FC 14
		hands="Gendewitha Gages +1", -- SC 7+5
		legs="Kaykaus Tights", -- FC 6
		feet="Fili Cothurnes +3", -- FC 13
		neck="Loricate Torque +1",
		ear1="Eabani Earring", 
		ear2="Fili earring +1",
		ring1="Defending Ring",
		ring2="Moonlight Ring", 
		waist="Embla Sash", -- FC 5
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}}, -- FC 10
		} -- Total: 81 inc. Gifts

    sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})
        
    
    -- Precast sets to enhance JAs
    
	sets.precast.FC["Aria of Passion"] = set_combine(sets.precast.FC.BardSong,{range="Loughnashade"})
	sets.precast.FC["Honor March"] = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
    sets.precast.JA.Nightingale = {feet={ name="Bihu Slippers +3", augments={'Enhances "Nightingale" effect',}}}
    sets.precast.JA.Troubadour = {body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}}}
    sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +3"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
		range="Gjallarhorn",
    }
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {				
		range={ name="Linos", augments={'Accuracy+15 Attack+15','"Dbl.Atk."+3','Quadruple Attack +3',}},
		head="Nyame Helm",
		body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist="Fotia belt",
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Karieyh Ring +1",
		right_ring="Cornelia's Ring",
		back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
    		
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
		body="Nyame Mail",
		hands="Bunzi's Gloves",
		left_ear="Brutal Earring",
		right_ear="Telos Earring",
		left_ring="Hetairoi Ring",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}},
	})

	sets.precast.WS['Ruthless Stroke'] = set_combine(sets.precast.WS, {
		range={ name="Linos", augments={'Accuracy+13 Attack+13','Weapon skill damage +3%','DEX+8',}},
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}},
	})
	
	sets.precast.WS['Rudra\'s Storm'] = set_combine(sets.precast.WS, {
		range={ name="Linos", augments={'Accuracy+13 Attack+13','Weapon skill damage +3%','DEX+8',}},
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}},
	})
	
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS)

    sets.precast.WS['Mordant Rime'] = set_combine(sets.precast.WS, {	
		range={ name="Linos", augments={'Accuracy+15 Attack+15','Weapon skill damage +3%','CHR+8',}},
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear="Regal Earring",
		back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	})
    
	sets.precast.WS['Savage Blade'] = {	
		range={name="Linos", augments={'Accuracy+15 Attack+15','Weapon skill damage +3%','STR+8',}},
		head="Nyame Helm",
		body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Karieyh Ring +1",
		right_ring="Cornelia's Ring",
		back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
    }
	
	sets.precast.WS['Aeolian Edge'] = {ammo="Seeth. Bomblet +1",
        head="Nyame Helm",neck="Baetyl Pendant",ear1={name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},ear2="Crep. Earring",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Karieyh Ring +1",ring2="Dingir Ring",
        back=gear.wsd_jse_back,waist="Eschan Stone",legs="Nyame Flanchard",feet="Nyame Sollerets"}
    -- Midcast Sets

    -- General set for recast times.
    sets.midcast.FastRecast = {}
        
    -- Gear to enhance certain classes of songs.  No instruments added here since Gjallarhorn is being used.
    --sets.midcast.Ballad = {legs="Fili Rhingrave +3"}
	sets.midcast.Lullaby = {hands="Brioso Cuffs +3",range="Daurdabla"}
    sets.midcast.Madrigal = {head="Fili Calot +3", back={name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},feet="Fili Cothurnes +3",}
    sets.midcast.March = {hands="Fili Manchettes +3"}
    sets.midcast.Minuet = {body="Fili Hongreline +3"}
    sets.midcast.Minne = {legs="Mou. Seraweels +1",}
	sets.midcast.Prelude = {back={name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},feet="Fili Cothurnes +3"}
    sets.midcast.Paeon = {head="Brioso Roundlet +3"}
	sets.midcast.Carol = {hands="Mousai Gages +1",}
	sets.midcast.Mambo = {feet="Mou. Crackows +1"}
    sets.midcast["Sentinel's Scherzo"] = {feet="Fili Cothurnes +3"}
	sets.midcast['Magic Finale'] = {}
    sets.midcast.Mazurka = {range=info.ExtraSongInstrument}
    

    -- For song buffs (duration and AF3 set bonus)
    sets.midcast.SongEffect = {
		--main="Carnwenhan",
		range="Gjallarhorn",
		head="Fili Calot +3",
		body="Fili Hongreline +3",
		hands="Fili Manchettes +3",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +3",
		neck="Mnbw. Whistle +1",
		right_ear={name="Fili Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','Damage taken-5%',}},
		}
		
	sets.midcast["Honor March"] = set_combine(sets.midcast.SongEffect,{range="Marsyas"})
	sets.midcast["Aria of Passion"] = set_combine(sets.midcast.SongEffect,{range="Loughnashade"})
	
	-- For song defbuffs (duration primary, accuracy secondary)
    -- TOGGLE CTRL+F11
    sets.midcast.SongDebuff = {range="Gjallarhorn",
        head="Brioso Roundlet +3",
		body="Fili Hongreline +3",
		hands="Fili Manchettes +3",
        legs="Fili Rhingrave +3",
		feet="Brioso Slippers +3",
		neck="Mnbw. Whistle +1",
		waist="Acuity Belt +1",
		left_ear="Regal Earring",
		right_ear={name="Fili Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','Damage taken-5%',}},		
		ring1="Metamor. Ring +1",
		ring2="Stikini Ring +1",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},		
		}
		
    -- For song defbuffs (accuracy primary, duration secondary)
    sets.midcast.ResistantSongDebuff = {range="Gjallarhorn",
        neck="Mnbw. Whistle +1",
        body="Fili Hongreline +3",
		hands="Fili Manchettes +3",
        legs="Fili Rhingrave +3",
		feet="Brioso Slippers +3",
		waist="Acuity Belt +1",
		left_ear="Regal Earring",
		right_ear={name="Fili Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','Damage taken-5%',}},
		ring1="Metamor. Ring +1",
		ring2="Stikini Ring +1",		
		}
		
    sets.midcast.Threnody = set_combine(sets.midcast.SongDebuff,{
		body="Mou. Manteel +1",
        })
		

    -- Song-specific recast reduction
    --[[sets.midcast.SongRecast = {ear2="Loquacious Earring",
        ring1="Kishar Ring",
        back="Harmony Cape",waist="Corvax Sash",legs="Aoidos' Rhing. +2"}--]]
    sets.midcast.SongRecast = {
        ring2="Kishar Ring",
        }

    --sets.midcast.Daurdabla = set_combine(sets.midcast.FastRecast, sets.midcast.SongRecast, {range=info.ExtraSongInstrument})

    -- Cast spell with normal gear, except using Daurdabla instead
    sets.midcast.Daurdabla = {range=info.ExtraSongInstrument}

    -- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
    sets.midcast.DaurdablaDummy = {range=info.ExtraSongInstrument, neck="Loricate Torque +1",
	}

		
    -- Other general spells and classes.

    sets.midcast.Cure = {
		head={ name="Kaykaus Mitra +1", augments={'MP+80','Spell interruption rate down +12%','"Cure" spellcasting time -7%',}},
		feet={ name="Kaykaus Boots +1", augments={'Mag. Acc.+20','"Cure" potency +6%','"Fast Cast"+4',}},
	}
	
    
	sets.midcast.Curaga = sets.midcast.Cure
			
    sets.midcast.Stoneskin = {
		neck="Nodens Gorget",
		waist="Siegel Sash",
	}
		
	sets.midcast.Cursna = {}
    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    --[[sets.resting = {main=gear.Staff.HMP, 
        body="Gendewitha Bliaut",
        legs="Nares Trews",feet="Chelona Boots +1"}--]]
    sets.resting = {}
    
    -- Idle sets 
    
	sets.idle = {
		head="Fili Calot +3",
		body="Nyame mail",
		hands="Nyame Gauntlets",
		legs="Fili Rhingrave +3",
		feet="Fili Cothurnes +3",
		neck="Loricate Torque +1",
		waist="Carrier's sash",
		left_ear="Eabani Earring",
		right_ear={name="Fili Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','Damage taken-5%',}},
		ring1="Defending Ring",
		ring2="Moonlight ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
	}
	
	sets.idle.Refresh = set_combine(sets.idle, {
        head=gear.Herc_Idle_head,
        hands="Volte Gloves",
        feet="Volte Gaiters",
        ring2="Stikini Ring +1",
        })
    
	sets.idle.PDT = set_combine(sets.idle)

    sets.idle.Town = set_combine(sets.idle)
    
    sets.idle.Weak = set_combine(sets.idle)
    
    -- Defense sets

    --[[sets.defense.PDT = {main=gear.Staff.PDT,sub="Mephitis Grip",
        head="Gendewitha Caubeen",neck="Twilight Torque",
        body="Gendewitha Bliaut",hands="Gendewitha Gages",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Umbra Cape",waist="Flume Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}

    sets.defense.MDT = {main=gear.Staff.PDT,sub="Mephitis Grip",
        head="Nahtirah Hat",neck="Twilight Torque",
        body="Gendewitha Bliaut",hands="Gendewitha Gages",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Bihu Cannions",feet="Gendewitha Galoshes"}

    sets.Kiting = {feet="Aoidos' Cothurnes +2"}

    sets.latent_refresh = {waist="Fucho-no-obi"}--]]

    sets.defense.PDT = set_combine(sets.idle)

    sets.defense.MDT = set_combine(sets.idle)

    sets.Kiting = set_combine(sets.idle)

    sets.latent_refresh = set_combine(sets.idle)

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    --[[sets.engaged = {range="Angel Lyre",
        head="Nahtirah Hat",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Bihu Justaucorps",hands="Buremte Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Atheling Mantle",waist="Goading Belt",legs="Brioso Cannions +1",feet="Gendewitha Galoshes"}

    -- Sets with weapons defined.
    sets.engaged.Dagger = {range="Angel Lyre",
        head="Nahtirah Hat",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Bihu Justaucorps",hands="Buremte Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Atheling Mantle",waist="Goading Belt",legs="Brioso Cannions +1",feet="Gendewitha Galoshes"}

	--]]
		
    sets.engaged = set_combine(sets.idle, {
		--main="Carnwenhan",
		range={ name="Linos", augments={'Accuracy+15 Attack+15','"Dbl.Atk."+3','Quadruple Attack +3',}},
	    head="Bunzi's hat",
		body="Ashera Harness",
		hands="Bunzi's Gloves",
        legs="Nyame Flanchard",
        feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Crep. Earring",
		right_ear="Telos Earring",
		left_ring="Chirich Ring +1",
		right_ring="Moonlight ring",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	})

    -- Sets with weapons defined.
    --sets.engaged.Dagger =  sets.engaged

    -- Set if dual-wielding
    sets.engaged.DW = set_combine(sets.idle, {
		range={ name="Linos", augments={'Accuracy+15 Attack+15','"Dbl.Atk."+3','Quadruple Attack +3',}},
	    head="Bunzi's hat",
		body="Ashera Harness",
		hands="Bunzi's Gloves",
        legs="Nyame Flanchard",
        feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist="Reiki yotai",
		left_ear="Crep. Earring",
		right_ear="Telos Earring",
		left_ring="Chirich Ring +1",
		right_ring="Moonlight ring",
		back="Null Shawl",
		--back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	})
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        -- Auto-Pianissimo
        if ((spell.target.type == 'PLAYER' and not spell.target.charmed) or (spell.target.type == 'NPC' and spell.target.in_party)) and
            not state.Buff['Pianissimo'] then
            
            local spell_recasts = windower.ffxi.get_spell_recasts()
            if spell_recasts[spell.recast_id] < 2 then
                send_command('@input /ja "Pianissimo" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
                eventArgs.cancel = true
                return
            end
        end
    --[[elseif spell.name=='Nightingale' then
        equip(sets.precast.JA.Nightingale)
    elseif spell.name=='Troubadour' then
        equip(sets.precast.JA.Troubadour)--]]
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
        if spell.type == 'BardSong' then
            -- layer general gear on first, then let default handler add song-specific gear.
            local generalClass = get_song_class(spell)
            if generalClass and sets.midcast[generalClass] then
                equip(sets.midcast[generalClass])
            end
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        if state.ExtraSongsMode.value == 'FullLength' then
            equip(sets.midcast.Daurdabla)
        end

        state.ExtraSongsMode:reset()
    end
end

-- Set eventArgs.handled to true if we don't want automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' and not spell.interrupted then
        if spell.target and spell.target.type == 'SELF' then
            adjust_timers(spell, spellMap)
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','ammo')
        else
            enable('main','sub','ammo')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    pick_tp_weapon()
end


-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Determine the custom class to use for the given song.
function get_song_class(spell)
    -- Can't use spell.targets:contains() because this is being pulled from resources
    if set.contains(spell.targets, 'Enemy') then
        if state.CastingMode.value == 'Resistant' then
            return 'ResistantSongDebuff'
        else
            return 'SongDebuff'
        end
    elseif state.ExtraSongsMode.value == 'Dummy' or spell.english == "Army's Paeon" or spell.english == "Army's Paeon II" then
        return 'DaurdablaDummy'
    else
        return 'SongEffect'
    end
end


-- Function to create custom buff-remaining timers with the Timers plugin,
-- keeping only the actual valid songs rather than spamming the default
-- buff remaining timers.
function adjust_timers(spell, spellMap)
    if state.UseCustomTimers.value == false then
        return
    end
    
    local current_time = os.time()
    
    -- custom_timers contains a table of song names, with the os time when they
    -- will expire.
    
    -- Eliminate songs that have already expired from our local list.
    local temp_timer_list = {}
    for song_name,expires in pairs(custom_timers) do
        if expires < current_time then
            temp_timer_list[song_name] = true
        end
    end
    for song_name,expires in pairs(temp_timer_list) do
        custom_timers[song_name] = nil
    end
    
    local dur = calculate_duration(spell.name, spellMap)
    if custom_timers[spell.name] then
        -- Songs always overwrite themselves now, unless the new song has
        -- less duration than the old one (ie: old one was NT version, new
        -- one has less duration than what's remaining).
        
        -- If new song will outlast the one in our list, replace it.
        if custom_timers[spell.name] < (current_time + dur) then
            send_command('timers delete "'..spell.name..'"')
            custom_timers[spell.name] = current_time + dur
            send_command('timers create "'..spell.name..'" '..dur..' down')
        end
    else
        -- Figure out how many songs we can maintain.
        local maxsongs = 2
        if player.equipment.range == info.ExtraSongInstrument then
            maxsongs = maxsongs + info.ExtraSongs
        end
        if buffactive['Clarion Call'] then
            maxsongs = maxsongs + 1
        end
        -- If we have more songs active than is currently apparent, we can still overwrite
        -- them while they're active, even if not using appropriate gear bonuses (ie: Daur).
        if maxsongs < table.length(custom_timers) then
            maxsongs = table.length(custom_timers)
        end
        
        -- Create or update new song timers.
        if table.length(custom_timers) < maxsongs then
            custom_timers[spell.name] = current_time + dur
            send_command('timers create "'..spell.name..'" '..dur..' down')
        else
            local rep,repsong
            for song_name,expires in pairs(custom_timers) do
                if current_time + dur > expires then
                    if not rep or rep > expires then
                        rep = expires
                        repsong = song_name
                    end
                end
            end
            if repsong then
                custom_timers[repsong] = nil
                send_command('timers delete "'..repsong..'"')
                custom_timers[spell.name] = current_time + dur
                send_command('timers create "'..spell.name..'" '..dur..' down')
            end
        end
    end
end

-- Function to calculate the duration of a song based on the equipment used to cast it.
-- Called from adjust_timers(), which is only called on aftercast().
function calculate_duration(spellName, spellMap)
    local mult = 1
    if player.equipment.range == 'Daurdabla' then mult = mult + 0.3 end -- change to 0.25 with 90 Daur
    if player.equipment.range == "Gjallarhorn" then mult = mult + 0.4 end -- change to 0.3 with 95 Gjall
    
    if player.equipment.main == "Carnwenhan" then mult = mult + 0.5 end -- 0.1 for 75, 0.4 for 95, 0.5 for 99/119
    if player.equipment.main == "Legato Dagger" then mult = mult + 0.05 end
	if player.equipment.sub == "Kali" then mult = mult + 0.05 end
    if player.equipment.neck == "Aoidos' Matinee" then mult = mult + 0.1 end
    if player.equipment.body == "Aoidos' Hngrln. +2" then mult = mult + 0.1 end
    if player.equipment.legs == "Mdk. Shalwar +1" then mult = mult + 0.1 end
    if player.equipment.feet == "Brioso Slippers" then mult = mult + 0.1 end
    if player.equipment.feet == "Brioso Slippers +3" then mult = mult + 0.15 end
    
    if spellMap == 'Paeon' and player.equipment.head == "Brioso Roundlet" then mult = mult + 0.1 end
    if spellMap == 'Paeon' and player.equipment.head == "Brioso Roundlet +1" then mult = mult + 0.1 end
    if spellMap == 'Madrigal' and player.equipment.head == "Fili Calot +3" then mult = mult + 0.1 end
    if spellMap == 'Minuet' and player.equipment.body == "Fili Hongreline +3" then mult = mult + 0.1 end
    if spellMap == 'March' and player.equipment.hands == 'Fili Manchettes +3' then mult = mult + 0.1 end
    if spellMap == 'Ballad' and player.equipment.legs == "Fili Rhingrave +3" then mult = mult + 0.1 end
    if spellName == "Sentinel's Scherzo" and player.equipment.feet == "Fili Cothurnes +3" then mult = mult + 0.1 end
    
    if buffactive.Troubadour then
        mult = mult*2
    end
    if spellName == "Sentinel's Scherzo" then
        if buffactive['Soul Voice'] then
            mult = mult*2
        elseif buffactive['Marcato'] then
            mult = mult*1.5
        end
    end
    
    local totalDuration = math.floor(mult*120)

    return totalDuration
end


-- Examine equipment to determine what our current TP weapon is.
function pick_tp_weapon()
    if brd_daggers:contains(player.equipment.main) then
        state.CombatWeapon:set('Dagger')
        
        if S{'NIN','DNC'}:contains(player.sub_job) and brd_daggers:contains(player.equipment.sub) then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    else
        state.CombatWeapon:reset()
        state.CombatForm:reset()
    end
end

-- Function to reset timers.
function reset_timers()
    for i,v in pairs(custom_timers) do
        send_command('timers delete "'..i..'"')
    end
    custom_timers = {}
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 3)
end

function set_lockstyle()
	lockstyleset = 3
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end

windower.raw_register_event('zone change',reset_timers)
windower.raw_register_event('logout',reset_timers)
