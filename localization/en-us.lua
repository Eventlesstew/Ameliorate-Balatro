return {
    descriptions = {
        Joker = {
            j_ameliorates_reese = {
                name = "Reese",
                text = {
                    "{X:mult,C:white}X#1#{} Mult when",
                    "{C:attention}Boss Blind{} is selected"
                },
            },

            j_ameliorates_guira = {
                name = "Guira",
                text = {
                    {
                        "{X:mult,C:white}INCOMPLETE{}",
                    }
                },
            },

            j_ameliorates_arpeggidough = {
                name = "Arpeggidough",
                text = {
                        "If {C:attention}first hand {}of round has only {C:attention} 1{}",
                        "card, add a random {C:attention}enhancement to it.",
                        "{X:mult,C:white}INCOMPLETE{}",
                        "{C:mult}Only turns cards to Gold cards."
                },
            },

            j_ameliorates_meeka = {
                name = "Meeka",
                text = {
                        "{C:green}#1# in #2#{} chance to",
                        "retrigger played card."
                },
            },

            j_ameliorates_etikan = {
                name = "Etikan",
                text = {
                    {
                        "This Joker gains {C:chips}+#2#{} Chip per",
                        "discarded card.",
                        "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
                    }
                },
            },
            j_ameliorates_tabi = {
                name = "Tabi",
                text = {
                    {
                        "This Joker gains {X:mult,C:white}X#2#{} Mult",
                        "when a {C:attention}Joker{} is destroyed",
                        "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)",
                    }
                },
            },
            
            j_ameliorates_yaun = {
                name = "Yaun",
                text = {
                        "{X:mult,C:white}INCOMPLETE{}",
                },
            },

            j_ameliorates_esckickis = {
                name = "Esckickis",
                text = {
                        "{X:mult,C:white}INCOMPLETE{}",
                },
            },

            j_ameliorates_nillacorn = {
                name = "NillaCorn",
                text = {
                    "{C:chips}+#1#{} Chips",
                    "{C:chips}+#2#{} Chips for",
                    "every hand played",
                },
            },

            j_ameliorates_jugashley = {
                name = "Jugashley",
                text = {
                        "{X:mult,C:white}INCOMPLETE{}",
                },
            },

            j_ameliorates_orgako = {
                name = "Orgako",
                text = {
                        "{X:mult,C:white}INCOMPLETE{}",
                },
            },

            j_ameliorates_alliumaid = {
                name = "Alliumaid",
                text = {
                        "{X:mult,C:white}INCOMPLETE{}",
                },
            },

            j_ameliorates_expifour = {
                name = "Expi-Four",
                text = {
                    "",
                },
            },

            j_ameliorates_octosquish = {
                name = "Octosquish",
                text = {
                        "{X:mult,C:white}INCOMPLETE{}",
                },
            },

            j_ameliorates_trashcymbal = {
                name = "Trash Cymbal",
                text = {
                        "{C:chips}+#1# {}Chips on {C:attention}odd",
                        "{}numbered rounds",
                        "{C:mult}+#2# {}Mult on {C:attention}even",
                        "{}numbered rounds",
                },
            },

            j_ameliorates_dormana = {
                name = "Dormana",
                text = {
                        "{X:mult,C:white}INCOMPLETE{}",
                },
            },

            j_ameliorates_nnoygon = {
                name = "Nnoygon",
                text = {
                        "{X:mult,C:white}INCOMPLETE{}",
                },
            },

            j_ameliorates_organe = {
                name = "Organe",
                text = {
                        "{X:mult,C:white}INCOMPLETE{}",
                },
            },

            j_ameliorates_robby = {
                name = "Robby",
                text = {
                        "{X:mult,C:white}INCOMPLETE{}",
                },
            },

            j_ameliorates_vack = {
                name = "Vack",
                text = {
                        "{X:mult,C:white}INCOMPLETE{}",
                },
            },

            j_ameliorates_rallentando = {
                name = "Rallentando",
                text = {
                        "{X:mult,C:white}INCOMPLETE{}",
                },
            },

            j_ameliorates_semohseaga = {
                name = "Sem Oh Seaga",
                text = {
                        "{X:mult,C:white}INCOMPLETE{}",
                },
            },

            j_ameliorates_athenerd = {
                name = "Athenerd",
                text = {
                        "{X:mult,C:white}INCOMPLETE{}",
                },
            },

            j_ameliorates_kassbick = {
                name = "Kass Bick",
                text = {
                        "{X:mult,C:white}INCOMPLETE{}",
                },
            },

            j_ameliorates_deltah = {
                name = "Deltah",
                text = {
                        "{X:mult,C:white}INCOMPLETE{}",
                },
            },

            j_ameliorates_spotscast = {
                name = "Spotscast",
                text = {
                    {
                        "Copies the ability of",
                        "every owned {C:attention}Joker",
                    }
                },
            },

            j_ameliorates_trumpoff = {
                name = "Trumpoff",
                text = {
                    {
                        "{X:mult,C:white}INCOMPLETE{}",
                    }
                },
            },

            j_ameliorates_refabric = {
                name = "Re-Fabrić",
                text = {
                    {
                        "{X:mult,C:white}INCOMPLETE{}",
                    }
                },
            },

            j_ameliorates_monkdom = {
                name = "Monkdom",
                text = {
                    {
                        "{X:mult,C:white}INCOMPLETE{}",
                    }
                },
            },

            j_ameliorates_bushka = {
                name = "Bushka",
                text = {
                    {
                        "{X:chips,C:white}X#2#{} Chips for each {C:attention}Joker{} card.",
                        "{C:inactive}(Currently {X:chips,C:white}X#1#{C:inactive} Chips)",
                    }
                },
            },

            j_ameliorates_onyx = {
                name = "???",
                text = {
                    {
                        "{X:mult,C:white}INCOMPLETE{}",
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