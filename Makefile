

.PHONY: k3d cluster disable-traefik clean

help:
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//' 
##
## ------------------------------------
## Cluster
## ------------------------------------
## make k3d - Download k3d
k3d:
	wget -q -O - https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash

## make cluster - Create cluster k3d, with the example k3d.yaml
cluster:
	curl https://raw.githubusercontent.com/adilsonmenechini/k8s-hands-on/main/k3d.yaml | k3d cluster create --config -

## make disable-traefik - Create cluster k3d, with the example k3d.yaml whitout traefik
disable-traefik:
	curl https://raw.githubusercontent.com/adilsonmenechini/k8s-hands-on/main/k3d.yaml | k3d cluster create --config - \
	--k3s-arg "--disable=traefik@server:0"

## make clean - Delete cluster k3d
clean:
	curl https://raw.githubusercontent.com/adilsonmenechini/k8s-hands-on/main/k3d.yaml | k3d cluster delete --config -
	docker rmi $$(docker images -q)
	find ./ -name charts -exec rm -rf {} \;