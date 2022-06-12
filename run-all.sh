#!/bin/bash

cd crypto-exchange-fe && ./dockerize.sh

kind create cluster

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/namespace.yaml

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/metallb.yaml

kubectl get pods -n metallb-system --watch

## get ip range from docker used for kind and update the range in the network-configmap.yaml below before applying it
docker network inspect -f '{{.IPAM.Config}}' kind

kubectl apply -f ./k8s-demo-helm/network-configmap.yaml

kind load docker-image bitvavo/k8s-canary-app:v0.1

kind load docker-image bitvavo/k8s-canary-app:v0.1

helm install k8s-canary-demo k8s-demo-helm

## check the exposed LB IP address so you can export it
kubectl get svc/crypto-exchange-fe -o=jsonpath='{.status.loadBalancer.ingress[0].ip}'

# export the ip address above
export LB_IP=$IP_ADDRESS

