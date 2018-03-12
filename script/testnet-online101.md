fork https://github.com/validstate/testnets (branch inofficial-101)
copy file gaia/genesis-inclusion-requests/request.toml.template to gaia/genesis-inclusion-requests/syuuuu.toml
21:17
fill it out, commit, push, send pull request 
don't need to separate sentry + validator when using the AWS, but assuming you just want to run one node in AWS, make sure that "sentry.host" is the public IP of this node
this will end up in "seeds =" of the config.toml
you need a python3 with fire and toml installed (e.g. pip install -f scripts/chainsetup/requirements.txt), and then you run python3 scripts/chainsetup/generate-config.py inofficial-101 and python3 scripts/chainsetup/generate-genesis.py inofficial-101

py3.6 actually


pip3 install -r  requirements.txt

python3 scripts/chainsetup/generate-config.py inofficial-101

python3 scripts/chainsetup/generate-genesis.py inofficial-101