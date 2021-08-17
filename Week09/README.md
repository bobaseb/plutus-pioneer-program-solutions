#Week 09 Homework (Plutus Pioneer Program)

This week was about Marlowe, a domain-specific language (DSL) focused on financial contracts. The example given was Alice & Bob deposit some ada (same amounts) and Charlie chooses who gets the pot. We saw how to code this visually with Blockly and also in plain Haskell.

The homework was to account for inaction on Charlie's part. So Charlie is forced to put some ada upfront (twice that put up by Bob/Alice) which would be equally split by Alice & Bob if Charlie does not choose the winner.

I solved this by using Blockly first based on Lars' example ("marlowe\_blockly.hs"). Then I condensed that code to something more readable with plain old Haskell ("marlowe\_haskell.hs"), the same way Lars went about it in the lecture.
