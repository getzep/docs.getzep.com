# Custom Prompts

Custom prompts can be configured if you're using LLMs other than the default Anthropic and OpenAI models, or would like to modify the how Zep's extractor functionality works. 

The prompts are configured in the `custom_prompts` section of the `config.yaml` file. They may also be configured via environment variables. See [Configuration](config.md) for more information.

Currently only the summarizer prompt may be customized.

```yaml
custom_prompts:
  summarizer_prompts:
    # Anthropic Guidelines:
    # - Use XML-style tags like <current_summary> as element identifiers.
    # - Include {{.PrevSummary}} and {{.MessagesJoined}} as template variables.
    # - Clearly explain model instructions, e.g., "Review content inside <current_summary></current_summary> tags".
    # - Provide a clear example within the prompt.
    #
    # Example format:
    # anthropic: |
    #   <YOUR INSTRUCTIONS HERE>
    #   <example>
    #     <PROVIDE AN EXAMPLE>
    #   </example>
    #   <current_summary>{{.PrevSummary}}</current_summary>
    #   <new_lines>{{.MessagesJoined}}</new_lines>
    #   Response without preamble.
    #
    # If left empty, the default Anthropic summary prompt from zep/pkg/extractors/prompts.go will be used.
    anthropic: |

    # OpenAI summarizer prompt configuration.
    # Guidelines:
    # - Include {{.PrevSummary}} and {{.MessagesJoined}} as template variables.
    # - Provide a clear example within the prompt.
    #
    # Example format:
    # openai: |
    #   <YOUR INSTRUCTIONS HERE>
    #   Example:
    #     <PROVIDE AN EXAMPLE>
    #   Current summary: {{.PrevSummary}}
    #   New lines of conversation: {{.MessagesJoined}}
    #   New summary:`
    #
    # If left empty, the default OpenAI summary prompt from zep/pkg/extractors/prompts.go will be used.
    openai: |
```