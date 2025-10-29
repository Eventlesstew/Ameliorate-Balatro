-- DUE TO A BUG This does not load in the actual mod.
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
    vars = {suit='Spades'},
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
            if context.hand_drawn then
                blind.effect.suit = pseudorandom_element(SMODS.Suits, 'seed').key
                blind:wiggle()

                for k, v in pairs(G.playing_cards) do
                    if v.debuff ~= v:is_suit(blind.effect.suit) then
                        v:juice_up()
                    end
                    v.debuff = v:is_suit(blind.effect.suit)
                end
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