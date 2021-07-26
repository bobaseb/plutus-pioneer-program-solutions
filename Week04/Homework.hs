{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE DeriveAnyClass    #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications  #-}
{-# LANGUAGE TypeOperators     #-}

module Week04.Homework where

import Data.Aeson            (FromJSON, ToJSON)
import Data.Functor          (void)
import Data.Text             (Text, unpack)
import Data.Void                  (Void)
import GHC.Generics          (Generic)
import Ledger
import Ledger.Ada            as Ada
import Ledger.Constraints    as Constraints
import Plutus.Contract       as Contract
import Plutus.Trace.Emulator as Emulator
import Wallet.Emulator.Wallet

data PayParams = PayParams
    { ppRecipient :: PubKeyHash
    , ppLovelace  :: Integer
    } deriving (Show, Generic, FromJSON, ToJSON)

type PaySchema = Endpoint "pay" PayParams

payContract :: Contract () PaySchema Text ()
payContract = do
    pp <- endpoint @"pay"
    let tx = mustPayToPubKey (ppRecipient pp) $ lovelaceValueOf $ ppLovelace pp
    void $ submitTx tx
    payContract

myContractHandler :: Contract () PaySchema Void ()
myContractHandler = Contract.handleError
    (\err -> Contract.logError $ "caught: " ++ unpack err)
    --let pp = endpoint @"pay" in
    payContract --pp


-- A trace that invokes the pay endpoint of payContract on Wallet 1 twice, each time with Wallet 2 as
-- recipient, but with amounts given by the two arguments. There should be a delay of one slot
-- after each endpoint call.
payTrace :: Integer -> Integer -> EmulatorTrace ()
payTrace val1 val2 = do
    h <- activateContractWallet (Wallet 1) payContract
    let pkh2 = pubKeyHash $ walletPubKey $ Wallet 2
        pp1  = PayParams pkh2 val1
        pp2 =  PayParams pkh2 val2

    callEndpoint @"pay" h pp1
    void $ Emulator.waitNSlots 1

    callEndpoint @"pay" h pp2
    void $ Emulator.waitNSlots 1

payTrace' :: Integer -> Integer -> EmulatorTrace ()
payTrace' val1 val2 = do
    h1 <- activateContractWallet (Wallet 1) myContractHandler
    let pkh2 = pubKeyHash $ walletPubKey $ Wallet 2
        pp1  = PayParams pkh2 val1
        pp2 =  PayParams pkh2 val2

    callEndpoint @"pay" h1 pp1
    void $ Emulator.waitNSlots 1

    h2 <- activateContractWallet (Wallet 1) myContractHandler

    callEndpoint @"pay" h2 pp2
    void $ Emulator.waitNSlots 1

payTest1 :: IO ()
payTest1 = runEmulatorTraceIO $ payTrace 1000000 2000000

payTest2 :: IO ()
payTest2 = runEmulatorTraceIO $ payTrace 1000000000 2000000

payTest1' :: IO ()
payTest1' = runEmulatorTraceIO $ payTrace' 1000000 2000000

payTest2' :: IO ()
payTest2' = runEmulatorTraceIO $ payTrace' 1000000000 2000000
