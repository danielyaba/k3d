# justfile

# Define variables
API_PORT := "6550"
LB_PORT := "8080"
LB_TARGET_PORT := "80"
CLUSTER_NAME := "my-cluster"

# List tasks,
default:
    just --list

# Create K3D cluster with the specified configuration
create-cluster:
    echo "Creating K3D cluster {{CLUSTER_NAME}}..."
    k3d cluster create {{CLUSTER_NAME}} --api-port {{API_PORT}} -p "{{LB_PORT}}:{{LB_TARGET_PORT}}@loadbalancer"
    echo "K3D cluster created successfully."

# Delete K3D cluster
delete-cluster:
    echo "Deleting K3D cluster..."
    k3d cluster delete {{CLUSTER_NAME}}
    echo "K3D cluster deleted successfully."

# Deploy ArgoCD
deploy-argocd:
    echo "Deploying ArgoCD..."
    helm install argocd argo/argo-cd --values argocd-values.yaml --namespace argocd --create-namespace
    kubectl rollout status deployment/argocd-repo-server --namespace argocd
    echo "ArgoCD deployed successfully."
    echo "Access ArgoCD UI: http://localhost:8080"
    echo "$(kubectl get secrets argocd-initial-admin-secret --namespace argocd -o jsonpath="{.data.password}" | base64 -d)"

# Deploy ArgoCD
upgrade-argocd:
    echo "Upgrading ArgoCD..."
    helm repo add argo
    helm repo update
    helm upgrade argocd argo/argo-cd --values argocd-values.yaml --namespace argocd --create-namespace
    echo "ArgoCD deployed successfully."
    echo "Access ArgoCD UI: http://localhost:8080"
    echo "Argocd password: $(kubectl get secrets argocd-initial-admin-secret --namespace argocd-o jsonpath="{.data.password}" | base64 -d)"

# Delete ArgoCD
delete-argocd:
    echo "Deleting ArgoCD from K3D cluster {{CLUSTER_NAME}}..."
    kubectl delete namespace argocd
    echo "ArgoCD deleted successfully."

# Add ArgoCD App-of-Apps Repository
add-app-of-apps-repo:
    echo "Adding ArgoCD App-of-Apps Repository..."
    kubectl apply -f app-of-apps-repo.yaml
    echo "Repository added successfully."

# Get ArgoCD password
get-argocd-pass:
    echo "$(kubectl get secrets argocd-initial-admin-secret --namespace argocd -o jsonpath="{.data.password}" | base64 -d)"

# Apply devops-apps
apply-devops-apps:
    kubectl apply -f devops-apps.yaml

apply-external-apps:
    kubectl apply -f external-apps.yaml

# Connect to ArgoCD with port-forward directly to the ArgoCD service
argocd-port-forward:
    kubectl port-forward --namespace argocd svc/argocd-server 8080:80

# Create cluster with all components deployed
spinup-cluster-with-argocd: create-cluster deploy-argocd add-app-of-apps-repo apply-devops-apps get-argocd-pass argocd-port-forward


