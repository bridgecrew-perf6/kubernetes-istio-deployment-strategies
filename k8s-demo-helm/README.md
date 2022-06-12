## Local setup

This Helm chart enable you to run a local setup of the application. 
It's meant to be used in development environments only.

## How to run the local setup

1. Update the crypto-exchange-fe docker image running `../crypto-exchange-fe/dockerize.sh`
2. Start the Kind cluster: `cd ${PWD}/helm && kind create cluster --config=kind-config.yaml`
3. Load the image into kind: `kind load docker-image bitvavo/k8s-istio-demo-app:latest`
4. Install the helm charts(from project root dir): `cd .. && helm install k8s-istio-demo k8s-istio-demo-helm`

Optionally run the `run-all.sh` script

## How to stop local setup

1. Unload helm project: `helm uninstall local-dev`
2. Stop Kind cluster(docker): `kind delete cluster`

## Update the app in Helm

1. Update the docker image `dockerize.sh`
2. Bump the application version in `Chart.yaml`
3. Run `helm upgrade --install local-dev local-dev-helm-chart`


## DB management for PRD 

Using flyway as a kubernetes `initcontainer` in the Helm chart configuration for Kubernetes. 
Flyway runs as an init container when the pod with the application is started. Auto table creation by typeorm framework
should be disabled for PRD builds so the flyway scripts will manage the versioning of DB.

