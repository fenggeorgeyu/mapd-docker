
name=mapd-gpu-`whoami`
image=mapd/mapd-ce-cuda

host_dir=$(shell pwd)
# db folder
vol1=${host_dir}/mapd-storage
mnt1=/mapd-storage

pl1=9090-9092
pdk1=9090-9092

passwd=HyperInteractive

pull:
	docker pull 

create: create-mapd

create-mapd:
	[ -d ${vol1} ] || mkdir ${vol1}
	docker run --runtime=nvidia -d -it --name ${name} -v ${vol1}:${mnt1} -p ${pl1}:${pdk1} ${image}

bash:
	docker exec -it ${name} /bin/bash

connect:
	docker exec -it ${name} /mapd/bin/mapdql -p ${passwd}

# docker exec -it ${name} mysql -uroot -p${passwd}


start:
	docker start ${name}

stop:
	docker stop ${name}

delete:
	docker rm ${name}

insert_sample_data:
	docker exec -it ${name} ./insert_sample_data
