local lovely = require("lovely")

assert(SMODS.load_file('atlas.lua'))()
assert(SMODS.load_file("globals.lua"))()

ameliorates = SMODS.current_mod

-- Config tab
if NFS.read(SMODS.current_mod.path.."config.lua") then
    local file = STR_UNPACK(NFS.read(SMODS.current_mod.path.."config.lua"))
    ameliorates.config_path = SMODS.current_mod.path.."config.lua"
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
                    NFS.write(ameliorates.config_path, STR_PACK(ameliorates.config_file))
                end
            }),
            create_toggle({
                align = "tl",
                label = "Extra Jokers",
                ref_table = ameliorates.config_file,
                ref_value = "extras",
                callback = function(_set_toggle)
                    ameliorates.config_file.extras = _set_toggle
                    NFS.write(ameliorates.config_path, STR_PACK(ameliorates.config_file))
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

-- Decks
--assert(SMODS.load_file("items/decks.lua"))

-- Blinds
--assert(SMODS.load_file("items/blinds.lua"))

-- Jokers
assert(SMODS.load_file("items/jokers.lua"))

if ameliorates.config_file.ameliorates then
    assert(SMODS.load_file("items/jokers_ameliorates.lua"))()
end
if ameliorates.config_file.extras then
    assert(SMODS.load_file("items/jokers_extras.lua"))()
end