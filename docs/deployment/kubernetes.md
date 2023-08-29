# Setting up Zep in a Kubernetes Cluster

## Setup a Kubernetes Cluster

Setup a Kubernetes Cluster (e.g. using Docker Desktop for local testing on your laptop).

Make sure cluster is running...

```shell
kubectl cluster-info
```

## Create an OpenAI API Key secret

Create a Secret to store the `OPENAI_API_KEY`

```shell
kubectl create secret generic zep-secret --from-literal=ZEP_OPENAI_API_KEY=<your-api-key>
```

## Deploy Zep

Run the deployment yaml

```shell
kubectl apply -f zep-deployment.yaml
```

## Access Zep

Make sure you have setup port forwarding (default listen port in the config is localhost:8000)

```shell
kubectl port-forward service/zep 8000:8000
```

Point your Zep Python or JavaScript client to `http://localhost:8000` to access the Zep API.

## Installing on EKS, GKE, and other managed Kubernetes services

The base instructions above will bring up a local Kubernetes deployment of a Zep server and related containers,
with a very limited configuration. For production or managed Kubernetes deployment, this template should be edited
to include [resource requests and limits](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/),
and other Zep [configuration options](config.md) and secrets.

For resource requirements to consider, see the [production deployment guide](production.md).
