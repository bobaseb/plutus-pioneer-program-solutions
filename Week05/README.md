#Week 05 Homework (Plutus Pioneer Program)

Homework1.hs wants to acheive the following:

"This policy should only allow minting (or burning) of tokens if the owner of the specified PubKeyHash has signed the transaction and if the specified deadline has not passed."

This basically involved adapting our solution from the homework in week 3 and copying some code from NFT.hs & Signed.hs with some mix and matching since this contract is doubly parametrized with PubKeyHash and POSIXTime. This is not really a Plutus solution since you can acheive this with metadata functionality through the Cardano CLI.

Homework2.hs wants to acheive the following:

"Minting policy for an NFT, where the minting transaction must consume the given UTxO as input and where the TokenName will be the empty ByteString."

This represents a proper Plutus solution to minting NFTs since consuming the given UTxO as input guarantees uniqueness of the NFT. The solution in Homework1 is more hackish since it relies on time windows which could be exploited by adversaries. Not sure why you would want TokenName as the empty ByteString though.

The solution involved mostly copy/pasting from NFT.hs and taking out anything related to the tn variable (i.e., the token name). This was also the case for the mint function that outputs a Contract monad. Although there we insert an empty ByteString when we define val with Value.singleton
