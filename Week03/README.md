# Week 03 Homework (Plutus Pioneer Program)

Homework1.hs wants to acheive the following:

"This should validate if either beneficiary1 has signed the transaction and the current slot is before or at the deadline or if beneficiary2 has signed the transaction and the deadline has passed."

Homework1.hs does this with a VestingDatum (as the Datum) written with record syntax.

Homework2.hs achieves the same as the sample Vesting* contract in the PPP but with parametrized contracts --- mkValidator takes four inputs now. This lets you get different contract instances and thus hashes/contract addresses. So the contract is parametrized by a public key hash and the Datum is just the POSIX time.

*With a vesting contract you just want the funds to be accessible by a beneficiary at a later point in time. Homework1.hs is also a vesting contract that allows two beneficiaries on either side of the deadline.

