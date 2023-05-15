# Quick Start

### Starting a Zep server locally is simple. 

1\. Clone this repo

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

4\. Access Zep via the Python or Javascript SDKs:

Install the **[Python](https://github.com/getzep/zep-python)** or **[Javascript](https://github.com/getzep/zep-js)** SDKs.

=== "Python"

    ``` py title="Add a memory using the Python SDK"
    async with ZepClient(base_url) as client:
        role = "user"
        content = "who was the first man to go to space?"
        message = Message(role=role, content=content)
        memory = Memory()
        memory.messages = [message]
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
     const result = await client.addMemoryAsync(session_id, memory);
    ```

### Next Steps

- Learn [Key Concepts](concepts.md)