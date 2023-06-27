# OpenAI Configuration

## OpenAI API Key
An OpenAI API Key is required to run Zep. Your OpenAI API key should not be stored in the `config.yaml` file. 
Instead, it should be stored in the `ZEP_OPENAI_API_KEY` environment variable.

## LLM Model
You may configure which LLM model to use by setting the [`llm.model` config key or `ZEP_LLM_MODEL`](/deployment/config) 
environment variable.

## OpenAI OrgID
You may configure which OpenAI OrgID to use by setting the [`llm.openai_org_id` config key or `ZEP_LLM_OPENAI_ORG_ID`](/deployment/config)

## Azure OpenAI Endpoint
!!! note "Experimental"
    This feature is experimental. Please let us know if it works for you.

Azure OpenAI API support can be enabled by setting the 
[`llm.azure_openai_endpoint` config key or `ZEP_LLM_AZURE_OPENAI_ENDPOINT`](/deployment/config) environment variable.

Your Azure OpenAI API key should be set as described above.
