function get_sets()

	-- Job Ability Sets
	sets.JA = {}
	sets.JA.Aggressor = {body="Pummeler's mask +2"}
	sets.JA.Berserk = {body="Pummeler's lorica +2"}
	sets.JA.Retaliation = {body="Pummeler's mufflers"}
		
	-- Weapon skill sets
    sets.WS = {ammo="",
		head="Studded bandana",neck="Peacock amulet",ear1="Tourmaline earring",ear2="Bone earring",
		body="Brass harness",hands="Studded gloves",ring1="San d'Orian ring",ring2="Amethyst ring",
		back="",waist="",legs="Phlegethon's trousers",feet="Bounding boots"}
		
	-- sets.WS['Fell Cleave'] = {ammo="Knobkierrie",
		-- head="Nyame helm",neck="Warrior's bead necklace +2",ear1="Moonshade earring",ear2="Boii earring +1",
		-- body="Nyame mail",hands="Nyame gauntlets",ring1="Niqmaddu ring",ring2="Ephramad's ring",
		-- back="Atheling mantle",waist="Sailfi belt +1",legs="Nyame flanchard",feet="Nyame sollerets"}
		
	-- variables used to cycle sets with self_command() below
	TP_sets = {'DT'}
    TP_ind = 1

    sets.tp = {}
		
	sets.tp.DT = {ammo="",
		head="Studded bandana",neck="Peacock amulet",ear1="Tourmaline earring",ear2="Bone earring",
		body="Brass harness",hands="Studded gloves",ring1="San d'Orian ring",ring2="Amethyst ring",
		back="",waist="",legs="Phlegethon's trousers",feet="Bounding boots"}
    
	-- variables used to cycle sets with self_command() below
	Idle_sets = {'Speed','DT'}
    Idle_ind = 1
	
	sets.idle = {}
    sets.idle.Speed = {ammo="",
		head="Studded bandana",neck="Peacock amulet",ear1="Tourmaline earring",ear2="Bone earring",
		body="Brass harness",hands="Studded gloves",ring1="San d'Orian ring",ring2="Amethyst ring",
		back="",waist="",legs="Phlegethon's trousers",feet="Bounding boots"}
			
	sets.idle.DT = sets.idle.Speed
	
	-- glamor sets
	sets.fashion = {}

    set_macro_book()
	fashion_particulars()
	send_command('@input /echo Idle gear set='..Idle_sets[Idle_ind])
	send_command('@input /echo TP gear set='..TP_sets[TP_ind])
end

-- Select default macro book on initial load or subjob change.
function set_macro_book()
	-- Default macro set/book
	send_command('wait 1;input /macro book 1;wait 1;input /macro set 1')
end

-- Equip fashion set, turn on lockstyle, and then equip idle set
function fashion_particulars()
	send_command('wait 1;input /lockstyleset 34;gs equip idle.'..Idle_sets[Idle_ind])
end

function sub_job_change(new,old)
	set_macro_book()
	fashion_particulars()
end

function precast(spell)
	-- cancel buffs that don't automatically overwrite themselves
	if spell.name == 'Spectral Jig' and buffactive.sneak then
        windower.ffxi.cancel_buff(71)
    end
end

function midcast(spell)
    if sets.JA[spell.name] then
        equip(sets.JA[spell.name])
		--add_to_chat(8,'----' .. spell.name .. ' set equipped ----')
    elseif sets.WS[spell.name] then
		equip(sets.WS[spell.name])
		--add_to_chat(8,'----' .. spell.name .. ' set equipped ----')
	elseif spell.type=="WeaponSkill" then
		equip(sets.WS)
		--add_to_chat(8,'---- WS set equipped ----')
    end
end

function aftercast(spell)
    if player.status =='Engaged' then
		equip(sets.tp[TP_sets[TP_ind]])
    else
        equip(sets.idle[Idle_sets[Idle_ind]])
    end
end

-- executes when you enter/leave combat
function status_change(new,old)
    if player.status =='Engaged' then
		equip(sets.tp[TP_sets[TP_ind]])
    else
        equip(sets.idle[Idle_sets[Idle_ind]])
    end
end

-- change TP/Idle modes throughout the rest of the script
-- executed by calling the following command in a macro:
-- /console gs c "command" 
-- where "command" is toggleTP, toggleIdle, etc.
-- change gear if we're already in the mode being changed
function self_command(command)
    if command == 'toggleTP' then
		-- cycle sets by incrementing the set number and applying modulo
        TP_ind = TP_ind%#TP_sets +1
        send_command('@input /echo TP gear set='..TP_sets[TP_ind])
		if player.status == 'Engaged' then
			equip(sets.tp[TP_sets[TP_ind]])
		end
	elseif command == 'toggleIdle' then
        Idle_ind = Idle_ind%#Idle_sets +1
        send_command('@input /echo Idle gear set='..Idle_sets[Idle_ind])
		if player.status == 'Idle' then
			equip(sets.idle[Idle_sets[Idle_ind]])
		end
	end
end