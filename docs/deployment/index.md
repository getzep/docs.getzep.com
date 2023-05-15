# Deploying Zep
## Production
Dockerfiles for both the Zep server and a Postgres database with `pgvector` installed may be found in this repo.

Prebuilt containers for both `amd64` and `arm64` may be installed as follows:
```bash
docker pull ghcr.io/getzep/zep:latest
```

Many cloud providers, including AWS, now offer managed Postgres services with `pgvector` installed.

## Local Development

See the [Quickstart guide](deployment/quickstart) for instructions on how to run Zep locally.
