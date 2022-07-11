# Welcome to simple to deploy opensuse home mirror container

You might want to consider also looking into https://github.com/Firstyear/opensuse-proxy-cache
if you're on a tight space budget.

The idea is to provide almost a single click super quick to deploy a mirror
solution for your home or a local community.


## Few clicks deployment

I'm using RaspPi 4 8Gb with 1TB SSD connected via USB with a clean install of
Leap Micro 5.2 managed by a cockpit web interface (install patterns-microos-cockpit). See the [demo](https://www.youtube.com/watch?v=ft8UVx9elKc) or [related docs](
https://documentation.suse.com/sle-micro/5.2/single-html/SLE-Micro-administration/#sec-admin-cockpit)

* Simply access cockpit by https://$IPADDR:9090
* Go to podman containers and enable podman unless it's already enabled
* Click on Get new image
* Lookup opensuse/opensuse-mirror
* Set forwarding from host's port :80 to container's nginx port :8080
* I do recommend using a [volume](https://docs.docker.com/storage/volumes/) for /srv/pub/opensuse
* Choose the [rsync module] (https://mirrors.opensuse.org/list/rsyncinfo-stage.o.o.txt rsync module)
  which you'd like to mirror **the default is mirror_module is opensuse-hotstuff-hackweek**. The full 'opensuse-full' can easily consume few TB of space.
* Container will initiate sync of the selected module on the first start (check for /srv/pub/opensuse being empty)
* The mirror will be then re-synced daily via a cronjob at a random time of the day (by using RANDOM_DELAY=1380 minutes)

![Run image in cockpit](https://user-images.githubusercontent.com/510119/178058554-4bc92469-8e27-4395-8042-e37ad3a101b0.png)


As mentioned above, if you'd have a space budget, you can choose one of the hot stuff rsync
modules by specifying --build-args or simply passing "mirror_module" and "opensuse-hotstuff-160gb"
as Key/Value Environment pair in Cockpit's podman web management.

I plan to revisit and refresh these [hostuff modules](https://github.com/openSUSE/opensuse-hotstuff/tree/main/etc/rsyncd.d) or utilize the exclude list which
what I have been personally using at home. 
