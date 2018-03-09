git clone https://github.com/brandoncurtis/testnets.git $HOME/testnets
GAIANET=$HOME/testnets/unofficial-102/gaia
gaia node start --home=$GAIANET
gaia client init --chain-id unofficial-102 --node=tcp://0.0.0.0:46657

gaia client tx declare-candidacy --name bianjie --amount 1000fermion --pubkey A59140B268A36BA13A91E12CE8D8D356439517FA1DA3B6DE7207010FAB5A61C4 --moniker bianjie --details "bianjie.ai"