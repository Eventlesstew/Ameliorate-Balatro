local lovely = require("lovely")

assert(SMODS.load_file('atlas.lua'))()
assert(SMODS.load_file("globals.lua"))()

ameliorates = SMODS.current_mod

-- Config tab
if NFS.read(SMODS.current_mod.path.."config.lua") then
    local file = STR_UNPACK(NFS.read(SMODS.current_mod.path.."config.lua"))
    ameliorates.config_file = file
end

G.FUNCS.restart_game_smods = function(e)
	SMODS.restart_game()
end

ameliorates.config_tab = function()
	return {
		n = G.UIT.ROOT,
		config = {
			emboss = 0.05,
			r = 0.1,
			align = "tl",
			padding = 0.2,
			colour = G.C.BLACK
		},
		nodes =  {
            create_toggle({
                align = "tl",
                label = "Ameliorates",
                ref_table = ameliorates.config_file,
                ref_value = "ameliorates",
                callback = function(_set_toggle)
                    ameliorates.config_file.ameliorates = _set_toggle
                    NFS.write(lovely.mod_dir.."/config.lua", STR_PACK(ameliorates.config_file))
                end
            }),
			create_toggle({
                align = "tl",
                label = "Please don't...",
                ref_table = ameliorates.config_file,
                ref_value = "onyx",
                callback = function(_set_toggle)
                    ameliorates.config_file.onyx = _set_toggle
                    NFS.write(lovely.mod_dir .. "/config.lua", STR_PACK(ameliorates.config_file))
                end
			}),
            create_toggle({
                align = "tl",
                label = "Extra Jokers",
                ref_table = ameliorates.config_file,
                ref_value = "extras",
                callback = function(_set_toggle)
                    ameliorates.config_file.extras = _set_toggle
                    NFS.write(lovely.mod_dir .. "/config.lua", STR_PACK(ameliorates.config_file))
                end
			}),
			UIBox_button({
                align = "tl",
                label = { "Apply Changes" }, 
                minw = 3.5,
                button = 'restart_game_smods'
			}),
		}
	}
end

-- Jokers
assert(SMODS.load_file("jokers/jokers.lua"))

if ameliorates.config_file.ameliorates then
    assert(SMODS.load_file("jokers/jokers_ameliorates.lua"))()
end
if ameliorates.config_file.onyx then
    assert(SMODS.load_file("jokers/jokers_onyx.lua"))()
end
if ameliorates.config_file.extras then
    assert(SMODS.load_file("jokers/jokers_extras.lua"))()
end