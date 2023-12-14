# Long-term Memory Persistence, Enrichment, and Search for Langchain Apps

Langchain Python and LangchainJS ship with `ZepMemory` and `ZepRetriever` classes. There are also `ZepVectorStore` classes available for both Python and typescript.

### Managing Chat History Memory

Zep's `ZepMemory` class can be used to provide long-term memory for your Langchain chat apps or agents. Zep will store the entire historical message stream, automatically summarize messages, enrich them with token counts, timestamps, metadata and more.

You can also provide your bot or agent with access to relevant messages in long-term storage by using Zep's built-in vector search.

### Building Retrieval Augmented Generation Apps (Q&A over Docs)

Zep's `ZepVectorStore` class can be used to store a collection of documents, metadata, and related embeddings. Retrieval Augmented Generation (RAG) apps can then use Zep's vector search to surface documents relevant to a prompt.

Zep will automatically embed the documents using low-latency local models, ensuring that your app is fast and responsive.

!!! note "Installing Zep"

    A Zep server install is required. You will also need to have the Zep Python SDK or Zep typescript SDK installed in order to use the Langchain `ZepMemory` and `ZepRetriever` classes.

    See the [Zep Quick Start Guide](../deployment/quickstart.md) for details.

    [![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](../deployment/render.md)

## Using Zep as a VectorStore and Document Retriever

See the examples in the inline [Document Vector Store documentation](documents.md) and the [LangChain.js documentation](https://js.langchain.com/docs/modules/data_connection/vectorstores/integrations/zep).

## Using Zep as a LangChain Memory Store


### Using Zep with the LangChain's Python LangChain Expression Language (LCEL)

The `ZepChatMessageHistory` class is used to provide long-term memory to LangChain apps built using the LangChain Expression Language (LCEL).

First we'll create a `ChatPromptTemplate` that includes a placeholder for the message history. Then we'll create a `ChatOpenAI` model and chain it to the prompt. 
```python 
from langchain.chat_models import ChatOpenAI
from langchain.memory.chat_message_histories import ZepChatMessageHistory
from langchain.prompts import ChatPromptTemplate, MessagesPlaceholder
from langchain_core.runnables.history import RunnableWithMessageHistory

prompt = ChatPromptTemplate.from_messages(
    [
        ("system", "You're an assistant who's good at {ability}"),
        MessagesPlaceholder(variable_name="history"),
        ("human", "{question}"),
    ]
)

chain = prompt | ChatOpenAI(model="gpt-3.5-turbo-1106", api_key=openai_api_key)

session_id = "your-users-unique-session-id"
```

Now we'll instantiate a `ZepChatMessageHistory`, provide it with a unique session ID, and the Zep server URL and API key (if required). We'll also create a `RunnableWithMessageHistory` that will provide the message history to the chain. We'll specify the input and history message keys. The input messages key is the key that the chain will use to access the input messages. The history messages key is the key that the chain will use to access the message history. Ensure that these match your prompt template.

```python
zep_chat_history = ZepChatMessageHistory(
    session_id=session_id,
    url="http://localhost:8000",
    # api_key=<your_api_key>,
)

chain_with_history = RunnableWithMessageHistory(
    chain,
    lambda session_id: zep_chat_history,
    input_messages_key="question",
    history_messages_key="history",
)

chain_with_history.invoke(
    {"ability": "math", "question": "What does cosine mean?"},
    config={"configurable": {"session_id": session_id}},
)
```
```text
AIMessage(content='Cosine is a trigonometric function that relates the angle of a right-angled triangle to the ratio of the length of the adjacent side to the length of the hypotenuse. In simpler terms, cosine is a way to calculate the ratio of the length of one side of a right-angled triangle to the length of the hypotenuse, given an angle. This function is widely used in mathematics, physics, engineering, and many other fields.')
```
Let's invoke the chain again, this time with a different question. We'll also print the message history to see what's been stored.

```python
chain_with_history.invoke(
    {"ability": "math", "question": "What's its inverse"},
    config={"configurable": {"session_id": session_id}},
)
```
The prior message context was used to answer the question. Zep [automatically generates summaries](extractors.md) of the message history. These will be added to the message history sent to LAngChain and can be used to provide long-term context to the chain.

```text
AIMessage(content='The inverse of the cosine function is called arccosine or inverse cosine. It is denoted as "arccos" or "cos^(-1)". The arccosine function takes a value between -1 and 1 as input and returns the angle in radians whose cosine is the input value. In other words, if y = arccos(x), then x = cos(y). The arccosine function is the inverse of the cosine function, allowing us to find the angle given the cosine value.')
```

### Using LangChain's ZepMemory class

!!! note "`ZepMemory` is used with the legacy LangChain Python API"
    
    The following examples illustrate using Zep as a Langchain memory store. In Python, the `ZepMemory` class is 
    used when building LangChain app's with the legacy API. See above for details on building apps with the 
    LangChain Expression Language (LCEL).

=== ":fontawesome-brands-python: Python"

    Using Zep as your Langchain app's long-term memory simple: initialize the `ZepMemory` with your Zep instance URL, API key, and your user's [session identifier](chat_history/sessions.md).

    ```python title="ZepMemory instantiation"
    from langchain.memory import ZepMemory

    # Set this to your Zep server URL
    ZEP_API_URL = "http://localhost:8000"
    ZEP_API_KEY = "<your JWT token>" # optional

    session_id = str(uuid4())  # This is a unique identifier for the user

    # Set up ZepMemory instance
    memory = ZepMemory(
        session_id=session_id,
        url=ZEP_API_URL,
        api_key=zep_api_key,
        memory_key="chat_history",
    )
    ```

=== ":simple-typescript: TypeScript"
    Using Zep as your Langchain app's long-term memory simple: initialize the ZepMemory with your Zep instance URL and your user's session identifier (see Zep Concepts) and then utilize it as the chat memory for a Langchain Conversation.

    ```typescript title="ZepMemory instantiation"
    import { ChatOpenAI } from "langchain/chat_models/openai";
    import { ConversationChain } from "langchain/chains";
    import { ZepMemory } from "langchain/memory/zep";
    import { v4 as uuidv4 } from 'uuid'

    // Set this to your Zep server URL
    const zepApiURL = "http://localhost:8000";
    const zepApiKey = "<your JWT token>"; // optional
    const sessionId = uuid4();  // This is a unique identifier for the user

    // Set up Zep Memory
    const memory = new ZepMemory({
        sessionId,
        baseURL: zepApiURL,
        apiKey: zepApiKey,
    });
    ```

Once you've created the `memory`, use it in your chain or with your agent.

=== ":fontawesome-brands-python: Python"

    ```python title="Running a chain with ZepMemory"

    llm = ChatOpenAI(model_name="gpt-3.5-turbo")
    chain = ConversationChain(llm=llm, verbose=True, memory=memory)
    chain.run(
        input="What is the book's relevance to the challenges facing contemporary society?"
    )
    ```
    ```text title="Output:"

    > Entering new AgentExecutor chain...
    AI: Parable of the Sower is a powerful exploration of the challenges facing contemporary society, such as environmental disasters, poverty, and violence. It examines how these issues can lead to the breakdown of society and how individuals can take action to create a better future. The novel also explores themes of faith, hope, and resilience in the face of adversity.

    > Finished chain.
    'Parable of the Sower is a powerful exploration of the challenges facing contemporary society, such as environmental disasters, poverty, and violence. It examines how these issues can lead to the breakdown of society and how individuals can take action to create a better future. The novel also explores themes of faith, hope, and resilience in the face of adversity.'
    ```

    Inspecting the `zep_chat_history`, we see that a summary was automatically created, and that the history has been enriched with token counts, UUIDs, and timestamps.

    ```python  title="Inspecting the Zep memory"
    def print_messages(messages):
        for m in messages:
            print(m.type, ":\n", m.dict())


    print(memory.chat_memory.zep_summary)
    print("\n")
    print_messages(memory.chat_memory.messages)

    The human inquires about Octavia Butler. The AI identifies her as an American science fiction author. The human then asks which books of hers were made into movies. The AI responds by mentioning the FX series Kindred, based on her novel of the same name. The human then asks about her contemporaries, and the AI lists Ursula K. Le Guin, Samuel R. Delany, and Joanna Russ.


    system :
     {'content': 'The human inquires about Octavia Butler. The AI identifies her as an American science fiction author. The human then asks which books of hers were made into movies. The AI responds by mentioning the FX series Kindred, based on her novel of the same name. The human then asks about her contemporaries, and the AI lists Ursula K. Le Guin, Samuel R. Delany, and Joanna Russ.', 'additional_kwargs': {}}
    human :
     {'content': 'What awards did she win?', 'additional_kwargs': {'uuid': '6b733f0b-6778-49ae-b3ec-4e077c039f31', 'created_at': '2023-07-09T19:23:16.611232Z', 'token_count': 8, 'metadata': {'system': {'entities': [], 'intent': 'The subject is inquiring about the awards that someone, whose identity is not specified, has won.'}}}, 'example': False}
    ai :
     {'content': 'Octavia Butler won the Hugo Award, the Nebula Award, and the MacArthur Fellowship.', 'additional_kwargs': {'uuid': '2f6d80c6-3c08-4fd4-8d4e-7bbee341ac90', 'created_at': '2023-07-09T19:23:16.618947Z', 'token_count': 21, 'metadata': {'system': {'entities': [{'Label': 'PERSON', 'Matches': [{'End': 14, 'Start': 0, 'Text': 'Octavia Butler'}], 'Name': 'Octavia Butler'}, {'Label': 'WORK_OF_ART', 'Matches': [{'End': 33, 'Start': 19, 'Text': 'the Hugo Award'}], 'Name': 'the Hugo Award'}, {'Label': 'EVENT', 'Matches': [{'End': 81, 'Start': 57, 'Text': 'the MacArthur Fellowship'}], 'Name': 'the MacArthur Fellowship'}], 'intent': 'The subject is stating that Octavia Butler received the Hugo Award, the Nebula Award, and the MacArthur Fellowship.'}}}, 'example': False}
    human :
     {'content': 'Which other women sci-fi writers might I want to read?', 'additional_kwargs': {'uuid': 'ccdcc901-ea39-4981-862f-6fe22ab9289b', 'created_at': '2023-07-09T19:23:16.62678Z', 'token_count': 14, 'metadata': {'system': {'entities': [], 'intent': 'The subject is seeking recommendations for additional women science fiction writers to explore.'}}}, 'example': False}
    <snip />
    ```

=== ":simple-typescript: TypeScript"

    ```typescript  title="Running a chain with ZepMemory"
    const chain = new ConversationChain({ llm: model, memory });
    const response = await chain.run(
        {
            input="What is the book's relevance to the challenges facing contemporary society?"
        },
    )
    ```
    ```text title="Output:" 
    > Entering new AgentExecutor chain...
    AI: Parable of the Sower is a powerful exploration of the challenges facing contemporary society, such as environmental disasters, poverty, and violence. It examines how these issues can lead to the breakdown of society and how individuals can take action to create a better future. The novel also explores themes of faith, hope, and resilience in the face of adversity.

    > Finished chain.
    'Parable of the Sower is a powerful exploration of the challenges facing contemporary society, such as environmental disasters, poverty, and violence. It examines how these issues can lead to the breakdown of society and how individuals can take action to create a better future. The novel also explores themes of faith, hope, and resilience in the face of adversity.'
    ```

    Inspecting the `ZepMemory`, we see that a summary was automatically created, and that the history has been enriched with token counts, UUIDs, and timestamps.

    ```typescript  title="Inspecting the Zep Memory"
    const memoryVariables = await zepMemory.loadMemoryVariables({});
    console.log(memoryVariables);

    ```
    ```text title="Output:"
    The AI provides a synopsis of Parable of the Sower, a science fiction novel by Octavia Butler, about a young woman navigating a dystopian future. The human asks for recommendations for other women sci-fi writers and the AI suggests Ursula K. Le Guin and Joanna Russ. The AI also notes that Butler was a highly acclaimed writer, having won the Hugo Award, the Nebula Award, and the MacArthur Fellowship.


    {'uuid': 'becfe5f4-d24c-4487-b572-2e836d7cedc8', 'created_at': '2023-05-10T23:28:10.380343Z', 'role': 'human', 'content': "WWhat is the book's relevance to the challenges facing contemporary society?", 'token_count': 16}
    {'uuid': '8ea4875c-bf42-4092-b3b8-308394963cb7', 'created_at': '2023-05-10T23:28:10.396994Z', 'role': 'ai', 'content': 'Parable of the Sower is a powerful exploration of the challenges facing contemporary society, such as environmental disasters, poverty, and violence. It examines how these issues can lead to the breakdown of society and how individuals can take action to create a better future. The novel also explores themes of faith, hope, and resilience in the face of adversity.', 'token_count': 0}
    ...
    {'uuid': '2d95ff94-b52d-49bd-ade4-5e1e553e8cac', 'created_at': '2023-05-10T23:28:02.704311Z', 'role': 'ai', 'content': 'Octavia Estelle Butler (June 22, 1947 – February 24, 2006) was an American science fiction author.', 'token_count': 31}
    ```

## Search Zep's message history from your Langchain app

Zep supports both vector search using a Langchain `Retriever` as well as via an instance of `ZepMemory`.

### Using a ZepMemory instance

If you don't need to provide a `Retriever` to your chain or agent, you can search the long-term message history for a session directly from an instance of `ZepMemory`.

=== ":fontawesome-brands-python: Python"
    ```python  title="Search for relevant historical messages"
    search_results = memory.chat_memory.search("who are some famous women sci-fi authors?")
    for r in search_results:
        if r.dist > 0.8:  # Only print results with similarity of 0.8 or higher
            print(r.message, r.dist)
    ```
    ```text title="Output:"
    {'uuid': 'ccdcc901-ea39-4981-862f-6fe22ab9289b', 'created_at': '2023-07-09T19:23:16.62678Z', 'role': 'human', 'content': 'Which other women sci-fi writers might I want to read?', 'metadata': {'system': {'entities': [], 'intent': 'The subject is seeking recommendations for additional women science fiction writers to explore.'}}, 'token_count': 14} 0.9119619869747062
    {'uuid': '7977099a-0c62-4c98-bfff-465bbab6c9c3', 'created_at': '2023-07-09T19:23:16.631721Z', 'role': 'ai', 'content': 'You might want to read Ursula K. Le Guin or Joanna Russ.', 'metadata': {'system': {'entities': [{'Label': 'ORG', 'Matches': [{'End': 40, 'Start': 23, 'Text': 'Ursula K. Le Guin'}], 'Name': 'Ursula K. Le Guin'}, {'Label': 'PERSON', 'Matches': [{'End': 55, 'Start': 44, 'Text': 'Joanna Russ'}], 'Name': 'Joanna Russ'}], 'intent': 'The subject is suggesting that the person should consider reading the works of Ursula K. Le Guin or Joanna Russ.'}}, 'token_count': 18} 0.8534346954749745
    {'uuid': 'b05e2eb5-c103-4973-9458-928726f08655', 'created_at': '2023-07-09T19:23:16.603098Z', 'role': 'ai', 'content': "Octavia Butler's contemporaries included Ursula K. Le Guin, Samuel R. Delany, and Joanna Russ.", 'metadata': {'system': {'entities': [{'Label': 'PERSON', 'Matches': [{'End': 16, 'Start': 0, 'Text': "Octavia Butler's"}], 'Name': "Octavia Butler's"}, {'Label': 'ORG', 'Matches': [{'End': 58, 'Start': 41, 'Text': 'Ursula K. Le Guin'}], 'Name': 'Ursula K. Le Guin'}, {'Label': 'PERSON', 'Matches': [{'End': 76, 'Start': 60, 'Text': 'Samuel R. Delany'}], 'Name': 'Samuel R. Delany'}, {'Label': 'PERSON', 'Matches': [{'End': 93, 'Start': 82, 'Text': 'Joanna Russ'}], 'Name': 'Joanna Russ'}], 'intent': "The subject is stating that Octavia Butler's contemporaries included Ursula K. Le Guin, Samuel R. Delany, and Joanna Russ."}}, 'token_count': 27} 0.8523831524040919
    ```

    Zep uses cosine distance for search ranking and the distance values are returned in the search results.

### Using the `ZepRetriever` class

`Retrievers` are a powerful tool for in-context learning. That is, providing LLM models with context from external sources. Long-term chat message history is a valuable source of context for bots or agents that interact with humans over multiple engagements, potentially over months or years.

You wouldn't ordinarily call the `Retriever` directly, but we've done so as a simple illustration as to how Langchain `documents` returned by the `ZepRetriever` are enriched with metadata from the Zep service. In particular, token countx are useful when constructing prompts.

=== ":fontawesome-brands-python: Python"
    
    ```python title="Use the ZepRetriever to search for relevant historical messages"

    from langchain.retrievers import ZepRetriever

    zep_retriever = ZepRetriever(
        # Ensure that you provide the session_id when instantiating the Retriever
        session_id=session_id,
        url=ZEP_API_URL,
        top_k=5,
    )

    await zep_retriever.aget_relevant_documents("Who wrote Parable of the Sower?")
    ```
    ```text title="Output:"
    [Document(page_content='Parable of the Sower is a science fiction novel by Octavia Butler, published in 1993. It follows the story of Lauren Olamina, a young woman living in a dystopian future where society has collapsed due to environmental disasters, poverty, and violence.', metadata={'source': 'd2d364f3-d2cc-46be-9e04-b41333f80514', 'score': 0.8897276230611862, 'role': 'ai', 'token_count': 25, 'created_at': '2023-05-11T16:29:35.086398Z'}),
    Document(page_content="Write a short synopsis of Butler's book, Parable of the Sower. What is it about?", metadata={'source': '2baee3f7-cfc8-4cce-9e9f-6e448249244b', 'score': 0.8858500630231024, 'role': 'human', 'token_count': 20, 'created_at': '2023-05-11T16:29:35.083828Z'}),
    Document(page_content='Who was Octavia Butler?', metadata={'source': '73fb8cb3-da77-4f99-ac2b-939d5019e5b8', 'score': 0.7759728831215438, 'role': 'human', 'token_count': 0, 'created_at': '2023-05-11T16:29:35.014421Z'}),
    Document(page_content="Octavia Butler's contemporaries included Ursula K. Le Guin, Samuel R. Delany, and Joanna Russ.", metadata={'source': 'aff1b45d-1e14-427d-a5a2-2b5a9dade294', 'score': 0.760286350496536, 'role': 'ai', 'token_count': 17, 'created_at': '2023-05-11T16:29:35.052896Z'}),
    Document(page_content='You might want to read Ursula K. Le Guin or Joanna Russ.', metadata={'source': '0dd8cde5-860e-4d8b-975f-50f55028177d', 'score': 0.7595191167162665, 'role': 'ai', 'token_count': 15, 'created_at': '2023-05-11T16:29:35.080817Z'})]
    ```

=== ":simple-typescript: TypeScript"

    ```typescript title="Use the ZepRetriever to search for relevant historical messages"

    import { ZepRetriever } from "langchain/retrievers/zep";

    export const run = async () => {
        // Ensure that you provide the sessionId when instantiating the Retriever
        const retriever = new ZepRetriever({ sessionId, ZEP_API_URL });

        const query = "Who wrote Parable of the Sower?");
        const docs = await retriever.getRelevantDocuments(query);

        console.log(docs);
    };
    ```

    ```text title="Output:"
    [Document(page_content='Parable of the Sower is a science fiction novel by Octavia Butler, published in 1993. It follows the story of Lauren Olamina, a young woman living in a dystopian future where society has collapsed due to environmental disasters, poverty, and violence.', metadata={'source': 'd2d364f3-d2cc-46be-9e04-b41333f80514', 'score': 0.8897276230611862, 'role': 'ai', 'token_count': 25, 'created_at': '2023-05-11T16:29:35.086398Z'}),
    Document(page_content="Write a short synopsis of Butler's book, Parable of the Sower. What is it about?", metadata={'source': '2baee3f7-cfc8-4cce-9e9f-6e448249244b', 'score': 0.8858500630231024, 'role': 'human', 'token_count': 20, 'created_at': '2023-05-11T16:29:35.083828Z'}),
    Document(page_content='Who was Octavia Butler?', metadata={'source': '73fb8cb3-da77-4f99-ac2b-939d5019e5b8', 'score': 0.7759728831215438, 'role': 'human', 'token_count': 0, 'created_at': '2023-05-11T16:29:35.014421Z'}),
    Document(page_content="Octavia Butler's contemporaries included Ursula K. Le Guin, Samuel R. Delany, and Joanna Russ.", metadata={'source': 'aff1b45d-1e14-427d-a5a2-2b5a9dade294', 'score': 0.760286350496536, 'role': 'ai', 'token_count': 17, 'created_at': '2023-05-11T16:29:35.052896Z'}),
    Document(page_content='You might want to read Ursula K. Le Guin or Joanna Russ.', metadata={'source': '0dd8cde5-860e-4d8b-975f-50f55028177d', 'score': 0.7595191167162665, 'role': 'ai', 'token_count': 15, 'created_at': '2023-05-11T16:29:35.080817Z'})]
    ```
````
