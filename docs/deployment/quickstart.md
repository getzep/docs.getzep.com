# Quick Start

Looking for a fast way to get developing with Zep?

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](/deployment/render)

### Starting a Zep server locally is simple.

!!! note "Docker on  Macs: Embedding is slow!"

    **For docker compose deployment we default to using OpenAI's embedding service.**
    
    Zep relies on PyTorch for embedding inference. On MacOS, Zep's NLP server runs in a Linux ARM64 container. PyTorch is not optimized to run on Linux ARM64 and does not have access to MacBook M-series acceleration hardware.
    
    
    Want to use local embeddings? See [Selecting Embedding Models](embeddings.md).

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

    Zep uses OpenAI for chat history summarization, intent analysis, and, by default, embeddings. You can get an [Open AI Key here](https://openai.com/).

&nbsp;

3\. Start the Zep server:


```bash
docker-compose up
```

This will start a Zep server on port `8000`, an NLP server on port 8080, and a Postgres database on port `5432`.


!!! Warning "Configure Server Authentication"

    If you are deploying Zep to a production environemnt or where Zep APIs are exposed to the public internet, 
    please ensure that you secure your Zep server by [configuring authentication](/deployment/auth).
    Failing to do so will leave your server open to the public.

&nbsp;

4\. Get started with the [Zep SDKs](../sdk/index.md)!

- Install the **[Python](https://github.com/getzep/zep-python)** or **[Javascript](https://github.com/getzep/zep-js)** SDKs by following the [SDK Guide](/sdk/).
- Looking to develop with Langchain? Check out the [Langchain SDK](../sdk/langchain.md).



### Next Steps

- Setting up [authentication](auth.md)
- Developing with [Zep SDKs](../sdk/index.md)
- Learn about [Extractors](../sdk/extractors.md)
- Setting Zep [Configuration options](config.md)
- Learn about [deploying to production](production.md)
