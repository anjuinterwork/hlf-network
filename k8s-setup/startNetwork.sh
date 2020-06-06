# Function definitions

get_pods() {
    kubectl get pods --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}'
}

sep() {
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
}



# Starting the Network
echo Starting Network
minikube start
sep

echo Creating TLS CA pod
kubectl apply -f tls-ca-server.yaml
sep

echo Pod Names
get_pods
sep

echo Copy TLS certificate to local folder 
export TMP_FOLDER=tmp-certificates
mkdir -p $TMP_FOLDER
# kubectl cp default/<some-pod>:/tmp/foo $TMP_FOLDER
