function get_sets()

    sets.weapons = {main="Mikazuki",sub="Tenax strap"}
	
	-- Job Ability Sets
	sets.JA = {}
    sets.JA.Boost = {}
	
    sets.JA['Warding Circle'] = {}
		
	-- you might have to specify augments to differentiate duplicate items (e.g. JSE capes)
	-- head={name="Mummu bonnet +2", augments={'STR+4','AGI+4','Weapon Skill Acc.+15','Weapon skill damage +2%'}}
	
	-- Weapon skill sets
	sets.WS = {}
    sets.WS.default = set_combine(sets.weapons,{ammo="Tiphia sting",
		head="Windurstian hachimaki",neck="Peacock charm",ear1="Beetle earring",ear2="Beetle earring",
		body="Scorpion harness",hands="Custom M gloves",ring1="Ulthalam's ring",ring2="Rajas ring",
		back="Accura cape",waist="Swift belt",legs="Jujitsu sitabaki",feet="Mettle leggings"})
		
	-- variables used to cycle sets with self_command() below
	TP_sets = {'DT'}
    TP_ind = 1

    sets.tp = {}
	sets.tp.DT = set_combine(sets.weapons,{ammo="Tiphia sting",
		head="Windurstian hachimaki",neck="Peacock charm",ear1="Beetle earring",ear2="Beetle earring",
		body="Scorpion harness",hands="Custom M gloves",ring1="Ulthalam's ring",ring2="Rajas ring",
		back="Accura cape",waist="Swift belt",legs="Jujitsu sitabaki",feet="Mettle leggings"})
    
	-- variables used to cycle sets with self_command() below
	Idle_sets = {'DT'}
    Idle_ind = 1
	
	sets.idle = {}
    sets.idle.DT = sets.tp.DT
	
	-- glamor sets
	sets.fashion = {}
	sets.fashion.sam = {head="Windurstian hachimaki",body="Custom tunic",hands="Custom M gloves",
		legs="Jujitsu sitabaki",feet="Mettle leggings"}

    set_macro_book()
	fashion_particulars()
	send_command('@input /echo Idle gear set='..Idle_sets[Idle_ind])
	send_command('@input /echo TP gear set='..TP_sets[TP_ind])
end

-- Select default macro book on initial load or subjob change.
function set_macro_book()
	-- Default macro set/book
	send_command('wait 1;input /macro book 2;wait 1;input /macro set 1')
end

-- Equip fashion set, turn on lockstyle, and then equip idle set
function fashion_particulars()
	--send_command('wait 1;gs equip fashion.sam;wait 1;input /lockstyle on;wait 1;gs equip idle.'..Idle_sets[Idle_ind])
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
		equip(sets.WS.default)
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
	if new =='Engaged' then
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