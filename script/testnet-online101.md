fork https://github.com/validstate/testnets (branch inofficial-101)
copy file gaia/genesis-inclusion-requests/request.toml.template to gaia/genesis-inclusion-requests/syuuuu.toml
21:17
fill it out, commit, push, send pull request 
don't need to separate sentry + validator when using the AWS, but assuming you just want to run one node in AWS, make sure that "sentry.host" is the public IP of this node
21:23
this will end up in "seeds =" of the config.toml