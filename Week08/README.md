#Week 08 Homework (Plutus Pioneer Program)

This week had a long lecture using property based testing (Quickcheck) on a token sale contract. The homework was to add a "close" endpoint to the token sale and amend the model and trace accordingly -- the test suite needs a model to simulate interactions with the outside world basically. Closing the contract should withdraw all ada, the tokens being sold and the contract's NFT (giving them back to the original seller).

Setting the state to Nothing & mempty now triggers the closing of the contract. The transitions are handled by tsStateMachine which checks for this and automatically hands all funds over to the original seller. For this to work the State now takes a Maybe Integer instead of an Integer.

I still have have many holes in my knowledge w.r.t. to the Model and Trace scripts. I copied someone else's solution for the implementation of Close with nextState. This helped me understand that we should enforce wallets be equal (v==w). I find myself puzzled with lenses still (e.g., .^). I defined a new generator for Maybe Integers for the Model (genMaybeInt). Had I just sent () throught the "close" endpoint this would not be necessary, but it is since I send Nothing instead. Fortunately, my solution passes all tests but I think I could spend more time writing some more stringent tests or properties.
