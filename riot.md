I have reopened the issue, https://github.com/cosmos/gaia/issues/121
My suggestiong is we should be careful with the setup bonding process, let the account with the most ATOM bond first and so.
Maybe we could force the accounts in genesis file to be bonded. 


I agree to purchase [646,517] Tokens (“Purchased Tokens”) at a price of US$[0.077337] per Token (“Token Price”), for a total purchase price of US$[50,000] (“Purchase Amount”).  
I agree to make payment of the Purchase Amount in
ETH, in the amount of [56.7145], by transfer to the address specified by the Foundation in writing, clear of any transaction fees.
646,517 IRIS Token for price of 56.7145 ETH



19:56
guys, since the gaia-3003 chain is fckd again already, would you mind joining an inofficial chain? Kris Pritchard brandon Aamatar gamarin mdyring adrianbrink roblav96 aurel Bbascule ZZaki and whoever I don't know -- this is permissionless :) those interested, please fork validstate/testnets branch inofficial-101 on github, copy https://github.com/validstate/testnets/blob/inofficial-101/inofficial-101/gaia/genesis-inclusion-requests/request.toml.template\ to <your_validator_name>.toml, adapt to your needs (i.e. fill out the empty strings) and send a pull request. my example is https://github.com/validstate/testnets/blob/inofficial-101/inofficial-101/gaia/genesis-inclusion-requests/validstate.toml\ (DNS name for the "host" entry is not necessary if you don't have one).