# Vector Search
Zep allows developers to search the long-term memory store for relevant historical conversations.

!!! note "Embedding short texts"
    Contextual search over chat histories is challenging: chat messages are typically short and can lack "information". When combined with high-dimensional embedding vectors, short texts can create very sparse vectors. 
    
    This vector sparsity results in many vectors appearing close to each other in the vectorspace. This may in turn result in many false positives when searching for relevant messages. 

    We're thinking of strategies to address this problem, including hybrid search and enriching messages with metadata.

### Search Ranking and Limits
Zep returns all messages up to a default limit, which can overridden by passing a `limit` querystring argument to the search API. Given the sparsity issue discussed above, we suggest only using the top 2-3 messages in your prompts. Alternatively, analyze your search results and use a distance threshold to filter out irrelevant messages.

### Embeddings
By default, Zep uses OpenAI's 1536-wide AdaV2 embeddings and cosine distance for search ranking.