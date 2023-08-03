#!/bin/bash

set -x
echo "params: $@"

clinfo -l
data_dir_var=${DATA_DIR=/root/data}
post_dir_var=${POST_DIR=/root/post}
log_dir_var=${LOG_DIR=/root/log}

user_node_config_var=${USER_NODE_CONFIG=/root/cfg/node-config.json}
listen_port=${LISTEN_PORT=7513}

jq -s '.[0] * .[1] * .[2]' config-mainnet.json config-disable-remote-grpc.json $user_node_config_var > config.json 

echo "Generated config:"
cat config.json

mkdir -p $log_dir_var

./go-spacemesh \
	--config config.json \
	-d $data_dir_var \
	--smeshing-opts-datadir $post_dir_var \
	--listen /ip4/0.0.0.0/tcp/$LISTEN_PORT \
	$@ |& tee $log_dir_var/spacemesh.log
