## Local setup

This Helm chart enable you to run a local setup of the application. 
It's meant to be used in development environments only.

It provides a postgresql to be used in local development and also a pod with the application running in PRD mode for 
testing. The local port for postgres is 5432.
The neo-nutrilife-api is exposed on port 7777. 
There's also a maildev pod running exposing interface on port 1080 and smtp on port 25 which can be used for local tests
with sending emails.

## How to run the local setup

1. Update the neo-nutrilife-server docker image running `./dockerize.sh`
2. Start the Kind cluster: `cd ${PWD}/local-dev-helm-chart && kind create cluster --config=kind-config.yaml`
3. Load the image into kind: `kind load docker-image neo-nutrilife-api:latest` optionally also load the maildev and 
postgres image to speed up first start after starting the Kind docker service.
4. Install the helm charts(from project root dir): `helm install local-dev local-dev-helm-chart`

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

