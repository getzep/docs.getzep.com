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
<a href="/deployment/quickstart/">Quick Start Guide</a> | 
<a href="/sdk/langchain/">LangChain Support</a> | 
<a href="https://discord.gg/W8Kw6bsgXQ">Discord</a><br />
<a href="https://www.getzep.com">www.getzep.com</a>
</p>

<h2>Easily add relevant documents, chat history memory & rich user data to your LLM app's prompts.</h2>

### Vector Database with Hybrid Search
Populate your prompts with relevant documents and chat history. Rich metadata and JSONPath query filters offer a powerful hybrid search over texts.

### Batteries Included Embedding & Enrichment
- Automatically embed texts, or bring your own vectors. 
- [Enrichment of chat histories](/sdk/extractors) with summaries, named entities, token counts. Use these as search filters. 
- Associate your own metadata with documents & chat histories.

### Fast, low-latency APIs and stateless deployments
- Zep’s local embedding models and async enrichment ensure a snappy user experience. 
- Storing documents and history in Zep and not in memory enables stateless deployment.

&nbsp;

!!! info "Looking for a quick cloud deployment?"

    Looking for a fast way to get developing with Zep?

    [![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](/deployment/render)


<br />

<table>
<tr>
<td>

<h4>Document Vector Store</h4>

<p><span class="twemoji"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M7.75 6.5a1.25 1.25 0 1 0 0 2.5 1.25 1.25 0 0 0 0-2.5Z"></path><path d="M2.5 1h8.44a1.5 1.5 0 0 1 1.06.44l10.25 10.25a1.5 1.5 0 0 1 0 2.12l-8.44 8.44a1.5 1.5 0 0 1-2.12 0L1.44 12A1.497 1.497 0 0 1 1 10.94V2.5A1.5 1.5 0 0 1 2.5 1Zm0 1.5v8.44l10.25 10.25 8.44-8.44L10.94 2.5Z"></path></svg></span> <strong>1.9.0</strong></p>

<p>With Zep's document vector store, you can build collections of documents useful for grounding your prompts. </p>
<p>Run semantic search over a collection using either Zep's own SDKs, or with Langchain.</p>

<a href="/sdk/documents" class="md-button md-button--primary">
    Document API
</a>

</td>
<td>


<h4>Chat History Store</h4>

<p><span class="twemoji"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M7.75 6.5a1.25 1.25 0 1 0 0 2.5 1.25 1.25 0 0 0 0-2.5Z"></path><path d="M2.5 1h8.44a1.5 1.5 0 0 1 1.06.44l10.25 10.25a1.5 1.5 0 0 1 0 2.12l-8.44 8.44a1.5 1.5 0 0 1-2.12 0L1.44 12A1.497 1.497 0 0 1 1 10.94V2.5A1.5 1.5 0 0 1 2.5 1Zm0 1.5v8.44l10.25 10.25 8.44-8.44L10.94 2.5Z"></path></svg></span> <strong>1.8.1</strong>
&nbsp;
<span class="twemoji"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M7.75 6.5a1.25 1.25 0 1 0 0 2.5 1.25 1.25 0 0 0 0-2.5Z"></path><path d="M2.5 1h8.44a1.5 1.5 0 0 1 1.06.44l10.25 10.25a1.5 1.5 0 0 1 0 2.12l-8.44 8.44a1.5 1.5 0 0 1-2.12 0L1.44 12A1.497 1.497 0 0 1 1 10.94V2.5A1.5 1.5 0 0 1 2.5 1Zm0 1.5v8.44l10.25 10.25 8.44-8.44L10.94 2.5Z"></path></svg></span> <strong>1.9.0</strong></p>

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
- Using Zep's [Python and Javascript SDKs](/sdk)
- Developing with [Langchain and Zep](/sdk/langchain)
