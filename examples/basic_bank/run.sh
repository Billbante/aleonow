#!/bin/bash
# First check that Leo is installed.
if ! command -v leo &> /dev/null
then
    echo "leo is not installed."
    exit
fi

# The private key and address of the bank.
# Swap these into program.json, when running transactions as the bank.
# NETWORK=mainnet
# PRIVATE_KEY=APrivateKey1zkp8CZNn3yeCseEtxuVPbDCwSyhGW6yZKUYKfgXmcpoGPWH

# The private key and address of the user.
# Swap these into program.json, when running transactions as the user.
# NETWORK=mainnet
# PRIVATE_KEY=APrivateKey1zkp2RWGDcde3efb89rjhME1VYA8QMxcxep5DShNBR6n8Yjh

# Swap in the private key and address of the bank to .env.
echo "
NETWORK=mainnet
PRIVATE_KEY=APrivateKey1zkp8CZNn3yeCseEtxuVPbDCwSyhGW6yZKUYKfgXmcpoGPWH
ENDPOINT=https://localhost:3030
" > .env

# Have the bank issue 100 tokens to the user.
echo "
###############################################################################
########                                                               ########
########     STEP 1: Initialize 100 tokens for aleo1s3ws5...em2u4t     ########
########                                                               ########
########           -----------------------------------------           ########
########           |      ACTION     |        AMOUNT       |           ########
########           -----------------------------------------           ########
########           -----------------------------------------           ########
########           |        Issuing  |         100         |           ########
########           -----------------------------------------           ########
########           |     Depositing  |          0          |           ########
########           -----------------------------------------           ########
########           |    Withdrawing  |          0          |           ########
########           -----------------------------------------           ########
########                                                               ########
########           -----------------------------------------           ########
########           |      WALLET     | aleo1s3ws5...em2u4t |           ########
########           -----------------------------------------           ########
########           -----------------------------------------           ########
########           |        Balance  |         100         |           ########
########           -----------------------------------------           ########
########                                                               ########
########           -----------------------------------------           ########
########           |      BANK       | aleo1rhgdu...vzp9px |           ########
########           -----------------------------------------           ########
########           -----------------------------------------           ########
########           |        Balance  |          0          |           ########
########           -----------------------------------------           ########
########           |        Periods  |          0          |           ########
########           -----------------------------------------           ########
########           |  Interest Rate  |        12.34%       |           ########
########           -----------------------------------------           ########
########                                                               ########
########           -----------------------------------------           ########
########           |  TOTAL BALANCE  |         100         |           ########
########           -----------------------------------------           ########
########                                                               ########
###############################################################################
"
leo run issue aleo1s3ws5tra87fjycnjrwsjcrnw2qxr8jfqqdugnf0xzqqw29q9m5pqem2u4t 100u64 || exit


# Swap in the private key and address of the user to .env.
echo "
NETWORK=mainnet
PRIVATE_KEY=APrivateKey1zkp2RWGDcde3efb89rjhME1VYA8QMxcxep5DShNBR6n8Yjh
ENDPOINT=https://localhost:3030
" > .env

# Have the user deposit 50 tokens into the bank.
echo "
###############################################################################
########                                                               ########
########     STEP 2: aleo1s3ws5...em2u4t deposits 50 tokens            ########
########                                                               ########
########           -----------------------------------------           ########
########           |      ACTION     |        AMOUNT       |           ########
########           -----------------------------------------           ########
########           -----------------------------------------           ########
########           |        Issuing  |          0          |           ########
########           -----------------------------------------           ########
########           |     Depositing  |          50         |           ########
########           -----------------------------------------           ########
########           |    Withdrawing  |          0          |           ########
########           -----------------------------------------           ########
########                                                               ########
########           -----------------------------------------           ########
########           |      WALLET     | aleo1s3ws5...em2u4t |           ########
########           -----------------------------------------           ########
########           -----------------------------------------           ########
########           |        Balance  |          50         |           ########
########           -----------------------------------------           ########
########                                                               ########
########           -----------------------------------------           ########
########           |      BANK       | aleo1rhgdu...vzp9px |           ########
########           -----------------------------------------           ########
########           -----------------------------------------           ########
########           |        Balance  |          50         |           ########
########           -----------------------------------------           ########
########           |        Periods  |          0          |           ########
########           -----------------------------------------           ########
########           |  Interest Rate  |        12.34%       |           ########
########           -----------------------------------------           ########
########                                                               ########
########           -----------------------------------------           ########
########           |  TOTAL BALANCE  |         100         |           ########
########           -----------------------------------------           ########
########                                                               ########
###############################################################################
"
leo run deposit "{
    owner: aleo1s3ws5tra87fjycnjrwsjcrnw2qxr8jfqqdugnf0xzqqw29q9m5pqem2u4t.private,
    amount: 100u64.private,
    _nonce: 4668394794828730542675887906815309351994017139223602571716627453741502624516group.public
}"  50u64 || exit

echo "
###############################################################################
########                                                               ########
########     STEP 3: Wait 15 periods                                   ########
########                                                               ########
########           -----------------------------------------           ########
########           |      ACTION     |        AMOUNT       |           ########
########           -----------------------------------------           ########
########           -----------------------------------------           ########
########           |        Issuing  |          0          |           ########
########           -----------------------------------------           ########
########           |     Depositing  |          0          |           ########
########           -----------------------------------------           ########
########           |    Withdrawing  |          0          |           ########
########           -----------------------------------------           ########
########                                                               ########
########           -----------------------------------------           ########
########           |      WALLET     | aleo1s3ws5...em2u4t |           ########
########           -----------------------------------------           ########
########           -----------------------------------------           ########
########           |        Balance  |          50         |           ########
########           -----------------------------------------           ########
########                                                               ########
########           -----------------------------------------           ########
########           |      BANK       | aleo1rhgdu...vzp9px |           ########
########           -----------------------------------------           ########
########           -----------------------------------------           ########
########           |        Balance  |         266         |           ########
########           -----------------------------------------           ########
########           |        Periods  |          15         |           ########
########           -----------------------------------------           ########
########           |  Interest Rate  |        12.34%       |           ########
########           -----------------------------------------           ########
########                                                               ########
########           -----------------------------------------           ########
########           |  TOTAL BALANCE  |         316         |           ########
########           -----------------------------------------           ########
########                                                               ########
###############################################################################
"

# Swap in the private key and address of the bank to .env.
echo "
NETWORK=mainnet
PRIVATE_KEY=APrivateKey1zkp8CZNn3yeCseEtxuVPbDCwSyhGW6yZKUYKfgXmcpoGPWH
ENDPOINT=https://localhost:3030
" > .env

# Have the bank withdraw all of the user's tokens with compound interest over 15 periods at 12.34%.
echo "
###############################################################################
########                                                               ########
########  STEP 4: Withdraw tokens of aleo1s3ws5...em2u4t w/ interest   ########
########                                                               ########
########           -----------------------------------------           ########
########           |      ACTION     |        AMOUNT       |           ########
########           -----------------------------------------           ########
########           -----------------------------------------           ########
########           |        Issuing  |          0          |           ########
########           -----------------------------------------           ########
########           |     Depositing  |          0          |           ########
########           -----------------------------------------           ########
########           |    Withdrawing  |         266         |           ########
########           -----------------------------------------           ########
########                                                               ########
########           -----------------------------------------           ########
########           |      WALLET     | aleo1s3ws5...em2u4t |           ########
########           -----------------------------------------           ########
########           -----------------------------------------           ########
########           |        Balance  |         316         |           ########
########           -----------------------------------------           ########
########                                                               ########
########           -----------------------------------------           ########
########           |      BANK       | aleo1rhgdu...vzp9px |           ########
########           -----------------------------------------           ########
########           -----------------------------------------           ########
########           |        Balance  |          0          |           ########
########           -----------------------------------------           ########
########           |        Periods  |          15         |           ########
########           -----------------------------------------           ########
########           |  Interest Rate  |        12.34%       |           ########
########           -----------------------------------------           ########
########                                                               ########
########           -----------------------------------------           ########
########           |  TOTAL BALANCE  |         316         |           ########
########           -----------------------------------------           ########
########                                                               ########
###############################################################################
"
leo run withdraw aleo1t0uer3jgtsgmx5tq6x6f9ecu8tr57rzzfnc2dgmcqldceal0ls9qf6st7a 50u64 1234u64 15u64 || exit

