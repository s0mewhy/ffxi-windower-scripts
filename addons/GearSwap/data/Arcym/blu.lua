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
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
    state.Buff.Convergence = buffactive.Convergence or false
    state.Buff.Diffusion = buffactive.Diffusion or false
    state.Buff.Efflux = buffactive.Efflux or false
    
    state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false


    blue_magic_maps = {}
    
    -- Mappings for gear sets to use for various blue magic spells.
    -- While Str isn't listed for each, it's generally assumed as being at least
    -- moderately signficant, even for spells with other mods.
    
    -- Physical Spells --
    
    -- Physical spells with no particular (or known) stat mods
    blue_magic_maps.Physical = S{
        'Bilgestorm'
    }

    -- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
    blue_magic_maps.PhysicalAcc = S{
        'Heavy Strike'
    }

    -- Physical spells with Str stat mod
    blue_magic_maps.PhysicalStr = S{
        'Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
        'Empty Thrash','Quadrastrike','Sinker Drill','Spinal Cleave',
        'Uppercut','Vertical Cleave'
    }
        
    -- Physical spells with Dex stat mod
    blue_magic_maps.PhysicalDex = S{
        'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone','Disseverment',
        'Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
        'Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault',
        'Vanity Dive'
    }
        
    -- Physical spells with Vit stat mod
    blue_magic_maps.PhysicalVit = S{
        'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
        'Power Attack','Quad. Continuum','Saurian Slide','Sprout Smack','Sub-zero Smash',
		'Sweeping Gouge'
    }
        
    -- Physical spells with Agi stat mod
    blue_magic_maps.PhysicalAgi = S{
        'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
        'Pinecone Bomb','Spiral Spin','Wild Oats'
    }

    -- Physical spells with Int stat mod
    blue_magic_maps.PhysicalInt = S{
        'Mandibular Bite','Queasyshroom'
    }

    -- Physical spells with Mnd stat mod
    blue_magic_maps.PhysicalMnd = S{
        'Ram Charge','Screwdriver','Tourbillion'
    }

    -- Physical spells with Chr stat mod
    blue_magic_maps.PhysicalChr = S{
        'Bludgeon'
    }

    -- Physical spells with HP stat mod
    blue_magic_maps.PhysicalHP = S{
        'Final Sting'
    }

    -- Magical Spells --

    -- Magical spells with the typical Int mod
    blue_magic_maps.Magical = S{
        'Blastbomb','Blazing Bound','Bomb Toss','Cursed Sphere','Dark Orb','Death Ray',
        'Diffusion Ray','Droning Whirlwind','Embalming Earth','Firespit','Foul Waters',
        'Ice Break','Leafstorm','Maelstrom','Rail Cannon','Regurgitation','Rending Deluge',
        'Retinal Glare','Spectral Floe','Subduction','Tem. Upheaval','Water Bomb'
    }

    -- Magical spells with a primary Mnd mod
    blue_magic_maps.MagicalMnd = S{
        'Acrid Stream','Evryone. Grudge','Magic Hammer','Mind Blast','Nectarous Deluge',
		'Scouring Spate'
    }

    -- Magical spells with a primary Chr mod
    blue_magic_maps.MagicalChr = S{
        'Eyes On Me','Mysterious Light'
    }

    -- Magical spells with a Vit stat mod (on top of Int)
    blue_magic_maps.MagicalVit = S{
        'Atra. Libations','Entomb','Thermal Pulse'
    }
	
	blue_magic_maps.MagicalAgi = S{'Molting Plumage','Palling Salvo','Silent Storm'}
	
	blue_magic_maps.MagicalStr = S{'Blinding Fulgor','Searing Tempest'}
	
    -- Magical spells with a Dex stat mod (on top of Int)
    blue_magic_maps.MagicalDex = S{
        'Anvil Lightning','Charged Whisker','Gates of Hades'
    }
            
    -- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
    -- Add Int for damage where available, though.
    blue_magic_maps.MagicAccuracy = S{
        '1000 Needles','Absolute Terror','Actinic Burst','Auroral Drape','Awful Eye',
        'Blank Gaze','Blistering Roar','Blood Drain','Blood Saber','Chaotic Eye',
        'Cimicine Discharge','Cold Wave','Corrosive Ooze','Cruel Joke',
		'Demoralizing Roar','Digest',
        'Dream Flower','Enervation','Feather Tickle','Filamented Hold','Frightful Roar',
        'Geist Wall','Hecatomb Wave','Infrasonics','Jettatura','Light of Penance',
        'Lowing','Mind Blast','Mortal Ray','MP Drainkiss','Osmosis','Reaving Wind',
        'Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast','Stinking Gas',
        'Sub-zero Smash','Venom Shell','Voracious Trunk','Yawn'
    }
        
    -- Breath-based spells
    blue_magic_maps.Breath = S{
        'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath',
        'Hecatomb Wave','Magnetite Cloud','Poison Breath','Radiant Breath','Self-Destruct',
        'Thunder Breath','Vapor Spray','Wind Breath'
    }

    -- Stun spells
    blue_magic_maps.Stun = S{
        'Blitzstrahl','Frypan','Head Butt','Sudden Lunge','Tail slap','Temporal Shift',
        'Thunderbolt','Whirl of Rage'
    }
        
    -- Healing spells
    blue_magic_maps.Healing = S{
        'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Restoral','White Wind',
        'Wild Carrot'
    }
    
    -- Buffs that depend on blue magic skill
    blue_magic_maps.SkillBasedBuff = S{
        'Barrier Tusk','Diamondhide','Magic Barrier','Metallic Body','Mighty Guard',
		'Occultation','Plasma Charge','Pyric Bulwark','Reactor Cool',
    }

    -- Other general buffs
    blue_magic_maps.Buff = S{
        'Amplification','Animating Wail','Battery Charge','Carcharian Verve','Cocoon',
        'Erratic Flutter','Exuviation','Fantod','Feather Barrier','Harden Shell',
        'Memento Mori','Mighty Guard','Nat. Meditation','Orcish Counterstance',
		'Refueling','Regeneration','Saline Coat','Triumphant Roar','Warm-Up','Winds of Promyvion',
        'Zephyr Mantle'
    }
	
    --Tenebral Crush
    blue_magic_maps.TenebralCrush = S{'Tenebral Crush'}
    
    -- Spells that require Unbridled Learning to cast.
    unbridled_spells = S{
        'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve',
		'Cruel Joke','Cesspool','Crashing Thunder','Droning Whirlwind','Gates of Hades',
		'Harden Shell','Mighty Guard','Polar Roar','Pyric Bulwark','Tearing Gust',
		'Thunderbolt','Tourbillion','Uproot'}
	
	degrade_array = {
		['BlueAoE'] = {'Blank Gaze','Sheep Song','Dream Flower','Jettatura'}
		}
	
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal','Refresh','DT','Acc')
    state.WeaponskillMode:options('Normal','Acc')
    state.CastingMode:options('Normal','Resistant')
    state.IdleMode:options('Speed','DT')

    gear.macc_hagondes = {name="Hagondes Cuffs", augments={'Phys. dmg. taken -3%','Mag. Acc.+29'}}

    update_combat_form()
    select_default_macro_book()
	fashion_particulars()
end

-- Set up gear sets.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
	--sets.weapons = {main="Naegling", sub="Thibron"} --auto-equips weapons on load
	sets.weapons = {main="Maxentius", sub="Bunzi's rod"} --auto-equips weapons on load
	
	int_cape = {name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10','Damage taken-5%',}}

    sets.buff['Burst Affinity'] = {feet="Hashishin basmak +3"}
    sets.buff['Chain Affinity'] = {head="Hashishin kavuk +3", feet="Assimilator's charuqs"}
    --sets.buff.Convergence = {head="Luhlaza Keffiyeh"}
    sets.buff.Diffusion = {feet="Luhlaza Charuqs +1"}
    --sets.buff.Enchainment = {body="Luhlaza Jubbah"}
    sets.buff.Efflux = {legs="Hashishin tayt +3"}

    -- Precast Sets
    
    -- Precast sets to enhance JAs
    --sets.precast.JA['Azure Lore'] = {hands="Mirage Bazubands +2"}


    -- Waltz set (chr and vit)
    -- sets.precast.Waltz = {ammo="Sonia's Plectrum",
        -- head="Uk'uxkaj Cap",
        -- body="Vanir Cotehardie",hands="Buremte Gloves",ring1="Spiral Ring",
        -- back="Iximulew Cape",waist="Caudata Belt",legs="Hagondes Pants",feet="Iuitl Gaiters +1"}
        
    -- Don't need any special gear for Healing Waltz.
    -- sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    -- sets.precast.FC = {ammo="Impatiens",
        -- head="Haruspex Hat",ear2="Loquacious Earring",
        -- body="Luhlaza Jubbah",hands="Thaumas Gloves",ring1="Prolix Ring",
        -- back="Swith Cape +1",waist="Witful Belt",legs="Enif Cosciales",feet="Chelona Boots +1"}
		
	sets.precast.FC = {ammo="Impatiens",
        ear1="Etiolation earring",
        hands="Leyline gloves",ring1="Lebeche ring",ring2="Kishar ring",
        back="Fi follet cape +1",waist="Witful belt",legs="Ayanmo cosciales +2"}
		
    sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Hashishin mintan +3"})
    
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Ginsen",
		head="Hashishin kavuk +3", --WS Dmg 12%, MAB +51, MAcc +61
        --head="Adhemar bonnet +1", --Haste 8%, DEX +33, Acc +56, SB +8, TA 4%, Crit 6%, STR +19 (set bonus: Crit rate +4%)
		neck="Fotia gorget", --Latent(Skillchain): WS fTP +10%, TP not depleted 1%
		ear1="Ishvara earring", --WSD 2%
		ear2="Moonshade earring", --TP bonus +250, Att +4
        body="Nyame mail", --WS Dmg 10%
		--STR +16, DEX +49, Att +27, TA 5%
		--hands={ name="Herculean Gloves", augments={'Attack+27','"Triple Atk."+3','DEX+10',}},
		hands="Nyame gauntlets",
		ring1="Chirich ring +1", --STP+6, SB+10, Acc+10, Regen+2
		ring2="Ilabrat Ring", --DEX +10, Att +25, STP +5
        back="Atheling Mantle", --DA 3%, Att +20
		waist="Sailfi belt +1", 
		legs="Nyame flanchard", 
		feet="Nyame sollerets"
	}
    
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    -- sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {ring1="Aquasoul Ring",feet="Luhlaza Charuqs"})
	
	sets.precast.WS['Savage Blade'] = {
		ammo="Coiste bodhar",
		head="Hashishin kavuk +3", --WS Dmg 12%, MAB +51, MAcc +61
		neck="Republican platinum medal", 
		ear1="Moonshade earring", --TP bonus +250, Att +4
		ear2="Hashishin earring +2", --STR+11
        body="Nyame mail", --WS Dmg 10%
		hands="Nyame gauntlets",
		ring1="Ilabrat ring", 
		ring2="Ephramad's ring", 
        back="Atheling Mantle", --DA 3%, Att +20
		waist="Sailfi belt +1", 
		legs="Nyame flanchard", 
		feet="Nyame sollerets"
	}

    sets.precast.WS['Sanguine Blade'] = {
		ammo="Ghastly tathlum +1",
		head="Pixie hairpin +1",
		neck="Sibyl scarf", 
		ear1="Regal earring", 
		ear2="Hashishin earring +2", --STR+11
        body="Nyame mail", --WS Dmg 10%
		hands="Nyame gauntlets",
		ring1="Metamorph ring +1", 
		ring2="Archon ring", 
        back="Rosmerta's cape",
		waist="Eschan stone", 
		legs="Nyame flanchard", 
		feet="Nyame sollerets"
	}
    
    -- Midcast Sets
    -- sets.midcast.FastRecast = {
        -- head="Haruspex Hat",ear2="Loquacious Earring",
        -- body="Luhlaza Jubbah",hands="Hashishin bazubands +3",ring1="Prolix Ring",
        -- back="Swith Cape +1",waist="Hurch'lan Sash",legs="Enif Cosciales",feet="Iuitl Gaiters +1"}
        
    sets.midcast['Blue Magic'] = {}
    
    -- Physical Spells --
    
    -- sets.midcast['Blue Magic'].Physical = {ammo="Hashishin Tathlum",
        -- head="Whirlpool Mask",neck="Ej Necklace",ear1="Heartseeker Earring",ear2="Steelflash Earring",
        -- body="Vanir Cotehardie",hands="Buremte Gloves",ring1="Rajas Ring",ring2="Spiral Ring",
        -- back="Cornflower Cape",waist="Caudata Belt",legs="Nahtirah Trousers",feet="Qaaxo Leggings"}

    -- sets.midcast['Blue Magic'].PhysicalAcc = {ammo="Jukukik Feather",
        -- head="Whirlpool Mask",neck="Ej Necklace",ear1="Heartseeker Earring",ear2="Steelflash Earring",
        -- body="Luhlaza Jubbah",hands="Buremte Gloves",ring1="Rajas Ring",ring2="Patricius Ring",
        -- back="Letalis Mantle",waist="Hurch'lan Sash",legs="Manibozho Brais",feet="Qaaxo Leggings"}

    -- sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical,
        -- {body="Iuitl Vest",hands="Assimilator's Bazubands +1"})

    -- sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical,
        -- {ammo="Jukukik Feather",body="Iuitl Vest",hands="Assimilator's Bazubands +1",
         -- waist="Chaac Belt",legs="Manibozho Brais"})

    -- sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical,
        -- {body="Vanir Cotehardie",hands="Assimilator's Bazubands +1",back="Iximulew Cape"})

    -- sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical,
        -- {body="Vanir Cotehardie",hands="Iuitl Wristbands",ring2="Stormsoul Ring",
         -- waist="Chaac Belt",feet="Iuitl Gaiters +1"})

    -- sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical,
        -- {ear1="Psystorm Earring",body="Vanir Cotehardie",hands="Assimilator's Bazubands +1",
         -- ring2="Icesoul Ring",back="Toro Cape",feet="Hagondes Sabots"})

    -- sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical,
        -- {ear1="Lifestorm Earring",body="Vanir Cotehardie",hands="Assimilator's Bazubands +1",
         -- ring2="Aquasoul Ring",back="Refraction Cape"})

    -- sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical,
        -- {body="Vanir Cotehardie",hands="Assimilator's Bazubands +1",back="Refraction Cape",
         -- waist="Chaac Belt"})

    -- sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical)


    -- Magical Spells --
    
    sets.midcast['Blue Magic'].Magical = {
		ammo="Hydrocera", --MAcc+6, MND+3, MP+20
        head="Hashishin kavuk +3", --WS Dmg 12%, MAB +51, MAcc +61
		neck="Sanctity necklace", --MAB +10, MAcc +10, MP +35, Regen +2
		ear1="Hermetic earring", --MAB +3, MAcc +7
		ear2="Regal earring", --MAB +7, INT +10, MND +10, CHR +10, MP+20
		body="Hashishin mintan +3", --MAB +49, MAcc +54, INT +40
		hands="Hashishin bazubands +3", --MAB +52, MAcc +52, DT -9, BLU RD -15%
		ring1="Locus ring", --MCR 5%, MBD bonus
		--Metamorph ring +1
		ring2="Jhakri ring", 
        back=int_cape, 
		waist="Acuity belt +1",
		legs="Hashishin tayt +3", --MAB+48, MAcc+53, INT+43
		feet="Hashishin basmak +3" --MAB 50, MAcc +53, BLU skill +28
	}

    -- sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical,
        -- {body="Vanir Cotehardie",ring1="Sangoma Ring",legs="Iuitl Tights",feet="Hashishin basmak +3"})
    
	sets.midcast['Blue Magic'].MagicalMnd = sets.midcast['Blue Magic'].Magical
    -- sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical,
        -- {ring1="Aquasoul Ring"})

	sets.midcast['Blue Magic'].MagicalChr = sets.midcast['Blue Magic'].Magical
    -- sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical)

	sets.midcast['Blue Magic'].MagicalAgi = sets.midcast['Blue Magic'].Magical

	sets.midcast['Blue Magic'].MagicalVit = sets.midcast['Blue Magic'].Magical
    -- sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical,
        -- {ring1="Spiral Ring"})
	
	sets.midcast['Blue Magic'].MagicalDex = sets.midcast['Blue Magic'].Magical
    -- sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical)
	
	sets.midcast['Blue Magic'].MagicalStr = sets.midcast['Blue Magic'].Magical

	sets.midcast['Blue Magic'].MagicAccuracy = {
		ammo="Hydrocera", --MAcc+6, MND+3, MP+20
        head="Hashishin kavuk +3", --WS Dmg 12%, MAB +51, MAcc +61
		neck="Null loop", --MAcc +50
		ear1="Dignitary's earring", --MAcc+11
		ear2="Hashishin earring +2", 
		body="Hashishin mintan +3", --MAB +49, MAcc +54, INT +40
		hands="Hashishin bazubands +3", --MAB +52, MAcc +52, DT -9, BLU RD -15%
		ring1="Stikini ring", --MAcc+8, Magic skill+5
		ring2="Stikini ring", --MAcc+8, Magic skill+5
        back=int_cape, 
		waist="Acuity belt +1",
		waist="Rumination sash", --Macc+3, SIRD+10
		legs="Hashishin tayt +3", --MAB+48, MAcc+53, INT+43, Eva+67, DT-11
		feet="Hashishin basmak +3" --MAB 50, MAcc +53, BLU skill +28
	}
	

    -- Breath Spells --
    
	sets.midcast['Blue Magic'].Breath = set_combine(sets.midcast['Blue Magic'].Magical,
		{ammo="Mavi tathlum"})
    -- sets.midcast['Blue Magic'].Breath = {ammo="Hashishin Tathlum",
        -- head="Luhlaza Keffiyeh",neck="Ej Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        -- body="Vanir Cotehardie",hands="Assimilator's Bazubands +1",ring1="K'ayres Ring",ring2="Beeline Ring",
        -- back="Refraction Cape",legs="Enif Cosciales",feet="Iuitl Gaiters +1"}

    -- Other Types --
    
	sets.midcast['Blue Magic'].Stun = sets.midcast['Blue Magic'].Magical
    -- sets.midcast['Blue Magic'].Stun = set_combine(sets.midcast['Blue Magic'].MagicAccuracy,
        -- {waist="Chaac Belt"})
       
	sets.midcast['Blue Magic']['White Wind'] = sets.midcast['Blue Magic'].Magical
    -- sets.midcast['Blue Magic']['White Wind'] = {
        -- head="Whirlpool Mask",neck="Lavalier +1",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        -- body="Vanir Cotehardie",hands="Buremte Gloves",ring1="K'ayres Ring",ring2="Meridian Ring",
        -- back="Fravashi Mantle",waist="Hurch'lan Sash",legs="Enif Cosciales",feet="Hagondes Sabots"}

    sets.midcast['Blue Magic'].Healing = {
        legs="Carmine cuisses +1"}

	sets.midcast['Blue Magic'].SkillBasedBuff = sets.midcast['Blue Magic'].Magical
    -- sets.midcast['Blue Magic'].SkillBasedBuff = {ammo="Hashishin Tathlum",
        -- head="Luhlaza Keffiyeh",
        -- body="Assimilator's Jubbah",
        -- back="Cornflower Cape",legs="Hashishin tayt +3",feet="Luhlaza Charuqs"}

	-- BLU skill
    sets.midcast['Blue Magic'].Buff = {
		ammo="Hydrocera", --MAcc+6, MND+3, MP+20
        head="Hashishin kavuk +3", --WS Dmg 12%, MAB +51, MAcc +61
		neck="Erra pendant", --MAcc +17
		ear1="Dignitary's earring", --MAcc+10
		ear2="Hashishin earring +2", --BLU skill +12
		body="Assimilator's jubbah +2", --MAB +49, MAcc +54, INT +40
		hands="Hashishin bazubands +3", --MAB +52, MAcc +52, DT -9, BLU RD -15%
		ring1="Stikini ring", --MAcc+8, Magic skill+5
		ring2="Stikini ring", --MAcc+8, Magic skill+5
        back=int_cape, 
		waist="Acuity belt +1",
		waist="Rumination sash", --Macc+3, SIRD+10
		legs="Telchine braconi", 
		feet="Hashishin basmak +3" --MAB 50, MAcc +53, BLU skill +28
	}
	
	sets.midcast['Blue Magic'].TenebralCrush = set_combine(sets.midcast['Blue Magic'].Magical,
		{
			ring2="Archon ring", --Dark MAB +5, Dark MAcc +5
		})
    
    -- sets.midcast.Protect = {ring1="Sheltered Ring"}
    -- sets.midcast.Protectra = {ring1="Sheltered Ring"}
    -- sets.midcast.Shell = {ring1="Sheltered Ring"}
    -- sets.midcast.Shellra = {ring1="Sheltered Ring"}
    
	
 
    -- Sets to return to when not performing an action.

    -- Gear for learning spells: +skill and AF hands.
		
    sets.Learning = {hands="Assimilator's bazubands"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Resting sets
    -- sets.resting = {
        -- head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",
        -- body="Hagondes Coat",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        -- waist="Austerity Belt",feet="Chelona Boots +1"}
    
    -- Idle sets
    sets.idle = {}

    sets.idle.DT = {
		ammo="Staunch tathlum +1",
		head="Nyame helm", --DT -7, MEva+123
		neck="Warder's charm +1",
		ear1="Infused earring", --Regen +1, Eva +10, AGI +4
		ear2="Eabani earring", --HP+45, Eva+15, MEva+8
		body="Hashishin mintan +3", --Refresh +3, DT -12%, MEva +126
		hands="Nyame gauntlets", --DT -7%, MEva+112, Eva+80
		--ring1="Murky ring", --DT -10%
		ring1="Vengeful ring", --Eva+9, MEva+9, MP+20
		ring2="Warden's ring", --Death resist +10, enemy crit rate -5%, PDt -3%
		back="Archon cape", -- 12% chance to negate dmg if >=85% of HP
		waist="Carrier's sash",
		legs="Hashishin tayt +3", --DT -11, MEva +152
		feet="Nyame sollerets" --DT -7, MEva +150
	}
		
	sets.idle.Speed = set_combine(sets.idle.DT, {ring2="Shneddick ring"})

    sets.idle.Learning = set_combine(sets.idle, sets.Learning)

    
    -- Defense sets
    -- sets.defense.PDT = {ammo="Iron Gobbet",
        -- head="Whirlpool Mask",neck="Wiglen Gorget",ear1="Bloodgem Earring",
        -- body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Murky Ring",ring2=gear.DarkRing.physical,
        -- back="Archon cape",waist="Flume Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters +1"}

    -- sets.defense.MDT = {ammo="Demonry Stone",
        -- head="Whirlpool Mask",neck="Twilight Torque",ear1="Bloodgem Earring",
        -- body="Hagondes Coat",hands="Iuitl Wristbands",ring1="Murky Ring",ring2="Shadow Ring",
        -- back="Engulfer Cape",waist="Flume Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters +1"}

    sets.Kiting = {ring2="Shneddick ring"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo="Coiste bodhar",
        head="Malignance chapeau",
		neck="Null loop",
		ear1="Telos earring",
		ear2="Hashishin earring +2",
        body="Malignance tabard",
		hands="Malignance gloves", 
		ring1="Chirich ring +1", --STP+6, SB+10, Acc+10, Regen+2
		ring2="Ilabrat ring",
        back=int_cape,
		waist="Reiki yotai", 
		legs="Hashishin tayt +3", --"Malignance tights",
		feet="Malignance boots"
	}

    sets.engaged.DW = set_combine(sets.engaged, {waist="Reiki yotai"})

    -- sets.engaged.DW.Acc = {ammo="Jukukik Feather",
        -- head="Whirlpool Mask",neck="Ej Necklace",ear1="Heartseeker Earring",ear2="Dudgeon Earring",
        -- body="Luhlaza Jubbah",hands="Buremte Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
        -- back="Letalis Mantle",waist="Hurch'lan Sash",legs="Manibozho Brais",feet="Qaaxo Leggings"}

    -- sets.engaged.DW.Refresh = {ammo="Jukukik Feather",
        -- head="Whirlpool Mask",neck="Asperity Necklace",ear1="Heartseeker Earring",ear2="Dudgeon Earring",
        -- body="Luhlaza Jubbah",hands="Assimilator's Bazubands +1",ring1="Rajas Ring",ring2="Epona's Ring",
        -- back="Letalis Mantle",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Qaaxo Leggings"}

    sets.engaged.Learning = set_combine(sets.engaged, sets.Learning)
    -- sets.engaged.DW.Learning = set_combine(sets.engaged.DW, sets.Learning)


    -- sets.self_healing = {ring1="Kunaji Ring",ring2="Asklepian Ring"}
	
	-- Fashion sets
	sets.fashion = {}
	
	-- sets.fashion.af = {
		-- head="Assimilator's keffiyeh +2",body="Assimilator's jubbah +2",hands="Luhlaza bazubands +1",
		-- legs="Assimilator's shalwar +2",feet="Luhlaza charuqs +1"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 1)
end

function fashion_particulars()
	send_command('wait 1;input /lockstyleset 18;wait 1;gs c set IdleMode Speed')
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if unbridled_spells:contains(spell.english) and not state.Buff['Unbridled Learning'] then
        eventArgs.cancel = true
        windower.send_command('@input /ja "Unbridled Learning" <me>; wait 2; input /ma "'..spell.name..'" <t>')
    end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Add enhancement gear for Chain Affinity, etc.
    if spell.skill == 'Blue Magic' then
        for buff,active in pairs(state.Buff) do
            if active and sets.buff[buff] then
                equip(sets.buff[buff])
            end
        end
        if spellMap == 'Healing' and spell.target.type == 'SELF' and sets.self_healing then
            equip(sets.self_healing)
        end
    end

    -- If in learning mode, keep on gear intended to help with that, regardless of action.
    if state.OffenseMode.value == 'Learning' then
        equip(sets.Learning)
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
    end
	
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
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    -- Check for H2H or single-wielding
    if player.equipment.sub == "Ammurapi shield" or player.equipment.sub == 'empty' then
        state.CombatForm:reset()
    else
        state.CombatForm:set('DW')
    end
end

	-- Anybody proficient with Gearswap, specifically with dealing with Degrade arrays? 
	-- Got one built for my PLD for /BLU spells, but it won't work past the second spell. 
	-- Not sure if I need to be using a different casting command than just my in-game 
	-- macro to make it work right, or what the problem is. It's set to a macro right 
	-- now to cast Geist Wall, which it does, obviously. Then if I hit it again, the 
	-- degrade array bumps it to Sheep Song, as it should. But once those two are on 
	-- recast, it won't jump to the next spell in the list.
	
function refine_various_spells(spell, action, spellMap, eventArgs)
	-- degrade_array = {
		-- ['BlueAoE'] = {'Jettatura','Soporific','Sheep Song','Geist Wall'}
		-- }
	BlueAoE = S{'Blank Gaze','Sheep Song','Dream Flower','Jettatura'}
	
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
	end
end