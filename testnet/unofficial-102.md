git clone https://github.com/brandoncurtis/testnets.git $HOME/testnets
GAIANET=$HOME/testnets/unofficial-102/gaia
gaia node start --home=$GAIANET >gaia.log
gaia client init --chain-id unofficial-102 --node=tcp://169.229.198.105:46657 --home /mnt/gaia_client

gaia client tx declare-candidacy --name suyuuu --amount 900fermion --pubkey A59140B268A36BA13A91E12CE8D8D356439517FA1DA3B6DE7207010FAB5A61C4 --moniker bianjie --details "bianjie.ai"

gaia client rpc status

gaia client keys recover suyuuuu

gaia client query account 7D626173FAA69D96E56523A333EAF78F87843CE5

dash judge window useless great script twenty estate parrot raccoon word meadow approve odor chef absent


/home/zhiqiang/.cosmos-gaia-cli/keys/bianjie.pub


gaia client tx send --name suyuuu --to A1457DF58614286DC70EBCBA50FD50B37262E4B5 --amount 1fermion

gaia client query candidate --pubkey A59140B268A36BA13A91E12CE8D8D356439517FA1DA3B6DE7207010FAB5A61C4

gaia client tx unbond --pubkey A59140B268A36BA13A91E12CE8D8D356439517FA1DA3B6DE7207010FAB5A61C4 --shares 900 --name suyuuu

gaia client rpc block --height 46439