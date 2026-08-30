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
	
	--brd_daggers = S{'Kali', 'Twashtar', 'Carnwenhan', "Gleti's Knife", 'Centovente', 'Aeneas', 'Tauret', 'Naegling'}
	pick_tp_weapon()
	
	state.CombatWeapon = M{['description']='Weapon Selection', 'MpuGleti', 'NaeGleti'
                                                              --  'MpuShield','NaeShield'
                                                              }
	
    -- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Daurdabla'
    -- How many extra songs we can keep from Daurdabla/Terpander
    info.ExtraSongs = 2
    
    -- Set this to false if you don't want to use custom timers.
    state.UseCustomTimers = M(false, 'Use Custom Timers')
	    
    -- Additional local binds
    --	send_command('bind ^` gs c cycle ExtraSongsMode')
    --	send_command('bind !` input /ma "Chocobo Mazurka" <me>')
	
	brd_daggers = ""

    select_default_macro_book()
	fashion_particulars()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
--    send_command('unbind ^`')
--    send_command('unbind !`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

	enh_telchine_legs = { name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}}
	
	--Ambu capes
	song_cape = {name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Enmity-10','Damage taken-5%',}}
	cha_wsd_cape = { name="Intarabus's Cape", augments={'CHR+20','Accuracy+20 Attack+20','CHR+10','Weapon skill damage +10%','Damage taken-5%',}}
    str_wsd_cape = {name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}
	dex_da_cape = { name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}
	-- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {main="Kali", -- FC 7
		head="Bunzi's hat", -- FC 10
		neck="Loricate torque +1",
		ear1="Etiolation earring", -- FC 1
		ear2="Fili earring +2",
		body="Inyanga jubbah +2", -- FC 14
		hands="Gendewitha gages +1", -- SC 7+5
		ring1="Murky ring",
		ring2="Kishar ring", -- FC 4
		back="Fi follet cape +1", -- FC 10
		waist="Embla sash", -- FC 5
		legs="Ayanmo cosciales +2", -- FC 6
		feet="Fili cothurnes +3" -- FC 13
	}

    sets.precast.FC.Cure = sets.precast.FC
	
	-- Enh. duration in precast for spells that cast too quickly to swap midcast gear
	sets.EnhancingDuration = {sub="Ammurapi shield", waist="Embla sash", legs=enh_telchine_legs}
	sets.precast.FC.Haste = set_combine(sets.precast.FC, sets.EnhancingDuration)

    -- sets.precast.FC.Stoneskin = set_combine(sets.precast.FC, {head="Umuthi Hat"})

    -- sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.BardSong = {main="Carnwenhan", 
		sub="Kali",
		head="Fili calot +3", -- SC 16
		neck="Loricate torque +1", 
		ear1="Etiolation earring", -- FC 1
		ear2="Fili earring +2",
		body="Inyanga jubbah +2", -- FC 14
		hands="Gendewitha gages +1", -- SC 7+5
		ring1="Murky ring",
		ring2="Kishar ring", -- FC 4
		back="Fi follet cape +1", -- FC 10
		waist="Embla sash", -- FC 5
		legs="Ayanmo cosciales +2", -- FC 6
		feet="Fili cothurnes +3", -- FC 13
	}
	
    sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})
	sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.BardSong, {range="Marsyas"})
	sets.precast.FC['Aria of Passion'] = set_combine(sets.precast.FC.BardSong, {range="Loughnashade"})
	
    -- Precast sets to enhance JAs
    sets.precast.JA.Nightingale = {feet="Bihu slippers +2"}
    sets.precast.JA.Troubadour = {body="Bihu justaucorps +4"}
    sets.precast.JA['Soul Voice'] = {legs="Bihu cannions +2"}
	
	sets.precast.Step = {
		range={ name="Linos", augments={'Attack+16','"Dbl.Atk."+2','Quadruple Attack +3',}},
		head="Fili calot +3", 
		neck="Bard's charm +2",ear1="Telos earring",ear2="Crepuscular earring",
        body="Fili hongreline +3",hands="Fili manchettes +3",ring1="Chirich ring +1",ring2="Ilabrat Ring",
        back=dex_da_cape,waist="Sailfi belt +1",legs="Fili rhingrave +3",feet="Fili cothurnes +3"}

    -- Waltz set (chr and vit)
    -- sets.precast.Waltz = {range="Gjallarhorn",
        -- head="Nahtirah Hat",
        -- body="Gendewitha Bliaut",hands="Buremte Gloves",
        -- back="Kumbira Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
    
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		range={ name="Linos", augments={'Attack+16','"Dbl.Atk."+2','Quadruple Attack +3',}},
        head="Nyame helm",
		neck="Bard's charm +2", --TA 1%, Acc +8, SB +3
		ear1="Ishvara earring", --WSD 2%
		ear2="Moonshade earring", --TP bonus +250, Att +4
        body="Bihu justaucorps +4", 
		hands="Nyame gauntlets",
		ring1="Ephramad's ring", --STR +10, DEX +10, AGI +10, Acc/Att/Racc/Ratt +20, PDL +10
		ring2="Ilabrat ring", --DEX +10, Store TP +5, Att +25
        back=str_wsd_cape,
		waist="Sailfi belt +1",
		legs="Nyame flanchard", --Aug WSD+4/Att+12
		feet="Nyame sollerets" --Aug WSD+6/Att+20
	}
	
	-- Mordant Rime (CHR)
    sets.precast.WS["Mordant Rime"] = {
		range={ name="Linos", augments={'Attack+15','Weapon skill damage +2%','STR+6 CHR+6',}},
        head="Nyame helm", --STR +26, MND +26, Acc +40, Att +30, SC bonus +5
		neck="Bard's charm +2", --TA 1%, Acc +8, SB +3
		ear1="Regal earring", --CHA +10
		ear2="Fili earring +2", --CHA +7
        body="Bihu justaucorps +4", 
		hands="Nyame gauntlets", --STR +17, MND +40, Acc +40, Att +30, SC bonus +5
		ring1="Ephramad's ring", --STR +10, DEX +10, AGI +10, Acc/Att/Racc/Ratt +20, PDL +10
		ring2="Metamorph ring +1",
        back=cha_wsd_cape, 
		waist="Kentarch belt +1", 
		legs="Nyame flanchard", --Aug WSD+4/Att+12
		feet="Nyame sollerets" --Aug WSD+6/Att+20
	}
	 
    -- Rudra's Storm = 80% DEX, SC: Gravitation / Transfixion
    sets.precast.WS["Rudra's Storm"] = {
		range={ name="Linos", augments={'Attack+16','"Dbl.Atk."+2','Quadruple Attack +3',}},
        head="Nyame helm", 
		neck="Bard's charm +2", --TA 1%, Acc +8, SB +3
		ear1="Dominance earring +1", 
		ear2="Moonshade earring", --TP bonus +250, Att +4
        body="Bihu justaucorps +4", 
		hands="Nyame gauntlets",
		ring1="Ephramad's ring", --STR +10, DEX +10, AGI +10, Acc/Att/Racc/Ratt +20, PDL +10
		ring2="Ilabrat ring", --DEX +10, Store TP +5, Att +25
        back=dex_da_cape, 
		waist="Sailfi belt +1", 
		legs="Nyame flanchard", --Aug WSD+4/Att+12
		feet="Nyame sollerets" --Aug WSD+6/Att+20
	}

	-- Ruthless Stroke
    sets.precast.WS["Ruthless Stroke"] = {
		range={ name="Linos", augments={'Attack+16','"Dbl.Atk."+2','Quadruple Attack +3',}},
        head="Nyame helm",
		neck="Bard's charm +2", --TA 1%, Acc +8, SB +3
		ear1="Ishvara earring",
		ear2="Moonshade earring", --TP bonus +250, Att +4
        body="Bihu justaucorps +4",
		hands="Nyame gauntlets",
		ring1="Ephramad's ring", --STR +10, DEX +10, AGI +10, Acc/Att/Racc/Ratt +20, PDL +10
		ring2="Ilabrat ring", --DEX +10, Store TP +5, Att +25
        back=str_wsd_cape,
		waist="Sailfi belt +1",
		legs="Nyame flanchard", --Aug WSD+4/Att+12
		feet="Nyame sollerets" --Aug WSD+6/Att+20
	}
	
	-- Savage Blade = 50% STR/50% MND, SC: Fragmentation / Scission
    sets.precast.WS["Savage Blade"] = {
		range={ name="Linos", augments={'Attack+15','Weapon skill damage +2%','STR+6 CHR+6',}},
        head="Nyame helm", --STR +26, MND +26, Acc +40, Att +30, SC bonus +5
		neck="Republican platinum medal",
		ear1="Ishvara earring", --WSD 2%
		ear2="Moonshade earring", --TP bonus +250, Att +4
        body="Bihu justaucorps +4", 
		hands="Nyame gauntlets", --STR +17, MND +40, Acc +40, Att +30, SC bonus +5
		ring1="Ephramad's ring", --STR +10, DEX +10, AGI +10, Acc/Att/Racc/Ratt +20, PDL +10
		ring2="Ilabrat ring", --DEX +10, Store TP +5, Att +25
        back=str_wsd_cape, 
		waist="Sailfi belt +1", 
		legs="Nyame flanchard", --Aug WSD+4/Att+12
		feet="Nyame sollerets" --Aug WSD+6/Att+20
	}
    

	
    -- Midcast Sets

    -- General set for recast times.
    -- sets.midcast.FastRecast = {range="Angel Lyre",
        -- head="Nahtirah Hat",ear2="Loquacious Earring",
        -- body="Vanir Cotehardie",hands="Gendewitha Gages",ring1="Prolix Ring",
        -- back="Swith Cape +1",waist="Goading Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
        
    -- Gear to enhance certain classes of songs.  No instruments added here since Gjallarhorn is being used.
    sets.midcast.Lullaby = {
		main="Carnwenhan",
		sub="Kali", 
		range="Marsyas", --Song effect duration +50%
		head="Brioso roundlet +4", --String skill +14
		neck="Moonbow whistle +1", --CHR +23, MAcc +23 
		ear1="Regal earring", --CHR +10 (set bonus: +30 Acc/RAcc/MAcc)
		ear2="Fili earring +2", --Sing +12, Enm -9, MND+7, CHR+7, MAcc +16, Acc +16, DT -6%
		body="Fili hongreline +3", --CHR +48, Singing skill +24, Wind skill +24, Song dur +14%
		hands="Fili manchettes +3", 
		--hands="Brioso cuffs" --Lullaby+
		ring1="Stikini ring", --Magic skills +5, MAcc +8
		ring2="Metamorph ring +1",
		back=song_cape, --CHR+20, MAcc +30
		waist="Null belt", --MAcc
		legs="Inyanga shalwar +2", --CHR +32, MAcc +45, Song dur +17%
		feet="Brioso slippers +4" --CHR +50, MAcc +56, Wind skill +15, Song dur +15% (set bonus: +30 Acc/RAcc/MAcc)
	}
	
	--String skill 648=8 yalms radius
	sets.midcast['Horde Lullaby II'] = {
		main="Carnwenhan",
		sub="Kali", 
		range="Daurdabla", --String+20
		head="Brioso roundlet +4", --String skill +14
		--neck="Moonbow whistle +1", --CHR +23, MAcc +23 
		neck="Incanter's torque", --Magic skill+10
		ear1="Regal earring", --CHR +10 (set bonus: +30 Acc/RAcc/MAcc)
		ear2="Gersemi earring", --String+10
		--need brioso justaucorps here
		body="Fili hongreline +3", --CHR +48, Singing skill +24, Wind skill +24, Song dur +14%
		hands="Inyanga dastanas +2", --Magic skills+20
		--hands="Brioso cuffs" --Lullaby+
		ring1="Stikini ring", --Magic skills +5, MAcc +8
		ring2="Metamorph ring +1",
		back=song_cape, --CHR+20, MAcc +30
		waist="Null belt",
		legs="Inyanga shalwar +2", --CHR +32, MAcc +45, Song dur +17%
		feet="Bihu slippers +2" --String skill +13
	}
	
	--Enmity set, remember to reset merits and eat food
	sets.midcast.Enmity = {
		main="Carnwenhan",
		sub="Genmei shield", 
		range="Daurdabla", 
		head="Brioso roundlet +4", 
		neck="Unmoving collar +1", --Enmity+10
		ear1="Regal earring", 
		ear2="Cryptic earring", --Enmity+4
		body="Emet harness +1", --Enmity+10
		hands="Fili manchettes +3",
		--ring1="Moonlight ring", 
		ring1="Murky ring",
		ring2="Metamorph ring +1",
		back=dex_da_cape, 
		waist="Null belt",
		legs="Zoar subligar +1", --Enmity+6
		feet="Nyame sollerets"
	}
	
	--Enmity song sets
	--sets.midcast.Lullaby = sets.midcast.Enmity
	--sets.midcast['Horde Lullaby II'] = sets.midcast.Enmity
		
	--sets.midcast.Ballad = {legs="Fili rhingrave +3"}
	sets.midcast.Carol = {hands="Mousai gages +1"}
	sets.midcast.Etude = {head="Mousai turban +1"}
	sets.midcast.Mambo = {feet="Mousai crackows +1"}
	--Madrigal: swap brioso slippers for fili cothurnes for dex bonus instead of extra duration
    sets.midcast.Madrigal = {head="Fili calot +3",back=song_cape,feet="Fili cothurnes +3"}
    sets.midcast.March = {hands="Fili manchettes +3"}
    sets.midcast.Minuet = {body="Fili hongreline +3"}
    sets.midcast.Minne = {legs="Mousai seraweels +1"}
    sets.midcast.Paeon = {head="Brioso roundlet +4"}
	--Prelude: swap brioso slippers for fili cothurnes for stat bonus instead of extra duration
	sets.midcast.Prelude = {back=song_cape,feet="Fili cothurnes +3"}
    sets.midcast["Sentinel's Scherzo"] = {feet="Fili cothurnes +3"}
    -- sets.midcast['Magic Finale'] = {neck="Wind Torque",waist="Corvax Sash",legs="Aoidos' Rhing. +2"}
	sets.midcast.Threnody = {body="Mousai manteel +1"}
    sets.midcast.Mazurka = {range=info.ExtraSongInstrument}
	sets.midcast['Honor March'] = set_combine(sets.midcast.March, {range="Marsyas"})
	sets.midcast['Aria of Passion'] = {range="Loughnashade"}

    -- For song buffs (duration and AF3 set bonus)
	sets.midcast.SongEffect = {
		main="Carnwenhan", 
		range="Gjallarhorn", --Singing skill +25, Wind skill +25 
		head="Fili calot +3", --CHR +42
		neck="Moonbow whistle +1", --CHR +23, MAcc +23 
		ear1="Regal earring", --CHR +10 (set bonus: +30 Acc/RAcc/MAcc)
		ear2="Fili earring +2", --Sing +12, Enm -9, MND+7, CHR+7, MAcc +16, Acc +16, DT -6%
		body="Fili hongreline +3", --CHR +48, Singing skill +24, Wind skill +24, Song dur +14%
		hands="Fili manchettes +3", 
		back=song_cape, --CHR+20, MAcc +30
		--waist
		legs="Inyanga shalwar +2", --CHR +32, MAcc +45, Song dur +17%
		feet="Brioso slippers +4" --CHR +50, MAcc +56, Wind skill +15, Song dur +15% (set bonus: +30 Acc/RAcc/MAcc)
	}

    -- For song defbuffs (duration primary, accuracy secondary)
	-- CHR/MAcc/Wind skill/Singing skill, Song duration
	sets.midcast.SongDebuff = {
		main="Carnwenhan", 
		sub="Kali", 
		range="Gjallarhorn", --CHR +10, Singing skill +25, Wind skill +25 
		head="Brioso roundlet +4", --CHR +43, MAcc +71 (set bonus: +30 Acc/RAcc/MAcc)
		neck="Moonbow whistle +1", --CHR +23, MAcc +23 
		ear1="Regal earring", --CHR +10 (set bonus: +30 Acc/RAcc/MAcc)
		ear2="Fili earring +2", --Sing +12, Enm -9, MND+7, CHR+7, MAcc +16, Acc +16, DT -6%
		body="Fili hongreline +3", --CHR +48, Singing skill +24, Wind skill +24, Song dur +14%
		hands="Fili manchettes +3", 
		ring1="Stikini ring", --Magic skills +5, MAcc +8
		ring2="Metamorph ring +1",
		back=song_cape, --CHR+20, MAcc +30
		waist="Null belt", --MAcc +30
		legs="Inyanga shalwar +2", --CHR +32, MAcc +45, Song dur +17%
		feet="Brioso slippers +4" --CHR +50, MAcc +56, Wind skill +15, Song dur +15% (set bonus: +30 Acc/RAcc/MAcc)
	}

    -- Song-specific recast reduction
    -- sets.midcast.SongRecast = {ear2="Loquacious Earring",
        -- ring1="Prolix Ring",
        -- back="Harmony Cape",waist="Corvax Sash",legs="Aoidos' Rhing. +2"}

    --sets.midcast.Daurdabla = set_combine(sets.midcast.FastRecast, sets.midcast.SongRecast, {range=info.ExtraSongInstrument})

    -- Cast spell with normal gear, except using Daurdabla instead
    sets.midcast.Daurdabla = {range=info.ExtraSongInstrument}

    -- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
    sets.midcast.DaurdablaDummy = {main="",range=info.ExtraSongInstrument,
		head="Vanya hood",neck="Loricate torque +1",ear1="Etiolation earring",ear2="Ethereal earring",
		body="Inyanga jubbah +2",hands="Gendewitha gages +1",ring1="Murky ring",ring2="Kishar ring",
		back="Fi follet cape +1",waist="Embla sash",legs="Ayanmo cosciales +2",feet="Ayanmo gambieras +2"}

    -- Other general spells and classes.
	sets.midcast['Enhancing Magic'] = {sub="Ammurapi shield",ammo="Pemphredo tathlum",
		head="Vanya hood",neck="Incanter's torque",ear1="Mimir earring",ear2="Ethereal earring",
		body="Inyanga jubbah +2",hands="Inyanga dastanas +2",ring1="Stikini ring",ring2="Stikini ring",
		back="Fi follet cape +1",waist="Embla sash",legs=enh_telchine_legs,feet="Ayanmo gambieras +2"}
		
	sets.midcast['Enfeebling Magic'] = sets.midcast.SongDebuff
	
	sets.midcast['Dark Magic'] = sets.midcast.SongDebuff

	sets.midcast['Absorb-TP'] = {
		main="Carnwenhan",
		sub="Ammurapi shield",
		range="Gjallarhorn", --CHR +10, Singing skill +25, Wind skill +25
		head="Brioso roundlet +4", --CHR +43, MAcc +71 (set bonus: +30 Acc/RAcc/MAcc)
		neck="Null loop",
		ear1="Regal earring", --CHR +10 (set bonus: +30 Acc/RAcc/MAcc)
		ear2="Fili earring +2", --Sing +12, Enm -9, MND+7, CHR+7, MAcc +16, Acc +16, DT -6%
		body="Fili hongreline +3", --CHR +48, Singing skill +24, Wind skill +24, Song dur +14%
		hands="Fili manchettes +3",
		ring1="Stikini ring", --Magic skills +5, MAcc +8
		ring2="Metamorph ring +1",
		back=song_cape, --CHR+20, MAcc +30
		waist="Null belt", --MAcc +30
		legs="Inyanga shalwar +2", --CHR +32, MAcc +45, Song dur +17%
		feet="Brioso slippers +4" --CHR +50, MAcc +56, Wind skill +15, Song dur +15% (set bonus: +30 Acc/RAcc/MAcc)
	}
	
    sets.midcast.Cure = {main="Daybreak",sub="Ammurapi shield",ammo="Pemphredo tathlum",
        head="Vanya hood",neck="Incanter's torque",ear1="Etiolation earring",ear2="Mendicant's earring",
        body="Inyanga jubbah +2",hands="Inyanga dastanas +2",ring1="Lebeche ring",ring2="Mephitas's ring +1",
        back="Fi follet cape +1",waist="Rumination sash",legs="Gyve trousers",feet="Vanya clogs"}
        
    sets.midcast.Curaga = sets.midcast.Cure
	
	sets.midcast.Cursna = {ammo="Pemphredo tathlum",
        head="Vanya hood",neck="Debilis medallion",ear1="Etiolation earring",ear2="Mendicant's earring",
        body="Inyanga jubbah +2",hands="Inyanga dastanas +2",ring1="Menelaus's ring",ring2="Stikini ring",
        back="Fi follet cape +1",waist="Embla sash",legs="Ayanmo cosciales +2",feet="Volte gaiters"}
        
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'],
        {neck="Nodens gorget"})
		   
	-- PDT 53/50, MDT 50/50, Regen +9, Refresh +1
    sets.idle = { 
        head="Fili calot +3", --DT -11%, MEva +130
		neck="Warder's charm +1",
		ear1="Infused earring", --Regen +1, Eva +10, AGI +4
		ear2="Eabani earring", --HP+45, Eva+15, MEva+8
		body="Adamantite armor", 
		hands="Nyame gauntlets", 
		ring1="Murky ring",
		ring2="Shneddick ring", --run fast
		back=song_cape, --DT -5
        --back="Archon cape", -- 12% chance to negate dmg if >=85% of HP
		waist="Carrier's sash", 
		legs="Fili rhingrave +3", --DT -12, MEva +147
		feet="Nyame sollerets" 
	}
	       
    -- Defense sets
    -- sets.defense.PDT = {main=gear.Staff.PDT,sub="Mephitis Grip",
        -- head="Gendewitha Caubeen",neck="Twilight Torque",
        -- body="Gendewitha Bliaut",hands="Gendewitha Gages",ring1="Murky Ring",ring2=gear.DarkRing.physical,
        -- back="Umbra Cape",waist="Flume Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}

    -- sets.defense.MDT = {main=gear.Staff.PDT,sub="Mephitis Grip",
        -- head="Nahtirah Hat",neck="Twilight Torque",
        -- body="Gendewitha Bliaut",hands="Gendewitha Gages",ring1="Murky Ring",ring2="Shadow Ring",
        -- back="Engulfer Cape",waist="Flume Belt",legs="Bihu Cannions",feet="Gendewitha Galoshes"}

    sets.Kiting = {ring2="Shneddick ring"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	--------------------------------------
	-- Weapons
	--------------------------------------
	sets.weapons = {}
	sets.weapons.NaeGleti = {main="Naegling",sub="Gleti's knife"}
	sets.weapons.NaeCent = {main="Naegling",sub="Centovente"}
	sets.weapons.MpuGleti = {main="Mpu Gandring",sub="Gleti's knife"}
	sets.weapons.MpuCent = {main="Mpu Gandring",sub="Centovente"}
	sets.weapons.NaeShield = {main="Naegling",sub="Genbu's shield"}
	sets.weapons.MpuShield = {main="Mpu Gandring",sub="Genbu's shield"}
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {
		range={ name="Linos", augments={'Attack+16','"Dbl.Atk."+2','Quadruple Attack +3',}},
        head="Bunzi's hat",
		neck="Bard's charm +2",ear1="Telos earring",ear2="Crepuscular earring",
        body="Ayanmo corazza +2",hands="Bunzi's gloves",ring1="Chirich ring +1",ring2="Ilabrat Ring",
        back=dex_da_cape,waist="Sailfi belt +1",legs="Fili rhingrave +3",feet="Nyame sollerets"}
	
	-- Set if dual-wielding
    sets.engaged.DW = {
		range={ name="Linos", augments={'Attack+16','"Dbl.Atk."+2','Quadruple Attack +3',}},
        head="Bunzi's hat",
		neck="Bard's charm +2",ear1="Telos earring",ear2="Crepuscular earring",
        body="Ayanmo corazza +2",hands="Bunzi's gloves",ring1="Chirich ring +1",ring2="Ilabrat Ring",
        back=dex_da_cape,waist="Reiki yotai",legs="Fili rhingrave +3",feet="Nyame sollerets"
	}
	
	sets.engaged.Acc = set_combine(sets.engaged, {ear2="Fili earring +2"})
	
	-- Fashion sets
	sets.fashion = {}
	sets.fashion.mousai = {
		head="Mousai turban +1",body="Mousai manteel +1",
		hands="Mousai gages +1",legs="Mousai seraweels +1",feet="Mousai crackows +1"}
		
	sets.fashion.empy = {
		head="Fili calot +3",body="Fili hongreline +3",
		hands="Fili manchettes +3",legs="Fili rhingrave +3",feet="Fili cothurnes +3"}
		
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 16)
end

function fashion_particulars()
	send_command('wait 1;input /lockstyleset 22;wait 1;gs equip sets.idle')
end
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        --Auto-Pianissimo
        if ((spell.target.type == 'PLAYER' and not spell.target.charmed) or (spell.target.type == 'NPC' and spell.target.in_party)) and
            not state.Buff['Pianissimo'] then
            
            local spell_recasts = windower.ffxi.get_spell_recasts()
            if spell_recasts[spell.recast_id] < 2 then
                send_command('@input /ja "Pianissimo" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
                eventArgs.cancel = true
                return
            end
        end
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

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

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
    elseif state.ExtraSongsMode.value == 'Dummy' then
        return 'DaurdablaDummy'
    else
        return 'SongEffect'
    end
end

-- Examine equipment to determine what our current TP weapon is.
function pick_tp_weapon()
    -- if brd_daggers:contains(player.equipment.main) then
        -- state.CombatWeapon:set('Dagger')
        
        -- if S{'NIN','DNC'}:contains(player.sub_job) and brd_daggers:contains(player.equipment.sub) then
            -- state.CombatForm:set('DW')
        -- else
            -- state.CombatForm:reset()
        -- end
    -- else
        -- state.CombatWeapon:reset()
        -- state.CombatForm:reset()
    -- end
	
	if S{'NIN','DNC'}:contains(player.sub_job) then
		state.CombatForm:set('DW')
	end
end

-- Function to reset timers.
function reset_timers()
    for i,v in pairs(custom_timers) do
        send_command('timers delete "'..i..'"')
    end
    custom_timers = {}
end

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
	-- gs c 5songs
	elseif cmdParams[1]:lower() == '5songs' then
		send_command('@input /ma "Knight\'s Minne V" <me>;wait 6;\
						input /ma "Knight\'s Minne IV" <me>;wait 6;\
						input /ja "Clarion Call" <me>;wait 1;\
						input /ma "Knight\'s Minne III" <me>;wait 6;\
						input //gs c set ExtraSongsMode Dummy;wait 1;\
						input /ma "Knight\'s Minne II" <me>;wait 6;\
						input //gs c set ExtraSongsMode Dummy;wait 1;\
						input /ma "Knight\'s Minne" <me>;')
		eventArgs.handled = true
    end
end

windower.raw_register_event('zone change',reset_timers)
windower.raw_register_event('logout',reset_timers)
