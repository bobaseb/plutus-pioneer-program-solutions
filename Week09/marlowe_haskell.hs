{-# LANGUAGE OverloadedStrings #-}
import Language.Marlowe.Extended

main :: IO ()
main = print . pretty $ contract "Alice" "Bob" "Charlie" $ Constant 10

choiceId :: Party -> ChoiceId
choiceId p = ChoiceId "Winner" p

contract :: Party -> Party -> Party -> Value -> Contract
contract alice bob charlie deposit =
    When
        [Case
        (Deposit
            charlie
            charlie
            ada
            (MulValue deposit $ Constant 2)
        )
            (When
                [ f alice bob
                , f bob alice
                ]
                10 Close)
        ]
        5 Close
  where
    f :: Party -> Party -> Case
    f x y =
        Case
            (Deposit
                x
                x
                ada
                deposit
            )
            (When
                [Case
                    (Deposit
                        y
                        y
                        ada
                        deposit
                    )
                    (When
                        [Case
                            (Choice
                                (choiceId charlie)
                                [Bound 1 2]
                            )
                            (If
                                (ValueEQ
                                    (ChoiceValue $ choiceId charlie)
                                    (Constant 1)
                                )
                                (Pay
                                    bob
                                    (Account alice)
                                    ada
                                    deposit
                                    Close
                                )
                                (Pay
                                    alice
                                    (Account bob)
                                    ada
                                    deposit
                                    Close
                                )
                            )]
                        30 
                            (Pay
                                charlie
                                (Account alice)
                                ada
                                deposit
                                (Pay
                                    charlie
                                    (Account bob)
                                    ada
                                    deposit
                                    Close 
                                )
                            )
                    )]
                20 Close
            )
