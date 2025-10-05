
-- you can have shared helper functions
function shakecard(self) --visually shake a card
    G.E_MANAGER:add_event(Event({
        func = function()
            self:juice_up(0.5, 0.5)
            return true
        end
    }))
end

function return_JokerValues() -- not used, just here to demonstrate how you could return values from a joker
    if context.joker_main and context.cardarea == G.jokers then
        return {
            chips = card.ability.extra.chips,       -- these are the 3 possible scoring effects any joker can return.
            mult = card.ability.extra.mult,         -- adds mult (+)
            x_mult = card.ability.extra.x_mult,     -- multiplies existing mult (*)
            card = self,                            -- under which card to show the message
            colour = G.C.CHIPS,                     -- colour of the message, Balatro has some predefined colours, (Balatro/globals.lua)
            message = localize('k_upgrade_ex'),     -- this is the message that will be shown under the card when it triggers.
            extra = { focus = self, message = localize('k_upgrade_ex') }, -- another way to show messages, not sure what's the difference.
        }
    end
end

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
            if G.GAME.blind.boss then
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
    cost = 4,                                            --cost to buy the joker in shops.
    blueprint_compat=false,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'arpeggidough',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)
        if context.first_hand_drawn and not context.blueprint then
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
    cost = 4,                                            --cost to buy the joker in shops.
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
    key = "etikan",                                  --name used by the joker.    
    config = { extra = { chips = 0, chip_mod = 1 } },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 1,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 3,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=false,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'etikan',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)
        if not context.blueprint then -- blueprint/brainstorm don't get to add chips to themselves
            if context.discard and not context.other_card.debuff then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod -- add configurable amount of chips to joker
                    
                return {                             -- shows a message under the specified card (card) when it triggers, k_upgrade_ex is a key in the localization files of Balatro
                    extra = {focus = card, message = localize('k_upgrade_ex')},
                    card = card,
                    colour = G.C.CHIPS
                }
            end
        end
        if context.joker_main and context.cardarea == G.jokers then
            return { -- returns total chips from joker to be used in scoring, no need to show message in joker_main phase, game does it for us.
                chips = card.ability.extra.chips, 
                colour = G.C.CHIPS
            }
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
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
    config = {extra = { x_mult_mod = 0.75, x_mult = 1}},
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
        if not context.blueprint then -- This should be jokers destroyed.
            if context.joker_type_destroyed and context.card then
                card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_mod
                return {                             -- shows a message under the specified card (card) when it triggers, k_upgrade_ex is a key in the localization files of Balatro
                    extra = {focus = card, message = localize('k_upgrade_ex')},
                    card = card,
                    colour = G.C.RED
                }
            end
        end
        if context.joker_main and context.cardarea == G.jokers then
            if card.ability.extra.x_mult > 1 then
                return {
                    message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}},
                    colour = G.C.RED,
                    x_mult = card.ability.extra.x_mult
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, card.ability.extra.x_mult_mod} }
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
    config = { extra = {x_mult = 1, x_mult_mod = 0.1} },    --variables used for abilities and effects.
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
    atlas = 'yaun',                                --atlas name, single sprites are deprecated.

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
                        colour = G.C.RED
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
    config = { extra = {chips = 100, chip_mod = 5} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 2,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 7,                                            --cost to buy the joker in shops.
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
    cost = 4,                                            --cost to buy the joker in shops.
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
    config = { extra = {dollars = 2, dollar_mod = 2, dollar_limit = 20} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 2,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 5,                                            --cost to buy the joker in shops.
    blueprint_compat=false,                               --does joker work with blueprint.
    eternal_compat=false,                                 --can joker be eternal.
    perishable_compat=false,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'alliumaid',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if context.after then
            card.ability.extra.dollars = card.ability.extra.dollars + card.ability.extra.dollar_mod
            if card.ability.extra.dollars > card.ability.extra.dollar_limit then
                SMODS.destroy_cards(card, nil, nil, true)
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
    config = { extra = { min = 1, max = 6} },    --variables used for abilities and effects.
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
    config = { extra = {chips = 75, mult = 15, x_mult = 3, dollars = 7, action = 0} },    --variables used for abilities and effects.
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
        local msg1b = G.C.WHITE
        local msg1v = G.C.BLACK
        local msg1 = ''
        local msg2 = ''
        if action == 0 then
            msg2 = 'does nothing'
        elseif action == 1 then
            msg1v = G.C.CHIPS
            msg1 = localize('k_plus') .. tostring(card.ability.extra.chips)
            msg2 = ' ' .. localize('k_chips') 
        elseif action == 2 then
            msg1v = G.C.MULT
            msg1 = localize('k_plus') .. tostring(card.ability.extra.mult)
            msg2 = ' ' .. localize('k_mult')
        elseif action == 3 then
            msg1b = G.C.MULT
            msg1v = G.C.WHITE
            msg1 = localize('k_x') .. tostring(card.ability.extra.x_mult)
            msg2 = ' ' .. localize('k_mult')
        elseif action == 4 then
            msg1v = G.C.MONEY
            msg1 = localize('k_dollar') .. tostring(card.ability.extra.dollars)
        end

        main_end = {
            n = G.UIT.T,
            config = {text = actionMSG, scale = 0.32}
        }
        return {vars = {card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.x_mult, card.ability.extra.dollars, msg1, msg2, colours = {msg1v, msg1b} }, key = self.key }
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
    config = { extra = {chips = 111, mult = 20} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 2,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 1,                                            --cost to buy the joker in shops.
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
        return { vars = {card.ability.extra.chips, card.ability.extra.mult}, key = self.key }
    end
}



SMODS.Atlas({
    key = "dormana",
    path = "dormanatemp.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "dormana",                                  --name used by the joker.    
    config = { extra = {odds = 6} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 3,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 5,                                            --cost to buy the joker in shops.
    blueprint_compat=false,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'dormana',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
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
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'dormana')
        info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
        info_queue[#info_queue + 1] = G.P_CENTERS.e_holo
        info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
        return { vars = {numerator, denominator}, key = self.key }
    end
}

SMODS.Atlas({
    key = "nnoygon",
    path = "nnoygontemp.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "nnoygon",                                  --name used by the joker.    
    config = { extra = {x_mult = 1, x_mult_mod = 0.05, suit = 'Diamonds'} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 3,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 1,                                            --cost to buy the joker in shops.
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
            if context.joker_main and context.cardarea == G.jokers then
                return {
                    x_mult = card.ability.extra.x_mult, 
                    colour = G.C.MULT
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {card.ability.extra.x_mult, card.ability.extra.x_mult_mod, localize(card.ability.extra.suit, 'suits_singular')}, key = self.key }
    end
}

SMODS.Atlas({
    key = "organe",
    path = "organetemp.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "organe",                                  --name used by the joker.    
    config = { extra = {suit = 'Clubs'} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 3,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 1,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'organe',                                --atlas name, single sprites are deprecated.

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
    key = "robby",
    path = "placeholderJimbo.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "robby",                                  --name used by the joker.    
    config = { extra = {} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 3,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 1,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'robby',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {}, key = self.key }
    end
}

SMODS.Atlas({
    key = "vack",
    path = "placeholderJimbo.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "vack",                                  --name used by the joker.    
    config = { extra = {} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 3,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 1,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'vack',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here

    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {}, key = self.key }
    end
}

SMODS.Atlas({
    key = "rallentando",
    path = "placeholderJimbo.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "rallentando",                                  --name used by the joker.    
    config = { extra = {} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 3,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 1,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'rallentando',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here

    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {}, key = self.key }
    end
}

SMODS.Atlas({
    key = "semohseaga",
    path = "placeholderJimbo.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "semohseaga",                                  --name used by the joker.    
    config = { extra = {x_mult = 5} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 3,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 1,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'semohseaga',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if context.after then
            if SMODS.calculate_round_score() < G.GAME.blind.chips then
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
    key = "athenerd",
    path = "placeholderJimbo.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "athenerd",                                  --name used by the joker.    
    config = { extra = {} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 3,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 1,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'athenerd',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here

    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {}, key = self.key }
    end
}

SMODS.Atlas({
    key = "kassbick",
    path = "placeholderJimbo.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "kassbick",                                  --name used by the joker.    
    config = { extra = {} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 3,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 1,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'kassbick',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here

    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {}, key = self.key }
    end
}

SMODS.Atlas({
    key = "deltah",
    path = "placeholderJimbo.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "deltah",                                  --name used by the joker.    
    config = { extra = {} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 3,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 1,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'deltah',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here

    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {}, key = self.key }
    end
}

--[[
SMODS.Atlas({
    key = "spotscast",
    path = "spotscast.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "spotscast",                                  --name used by the joker.    
    config = { extra = {odds = 3} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                             --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    soul_pos = { x = 1, y = 0 },
    rarity = 4,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 1,                                            --cost to buy the joker in shops.
    blueprint_compat=false,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    atlas = 'spotscast',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        local effects = {}
        for k, v in pairs(G.jokers.cards) do
            if SMODS.pseudorandom_probability(card, 'spotscast', 1, card.ability.extra.odds) then
                if v ~= card then
                    local effect = SMODS.blueprint_effect(card, v, context)
                    if effect then
                        effect.colour = G.C.RED
                    end
                    table.insert(effects, effect)
                end
            end
        end
        return SMODS.merge_effects(effects)
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
    config = { extra = {} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 4,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 1,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'trumpoff',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here

    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {}, key = self.key }
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
    config = { extra = {} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 4,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 1,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'refabric',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here

    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {}, key = self.key }
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
    config = { extra = {} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 4,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 1,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'monkdom',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here

    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {}, key = self.key }
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
    config = { extra = {x_chips = 0, x_chips_mod = 1} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 4,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 1,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'bushka',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if context.joker_main and context.cardarea == G.jokers then
            card.ability.extra.x_chips = card.ability.extra.x_chips_mod * #G.jokers.cards
            return {
                x_chips = card.ability.extra.x_chips,
                colour = G.C.CHIPS
            }
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {card.ability.extra.x_chips_mod * (G.jokers and #G.jokers.cards or 0), card.ability.extra.x_chips_mod}, key = self.key }
    end
}

SMODS.Atlas({
    key = "onyx",
    path = "onyx.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "onyx",                                  --name used by the joker.    
    config = { extra = {} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 4,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 1,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'onyx',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here

    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {}, key = self.key }
    end
}
]]

SMODS.Atlas({
    key = "sylvesterreese",
    path = "sylvesterreese.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "sylvesterreese",                                  --name used by the joker.    
    config = { extra = { x_chips = 2} },    --variables used for abilities and effects.
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
    atlas = 'sylvesterreese',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if context.joker_main and context.cardarea == G.jokers then
            if G.GAME.blind.boss then
                return {
                    x_chips = card.ability.extra.x_chips, 
                    colour = G.C.MULT
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = { card.ability.extra.x_chips}, key = self.key }
    end
}

function SMODS.current_mod.reset_game_globals(run_start)
    reset_ameliorates_octosquish()    -- See Octosquish
end