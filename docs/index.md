# About

!!! info "Quick Start"

    Looking to get going? The [Zep Quick Start Guide](/deployment/quickstart) has what you need.

    [![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](/deployment/render)

Zep stores, summarizes, embeds, indexes, and enriches LLM app / chatbot histories, and exposes them via simple, low-latency APIs. Zep allows developers to focus on developing their AI apps, rather than on building memory persistence, search, and enrichment infrastructure.

Zep's Extractor model is easily extensible, with a simple, clean interface available to build new enrichment functionality, such as summarizers, entity extractors, embedders, and more.

**Key Features:**

- **Fast!** Zep’s async extractors operate independently of the your chat loop, ensuring a snappy user experience.
- **Long-term memory persistence**, with access to historical messages irrespective of your summarization strategy.
- **Auto-summarization** of memory messages based on a configurable message window. A series of summaries are stored, providing flexibility for future summarization strategies.
- **Hybrid search** over memories and metadata, with messages automatically embedded on creation.
- **Intent Extraction** that automatically identifies the human's intent and stores this in the message metadata.
- **Entity Extractor** that automatically extracts named entities from messages and stores them in the message metadata.
- **Auto-token counting** of memories and summaries, allowing finer-grained control over prompt assembly.
- **JWT Authentication** for secure API access.
- **[Python](https://github.com/getzep/zep-python)** and **[Javascript](https://github.com/getzep/zep-js)** SDKs.
- [**Langchain**](/sdk/langchain) integration, enabling long-term memory and vector search over memory for Langchain projects.



## Why Zep?

Chat history storage is an infrastructure challenge all developers and enterprises face as they look to move from prototypes to deploying LLM/ AI Chat applications that provide rich and intimate experiences to users.

Long-term memory persistence enables a variety of use cases, including:

- Personalized re-engagement of users based on their chat history.
- Prompt evaluation based on historical data.
- Training of new models and evaluation of existing models.
- Analysis of historical data to understand user behavior and preferences.

However:

- Most LLM chat history or memory implementations run in-memory, and are not designed for stateless deployments or long-term persistence.
- Standing up and managing low-latency infrastructure to store, manage, and enrich memories is non-trivial.
- When storing messages long-term, developers are exposed to privacy and regulatory obligations around retention and deletion of user data.

The Zep server and client SDKs are designed to address these challenges.

## Next Steps

- [Quick Start](deployment/quickstart.md): Run a Zep server locally and a primer on the Python or Javascript SDKs.
- Using Zep's [Python and Javascript SDKs](/sdk)
- Developing with [Langchain and Zep](/sdk/langchain)
