# Quick Start

!!! info "Looking for a quick cloud deployment?"

    [![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](/deployment/render)

!!! question "Need help?"

    [Join our Discord](https://discord.gg/W8Kw6bsgXQ) and ask away!

    [![](https://dcbadge.vercel.app/api/server/W8Kw6bsgXQ?style=flat)](https://discord.gg/W8Kw6bsgXQ)

### Starting a Zep server locally is simple.

1\. Clone the [Zep repo](https://github.com/getzep/zep)

```bash
git clone https://github.com/getzep/zep.git
```

2\. Add your OpenAI API key to a `.env` file in the root of the repo:

```bash
ZEP_OPENAI_API_KEY=<your key here>
```

!!! note "Important"

    You must have an OpenAI API key to use Zep. You can get one [here](https://openai.com/).

3\. Start the Zep server:

```bash
docker-compose up
```

This will start a Zep server on port `8000`, and a Postgres database on port `5432`.

!!! Warning "Configure Server Authentication"

    If you are deploying Zep to a production environemnt or where Zep APIs are exposed to the public internet, 
    please ensure that you secure your Zep server by [configuring authentication](/deployment/auth).
    Failing to do so will leave your server open to the public.

4\. Access Zep via the Python or Javascript SDKs:

Install the **[Python](https://github.com/getzep/zep-python)** or **[Javascript](https://github.com/getzep/zep-js)** SDKs.

=== "Python"

    ``` py title="Add a memory using the Python SDK"
    async with ZepClient(base_url) as client:
        role = "user"
        content = "who was the first man to go to space?"
        message = Message(role=role, content=content)
        memory = Memory(messages=[message])
        # Add a memory
        result = await client.aadd_memory(session_id, memory)
    ```

=== "Javascript"

    ``` ts title="Add a memory using the Javascript SDK"
     // Add memory
     const role = "user";
     const content = "I'm looking to plan a trip to Iceland. Can you help me?"
     const message = new Message({ role, content });
     const memory = new Memory();
     memory.messages = [message];
     const result = await client.addMemory(session_id, memory);
    ```

### Next Steps

- Setting up [authentication](/deployment/auth)
- Learn about [Extractors](/extractors)
- Setting Zep [Configuration options](/deployment/config)
- Learn about [deploying to production](/deployment)
