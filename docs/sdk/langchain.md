# Zep and Langchain

!!! note "Not yet merged"

    Zep integration has not yet been merged to Langchain's master branch.

Langchain Python ships with `ZepChatMessageHistory` and `ZepRetriever` classes.

Zep can be used to provide long-term memory for your Langchain chat apps or agents. Zep will store the entire historical message stream, automatically summarize messages, enrich them with token counts, timestamps, metadata and more.

You can also provide your bot or agent with access to relevant messages in long-term storage by using Zep's built-in vector search.

!!! note "Installing the Zep Python SDK"

    You will need to have the Zep Python SDK installed in order to use the Langchain `ZepChatMessageHistory` and `ZepRetriever` classes.

    See the [Zep Quick Start Guide](/deployment/quickstart) for details.

## Using Zep as the Memory Store for your Langchain app

Using Zep as your Langchain app's long-term memory simple: initialize the `ZepChatMessageHistory` with your Zep instance URL and your user's session identifier (see [Zep Concepts](/about/concepts)) and then utilize it as the `chat_memory` for a Langchain `ConversationBufferMemory`.

```python
from langchain.memory.chat_message_histories import ZepChatMessageHistory
from langchain.memory import ConversationBufferMemory

# Set this to your Zep server URL
ZEP_API_URL = "http://localhost:8000"

session_id = str(uuid4())  # This is a unique identifier for the user

# Set up Zep Chat History
zep_chat_history = ZepChatMessageHistory(
    session_id=session_id,
    url=ZEP_API_URL,
)

# Use a standard ConversationBufferMemory to encapsulate the Zep chat history
memory = ConversationBufferMemory(
    memory_key="chat_history", chat_memory=zep_chat_history
)
```

Once you've created the `memory`, use it in your chain or with your agent.

```python
agent_chain.run(
    input="What is the book's relevance to the challenges facing contemporary society?"
)
```

```text
> Entering new AgentExecutor chain...
AI: Parable of the Sower is a powerful exploration of the challenges facing contemporary society, such as environmental disasters, poverty, and violence. It examines how these issues can lead to the breakdown of society and how individuals can take action to create a better future. The novel also explores themes of faith, hope, and resilience in the face of adversity.

> Finished chain.
'Parable of the Sower is a powerful exploration of the challenges facing contemporary society, such as environmental disasters, poverty, and violence. It examines how these issues can lead to the breakdown of society and how individuals can take action to create a better future. The novel also explores themes of faith, hope, and resilience in the face of adversity.'
```

Inspecting the `zep_chat_history`, we see that a summary was automatically created, and that the history has been enriched with token counts, UUIDs, and timestamps.

```python
def print_messages(messages):
    for m in messages:
        print(m.to_dict())


print(zep_chat_history.zep_summary)
print("\n")
print_messages(zep_chat_history.zep_messages)
```

```text
The AI provides a synopsis of Parable of the Sower, a science fiction novel by Octavia Butler, about a young woman navigating a dystopian future. The human asks for recommendations for other women sci-fi writers and the AI suggests Ursula K. Le Guin and Joanna Russ. The AI also notes that Butler was a highly acclaimed writer, having won the Hugo Award, the Nebula Award, and the MacArthur Fellowship.


{'uuid': 'becfe5f4-d24c-4487-b572-2e836d7cedc8', 'created_at': '2023-05-10T23:28:10.380343Z', 'role': 'human', 'content': "WWhat is the book's relevance to the challenges facing contemporary society?", 'token_count': 16}
{'uuid': '8ea4875c-bf42-4092-b3b8-308394963cb7', 'created_at': '2023-05-10T23:28:10.396994Z', 'role': 'ai', 'content': 'Parable of the Sower is a powerful exploration of the challenges facing contemporary society, such as environmental disasters, poverty, and violence. It examines how these issues can lead to the breakdown of society and how individuals can take action to create a better future. The novel also explores themes of faith, hope, and resilience in the face of adversity.', 'token_count': 0}
...
{'uuid': '2d95ff94-b52d-49bd-ade4-5e1e553e8cac', 'created_at': '2023-05-10T23:28:02.704311Z', 'role': 'ai', 'content': 'Octavia Estelle Butler (June 22, 1947 – February 24, 2006) was an American science fiction author.', 'token_count': 31}
```

## Search Zep's message history from your Langchain app

Zep supports both vector search using a Langchain `Retriever` as well as via an instance of `ZepChatMessageHistory`.

### Using a ZepChatMessageHistory instance

If you don't need to provide a `Retriever` to your chain or agent, you can search the long-term message history for a session directly from an instance of `ZepChatMessageHistory`.

```python
search_results = zep_chat_history.search("who are some famous women sci-fi authors?")
for r in search_results:
    print(r.message, r.dist)
```

```text
{'uuid': '622b41cb-5821-45d2-8026-67163b826a73', 'created_at': '2023-05-10T23:28:02.78107Z', 'role': 'human', 'content': 'Which other women sci-fi writers might I want to read?', 'token_count': 0} 0.9118298949424545
{'uuid': 'e957973c-d2e6-4e61-b760-0d8138471331', 'created_at': '2023-05-10T23:28:02.784666Z', 'role': 'ai', 'content': 'You might want to read Ursula K. Le Guin or Joanna Russ.', 'token_count': 0} 0.8533024416448016
{'uuid': 'c2542d2e-2110-45e9-ace2-94923080ab70', 'created_at': '2023-05-10T23:28:02.755448Z', 'role': 'ai', 'content': "Octavia Butler's contemporaries included Ursula K. Le Guin, Samuel R. Delany, and Joanna Russ.", 'token_count': 0} 0.852352466457884
{'uuid': '85e6b9b1-8f5e-4503-8549-18a148f255e5', 'created_at': '2023-05-10T23:28:02.689483Z', 'role': 'human', 'content': 'Who was Octavia Butler?', 'token_count': 0} 0.823569608637507
```

Zep uses cosine distance for search ranking and the distance values are returned in the search results.

### Using the `ZepRetriever` class

`Retrievers` are a powerful tool for in-context learning. That is, providing LLM models with context from external sources. Long-term chat message history is a valuable source of context for bots or agents that interact with humans over multiple engagements, potentially over months or years.

The `ZepRetriever` class is able to take advantage of `zep-python`'s `async` API, as demonstrated below.

```python

from langchain.retrievers import ZepRetriever

zep_retriever = ZepRetriever(
    # Ensure that you provide the session_id when instantiating the Retriever
    session_id=session_id,
    url=ZEP_API_URL,
    top_k=5,
)

await zep_retriever.aget_relevant_documents("Who wrote Parable of the Sower?")
```

```text
[Document(page_content='Parable of the Sower is a science fiction novel by Octavia Butler, published in 1993. It follows the story of Lauren Olamina, a young woman living in a dystopian future where society has collapsed due to environmental disasters, poverty, and violence.', metadata={'source': 'd2d364f3-d2cc-46be-9e04-b41333f80514', 'score': 0.8897276230611862, 'role': 'ai', 'token_count': 25, 'created_at': '2023-05-11T16:29:35.086398Z'}),
 Document(page_content="Write a short synopsis of Butler's book, Parable of the Sower. What is it about?", metadata={'source': '2baee3f7-cfc8-4cce-9e9f-6e448249244b', 'score': 0.8858500630231024, 'role': 'human', 'token_count': 20, 'created_at': '2023-05-11T16:29:35.083828Z'}),
 Document(page_content='Who was Octavia Butler?', metadata={'source': '73fb8cb3-da77-4f99-ac2b-939d5019e5b8', 'score': 0.7759728831215438, 'role': 'human', 'token_count': 0, 'created_at': '2023-05-11T16:29:35.014421Z'}),
 Document(page_content="Octavia Butler's contemporaries included Ursula K. Le Guin, Samuel R. Delany, and Joanna Russ.", metadata={'source': 'aff1b45d-1e14-427d-a5a2-2b5a9dade294', 'score': 0.760286350496536, 'role': 'ai', 'token_count': 17, 'created_at': '2023-05-11T16:29:35.052896Z'}),
 Document(page_content='You might want to read Ursula K. Le Guin or Joanna Russ.', metadata={'source': '0dd8cde5-860e-4d8b-975f-50f55028177d', 'score': 0.7595191167162665, 'role': 'ai', 'token_count': 15, 'created_at': '2023-05-11T16:29:35.080817Z'})]
```

You wouldn't ordinarily call the `Retriever` directly, but we've done so as a simple illustration as to how Langchain `documents` returned by the `ZepRetriever` are enriched with metadata from the Zep service. In particular, token countx are useful when constructing prompts.
