# Deploying to Fly.io

!!! Warning "Not for Production Use"

    This deployment method should be used for development and testing purposes only. The deployment is not secure and set up for high availability. **Do not use this for production.**

#### 1. Clone the Zep repo

```sh
git clone https://github.com/getzep/zep.git
```

#### 2. Deploy Postgres Database with pgvector support

Zep requires access to a Postgres database server with `pgvector` support. We've created a Fly.io compatible postgres container image with `pgvector` installed. We recommend using the `shared-cpu-2x` VM size.

Deploy it as follows:

```sh
flyctl postgres create -n zep-postgres --vm-size shared-cpu-2x --image-ref ghcr.io/getzep/postgres-flyio:latest
```

Note down the connection string.
```text
  Connection string: postgres://postgres:XXXXXXXXXXX@zep-postgres.flycast:5432
```

#### 3. Edit the `fly.toml` file, adding the connection string

!!! note

    Append `?sslmode=disable` to the DSN URL to disable SSL.

```toml
[env]

ZEP_MEMORY_STORE_POSTGRES_DSN = "postgres://postgres:XXXXXXXXXXX@zep-postgres:5432?sslmode=disable"
```

Modify other Zep environment variables as needed. See [Config](/deployment/config/) for more information.


#### 4. Create the Fly.io app

Answer `YES` to the question about reusing the existing configuration file.
```sh
fly launch --no-deploy

An existing fly.toml file was found for app zep
? Would you like to copy its configuration to the new app? Yes
```

#### 5. Add your OpenAI API key as a secret

Create a `ZEP_OPENAI_API_KEY` secret:

```sh
flyctl secrets set -a zep ZEP_OPENAI_API_KEY=<your key>
```

or, if you have your key in a `.env` file:

```sh
cat .env | fly secrets import
```


#### 4. Deploy the Zep app

```sh
  flyctl deploy
```