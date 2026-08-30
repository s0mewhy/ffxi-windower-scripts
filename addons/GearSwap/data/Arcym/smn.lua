-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Also, you'll need the Shortcuts addon to handle the auto-targetting of the custom pact commands.

--[[
    Custom commands:
    
    gs c petweather
        Automatically casts the storm appropriate for the current avatar, if possible.
    
    gs c siphon
        Automatically run the process to: dismiss the current avatar; cast appropriate
        weather; summon the appropriate spirit; Elemental Siphon; release the spirit;
        and re-summon the avatar.
        
        Will not cast weather you do not have access to.
        Will not re-summon the avatar if one was not out in the first place.
        Will not release the spirit if it was out before the command was issued.
        
    gs c pact [PactType]
        Attempts to use the indicated pact type for the current avatar.
        PactType can be one of:
            cure
            curaga
            buffOffense
            buffDefense
            buffSpecial
            debuff1
            debuff2
            sleep
            nuke2
            nuke4
            bp70
            bp75 (merits and lvl 75-80 pacts)
            astralflow

--]]


-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff["Avatar's Favor"] = buffactive["Avatar's Favor"] or false
    state.Buff["Astral Conduit"] = buffactive["Astral Conduit"] or false

    spirits = S{"LightSpirit", "DarkSpirit", "FireSpirit", "EarthSpirit", 
		"WaterSpirit", "AirSpirit", "IceSpirit", "ThunderSpirit"}
    avatars = S{"Carbuncle", "Fenrir", "Diabolos", "Ifrit", "Titan", "Leviathan", 
		"Garuda", "Shiva", "Ramuh", "Odin", "Alexander", "Cait Sith", "Siren"}

    magicalRagePacts = S{
        'Inferno','Earthen Fury','Tidal Wave','Aerial Blast','Diamond Dust',
		'Judgment Bolt','Searing Light','Howling Moon','Ruinous Omen',
        'Fire II','Stone II','Water II','Aero II','Blizzard II','Thunder II',
        'Fire IV','Stone IV','Water IV','Aero IV','Blizzard IV','Thunder IV',
        'Thunderspark','Burning Strike','Meteorite','Nether Blast','Flaming Crush',
        'Meteor Strike','Heavenly Strike','Wind Blade','Geocrush','Grand Fall',
		'Thunderstorm','Holy Mist','Lunar Bay','Impact','Night Terror',
		'Level ? Holy', 'Tornado II', 'Sonic Buffet', 'Conflag Strike', 'Volt Strike'}

    pacts = {}
    pacts.cure = {['Carbuncle']='Healing Ruby'}
    pacts.curaga = {['Carbuncle']='Healing Ruby II', 
		['Garuda']='Whispering Wind', ['Leviathan']='Spring Water'}
    pacts.buffoffense = {['Carbuncle']='Pacifying Ruby', ['Ifrit']='Crimson Howl', 
		['Garuda']='Hastega II', ['Ramuh']='Rolling Thunder', ['Fenrir']='Ecliptic Growl', 
		['Siren']='Katabatic Blades', ['Shiva']='Crystal Blessing'}
    pacts.buffdefense = {['Carbuncle']='Shining Ruby', ['Shiva']='Frost Armor', 
		['Garuda']='Aerial Armor', ['Titan']='Earthen Ward',
        ['Ramuh']='Lightning Armor', ['Fenrir']='Ecliptic Howl', ['Diabolos']='Noctoshield', 
		['Cait Sith']='Reraise II', ['Siren']="Wind's Blessing"}
    pacts.buffspecial = {['Ifrit']='Inferno Howl', ['Garuda']='Fleet Wind', 
		['Titan']='Earthen Armor', ['Diabolos']='Dream Shroud', ['Carbuncle']='Soothing Ruby', 
		['Fenrir']='Heavenward Howl', ['Cait Sith']='Raise II', ['Siren']='Chinook', 
		['Leviathan']='Soothing Current'}
    pacts.debuff1 = {['Shiva']='Diamond Storm', ['Ramuh']='Shock Squall', ['Leviathan']='Tidal Roar', 
		['Fenrir']='Lunar Cry', ['Diabolos']='Pavor Nocturnus', ['Cait Sith']='Eerie Eye', 
		['Siren']='Lunatic Voice'}
    pacts.debuff2 = {['Shiva']='Sleepga', ['Leviathan']='Slowga', 
		['Fenrir']='Lunar Roar', ['Diabolos']='Somnolence', ['Siren']='Bitter Elegy'}
    pacts.sleep = {['Shiva']='Sleepga', ['Diabolos']='Nightmare', ['Cait Sith']='Mewing Lullaby'}
    pacts.nuke2 = {['Ifrit']='Conflag Strike', ['Shiva']='Blizzard II', ['Garuda']='Aero II', 
		['Titan']='Stone IV', ['Ramuh']='Thunderspark', ['Leviathan']='Water II', 
		['Carbuncle']='Poison Nails',  ['Diabolos']='Camisado', ['Fenrir']='Moonlit Charge', 
		['Cait Sith']='Regal Scratch'}
    pacts.nuke4 = {['Ifrit']='Fire IV', ['Shiva']='Blizzard IV', ['Garuda']='Aero IV', 
		['Titan']='Crag Throw', ['Ramuh']='Volt Strike', ['Leviathan']='Water IV', 
		['Fenrir']='Impact', ['Siren']='Tornado II', ['Diabolos']='Blindside',} 
    pacts.bp70 = {['Ifrit']='Flaming Crush', ['Shiva']='Rush', ['Garuda']='Predator Claws', 
		['Titan']='Mountain Buster', ['Ramuh']='Chaotic Strike', ['Leviathan']='Spinning Dive', 
		['Carbuncle']='Meteorite', ['Fenrir']='Eclipse Bite', ['Diabolos']='Nether Blast',
		['Cait Sith']='Regal Gash', ['Siren']='Hysteric Assault'}
    pacts.bp75 = {['Ifrit']='Meteor Strike', ['Shiva']='Heavenly Strike', ['Garuda']='Wind Blade', 
		['Titan']='Geocrush', ['Ramuh']='Thunderstorm', ['Leviathan']='Grand Fall', 
		['Carbuncle']='Holy Mist', ['Fenrir']='Lunar Bay', ['Diabolos']='Night Terror', 
		['Cait Sith']='Level ? Holy', ['Siren']='Sonic Buffet'}
    pacts.astralflow = {['Ifrit']='Inferno', ['Shiva']='Diamond Dust', ['Garuda']='Aerial Blast', 
		['Titan']='Earthen Fury', ['Ramuh']='Judgment Bolt', ['Leviathan']='Tidal Wave', 
		['Carbuncle']='Searing Light', ['Fenrir']='Howling Moon', ['Diabolos']='Ruinous Omen', 
		['Cait Sith']="Altana's Favor", ['Siren']='Clarsach Call'}

    -- Wards table for creating custom timers   
    wards = {}
    -- Base duration for ward pacts.
    wards.durations = {
        ['Crimson Howl'] = 60, ['Earthen Armor'] = 60, ['Inferno Howl'] = 60, ['Heavenward Howl'] = 60,
        ['Rolling Thunder'] = 120, ['Fleet Wind'] = 120,
        ['Shining Ruby'] = 180, ['Frost Armor'] = 180, ['Lightning Armor'] = 180, ['Ecliptic Growl'] = 180,
        ['Glittering Ruby'] = 180, ['Hastega'] = 180, ['Noctoshield'] = 180, ['Ecliptic Howl'] = 180,
        ['Dream Shroud'] = 180,
        ['Reraise II'] = 3600
    }
    -- Icons to use when creating the custom timer.
    wards.icons = {
        ['Earthen Armor']   = 'spells/00299.png', -- 00299 for Titan
        ['Shining Ruby']    = 'spells/00043.png', -- 00043 for Protect
        ['Dream Shroud']    = 'spells/00304.png', -- 00304 for Diabolos
        ['Noctoshield']     = 'spells/00106.png', -- 00106 for Phalanx
        ['Inferno Howl']    = 'spells/00298.png', -- 00298 for Ifrit
        ['Hastega']         = 'spells/00358.png', -- 00358 for Hastega
        ['Rolling Thunder'] = 'spells/00104.png', -- 00358 for Enthunder
        ['Frost Armor']     = 'spells/00250.png', -- 00250 for Ice Spikes
        ['Lightning Armor'] = 'spells/00251.png', -- 00251 for Shock Spikes
        ['Reraise II']      = 'spells/00135.png', -- 00135 for Reraise
        ['Fleet Wind']      = 'abilities/00074.png', -- 
    }
    -- Flags for code to get around the issue of slow skill updates.
    wards.flag = false
    wards.spell = ''
    
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Speed', 'DT')

    gear.perp_staff = {name=""}
    
    select_default_macro_book()
	fashion_particulars()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast Sets
    --------------------------------------
    
    -- Precast sets to enhance JAs
    -- sets.precast.JA['Astral Flow'] = {head="Glyphic Horn"}
    
    sets.precast.JA['Elemental Siphon'] = {back="Conveyance cape",feet="Beckoner's pigaches +3"}

    sets.precast.JA['Mana Cede'] = {hands="Beckoner's bracers +3"}

    -- ***Blood Pact delay reduction and SMN skill for low BP recast***
	-- BP delay I and II both cap at -15 each for a total -30 the other 8-9 seconds are from Avatar's Favor & Beckoners Horn +1.
	-- The JP Gifts -10s BP delay is both I&II often called III, but dont push past the -30 cap. 
	-- Beckoner's Horn+1 is a must for precast or you wont get down to 21-22sec.
	-- There's a favor tier at 670 skill that's hard to hit. You do need a lot of Baayami +1 gear if you want to hit the 670 tier,
	--(21s) with Nirvana/Grip locked for AM3. If you don't have weapon locked and can swap Espiritus/Vox Grip for 18 more summoning skill,
	--then you can actually get away with no +1 gear
    sets.precast.BloodPactWard = {
		main="Espiritus", --SMN skill: path B
		sub="Vox grip", 
		ammo="Sancus sachet +1", --Avatar lvl 119, BP delay II -7
        head="Beckoner's horn +3", --Avatar's Favor +3, SMN skill+13, Refresh+2
		neck="Incanter's torque", --Magic skill+10
		ear1="Evans earring", --BP delay -2
		ear2="Lodurr earring", --SMN skill+10
        body="Convoker's doublet +2", --BP delay -10
		hands="Inyanga dastanas +2", --Magic skill +20
		ring1="Evoker's ring", --SMN skill+10
		ring2="Stikini ring", --Magic skill+5
        back="Conveyance cape", --SMN skill+8(+1),BP delay II -3
		waist="Lucidity sash", --SMN skill+7
		legs="Beckoner's spats +3", --SMN skill+30
		feet="Baayami sabots" --SMN skill+24
	}
		
    sets.precast.BloodPactRage = sets.precast.BloodPactWard

    -- Fast cast sets for spells
    
    sets.precast.FC = {
		main="Grioavolr", --FC+10
		sub="Vox grip", 
		ammo="Impatiens", --SIRD+10, QM+2
        head="Bunzi's hat", --FC+10
		neck="Loricate torque +1", --DT-6
		ear1="Malignance earring", --FC+4
		ear2="Beckoner's earring +1",
        body="Baayami robe", --SMN SIRD-100, FC+11
		hands="Bunzi's gloves", --DT-8
		ring1="Lebeche ring", --QM+2
		ring2="Kishar ring", --FC+4
        back="Campestres's cape", --DT-5
		--waist="Witful belt", --FC+3, QM+3
		waist="Cornelia's belt", --Haste+10
		legs="Lengo pants", --FC+5, SIRD+10
		feet="Volte gaiters" --FC+6
	}

    -- sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Oshasha's treatise",
		head="Nyame helm",neck="Fotia gorget",ear1="Moonshade earring",ear2="Mache earring +1",
        body="Nyame mail",hands="Nyame gauntlets",ring1="Ephramad's ring",ring2="Metamorph ring +1",
        back="Campestres's cape",waist="Famine sash",legs="Nyame flanchard",feet="Nyame sollerets"}

    -- Myrker, MP pool
    sets.precast.WS['Myrkr'] = {ammo="Ghastly tathlum +1",
		head="Beckoner's horn +3",neck="Sanctity necklace",ear1="Evans earring",ear2="Gelos earring",
        body="Convoker's Doublet +2",hands="Beckoner's bracers +3",ring1="Fortified ring",ring2="Speaker's ring",
        back="Campestres's cape",waist="Fucho-no-obi",legs="Beckoner's spats +3",feet="Beckoner's pigaches +3"}

    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    -- sets.midcast.FastRecast = {main="Grioavolr",sub="Elder's Grip +1",ammo="Sancus Sachet +1",
        -- head="Vanya Hood",neck="Adad Amulet",ear1="Loquacious Earring",ear2="Evans Earring",
        -- body="Merlinic Jubbah",hands="Convoker's Bracers",ring1="Evoker's Ring",ring2="Bifrost Ring",
        -- back="Veela Cape",waist="Embla Sash",legs="Psycloth Lappas",feet="Regal Pumps +1"}

    -- sets.midcast.Cure = {main="Chatoyant Staff",sub="Elder's Grip +1",ammo="Sancus Sachet +1",
        -- head="Vanya Hood",neck="Nodens Gorget",ear1="Gifted Earring",ear2="Beatific Earring",
        -- body="Shomonjijoe +1",hands="Summoner's Bracers",ring1="Evoker's Ring",ring2="Bifrost Ring",
        -- back="Seshaw Cape",waist="Hachirin-no-Obi",legs="Gyve Trousers",feet="Vanya Clogs"}

    -- sets.midcast.Stoneskin = {main="Espiritus",sub="Elder's Grip +1",ammo="Sancus Sachet +1",
        -- head="Befouled Crown",neck="Nodens Gorget",ear1="Andoaa Earring",ear2="Mimir Earring",
        -- body="Shomonjijoe +1",hands="Summoner's Bracers",ring1="Evoker's Ring",ring2="Bifrost Ring",
        -- back="Merciful Cape",waist="Siegel Sash",legs="Psycloth Lappas",feet="Regal Pumps +1"}

    -- sets.midcast['Elemental Magic'] = {main="Grioavolr",sub="Elder's Grip +1",ammo="Sancus Sachet +1",
        -- head="Amalric Coif",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Novio Earring",
        -- body="Amalric Doublet",hands="Amalric Gages",ring1="Adoulin Ring",ring2="Etana Ring",
        -- back="Izdubar Mantle",waist="Refoccilation Stone",legs="Gyve Trousers",feet="Tali'ah Crackows +2"}

    -- sets.midcast['Dark Magic'] = {main="Grioavolr",sub="Elder's Grip +1",ammo="Sancus Sachet +1",
        -- head="Amalric Coif",neck="Incanter's Torque",ear1="Abyssal Earring",ear2="Dignitary's Earring",
        -- body="Amalric Doublet",hands="Amalric Gages",ring1="Excelsis Ring",ring2="Evanescence Ring",
        -- back="Izdubar Mantle",waist="Refoccilation Stone",legs="Gyve Trousers",feet="Tali'ah Crackows +2"}

    -- Avatar pact sets.  All pacts are Ability type.
    
	sets.midcast.Pet.BloodPactWard = {main="Espiritus", --SMN skill: path B
		sub="Vox grip",ammo="Epitaph",
        head="Beckoner's horn +3",neck="Incanter's Torque",ear1="Andoaa earring",ear2="Lodurr earring",
        body="Baayami robe",hands="Inyanga Dastanas +2",ring1="Evoker's ring",ring2="Stikini ring",
        back="Conveyance cape",waist="Lucidity Sash",legs="Beckoner's spats +3",feet="Baayami sabots"}

    -- sets.midcast.Pet.DebuffBloodPactWard = {main="Nirvana",sub="Elder's Grip +1",ammo="Sancus Sachet +1",
        -- head="Beckoner's horn +3",neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Lodurr Earring",
        -- body="Beckoner's Doublet +1",hands="Inyanga Dastanas +2",ring1="Evoker's Ring",ring2="Varar Ring +1",
        -- back="Campestres's Cape",waist="Lucidity Sash",legs="Assiduity Pants +1",feet="Apogee Pumps"}
        
    -- sets.midcast.Pet.DebuffBloodPactWard.Acc = sets.midcast.Pet.DebuffBloodPactWard
    
    sets.midcast.Pet.PhysicalBloodPactRage = {
		main="Gridarvor", 
		sub="Elan strap +1", --BP dmg+5, MAB+7
		ammo="Epitaph", --Avatar lvl 119, BP dmg+16
        head="Helios band", --BP+7, Pet DA+7, Pet Att+25
		neck="Shulmanu collar", --Pet DA 5%, Pet Acc/Att +20
		ear1="Lugalbanda earring", --Avatar Acc/RAcc/MAcc +15, BP dmg +10
		ear2="Gelos earring", --BP Dmg +5
		--body="Convoker's doublet +2", --BP Dmg+14
        body="Beckoner's doublet +3", --BP dmg +13, Acc/MAcc +64
		hands="Beckoner's bracers +3", --BP dmg +12, Avatar Acc/Macc/Racc+62
		ring1="Varar ring +1", --BP dmg +4, Pet STP+6, Pet Acc/RAcc+10
		ring2="Varar ring +1", --BP dmg +4, Pet STP+6, Pet Acc/RAcc+10
        back="Campestres's cape", 
		waist="Incarnation sash",
		legs="Enticer's Pants", --MP +50, Avatar: BP dmg +12, TP bonus +650, DA 3%, CR 5%, MAcc +14, DT -4, Acc/RAcc +13
		feet="Helios boots" --BP dmg +7, pet DA+7, pet Att+19
	}

    -- sets.midcast.Pet.PhysicalBloodPactRage.Acc = sets.midcast.Pet.PhysicalBloodPactRage

    sets.midcast.Pet.MagicalBloodPactRage = {
		main="Gridarvor", 
		sub="Elan strap +1", --BP dmg+5, MAB+7
		ammo="Epitaph", --Avatar lvl 119, BP dmg+16
        head="Apogee crown +1", --BP+8, Pet MAB+35
		neck="Adad amulet", --DT -4, Pet: MAcc+20, MAB +10
		ear1="Lugalbanda earring", --Avatar Acc/RAcc/MAcc +15, BP dmg +10
		ear2="Gelos earring", --BP Dmg +5
		--body="Convoker's doublet +2", --BP Dmg+14
        body="Beckoner's doublet +3", --BP dmg +13, Acc/MAcc +64
		hands="Beckoner's bracers +3", --BP dmg +12, Avatar Acc/Macc/Racc+62
		ring1="Varar ring +1", --BP dmg +4, Pet STP+6, Pet Acc/RAcc+10
		ring2="Varar ring +1", --BP dmg +4, Pet STP+6, Pet Acc/RAcc+10
        back="Campestres's cape", 
		waist="Regal belt", --Avatar: Att +20, MAB +10, AF set bonus: Acc/RAcc/MAcc
		legs="Enticer's Pants", --MP +50, Avatar: BP dmg +12, TP bonus +650, DA 3%, CR 5%, MAcc +14, DT -4, Acc/RAcc +13
		feet="Beckoner's pigaches +3" --Avatar BP dmg +12
	}
		
	--sets.midcast.Pet['Flaming Crush'] = sets.midcast.Pet.MagicalBloodPactRage
	--sets.midcast.Pet['Thunderspark'] = sets.midcast.Pet.MagicalBloodPactRage

    -- sets.midcast.Pet.MagicalBloodPactRage.Acc = sets.midcast.Pet.MagicalBloodPactRage


    -- Spirits cast magic spells, which can be identified in standard ways.
    
    --sets.midcast.Pet.WhiteMagic = {legs="Summoner's Spats"}
    
    --sets.midcast.Pet['Elemental Magic'] = set_combine(sets.midcast.Pet.BloodPactRage, {legs="Summoner's Spats"})

    --sets.midcast.Pet['Elemental Magic'].Resistant = {}
    

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
       
    -- Idle sets
    sets.idle = {main="Gridarvor",sub="Oneiros grip",ammo="Epitaph",
        head="Beckoner's horn +3",neck="Caller's pendant",ear1="Infused earring",ear2="Beckoner's earring +1",
        body="Beckoner's doublet +3",hands="Bunzi's gloves",ring1="Murky ring",ring2="Inyanga ring",
        back="Campestres's cape",waist="Carrier's sash",legs="Assiduity Pants",feet="Baayami sabots"}

    sets.idle.DT = {main="Gridarvor",sub="Oneiros grip",ammo="Epitaph",
        head="Beckoner's horn +3",neck="Caller's pendant",ear1="Infused earring",ear2="Beckoner's earring +1",
        body="Beckoner's doublet +3",hands="Bunzi's gloves",ring1="Murky ring",ring2="Inyanga ring",
        back="Campestres's cape",waist="Carrier's sash",legs="Assiduity Pants",feet="Baayami sabots"}
		
	sets.idle.Speed = set_combine(sets.idle.DT, {ring2="Shneddick ring"})
	
    -- perp costs:
    -- spirits: 7
    -- carby: 11 (5 with mitts)
    -- fenrir: 13
    -- others: 15
    -- avatar's favor: -4/tick
    
    -- Max useful -perp gear is 1 less than the perp cost (can't be reduced below 1)
    -- Aim for -14 perp, and refresh in other slots.
    
    -- -perp gear:
    -- Gridarvor: -5
    -- Glyphic Horn: -4
    -- Caller's Doublet +2/Glyphic Doublet: -4
    -- Evoker's Ring: -1
    -- Convoker's Pigaches: -4
    -- total: -18
    
    -- Can make due without either the head or the body, and use +refresh items in those slots.
    
	sets.idle.Avatar = {main="Gridarvor",sub="Oneiros grip",ammo="Epitaph",
        head="Beckoner's horn +3",neck="Caller's pendant",ear1="Crepuscular earring",ear2="Beckoner's earring +1",
        body="Beckoner's doublet +3",hands="Bunzi's gloves",ring1="Murky ring",ring2="Inyanga ring",
        back="Campestres's cape",waist="Carrier's sash",legs="Assiduity Pants",feet="Bunzi's sabots"}

    -- sets.idle.PDT.Avatar = {main="Grioavolr",sub="Oneiros grip",ammo="Epitaph",
        -- head="Befouled crown",neck="Shulmanu collar",ear1="Lugalbanda earring",ear2="Beckoner's earring +1",
        -- body="Shomonjijoe +1",hands="Inyanga dastanas +2",ring1="Shneddick ring",ring2="Inyanga ring",
        -- back="Conveyance cape",waist="Lucidity Sash",legs="Assiduity Pants",feet="Bunzi's sabots"}

    -- sets.idle.Spirit = {main="Nirvana",sub="Elder's Grip +1",ammo="Sancus Sachet +1",
        -- head="Beckoner's horn +3",neck="Caller's Pendant",ear1="Evans Earring",ear2="Lodurr Earring",
        -- body="Shomonjijoe +1",hands="Summoner's Bracers",ring1="Evoker's Ring",ring2="Varar Ring +1",
        -- back="Campestres's Cape",waist="Lucidity Sash",legs="Assiduity Pants +1",feet="Apogee Pumps"}

    -- sets.idle.Town = {main="Nirvana",sub="Elder's Grip +1",ammo="Sancus Sachet +1",
        -- head="Beckoner's horn +3",neck="Caller's Pendant",ear1="Evans Earring",ear2="Lodurr Earring",
        -- body="Shomonjijoe +1",hands="Summoner's Bracers",ring1="Evoker's Ring",ring2="Varar Ring +1",
        -- back="Campestres's Cape",waist="Lucidity Sash",legs="Assiduity Pants +1",feet="Crier's Gaiters"}

    -- Favor uses Caller's Horn instead of Convoker's Horn for refresh
    -- sets.idle.Avatar.Favor = {main="Nirvana",sub="Elder's Grip +1",ammo="Sancus Sachet +1",
        -- head="Beckoner's horn +3",neck="Caller's Pendant",ear1="Andoaa Earring",ear2="Lodurr Earring",
        -- body="Beckoner's Doublet +1",hands="Summoner's Bracers",ring1="Evoker's Ring",ring2="Varar Ring +1",
        -- back="Campestres's Cape",waist="Lucidity Sash",legs="Beckoner's Spats +1",feet="Apogee Pumps"}
		
    -- sets.idle.Avatar.Melee = {main="Nirvana",sub="Elder's Grip +1",ammo="Sancus Sachet +1",
        -- head="Beckoner's horn +3",neck="Caller's Pendant",ear1="Evans Earring",ear2="Lodurr Earring",
        -- body="Shomonjijoe +1",hands="Summoner's Bracers",ring1="Evoker's Ring",ring2="Varar Ring +1",
        -- back="Campestres's Cape",waist="Lucidity Sash",legs="Assiduity Pants +1",feet="Apogee Pumps"}
        
    sets.perp = {main="Gridarvor",sub="Oneiros grip",ammo="Epitaph",
        head="Beckoner's horn +3",neck="Caller's pendant",ear1="Crepuscular earring",ear2="Beckoner's earring +1",
        body="Beckoner's doublet +3",hands="Bunzi's gloves",ring1="Murky ring",ring2="Inyanga ring",
        back="Campestres's cape",waist="Carrier's sash",legs="Assiduity Pants",feet="Bunzi's sabots"}
		
    -- Caller's Bracer's halve the perp cost after other costs are accounted for.
    -- Using -10 (Gridavor, ring, Conv.feet), standard avatars would then cost 5, halved to 2.
    -- We can then use Hagondes Coat and end up with the same net MP cost, but significantly better defense.
    -- Weather is the same, but we can also use the latent on the pendant to negate the last point lost.
    --sets.perp.Day = {body="Hagondes Coat",hands="Caller's Bracers +2"}
    --sets.perp.Weather = {neck="Caller's Pendant",body="Hagondes Coat",hands="Caller's Bracers +2"}
    -- Carby: Mitts+Conv.feet = 1/tick perp.  Everything else should be +refresh
    --sets.perp.Carbuncle = {main="Bolelabunga",sub="Genbu's Shield",
    --    head="Convoker's Horn",body="Hagondes Coat",hands="Carbuncle Mitts",legs="Nares Trews",feet="Convoker's Pigaches"}
    -- Diabolos's Rope doesn't gain us anything at this time
    --sets.perp.Diabolos = {waist="Diabolos's Rope"}
    --sets.perp.Alexander = sets.midcast.Pet.BloodPactWard

    --sets.perp.staff_and_grip = {main=gear.perp_staff,sub="Achaq Grip"}
    
    -- Defense sets
    -- sets.defense.PDT = {main="Nirvana",sub="Elder's Grip +1",ammo="Sancus Sachet +1",
        -- head="Beckoner's horn +3",neck="Loricate Torque +1",ear1="Evans Earring",ear2="Lodurr Earring",
        -- body="Shomonjijoe +1",hands="Summoner's Bracers",ring1="Evoker's ring",ring2="Varar Ring +1",
        -- back="Campestres's Cape",waist="Lucidity Sash",legs="Assiduity Pants +1",feet="Apogee Pumps"}

    -- sets.defense.MDT = {main="Nirvana",sub="Elder's Grip +1",ammo="Sancus Sachet +1",
        -- head="Beckoner's horn +3",neck="Loricate Torque +1",ear1="Evans Earring",ear2="Lodurr Earring",
        -- body="Shomonjijoe +1",hands="Summoner's Bracers",ring1="Evoker's Ring",ring2="Varar Ring +1",
        -- back="Campestres's Cape",waist="Lucidity Sash",legs="Assiduity Pants +1",feet="Apogee Pumps"}

    sets.Kiting = {ring1="Shneddick ring"}
    
    sets.latent_refresh = {waist="Fucho-no-obi"}
    
    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
    -- Normal melee group
    sets.engaged = {main="Gridarvor",sub="Oneiros grip",ammo="Epitaph",
        head="Beckoner's horn +3",neck="Caller's pendant",ear1="Crepuscular earring",ear2="Beckoner's earring +1",
        body="Beckoner's doublet +3",hands="Bunzi's gloves",ring1="Chirich ring +1",ring2="Varar ring +1",
        back="Campestres's cape",waist="Cornelia's belt",legs="Assiduity Pants",feet="Bunzi's sabots"}
		
	sets.fashion = {}
	
end

function fashion_particulars()
	send_command('wait 1;input /lockstyleset 35;wait 1;gs c set IdleMode Speed')
	--send_command('wait 1;gs c set MagicBurst true')
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if state.Buff['Astral Conduit'] and pet_midaction() then
        eventArgs.handled = true
    end
end

function job_midcast(spell, action, spellMap, eventArgs)
    if state.Buff['Astral Conduit'] and pet_midaction() then
        eventArgs.handled = true
    end
end

-- Runs when pet completes an action.
function job_pet_aftercast(spell, action, spellMap, eventArgs)
	-- fix for gear not switching
	if not spell.interrupted and spell.type:sub(1,9) == "BloodPact" then
		job_pet_midcast(spell, action, spellMap, eventArgs)
	end
	-- end fix

    if not spell.interrupted and spell.type == 'BloodPactWard' and spellMap ~= 'DebuffBloodPactWard' then
        wards.flag = true
        wards.spell = spell.english
        send_command('wait 4; gs c reset_ward_flag')
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
        handle_equipping_gear(player.status)
    elseif storms:contains(buff) then
        handle_equipping_gear(player.status)
    end
end


-- Called when the player's pet's status changes.
-- This is also called after pet_change after a pet is released.  Check for pet validity.
function job_pet_status_change(newStatus, oldStatus, eventArgs)
    if pet.isvalid and not midaction() and not pet_midaction() and (newStatus == 'Engaged' or oldStatus == 'Engaged') then
        handle_equipping_gear(player.status, newStatus)
    end
end


-- Called when a player gains or loses a pet.
-- pet == pet structure
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(petparam, gain)
    classes.CustomIdleGroups:clear()
    if gain then
        if avatars:contains(pet.name) then
            classes.CustomIdleGroups:append('Avatar')
        elseif spirits:contains(pet.name) then
            classes.CustomIdleGroups:append('Spirit')
        end
    else
        select_default_macro_book('reset')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell)
    if spell.type == 'BloodPactRage' then
        if magicalRagePacts:contains(spell.english) then
            return 'MagicalBloodPactRage'
        else
            return 'PhysicalBloodPactRage'
        end
    elseif spell.type == 'BloodPactWard' and spell.target.type == 'MONSTER' then
        return 'DebuffBloodPactWard'
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if pet.isvalid then
        if pet.element == world.day_element then
            idleSet = set_combine(idleSet, sets.perp.Day)
        end
        if pet.element == world.weather_element then
            idleSet = set_combine(idleSet, sets.perp.Weather)
        end
        if sets.perp[pet.name] then
            idleSet = set_combine(idleSet, sets.perp[pet.name])
        end
        gear.perp_staff.name = elements.perpetuance_staff_of[pet.element]
        if gear.perp_staff.name and (player.inventory[gear.perp_staff.name] or player.wardrobe[gear.perp_staff.name]) then
            idleSet = set_combine(idleSet, sets.perp.staff_and_grip)
        end
        if state.Buff["Avatar's Favor"] and avatars:contains(pet.name) then
            idleSet = set_combine(idleSet, sets.idle.Avatar.Favor)
        end
        if pet.status == 'Engaged' then
            idleSet = set_combine(idleSet, sets.idle.Avatar.Melee)
        end
    end
    
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if pet.isvalid then
        if avatars:contains(pet.name) then
            classes.CustomIdleGroups:append('Avatar')
        elseif spirits:contains(pet.name) then
            classes.CustomIdleGroups:append('Spirit')
        end
    end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end


-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'petweather' then
        handle_petweather()
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'siphon' then
        handle_siphoning()
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'pact' then
        handle_pacts(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1] == 'reset_ward_flag' then
        wards.flag = false
        wards.spell = ''
        eventArgs.handled = true
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Cast the appopriate storm for the currently summoned avatar, if possible.
function handle_petweather()
    if player.sub_job ~= 'SCH' then
        add_to_chat(122, "You can not cast storm spells")
        return
    end
        
    if not pet.isvalid then
        add_to_chat(122, "You do not have an active avatar.")
        return
    end
    
    local element = pet.element
    if element == 'Thunder' then
        element = 'Lightning'
    end
    
    if S{'Light','Dark','Lightning'}:contains(element) then
        add_to_chat(122, 'You do not have access to '..elements.storm_of[element]..'.')
        return
    end 
    
    local storm = elements.storm_of[element]
    
    if storm then
        send_command('@input /ma "'..elements.storm_of[element]..'" <me>')
    else
        add_to_chat(123, 'Error: Unknown element ('..tostring(element)..')')
    end
end


-- Custom uber-handling of Elemental Siphon
function handle_siphoning()
    if areas.Cities:contains(world.area) then
        add_to_chat(122, 'Cannot use Elemental Siphon in a city area.')
        return
    end

    local siphonElement
    local stormElementToUse
    local releasedAvatar
    local dontRelease
    
    -- If we already have a spirit out, just use that.
    if pet.isvalid and spirits:contains(pet.name) then
        siphonElement = pet.element
        dontRelease = true
        -- If current weather doesn't match the spirit, but the spirit matches the day, try to cast the storm.
        if player.sub_job == 'SCH' and pet.element == world.day_element and pet.element ~= world.weather_element then
            if not S{'Light','Dark','Lightning'}:contains(pet.element) then
                stormElementToUse = pet.element
            end
        end
    -- If we're subbing /sch, there are some conditions where we want to make sure specific weather is up.
    -- If current (single) weather is opposed by the current day, we want to change the weather to match
    -- the current day, if possible.
    elseif player.sub_job == 'SCH' and world.weather_element ~= 'None' then
        -- We can override single-intensity weather; leave double weather alone, since even if
        -- it's partially countered by the day, it's not worth changing.
        if get_weather_intensity() == 1 then
            -- If current weather is weak to the current day, it cancels the benefits for
            -- siphon.  Change it to the day's weather if possible (+0 to +20%), or any non-weak
            -- weather if not.
            -- If the current weather matches the current avatar's element (being used to reduce
            -- perpetuation), don't change it; just accept the penalty on Siphon.
            if world.weather_element == elements.weak_to[world.day_element] and
                (not pet.isvalid or world.weather_element ~= pet.element) then
                -- We can't cast lightning/dark/light weather, so use a neutral element
                if S{'Light','Dark','Lightning'}:contains(world.day_element) then
                    stormElementToUse = 'Wind'
                else
                    stormElementToUse = world.day_element
                end
            end
        end
    end
    
    -- If we decided to use a storm, set that as the spirit element to cast.
    if stormElementToUse then
        siphonElement = stormElementToUse
    elseif world.weather_element ~= 'None' and (get_weather_intensity() == 2 or world.weather_element ~= elements.weak_to[world.day_element]) then
        siphonElement = world.weather_element
    else
        siphonElement = world.day_element
    end
    
    local command = ''
    local releaseWait = 0
    
    if pet.isvalid and avatars:contains(pet.name) then
        command = command..'input /pet "Release" <me> <wait 1.1>'
        releasedAvatar = pet.name
        releaseWait = 10
    end
    
    if stormElementToUse then
        command = command..'input /ma "'..elements.storm_of[stormElementToUse]..'" <me> <wait 4>'
        releaseWait = releaseWait - 4
    end
    
    if not (pet.isvalid and spirits:contains(pet.name)) then
        command = command..'input /ma "'..elements.spirit_of[siphonElement]..'" <me> <wait 4>'
        releaseWait = releaseWait - 4
    end
    
    command = command..'input /ja "Elemental Siphon" <me>;'
    releaseWait = releaseWait - 1
    releaseWait = releaseWait + 0.1
    
    if not dontRelease then
        if releaseWait > 0 then
            command = command..'wait '..tostring(releaseWait)..';'
        else
            command = command..'wait 1.1;'
        end
        
        command = command..'input /pet "Release" <me>;'
    end
    
    if releasedAvatar then
        command = command..'wait 1.1;input /ma "'..releasedAvatar..'" <me>'
    end
    
    send_command(command)
end


-- Handles executing blood pacts in a generic, avatar-agnostic way.
-- cmdParams is the split of the self-command.
-- gs c [pact] [pacttype]
function handle_pacts(cmdParams)
    if areas.Cities:contains(world.area) then
        add_to_chat(122, 'You cannot use pacts in town.')
        return
    end

    if not pet.isvalid then
        add_to_chat(122,'No avatar currently available. Returning to default macro set.')
        select_default_macro_book('reset')
        return
    end

    if spirits:contains(pet.name) then
        add_to_chat(122,'Cannot use pacts with spirits.')
        return
    end

    if not cmdParams[2] then
        add_to_chat(123,'No pact type given.')
        return
    end
    
    local pact = cmdParams[2]:lower()
    
    if not pacts[pact] then
        add_to_chat(123,'Unknown pact type: '..tostring(pact))
        return
    end
    
    if pacts[pact][pet.name] then
        if pact == 'astralflow' and not buffactive['astral flow'] then
            add_to_chat(122,'Cannot use Astral Flow pacts at this time.')
            return
        end
        
		add_to_chat(122,pet.name..': '..pact..' = '..pacts[pact][pet.name])
        -- Leave out target; let Shortcuts auto-determine it.
        send_command('@input /pet "'..pacts[pact][pet.name]..'"')
    else
        add_to_chat(122,pet.name..' does not have a pact of type ['..pact..'].')
    end
end


-- Event handler for updates to player skill, since we can't rely on skill being
-- correct at pet_aftercast for the creation of custom timers.
windower.raw_register_event('incoming chunk',
    function (id)
        if id == 0x62 then
            if wards.flag then
                create_pact_timer(wards.spell)
                wards.flag = false
                wards.spell = ''
            end
        end
    end)

-- Function to create custom timers using the Timers addon.  Calculates ward duration
-- based on player skill and base pact duration (defined in job_setup).
function create_pact_timer(spell_name)
    -- Create custom timers for ward pacts.
    if wards.durations[spell_name] then
        local ward_duration = wards.durations[spell_name]
        if ward_duration < 181 then
            local skill = player.skills.summoning_magic
            if skill > 300 then
                skill = skill - 300
                if skill > 200 then skill = 200 end
                ward_duration = ward_duration + skill
            end
        end
        
        local timer_cmd = 'timers c "'..spell_name..'" '..tostring(ward_duration)..' down'
        
        if wards.icons[spell_name] then
            timer_cmd = timer_cmd..' '..wards.icons[spell_name]
        end

        send_command(timer_cmd)
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book(reset)
    if reset == 'reset' then
        -- lost pet, or tried to use pact when pet is gone
    end
    
    -- Default macro set/book
    set_macro_page(1, 17)
end
