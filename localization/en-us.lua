return {
    descriptions = {
        Joker = {
            j_sj_reese = {
                name = "Reese",
                text = {
                    "This Joker gains",
                    "{C:chips}+#2#{} Chips when each",
                    "played {C:attention}2{} is scored",
                    "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
                },
            },
            j_sj_etikan = {
                name = "Etikan",
                text = {
                    {
                        "This Joker gains {C:chips}+#2#{} Chip per",
                        "discarded card.",
                        "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Mult)",
                    }
                },
            },
            j_sj_tabi = {
                name = "Tabi",
                text = {
                    {
                        "This Joker gains {X:mult,C:white}X#2#{} Mult",
                        "when a {C:attention}Joker{} is destroyed",
                        "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)",
                    }
                },
            },
        }
    },
    misc = {

            -- do note that when using messages such as: 
            -- message = localize{type='variable',key='a_xmult',vars={current_xmult}},
            -- that the key 'a_xmult' will use provided values from vars={} in that order to replace #1#, #2# etc... in the localization file.


        dictionary = {
            a_chips="+#1#",
            a_chips_minus="-#1#",
            a_hands="+#1# Hands",
            a_handsize="+#1# Hand Size",
            a_handsize_minus="-#1# Hand Size",
            a_mult="+#1# Mult",
            a_mult_minus="-#1# Mult",
            a_remaining="#1# Remaining",
            a_sold_tally="#1#/#2# Sold",
            a_xmult="X#1# Mult",
            a_xmult_minus="-X#1# Mult",
        }
    }
}