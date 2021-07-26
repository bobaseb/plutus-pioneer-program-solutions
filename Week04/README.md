#Week 03 Homework (Plutus Pioneer Program)

Homework.hs wants to acheive the following:

"A trace that invokes the pay endpoint of payContract on Wallet 1 twice, each time with Wallet 2 as recipient, but with amounts given by the two arguments. There should be a delay of one slot after each endpoint call."

So the goal is to write the off-chain logic for Wallet 1 to pay Wallet 2 twice. This was implemented with the payTrace function and payTrace' catches errors in case of insufficient funds.

