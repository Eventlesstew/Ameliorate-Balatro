SMODS.Atlas({
    key = "reese",
    path = "reese.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "reese",                                  --name used by the joker.    
    config = { extra = { x_mult = 2} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 1,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 5,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'reese',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if context.joker_main and context.cardarea == G.jokers then
            if not G.GAME.blind.boss then
                return {
                    x_mult = card.ability.extra.x_mult, 
                    colour = G.C.MULT
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = { card.ability.extra.x_mult}, key = self.key }
    end
}

SMODS.Atlas({
    key = "guira",
    path = "guira.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "guira",                                  --name used by the joker.    
    config = { extra = {chip_mod = 15, chips = 0} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 1,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 4,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos={ x = 1, y = 0 },                                        --pos of a soul sprite.
    atlas = 'guira',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if context.joker_main and context.cardarea == G.jokers then
            card.ability.extra.chips = card.ability.extra.chip_mod * #G.jokers.cards
            return {
                chips = card.ability.extra.chips,
                colour = G.C.CHIPS
            }
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {card.ability.extra.chip_mod * (G.jokers and #G.jokers.cards or 0), card.ability.extra.chip_mod}, key = self.key }
    end
}

SMODS.Atlas({
    key = "arpeggidough",
    path = "arpeggidough.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "arpeggidough",                                  --name used by the joker.    
    config = { extra = {} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 1,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 6,                                            --cost to buy the joker in shops.
    blueprint_compat=false,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'arpeggidough',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)
        if not context.blueprint then
            if context.first_hand_drawn then
                local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
                juice_card_until(card, eval, true)
            end

            if context.before and G.GAME.current_round.hands_played == 0 and #context.full_hand == 1 then
                local scored_card = context.scoring_hand[1]

                local options = get_current_pool('Enhanced')
                for k, v in pairs(options) do
                    if v == 'm_stone' or v == scored_card.config.center.key then
                        table.remove(options, k)
                    end
                end
                scored_card:set_ability(SMODS.poll_enhancement({guaranteed = true, options = options}), nil, true)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        scored_card:juice_up()
                        return true
                    end
                }))
                return {
                    message = localize('k_upgrade_ex'),
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {}, key = self.key }
    end
}

SMODS.Atlas({
    key = "meeka",
    path = "meeka.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "meeka",                                  --name used by the joker.    
    config = { extra = {odds = 2} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 1,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 6,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'meeka',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if context.repetition and context.cardarea == G.play then
            if SMODS.pseudorandom_probability(card, 'meeka', 1, card.ability.extra.odds) then
                return {
                    repetitions = 1
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'meeka')
        return { vars = {numerator, denominator}, key = self.key }
    end
}

SMODS.Atlas({
    key = "etikan",
    path = "etikan.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "etikan",
    config = { extra = { chips = 0, chip_mod = 1 } },
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 5,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat=false,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'etikan',

    calculate = function(self,card,context)
        if not context.blueprint then
            if context.discard and not context.other_card.debuff then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
                    
                return {
                    extra = {focus = card, message = localize('k_upgrade_ex')},
                    colour = G.C.CHIPS
                }
            end
        end
        if context.joker_main and context.cardarea == G.jokers then
            return {
                chips = card.ability.extra.chips, 
                colour = G.C.CHIPS
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chip_mod }, key = self.key }
    end
}

SMODS.Atlas({
    key = "tabi",
    path = "tabi.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "tabi",
    config = {extra = { x_mult_mod_joker = 0.5, x_mult_mod_card = 0.1, x_mult = 1}},
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat=false,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'tabi',
    soul_pos = nil,

    calculate = function(self, card, context)
        if not context.blueprint then
            local upgrade = false
            if context.joker_type_destroyed and context.card then
                card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_mod_joker
                upgrade = true
            end
            if context.remove_playing_cards then
                card.ability.extra.x_mult = card.ability.extra.x_mult + (card.ability.extra.x_mult_mod_card * #context.removed)
                upgrade = true
            end
            if upgrade then
                return { message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } } }
            end
        end
        if context.joker_main and context.cardarea == G.jokers then
            return {
                colour = G.C.RED,
                x_mult = card.ability.extra.x_mult
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, card.ability.extra.x_mult_mod_joker, card.ability.extra.x_mult_mod_card} }
    end
}

SMODS.Atlas({
    key = "yaun",
    path = "yaun.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "yaun",                                  --name used by the joker.    
    config = { extra = {x_mult = 3} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 2,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 6,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'yaun',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if context.joker_main and context.cardarea == G.jokers then
            if G.GAME.current_round.hands_played == 0 then
                return {
                    x_mult = card.ability.extra.x_mult, 
                    colour = G.C.MULT
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {card.ability.extra.x_mult}, key = self.key }
    end
}

SMODS.Atlas({
    key = "esckickis",
    path = "esckickis.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "esckickis",                                  --name used by the joker.    
    config = { extra = {x_mult = 1, x_mult_mod = 1} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 2,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 6,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'esckickis',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if not context.blueprint then
            if context.before then
                card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_mod
                return {                             -- shows a message under the specified card (card) when it triggers, k_upgrade_ex is a key in the localization files of Balatro
                    extra = {focus = card, message = localize('k_upgrade_ex')},
                    colour = G.C.MULT
                }
            end
            if context.end_of_round and context.game_over == false and context.main_eval then
                card.ability.extra.x_mult = 1
                return {                             -- shows a message under the specified card (card) when it triggers, k_upgrade_ex is a key in the localization files of Balatro
                    extra = {focus = card, message = localize('k_reset')},
                    colour = G.C.MULT
                }
            end
        end
        if context.joker_main and context.cardarea == G.jokers then
            return { -- returns total chips from joker to be used in scoring, no need to show message in joker_main phase, game does it for us.
                x_mult = card.ability.extra.x_mult,
                colour = G.C.MULT
            }
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {card.ability.extra.x_mult, card.ability.extra.x_mult_mod}, key = self.key }
    end
}

SMODS.Atlas({
    key = "nillacorn",
    path = "nillacorn.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "nillacorn",                                  --name used by the joker.    
    config = { extra = {chips = 50, chip_mod = 5} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 2,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 8,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=false,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    atlas = 'nillacorn',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if context.after and not context.blueprint then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {card.ability.extra.chips, card.ability.extra.chip_mod}, key = self.key }
    end
}

SMODS.Atlas({
    key = "jugashley",
    path = "jugashley.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "jugashley",                                  --name used by the joker.    
    config = { extra = {chips = 0, mult = 0, chip_mod = 50, mult_mod = 8, poker_hand = 'Straight Flush'} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 2,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 5,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=false,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'jugashley',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if context.before and not context.blueprint and next(context.poker_hands[card.ability.extra.poker_hand]) then
            -- See note about SMODS Scaling Manipulation on the wiki
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.PURPLE,
            }
        end
        if context.joker_main and context.cardarea == G.jokers then
            local effects = {
                {
                    chips = card.ability.extra.chips, 
                    colour = G.C.CHIPS
                },
                {
                    mult = card.ability.extra.mult, 
                    colour = G.C.MULT
                }
            }
            return SMODS.merge_effects(effects)
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {card.ability.extra.chips, card.ability.extra.chip_mod, card.ability.extra.mult, card.ability.extra.mult_mod, card.ability.extra.poker_hand}, key = self.key }
    end
}

SMODS.Atlas({
    key = "orgako",
    path = "orgako.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "orgako",                                  --name used by the joker.    
    config = { extra = {odds = 4} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 2,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 7,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'orgako',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if context.repetition and context.cardarea == G.play then
            if context.other_card:get_edition() then
                return {
                    repetitions = 1
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {}, key = self.key }
    end
}

SMODS.Atlas({
    key = "alliumaid",
    path = "alliumaid.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "alliumaid",                                  --name used by the joker.    
    config = { extra = {dollars = 1, dollar_mod = 1, dollar_limit = 10} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 2,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 8,                                            --cost to buy the joker in shops.
    blueprint_compat=false,                               --does joker work with blueprint.
    eternal_compat=false,                                 --can joker be eternal.
    perishable_compat=false,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'alliumaid',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if not context.blueprint then
            if context.after then
                card.ability.extra.dollars = card.ability.extra.dollars + card.ability.extra.dollar_mod
                if card.ability.extra.dollars > card.ability.extra.dollar_limit then
                    card.ability.extra.dollars = 1
                    return {
                        message = localize('k_clean_ex'),
                        colour = G.C.MONEY,
                    }
                else
                    return {
                        message = localize('k_upgrade_ex'),
                        colour = G.C.MONEY,
                    }
                end
            end
        end
    end,

    calc_dollar_bonus = function(self, card)
        return card.ability.extra.dollars
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {card.ability.extra.dollars, card.ability.extra.dollar_mod, card.ability.extra.dollar_limit}, key = self.key }
    end
}

SMODS.Atlas({
    key = "expifour",
    path = "expifour.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "expifour",                                  --name used by the joker.    
    config = { extra = { min = 1, max = 4} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 2,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 6,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'expifour',                                --atlas name, single sprites are deprecated.

    

    calculate = function(self,card,context)              --define calculate functions here
        if context.joker_main and context.cardarea == G.jokers then
            return {
                x_mult = pseudorandom('expifour', card.ability.extra.min, card.ability.extra.max), 
                colour = G.C.MULT
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        local r_mults = {}
        for i = card.ability.extra.min, card.ability.extra.max do
            r_mults[#r_mults + 1] = tostring(i)
        end
        local loc_mult = ' ' .. (localize('k_mult')) .. ' '
        main_start = {
            {
                n = G.UIT.C,
                config = {
                    colour = G.C.RED,
                    res = 1,
                    padding = 0.02,
                },
                nodes = {
                    { 
                        n = G.UIT.T,
                        config = {
                            text = 'X',
                            colour = G.C.WHITE,
                            scale = 0.32,
                        }
                    },
                    { 
                        n = G.UIT.O, 
                        config = { 
                            object = DynaText({
                                string = r_mults,
                                colours = {G.C.WHITE},
                                pop_in_rate = 9999999,
                                silent = true,
                                random_element = true,
                                pop_delay = 0.5,
                                scale = 0.32,
                                min_cycle_time = 0,
                            })
                        } 
                    },
                }
            },
            {
                n = G.UIT.O,
                config = {
                    object = DynaText({
                        string = {
                            {string = 'rand()', colour = G.C.JOKER_GREY},
                            {string = "#@" .. (G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.id or 11) .. (G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.suit:sub(1, 1) or 'D'), colour = G.C.RED },
                            loc_mult,
                            loc_mult,
                            loc_mult,
                            loc_mult,
                            loc_mult,
                            loc_mult,
                            loc_mult,
                            loc_mult,
                            loc_mult,
                            loc_mult,
                            loc_mult,
                            loc_mult,
                            loc_mult,
                        },
                        colours = { G.C.UI.TEXT_DARK },
                        pop_in_rate = 9999999,
                        silent = true,
                        random_element = true,
                        pop_delay = 0.2011,
                        scale = 0.32,
                        min_cycle_time = 0
                    })
                }
            },
        }
        
        return { main_start = main_start, vars = {r_value}, key = self.key }
    end,
}

SMODS.Atlas({
    key = "octosquish",
    path = "octosquish.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "octosquish",                                  --name used by the joker.    
    config = { extra = {chips = 50, mult = 15, x_mult = 2, dollars = 3, action = 0} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 2,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 5,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'octosquish',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if context.joker_main and context.cardarea == G.jokers then
            local action = G.GAME.current_round.ameliorates_octosquish
            if action == 1 then
                return {
                    chips = card.ability.extra.chips, 
                    colour = G.C.CHIPS
                }
            elseif action == 2 then
                return {
                    mult = card.ability.extra.mult, 
                    colour = G.C.MULT
                }
            elseif action == 3 then
                return {
                    x_mult = card.ability.extra.x_mult, 
                    colour = G.C.MULT
                }
            elseif action == 4 then
                return {
                    dollars = card.ability.extra.dollars,
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        vars = {card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.x_mult, card.ability.extra.dollars}
        local action = G.GAME.current_round.ameliorates_octosquish or 0
        local msg2b = G.C.WHITE
        local msg2v = G.C.BLACK
        local msg1 = ''
        local msg2 = ''
        local msg3 = ''
        if action == 0 then
            msg1 = 'does nothing'
        elseif action == 1 then
            msg2v = G.C.CHIPS
            msg2 = localize('k_plus') .. tostring(card.ability.extra.chips)
            msg3 = ' ' .. localize('k_chips') 
        elseif action == 2 then
            msg2v = G.C.MULT
            msg2 = localize('k_plus') .. tostring(card.ability.extra.mult)
            msg3 = ' ' .. localize('k_mult')
        elseif action == 3 then
            msg2b = G.C.MULT
            msg2v = G.C.WHITE
            msg2 = localize('k_x') .. tostring(card.ability.extra.x_mult)
            msg3 = ' ' .. localize('k_mult')
        elseif action == 4 then
            msg1 = 'grants '
            msg2v = G.C.MONEY
            msg2 = localize('k_dollar') .. tostring(card.ability.extra.dollars)
        end

        main_end = {
            n = G.UIT.T,
            config = {text = actionMSG, scale = 0.32}
        }
        return {vars = {card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.x_mult, card.ability.extra.dollars, msg1, msg2, msg3, colours = {msg2v, msg2b} }, key = self.key }
    end
}

local function reset_ameliorates_octosquish()
    G.GAME.current_round.ameliorates_octosquish = pseudorandom('octosquish', 0, 4)
end

SMODS.Atlas({
    key = "trashcymbal",
    path = "trashcymbal.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "trashcymbal",                                  --name used by the joker.    
    config = { extra = {chips = 63, mult = 20} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 2,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 7,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'trashcymbal',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if context.setting_blind and not context.blueprint then
            if (G.GAME.round % 2) == 0 then
                return {
                    message = localize('k_mult_ex'),
                    colour = G.C.MULT
                }
            else
                return {
                    message = localize('k_chips_ex'),
                    colour = G.C.CHIPS
                }
            end
        end
        if context.joker_main and context.cardarea == G.jokers then
            if (G.GAME.round % 2) == 0 then
                return {
                    mult = card.ability.extra.mult, 
                    colour = G.C.MULT
                }
            else
                return {
                    chips = card.ability.extra.chips, 
                    colour = G.C.CHIPS
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        local evenRound = (G.GAME.round % 2) == 0

        local currentVal = (evenRound and card.ability.extra.mult) or card.ability.extra.chips
        local currentCol = (evenRound and G.C.MULT) or G.C.CHIPS
        local currentType = (evenRound and 'Mult') or 'Chips'

        return { vars = {card.ability.extra.chips, card.ability.extra.mult, currentVal, currentType, colours = {currentCol}}, key = self.key }
    end
}



SMODS.Atlas({
    key = "dormana",
    path = "dormana.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "dormana",                                  --name used by the joker.    
    config = { extra = {odds = 4} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 3,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 8,                                            --cost to buy the joker in shops.
    blueprint_compat=false,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos={x = 1, y = 0},                                        --pos of a soul sprite.
    atlas = 'dormana',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if context.individual and context.cardarea == G.play and
            #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if (context.other_card:get_id() == 2) and SMODS.pseudorandom_probability(card, 'dormana', 1, card.ability.extra.odds) then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                return {
                    extra = {
                        message = localize('k_plus_spectral'),
                        message_card = card,
                        func = function() -- This is for timing purposes, everything here runs after the message
                            G.E_MANAGER:add_event(Event({
                                func = (function()
                                    SMODS.add_card {
                                        set = 'Spectral',
                                        key_append = 'dormana' -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
                                    }
                                    G.GAME.consumeable_buffer = 0
                                    return true
                                end)
                            }))
                        end
                    },
                }
            end
        end
        --[[
        if not context.blueprint then
            if context.before then
                local enhanced = 0
                for _, scored_card in ipairs(context.scoring_hand) do
                    if not scored_card:get_edition() then 
                        if SMODS.pseudorandom_probability(card, 'dormana', 1, card.ability.extra.odds) then
                            local edition = poll_edition('dormana_edition', nil, true, true, {'e_polychrome', 'e_holo', 'e_foil'})
                            scored_card:set_edition(edition, true)
                            enhanced = enhanced + 1
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    scored_card:juice_up()
                                    return true
                                end
                            }))
                        end
                    end
                end
                if enhanced > 0 then
                    return {
                        message = localize('k_upgrade_ex'),
                        colour = G.C.MONEY
                    }
                end
            end
        end
        ]]
    end,

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'dormana')
        return { vars = {numerator, denominator}, key = self.key }
    end
}

SMODS.Atlas({
    key = "nnoygon",
    path = "nnoygon.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "nnoygon",                                  --name used by the joker.    
    config = { extra = {x_mult = 1, x_mult_mod = 0.05, suit = 'Diamonds'} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 3,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 9,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=false,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'nnoygon',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit(card.ability.extra.suit) then
                card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_mod
                return {                             -- shows a message under the specified card (card) when it triggers, k_upgrade_ex is a key in the localization files of Balatro
                    extra = {focus = card, message = localize('k_upgrade_ex')},
                    card = card,
                    colour = G.C.MULT
                }
            end
        end
        if context.joker_main and context.cardarea == G.jokers then
            return {
                x_mult = card.ability.extra.x_mult, 
                colour = G.C.MULT
            }
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {card.ability.extra.x_mult, card.ability.extra.x_mult_mod, localize(card.ability.extra.suit, 'suits_singular')}, key = self.key }
    end
}

SMODS.Atlas({
    key = "organe",
    path = "organe.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "organe",                                  --name used by the joker.    
    config = { extra = {} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 3,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 8,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'organe',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if context.first_hand_drawn then
            local _card = SMODS.create_card { set = "Base", enhancement = 'm_glass', area = G.discard }
            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            _card.playing_card = G.playing_card
            table.insert(G.playing_cards, _card)

            G.E_MANAGER:add_event(Event({
                func = function()
                    G.hand:emplace(_card)
                    _card:start_materialize()
                    G.GAME.blind:debuff_card(_card)
                    G.hand:sort()
                    if context.blueprint_card then
                        context.blueprint_card:juice_up()
                    else
                        card:juice_up()
                    end
                    SMODS.calculate_context({ playing_card_added = true, cards = { _card } })
                    save_run()
                    return true
                end
            }))

            return nil, true -- This is for Joker retrigger purposes
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {}, key = self.key }
    end
}

SMODS.Atlas({
    key = "robby",
    path = "robby.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "robby",                                  --name used by the joker.    
    config = { extra = {chips = 50, mult = 7} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 3,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 8,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'robby',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if context.individual and context.cardarea == G.play then
            
            local effects = {}

            if context.other_card:is_suit(G.GAME.current_round.robby_suit_1.suit) then
                effects[#effects + 1] = {
                    chips = card.ability.extra.chips, 
                    colour = G.C.MULT,
                    focus = card
                }
            end
            if context.other_card:is_suit(G.GAME.current_round.robby_suit_2.suit) then
                effects[#effects + 1] = {
                    mult = card.ability.extra.mult, 
                    colour = G.C.MULT,
                    focus = card
                }
            end
            if effects then
                return SMODS.merge_effects(effects)
            end
            
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        local suit1 = (G.GAME.current_round.robby_suit_1 or {}).suit or 'Spades'
        local suit2 = (G.GAME.current_round.robby_suit_2 or {}).suit or 'Hearts'
        return { vars = {card.ability.extra.chips, localize(suit1, 'suits_singular'), card.ability.extra.mult, localize(suit2, 'suits_singular'), colours = {G.C.SUITS[suit1], G.C.SUITS[suit2]}}, key = self.key }
    end
}

local function reset_ameliorates_robby()
    G.GAME.current_round.robby_suit_1 = {suit = 'Spades'}
    G.GAME.current_round.robby_suit_2 = {suit = 'Hearts'}

    local valid_robby_cards_1 = {}
    for _, playing_card in ipairs(G.playing_cards) do
        if not SMODS.has_no_suit(playing_card) then
            valid_robby_cards_1[#valid_robby_cards_1 + 1] = playing_card
        end
    end

    local robby_card_1 = pseudorandom_element(valid_robby_cards_1, 'robby1' .. G.GAME.round_resets.ante)
    if robby_card_1 then
        G.GAME.current_round.robby_suit_1.suit = robby_card_1.base.suit
    end

    local valid_robby_cards_2 = {}
    for _, playing_card in ipairs(G.playing_cards) do
        if (not SMODS.has_no_suit(playing_card)) and playing_card.base.suit ~= G.GAME.current_round.robby_suit_1.suit then
            valid_robby_cards_2[#valid_robby_cards_2 + 1] = playing_card
        end
    end

    local robby_card_2 = pseudorandom_element(valid_robby_cards_2, 'robby2' .. G.GAME.round_resets.ante)
    if robby_card_2 then
        G.GAME.current_round.robby_suit_2.suit = robby_card_2.base.suit
    else
        G.GAME.current_round.robby_suit_2.suit = G.GAME.current_round.robby_suit_1.suit
    end
end

SMODS.Atlas({
    key = "vack",
    path = "vack.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "vack",                                  --name used by the joker.    
    config = { extra = {x_mult = 1, x_mult_mod = 0.2} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 3,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 9,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'vack',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if not context.blueprint then
            if context.individual and context.cardarea == G.play then
                card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_mod
                return {
                    extra = {focus = card, message = localize('k_upgrade_ex')},
                    card = card,
                    colour = G.C.MULT
                }
            end
            if context.end_of_round and context.game_over == false and context.main_eval then
                if context.beat_boss and card.ability.extra.x_mult > 1 then
                    card.ability.extra.x_mult = 1
                    return {
                        message = localize('k_reset'),
                        colour = G.C.MULT
                    }
                end
            end
        end

        if context.joker_main and context.cardarea == G.jokers then
            return {
                x_mult = card.ability.extra.x_mult, 
                colour = G.C.MULT
            }
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {card.ability.extra.x_mult, card.ability.extra.x_mult_mod}, key = self.key }
    end
}

SMODS.Atlas({
    key = "rallentando",
    path = "rallentando.png",
    px = 71,
    py = 95
})

-- Have him eating lettuce with the expression referencing the fucking chewing face you can't escape from
SMODS.Joker{
    key = "rallentando",                                  --name used by the joker.    
    config = {extra = {chosen_joker = nil}},    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 3,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 10,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'rallentando',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if not context.blueprint then
            if context.setting_blind or context.after or
                (context.buying_card and context.card.config.center.key == self.key and context.cardarea == G.jokers) or 
                (context.card and (context.joker_type_destroyed or (context.selling_card and context.card.ability.set == 'Joker')))
            then
                local compat_jokers = {}
                for _,joker in pairs(G.jokers.cards) do
                    if joker ~= card and joker.config.center.blueprint_compat then
                        compat_jokers[#compat_jokers + 1] = joker
                    end
                end
                card.ability.extra.chosen_joker = pseudorandom_element(compat_jokers, 'rallentando' .. G.GAME.round_resets.ante)
            end
        end
        
        if card.ability.extra.chosen_joker then
            return SMODS.blueprint_effect(card, card.ability.extra.chosen_joker, context)
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {}, key = self.key }
    end
}

SMODS.Atlas({
    key = "semohseaga",
    path = "semohseaga.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "semohseaga",                                  --name used by the joker.    
    config = { extra = {dollars = 4, dollar_mod = 4} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 3,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 9,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'semohseaga',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if context.end_of_round and context.game_over == false and context.main_eval then
            card.ability.extra.dollars = card.ability.extra.dollars + card.ability.extra.dollar_mod
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MONEY,
            }
        end
        if context.after then
            if SMODS.calculate_round_score() > G.GAME.blind.chips then
                card.ability.extra.dollars = 4
                return {
                    message = localize('k_reset'),
                    colour = G.C.MONEY,
                }
            end
        end
    end,

    calc_dollar_bonus = function(self, card)
        return card.ability.extra.dollars
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {card.ability.extra.dollars, card.ability.extra.dollar_mod}, key = self.key }
    end
}

SMODS.Atlas({
    key = "athenerd",
    path = "athenerd.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "athenerd",                                  --name used by the joker.    
    config = { extra = {x_mult = 4} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 3,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 8,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'athenerd',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if context.joker_main and context.cardarea == G.jokers then
            if next(context.poker_hands[G.GAME.current_round.ameliorates_athenerd]) then
                return {
                    xmult = card.ability.extra.x_mult
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        local poker_hand = G.GAME.current_round.ameliorates_athenerd or "Flush House"
        return {
            vars = {
                card.ability.extra.x_mult,
                poker_hand,
            },
            key = self.key
        }
    end
}

local function reset_ameliorates_athenerd()
    local hands = {
        "Straight",
        "Flush",
        "Full House",
        "Straight Flush",
        "Five of a Kind",
        "Flush House",
        "Flush Five"
    }
    G.GAME.current_round.ameliorates_athenerd = hands[pseudorandom('athenerd', 1, #hands)]
end

SMODS.Atlas({
    key = "kassbick",
    path = "kassbick.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "kassbick",                                  --name used by the joker.    
    config = { extra = {suit = 'Clubs'} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 3,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 8,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'kassbick',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if context.repetition and context.cardarea == G.play then
            if context.other_card:is_suit(card.ability.extra.suit) then
                return {
                    repetitions = 1
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {localize(card.ability.extra.suit, 'suits_singular')}, key = self.key }
    end
}

SMODS.Atlas({
    key = "deltah",
    path = "deltah.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "deltah",                                  --name used by the joker.    
    config = { 
        extra = {x_mult = 3, odds = 3, rank = 3},
    },
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 3,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 9,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'deltah',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == card.ability.extra.rank then
                if SMODS.pseudorandom_probability(card, 'deltah', 1, card.ability.extra.odds) then
                    return {
                        x_mult = card.ability.extra.x_mult,
                        colour = G.C.MULT
                    }
                end
            end
        end
            --[[
            local my_pos = 1
            local joker_count = G.jokers.config.card_limit
            
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_pos = i
                    break
                end
            end
            
            local x_mult_gain = (((card.ability.extra.x_mult_mod - 1) * (joker_count - my_pos)) / (joker_count - 1)) + 1
            if x_mult_gain < 1 then
                x_mult_gain = 1
            end

            return {
                x_mult = x_mult_gain,
                colour = G.C.MULT
            }
            ]]
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        --[[
        local joker_count = 5
        local my_pos = 1
        if G.jokers then
            joker_count = G.jokers.config.card_limit
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_pos = i
                    break
                end
            end
        end

        local x_mult_gain = (((card.ability.extra.x_mult_mod - 1) * (joker_count - my_pos)) / (joker_count - 1)) + 1
        if x_mult_gain < 1 then
            x_mult_gain = 1
        end
        local x_mult_gradient = (card.ability.extra.x_mult_mod - 1) / (joker_count - 1)
        return { vars = {x_mult_gain, card.ability.extra.x_mult_mod, x_mult_gradient}, key = self.key }
        ]]
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'deltah')
        return { vars = {numerator, denominator, card.ability.extra.x_mult, card.ability.extra.rank}, key = self.key }
    end
}

--[[
local function get_deltah_x_mult(position, slots, x_mult_mod)
    local x_mult = (((1 - x_mult_mod) * (slots-position)) / (slots - 1)) + 1
    if x_mult < 1 then
        x_mult = 1
    end
    return x_mult
end
]]



SMODS.Atlas({
    key = "spotscast",
    path = "spotscast.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "spotscast",                                  --name used by the joker.    
    config = { extra = {odds = 3, jokers = {}} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                             --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    soul_pos = { x = 1, y = 0 },
    rarity = 4,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 20,                                            --cost to buy the joker in shops.
    blueprint_compat=false,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    atlas = 'spotscast',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if not context.blueprint then
            if context.setting_blind or context.after or
                (context.buying_card and context.card.config.center.key == self.key and context.cardarea == G.jokers) or 
                (context.card and (context.joker_type_destroyed or (context.selling_card and context.card.ability.set == 'Joker')))
            then
                card.ability.extra.jokers = {}
                for _,joker in pairs(G.jokers.cards) do
                    if joker ~= card and joker.config.center.blueprint_compat and SMODS.pseudorandom_probability(card, 'spotscast', 1, card.ability.extra.odds) then
                        card.ability.extra.jokers[#card.ability.extra.jokers + 1] = joker
                    end
                end
            end
        end
        
        if card.ability.extra.jokers then
            local ret = {}
            for _,joker in ipairs(card.ability.extra.jokers) do
                ret[#ret + 1] = SMODS.blueprint_effect(card, joker, context)
            end
            if ret then
                return SMODS.merge_effects(ret)
            end
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'spotscast')
        return { vars = {numerator, denominator}, key = self.key }
    end
}

SMODS.Atlas({
    key = "trumpoff",
    path = "trumpoff.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "trumpoff",                                  --name used by the joker.    
    config = { extra = {x_mult = 1, x_mult_mod = 0.1} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    soul_pos={x=1,y=0}, 
    rarity = 4,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 20,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    atlas = 'trumpoff',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if not context.blueprint then
            if context.individual and context.cardarea == G.play then
                if next(SMODS.get_enhancements(context.other_card)) then
                    card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_mod
                    return {
                        message = localize('k_upgrade_ex'),
                        colour = G.C.MULT,
                    }
                end
            end
        end
        if context.joker_main and context.cardarea == G.jokers then
            return {
                x_mult = card.ability.extra.x_mult, 
                colour = G.C.MULT
            }
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {card.ability.extra.x_mult,card.ability.extra.x_mult_mod}, key = self.key }
    end
}

SMODS.Atlas({
    key = "refabric",
    path = "refabric.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "refabric",                                  --name used by the joker.    
    config = { extra = {x_mult = 4, x_mult_blueprint = 6} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    soul_pos={x=1,y=0}, 
    rarity = 4,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 20,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    atlas = 'refabric',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if context.joker_main and context.cardarea == G.jokers then
            local x_mult_result = context.blueprint and card.ability.extra.x_mult_blueprint or card.ability.extra.x_mult
            return {
                x_mult = x_mult_result, 
                colour = G.C.MULT
            }
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {card.ability.extra.x_mult, card.ability.extra.x_mult_blueprint}, key = self.key }
    end
}


SMODS.Atlas({
    key = "monkdom",
    path = "monkdom.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "monkdom",                                  --name used by the joker.    
    config = { extra = {x_mult = 1, x_mult_mod = 1} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    soul_pos={x=1,y=0}, 
    rarity = 4,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 20,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    atlas = 'monkdom',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if context.beat_boss then
                card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_mod
                return { message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } } }
            end
        end
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {card.ability.extra.x_mult,card.ability.extra.x_mult_mod}, key = self.key }
    end
}


SMODS.Atlas({
    key = "bushka",
    path = "bushka.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "bushka",                                  --name used by the joker.    
    config = { extra = {x_chips = 1.25} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    soul_pos={x=1,y=0}, 
    rarity = 4,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 20,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    atlas = 'bushka',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_face() then
                return {
                    x_chips = card.ability.extra.x_chips,
                    colour = G.C.CHIPS
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {card.ability.extra.x_chips}, key = self.key }
    end
}


function SMODS.current_mod.reset_game_globals(run_start)
    reset_ameliorates_octosquish() -- See Octosquish
    reset_ameliorates_athenerd() -- See Athenerd
    reset_ameliorates_robby() -- See Robby
end

-- Onyx
SMODS.Atlas({
    key = "final_onyx",
    path = "final_onyx.png",
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21,
    px = 34,
    py = 34
})

SMODS.Blind {
    key = "final_onyx",
    atlas = 'final_onyx',
    pos = { x = 0, y = 0 },
    vars = {active=true},
    dollars = 8,
    mult = 2,
    boss = { showdown = true },
    boss_colour = HEX("6c4c7d"),
    get_loc_debuff_text = function(self)
        return G.GAME.blind.loc_debuff_text ..
            (G.GAME.blind.only_hand and ' [' .. localize(G.GAME.blind.only_hand, 'poker_hands') .. ']' or '')
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.before or context.debuffed_hand then
                blind.effect.active = true
            end
            if context.setting_blind or (context.hand_drawn and blind.effect.active) then
                local valid_onyx_cards = {}
                for _, playing_card in ipairs(G.playing_cards) do
                    if not (SMODS.has_no_suit(playing_card) or SMODS.has_enhancement(playing_card, 'm_stone')) then
                        valid_onyx_cards[#valid_onyx_cards + 1] = playing_card
                    end
                end
                local onyx_card = pseudorandom_element(valid_onyx_cards, 'ameliorates_onyx')
                if onyx_card then
                    blind:wiggle()
                    for k, v in pairs(G.playing_cards) do
                        local juice = false
                        if v.debuff then
                            juice = true
                            v.debuff = false
                        end
                        if v:is_suit(onyx_card.base.suit) then
                            juice = true
                            v.debuff = true
                        end

                        if juice then
                            v:juice_up()
                        end
                    end
                end
                blind.effect.active = false
            end
            
            if context.debuff_hand then
                for k, v in pairs(context.full_hand) do
                    if v.debuff then
                        return {debuff = true}
                    end
                end
            end
        end
    end
}

--[[
SMODS.Atlas({
    key = "signal_deck",
    path = "spotscast.png",
    px = 71,
    py = 95
})

SMODS.Back {
    key = "signal_deck",
    atlas = "signal_deck",
    pos = { x = 0, y = 0 },
    unlocked = true,
    config = { extra = {seal = 'Red',count = 10}},
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                local i = 0
                while i < self.config.extra.count do
                    local v = pseudorandom_element(G.playing_cards, 'ameliorates_signal')
                    if v:get_seal() ~= "Red" then
                        v:set_seal(self.config.extra.seal, nil, true)
                        i = i + 1
                    end
                end
                return true
            end
        }))
    end,
    loc_vars = function(self, info_queue, back)
        return { vars = {self.config.extra.seal,self.config.extra.count} }
    end,
}

SMODS.Atlas({
    key = "clay_deck",
    path = "trumpoff.png",
    px = 71,
    py = 95
})

SMODS.Back {
    key = "clay_deck",
    atlas = "clay_deck",
    pos = { x = 0, y = 0 },
    unlocked = true,
    config = { extra = {count = 8}},
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                local i = 0
                while i < self.config.extra.count do
                    local v = pseudorandom_element(G.playing_cards, 'ameliorates_clay')
                    if not next(SMODS.get_enhancements(v)) then
                        v:set_ability(SMODS.poll_enhancement({guaranteed = true, options = options}), nil, true)
                        i = i + 1
                    end
                end
                return true
            end
        }))
    end,
    loc_vars = function(self, info_queue, back)
        return { vars = {self.config.extra.count} }
    end,
}

SMODS.Atlas({
    key = "trash_deck",
    path = "refabric.png",
    px = 71,
    py = 95
})

SMODS.Back {
    key = "trash_deck",
    atlas = "trash_deck",
    pos = { x = 0, y = 0 },
    unlocked = true,
    config = { extra = {}},
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                local suit = pseudorandom_element(G.SUITS, 'ameliorates_trash')
                local cards = {}
                for _,v in pairs(G.playing_cards) do
                    if v:is_suit(suit) then
                        cards[#cards + 1] = v
                    end
                end
                SMODS.destroy_cards(cards)
                return true
            end
        }))
    end,
    loc_vars = function(self, info_queue, back)
        return { vars = {} }
    end,
}
]]