{-# LANGUAGE OverloadedStrings #-}
module Example where

import           Language.Marlowe.Extended

main :: IO ()
main = print . pretty $ contract

contract :: Party -> Party -> Party -> Value -> Contract
contract =
When
    [Case
        (Deposit
            (Role "Charlie")
            (Role "Charlie")
            (Token "" "")
            (Constant 20)
        )
        (When
            [Case
                (Deposit
                    (Role "Alice")
                    (Role "Alice")
                    (Token "" "")
                    (Constant 10)
                )
                (When
                    [Case
                        (Deposit
                            (Role "Bob")
                            (Role "Bob")
                            (Token "" "")
                            (Constant 10)
                        )
                        (When
                            [Case
                                (Choice
                                    (ChoiceId
                                        "Winner"
                                        (Role "Charlie")
                                    )
                                    [Bound 1 2]
                                )
                                (If
                                    (ValueEQ
                                        (ChoiceValue
                                            (ChoiceId
                                                "Winner"
                                                (Role "Charlie")
                                            ))
                                        (Constant 1)
                                    )
                                    (Pay
                                        (Role "Bob")
                                        (Account (Role "Alice"))
                                        (Token "" "")
                                        (Constant 10)
                                        Close 
                                    )
                                    (Pay
                                        (Role "Alice")
                                        (Account (Role "Bob"))
                                        (Token "" "")
                                        (Constant 10)
                                        Close 
                                    )
                                )]
                            30
                            (Pay
                                (Role "Charlie")
                                (Account (Role "Alice"))
                                (Token "" "")
                                (Constant 10)
                                (Pay
                                    (Role "Charlie")
                                    (Account (Role "Bob"))
                                    (Token "" "")
                                    (Constant 10)
                                    Close 
                                )
                            )
                        )]
                    20 Close 
                ), Case
                (Deposit
                    (Role "Bob")
                    (Role "Bob")
                    (Token "" "")
                    (Constant 10)
                )
                (When
                    [Case
                        (Deposit
                            (Role "Alice")
                            (Role "Alice")
                            (Token "" "")
                            (Constant 10)
                        )
                        (When
                            [Case
                                (Choice
                                    (ChoiceId
                                        "Winner"
                                        (Role "Charlie")
                                    )
                                    [Bound 1 2]
                                )
                                (If
                                    (ValueEQ
                                        (ChoiceValue
                                            (ChoiceId
                                                "Winner"
                                                (Role "Charlie")
                                            ))
                                        (Constant 1)
                                    )
                                    (Pay
                                        (Role "Bob")
                                        (Account (Role "Alice"))
                                        (Token "" "")
                                        (Constant 10)
                                        Close 
                                    )
                                    (Pay
                                        (Role "Alice")
                                        (Account (Role "Bob"))
                                        (Token "" "")
                                        (Constant 10)
                                        Close 
                                    )
                                )]
                            30
                            (Pay
                                (Role "Charlie")
                                (Account (Role "Alice"))
                                (Token "" "")
                                (Constant 10)
                                (Pay
                                    (Role "Charlie")
                                    (Account (Role "Bob"))
                                    (Token "" "")
                                    (Constant 10)
                                    Close 
                                )
                            )
                        )]
                    20 Close 
                )]
            10 Close 
        )]
    5 Close 