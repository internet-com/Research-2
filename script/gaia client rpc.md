gaia client rpc block --height <height>, then take a look at the number of precommits
Z
23:40
(unfortunately the latter command lists validator addresses and not pubkeys, so it's not immediately obvious which validator addresses have what power)

You can use gaia client rpc block --height <blockheight> to inspect the block header for info about things like total transactions sent:

 "header": {
      "chain_id": "unofficial-102",
      "height": 33675,
      "time": "2018-03-09T13:02:04.014-08:00",
      "num_txs": 0,
      "last_block_id": {
        "hash": "8B81F3BE144CE40E7F8D6461F6BE42340F81EF71",
        "parts": {
          "total": 1,
          "hash": "8779C50CE8B0C6F2A9D74263884D643BD50B37F2"
        }
      },
      "total_txs": 252,
      "last_commit_hash": "03632362A3F29C7079D2C1BC55F223DF7D818822",
      "data_hash": "",
      "validators_hash": "7A579E6FF8EA02F4FE4040CD9A4DF4CE8C7313F3",
      "consensus_hash": "B9FD9BB442BAD53793C4C744D44B5F8AF4C09438",
      "app_hash": "504B868C39FFC7DF73BD6676538F053EFA8A3AB0",
      "last_results_hash": "",
      "evidence_hash": ""
    }

252 transactions sent so far
the validators obeyed "no empty blocks" only when it was just the genesis validators
05:05
upon declaring a validator candidate, even if the validator candidate was already a genesis validator, they started finalizing empty blocks