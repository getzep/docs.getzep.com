# LLM Configuration

Zep uses LLM models for summarization, intent analysis tasks, and embedding texts, and currently supports 
the OpenAI and Anthropic LLM services, local LLMs with OpenAI compatible APIs, and local embeddings services.

## OpenAI Service
### OpenAI API Key
Your OpenAI API key should not be stored in the `config.yaml` file. 
Instead, it should be stored in the `ZEP_OPENAI_API_KEY` environment variable.

### LLM Model
You may configure which LLM model to use by setting the [`llm.model` config key or `ZEP_LLM_MODEL`](config.md) 
environment variable.

### OpenAI OrgID
You may configure which OpenAI OrgID to use by setting the [`llm.openai_org_id` config key or `ZEP_LLM_OPENAI_ORG_ID`](config.md)

### Azure OpenAI Endpoint
!!! note "Experimental"
    This feature is experimental. Please let us know if it works for you.

Azure OpenAI API support can be enabled by setting the 
[`llm.azure_openai_endpoint` config key or `ZEP_LLM_AZURE_OPENAI_ENDPOINT`](config.md) environment variable.

Your Azure OpenAI API key should be set as described above.

## Anthropic Service

!!! info "Anthropic does not support embeddings"
  
    If configuring Zep to use the Anthropic LLM service, you must configure Zep to use the local embeddings service.

To configure Zep to use the Anthropic LLM service:

1. Set the [`ZEP_LLM_ANTHROPIC_API_KEY`](./config.md) environment variable to your Anthropic API key.
2. Set the [`llm.service` config key or `ZEP_LLM_SERVICE`](./config.md) environment variable to `anthropic`.
3. Set the [`llm.model` config key or `ZEP_LLM_MODEL`](./config.md) environment variable to a supported Anthropic model.

## Custom OpenAI-compatible API Endpoint 

!!! warning "Zep's prompts are not optimized for all LLMs"
  
    Your mileage may vary on how well Zep's default summarization and entity extraction prompts work with LLMs other than those explicitly supported. 

    Zep can can be configured with custom prompts for summarization. See [Custom Prompts](prompts.md) for more information.


The OpenAI API Endpoint URL can be customized to allow Zep to connect to alternative OpenAI-compatible APIs.