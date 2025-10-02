
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
    path = "placeholderJimbo.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "guira",                                  --name used by the joker.    
    config = { extra = {} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 1,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 1,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    perishable_compat=true,
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'guira',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here

    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {}, key = self.key }
    end
}

SMODS.Atlas({
    key = "arpeggidough",
    path = "placeholderJimbo.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "arpeggidough",                                  --name used by the joker.    
    config = { extra = {} },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 1,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 1,                                            --cost to buy the joker in shops.
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

            scored_card:set_ability('m_mult', nil, true)
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
    path = "placeholderJimbo.png",
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
    cost = 1,                                            --cost to buy the joker in shops.
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
    config = {extra = { x_mult_mod = 0.5, x_mult = 1}},
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
    path = "placeholderJimbo.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "yaun",                                  --name used by the joker.    
    config = { extra = {} },    --variables used for abilities and effects.
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
    atlas = 'yaun',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here

    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {}, key = self.key }
    end
}

SMODS.Atlas({
    key = "esckickis",
    path = "placeholderJimbo.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "esckickis",                                  --name used by the joker.    
    config = { extra = {} },    --variables used for abilities and effects.
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
    atlas = 'esckickis',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here

    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {}, key = self.key }
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
    path = "placeholderJimbo.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "jugashley",                                  --name used by the joker.    
    config = { extra = {} },    --variables used for abilities and effects.
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
    atlas = 'jugashley',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here

    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {}, key = self.key }
    end
}

SMODS.Atlas({
    key = "orgako",
    path = "placeholderJimbo.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "orgako",                                  --name used by the joker.    
    config = { extra = {} },    --variables used for abilities and effects.
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
    atlas = 'orgako',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here

    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {}, key = self.key }
    end
}

SMODS.Atlas({
    key = "alliumaid",
    path = "placeholderJimbo.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "alliumaid",                                  --name used by the joker.    
    config = { extra = {} },    --variables used for abilities and effects.
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
    atlas = 'alliumaid',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here

    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {}, key = self.key }
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
        local r_value = ""
        local r_mults = {}
        for i = card.ability.extra.min, card.ability.extra.max do
            r_mults[#r_mults + 1] = tostring(i)
        end
        local loc_mult = ' ' .. (localize('k_mult')) .. ' '
        main_start = {
            { 
                n = G.UIT.T,
                config = { text = '  X', colour = G.C.MULT, scale = 0.32 }
            },
            { 
                n = G.UIT.O, 
                config = { 
                    object = DynaText({
                        string = r_mults,
                        colours = {G.C.MULT},
                        pop_in_rate = 9999999,
                        silent = true,
                        random_element = true,
                        pop_delay = 0.5,
                        scale = 0.32,
                        min_cycle_time = 0 }) } },
            {
                n = G.UIT.O,
                config = {
                    object = DynaText({
                        string = {
                            { string = 'rand()', colour = G.C.JOKER_GREY }, { string = "#@" .. (G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.id or 11) .. (G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.suit:sub(1, 1) or 'D'), colour = G.C.RED },
                            loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult,
                            loc_mult, loc_mult, loc_mult, loc_mult },
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
        return { main_start = main_start }
    end,
}

SMODS.Atlas({
    key = "octosquish",
    path = "placeholderJimbo.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "octosquish",                                  --name used by the joker.    
    config = { extra = {} },    --variables used for abilities and effects.
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
    atlas = 'octosquish',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here

    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {}, key = self.key }
    end
}

SMODS.Atlas({
    key = "trashcymbal",
    path = "placeholderJimbo.png",
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
    path = "placeholderJimbo.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "dormana",                                  --name used by the joker.    
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
    atlas = 'dormana',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here

    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {}, key = self.key }
    end
}

SMODS.Atlas({
    key = "nnoygon",
    path = "placeholderJimbo.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "nnoygon",                                  --name used by the joker.    
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
    atlas = 'nnoygon',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here

    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {}, key = self.key }
    end
}

SMODS.Atlas({
    key = "organe",
    path = "placeholderJimbo.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "organe",                                  --name used by the joker.    
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
    atlas = 'organe',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here

    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {}, key = self.key }
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
    atlas = 'semohseaga',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here

    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {}, key = self.key }
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

SMODS.Atlas({
    key = "spotscast",
    path = "spotscast.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "spotscast",                                  --name used by the joker.    
    config = { extra = {} },    --variables used for abilities and effects.
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
            if v ~= card then
                local effect = SMODS.blueprint_effect(card, v, context)
                if effect then
                    effect.colour = G.C.RED
                end
                table.insert(effects, effect)
            end
        end
        return SMODS.merge_effects(effects)
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = {}, key = self.key }
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