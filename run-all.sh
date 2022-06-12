#!/bin/bash

cd crypto-exchange-fe && ./dockerize.sh

kind create cluster --config kind-config.yaml

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/namespace.yaml

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/metallb.yaml

kubectl get pods -n metallb-system --watch

## get ip range from docker used for kind and update the range in the network-configmap.yaml below before applying it
docker network inspect -f '{{.IPAM.Config}}' kind

kubectl apply -f ./k8s-demo-helm/network-configmap.yaml

kind load docker-image bitvavo/k8s-istio-demo-app:latest

helm install k8s-canary-demo k8s-demo-helm

