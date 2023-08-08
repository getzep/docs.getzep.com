# Production Deployment
Dockerfiles and Kubernetes configs for the Zep server, Zep NLP server, and a Postgres database with `pgvector` installed may be found in the [Zep repo](https://github.com/getzep/zep).

Many cloud providers, including AWS, now offer managed Postgres services with `pgvector` installed.

The [Zep docker-compose file](https://github.com/getzep/zep/blob/main/docker-compose.yaml) may be used as a deployment template for other container environments.

Prebuilt containers for both `amd64` and `arm64` architectures may be found on the [Zep Package Repo](https://github.com/orgs/getzep/packages?repo_name=zep).

## Hardware Requirements

For production deployment planning, please be mindful of the following.

### Memory requirements

You will need adequate memory for Zep's NLP and Postgres containers. The amount of memory required will be dictated by:
  
- **NLP Server**: The number of different embedding models you will be using and the size of these models. See [Selecting Embedding Models](embeddings.md).
- **Postgres** As the number of documents in your Collections grow and you create indexes over these collections, you will need to ensure that you have adequate memory available. Please see Postgres best practice deployment guides for more information.

### Database storage requirements

Zep's Postgres database will require adequate storage for your documents, document vectors, chat message histories, and chat message history vectors. The amount of storage required will be dictated by your use case, the width of your embedding vectors, and other variables.
