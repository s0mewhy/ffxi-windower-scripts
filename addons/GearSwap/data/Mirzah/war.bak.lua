function get_sets()

    sets.weapons = {main="Centurion's axe",sub="",ammo="Attar of roses"}
	
	-- JA Sets
	sets.JA = {}
	    
    sets.tp = {}

	sets.tp.dd = {
		head="Walkure mask",neck="Peacock amulet",ear1="Bloodbead earring",ear2="Bone earring",
		body="Brigandine armor",hands="Savage gauntlets",ring1="Amber ring",ring2="Clear ring",
		back="Dhalmel mantle",waist="Pinwheel belt",legs="Savage loincloth",feet="Savage gaiters"}
    
	sets.WS = {
		head="Walkure mask",neck="Peacock amulet",ear1="Bloodbead earring",ear2="Bone earring",
		body="Brigandine armor",hands="Savage gauntlets",ring1="Amber ring",ring2="Clear ring",
		back="Dhalmel mantle",waist="Pinwheel belt",legs="Savage loincloth",feet="Savage gaiters"}
	
    sets.status = {}
    sets.status.Engaged = sets.tp.dd
    
    sets.status.Idle = {
		head="Walkure mask",neck="Peacock amulet",ear1="Bloodbead earring",ear2="Bone earring",
		body="Brigandine armor",hands="Savage gauntlets",ring1="Amber ring",ring2="Clear ring",
		back="Dhalmel mantle",waist="Pinwheel belt",legs="Savage loincloth",feet="Savage gaiters"}

	sets.fashion = {
		head="Walkure mask",neck="Peacock amulet",ear1="Bloodbead earring",ear2="Bone earring",
		body="Savage separates",hands="Savage gauntlets",ring1="Amber ring",ring2="Clear ring",
		back="Dhalmel mantle",waist="Pinwheel belt",legs="Savage loincloth",feet="Savage gaiters"}
	
    set_macro_book()
	fashion_particulars()
end

-- Select default macro book on initial load or subjob change.
function set_macro_book()
	-- Default macro set/book
	if player.sub_job == 'SAM' then
		send_command('wait 1;input /macro book 1;wait 1;input /macro set 1')
	else
		send_command('wait 1;input /macro book 1;wait 1;input /macro set 1')
	end
end

-- Equip fashion set, turn on lockstyle, and then equip idle set
function fashion_particulars()
	send_command('wait 1;gs equip fashion;wait 1;input /lockstyle on;wait 1;gs equip status.Idle')
end

function sub_job_change(new,old)
	set_macro_book()
	fashion_particulars()
end

function precast(spell)
--    code here to cancel buffs that don't automatically overwrite themselves
	if spell.name == 'Spectral Jig' and buffactive.sneak then
        windower.ffxi.cancel_buff(71)
    end
end

function midcast(spell)
	if sets.JA[spell.name] then
        equip(sets.JA[spell.name])
		add_to_chat(8,'----' .. spell.name .. ' set equipped ----')
    elseif sets.WS[spell.name] then
        equip(sets.WS[spell.name])
		add_to_chat(8,'----' .. spell.name .. ' set equipped ----')
	elseif sets.JA[spell.type] then
        equip(sets.JA[spell.type])
		add_to_chat(8,'----' .. spell.type .. ' set equipped ----')
	elseif spell.type == 'WeaponSkill' then
		equip(sets.WS)
		add_to_chat(8,'---- WS set equipped ----')
    end
end

function aftercast(spell)
    if sets.status[player.status] then
        equip(sets.status[player.status])
		add_to_chat(8,'---- ' .. player.status .. ' set equipped ----')
    end
end

function status_change(new,old)
    if sets.status[new] then
        equip(sets.status[new])
    end
end