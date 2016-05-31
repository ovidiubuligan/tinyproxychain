
####This is the base repository for ovidiubuligan/tinyproxychain docker image
This is an **alpha** stage image and is currently  based ubuntu which is 120 MB . It should be swapped with  a smaller base image.
 
 The image bundles proxychains 3.1 (latest in the ubuntu repositoryes) and tinyproxy and exposes their configs to a mounted volume `/configdata`.

> **Note:**  Proxychains 3.1 does not support dynamically  linked network
> libraries like 4.x but is enough for statically linked binaries (which
> tinyproy is )

### For tinyproxy
-You will have to configure tinyproxy to `Port 8080` in order to be in sync with the `EXPOSED` port.
-Set up `Allow` networks , or comment all `Allow` lines to allow all networks to access this proxy .
-Comment out all `ConnectPort` to allow tinyproxy for incomming https connections:

### For proxychains
Just add a list of proxies at the end of the file in which which will be your chain

###start.sh (main script that is run)
 The `start.sh` script is the entrypoint of the 'contained app' and does the following :
	 

 1. if `tinyproxy.conf` and `proxychains.conf` files are present in the mounted volume it copyes them to their respectiv default config locations. then starts tinyproxy through proxychains
 2. if `tinyproxy.conf` and `proxychains.conf` files are **NOT** present in the mounted volume it copies them from the container to the mounted volume. (This was done in case you don't have any configured proxychains or tinyproxy files)


###Running the image as a container
If you don't have `proxychains.conf`  and `tinyproxy.conf` just run the image as if you had configured them already:

```
docker run  -d -p 10444:8080  \
	-v /c/Users/myuser/dev/tinyproxychains_RUN:/configdata \
	--name myproxy\
	ovidiubuligan/tinyproxychain:0.1
```

After this  the configs will be copied over the to the mounted volume. You can stop the container edit the configs and start the container and  it will copy the config files again. (When editing the config files in windows you should save them with unix line endings '\f' and not windows '\r\f'). 