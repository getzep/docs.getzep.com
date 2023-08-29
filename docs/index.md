<p align="center">
  <a href="https://squidfunk.github.io/mkdocs-material/">
    <img src="https://github.com/getzep/zep/blob/main/assets/zep-bot-square-200x200.png?raw=true" width="150" alt="Zep Logo">
  </a>
</p>

<h1 align="center">
Batteries Included Memory for LLM apps
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


## Easily add relevant data to your LLM app's prompts.

Zep is built for LLM apps from the ground up. Adding relevant documents, chat history memory & rich user data to your prompts is simple. 


> Unlike other vector databases, *Users*, *Sessions*, *Memories*, and *Documents* are all first-class citizens in Zep.



<div class="grid cards" markdown>

-   :material-clock-fast:{ .lg .middle } __Set up in 5 minutes__

    ---

    Install via `docker compose` or Render and get up
    and running in minutes

    [:octicons-arrow-right-24: Quick Start](deployment/quickstart.md)

-   :material-magnify:{ .lg .middle } __Hybrid Vector Database__

    ---

    Populate your prompts with relevant documents and chat history

    [:octicons-arrow-right-24: Vector Store](sdk/documents.md)

-   :material-chat-outline:{ .lg .middle } __Persist Chat History__

    ---

    Store chat history, enrich it with metadata, and run semantic search over it

    [:octicons-arrow-right-24: Chat History](sdk/chat_history/index.md)

-   :material-cog:{ .lg .middle } __Enrich it all__

    ---

    Embeddings, summaries, named entities, token counts, and more

    [:octicons-arrow-right-24: Extractors](sdk/extractors.md)

-   :black_heart:{ .lg .middle } __Use the tools you love__

    ---

    Python :fontawesome-brands-python:, TypeScript :simple-typescript:, LangChain 🦜⛓️, LlamaIndex 🦙, and more

    [:octicons-arrow-right-24: SDKs](sdk/index.md)

-   :material-scale-balance:{ .lg .middle } __Open Source__

    ---

    Zep is licensed under MIT and available on [GitHub](https://github.com/getzep/zep)

    [:octicons-arrow-right-24: License](https://github.com/getzep/zep/blob/main/LICENSE)

</div>

----

## What you can build with Zep

1. **Chatbot Applications**: Zep's chat history storage enables context-aware chatbot applications.
3. **Retrieval Augmented Generation (RAG) Applications**: Zep's vector store aids in building applications that answer questions based on a document set.
2. **Agent Applications**: Zep's document vector store and enriched chat history store can be used as tools by agents, able to look up relevant information and past conversations.
4. **Data Enrichment Applications**: Zep's extractors can be used for applications that need to analyze and understand the text data from human/bot conversations.

----

## Quick Start

<p style="display: flex; align-items: center; margin-bottom: 80px">
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
