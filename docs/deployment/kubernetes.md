## Setting up Zep in a Kubernetes Cluster
:octicons-tag-24: **1.8.1**

!!! note "Deploying Zep v0.9.0-beta to Kubernetes"

    The instructions below are for deploying Zep v0.8.1 Stable to Kubernetes. 

    For instructions on deploying beta versions of Zep to Kubernetes, please refer to the `docker-compose-beta.yaml` file in the Zep repo for image tags and configuration params.

1. Setup a Kubernetes Cluster (e.g., using Docker Desktop for local testing on your laptop)
Make sure cluster is running...
```shell
kubectl cluster-info
```

2. Create a Secret to store the `OPENAI_API_KEY`
```shell
kubectl create secret generic zep-secret --from-literal=ZEP_OPENAI_API_KEY=<your-api-key>
```
3. Run the deployment yaml
```shell
kubectl apply -f zep-deployment.yaml
```

4. Make sure you have setup port forwarding (default listen port in the config is localhost:8000)
```shell
kubectl port-forward service/zep 8000:8000
```

### Note
The base instructions above will bring up a Kubernetes deployment of Zep server and related containers, 
with the default configuration. Zep has a number of configuration params that are provided in the 
`.env` file to setup authentication etc. for users wanting to customize deployments and have fine-grained controls 
and enabling optional features. 

If you want to use any of those optional params, you will need to create a `configMap` from those
params and update the `zep-deployment.yaml` file to reference/load these params. 
You can run: to reload the cluster with new config params. 
```shell
kubectl apply -f zep-deployment.yaml 
```