#!/bin/bash
cd

# ---- Variables ----
dcs_startup_name="DataCloudServices"
dcs_path_current=$(pwd)
dcs_path_root="${dcs_path_current}/${dcs_startup_name}"
dcs_path_config="${dcs_path_root}/config"
dcs_onedev_tag="7.4.6"
dcs_url_dockercompose="https://raw.githubusercontent.com/DataCloudServices/startup-setup/main/docker-compose.yaml"

# ---- INIT ----
mkdir ${dcs_path_root}
mkdir ${dcs_path_config}

# ---- OneDev -----
docker run \
    --tty \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v ${dcs_path_config}/onedev:/opt/onedev \
    -p 6610:6610 \
    -p 6611:6611 \
    --detach \
    1dev/server:${dcs_onedev_tag}

# ---- WikiJs
cd ${dcs_path_config}
wget ${dcs_url_dockercompose}
docker-compose up -d
cd -