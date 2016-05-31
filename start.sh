#!/bin/sh

# /var/log/tinyproxy/tinyproxy.log
# # test paths
# HOST_TINY_CONFIG="./host_folder/tinyproxy.conf"
# HOST_PROXYCHAINS_CONFIG="./host_folder/proxychains.conf"

# CONTAINER_TINY_CONFIG="./container_folder/tinyproxy.conf"
# CONTAINER_PROXYCHAINS_CONFIG="./container_folder/proxychains.conf"


HOST_TINY_CONFIG="/configdata/tinyproxy.conf"
HOST_PROXYCHAINS_CONFIG="/configdata/proxychains.conf"

CONTAINER_TINY_CONFIG="/etc/tinyproxy.conf"
CONTAINER_PROXYCHAINS_CONFIG="/etc/proxychains.conf"


init_config_files () {
	# if host contains files
	if ! [ host_contains_files ] ; then	  	
	  	copy_files_from_container
	else 
		# files already present in volumes
		copy_configs_to_container
	fi
}

host_contains_files () {
   if [ -e "${HOST_TINY_CONFIG}" ] && [ -e "${HOST_PROXYCHAINS_CONFIG}" ] ; then
   	# 0 = true
   	return 0;
   else
   	# 1 = false
   	return 1;
   fi
}

copy_files_from_container () {
    echo "Copying configs FROM Container"
	cp "${CONTAINER_TINY_CONFIG}" "${HOST_TINY_CONFIG}" ;
	cp "${CONTAINER_PROXYCHAINS_CONFIG}" "${HOST_PROXYCHAINS_CONFIG}" ;
}

copy_configs_to_container () {
 	echo "Copying configs TO Container"
	cp "$HOST_TINY_CONFIG" "$CONTAINER_TINY_CONFIG" ;
	cp "$HOST_PROXYCHAINS_CONFIG" "$CONTAINER_PROXYCHAINS_CONFIG" ;
}

init_config_files 



# create required tinyproxy files
mkdir -p /var/run/tinyproxy && touch /var/run/tinyproxy/tinyproxy.pid
chmod 777 /var/run/tinyproxy/tinyproxy.pid

# Runn main
proxychains /usr/sbin/tinyproxy -d