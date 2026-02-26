----------------------------------------------------------------------------------------
--  __  __           _                     __   _____                        _
-- |  \/  |         | |                   / _| |  __ \                      | |
-- | \  / | __ _ ___| |_ ___ _ __    ___ | |_  | |__) |   _ _ __  _ __   ___| |_ ___
-- | |\/| |/ _` / __| __/ _ \ '__|  / _ \|  _| |  ___/ | | | '_ \| '_ \ / _ \ __/ __|
-- | |  | | (_| \__ \ ||  __/ |    | (_) | |   | |   | |_| | |_) | |_) |  __/ |_\__ \
-- |_|  |_|\__,_|___/\__\___|_|     \___/|_|   |_|    \__,_| .__/| .__/ \___|\__|___/
--                                                         | |   | |
--                                                         |_|   |_|
-----------------------------------------------------------------------------------------
--[[

    Originally Created By: Faloun
    Programmers: Arrchie, Kuroganashi, Byrne, Tuna
    Testers:Arrchie, Kuroganashi, Haxetc, Patb, Whirlin, Petsmart
    Contributors: Xilkk, Byrne, Blackhalo714

    ASCII Art Generator: http://www.network-science.de/ascii/
    
]]

-- Initialization function for this job file.
-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include("Mote-Include.lua")
end

function user_setup()

    --[[
        Cycle Offense Mode (the offensive half of all 'hybrid' melee modes).
        
        These are for when you are fighting with or without Pet
        When you are IDLE and Pet is ENGAGED that is handled by the Idle Sets
    ]]
	
    state.OffenseMode:options("Master", "ODSS", "ODVE", "Bruiser", "Turtle", "Magic")

    --[[
        Cycle Hybrid Mode (the defensive half of all 'hybrid' melee modes).
        
        Used when you are Engaged with Pet
        Used when you are Idle and Pet is Engaged
    ]]
    state.HybridMode:options("Pet", "Master")

    --[[ IDLE Mode Notes:

        Update currently equipped gear, and report current status.
        Cycle Idle Mode.
        
        Will automatically set IdleMode to Idle when Pet becomes Engaged and you are Idle
    ]]
	
    state.PhysicalDefenseMode:options("Normal", "PetDT", "DT")

    --[[
        F10 - Activate emergency Physical Defense Mode

        F11 - Activate emergency Magical Defense Mode. Replaces Physical Defense Mode, if that was active.
    ]]
	
    state.MagicalDefenseMode:options("PetMDT")

    --[[ IDLE Mode Notes:

        Update currently equipped gear, and report current status.
        Cycle Idle Mode.
        
        Will automatically set IdleMode to Idle when Pet becomes Engaged and you are Idle
    ]]
	
    state.IdleMode:options("Idle", "MasterDT")

    --Various Cycles for the different types of PetModes
	state.PetStyleCycleDD = M {"NORMAL", "BONE", "SPAM"}
    state.PetStyleCycleTank = M {"NORMAL", "DD", "MAGIC", "SPAM"}
    state.PetStyleCycleMage = M {"NORMAL", "HEAL", "SUPPORT", "MB", "DD"}


    --The actual Pet Mode and Pet Style cycles
    --Default Mode is Tank
    state.PetModeCycle = M {"DD", "TANK", "MAGE"}
    --Default Pet Cycle is Tank
    state.PetStyleCycle = state.PetStyleCycleTank

    --Toggles
	-- Home - Auto Maneuver
	-- End - Lock DT set
	-- Delete - Lock Weapon
	-- ALT + Home - Weaponskill FTP
    -- Alt +End  - Toggles Kiting Mode
	-- ALT + Delete - 
	-- Alt + (tilda) - CP Gear
	
    --[[
        //gs c toggle automan
    ]]
	
    state.AutoMan = M(false, "Auto Maneuver")
	
    --[[
        //gs c toggle autodeploy
    ]]
	
    state.AutoDeploy = M(false, "Auto Deploy")

    --[[
        //gs c toggle lockdt
        (Note this will block all gearswapping when active)
    ]]
	
    state.LockDT = M(false, "Lock DT")

    --[[
        //gs c toggle lockweapon
    ]]
	
    state.LockWeapon = M(false, "Lock Weapon")

    --[[
        //gs c toggle setftp
    ]]
	
    state.SetFTP = M(false, "Set FTP")

   --[[
        This will hide the entire HUB
        //gs c hub all
    ]]
	
    state.textHideHUB = M(false, "Hide HUB")

    --[[
        This will hide the Mode on the HUB
        //gs c hub mode
    ]]
	
    state.textHideMode = M(false, "Hide Mode")

    --[[
        This will hide the State on the HUB
        //gs c hub state
    ]]
	
    state.textHideState = M(false, "Hide State")

    --[[
        This will hide the Options on the HUB
        //gs c hub options
    ]]
	
    state.textHideOptions = M(false, "Hide Options")

    --[[
        This will toggle the HUB lite mode
        //gs c hub lite
    ]] 
	
    state.useLightMode = M(false, "Toggles Lite mode")

    --[[
        This will toggle the default Keybinds set up for any changeable command on the window
        //gs c hub keybinds
    ]]
	
    state.Keybinds = M(false, "Hide Keybinds")

    --[[ 
        This will toggle the CP Mode 
        //gs c toggle CP 
    ]] 
	
    state.CP = M(false, "CP") 
	CP_CAPE = {
		name="Mecisto. Mantle", 
		augments={'Cap. Point+41%','MP+13','DEF+8',}
	}
	
    --[[
        Enter the slots you would lock based on a custom set up.
        Can be used in situation like Salvage where you don't want
        certain pieces to change.

        //gs c toggle customgearlock
        ]]
    state.CustomGearLock = M(false, "Custom Gear Lock")
    --Example customGearLock = T{"head", "waist"}
    customGearLock = T{} -- Currently tied to "Warp ring" in Library

    send_command("bind !f7 gs c cycle PetModeCycle")
    send_command("bind ^f7 gs c cycleback PetModeCycle")
    send_command("bind !f8 gs c cycle PetStyleCycle")
    send_command("bind ^f8 gs c cycleback PetStyleCycle")
	send_command('bind !f10 gs c cycle OffenseMode')
    send_command('bind ^f10 gs c cycleback OffenseMode')
	send_command('bind !f11 gs c cycle HybridMode')
	send_command('bind ^f11 gs c cycleback HybridMode')
	send_command('bind !f9 gs c cycle IdleMode')
	send_command('bind ^f9 gs c cycleback IdleMode')
    send_command("bind home gs c toggle AutoMan")
    send_command("bind end gs c toggle LockDT")
    send_command("bind !f4 gs c predict")
    send_command("bind delete gs c toggle LockWeapon")
    send_command("bind !home gs c toggle setftp")
    send_command("bind !delete gs c toggle autodeploy")
	send_command("bind !end gs c toggle CustomGearLock")
	send_command("bind = gs c clear")
    send_command("bind !e gs c hide keybinds")
    send_command("bind !` gs c toggle CP") 
    send_command("bind = gs c clear")
	

    select_default_macro_book()
	send_command('@wait 3;input /lockstyleset 16')

    -- Adjust the X (horizontal) and Y (vertical) position here to adjust the window
    pos_x = 1730
    pos_y = 500
    setupTextWindow(pos_x, pos_y)
    
end

function file_unload()
    send_command("unbind !f7")
    send_command("unbind ^f7")
    send_command("unbind !f8")
    send_command("unbind ^f8")
	send_command('unbind !f9')
	send_command('unbind ^f9')
	send_command('unbind !f10')
	send_command('unbind ^f10')
	send_command('unbind !f11')
	send_command('unbind ^f11')
    send_command("unbind !e")
    send_command("unbind !f4")
    send_command("unbind !`")
    send_command("unbind home")
	send_command("unbind !home")
	send_command("unbind !end")
    send_command("unbind !delete")
    send_command("unbind end")
	send_command("unbind delete") 
    send_command("unbind =")
end

function job_setup()
    include("PUP-LIB.lua")
	
	no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)"}
end

function init_gear_sets()
    --Table of Contents
    ---Gear Variables
    ---Master Only Sets
    ---Hybrid Only Sets
    ---Pet Only Sets
    ---Misc Sets

    -------------------------------------------------------------------------
    --  _____                  __      __        _       _     _
    -- / ____|                 \ \    / /       (_)     | |   | |
    --| |  __  ___  __ _ _ __   \ \  / /_ _ _ __ _  __ _| |__ | | ___  ___
    --| | |_ |/ _ \/ _` | '__|   \ \/ / _` | '__| |/ _` | '_ \| |/ _ \/ __|
    --| |__| |  __/ (_| | |       \  / (_| | |  | | (_| | |_) | |  __/\__ \
    -- \_____|\___|\__,_|_|        \/ \__,_|_|  |_|\__,_|_.__/|_|\___||___/
    -------------------------------------------------------------------------
    --[[
        This section is best ultilized for defining gear that is used among multiple sets
        You can simply use or ignore the below
    ]]	
	
    --Key-Value Pair for Artifact, Relic and Empy gear
	
    Artifact_Foire = {}
    Artifact_Foire.Head = "Foire Taj +3"
    Artifact_Foire.Body = "Foire Tobe +3"
    Artifact_Foire.Hands = "Foire Dastanas +3"
    Artifact_Foire.Legs = "Foire Churidars +3"
    Artifact_Foire.Feet = "Foire Babouches +3"

    Relic_Pitre = {}
    Relic_Pitre.Head = "Pitre Taj +3" --Enhances Optimization
    Relic_Pitre.Body = "Pitre Tobe +3" --Enhances Overdrive
    Relic_Pitre.Hands = "Pitre Dastanas +3" --Enhances Fine-Tuning
    Relic_Pitre.Legs = "Pitre Churidars +3" --Enhances Ventriloquy
    Relic_Pitre.Feet = "Pitre Babouches +3" --Enhances Role Reversal

    Empy_Karagoz = {}
    Empy_Karagoz.Head = "Kara. Cappello +2"
    Empy_Karagoz.Body = "Kara. Farsetto +2"
    Empy_Karagoz.Hands = "Karagoz Guanti +2"
    Empy_Karagoz.Legs = "Kara. Pantaloni +2"
    Empy_Karagoz.Feet = "Karagoz Scarpe +2"
	Empy_Karagoz.Ear = "Kara. Earring +1"

	--Key-Value Pair for Animators

    Animators = {}
    Animators.Melee = "Animator P +1"
	Animators.Magic = "Animator P II +1"
	Animators.Master = "Neo Animator"

    --Key-Value Pair for mantles
	
    Visucius = {}
	Visucius.haste = {
		name="Visucius's Mantle", 
		augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: Damage taken -5%'
			}
		}

	Visucius.regen = {
		name="Visucius's Mantle", 
		augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: "Regen"+10','Pet: Damage taken -5%'
			}
		}

    Visucius.master = { 
		name="Visucius's Mantle",
		augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%'
			}
		}

	Dispersal = {}
    Dispersal.TP = {
        name="Dispersal Mantle", 
		augments={'STR+1','DEX+2','Pet: TP Bonus+500','"Martial Arts"+11'
		}
	}
	
    --------------------------------------------------------------------------------
    --  __  __           _               ____        _          _____      _
    -- |  \/  |         | |             / __ \      | |        / ____|    | |
    -- | \  / | __ _ ___| |_ ___ _ __  | |  | |_ __ | |_   _  | (___   ___| |_ ___
    -- | |\/| |/ _` / __| __/ _ \ '__| | |  | | '_ \| | | | |  \___ \ / _ \ __/ __|
    -- | |  | | (_| \__ \ ||  __/ |    | |__| | | | | | |_| |  ____) |  __/ |_\__ \
    -- |_|  |_|\__,_|___/\__\___|_|     \____/|_| |_|_|\__, | |_____/ \___|\__|___/
    --                                                  __/ |
    --                                                 |___/
    ---------------------------------------------------------------------------------
    --This section is best utilized for Master Sets
    --[[
        Will be activated when Pet is not active, otherwise refer to sets.idle.Pet
    ]]
   
	-- Add enmity set for Provoke and Flash
	sets.Enmity = {}

    sets.precast.FC = {}

    sets.midcast = {} --Can be left empty

    sets.midcast.FastRecast = {}
	
	sets.midcast['Flash'] = set_combine(sets.Enmity, {})

    sets.Kiting = {
		legs = "Desultor Tassets", --Movement speed +8%
		feet = "Hermes' Sandals" --Movement speed +12%
	} 

    -------------------------------------JA
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
		--neck = "Magoraga Beads", 
		body = "Passion Jacket" --Utsusemi spellcasting time -10%
	})

    -- Precast sets to enhance JAs
    sets.precast.JA = {} -- Can be left empty

    sets.precast.JA["Provoke"] = set_combine(sets.Enmity, {})

    sets.precast.JA["Tactical Switch"] = {
		feet = Empy_Karagoz.Feet
	}

    sets.precast.JA["Ventriloquy"] = {
		legs = Relic_Pitre.Legs
	}

    sets.precast.JA["Role Reversal"] = {
		feet = Relic_Pitre.Feet
	}

    sets.precast.JA["Overdrive"] = {
		body = Relic_Pitre.Body
	}

	--PUP - Repair (Nibiru) --
	--Max repair potency is 50%
    sets.precast.JA["Repair"] = {
		main="Nibiru Sainti", --Repair potency +10%
	    ammo="Automat. Oil +3",
        head="Rao Kabuto +1", --HP+125
		body=Artifact_Foire.Body, --HP+220
		hands="Rao Kote +1", --HP+125
		legs="Desultor Tassets", --Repair potency +10%
        feet=Artifact_Foire.Feet, --Repair +3
		ring2="Overbearing ring", --HP+45
		ear1="Pratik Earring", --Repair potency +10%
		ear2="Guignol Earring" --Repair potency +20%
    }

    sets.precast.JA["Maintenance"] = set_combine(sets.precast.JA["Repair"], {})

	-- PUP - Maneuvers --
    sets.precast.JA.Maneuver = {
		--Main="Kenkoken",
        body=Empy_Karagoz.Body, --Overload rate -40
        hands=Artifact_Foire.Hands, --Maneuver effect +5 & Overload rate -5
		neck="Buffoon's Collar +1", --Overload cap +5
        ear2="Burana Earring", --Maneuver effect +1
		back = Visucius.regen, --Overload rate -10
		}

    sets.precast.JA["Activate"] = {
		back = Visucius.regen, --Overload rate -10
		}

    sets.precast.JA["Deus Ex Automata"] = sets.precast.JA["Activate"]

    --Waltz set (chr and vit)
    sets.precast.Waltz = {
       body = "Passion Jacket" --Waltz potency +13%
    }

    sets.precast.Waltz["Healing Waltz"] = {}
	
	----------------------------------------------------------------------------
	--   ____   __  __               _             __  __           _           
	--  / __ \ / _|/ _|             (_)           |  \/  |         | |          
	-- | |  | | |_| |_ ___ _ __  ___ ___   _____  | \  / | ___   __| | ___  ___ 
	-- | |  | |  _|  _/ _ \ '_ \/ __| \ \ / / _ \ | |\/| |/ _ \ / _` |/ _ \/ __|
	-- | |__| | | | ||  __/ | | \__ \ |\ V /  __/ | |  | | (_) | (_| |  __/\__ \
	--  \____/|_| |_| \___|_| |_|___/_| \_/ \___| |_|  |_|\___/ \__,_|\___||___/
	----------------------------------------------------------------------------

    -------------------------------------Engaged sets
    --[[
        Offense Mode = Master
		
		-- When fighting with out Automation --
		-- PUP - TP (AM3) --
    ]]

	sets.engaged.Master = {
		main="Godhands",
		--Main="Kenkoken",
		range=Animators.Master,
		ammo="Automat. Oil +3",
		head="Malignance Chapeau",
		body="Nyame Mail",
		--body="Malignance Tabard",
		hands="Nyame Gauntlets",
		--hands="Malignance Gloves",
		legs="Nyame Flanchard",
		--legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Combatant's Torque",
		waist="Moonbow Belt +1",
		ear1="Telos Earring",
		ear2="Dedition Earring",
		ring1="Regal Ring",
		ring2="Gere Ring",
		back=Visucius.master,
	}
		
	sets.engaged.Master.Master = set_combine(sets.engaged.Master,{})
	-------------------------------------
    --[[
        Offense Mode = Master
		Hybrid Mode = Pet
		
		-- When engaging with Automation --
		-- PUP - Dual TP --
		-- Max equiptment haste cap for automation is 26%
    ]]
	
	sets.engaged.Master.Pet = {
		main="Godhands",
		--main="Kenkoken", --Suppresses Overload
		range=Animators.Melee,
		ammo="Automat. Oil +3",
		head="Heyoka Cap",
		body={ name="Mpaca's Doublet", augments={'Path: A',}},
		hands=Empy_Karagoz.Hands,
		legs="Heyoka Subligar +1",
		feet={ name="Mpaca's Boots", augments={'Path: A',}},
		neck="Shulmanu Collar",
		waist="Moonbow Belt +1",
		ear1="Crep. Earring",
		ear2=Empy_Karagoz.Ear,
		ring1="Niqmaddu Ring",
		ring2="Gere Ring",
		back=Visucius.haste,
	}
	-------------------------------------
    --[[
        Offense Mode = ODSS
		
		-- When Overdriving on Sharpshot frame --
		-- PUP - Overdrive (SS) --
    ]]
	
	sets.engaged.ODSS = {
		main={ name="Xiucoatl", augments={'Path: C',}},
		range=Animators.Melee,
		head=Empy_Karagoz.Head,
		ammo="Automat. Oil +3",
		body=Relic_Pitre.Body,
		hands={ name="Mpaca's Gloves", augments={'Path: A',}},
		legs="Heyoka Subligar +1",
		feet={ name="Mpaca's Boots", augments={'Path: A',}},
		neck="Shulmanu Collar",
		waist="Klouskap Sash +1",
		ear1="Rimeice Earring",
		ear2=Empy_Karagoz.Ear,
		ring1="Thur. Ring +1",
		ring2="C. Palug Ring",
		back=Dispersal.TP,
	}
	
	sets.engaged.ODSS.Master = set_combine(sets.engaged.ODSS,{})
	sets.engaged.ODSS.Pet = set_combine(sets.engaged.ODSS,{})
	-------------------------------------
	--[[
        Offense Mode = ODVE
		
		-- When Overdriving on Valoredge frame --
    ]]
	
	sets.engaged.ODVE = {
		main={ name="Xiucoatl", augments={'Path: C',}},
		--main="Kenkoken",
		range=Animators.Melee,
		ammo="Automat. Oil +3",
		head={ name="Taeon Chapeau", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
		body={ name="Taeon Tabard", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
		hands={ name="Taeon Gloves", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
		legs={ name="Taeon Tights", augments={'Pet: Accuracy+23 Pet: Rng. Acc.+23','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
		feet={ name="Mpaca's Boots", augments={'Path: A',}},
		neck="Shulmanu Collar",
		waist="Klouskap Sash +1",
		ear1="Rimeice Earring",
		ear2=Empy_Karagoz.Ear,
		ring1="Thur. Ring +1",
		ring2="C. Palug Ring",
		back=Visucius.regen,
	}
	
	sets.engaged.ODVE.Master = set_combine(sets.engaged.ODVE,{})
	sets.engaged.ODVE.Pet = set_combine(sets.engaged.ODVE,{})
	-------------------------------------
    --[[
        Offense Mode = Bruiser
		
		-- When tanking but can be more offensive --
		-- PUP - Bruiser TP --
    ]]

	sets.engaged.Bruiser = {
		main={ name="Ohtas", augments={'Accuracy+70','Pet: Accuracy+70','Pet: Haste+10%',}},
		range=Animators.Melee,
		ammo="Automat. Oil +3",
		head={ name="Taeon Chapeau", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
		body={ name="Taeon Tabard", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
		hands={ name="Taeon Gloves", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
		legs={ name="Taeon Tights", augments={'Pet: Accuracy+23 Pet: Rng. Acc.+23','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
		feet={ name="Taeon Boots", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
		neck="Shulmanu Collar",
		waist="Incarnation Sash",
		ear1="Rimeice Earring",
		ear2="Enmerkar Earring",
		ring1="Thur. Ring +1",
		ring2 ="C. Palug Ring",
		back=Visucius.regen,
	}
	
	sets.engaged.Bruiser.Master = set_combine(sets.engaged.Bruiser,{})
	sets.engaged.Bruiser.Pet = set_combine(sets.engaged.Bruiser,{})
	 -------------------------------------
    --[[
        Offense Mode = Turtle
		
		-- When maximum survival is needed --
		-- PUP - Turtle Tank --
    ]]
	
	sets.engaged.Turtle = {
		main="Gnafron's Adargas",
		range=Animators.Melee,
		ammo="Automat. Oil +3",
		head={ name="Rao Kabuto +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		body={ name="Rao Togi +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		hands={ name="Rao Kote +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		legs={ name="Rao Haidate +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		feet={ name="Rao Sune-Ate +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		neck="Shepherd's Chain",
		waist="Isa Belt",
		ear1="Rimeice Earring",
		ear2="Domes. Earring",
		ring1="Thur. Ring +1",
		ring2="Overbearing Ring",
		back=Visucius.regen,
	}
	
	sets.engaged.Turtle.Master = set_combine(sets.engaged.Turtle,{})
	sets.engaged.Turtle.Pet = set_combine(sets.engaged.Turtle,{})
	-------------------------------------
    --[[
        Offense Mode = Magic
		
		-- When casting and/or magic bursting is prefered --
		-- PUP - Pet Nuking --
    ]]
	
	sets.engaged.Magic = {
		main="Sakpata's Fists", --All Attr. +20, Magic Accuracy +50
		range=Animators.Magic,
		ammo="Automat. Oil +3",
		head=Relic_Pitre.Head, --Regen +5, Refresh +5
		body=Artifact_Foire.Body, --MP +220, Haste +5%
		hands=Empy_Karagoz.Hands, --Magic Accuracy +52
		legs=Relic_Pitre.Legs, --Fast Cast +10%
		feet=Relic_Pitre.Feet, --Magic Accuracy +50, Haste +5%
		neck={ name="Pup. Collar +2", augments={'Path: A',}},  --Magic Accuracy +25
		waist="Ukko Sash", --Fast Cast 5%
		ear1="Crep. Earring", --Magic Accuracy +10
		ear2="Kyrene's Earring", --Magic Accuracy +15
		ring1="Tali'ah Ring", --Magic Accuracy +6
		ring2="C. Palug Ring", --Magic Accuracy +12
		back="Contriver's Cape", --Adds "Regen" and "Refresh"
	}
	
	sets.engaged.Magic.Master = set_combine(sets.engaged.Magic,{})
	sets.engaged.Magic.Pet = set_combine(sets.engaged.Magic,{})
	-------------------------------------
    --[[
        Offense Mode = DT - Master DT set
    
		When using damage taken idle or emergency DT set
		-tied to library- lua with Opo-opo Necklace
	]]
	
	sets.engaged.DT = {
       	head="Nyame Helm", --DT -7%
		body=Empy_Karagoz.Body, --DT -12%
		hands=Empy_Karagoz.Hands, --DT -9%
		legs="Nyame Flanchard", --DT -8%
		feet="Nyame Sollerets", --DT -7%
		neck="Twilight Torque", --DT -5%
		--Loricate Torque +1, --DT -6%
		waist="Moonbow Belt +1", --DT -6%
		ring1="Fortified Ring", --MDT -5%
		ring2="Defending Ring", --DT -10%
		ear1="Schere Earring", --Melee attack: Consumes 20 mp and reduces enmity by 20
		ear2="Genmei Earring", --PDT -2%
    }
	
	sets.engaged.DT.Master = set_combine(sets.engaged.DT,{})
	sets.engaged.DT.Pet = set_combine(sets.engaged.DT,{})
    ----------------------------------------------------------------
    --  _____     _      ____        _          _____      _
    -- |  __ \   | |    / __ \      | |        / ____|    | |
    -- | |__) |__| |_  | |  | |_ __ | |_   _  | (___   ___| |_ ___
    -- |  ___/ _ \ __| | |  | | '_ \| | | | |  \___ \ / _ \ __/ __|
    -- | |  |  __/ |_  | |__| | | | | | |_| |  ____) |  __/ |_\__ \
    -- |_|   \___|\__|  \____/|_| |_|_|\__, | |_____/ \___|\__|___/
    --                                  __/ |
    --                                 |___/
    ----------------------------------------------------------------

    -------------------------------------Magic Midcast
    sets.midcast.Pet = {}

    sets.midcast.Pet.Cure = {
	   	legs = Artifact_Foire.Legs, --Pet "Cure" potency +16%
    }

    sets.midcast.Pet["Healing Magic"] = {}

    sets.midcast.Pet["Elemental Magic"] = {
		--body="Udug Jacket" --Pet Magic Atk. Bonus +45
		legs=Relic_Pitre.Legs, --Pet Magic Atk. Bonus +51
	   	feet=Relic_Pitre.Feet, --Pet Magic Atk. Bonus +57
		ear1="Burana Earring", --Pet Magic Atk. Bonus +10
		ear2=Empy_Karagoz.Ear
    }

    sets.midcast.Pet["Enfeebling Magic"] = {}

    sets.midcast.Pet["Dark Magic"] = {}

    sets.midcast.Pet["Divine Magic"] = {}

    sets.midcast.Pet["Enhancing Magic"] = {}

    -------------------------------------Idle
    --[[
        This set will become default Idle Set when the Pet is Active 
        and sets.idle will be ignored
        Player = Idle and not fighting
        Pet = Idle and not fighting

        Idle Mode = Idle
    ]]
	
	sets.idle = {} -- Empty, representing no idle set active
	
	-------------------------------------Idle DT
		
	sets.idle.MasterDT = set_combine(sets.engaged.DT, {})
	
    -------------------------------------Enmity
	--[[
		Equipped automatically when using Flash or Strobe
		-tied to library lua-
	]]
	
    sets.pet_enmity = {
		head="Heyoka Cap", --Enmity +8
		body="Heyoka Harness", --Enmity +10
       	hands="Heyoka Mittens", --Enmity +7
	   	legs="Heyoka Subligar +1", --Enmity +
	   	feet="Heyoka Leggings",--Enmity +11
	   	ear1="Rimeice Earring",--Enmity +5
		ear2="Domes. Earring", --Enmity +5
	}

	---------------------------------------------
	-- __          _______    _____      _       
	-- \ \        / / ____|  / ____|    | |      
	--  \ \  /\  / / (___   | (___   ___| |_ ___ 
	--   \ \/  \/ / \___ \   \___ \ / _ \ __/ __|
	--    \  /\  /  ____) |  ____) |  __/ |_\__ \
	--     \/  \/  |_____/  |_____/ \___|\__|___/
	---------------------------------------------
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    -------------------------------------WS
	
    sets.precast.WS = {
		head = "Nyame Helm", --Skillchain bonus +5
		body = Artifact_Foire.Body, --Weaponskill dmg +10%
		hands = Relic_Pitre.Hands, --Weaponskill dmg +10%
		legs = "Nyame Flanchard", --Skillchain bonus +6
		feet = Empy_Karagoz.Feet, --Weaponskill dmg +8%
	    neck = "Fotia Gorget", --Weaponskill Acc+ 10 Weaponskill dmg +10%
		waist = "Fotia Belt", --Weaponskill Acc+ 10 Weaponskill dmg +10%
		ear1 = "Moonshade Earring", --TP Bonus +250 & Attack +4
		ear2 = "Mache Earring +1", --Accuracy +10 & Dex +8
		ring1 = "Regal Ring", --Attack +20, Str +10, Dex +10, Vit +10, Agi +10
		ring2 = "Gere Ring", --Str +10, Attack +16
		back = Visucius.master, --Str +30, Accuracy +20 & Attack +20, Crit 10%
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found

    sets.precast.WS["Victory Smite"] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS["Stringing Pummel"] = set_combine(sets.precast.WS, {
		head={ name="Mpaca's Cap", augments={'Path: A',}},
		body={ name="Mpaca's Doublet", augments={'Path: A',}},
		hands={ name="Mpaca's Gloves", augments={'Path: A',}},
		legs={ name="Mpaca's Hose", augments={'Path: A',}},
		feet={ name="Mpaca's Boots", augments={'Path: A',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		ear1="Schere Earring",
		ear2=Empy_Karagoz.Ear,
		ring1="Niqmaddu Ring",
		ring2="Gere Ring",
		back=Visucius.master,
	})

    sets.precast.WS["Shijin Spiral"] = set_combine(sets.precast.WS, {
		head={ name="Mpaca's Cap", augments={'Path: A',}},
		body={ name="Mpaca's Doublet", augments={'Path: A',}},
		hands={ name="Mpaca's Gloves", augments={'Path: A',}},
		legs={ name="Mpaca's Hose", augments={'Path: A',}},
		feet={ name="Mpaca's Boots", augments={'Path: A',}},
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		ear1="Schere Earring",
		ear2=Empy_Karagoz.Ear,
		ring1="Niqmaddu Ring",
		ring2="Gere Ring",
		back=Visucius.master,
	})

    sets.precast.WS["Howling Fist"] = set_combine(sets.precast.WS, {
		head={ name="Mpaca's Cap", augments={'Path: A',}},
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs={ name="Mpaca's Hose", augments={'Path: A',}},
		feet="Nyame Sollerets",
		neck={ name="Pup. Collar +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		ear1="Schere Earring",
		ear2="Moonshade Earring",
		ring1="Niqmaddu Ring",
		ring2="Gere Ring",
		back=Visucius.master,
	})
	
	sets.precast.WS["Raging Fists"] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS["Evisceration"] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS["Aeolian Edge"] = set_combine(sets.precast.WS, {})
	
	-------------------------------------Pet WS
    --[[
        WSNoFTP is the default weaponskill set used
    ]]
	-- PUP - Valoredge WS set FTP off--
	
    sets.midcast.Pet.WSNoFTP = {
		head="Taeon Chapeau", --Double Attack +5%
		body="Taeon Tabard", --Double Attack +5%
		hands="Mpaca's Gloves", --Weaponskill Damage +10%
		legs="Taeon Tights", --Double Attack +5%
		feet="Mpaca's Boots", --Automation +1
		neck="Shulmanu Collar", --Double Attack +5%
		waist="Incarnation Sash", --Double Attack +4%
		ear1="Kyrene's Earring", --Double Attack +3%
		ear2="Domes. Earring", --Double Attack +3%
		ring1="Thur. Ring +1", --Attack +23
		ring2="C. Palug Ring", --Double Attack +5%
		back=Visucius.haste, --Accuracy +30 & Attack +20
}

    --[[
        If we have a pet weaponskill that can benefit from WSFTP
        then this set will be equipped
    ]]
	-- PUP - Sharpshot WS set FTP on --
	
    sets.midcast.Pet.WSFTP = {
		head=Empy_Karagoz.Head, --TP Bonus +575
		body=Relic_Pitre.Body, --Ranged Attack +60
		hands="Mpaca's Gloves", --Weaponskill Damage +10%
		legs=Empy_Karagoz.Legs, --Skill +28
		feet="Mpaca's Boots", --Automation +1
		neck="Shulmanu Collar", --Accuracy +20 Attack +20
		waist="Klouskap Sash +1", --Ranged Accuracy +20
		ear1="Burana Earring", --Ranged Attack +15
		ear2=Empy_Karagoz.Ear, --Automation +1
		ring1="Thur. Ring +1", --Ranged Accuracy +20 Ranged Attack +23
		ring2="Overbearing Ring", --Ranged Accuracy +12
		back=Dispersal.TP --TP Bonus +500
	}

    --[[
        Base Weapon Skill Set
        Used by default if no modifier is found
    ]]
	
    sets.midcast.Pet.WS = set_combine(sets.midcast.Pet.WSNoFTP, {})

    --Chimera Ripper, String Clipper
    sets.midcast.Pet.WS["STR"] = set_combine(sets.midcast.Pet.WSNoFTP, {})

    -- Bone crusher, String Shredder
    sets.midcast.Pet.WS["VIT"] = set_combine(sets.midcast.Pet.WSNoFTP, {})

    -- Cannibal Blade
    sets.midcast.Pet.WS["MND"] = set_combine(sets.midcast.Pet.WSNoFTP, {})

    -- Armor Piercer, Armor Shatterer
    sets.midcast.Pet.WS["DEX"] = set_combine(sets.midcast.Pet.WSNoFTP, {})

    -- Arcuballista, Daze
    sets.midcast.Pet.WS["DEXFTP"] = set_combine(sets.midcast.Pet.WSFTP, {})

    ---------------------------------------------
    --  __  __ _             _____      _
    -- |  \/  (_)           / ____|    | |
    -- | \  / |_ ___  ___  | (___   ___| |_ ___
    -- | |\/| | / __|/ __|  \___ \ / _ \ __/ __|
    -- | |  | | \__ \ (__   ____) |  __/ |_\__ \
    -- |_|  |_|_|___/\___| |_____/ \___|\__|___/
    ---------------------------------------------
	
    -- Town Set
    --[[sets.idle.Town = {
		legs = "Desultor Tassets", --Movement speed +8%
		feet = "Hermes' Sandals" --Movement speed +12%
    --]]

    -- Resting sets
    sets.resting = {
       -- Add your set here
    }
	
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(10, 1)
end
