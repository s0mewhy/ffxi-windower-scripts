-- gs reload
-- gs showswaps

function get_sets()

	sets.weapons = {main="Marin Staff +1",sub="Enki strap"}
	
	sets.WS = {ammo="Oshasha's treatise",
		head="Nyame helm",neck="Loricate torque +1",ear1="Moonshade earring",ear2="Ishvara earring",
		body="Nyame mail",hands="Nyame gauntlets",ring1="Jhakri ring",ring2="Ephramad's ring",
		back="Taranus's cape",waist="Famine Sash",legs="Nyame flanchard",feet="Nyame sollerets"}

	sets.WS.Myrkr = {ammo="Ghastly tathlum +1",
		head="Nyame helm",neck="Sanctity necklace",ear1="Moonshade earring",ear2="Etiolation earring",
		body="Nyame mail",hands="Nyame gauntlets",ring1="Mephitas's ring",ring2="Ephramad's ring",
		back="Taranus's cape",waist="Famine Sash",legs="Nyame flanchard",feet="Nyame sollerets"}

	-- Precast sets
    sets.precast = {}
	
	-- Fastcast set
	sets.precast.fastcast = {ammo="Impatiens",
		head="Merlinic hood",neck="Loricate torque +1",ear1="Malignance earring",ear2="Etiolation earring",
		body="Agwu's robe",hands="Agwu's gages",ring1="Kishar Ring",ring2="Lebeche ring",
		back="Fi follet Cape +1",waist="Embla Sash",legs="Lengo pants",feet="Regal Pumps +1"}
		
	-- sets.precast.FCDeath = {ammo="Ghastly Tathlum +1",
		-- head="Amalric Coif",neck="Sanctity Necklace",ear1="Loquacious Earring",ear2="Etiolation Earring",
		-- body="Amalric Doublet",hands="Regal Cuffs",ring1="Metamorph Ring +1",ring2="bifrost Ring",
		-- back="Fi Follet Cape +1",waist="Fucho-no-Obi",legs="Psycloth lappas",feet="Vanya Clogs"}	
		
	sets.precast.Impact = set_combine(sets.precast.fastcast, {body="Crepuscular cloak"})
			
	-- Midcast sets
    sets.midcast = {ammo="Ghastly Tathlum +1",
		head="Wicce petasos +3",neck="Sanctity Necklace",ear1="Malignance earring",ear2="Wicce earring +2",
		body="Wicce coat +3",hands="Wicce gloves +3",ring1="Freke ring",ring2="Jhakri ring",
		back="Taranus's cape",waist="Acuity belt +1",legs="Wicce chausses +3",feet="Wicce sabots +3"}	

	-- Magic-type sets
	-- sets.midcast['Dark Magic'] = {ammo="Pemphredo Tathlum",
        -- head="Ea Hat +1",neck="Erra Pendant",ear1="Dignitary's Earring",ear2="Abyssal Earring",
		-- body="Shango Robe",hands="Archmage's gloves +3",ring1="Adoulin Ring",ring2="Etana ring",
		-- back="Taranus's Cape",waist="Refoccilation Stone",legs="Psycloth lappas",feet="Wicce Sabots +3"}

	sets.midcast['Elemental Magic'] = {ammo="Ghastly Tathlum +1",
		head="Wicce petasos +3",neck="Sanctity Necklace",ear1="Malignance earring",ear2="Wicce earring +2",
		body="Wicce coat +3",hands="Wicce gloves +3",ring1="Freke ring",ring2="Jhakri ring",
		back="Taranus's cape",waist="Acuity belt +1",legs="Wicce chausses +3",feet="Agwu's pigaches"}

	-- sets.midcast['Elemental Magic'] = {ammo="Pemphredo Tathlum",
		-- head="Archmage's Petasos +3",neck="Sorcerer's Stole +2",ear1="Malignance Earring",ear2="Regal Earring",
		-- body="Wicce Coat +3",hands="Wicce Gloves +3",ring1="Adoulin Ring",ring2="Jhakri ring",
		-- back="Taranus's Cape",waist="Orpheus's Sash",legs="Wicce Chausses +3",feet="Archmage's Sabots +3"}

	-- sets.midcast['Enfeebling Magic'] = {ammo="Pemphredo Tathlum",
		-- head="Befouled Crown",neck="Sorcerer's Stole +2",ear1="Dignitary's Earring",ear2="Vor Earring",
		-- body="Spaekona's Coat +2",hands="Regal cuffs",ring1="Kishar Ring",ring2="Etana ring",
		-- back="Taranus's Cape",waist="Refoccilation Stone",legs="Psycloth lappas",feet="Archmage's Sabots +3"}
		
	-- sets.midcast['Enhancing Magic'] = {ammo="Kalboron stone",
		-- head="Befouled Crown",neck="Nodens Gorget",ear1="Andoaa Earring",ear2="Mimir Earring",
		-- body="Ea Houppelande",hands="Regal cuffs",ring1="Omega Ring",ring2="Etana ring",
		-- back="Fi follet Cape +1",waist="Siegel Sash",legs="Ea Slops",feet="Jhakri Pigaches +2"}
		
	-- sets.midcast['Healing Magic'] = {ammo="Kalboron stone",
		-- head="Vanya Hood",neck="Nodens Gorget",ear1="Beatific Earring",ear2="Static Earring",
		-- body="Ea Houppelande",hands="Regal cuffs",ring1="Lebeche Ring",ring2="Etana ring",
		-- back="Altruistic Cape",waist="Hachirin-no-Obi",legs="Gyve Trousers",feet="Vanya Clogs"}
		
	-- sets.midcast['Death'] = {ammo="Ghastly Tathlum +1",
        -- head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Barkarole Earring",ear2="Etiolation Earring",
		-- body="Wicce Coat +3",hands="Regal Cuffs",ring1="Etana Ring",ring2="Archon ring",
		-- back="Taranus's Cape",waist="Refoccilation Stone",legs="Archmage's Tonban +3",feet="Wicce Sabots +3"}	
		
	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head="",body="Crepuscular cloak"})
	
	-- Elemental Day/Weather set
	sets.midcast.EleWeather = {waist="Hachirin-no-Obi"}
	sets.midcast.Zodiac = {ring2="Zodiac ring"}
	--sets.midcast.MP = {body="Spaekona's Coat +2"}
	
	-- Magic Burst set
	sets.midcast.MB = {ammo="Pemphredo Tathlum",
		head="Ea Hat +1",neck="Sorcerer's Stole +2",ear1="Malignance Earring",ear2="Wicce earring +2",
		body="Wicce Coat +3",hands="Amalric Gages +1",ring1="Adoulin Ring",ring2="Mujin band",
		back="Taranus's Cape",waist="Refoccilation Stone",legs="Ea Slops",feet="Ea Pigaches"}
		
	-- sets.midcast.Aspir = set_combine(sets.midcast['Dark Magic'], 
		-- {ear1="Hirudinea Earring",ring1="Excelsis Ring",ring2="Evanescence Ring",waist="Fucho-no-Obi",feet="Archmage's sabots +3"})
		
	-- sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], 
		-- {ear1="Hirudinea Earring",ring1="Excelsis Ring",waist="Fucho-no-Obi",ring2="Evanescence Ring",feet="Agwu's Pigaches"})
	
	-- Elemental Debuff spells
	sets.midcast.EleDebuff = set_combine(sets.midcast['Elemental Magic'],
		{legs="Archmage's Tonban +3",feet="Archmage's sabots +3",hands="Archmage's gloves +3"})
	sets.midcast.Burn = sets.midcast.EleDebuff
	sets.midcast.Rasp = sets.midcast.EleDebuff
	sets.midcast.Drown = sets.midcast.EleDebuff
	sets.midcast.Choke = sets.midcast.EleDebuff
	sets.midcast.Frost = sets.midcast.EleDebuff
	sets.midcast.Shock = sets.midcast.EleDebuff

	--sets.midcast['Manafont'] = {head="Archmage's Coat +3"}
	sets.midcast['Mana Wall'] = {legs="Wicce Sabots +2"}

	-- variables used to cycle sets with self_command() below
	Idle_sets = {'DT'}
    Idle_ind = 1
	
	-- Idle set
	sets.idle = {}
	sets.idle.DT = {main="Marin staff +1",sub="Enki strap",ammo="Ghastly tathlum +1",
		head="Wicce petasos +3",neck="Bathy choker +1",ear1="Infused earring",ear2="Etiolation Earring",
		body="Wicce coat +3",hands="Wicce gloves +3",ring1="Murky ring",ring2="Shneddick ring",
		back="Taranus's cape",waist="Fucho-no-obi",legs="Wicce chausses +3",feet="Wicce sabots +3"}
	
	sets.fashion = {}
	sets.fashion.savage = {main="Mindmelter",sub="Enki strap",ammo="Ghastly Tathlum +1",
		head="Archmage's petasos +3",body="Igqira Weskit",hands="Archmage's gloves +3",
		legs="Igqira Lappas",feet="Archmage's sabots +3"}
	
	-- variables used to cycle sets with self_command() below
	MB_mode = false
	
	set_macro_book()
	fashion_particulars()
	printMB()
end

-- Select default macro book on initial load or subjob change.
function set_macro_book()
	-- Default macro set/book
	send_command('wait 1;input /macro book 8;wait 1;input /macro set 1')
end

-- Equip fashion set, turn on lockstyle, and then equip idle set
-- 4/20/21: added code to sync DressUp blinking and lockstyle
function fashion_particulars()
	send_command('wait 1;input /lockstyleset 17;wait 1;gs equip idle.'..Idle_sets[Idle_ind])
end

function precast(spell)
	if spell.action_type == 'Magic' then
		if spell.name == 'Impact' then
			equip(sets.precast.Impact)
			-- add_to_chat(8,'---- Impact set equipped ----')
		elseif spell.name == 'Death' then
			equip(sets.precast.FCDeath)
			-- add_to_chat(8,'---- FCDeath set equipped ----')
		else
			equip(sets.precast.fastcast)
			-- add_to_chat(8,'---- Fastcast set equipped ----')
		end
	elseif spell.type == 'WeaponSkill' then
		if sets.WS[spell.name] then
			equip(sets.WS[spell.name])
		else
			equip(sets.WS)
		end
		--add_to_chat(8,'---- WS set equipped ----')
    end
end

function midcast(spell)
	--add_to_chat(8,'-- spell.skill:'..spell.skill..', MB:'..tostring(MB_mode)..'--')
	if spell.name:sub(1,5) == "Aspir" then
		weathercheck(spell.element,sets.midcast.Aspir)
		-- add_to_chat(8,'---- Aspir set equipped ----')
	elseif spell.name:sub(1,5) == "Drain" then
		weathercheck(spell.element,sets.midcast.Drain)
		-- add_to_chat(8,'---- Drain set equipped ----')
	elseif spell.name == "Impact" then 
		weathercheck(spell.element,sets.midcast.Impact)
	elseif sets.midcast[spell.name] then
		weathercheck(spell.element,sets.midcast[spell.name])
		-- add_to_chat(8,'---- ' .. spell.name .. ' set equipped ----')
	elseif sets.midcast[spell.skill] then
		-- Equip Magic Burst set (w/ obi check) if MB_mode == true
		if spell.skill == 'Elemental Magic' and MB_mode then
			weathercheck(spell.element,sets.midcast.MB)
			-- add_to_chat(8,'---- MB set equipped ----')
		-- otherwise equip Elemental Magic set w/ obi and zodiac check
		elseif spell.skill == 'Elemental Magic' and not MB_mode then
			weathercheck(spell.element,sets.midcast[spell.skill])
			-- add_to_chat(8,'---- ' .. spell.skill .. ' set equipped ----')
			-- zodiaccheck(spell.element)
		else
			weathercheck(spell.element,sets.midcast[spell.skill])
			-- add_to_chat(8,'---- ' .. spell.skill .. ' set equipped ----')
		end
	end
	
	if player.mpp < 25 then 
		equip(sets.midcast.MP)
	end
end

function aftercast(spell)
	equip(sets.idle[Idle_sets[Idle_ind]])
end

function weathercheck(spell_element,set)
    if not set then return end
    if spell_element == world.weather_element or spell_element == world.day_element then
        equip(set,sets.midcast.EleWeather)
    else
        equip(set)
    end
end

function zodiaccheck(spell_element)
	--add_to_chat(8,'---- spell_element:' .. spell_element .. ', day:' .. world.day_element .. ' ----')
    if spell_element == world.day_element and spell_element ~= 'Dark' and spell_element ~= 'Light' then
        equip(sets.midcast.Zodiac)
		add_to_chat(8,'---- Zodiac set equipped ----')
    end
end

-- happens when you switch between Engaged/Idle
function status_change(new,old)

end

-- happens when you gain or lose a buff
function buff_change(name,gain)

end

-- change modes throughout the rest of the script
-- executed by calling the following command in a macro:
-- /console gs c "command" 
-- where "command" is toggleTP, toggleIdle, etc.
-- change gear if we're already in the mode being changed
function self_command(command)
	if command == 'toggleMB' then
        MB_mode = not MB_mode --invert MB_mode
		printMB()
	elseif command == 'toggleIdle' then
        Idle_ind = Idle_ind%#Idle_sets +1
        send_command('@input /echo Idle gear set='..Idle_sets[Idle_ind])
		if player.status == 'Idle' then
			equip(sets.idle[Idle_sets[Idle_ind]])
		end
	end
end

function printMB()
	if(MB_mode) then 
		send_command('@input /echo MB_mode = ON')
	else
		send_command('@input /echo MB_mode = OFF')
	end
end
