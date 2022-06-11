#!/bin/bash

cd crypto-exchange-fe && ./dockerize.sh

cd ../k8s-istio-demo-helm && kind create cluster --config=kind-config.yaml

kind load docker-image bitvavo/k8s-istio-demo-app:latest

cd .. && helm install k8s-istio-demo k8s-istio-demo-helm
