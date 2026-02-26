include('organizer-lib')
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
	
	degrade_array = {
		['BlueAoE'] = {'Jettatura','Soporific','Sheep Song','Geist Wall'}
		}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'hybrid', 'hptank', 'purehp')
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT', 'HP', 'Reraise', 'Charm')
    state.MagicalDefenseMode:options('MDT', 'HP', 'Reraise', 'Charm')
    
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'MP', 'Knockback', 'MP_Knockback'}
    state.EquipShield = M(false, 'Equip Shield w/Defense')

    update_defense_mode()
    
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
    send_command('bind @f10 gs c toggle EquipShield')
    send_command('bind @f11 gs c toggle EquipShield')
	send_command('bind ^numpad1 input /ws "Atonement" <t>')
	send_command('bind ^numpad2 input /ws "Swift Blade" <t>')
	send_command('bind ^numpad3 input /ws "Flat Blade" <t>')
	send_command('bind ^numpad4 input /ws "Savage Blade" <t>')
	send_command('bind ^numpad5 input /ws "Knights of Round" <t>')
	send_command('bind ^numpad6 input /ws "Chant du Cygne" <t>')
	send_command('bind ^numpad7 input /ws "Seraph Blade" <t>')
	send_command('bind ^numpad8 input /ws "Sanguine Blade" <t>')
	send_command('bind ^numpad9 input /ws "Requiescat" <t>')
	send_command('bind ^numpad0 input /ja "Berserk" <me>')
	send_command('bind ^numpadenter input /ws "Imperator" <t>')
	send_command('bind !numpad7 input /ws "Herculean Slash" <t>')
	send_command('bind !numpad5 input /ws "Resolution" <t>')
	send_command('bind !numpad4 input /ws "Torcleaver" <t>')
	send_command('bind !numpad8 input /ws "Fimbulvetr" <t>')
	send_command('bind !numpad6 input /ws "Spinning Slash" <t>')

    select_default_macro_book()
end

function user_unload()
    send_command('unbind ^f11')
    send_command('unbind !f11')
    send_command('unbind @f10')
    send_command('unbind @f11')
	send_command('unbind ^numpad1')
	send_command('unbind ^numpad2')
	send_command('unbind ^numpad3')
	send_command('unbind ^numpad4')
	send_command('unbind ^numpad5')
	send_command('unbind ^numpad6')
	send_command('unbind ^numpad7')
	send_command('unbind ^numpad8')
	send_command('unbind ^numpad9')
	send_command('unbind ^numpad0')
	send_command('unbind ^numpadenter')
	send_command('unbind !numpad7')
	send_command('unbind !numpad5')
	send_command('unbind !numpad4')
	send_command('unbind !numpad6')
	send_command('unbind !numpad8')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets to enhance JAs
	sets.precast.JA['Provoke'] =
{	--range="kaja bow",
	ammo="Sapience Orb",
    head="Loess Barbuta +1",priority=105,
    body="Souv. Cuirass +1",priority=171,
    hands="Caballarius Gauntlets +3",priority=124,
    legs="Caballarius Breeches +3",priority=72,
    feet="Eschite greaves",priority=98,
    neck="Moonbeam Necklace",
    waist="Goading Belt",
    ear1="Cryptic Earring",priority=40,
    ear2="Tuisto Earring",priority=150,--"Trux Earring",
    ring1="Apeile Ring", --"Pernicious Ring",
    ring2="Apeile Ring +1", --"Supershear Ring",
    back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}},priority=80,
}	
	
    sets.precast.JA['Invincible'] = set_combine(sets.precast.JA['Provoke'], {legs="Cab. Breeches +3",})
	
	sets.precast.JA['Palisade'] = set_combine(sets.precast.JA['Provoke'], {})
   
    sets.precast.JA['Holy Circle'] = set_combine(sets.precast.JA['Provoke'], {feet="Rev. Leggings +2"})
         
    sets.precast.JA['Shield Bash'] = set_combine(sets.precast.JA['Provoke'], {hands="Cab. Gauntlets +3"})
     
    sets.precast.JA['Intervene'] = sets.precast.JA['Shield Bash']
    
    sets.precast.JA['Sentinel'] = set_combine(sets.precast.JA['Rampart'], {feet="Cab. Leggings +3"})   
     
    --The amount of damage absorbed is variable, determined by VIT*2
    sets.precast.JA['Rampart'] = {
	--range="kaja bow",
    head="Caballarius Coronet +1",
    body="Sakpata's breastplate",
    hands="Sakpata's gauntlets",
    legs="Sakpata's cuisses",
    feet="Sakpata's leggings",
    neck="Unmoving Collar +1",
    waist="Goading Belt",
    ear1="Cryptic Earring",
    ear2="Tuisto Earring",
    ring1="Apeile Ring",
    ring2="Supershear Ring",
    back="Weard Mantle",
}

    sets.precast.JA['Fealty'] = set_combine(sets.precast.JA['Provoke'], {body="Cab. Surcoat +3",})
     
    sets.precast.JA['Divine Emblem'] = set_combine(sets.precast.JA['Provoke'], {feet="Chevalier's Sabaton's +2",})
	
	sets.precast.JA['Majesty'] = set_combine(sets.precast.JA['Provoke'], {})
     
    --15 + min(max(floor((user VIT + user MND - target VIT*2)/4),0),15)
    sets.precast.JA['Cover'] = set_combine(sets.precast.JA['Rampart'], {
	head="Rev. Coronet +2", 
	body="Cab. Surcoat +3",})

    -- add MND for Chivalry
    sets.precast.JA['Chivalry'] = {hands="Cab. Gauntlets +3",}
	
	
     
    ------------------------ Sub WAR ------------------------ 
	
 
    sets.precast.JA['Warcry'] = sets.precast.JA['Provoke'] 
     
    sets.precast.JA['Defender'] = sets.precast.JA['Provoke']
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Step = {waist="Chaac Belt"}
    sets.precast.Flourish1 = {waist="Chaac Belt"}

    -- Fast cast sets for spells, Caps at 80%
    
    sets.precast.FC = {
	--range="Ullr",
	ammo="Sapience Orb", --2%
    head="Carmine Mask +1", --14% total FC
    body={ name="Odyss. Chestplate", augments={'Pet: DEX+6','"Triple Atk."+1','"Fast Cast"+7','Mag. Acc.+17 "Mag.Atk.Bns."+17',}}, --{name="Rev. Surcoat +2", priority=9}, --5%  Could bump this to 10% by +3'ing body, or swap to Odyssean body with FC aug for 12%
    hands="Odyssean gauntlets", --5% aug
    legs="Eschite Cuisses", --5% aug
    feet={name="Chevalier's Sabatons +2", priority=8},--10%
    neck="Voltsurge Torque", --4%
    waist={name="Platinum Moogle Belt", priority=10}, --Solely for the sake of bumping HP
    left_ear="Loquacious Earring", --2%
    right_ear={name="Etiolation Earring", priority=7}, --1% but good HP boost
    left_ring="Kishar Ring", --4%  --"Defending Ring",
    right_ring="Prolix Ring", --"Weatherspoon Ring", --2%
    --back={ name="Rudianos's Mantle", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10',}},
	}
	
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
	
    sets.precast.WS = {
	--range="kaja bow",
    ammo="Oshasha's Treatise", --"Coiste Bodhar",
    head="Nyame Helm", --"Sakpata's Helm",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Nyame sollerets", --"Sulev. Leggings +2",
    neck="Republican Platinum Medal",
    waist="Sailfi Belt +1",
    left_ear="Moonshade Earring",
    right_ear="Thrud Earring",
    left_ring="Ephramad's Ring", --"Regal Ring", --"Rufescent Ring",
    right_ring="Epaminondas's Ring",
    back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
	
	
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {})
	
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		})
    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
		ammo="Coiste Bodhar",
		head="Blistering Sallet +1", --"Flam. Zucchetto +2",
		body="Dagon Breastplate", --"Sakpata's Plate",
		hands="Flamma manopolas +2", --"Sakpata's Gauntlets",
		legs="Sulevia's Cuisses +2", --"Valorous Hose",
		feet="Thereoid greaves", --"Sulev. Leggings +2",
		neck="Fotia Gorget",
		waist="Fotia Belt", --"Grunfeld Rope",
		left_ear="Lugra Earring +1",
		right_ear="Mache Earring +1",
		back={ name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
		})
	
	sets.precast.WS['Vorpal Blade'] = sets.precast.WS['Chant du Cygne']
	
	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {
		ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",
		neck="Sibyl Scarf",
		waist="Orpheus's Sash", --"Eschan Stone",
		left_ear="Crematio Earring",
		right_ear="Friomisi Earring",
		left_ring="Metamorph Ring +1", --"Rufescent Ring",
		right_ring="Epaminondas's Ring",
		back="Izdubar Mantle",
		})
		
	sets.precast.WS['Seraph Blade'] = set_combine(sets.precast.WS, {
		ammo="Pemphredo Tathlum",
		neck="Sibyl Scarf",
		waist="Orpheus's Sash", --"Eschan Stone",
		left_ear="Crematio Earring",
		right_ear="Friomisi Earring",
		left_ring="Weatherspoon Ring", --"Rufescent Ring",
		right_ring="Epaminondas's Ring",
		back="Izdubar Mantle",
		})
	
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
		ammo="Pemphredo Tathlum",
		head="Nyame Helm",
		body="Nyame mail",
		hands="Nyame Gauntlets",
		legs="Nyame flanchard",
		feet="Nyame sollerets",
		neck="Sibyl Scarf",
		waist="Orpheus's Sash", --"Eschan Stone",
		left_ear="Crematio Earring",
		right_ear="Friomisi Earring",
		left_ring="Regal Ring", --"Rufescent Ring",
		right_ring="Epaminondas's Ring",
		back="Izdubar Mantle",
		})
	
	sets.precast.WS['Torcleaver'] = set_combine(sets.precast.WS, {
		right_ring="Regal Ring",
		})
		
	sets.precast.WS['Fimbulvetr'] = set_combine(sets.precast.WS, {
		})
		
	sets.precast.WS['Imperator'] = set_combine(sets.precast.WS, {
		neck="Fotia Gorget",
		back={ name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
		})
	
	
    
    sets.precast.WS['Atonement'] = {sets.precast.JA['Provoke']}
	--sets.precast.WS['Atonement'] = {
		--head="Nyame Helm",
		--body="Nyame mail",
		--hands="Nyame gauntlets",
		--legs="Nyame flanchard",
		--feet="Nyame sollerets",
		--neck="Fotia Gorget",
		--waist="Fotia Belt",
		--ring1="Epaminondas's Ring",
		--ear1="Thrud Earring",
		--ear2="Ishvara Earring",
		--back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
		--}
    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
	--SIRD set with some FC remains
    --range="kaja bow",
    ammo="Staunch Tathlum +1",
    head="Souv. Schaller +1",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Founder's Hose",
    feet="Odyssean Greaves",
    neck="Moonbeam Necklace",
    waist="Audumbla Sash",
    left_ear="Loquac. Earring",
    right_ear="Etiolation Earring",
    left_ring="Defending Ring",
    right_ring="Prolix Ring",
    back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}},
	}
	
    sets.midcast.Enmity = {
	--range="kaja bow",
    ammo="Staunch Tathlum +1",
    head="Souv. Schaller +1",
    body="Souveran cuirass +1",
    hands="Caballarius Gauntlets +3",
    legs="Founder's Hose",
    feet="Odyssean Greaves",
    neck="Moonbeam Necklace",
    waist="Audumbla Sash",
    left_ear="Cryptic Earring",
    right_ear="Friomisi Earring",
    left_ring="Defending Ring",
    right_ring="Supershear Ring",
    back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}},
	}

    sets.midcast.Flash = {sets.midcast.Enmity}
    
    sets.midcast.Stun = {sets.midcast.Flash}
    
    sets.midcast.Cure = {
	--SIRD set, Cure Received caps at 30%, Cure Potency caps at 50%
	--range="kaja bow",
    ammo="Staunch Tathlum +1", --11% SIRD
    head="Souv. Schaller +1", --20% SIRD, 15% Cure received
    body="Souveran cuirass +1", --15% Cure received, 11% Potency
    hands="Macabre Gauntlets +1", --11% Potency
    legs="Founder's Hose", --30% SIRD
    feet="Odyssean Greaves", --20% SIRD, 7%/6% Potency
    neck="Moonbeam Necklace", --10% SIRD
    waist="Audumbla Sash", --10% SIRD
    left_ear="Mendicant's Earring", --5% Potency
    right_ear="Chevalier's Earring +1", --11% Potency 
    left_ring="Defending Ring",
    right_ring="Moonbeam Ring",
    back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}},
	--Current stats in this setup, 101% SIRD, 30% Cure Received, 51% Potency, 49% PDT
	}
	
	sets.midcast['Stoneskin'] = {
		ammo="Staunch Tathlum +1", --11% SIRD
		head="Souv. Schaller +1", --20% SIRD, 15% Cure received
		body="Sakpata's breastplate", --"Souveran cuirass +1", --15% Cure received, 11% Potency
		hands="Sakpata's Gauntlets", --"Macabre Gauntlets +1", --11% Potency
		legs="Haven hose",
		feet="Odyssean Greaves", --20% SIRD, 7%/6% Potency
		neck="Stone Gorget", --"Moonbeam Necklace", --10% SIRD
		waist="Siegel Sash", --"Audumbla Sash", --10% SIRD
		left_ear="Mendicant's Earring", --5% Potency
		right_ear="Earthcry Earring",
		left_ring="Defending Ring",
		right_ring="Moonbeam Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}},
		}

    sets.midcast['Enhancing Magic'] = {
	--range="kaja bow",
    ammo="Staunch Tathlum +1",
    head="Souv. Schaller +1",
    body="Shabti Cuirass",
    hands="Sakpata's Gauntlets",
    legs="Founder's Hose",
    feet="Odyssean Greaves",
    neck="Moonbeam Necklace",
    waist="Audumbla Sash",
    left_ear="Andoaa Earring",
    right_ear="Tuisto Earring",
    left_ring="Defending Ring",
    right_ring="Moonbeam Ring",
    back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}},
	}
	
	sets.midcast['Protect V'] = {
	--range="kaja bow",
    ammo="Staunch Tathlum +1",
    head="Souv. Schaller +1",
    body="Shabti Cuirass",
    hands="Sakpata's Gauntlets",
    legs="Founder's Hose",
    feet="Odyssean Greaves",
    neck="Moonbeam Necklace",
    waist="Audumbla Sash",
    left_ear="Andoaa Earring",
    right_ear="Tuisto Earring",
    left_ring="Defending Ring",
    right_ring="Moonbeam Ring",
    back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}},
	}
	
	sets.midcast['Enhancing Magic']['Phalanx'] = {
	--range="Kaja Bow",
    ammo="Staunch Tathlum +1",
    head="Odyssean Helm", --"Yorium Barbuta",
    body="Yorium Cuirass",
    hands="Souveran handschuhs",
    legs="Sakpata's cuisses",
    feet="Souveran schuhs +1",
    neck="Moonbeam Necklace",
    waist="Audumbla Sash",
    left_ear="Andoaa Earring",
    right_ear="Tuisto Earring",
    left_ring="Defending Ring",
    right_ring="Moonbeam Ring",
    back="Weard Mantle",
	}
	
	sets.midcast['Enhancing Magic']['Reprisal'] = {
	--range="Kaja Bow",
    ammo="Staunch Tathlum +1",
    head="Souv. Schaller +1",
    body="Shabti Cuirass",
    hands="Sakpata's Gauntlets",
    legs="Founder's Hose",
    feet="Odyssean Greaves",
    neck="Moonbeam Necklace",
    waist="Audumbla Sash",
    left_ear="Andoaa Earring",
    right_ear="Tuisto Earring",
    left_ring="Defending Ring",
    right_ring="Moonbeam Ring",
    back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}},
	}
	
	sets.midcast['Divine Magic'] = {
	--range="Ullr",
    ammo="Staunch Tathlum +1",
    head="Souv. Schaller +1",
    body="Sakpata's Breastplate",
    hands="Sakpata's Gauntlets",
    legs="Founder's Hose",
    feet="Odyssean Greaves",
    neck="Moonbeam Necklace",
    waist="Audumbla Sash",
    left_ear="Beatific Earring",
    right_ear="Tuisto Earring",
    left_ring="Defending Ring",
    right_ring="Moonbeam Ring",
    back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}},
	}
	
	sets.midcast['Holy'] = {
	ammo="Pemphredo Tathlum",
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    left_ear="Friomisi Earring",
    right_ear="Digni. Earring",
    left_ring="Stikini Ring",
    right_ring="Weatherspoon Ring",
    back="Izdubar Mantle",
	}
	
	sets.midcast['Holy II'] = {
	ammo="Pemphredo Tathlum",
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    left_ear="Friomisi Earring",
    right_ear="Hermetic Earring",
    left_ring="Stikini Ring",
    right_ring="Weatherspoon Ring",
    back="Izdubar Mantle",
	}
	
	sets.midcast['Banish'] = {
	ammo="Pemphredo Tathlum",
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    left_ear="Friomisi Earring",
    right_ear="Digni. Earring",
    left_ring="Stikini Ring",
    right_ring="Weatherspoon Ring",
    back="Izdubar Mantle",
	}

	sets.midcast['Banish II'] = {
	ammo="Pemphredo Tathlum",
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    left_ear="Friomisi Earring",
    right_ear="Digni. Earring",
    left_ring="Stikini Ring",
    right_ring="Weatherspoon Ring",
    back="Izdubar Mantle",
	}

	sets.midcast['Banishga'] = {
	ammo="Pemphredo Tathlum",
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    left_ear="Friomisi Earring",
    right_ear="Digni. Earring",
    left_ring="Stikini Ring",
    right_ring="Weatherspoon Ring",
    back="Izdubar Mantle",
	}

    
    sets.midcast.Protect = {ring1="Sheltered Ring"}
    sets.midcast.Shell = {ring1="Sheltered Ring"}
	
	---------- BLU Spell	--------------
	
    sets.midcast['Geist Wall'] ={
	--range="Ullr",
    ammo="Staunch Tathlum +1",
    head="Souv. Schaller +1",
    body="Souveran cuirass +1",
    hands="Caballarius Gauntlets +3",
    legs="Founder's Hose",
    feet="Odyssean Greaves",
    neck="Moonbeam Necklace",
    waist="Audumbla Sash",
    left_ear="Cryptic Earring",
    right_ear="Friomisi Earring",
    left_ring="Defending Ring",
    right_ring="Supershear Ring",
    back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}},
	}
	

    sets.midcast['Jettatura'] ={
	--range="Ullr",
    ammo="Staunch Tathlum +1",
    head="Souv. Schaller +1",
    body="Souveran cuirass +1",
    hands="Caballarius Gauntlets +3",
    legs="Founder's Hose",
    feet="Odyssean Greaves",
    neck="Moonbeam Necklace",
    waist="Audumbla Sash",
    left_ear="Cryptic Earring",
    right_ear="Friomisi Earring",
    left_ring="Defending Ring",
    right_ring="Supershear Ring",
    back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}},
	}

	
	sets.midcast['Blank Gaze'] ={
	--range="Ullr",
    ammo="Staunch Tathlum +1",
    head="Souv. Schaller +1",
    body="Souveran cuirass +1",
    hands="Caballarius Gauntlets +3",
    legs="Founder's Hose",
    feet="Odyssean Greaves",
    neck="Moonbeam Necklace",
    waist="Audumbla Sash",
    left_ear="Cryptic Earring",
    right_ear="Friomisi Earring",
    left_ring="Defending Ring",
    right_ring="Supershear Ring",
    back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}},
	}

	
	sets.midcast['Soporific'] ={
	--range="Ullr",
    ammo="Staunch Tathlum +1",
    head="Souv. Schaller +1",
    body="Souveran cuirass +1",
    hands="Caballarius Gauntlets +3",
    legs="Founder's Hose",
    feet="Odyssean Greaves",
    neck="Moonbeam Necklace",
    waist="Audumbla Sash",
    left_ear="Cryptic Earring",
    right_ear="Friomisi Earring",
    left_ring="Defending Ring",
    right_ring="Supershear Ring",
    back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}},
	}
	
	
	sets.midcast['Sheep Song'] ={
	--range="Ullr",
    ammo="Staunch Tathlum +1",
    head="Souv. Schaller +1",
    body="Souveran cuirass +1",
    hands="Caballarius Gauntlets +3",
    legs="Founder's Hose",
    feet="Odyssean Greaves",
    neck="Moonbeam Necklace",
    waist="Audumbla Sash",
    left_ear="Cryptic Earring",
    right_ear="Friomisi Earring",
    left_ring="Defending Ring",
    right_ring="Supershear Ring",
    back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}},
	}

    
	sets.midcast['Cocoon'] ={
	--range="Ullr",
    ammo="Staunch Tathlum +1",
    head="Souv. Schaller +1",
    body="Souveran cuirass +1",
    hands="Caballarius Gauntlets +3",
    legs="Founder's Hose",
    feet="Odyssean Greaves",
    neck="Moonbeam Necklace",
    waist="Audumbla Sash",
    left_ear="Cryptic Earring",
    right_ear="Friomisi Earring",
    left_ring="Defending Ring",
    right_ring="Supershear Ring",
    back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}},
	}

    
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    sets.Reraise = {head="Twilight Helm", body="Twilight Mail"}
    
    sets.resting = set_combine(sets.idle,{})
    

    -- Idle sets
    sets.idle = {
		--range="Ullr",
		ammo="Staunch Tathlum +1", --"Coiste Bodhar", 
		head="Nyame Helm", --"Sakpata's Helm",
		body="Nyame Mail", --"Sakpata's Plate",
		hands="Nyame Gauntlets", --"Sakpata's Gauntlets",
		legs="Nyame Flanchard", --"Sakpata's Cuisses",
		feet="Nyame Sollerets", --"Sakpata's Leggings",
		neck="Warder's Charm +1", --"Sanctity Necklace",
		waist="Carrier's Sash", --"Sailfi Belt +1",
		left_ear="Odnowa Earring +1",
		right_ear="Tuisto Earring",
		left_ring="Shneddick Ring", --"Chirich Ring +1",
		right_ring="Moonbeam Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}},
	}
		sets.idle.Town = {
		--range="Ullr",
		--head={ name="Jumalik Helm", augments={'MND+10','"Mag.Atk.Bns."+15','Magic burst dmg.+10%','"Refresh"+1',}},
		--body={ name="Souv. Cuirass +1", augments={'VIT+12','Attack+25','"Refresh"+3',}},
		--hands="Regal Gauntlets",
		--legs="Carmine Cuisses +1",
		--feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		--neck={ name="Kgt. Beads +2", augments={'Path: A',}},
		--waist="Audumbla Sash",
		--left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		--right_ear="Etiolation Earring",
		--right_ring="Moonlight Ring",
		left_ring="Shneddick Ring", --"Stikini Ring +1",
		--back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Mag. Evasion+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
    
    sets.idle.Weak = {
		--range="kaja bow",
		head="Nyame Helm", --"twilight helm",
		body="Nyame mail", --"twilight mail",
		hands="Nyame Gauntlets", --"Regal Gauntlets",
		legs="Nyame flanchard", --"Carmine Cuisses +1",
		feet="Nyame sollerets", --"Souveran Schuhs +1",
		neck="Sanctity Necklace", --"Kgt. Beads +2",
		waist="Carrier's Sash", --"Flume Belt +1",
		left_ear="Odnowa Earring +1",
		right_ear="Tuisto earring",
		left_ring="Moonlight Ring",
		right_ring="Moonbeam Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Mag. Evasion+10','"Store TP"+10','Phys. dmg. taken-10%',}},
		}
    
    sets.idle.Weak.Reraise = set_combine(sets.idle.Weak, sets.Reraise)
    
    sets.Kiting = {ring1="Shneddick ring"} --legs="Carmine Cuisses +1",}

    sets.latent_refresh = {body={ name="Souv. Cuirass +1", augments={'VIT+12','Attack+25','"Refresh"+3',}},neck="Creed Collar",waist="Fucho-no-obi"}


    --------------------------------------
    -- Defense sets
    --------------------------------------
    
    -- Extra defense sets.  Apply these on top of melee or defense sets.
    sets.Knockback = {legs="dashing subligar",left_ring="vocane earring",back="repulse mantle",}
    
    -- If EquipShield toggle is on (Win+F10 or Win+F11), equip the weapon/shield combos here
    -- when activating or changing defense mode:
    sets.PhysicalShield = {} -- Ochain
    sets.MagicalShield = {} -- Aegis

    -- Basic defense sets.
        
    sets.defense.PDT = {
	 range="kaja bow",
    head="Hjarrandi Helm",
    body="Hjarrandi Breast.",
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck={ name="Kgt. Beads +2", augments={'Path: A',}},
    waist="Audumbla Sash",
    left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    right_ear="etiolation earring",
    left_ring="Moonlight Ring",
    right_ring="Moonlight Ring",
    back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Mag. Evasion+10','"Store TP"+10','Phys. dmg. taken-10%',}},}
	
    sets.defense.HP = {
	 range="kaja bow",
    head="Hjarrandi Helm",
    body="Hjarrandi Breast.",
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck={ name="Kgt. Beads +2", augments={'Path: A',}},
    waist="Audumbla Sash",
    left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    right_ear="etiolation earring",
    left_ring="Moonlight Ring",
    right_ring="Moonlight Ring",
    back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Mag. Evasion+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
    sets.defense.Reraise = {
	 range="kaja bow",
    head="twilight helm",
    body="twilight mail",
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck={ name="Kgt. Beads +2", augments={'Path: A',}},
    waist="Audumbla Sash",
    left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    right_ear="etiolation earring",
    left_ring="vocane Ring",
    right_ring="defending Ring",
    back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Mag. Evasion+10','"Store TP"+10','Phys. dmg. taken-10%',}},}
	
    sets.defense.Charm = {
	 range="kaja bow",
    head="Hjarrandi Helm",
    body="Hjarrandi Breast.",
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck={ name="Kgt. Beads +2", augments={'Path: A',}},
    waist="Audumbla Sash",
    left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    right_ear="etiolation earring",
    left_ring="Moonlight Ring",
    right_ring="Moonlight Ring",
    back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Mag. Evasion+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
    -- To cap MDT with Shell IV (52/256), need 76/256 in gear.
    -- Shellra V can provide 75/256, which would need another 53/256 in gear.
    sets.defense.MDT = {
		--range="kaja bow",
		--head="Hjarrandi Helm",
		--body="Hjarrandi Breast.",
		--hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		--legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		--feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		--neck={ name="Kgt. Beads +2", augments={'Path: A',}},
		waist="Carrier's Sash",
		--left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		--right_ear="etiolation earring",
		--left_ring="Moonlight Ring",
		--right_ring="Moonlight Ring",
		--back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Mag. Evasion+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}


    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
    sets.engaged = {
	--range="kaja bow",
    ammo="Coiste Bodhar",
    head="Flam. Zucchetto +2",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Flam. Gambieras +2",
    neck="Vim Torque +1", --"Sanctity Necklace",
    waist="Sailfi Belt +1",
    left_ear="Cessance Earring",
    right_ear="Dedition Earring", --"Brutal Earring",
    left_ring="Chirich Ring +1",
    right_ring="Flamma Ring",
    back={ name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

    sets.engaged.hybrid = {
	--range="kaja bow",
    ammo="Coiste Bodhar",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck="Vim Torque +1", --"Sanctity Necklace",
    waist="Sailfi Belt +1",
    left_ear="Cessance Earring",
    right_ear="Digni. Earring",
    left_ring="Chirich Ring +1",
    right_ring="Chirich Ring",
    back={ name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
    sets.engaged.hptank = {
	--range="kaja bow",
    ammo="Coiste Bodhar", 
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Chevalier's Cuisses +3", --"Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck="Sanctity Necklace",
    waist="Sailfi Belt +1",
    left_ear="Odnowa Earring +1",
    right_ear="Tuisto Earring",
    left_ring="Chirich Ring +1",
    right_ring="Moonbeam Ring",
    back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}},
	}
	
	sets.engaged.purehp = {
	ammo="Staunch Tathlum +1",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body="Rev. Surcoat +2",
    hands={ name="Souv. Handschuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    legs="Arke Cosciales",
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck="Sanctity Necklace",
    waist="Platinum Moogle Belt",
    left_ear="Odnowa Earring +1",
    right_ear="Tuisto Earring",
    left_ring="Etana Ring",
    right_ring="Moonbeam Ring",
    back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}},
	}
	

    --sets.engaged.DW = {
	--range="kaja bow",
    --ammo="Coiste Bodhar",
    --head="Flam. Zucchetto +2",
    --body="Sakpata's Plate",
    --hands="Sakpata's Gauntlets",
    --legs="Sulev. Cuisses +2",
    --feet="Flam. Gambieras +2",
    --neck="Sanctity Necklace",
    --waist="Sailfi Belt +1",
    --left_ear="Cessance Earring",
    --right_ear="Dedition Earring",
    --left_ring="Flamma Ring",
    --right_ring="Chirich Ring",
    --back={ name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	--}

    --sets.engaged.DW.Acc = {
	--range="kaja bow",
	--head={ name="Valorous Mask", augments={'Accuracy+29','"Store TP"+4','Attack+9',}},
	--body="Hjarrandi Breast.",
	--hands="Sulev. Gauntlets +2",
	--legs={ name="Valor. Hose", augments={'Accuracy+17 Attack+17','"Store TP"+7','DEX+10','Accuracy+7',}},
	--feet="Flam. Gambieras +2",
	--neck={ name="Kgt. Beads +2", augments={'Path: A',}},
	--waist={ name="Sailfi Belt +1", augments={'Path: A',}},
	--left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
	--right_ear="Telos Earring",
	--left_ring="Moonlight Ring",
	--right_ring="Defending Ring",
	--back={ name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	--}

    sets.engaged.PDT = set_combine(sets.engaged, {})
	
    --sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {})
    sets.engaged.Reraise = set_combine(sets.engaged, sets.Reraise)
    --sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc, sets.Reraise)



    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Doom = {}
    sets.buff.Cover = {head="Reverence Coronet +2", body="Cab. Surcoat +3"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_precast(spell, action, spellMap, eventArgs)
	if spell.name:startswith('Geist') then
		refine_various_spells(spell, action, spellMap, eventArgs)
	end
end

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

function refine_various_spells(spell, action, spellMap, eventArgs)

    BlueAoE = S{'Jettatura','Soporific','Sheep Song','Geist Wall'}
    
    spell_recasts = windower.ffxi.get_spell_recasts()
    
    -- if spell is on cooldown, get next spell from array
    if spell_recasts[spell.recast_id] > 0 then
        if BlueAoE:contains(spell.name) then
            spell_index = table.find(degrade_array['BlueAoE'],spell.name)
            -- keep getting next spell if previous spells are on CD
            while spell_index > 1 do
                spell_index = spell_index - 1
                newSpellName = degrade_array['BlueAoE'][spell_index]
                newSpell = gearswap.res.spells:with('en', newSpellName) -- get spell info from resources
                newSpellRecast = spell_recasts[newSpell.recast_id]
                if newSpellRecast == 0 then
                    send_command('@input /ma "'..newSpellName..'" '..tostring(spell.target.raw))
                    eventArgs.cancel = true
                    return
                end
            end
            add_to_chat(123, 'Spells on CD')
        end
    end
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_defense_mode()
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    --if player.mpp < 51 then
    --    idleSet = set_combine(idleSet, sets.latent_refresh)
    --end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    
    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    
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
    if player.equipment.main == 'Kheshig Blade' and not classes.CustomDefenseGroups:contains('Kheshig Blade') then
        classes.CustomDefenseGroups:append('Kheshig Blade')
    end
    
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        if player.equipment.sub and not player.equipment.sub:contains('Shield') and
           player.equipment.sub ~= 'Aegis' and player.equipment.sub ~= 'Ochain' then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'BLU' then
        set_macro_page(3, 1)
    elseif player.sub_job == 'RUN' then
        set_macro_page(4, 1)
    elseif player.sub_job == 'RDM' then
        set_macro_page(4, 1)
    else
        set_macro_page(4, 1)
    end
end

