# Deploying to Render

!!! Warning "Configure Server Authentication"

    Ensure that you secure your Zep server by [configuring authentication](auth.md) after deploying.
    Failing to do so will leave your server open to the public.

!!! question "Web UI disabled for Render deploys"

    For security reasons, Zep deployments to Render default to disabling the web UI. The Zep web UI is not secured by 
    JWT authentication and should only [be enabled](config.md) if you deploy Zep as a [private service](https://render.com/docs/private-services).

#### 1. Click on the button below to deploy to Render using the Zep blueprint

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy?repo=https://github.com/getzep/zep){:target="\_blank"}

#### 2. Configure your deploy

Enter a **Blueprint Name** (we suggest `zep`) and provide your OpenAI API key, which will be stored as a secret.

Click `Apply`.

!!! note "OpenAI API Key Required"

    An OpenAI API key is required to run Zep. Please ensure that you enter it in the step above.

#### 3. Wait for your deploy to complete

This takes a few minutes.

#### 4. Configure authentication

Follow the [server authentication instructions here](auth.md). **Do not skip this step.** Failing to do so will leave your server open to the public.

#### 5. Point your client SDK to your new Zep server

Retrieve your Zep server URL from the Render web console.

`https://zepXXXXX.onrender.com`

=== "Python"

    ```python
    from zep_python import ZepClient

    zep = ZepClient("https://zepXXXXX.onrender.com", api_key) # Replace with Zep API URL
    ```

=== "TypeScript/JS"

    ```javascript
    import { ZepClient } from "@getzep/zep-js";

    const zep = new ZepClient.init("https://zepXXXXX.onrender.com", apiKey); // Replace with Zep API URL
    ```

Next steps: [Using Zep's Python and TypeScript/JS SDKs](../sdk/index.md)

#### What this blueprint does

Three services are deployed:

- `zep` - the Zep server
- `nlp` - a back-end private service responsible for several NLP tasks
- `zep-postgres` - a Postgres database

The blueprint defaults to the standard tier. You can change these settings in the Render web console.

!!! note "This blueprint is not optimized for production"

    This blueprint by default deploys in the smallest possible configuration.

    Depending on the embedding model you use, you may need to increase the memory and CPU allocated to the `nlp` service.

    Please see [the production deployment guide](production.md) for more information.

### Next Steps

- Setting up [authentication](auth.md)
- Developing with [Zep SDKs](../sdk/index.md)
- Learn about [Extractors](../sdk/extractors.md)
- Setting Zep [Configuration options](config.md)
- Learn about [deploying to production](production.md)
