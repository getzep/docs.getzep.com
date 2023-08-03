# Quick Start

!!! important "Zep v0.9-beta Deployment Guide"

    This guide is for the latest stable version of Zep. 

    If you'd like to use Zep's new **Document Vector Store**, please see the [Zep v0.9.0-beta Deployment Guide](/deployment/deployment-beta).


### Starting a Zep server locally is simple.

1\. Clone the [Zep repo](https://github.com/getzep/zep)

```bash
git clone https://github.com/getzep/zep.git
```

&nbsp;

2\. Add your OpenAI API key to a `.env` file in the root of the repo:

```bash
ZEP_OPENAI_API_KEY=<your key here>
```

!!! note "Important"

    You must have an OpenAI API key to use Zep. You can get one [here](https://openai.com/).

&nbsp;

3\. Start the Zep server:


=== ":fontawesome-solid-robot: Zep v0.8.1 Stable"

    ```bash
    docker-compose up
    ```

    This will start a Zep server on port `8000`, an NLP server on port 8080, and a Postgres database on port `5432`.


=== ":fontawesome-solid-robot: Zep v0.9.0-beta.0"

    Looking for Zep's Document Vector Store? Please see the [Zep v0.9.0-beta Deployment Guide](/deployment/deployment-beta).



!!! Warning "Configure Server Authentication"

    If you are deploying Zep to a production environemnt or where Zep APIs are exposed to the public internet, 
    please ensure that you secure your Zep server by [configuring authentication](/deployment/auth).
    Failing to do so will leave your server open to the public.

&nbsp;

4\. Access Zep via the Python or Javascript SDKs:

Install the **[Python](https://github.com/getzep/zep-python)** or **[Javascript](https://github.com/getzep/zep-js)** SDKs by following the [SDK Guide](/sdk/).

&nbsp;

!!! info "Looking for a quick cloud deployment?"

    [![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](/deployment/render)


### Next Steps

- Setting up [authentication](/deployment/auth)
- Developing with [Zep SDKs](/sdk)
- Learn about [Extractors](/extractors)
- Setting Zep [Configuration options](/deployment/config)
- Learn about [deploying to production](/deployment)
