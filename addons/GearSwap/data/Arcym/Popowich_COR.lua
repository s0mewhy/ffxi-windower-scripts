--Relyk

-- Load and initialize the include file.
include('Mirdain-Include')

--Set to ingame lockstyle and Macro Book/Set
LockStylePallet = "51"
MacroBook = "17"  -- Sub Job macro pallets can be defined in the sub_job_change_custom function below
MacroSet = "1"

-- Use "gs c food" to use the specified food item 
Food = "Grape Daifuku +1"

--Uses Items Automatically
AutoItem = true

--Upon Job change will use a random lockstyleset
Random_Lockstyle = false

--Lockstyle sets to randomly equip
Lockstyle_List = {51}

-- Set to true to run organizer on job changes
Organizer = false

-- Add CRIT the base modes to allow AM3 Critical Builds
state.OffenseMode:options('TP','ACC','DT','PDL','CRIT')
state.OffenseMode:set('TP')

--Modes for specific to Corsair
state.WeaponMode:options('Fomalhaut','Death Penalty','Savage Blade','Evisceration','Armageddon','Hot Shot','EarpSword','Aeolian Edge','EarpKnife')
state.WeaponMode:set('Death Penalty')

--Enable JobMode for UI.
UI_Name = 'TP Mode'

--Melee or Ranged Mode
state.JobMode:options('Standard','Melee','Ranged')
state.JobMode:set('Standard')

elemental_ws = S{'Aeolian Edge', 'Leaden Salute', 'Wildfire','Earth Shot','Ice Shot','Water Shot','Fire Shot','Wind Shot','Thunder Shot'}

-- load addons
--send_command('lua l autocor')

-- Initialize Player
jobsetup (LockStylePallet,MacroBook,MacroSet)

-- Threshold for Ammunition Warning
Ammo_Warning_Limit = 99

function get_sets()

	--Set the weapon options.  This is set below in job customization section

	-- Weapon setup
	sets.Weapons = {}

	sets.Weapons['Savage Blade'] = {
		main="Naegling",
		sub="Crepuscular Knife",
		range={ name="Ataktos", augments={'Delay:+60','TP Bonus +1000',}},
	}

	sets.Weapons['Evisceration'] = {
		main="Tauret",
		sub="Gleti's Knife",
		range="Earp",
	}

	sets.Weapons['Fomalhaut'] = {
		main={ name="Rostam", augments={'Path: B'}, bag="Wardrobe 3"},
		sub="Nusku Shield",
		range={ name="Fomalhaut", augments={'Path: A',}},
	}

	sets.Weapons['Death Penalty'] = {
		main={ name="Rostam", augments={'Path: B'}, bag="Wardrobe 3"},
		sub="Tauret",
		range={ name="Death Penalty", augments={'Path: A',}},
	}

	sets.Weapons['Armageddon'] = {
		--main="Naegling",
		main="Crepuscular Knife",
		--sub="Tauret",
		sub="Gleti's Knife",
		range={ name="Armageddon", augments={'Path: A',}},
	}
	
	sets.Weapons['Hot Shot'] = {
		main="Naegling",
		sub="Tauret",
		range={ name="Armageddon", augments={'Path: A',}},
	}
	
	sets.Weapons['Aeolian Edge'] = {
		ammo=Ammo.Bullet.MAG_WS,
		main={ name="Rostam", augments={'Path: B'}, bag="Wardrobe 3"},
		sub="Tauret",
		range={ name="Ataktos", augments={'Delay:+60','TP Bonus +1000',}},
	}

	sets.Weapons['EarpSword'] = {
		ammo=Ammo.Bullet.CRIT,
		main="Naegling",
		sub="Crepuscular Knife",
		range="Earp",
	}

	sets.Weapons['EarpKnife'] = {
		ammo=Ammo.Bullet.CRIT,
		main="Crepuscular Knife",
		sub="Gleti's Knife",
		range="Earp",
	}

	sets.Weapons.Melee = {
		sub="Gleti's Knife",
	}

	sets.Weapons.Ranged = {
		sub={ name="Kustawi +1", augments={'Path: A',}},
	}

	sets.Weapons.Shield = {
		sub={ name="Nusku Shield", priority=1},
	}

	sets.Weapons.Sleep = {
		range="",
	}

	-- Ammo Selection
	Ammo.Bullet.RA = "Chrono Bullet"		-- TP Ammo
	Ammo.Bullet.WS = "Chrono Bullet"		-- Physical Weaponskills
	Ammo.Bullet.CRIT = "Chrono Bullet"		-- Critical Hit Mode
	Ammo.Bullet.PDL = "Chrono Bullet"		-- Physical Damage Mode
	Ammo.Bullet.SB = "Chrono Bullet"		-- Subtle Blow Mode
	Ammo.Bullet.MAB = "Living Bullet"		-- Magical Weaponskills
	Ammo.Bullet.MACC = "Chrono Bullet"		-- Magic Accuracy
	Ammo.Bullet.QD = "Hauksbok Bullet"		-- Quick Draw
	Ammo.Bullet.MAG_WS = "Living Bullet"	-- Magic Weapon Skills

	-- Standard Idle set with -DT,Refresh,Regen with NO movement gear
	sets.Idle = {
		ammo = Ammo.Bullet.RA,
		head="Null Masque",
		body="Adamantite Armor",
		hands="Nyame Gauntlets",
		legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}},
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Carrier's Sash",
		left_ear="Odnowa Earring +1",
		right_ear="Alabaster Earring",
		left_ring="Chirich Ring +1",
		right_ring="Murky Ring",
		back="Null Shawl",
    }

	sets.Movement = {
		--legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}},
		--right_ring="Defending Ring",
	}

    sets.RollersRing = {left_ring="Roller's Ring"}

	-- Set to be used if you get 
	sets.Cursna_Received = {
	    neck="Nicander's Necklace",
	    left_ring={ name="Eshmun's Ring", bag="wardrobe1", priority=2},
		right_ring={ name="Eshmun's Ring", bag="wardrobe4", priority=1},
		waist="Gishdubar Sash",
	}

	sets.OffenseMode = {}

	--Base TP set to build off when melee'n
		sets.OffenseMode.TP = {
        ammo = Ammo.Bullet.RA,
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Adhemar Wrist. +1",
		neck="Iskur Gorget",
		legs="Chasseur's Culottes +3",
		feet="Malignance Boots",
		waist="Sailfi Belt +1",
		left_ear="Alabaster Earring",
		right_ear="Dedition Earring",
		left_ring="Chirich Ring +1",
		right_ring="Murky Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	
	--This set is used when OffenseMode is DT and Enaged
	sets.OffenseMode.DT = set_combine(sets.OffenseMode.TP, {
	    legs="Chas. Culottes +3",
		left_ring="Defending Ring",
		right_ear="Alabaster Earring",
	})

	--This set is used when OffenseMode is PDL and Enaged
	sets.OffenseMode.PDL = set_combine(sets.OffenseMode.TP, {
		legs="Malignance Tights",
		hands="Malignance Gloves",
		left_ring="Sroda Ring",
	})

	--This set is used when OffenseMode is CRIT and Enaged
	sets.OffenseMode.CRIT = set_combine(sets.OffenseMode.TP, {

	})

	--The following sets augment the base TP set above for Dual Wielding
	sets.DualWield = {
		waist="Reiki Yotai",
		--right_ear="Eabani Earring",
	}

	--This set is used when OffenseMode is ACC and Enaged (Augments the TP base set)
	sets.OffenseMode.ACC = {}

	sets.Precast = {}
	-- 70 snapshot is Cap.  Need 60 due to 10 from gifts
	-- Snapshot / Rapidshot
	-- Rapid shot is like quick magic
	-- Snapshot is like Fast Cast
	-- Flurry is 15% Snapshot
	-- Flurry II 30% Snapshot

	--No flurry - 60 Snapshot needed
	sets.Precast.RA = {
		ammo=Ammo.Bullet.RA,
		head="Chass. Tricorne +3", -- 0/18
		body="Oshosi Vest +1", -- 14/0
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}}, -- 8/11
		legs="Ikenga's Trousers", -- 8/0
		feet="Meg. Jam. +2", -- 10/0
		left_ear={ name="Tuisto Earring", priority=2},
		right_ear={ name="Etiolation Earring", priority=1},
		left_ring="Dingir Ring",
		right_ring="Regal Ring", -- 3/0
		neck={ name="Comm. Charm +2", augments={'Path: A',}}, -- 4/0
		waist="Yemaya Belt", -- 0/5
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Damage taken-5%',}}, -- 0/0
    } -- Totals 49/43

	-- Flurry - 45 Snapshot Needed
	sets.Precast.RA.Flurry = set_combine(sets.Precast.RA, { 
		head="Chass. Tricorne +3", -- 0/18
		body="Laksa. Frac +4", -- 0/20
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}}, -- 8/11
		legs="Ikenga's Trousers", -- 8/0
		feet={ name="Pursuer's Gaiters", augments={'Rng.Acc.+10','"Rapid Shot"+10','"Recycle"+15',}},-- 0/10
		left_ring="Crepuscular Ring", -- 3/0
		waist="Yemaya Belt", -- 0/5
    }) -- Totals 45/63

	-- Flurry II - 30 Snapshot Needed
	sets.Precast.RA.Flurry_II = set_combine( sets.Precast.RA.Flurry, { 
		head="Chass. Tricorne +3", -- 0/18
		body="Laksa. Frac +4", -- 0/20
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}}, -- 8/11
		legs="Ikenga's Trousers", -- 8/0
		feet={ name="Pursuer's Gaiters", augments={'Rng.Acc.+10','"Rapid Shot"+10','"Recycle"+15',}},-- 0/10
		left_ring="Crepuscular Ring", -- 3/0
		neck={ name="Comm. Charm +2", augments={'Path: A',}}, -- 4/0
		waist="Yemaya Belt", -- 0/5
    }) -- Totals 35/73

	-- Fast Cast for Magic
	sets.Precast.FastCast = {
	    head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}}, -- 14
		body={ name="Taeon Tabard", augments={'"Fast Cast"+5','HP+44',}}, -- 9
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}}, -- 8
		feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}}, -- 8
		neck="Voltsurge Torque", -- 4
		waist="Eschan Stone",
		left_ear="Loquac. Earring", -- 2
		right_ear="Enchanter's Earring +1", -- 2
		left_ring="Lebeche Ring",
		right_ring="Kishar Ring", -- 4
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}, -- 0
	} -- 65 FC
	
	--Base set for midcast - if not defined will notify and use your idle set for surviability
	sets.Midcast = set_combine(sets.Idle, {
        ammo="Devastating Bullet",
        head="Chass. Tricorne +3",
        body="Chasseur's Frac +3",
        hands="Chasseur's Gants +3",
        legs="Chas. Culottes +3",
        feet="Chass. Bottes +3",
        neck="Null loop",
        waist="Null belt",
        left_ear="Alabaster Earring",
        right_ear="Chas. Earring +2",
        left_ring="Metamorph Ring +1",
		right_ring={ name="Stikini Ring +1", bag="wardrobe3"},
        back="Null shawl",
        })

	-- Ranged Attack Gear (Normal Midshot)
    sets.Midcast.RA = {
		ammo=Ammo.Bullet.RA,
		head="Malignance Chapeau",
		neck="Iskur Gorget",
		ear1="Brutal Earring",
		ear2="Telos Earring",
        body="Laksa. Frac +4",
		hands="Meghanada Gloves +2",
		ring1="Dingir Ring",
		ring2="Regal Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Damage taken-5%',}},
		waist="Yemaya Belt",
		legs="Laksamana's Trews +3",
		feet="Meghanada Jambeaux +2"}

	sets.Midcast.RA.ACC = {}

	-- Ranged PDL
	sets.Midcast.RA.PDL = {
		left_ring="Sroda Ring",
    }

	-- Ranged CRIT
	sets.Midcast.RA.CRIT = {
		head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		hands="Chasseur's Gants +3",
		feet="Osh. Leggings +1",
		waist="K. Kachina Belt +1",
		neck="Iskur Gorget",
		left_ear="Odr Earring",
		right_ear={ name="Chas. Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+16','Mag. Acc.+16','Crit.hit rate+6','STR+7 AGI+7',}},
		left_ring="Dingir Ring",
		right_ring="Mummu Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Damage taken-5%',}},
    }

	-- Ranged Attack Gear (Triple Shot Midshot)
	sets.Midcast.RA.TripleShot = set_combine(sets.Midcast.RA, {
        head="Oshosi Mask +1", -- 5
        body="Chasseur's Frac +3", -- 14
        hands="Lanun Gants +4", -- Tripple shot becomes Quad shot
        legs="Ikenga's Trousers", -- Missing
        feet="Osh. Leggings +1", --3
    }) --28

	sets.Utsusemi = set_combine(sets.Idle, {
	
	})

	-- Quick Draw Gear Sets
	sets.QuickDraw = {}

	sets.QuickDraw.ACC = {
		ammo = Ammo.Bullet.QD,
		head="Laksamana's Tricorne +3",
		body="Malignance Tabard",
		hands="Laksamana's Gants +3",
		legs="Malignance Tights",
		feet="Laksamana's Bottes +3",
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="K. Kachina Belt +1",
		left_ear="Crepuscular Earring",
		right_ear={ name="Chas. Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+16','Mag. Acc.+16','Crit.hit rate+6','STR+7 AGI+7',}},
		left_ring="Regal Ring",
		right_ring="Stikini Ring +1",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}

	sets.QuickDraw.DMG = {
		ammo = Ammo.Bullet.QD,
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Lanun Frac +4", augments={'Enhances "Loaded Deck" effect',}},
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs="Nyame Flanchard",
		feet="Lanun Bottes +4",
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="Skrymir Cord +1",
		left_ear="Friomisi Earring",
		right_ear="Crematio Earring",
		left_ring="Dingir Ring",
		right_ring="Ilabrat Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}

	sets.QuickDraw.STP = {
		ammo = Ammo.Bullet.QD,
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Chasseur's Culottes +3",
		feet="Malignance Boots",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Telos Earring",
		right_ear="Crep. Earring",
		left_ring="Regal Ring",
		right_ring="Ilabrat Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}

	-- Quick Draw 
	sets.QuickDraw["Fire Shot"] = set_combine( sets.QuickDraw.DMG, {})
	sets.QuickDraw["Ice Shot"] = set_combine( sets.QuickDraw.DMG, {})
	sets.QuickDraw["Wind Shot"] = set_combine( sets.QuickDraw.DMG, {})
	sets.QuickDraw["Earth Shot"] = set_combine( sets.QuickDraw.DMG, {})
	sets.QuickDraw["Thunder Shot"] = set_combine( sets.QuickDraw.DMG, {})
	sets.QuickDraw["Water Shot"] = set_combine( sets.QuickDraw.DMG, {})
	sets.QuickDraw["Light Shot"] = set_combine( sets.QuickDraw.DMG, {})
	sets.QuickDraw["Dark Shot"] = set_combine( sets.QuickDraw.DMG, {
	    right_ring="Archon Ring",
	    head="Pixie Hairpin +1",
	})

	-- Job Abilities
	sets.JA = {}
	sets.JA["Wild Card"] = {
	    feet={ name="Lanun Bottes +4", augments={'Enhances "Wild Card" effect',}},
	}
	sets.JA["Phantom Roll"] = {}
	sets.JA["Random Deal"] = {
	    body={ name="Lanun Frac +4", augments={'Enhances "Loaded Deck" effect',}},
	}
	sets.JA["Snake Eye"] = {
	    legs={ name="Lanun Trews +4", augments={'Enhances "Snake Eye" effect',}},
	}
	sets.JA["Fold"] = {}			-- Use gloves for bust
	sets.JA["Triple Shot"] = {}		-- Gear to be worn during Midshot
	sets.JA["Cutting Cards"] = {}
	sets.JA["Crooked Cards"] = {}
	sets.JA["Double-Up"] = {
		right_ring="Luzaf's Ring", -- 16 yalm range
	}

	sets.Waltz = set_combine(sets.OffenseMode.DT, {
		ammo="Yamarang", -- 5
		hands="",
		legs="Dashing Subligar", -- 10
	}) -- 15% Potency

	--Base Set used for all rolls
	sets.PhantomRoll = set_combine(sets.Idle, {
		main={ name="Rostam", augments={'Path: C'}, bag="Wardrobe 4", priority=1}, -- +8 Effect and 60 sec Duration
		sub={ name="Nusku Shield", priority=2},
		range="Compensator", -- 20 sec Duration
		head={ name="Lanun Tricorne +4", augments={'Enhances "Winning Streak" effect',}}, -- 50% Job ability Bonus
		hands="Chasseur's Gants +3", --55 sec Duration
		neck="Regal Necklace", -- 20 sec Duration
		right_ring="Luzaf's Ring", -- 16 yalm range
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}}, -- 30 sec Duration
	})
	
	sets.PhantomRoll["Fighter's Roll"] = sets.PhantomRoll
	sets.PhantomRoll["Monk's Roll"] = sets.PhantomRoll
	sets.PhantomRoll["Healer's Roll"] = sets.PhantomRoll
	sets.PhantomRoll["Wizard's Roll"] = sets.PhantomRoll
	sets.PhantomRoll["Warlock's Roll"] = sets.PhantomRoll
	sets.PhantomRoll["Rogue's Roll"] = sets.PhantomRoll
	sets.PhantomRoll["Gallant's Roll"] = sets.PhantomRoll
	sets.PhantomRoll["Chaos Roll"] = sets.PhantomRoll
	sets.PhantomRoll["Beast Roll"] = sets.PhantomRoll
	sets.PhantomRoll["Choral Roll"] = sets.PhantomRoll
	sets.PhantomRoll["Hunter's Roll"] = sets.PhantomRoll
	sets.PhantomRoll["Samurai Roll"] = sets.PhantomRoll
	sets.PhantomRoll["Ninja Roll"] = sets.PhantomRoll
	sets.PhantomRoll["Drachen Roll"] = sets.PhantomRoll
	sets.PhantomRoll["Evoker's Roll"] = sets.PhantomRoll
	sets.PhantomRoll["Magus's Roll"] = sets.PhantomRoll
	sets.PhantomRoll["Corsair's Roll"] = sets.PhantomRoll
	sets.PhantomRoll["Puppet Roll"] = sets.PhantomRoll
	sets.PhantomRoll["Dancer's Roll"] = sets.PhantomRoll
	sets.PhantomRoll["Scholar's Roll"] = sets.PhantomRoll
	sets.PhantomRoll["Bolter's Roll"] = set_combine(sets.Idle, {
		main="Naegling",
		sub={ name="Nusku Shield", priority=2},
		head={ name="Lanun Tricorne +4", augments={'Enhances "Winning Streak" effect',}}, -- 50% Job ability Bonus
		right_ring="Luzaf's Ring", -- 16 yalm range
		back="Null SHawl",
	})
	sets.PhantomRoll["Caster's Roll"] = set_combine(sets.PhantomRoll, {legs="Chas. Culottes +3",})
	sets.PhantomRoll["Tactician's Roll"] = set_combine(sets.PhantomRoll, {body="Chasseur's Frac +3"})
	sets.PhantomRoll["Allies' Roll"] = set_combine(sets.PhantomRoll, {hands="Chasseur's Gants +3"})
	sets.PhantomRoll["Miser's Roll"] = sets.PhantomRoll
	sets.PhantomRoll["Companion's Roll"] = sets.PhantomRoll
	sets.PhantomRoll["Avenger's Roll"] = sets.PhantomRoll
	sets.PhantomRoll["Naturalist's Roll"] = sets.PhantomRoll
    sets.PhantomRoll["Courser's Roll"] = set_combine(sets.PhantomRoll, {feet="Chasseur's Bottes +3"})
    sets.PhantomRoll["Blitzer's Roll"] = set_combine(sets.PhantomRoll, {head="Chasseur's Tricorne +3"})

	-- Melee Base set
	sets.WS = {
		ammo=Ammo.Bullet.WS,
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Cornelia's Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}

	-- Ranged Base Set (Augments the sets.WS)
	sets.WS.RA = {
		body="Laksa. Frac +4",
		hands="Chasseur's Gants +3",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Damage taken-5%',}},
	}

	-- Accuracy sets used in OffenseMode.ACC
	sets.WS.ACC = {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Chasseur's Gants +3",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Null Loop",
		waist="Null Belt",
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	sets.WS.ACC.RA = {}

	-- Equipment to augment WS for Physical Damage Limit (Capped Attack)
	sets.WS.PDL = {
		left_ring="Sroda Ring",
	}
	sets.WS.PDL.RA = {
		left_ring="Sroda Ring",
		head="Ikenga's Hat",
		legs="Ikenga's Trousers",
		feet="Ikenga's Clogs",
	}

	-- Critical Hit set used in OffenseMode.CRIT
	sets.WS.CRIT = { }
	sets.WS.CRIT.RA = { }

	sets.WS.MAB = set_combine(sets.WS, {
		ammo=Ammo.Bullet.MAB,
		feet={ name="Lanun Bottes +4", augments={'Enhances "Wild Card" effect',}},
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear="Crematio Earring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Damage taken-5%',}},
	})

	--These set are used when a weaponskill is used with that level of aftermath with the correct weapon
	--They Augment any built weaponskill set - Same formatting as the OffenseModes
	sets.WS.AM = {}
	sets.WS.AM1 = {}
	sets.WS.AM2 = {}
	sets.WS.AM3 = {}

	sets.WS.AM.RA = {}
	sets.WS.AM1.RA = {}
	sets.WS.AM2.RA = {}
	sets.WS.AM3.RA = {}
	sets.WS.AM1.RA['Armageddon'] = {}
	sets.WS.AM2.RA['Armageddon'] = {}
	sets.WS.AM3.RA['Armageddon'] = {}

	sets.WS["Wildfire"] = set_combine(sets.WS.MAB, {
		head="Nyame Helm",
		body={ name="Lanun Frac +4", augments={'Enhances "Loaded Deck" effect',}},
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet={ name="Lanun Bottes +4", augments={'Enhances "Wild Card" effect',}},
		neck="Comm. Charm +2",
		waist="Skrymir Cord +1",
		left_ear="Friomisi Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	})

	sets.WS["Leaden Salute"] = set_combine(sets.WS.MAB, {
		head="Pixie Hairpin +1",
		body={ name="Lanun Frac +4", augments={'Enhances "Loaded Deck" effect',}},
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet={ name="Lanun Bottes +4", augments={'Enhances "Wild Card" effect',}},
		neck="Comm. Charm +2",
		waist="Skrymir Cord +1",
		left_ear="Friomisi Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Archon Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	})

	sets.WS["Terminus"] = set_combine(sets.WS.MAB, {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Chasseur's Gants +3",
		legs="Nyame Flanchard",
		feet={ name="Lanun Bottes +4", augments={'Enhances "Wild Card" effect',}},
		neck="Comm. Charm +2",
		waist="Fotia Belt",
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Damage taken-5%',}},
	})

	sets.WS["Evisceration"] = set_combine(sets.WS.MAB, {
		ammo="Bayeux Bullet",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body={ name="Ikenga's Vest", augments={'Path: A',}},
		hands="Chasseur's Gants +3",
		legs="Zoar Subligar +1",
		feet="Mummu Gamash. +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Mache Earring +1",
		right_ear="Odr Earring",
		left_ring="Epona's Ring",
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
	})

	sets.WS['Aeolian Edge'] = set_combine(sets.WS.MAB, {
		ammo="Hauksbok Bullet",
		head="Nyame Helm",
		body={ name="Lanun Frac +4", augments={'Enhances "Loaded Deck" effect',}},
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet={ name="Lanun Bottes +4", augments={'Enhances "Wild Card" effect',}},
		neck="Comm. Charm +2",
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	})

	sets.WS["Savage Blade"] = set_combine(sets.WS.WSD, {
		ammo="Bayeux Bullet",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Chasseur's Gants +3",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Rep. Plat. Medal",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','Weapon skill damage +10%','Damage taken-5%',}},
	})

	sets.WS["Last Stand"] = set_combine(sets.WS.WSD, sets.WS.RA, {
		Head="Nyame Helm",
		body="Ikenga's Vest",
		legs="Nyame Flanchard",
		feet="Lanun Bottes +4",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Dingir Ring",
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Damage taken-5%',}},
	})

	-- Uses Default WS set
	sets.WS["Hot Shot"] = set_combine(sets.WS, {
		head="Malignance Chapeau",
		body="Nyame Mail",
		hands="Malignance Gloves",
		legs="Nyame Flanchard",
		feet="Malignance Boots",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Friomisi Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	})
	sets.WS["Split Shot"] = set_combine(sets.WS, {})
	sets.WS["Sniper Shot"] = set_combine(sets.WS, {})
	sets.WS["Slug Shot"] = set_combine(sets.WS, {})
	sets.WS["Numbing Shot"] = set_combine(sets.WS, {})
	sets.WS["Fast Blade"] = set_combine(sets.WS, {})
	sets.WS["Burning Blade"] = set_combine(sets.WS, {})
	sets.WS["Flat Blade"] = set_combine(sets.WS, {})
	sets.WS["Shining Blade"] = set_combine(sets.WS, {})
	sets.WS["Circle Blade"] = set_combine(sets.WS, {})
	sets.WS["Spirits Within"] = set_combine(sets.WS, {})
	sets.WS["Requiescat"] = set_combine(sets.WS, {})

	sets.TreasureHunter = {
		head="Wh. Rarab Cap +1",
		waist="Chaac Belt",
		Legs="Volte Hose",
		right_ring="Hoxne Ring",
	}
end

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
        ["Drachen Roll"]     = {lucky=4, unlucky=7, bonus="Pet Accuracy"},
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
        ["Naturalist's Roll"] = {lucky=3, unlucky=7, bonus="Duration of enhansing effects"},
		["Avenger's Roll"]   = {lucky=4, unlucky=8, bonus="Counter Rate"},
    }
end

function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    local rollsize = (state.LuzafRing.value and 'Large') or 'Small'

    if rollinfo then
        add_to_chat(104, spell.english..' provides a bonus to '..rollinfo.bonus..'.  Roll size: '..rollsize)
        add_to_chat(104, 'Lucky roll is '..tostring(rollinfo.lucky)..', Unlucky roll is '..tostring(rollinfo.unlucky)..'.')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- DO NOT EDIT BELOW THIS LINE UNLESS YOU NEED TO MAKE JOB SPECIFIC RULES
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's subjob changes.
function sub_job_change_custom(new, old)
	-- Typically used for Macro pallet changing
end

--Adjust custom precast actions
function pretarget_custom(spell,action)
end

-- Augment basic equipment sets
function precast_custom(spell)
	equipSet = {}
	if spell.english == 'Fold' then
		equipSet = set_combine(equipSet, {hands={ name="Lanun Gants +4", augments={'Enhances "Fold" effect',}}})
    end
	if spell.id == 123 or spell.type == 'CorsairRoll' then -- Double up and bypass weapon check
		equipSet = set_combine(equipSet, sets.PhantomRoll)
	end
	equipSet = Job_Mode_Check(equipSet)
	return equipSet
end
-- Augment basic equipment sets
function midcast_custom(spell)
	equipSet = {}
	if spell.english == 'Fold' then
		equipSet = set_combine(equipSet, {hands={ name="Lanun Gants +4", augments={'Enhances "Fold" effect',}}})
    end
	if spell.id == 123 or spell.type == 'CorsairRoll' then -- Double up and bypass weapon check
		equipSet = set_combine(equipSet, sets.PhantomRoll)
	end
	equipSet = Job_Mode_Check(equipSet)
	return equipSet
end
-- Augment basic equipment sets
function aftercast_custom(spell)
	equipSet = {}
	if state.JobMode.value == 'Ranged' and player.status == "Engaged" then
		equipSet = set_combine(equipSet, sets.OffenseMode.Ranged)
	end
	equipSet = Job_Mode_Check(equipSet)
	return equipSet
end
--Function is called when the player gains or loses a buff
function buff_change_custom(name,gain)
	equipSet = {}
	if state.JobMode.value == 'Ranged' and player.status == "Engaged" then
		equipSet = set_combine(equipSet, sets.OffenseMode.Ranged)
	end
	equipSet = Job_Mode_Check(equipSet)
	return equipSet
end
--This function is called when a update request the correct equipment set
function choose_set_custom()
	equipSet = {}
	equipSet = Job_Mode_Check(equipSet)
	return equipSet
end
--Function is called when the player changes states
function status_change_custom(new,old)
	equipSet = {}
	if state.JobMode.value == 'Ranged' and new == "Engaged" then
		equipSet = set_combine(equipSet, sets.OffenseMode.Ranged)
	end
	equipSet = Job_Mode_Check(equipSet)
	return equipSet
end

--Function is called when a self command is issued
function self_command_custom(command)
end

function user_file_unload()
	--send_command('lua u autocor')
end

function check_buff_JA()
	buff = 'None'
	local ja_recasts = windower.ffxi.get_ability_recasts()
	if player.sub_job == 'WAR' then
		if not buffactive['Berserk'] and ja_recasts[1] == 0 then
			buff = "Berserk"
		elseif not buffactive['Aggressor'] and ja_recasts[4] == 0 then
			buff = "Aggressor"
		elseif not buffactive['Warcry'] and ja_recasts[2] == 0 then
			buff = "Warcry"
		end
	end
	return buff
end

function check_buff_SP()
	buff = 'None'
	return buff
end

function Job_Mode_Check(equipSet)
	if state.JobMode.value == 'Melee' then
		equipSet = set_combine(equipSet, sets.Weapons.Melee)
	elseif state.JobMode.value == 'Ranged' then
		equipSet = set_combine(equipSet, sets.Weapons.Ranged)
	end
	if DualWield == false then
		if TwoHand == false then
			equipSet = set_combine(equipSet, sets.Weapons.Shield)
		end
	end
	return equipSet
end