function get_sets()
	
	--ambu capes
	tp_cape = { name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}}
	dex_wsd_cape = { name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}}
	
	-- JA Sets
	sets.JA = {}
	sets.JA.Samba = {
		head="Maxixi tiara +1",
		back=tp_cape
	}

	--Waltz potency + CHR
    sets.JA.Waltz = {ammo="Yamarang",
		neck="Etoile gorget +2",
		body="Maxixi casaque +1",ring1="Murky ring",
		back=tp_cape,feet="Maxixi toe shoes +2"
	}

	--High acc
    sets.JA.Step = {ammo="Yamarang",
		head="Maxixi tiara +1",neck="Etoile gorget +2",ear1="Telos earring",ear2="Maculele earring +1",
		body="Maculele casaque +3",hands="Maxixi bangles +4",ring1="Moonlight ring",ring2="Moonlight ring",
		back=tp_cape,waist="Sailfi belt +1",legs="Malignance tights",feet="Maculele toe shoes +3"
	}

	sets.JA.Step['Feather Step'] = set_combine(sets.JA.Step, {feet="Maculele toe shoes +3"})
    sets.JA.Jig = {feet="Maxixi toe shoes +2"}
	
    sets.JA['Violent Flourish'] = {body="Horos casaque +1"}

    sets.JA['Reverse Flourish'] = {hands="Maculele bangles +3"}

    sets.JA['Striking Flourish'] = {body="Maculele casaque +3"}
    sets.JA['Climactic Flourish'] = {head="Maculele tiara +3"}
    
	sets.JA['No Foot Rise'] = {body="Horos casaque +1"}
	
	sets.WS = {}
	sets.WS.default = {ammo="Coiste bodhar",
		head="Maculele tiara +3",neck="Etoile gorget +2",ear1="Moonshade earring",ear2="Maculele earring +1",
		body="Nyame mail",hands="Maxixi bangles +4",ring1="Ephramad's ring",ring2="Regal ring",
		back=dex_wsd_cape,waist="Sailfi belt +1",legs="Nyame flanchard",feet="Nyame sollerets"}
	
    --Midbuff sets
    sets.WS["Aeolian Edge"] = {ammo="Ghastly Tathlum +1",
		head="Nyame helm",neck="Etoile gorget +2",ear1="Moonshade earring",ear2="Friomisi earring",
		body="Nyame mail",hands="Maxixi bangles +4",ring1="Ephramad's ring",ring2="Regal ring",
		back=dex_wsd_cape,waist="Eschan stone",legs="Nyame flanchard",feet="Nyame sollerets"}

    --Gleti set, charis feather(ammo)
    sets.WS["Evisceration"] = {ammo="Coiste bodhar",
		head="Blistering sallet +1",neck="Etoile gorget +2",ear1="Odr earring",ear2="Maculele earring +1",
		body="Nyame mail",hands="Maxixi bangles +4",ring1="Gere ring",ring2="Regal ring",
		back=dex_wsd_cape,waist="Fotia belt",legs="Nyame flanchard",feet="Nyame sollerets"}

    sets.WS["Pyrrhic Kleos"] = {ammo="Coiste bodhar",
		head="Maculele tiara +3",neck="Fotia gorget",ear1="Sherida earring",ear2="Maculele earring +1",
		body="Nyame mail",hands="Maxixi bangles +4",ring1="Gere ring",ring2="Regal ring",
		back=dex_wsd_cape,waist="Fotia belt",legs="Nyame flanchard",feet="Nyame sollerets"}

    sets.WS["Rudra's Storm"] = {ammo="Coiste bodhar",
		head="Maculele tiara +3",neck="Etoile gorget +2",ear1="Moonshade earring",ear2="Maculele earring +1",
		body="Nyame mail",hands="Maxixi bangles +4",ring1="Ephramad's ring",ring2="Regal ring",
		back=dex_wsd_cape,waist="Kentarch belt +1",legs="Nyame flanchard",feet="Nyame sollerets"}
	
    sets.WS["Ruthless Stroke"] = {ammo="Cath palug stone",
		head="Maculele tiara +3",neck="Etoile gorget +2",ear1="Moonshade earring",ear2="Maculele earring +1",
		body="Nyame mail",hands="Maxixi bangles +4",ring1="Ephramad's ring",ring2="Regal ring",
		back=dex_wsd_cape,waist="Sailfi belt +1",legs="Nyame flanchard",feet="Nyame sollerets"}
	
    sets.tp = {}
	sets.tp.dd = {ammo="Coiste bodhar",
		head="Maculele tiara +3",neck="Etoile gorget +2",ear1="Telos earring",ear2="Sherida earring",
		body="Maculele casaque +3",hands="Malignance gloves",ring1="Ilabrat ring",ring2="Moonlight ring",
		back=tp_cape,waist="Reiki yotai",legs="Malignance tights",feet="Maculele toe shoes +3"}
	
    sets.status = {}
    sets.status.Engaged = sets.tp.dd
    
    sets.status.Idle = {ammo="Staunch tathlum +1",
		head="Nyame helm",neck="Bathy choker +1",ear1="Infused earring",ear2="Eabani earring",
		body="Nyame mail",hands="Maculele bangles +3",ring1="Murky ring",ring2="Shneddick ring",
		back="Archon cape",waist="Carrier's sash",legs="Nyame flanchard",feet="Maculele toe shoes +3"}
	
    set_macro_book()
	fashion_particulars()
end

-- Select default macro book on initial load or subjob change.
function set_macro_book()
	send_command('wait 1;input /macro book 5;wait 1;input /macro set 1')
end

-- Equip fashion set, turn on lockstyle, and then equip idle set
function fashion_particulars()
	send_command('wait 1;input /lockstyleset 23;wait 1;gs equip sets.status.Idle')
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
		--add_to_chat(8,'----' .. spell.name .. ' set equipped ----')
    elseif sets.WS[spell.name] then
        equip(sets.WS[spell.name])
		--add_to_chat(8,'----' .. spell.name .. ' set equipped ----')
	elseif sets.JA[spell.type] then
        equip(sets.JA[spell.type])
		--add_to_chat(8,'----' .. spell.type .. ' set equipped ----')
	elseif spell.type == 'WeaponSkill' then
		equip(sets.WS.default)
		--add_to_chat(8,'---- WS set equipped ----')
--        if buffactive['climactic flourish'] then
--            equip(sets.JA['Climactic Flourish'])
--        elseif buffactive['striking flourish'] then
--            equip(sets.JA['Striking Flourish'])
--        end
    end
end

function aftercast(spell)
    if sets.status[player.status] then
        equip(sets.status[player.status])
		--add_to_chat(8,'---- ' .. player.status .. ' set equipped ----')
    end
end

function status_change(new,old)
    if sets.status[new] then
        equip(sets.status[new])
    end
end