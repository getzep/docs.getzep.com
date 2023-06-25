# Deploying Zep

1. Using [docker-compose](/deployment/quickstart).
2. Deploying to the [Render platform](/deployment/render).
3. Deploying to [production environments.](#production)
4. [Configuring authentication.](/deployment/auth)
5. [Data management](/deployment/data) with Zep.
5. [Configuring the Zep service](/deployment/config).
6. OpenAI API and Azure [OpenAI API configuration](/deployment/openai).

## Production
Dockerfiles for the Zep server, Zep NLP server, and a Postgres database with `pgvector` installed may be found in the [Zep repo](https://github.com/getzep/zep).

Many cloud providers, including AWS, now offer managed Postgres services with `pgvector` installed.

The [Zep docker-compose file](https://github.com/getzep/zep/blob/main/docker-compose.yaml) may be used as a deployment template for other environments.

Prebuilt containers for both `amd64` and `arm64` architectures may be found on the [Zep Package Repo](https://github.com/orgs/getzep/packages?repo_name=zep).

