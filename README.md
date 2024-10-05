# K3D

This repository lets you spin up a kubernetes cluster easily based on K3D.

### Requirements
* [Justfile](https://just.systems/man/en/) - Alternative to Makefile
* [K3D](https://k3d.io/) - K3D CLI
* [Kubectl](https://kubernetes.io/docs/tasks/tools/) - Kubectl CLI to interact with the kubernetes cluster
* [Docker](https://docs.docker.com/get-started/get-docker/) - Docker Desktop to run the kubernetes cluster


## Deployment

#### Editing cluster configuration
Edit `justfile` with the following variables:
* API_PORT - An api port of the cluster
* LB_PORT - Host port
* LB_TARGET_PORT - Docker container port
* CLUSTER_NAME - A name of the kubernetes cluster for K3D

Default values:
```
API_PORT := "6550"
LB_PORT := "8080"
LB_TARGET_PORT := "80"
CLUSTER_NAME := "my-cluster"
```

#### Spinמing Up K3D Cluster
Use `just` with the recepie    

##### Available Recepies:  
* add-app-of-apps-repo:  
Applie the ArgoCD App-of-Apps repository (You should create your own repository similarly to this [repository](https://github.com/danielyaba/argocd-app-of-apps)  


* apply-devops-apps:  
Applie the [devops applications manifest](devops-apps.yaml#1) for installing all infrastructure charts

* apply-external-apps:  
Applie the [external applications manifest](external-apps.yaml#1) for installing all external applications charts

* argocd-port-forward:  
Create port-forward to ArgoCD service on `http://localhost:8080`

* create-cluster:  
Create fresh kubernetes cluster with the specified configuration (justfile#3)

* delete-argocd:  
Delete ArgoCD namespace from the cluster along with its reousrces 

* delete-cluster:  
Delete the K3D cluster

* deploy-argocd:
Install the ArgoCD Helm chart and wait for the deployment `argocd-repo-server` to be ready

* get-argocd-pass:  
Print the ArgoCD admin password

* spinup-cluster-with-argocd:  
Create a K3D cluster, install the ArogCD Helm chart and apply the devops-apps application manifest

* upgrade-argocd:  
Upgrade the ArogCD Helm chart
