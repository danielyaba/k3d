# K3D

This repository lets you spin up a kubernetes cluster easily based on K3D.

### Requirements
* [Justfile](https://just.systems/man/en/) - Alternative to Makefile
* [K3D](https://k3d.io/) - K3D CLI
* [Kubectl](https://kubernetes.io/docs/tasks/tools/) - Kubectl CLI to interact with the kubernetes cluster


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
Applies the ArgoCD App-of-Apps repository (You should create your own repository similarly to this [repository](https://github.com/danielyaba/argocd-app-of-apps)  


* apply-devops-apps:  
Applies the [devops applications manifest](devops-apps.yaml#1) for installing all infrastructure charts

* apply-external-apps:  
Applies the [external applications manifest](external-apps.yaml#1) for installing all external applications charts

* argocd-port-forward:  
Creates port-forward to ArgoCD service on `http://localhost:8080`

* create-cluster:  
Creates fresh kubernetes cluster with the specified configuration (justfile#3)

* delete-argocd:  
Deletes ArgoCD namespace from the cluster along with its reousrces 

* delete-cluster:  
Deletes the K3D cluster

* deploy-argocd:
Installs the ArgoCD Helm chart and wait for the deployment `argocd-repo-server` to be ready

* get-argocd-pass:  
Prints the ArgoCD admin password

* spinup-cluster-with-argocd:  
Create a K3D cluster and install the ArogCD Helm chart

* upgrade-argocd:  
Upgrades the ArogCD Helm chart
