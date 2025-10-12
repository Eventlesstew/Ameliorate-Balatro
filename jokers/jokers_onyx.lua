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
    cost = 20,                                            --cost to buy the joker in shops.
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