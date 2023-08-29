<p align="center">
  <a href="https://squidfunk.github.io/mkdocs-material/">
    <img src="https://github.com/getzep/zep/blob/main/assets/zep-bot-square-200x200.png?raw=true" width="150" alt="Zep Logo">
  </a>
</p>

<h1 align="center">
A long-term memory store for LLM applications
</h1>

<p align="center">
  <a href="https://discord.gg/W8Kw6bsgXQ"><img
    src="https://dcbadge.vercel.app/api/server/W8Kw6bsgXQ?style=flat"
    alt="Chat on Discord"
  /></a>
  <a href="https://pypi.org/project/zep-python"><img alt="PyPI - Downloads" src="https://img.shields.io/pypi/dw/zep-python?label=pypi%20downloads"></a>
  <a href="https://www.npmjs.com/package/@getzep/zep-js"><img alt="@getzep/zep-js" src="https://img.shields.io/npm/dw/%40getzep/zep-js?label=npm%20downloads"></a>
</p>

<p align="center">
<a href="/deployment/quickstart/">Quick Start Guide</a> &nbsp; | &nbsp; 
<a href="/sdk/langchain/">Zep X LangChain 🦜⛓</a> &nbsp; | &nbsp; 
<a href="/sdk/llamaindex/">Zep X LlamaIndex 🦙</a> &nbsp; | &nbsp;
<a href="https://discord.gg/W8Kw6bsgXQ">Discord 💬</a><br />
<a href="https://www.getzep.com">www.getzep.com</a>
</p>

<h2>Easily add relevant documents, chat history memory & rich user data to your LLM app's prompts.</h2>

### Vector Database with Hybrid Search

Populate your prompts with relevant documents and chat history. Rich metadata and JSONPath query filters offer a powerful hybrid search over texts.

### Batteries Included Embedding & Enrichment

- Automatically embed texts, or bring your own vectors.
- [Enrichment of chat histories](/sdk/extractors) with summaries, named entities, token counts. Use these as search filters.
- Associate your own metadata with documents & chat histories.
- Support for OpenAI, Anthropic, and local LLMs

### Fast, low-latency APIs and stateless deployments

- Zep’s local embedding models and async enrichment ensure a snappy user experience.
- Storing documents and history in Zep and not in memory enables stateless deployment.

## Getting Started

### Docker Compose Deployment

Follow the [Quick Start Guide](./deployment/quickstart.md) to deploy Zep with Docker Compose.

### Prefer deploying to the cloud?

<p style="display: flex; align-items: center;">
    <a class="md-button" href="https://www.getzep.com/#join-waitlist" style="margin-right: 20px; padding: inherit 15px; border-radius: 7px;">
        Join the Zep Cloud Waitlist &nbsp;
        <span class="twemoji">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                <!--! Font Awesome Free 6.4.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free (Icons: CC BY 4.0, Fonts: SIL OFL 1.1, Code: MIT License) Copyright 2023 Fonticons, Inc.-->
                <path d="M498.1 5.6c10.1 7 15.4 19.1 13.5 31.2l-64 416c-1.5 9.7-7.4 18.2-16 23s-18.9 5.4-28 1.6L284 427.7l-68.5 74.1c-8.9 9.7-22.9 12.9-35.2 8.1S160 493.2 160 480v-83.6c0-4 1.5-7.8 4.2-10.7l167.6-182.9c5.8-6.3 5.6-16-.4-22s-15.7-6.4-22-.7L106 360.8l-88.3-44.2C7.1 311.3.3 300.7 0 288.9s5.9-22.8 16.1-28.7l448-256c10.7-6.1 23.9-5.5 34 1.4z"></path>
            </svg>
        </span>
    </a>
- or -
    <a href="/deployment/render" style="display: flex; align-items: center; margin-left: 20px">
        <img alt="Deploy to Render" src="https://render.com/images/deploy-to-render-button.svg">
    </a>
</p>

## Developing with Zep

<table>
<tr>
<td>

<h4>Document Vector Store</h4>

<p>With Zep's document vector store, you can build collections of documents useful for grounding your prompts. </p>
<p>Run semantic search over a collection using either Zep's own SDKs, or with Langchain.</p>

<a href="/sdk/documents" class="md-button md-button--primary">
    Document API
</a>

</td>
<td>

<h4>Chat History Store</h4>

<p>
    <p> With Zep's chat history store, you can capture your app's chat history, enrich it with metadata, and run semantic search over it.</p>
<p> Ground your prompts with context from prior conversations, both recent and distant past. Use Zep's own SDKs, or with Langchain.
</p>

<a href="/sdk/chat_history" class="md-button md-button--primary">
    Chat History API
</a>

</td>
</tr>
</table>

## Next Steps

- [Quick Start](deployment/quickstart.md): Run a Zep server locally and a primer on the Python or Javascript SDKs.
- Using Zep's [Python and Javascript SDKs](sdk/index.md)
- Developing with [Langchain and Zep](sdk/langchain)
