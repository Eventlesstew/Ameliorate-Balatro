SMODS.Atlas({
    key = "signal_deck",
    path = "spotscast.png",
    px = 71,
    py = 95
})
SMODS.Back {
    key = "signal",
    atlas = "signal_deck",
    pos = { x = 0, y = 0 },
    unlocked = true,
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    if v.base.suit == 'Clubs' then
                        v:change_suit('Spades')
                    end
                    if v.base.suit == 'Diamonds' then
                        v:change_suit('Hearts')
                    end
                end
                return true
            end
        }))
    end,
}