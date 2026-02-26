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

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal')
    state.WeaponskillMode:options('Normal')
    state.HybridMode:options('Normal')

    update_combat_form()
    update_melee_groups()

    select_default_macro_book()
	fashion_particulars()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    
    -- Precast sets to enhance JAs on use
    sets.precast.JA['Angon'] = {ammo="Angon"}
	sets.precast.JA['High Jump'] = {legs="Wyrm brais"}

    -- Fast cast sets for spells
    
    --sets.precast.FC = {ammo="Impatiens",head="Haruspex hat",ear2="Loquacious Earring",hands="Thaumas Gloves"}

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Astrolabe",
        head="Wyrm armet",neck="Fotia gorget",ear1="Pixie earring",ear2="Ethereal earring",
        body="Nuevo coselete",hands="Custom M gloves",ring1="Rajas ring",ring2="Ulthalam's ring",
        back="Amemet mantle +1",waist="Swift belt",legs="Askar dirs",feet="Bounding boots"}

    -- Idle sets
    sets.idle = {ammo="Astrolabe",
        head="Zeal cap",neck="Peacock charm",ear1="Pixie earring",ear2="Ethereal earring",
        body="Nuevo coselete",hands="Custom M gloves",ring1="Rajas ring",ring2="Ulthalam's ring",
        back="Amemet mantle +1",waist="Swift belt",legs="Crimson cuisses",feet="Bounding boots"}

    sets.Kiting = {legs="Crimson cuisses"}

    --sets.ExtraRegen = {head="Ocelomeh Headpiece +1"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee sets
    sets.engaged = {ammo="Astrolabe",
        head="Zeal cap",neck="Peacock charm",ear1="Pixie earring",ear2="Ethereal earring",
        body="Nuevo coselete",hands="Custom M gloves",ring1="Rajas ring",ring2="Ulthalam's ring",
        back="Amemet mantle +1",waist="Swift belt",legs="Askar dirs",feet="Bounding boots"}

	-- Fashion sets
	sets.fashion = {}
	
	sets.fashion.relic = {
		head="Wyrm armet",body="Wyrm mail",hands="Custom M gloves",
		legs="Wyrm brais",feet="Custom M boots"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 18)
end

function fashion_particulars()
	send_command('wait 1;gs equip sets.fashion.relic;wait 1;input /lockstyle on;wait 1;gs equip sets.idle')
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Don't gearswap for weaponskills when Defense is on.
    if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
        eventArgs.handled = true
    end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
        -- Replace Moonshade Earring if we're at cap TP
        if player.tp == 3000 then
            equip(sets.precast.MaxTP)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' and not spell.interrupted and state.FootworkWS and state.Buff.Footwork then
        send_command('cancel Footwork')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)

end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
    -- if player.hpp < 75 then
        -- idleSet = set_combine(idleSet, sets.ExtraRegen)
    -- end
    
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    update_combat_form()
    update_melee_groups()
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()

end

function update_melee_groups()
    classes.CustomMeleeGroups:clear()

end
