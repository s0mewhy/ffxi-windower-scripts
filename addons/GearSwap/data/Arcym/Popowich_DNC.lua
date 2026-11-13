-- Salidar

-- Load and initialize the include file.
include('Mirdain-Include')

--Set to ingame lockstyle and Macro Book/Set
LockStylePallet = "110"
MacroBook = "9"
MacroSet = "1"

--Uses Items Automatically
AutoItem = true

--Upon Job change will use a random lockstyleset
Random_Lockstyle = false

--Lockstyle sets to randomly equip
Lockstyle_List = {110,110,110}

-- Use "gs c food" to use the specified food item 
Food = "Sublime Sushi +1"

-- 'TP','ACC','DT' are standard Default modes.  You may add more and assigne equipsets for them
state.OffenseMode:options('DT','DTRollers','TP','TPRegain','SB','Aminon','AminonRollers') -- ACC effects WS and TP modes
state.OffenseMode:set('DT')

state.WeaponMode:options('Terpsichore','Twashtar','Aeneas Cento','Tauret','Aeneas Tauret','Mpu Gandring','Karambit')
state.WeaponMode:set('Mpu Gandring')

-- Initialize Player
jobsetup (LockStylePallet,MacroBook,MacroSet)

function get_sets()

	sets.Weapons = {}
	sets.Weapons['Terpsichore'] = {main="Terpsichore", sub="Gleti's Knife",}
	sets.Weapons['Twashtar'] = {main="Twashtar", sub="Centovente",}
	sets.Weapons['Aeneas Cento'] = {main="Aeneas", sub="Centovente",}
	sets.Weapons['Tauret'] = {main="Tauret", sub="Centovente",}
	sets.Weapons['Aeneas Tauret'] = {main="Aeneas", sub="Tauret",}
	sets.Weapons['Mpu Gandring'] = {main="Mpu Gandring", sub="Centovente",}
	sets.Weapons['Karambit'] = {main="Karambit",}

	-- Standard Idle set with -DT, Refresh, Regen and movement gear
	sets.Idle = {}

	sets.Idle.DT = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Adamantite Armor",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Engraved belt",
		left_ear="Odnowa Earring +1",
		right_ear="Alabaster Earring",
		left_ring="Chirich Ring +1",
		right_ring="Karieyh Ring",
		back="Null Shawl",
	}

	sets.Idle.DTRollers = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Adamantite Armor",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Engraved belt",
		left_ear="Odnowa Earring +1",
		right_ear="Alabaster Earring",
		left_ring="Roller's Ring",
		right_ring="Karieyh Ring",
		back="Null Shawl",
	}
	
	sets.Idle.TP = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Adamantite Armor",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Engraved belt",
		left_ear="Odnowa Earring +1",
		right_ear="Alabaster Earring",
		left_ring="Chirich Ring +1",
		right_ring="Karieyh Ring",
		back="Null Shawl",
	}
	
	sets.Idle.TPRegain = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Adamantite Armor",
		hands="Regal Gloves",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Engraved belt",
		left_ear="Odnowa Earring +1",
		right_ear="Alabaster Earring",
		left_ring="Roller's Ring",
		right_ring="Karieyh Ring",
		back="Null Shawl",
	}
	
	sets.Idle.AminonRollers = {
		ammo="Coiste Bodhar",
		head="Maculele Tiara +3",
		body="Horos Casaque +4",
		hands="Regal Gloves",
		legs="Gleti's Breeches",
		feet="Macu. Toe Sh. +3",
		neck={ name="Etoile Gorget +2", augments={'Path: A',}},
		waist="Windbuffet Belt +1",
		left_ear="Sherida Earring",
		right_ear="Alabaster Earring",
		left_ring="Roller's Ring",
		right_ring="Moonlight Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}
	
	sets.Idle.SB = sets.Idle.DT

	sets.Idle.Aminon = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Adamantite Armor",
		hands="Regal Gloves",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Engraved belt",
		left_ear="Odnowa Earring +1",
		right_ear={ name="Macu. Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+17','Mag. Acc.+17','"Store TP"+6','DEX+9 AGI+9',}},
		left_ring="Roller's Ring",
		right_ring="Karieyh Ring",
		back="Null Shawl",
}

	sets.Movement = {feet="Skadi's Jambeaux +1",}

	-- Set to be used if you get cursna casted on you
	sets.Cursna_Received = {
	    neck="Nicander's Necklace",
	    left_ring={ name="Eshmun's Ring", bag="wardrobe", priority=2},
		right_ring={ name="Eshmun's Ring", bag="wardrobe4", priority=1},
		waist="Gishdubar Sash",
	}

	--This set is used when OffenseMode is DT and Enaged (Augments the TP base set)
	sets.OffenseMode = {}

	sets.OffenseMode.DT = {
		ammo="Coiste Bodhar",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Duty Flanchard",
		feet="Macu. Toe Sh. +3",
		neck={ name="Etoile Gorget +2", augments={'Path: A',}},
		waist="Windbuffet Belt +1",
		left_ear="Alabaster Earring",
		right_ear="Sherida Earring",
		left_ring="Lehko's Ring",
		right_ring="Moonlight Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}
	
	sets.OffenseMode.DTRollers = {
		ammo="Coiste Bodhar",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Gleti's Breeches",
		feet="Macu. Toe Sh. +3",
		neck={ name="Etoile Gorget +2", augments={'Path: A',}},
		waist="Windbuffet Belt +1",
		left_ear="Alabaster Earring",
		right_ear="Sherida Earring",
		left_ring="Roller's Ring",
		right_ring="Moonlight Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}
	
	--Base TP set to build off
	sets.OffenseMode.TP = {
		ammo="Coiste Bodhar",
    	head="Maculele Tiara +3",
		body="Horos Casaque +4",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet="Maculele Toe Shoes +3",
		neck={ name="Etoile Gorget +2", augments={'Path: A',}},
		waist="Windbuffet Belt +1",
		left_ear="Alabaster Earring",
		right_ear="Sherida Earring",
		left_ring="Lehko's Ring",
		right_ring="Epona's Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}
	
	sets.OffenseMode.TPRegain = {
		ammo="Coiste Bodhar",
    	head="Maculele Tiara +3",
		body="Horos Casaque +4",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet="Maculele Toe Shoes +3",
		neck={ name="Etoile Gorget +2", augments={'Path: A',}},
		waist="Windbuffet Belt +1",
		left_ear="Alabaster Earring",
		right_ear="Sherida Earring",
		left_ring="Roller's Ring",
		right_ring="Epona's Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}
	
	-- Subtle Blow Cap at 50 and II at 25 for a Total of 75.
	-- DNC Subtle Blow = 20/50 w/ Traits. Need +30 in Gear for SBI Cap.
	-- Subtle Blow I: 50/50 | Subtle Blow II:05/25 | DT:50/50 | ACC: High
	
	sets.OffenseMode.SB = {
		ammo="Yamarang",
    	head="Malignance Chapeau",
    	body="Malignance Tabard",
    	hands="Malignance Gloves",
    	legs="Malignance Tights",
    	feet="Malignance Boots",
    	neck="Anu Torque",
    	waist="Reiki Yotai",
    	left_ear="Sherida Earring", -- SBII+5
    	right_ear={ name="Macu. Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+17','Mag. Acc.+17','"Store TP"+6','DEX+9 AGI+9',}},
    	left_ring="Chirich Ring +1", -- SB+10
    	right_ring="Chirich Ring +1", -- SB+10
    	back="Sacro Mantle", -- Ambu Cape has SB+10
	}
	
	sets.OffenseMode.Aminon = {
		ammo="Coiste Bodhar",
		head="Maculele Tiara +3",
		body="Horos Casaque +4",
		hands="Regal Gloves",
		legs="Gleti's Breeches",
		feet="Macu. Toe Sh. +3",
		neck={ name="Etoile Gorget +2", augments={'Path: A',}},
		waist="Windbuffet Belt +1",
		left_ear="Alabaster Earring",
		right_ear="Sherida Earring",
		left_ring="Lehko's Ring",
		right_ring="Moonlight Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}

	sets.OffenseMode.AminonRollers = {
		ammo="Coiste Bodhar",
		head="Maculele Tiara +3",
		body="Horos Casaque +4",
		hands="Regal Gloves",
		legs="Gleti's Breeches",
		feet="Macu. Toe Sh. +3",
		neck={ name="Etoile Gorget +2", augments={'Path: A',}},
		waist="Windbuffet Belt +1",
		left_ear="Alabaster Earring",
		right_ear="Sherida Earring",
		left_ring="Roller's Ring",
		right_ring="Moonlight Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}
	
	--This set is used when OffenseMode is ACC and Enaged (Augments the TP base set)
	sets.OffenseMode.ACC = {}
	--Dual Wield
	sets.OffenseMode.DW = {}

	sets.Precast = {}
	sets.Precast.FastCast = {
		ammo="Sapience Orb",
    	hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    	neck="Baetyl Pendant",
    	waist="Hachirin-no-Obi",
    	left_ear="Etiolation Earring",
    	right_ear="Enchntr. Earring +1",
    	right_ring="Rahab Ring",
	}
	sets.Enmity = {}
	sets.Midcast = {}
	sets.Midcast.SIRD = {}
	sets.Midcast.Cure = {}
	sets.Midcast.Enhancing = {}
	sets.Midcast.Enfeebling = {}
	sets.Midcast["Stoneskin"] = {}
	-------------------------------------------------------------------------------
	---------------------------------  JA Sets  -----------------------------------
	-- When you combine with idle during JA's you'll get ~2 sec of high defense --- 
	-------------------- if not overwritten by specified gear ---------------------
	-------------------------------------------------------------------------------
	sets.JA = {}

	sets.JA["Trance"] = {
		head="Horos tiara +4",
	}
	
	sets.JA["Contradance"] = {}
	
	sets.JA["Saber Dance"] = {
		legs="Horos Tights +4",
	}
	
	sets.JA["Fan Dance"] = {
		hands="Horos Bangles +4",
	}
	
	sets.JA["No Foot Rise"] = {
		body="Horos Casaque +4",
	}
	
	sets.JA["Presto"] = {}
	
	sets.JA["Grand Pas"] = {}
	-------------------------------------------------------------------------------
	-- Flourishes provide buffs to the Dancer and debuffs to the target monster. --
	-------------------------------------------------------------------------------
	sets.Flourish = set_combine(sets.Idle.DT, {head="Nyame Helm",})
																					-- Flourishes I : Monster Control
	sets.Flourish["Animated Flourish"] = set_combine(sets.Flourish, sets.Enmity) 	-- Volatile Enmity spike like Provoke
	sets.Flourish["Desperate Flourish"] = {} 										-- Gravity effect 
	sets.Flourish["Violent Flourish"] = {
        ammo="Yamarang",
        head="Mummu Bonnet +2",
        body="Horos Casaque +4",
        hands="Mummu Wrists +2",
        legs="Mummu Kecks +2",
        feet="Mummu Gamash. +2",
        neck="Etoile Gorget +2",
        ear1="Digni. Earring",
        ear2="Enchntr. Earring +1",
        ring1="Metamorph Ring +1",
        waist="Eschan Stone",
        } 																			-- Stun effect 
																					-- Flourishes II : Skillchain Enhancers
	sets.Flourish["Reverse Flourish"] = {
		hands="Macu. Bangles +3",
		Back="Toetapper Mantle",
	} 																				-- Returns TP in exchange for Finishing Moves
	sets.Flourish["Building Flourish"] = {head="Nyame Helm"}						-- Increases the strength of the next Weapon Skill
	sets.Flourish["Wild Flourish"] = {}												-- Readies target for Skillchain
																					-- Flourishes III : Weapon Skill Buffs
	sets.Flourish["Climactic Flourish"] = {head="Maculele Tiara +3"}				-- Forces Critical Hit(s) on the next attack(s) 
	sets.Flourish["Striking Flourish"] = {body="Macu. Casaque +3"}						-- Forces a Double Attack on the next swing 
	sets.Flourish["Ternary Flourish"] = {}											-- Forces a Triple Attack on the next swing
	-------------------------------------------------------------------------------
	-- Waltz Potency gear caps at 50%, while Waltz received potency caps at 30%. -- 
	-------------------------------------------------------------------------------
	sets.Waltz = {    
		ammo="Yamarang",
    	head={ name="Horos Tiara +4", augments={'Enhances "Trance" effect',}},
    	body="Maxixi Casaque +3",
    	hands="Regal Gloves",
    	legs="Dashing Subligar",
    	feet="Maxixi Toe Shoes +3",
    	neck="Etoile Gorget +2",
    	waist="Chaac Belt",
    	left_ear="Enchntr. Earring +1",
    	right_ear={ name="Macu. Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+17','Mag. Acc.+17','"Store TP"+6','DEX+9 AGI+9',}},
    	left_ring="Metamorph Ring +1",
    	right_ring="Regal Ring",
    	back="Moonlight Cape",
	}
	sets.Waltz["Curing Waltz"] = sets.Waltz
	sets.Waltz["Curing Waltz II"] = sets.Waltz
	sets.Waltz["Curing Waltz III"] = sets.Waltz
	sets.Waltz["Curing Waltz IV"] = sets.Waltz
	sets.Waltz["Curing Waltz V"] = sets.Waltz
	sets.Waltz["Divine Waltz"] = sets.Waltz
	sets.Waltz["Divine Waltz II"] = sets.Waltz
	sets.Waltz["Healing Waltz"] = sets.Waltz
	-------------------------------------------------------------------------------
	---------- Samba duration can be increased using various equipment. -----------
	-------------------------------------------------------------------------------
	sets.Samba = set_combine(sets.Idle.DT, {head="Maxixi Tiara +3",}) --  Missing Ambu Cape for +15
	
	sets.Samba["Haste Samba"] = {}
	sets.Samba["Aspir Samba"] = {}
	sets.Samba["Aspir Samba II"] = {}
	sets.Samba["Drain Samba"] = {}
	sets.Samba["Drain Samba II"] = {}
	sets.Samba["Drain Samba III"] = {}
	-------------------------------------------------------------------------------
	----------- Jigs duration can be increased using various equipment. ----------- 
	-------------------------------------------------------------------------------
	sets.Jig = set_combine(sets.Idle.DT, {feet="Maxixi Toe Shoes +3",}) -- Horos Tights +4 and Maxixi Toe Shoes +3

	sets.Jig["Spectral Jig"] = sets.Jig
	sets.Jig["Chocobo Jig"] = sets.Jig
	sets.Jig["Chocobo Jig II"] = sets.Jig
	-------------------------------------------------------------------------------
	----- Step Accuracy depends on your melee hit rate (including your normal -----
	---- Accuracy equipment). All Steps tested have shown an innate 10 Accuracy --- 
	-- bonus, which can be further enhanced through various pieces of equipment, -- 
	----------------------------- merits, and Presto. -----------------------------
	-------------------------------------------------------------------------------
	sets.Step = {
		ammo="Yamarang",
    	head="Maxixi Tiara +3",
    	body="Maxixi Casaque +3",
    	hands="Maxixi Bangles +4",
    	legs="Maxixi Tights +3",
    	feet="Horos Toe Sh. +4",
    	neck="Etoile Gorget +2",
    	waist="Olseni Belt",
    	left_ear={ name="Mache Earring +1", bag="wardrobe", priority=1},
    	right_ear={ name="Mache Earring +1", bag="wardrobe2", priority=2},
    	left_ring="Chirich Ring +1",
    	right_ring="Regal Ring",
    	back="Sacro Mantle",
	}
	
	sets.JA["Quickstep"] = sets.Step
	sets.JA["Box Step"] = sets.Step
	sets.JA["Stutter Step"] = sets.Step
	sets.JA["Feather Step"] = set_combine(sets.Idle.DT, {})

	--Default WS set base
	sets.WS = {
		ammo="Coiste Bodhar",
		head="Maculele Tiara +3",
		body="Nyame Mail",
		hands="Maxixi Bangles +4",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
    	neck="Etoile Gorget +2",
    	waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    	left_ear="Moonshade Earring",
    	right_ear="Sherida Earring",
    	left_ring="Epaminondas's Ring",
    	right_ring="Regal Ring",
    	back="Sacro Mantle",
	}

	--This set is used when OffenseMode is ACC and a WS is used (Augments the WS base set)
	sets.WS.ACC = {}
	--WS Sets
	-- Dagger WS
	sets.WS["Wasp Sting"] = {}
	sets.WS["Viper Bite"] = {}
	sets.WS["Shadowstich"] = {}
	sets.WS["Gust Slash"] = {}
	sets.WS["Cyclone"] = {}
	sets.WS["Energy Steal"] = {}
	sets.WS["Energy Drain"] = {}
	sets.WS["Dancing Edge"] = {}
	sets.WS["Shark Bite"] = {
		ammo="Crepuscular Pebble",
		head="Maculele Tiara +3",
		body="Nyame Mail",
		hands="Maxixi Bangles +4",
		legs="Maculele tights +3",
		feet="Nyame Sollerets",
    	neck="Etoile Gorget +2",
    	waist="Sailfi Belt +1",
    	left_ear="Moonshade Earring",
    	right_ear="Maculele Earring +2",
    	left_ring="Epaminondas's Ring",
    	right_ring="Regal Ring",
    	back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	sets.WS["Ruthless Stroke"] = {
		ammo="C. Palug Stone",
		head="Maculele Tiara +3",
		body="Nyame Mail",
		hands="Maxixi Bangles +4",
		legs="Maculele tights +3",
		feet="Nyame Sollerets",
    	neck="Etoile Gorget +2",
    	waist="Sailfi Belt +1",
    	left_ear="Moonshade Earring",
    	right_ear="Maculele Earring +2",
    	left_ring="Epaminondas's Ring",
    	right_ring="Regal Ring",
    	back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	sets.WS["Exenterator"] = {
		ammo="Coiste Bodhar",
		head="Maculele Tiara +3",
		body="Horos Casaque +4",
		hands="Maxixi Bangles +4",
		legs="Maculele tights +3",
		feet="Nyame Sollerets",
    	neck="Etoile Gorget +2",
    	waist="Fotia Belt",
    	left_ear="Sherida Earring",
    	right_ear="Maculele Earring +2",
    	left_ring="Epaminondas's Ring",
    	right_ring="Regal Ring",
    	back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	sets.WS["Pyrrhic Kleos"] = {
		ammo="Coiste Bodhar",
		head="Maculele Tiara +3",
		body="Horos Casaque +4",
		hands="Maxixi Bangles +4",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
    	neck="Etoile Gorget +2",
    	waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    	left_ear="Sherida Earring",
    	right_ear="Mache Earring +1",
    	left_ring="Gere Ring",
    	right_ring="Regal Ring",
    	back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	sets.WS["Evisceration"] = {
		ammo="Charis Feather",
		head={ name="Blistering Sallet +1", augments={'Path: A',}},
    	body="Gleti's Cuirass",
    	hands="Gleti's Gauntlets",
    	legs="Gleti's Breeches",
    	feet="Gleti's Boots",
		neck="Etoile Gorget +2",
		waist="Fotia Belt",
		left_ear="Odr Earring",
		right_ear="Maculele Earring +2",
		left_ring="Regal Ring",
		right_ring="Gere Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}	
	sets.WS["Aeolian Edge"] = {
		ammo="Ghastly Tathlum +1",
    	head="Nyame Helm",
    	body="Nyame Mail",
    	hands="Nyame Gauntlets",
    	legs="Nyame Flanchard",
    	feet="Nyame Sollerets",
    	neck="Baetyl Pendant",
    	waist="Orpheus's Sash",
   		left_ear="Moonshade Earring",
    	right_ear="Friomisi Earring",
    	left_ring="Epaminondas's Ring",
    	right_ring="Shiva Ring +1",
    	back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	sets.WS["Rudra's Storm"] = {
		ammo="Crepuscular Pebble",
		head="Maculele Tiara +3",
		body="Nyame Mail",
		hands="Maxixi Bangles +4",
		legs="Maculele tights +3",
		feet="Horos Tights +4",
    	neck="Etoile Gorget +2",
    	waist="Kentarch Belt +1",
    	left_ear="Moonshade Earring",
    	right_ear="Maculele Earring +2",
    	left_ring="Epaminondas's Ring",
    	right_ring="Regal Ring",
    	back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}

	-- Hand to Hand WS
	sets.WS["Combo"] = {}
	sets.WS["Shoulder Tackle"] = {}
	sets.WS["Backhand Blow"] = {}
	sets.WS["Asuran Fists"] = {} 	-- Only if Karambit Weapon Equipt
	sets.WS["Dragon Kick"] = {} 	-- Only if Hepatizon Baghnakhs NQ/+1 Weapon Equipt
	sets.WS["One Inch Punch"] = {} 	-- Must Sub MNK
	sets.WS["Raging Fists"] = {} 	-- Must Sub MNK
	sets.WS["Tornado Kick"] = {} 	-- Must Sub MNK

	sets.TreasureHunter = {
		head="Wh. Rarab Cap +1",
		waist="Chaac Belt",
		Legs="Volte Hose",
		right_ring="Hoxne Ring",
	}
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
    if spell.english == 'Spectral Jig' and buffactive.sneak then
        send_command('cancel sneak')
    elseif spell.english == 'Sneak' and spell.target.type == 'SELF' and buffactive.sneak then
        send_command('cancel sneak')
    elseif spell.english == ('Stoneskin') then
        send_command('@wait 1.0;cancel stoneskin')
    elseif spell.english:startswith('Monomi') then
        send_command('@wait 1.7;cancel sneak')
    elseif spell.english == 'Utsusemi: Ichi' then
        send_command('@wait 1.7;cancel copy image,copy image (2)')
    elseif (spell.english == 'Trance' or spell.type=='Waltz') and buffactive['saber dance'] then
        send_command('cancel saber dance')
    elseif spell.type=='Samba' and buffactive['fan dance'] then
        send_command('cancel fan dance')
    end

    equipSet = {}
    return Weapon_Check(equipSet)
end
-- Augment basic equipment sets
function midcast_custom(spell)
	equipSet = {}

	return Weapon_Check(equipSet)
end
-- Augment basic equipment sets
function aftercast_custom(spell)
	equipSet = {}

	return Weapon_Check(equipSet)
end
--Function is called when the player gains or loses a buff
function buff_change_custom(name,gain)
	equipSet = {}

	return Weapon_Check(equipSet)
end
--This function is called when a update request the correct equipment set
function choose_set_custom()
	equipSet = {}

	return Weapon_Check(equipSet)
end
--Function is called when the player changes states
function status_change_custom(new,old)
	equipSet = {}

	return Weapon_Check(equipSet)
end
--Function is called when a self command is issued
function self_command_custom(command)

end
--Function is called when a lua is unloaded
function user_file_unload()

end

--Function used to automate Job Ability use
function check_buff_JA()
	buff = 'None'
	local ja_recasts = windower.ffxi.get_ability_recasts()

	if player.sub_job == 'SAM' and player.sub_job_level > 8 then
		if not buffactive['Hasso'] and not buffactive['Seigan'] and ja_recasts[138] == 0 then
			buff = "Hasso"
		elseif not buffactive['Meditate'] and ja_recasts[134] == 0 then
			buff = "Meditate"
		end
	end

	if player.sub_job == 'WAR' and player.sub_job_level > 8 then
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
	--local sp_recasts = windower.ffxi.get_spell_recasts()
	return buff
end

function pet_change_custom(pet,gain)
	equipSet = {}
	
	return equipSet
end

function pet_aftercast_custom(spell)
	equipSet = {}

	return equipSet
end

function pet_midcast_custom(spell)
	equipSet = {}

	return equipSet
end

function Weapon_Check(equipSet)
	equipSet = set_combine(equipSet,sets.Weapons[state.JobMode.value])

	return equipSet
end