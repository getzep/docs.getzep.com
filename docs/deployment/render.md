# Deploying to Render

!!! Warning "Not for Production Use"

    This deployment method should be used for development and testing purposes only. The deployment is not secure and set up for high availability. **Do not use this for production.**

#### 1. Click on the button below to deploy to Render using the Zep blueprint

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy?repo=https://github.com/getzep/zep){:target="_blank"}

#### 2. Configure your deploy

Enter a **Blueprint Name** (we suggest `zep`) and provide your OpenAI API key, which will be stored as a secret.

Click `Apply`.

!!! note "OpenAI API Key Required"

    An OpenAI API key is required to run Zep. Please ensure that you enter it in the step above. 

#### 3. Wait for your deploy to complete

This takes a few minutes.

#### 4. Point your client SDK to your new Zep server

Retrieve your Zep server URL from the Render web console.

`https://zepXXXXX.onrender.com`

=== "Python"

    ```python
    from zep_python import ZepClient

    zep = ZepClient("https://zepXXXXX.onrender.com") # Replace with Zep API URL
    ```

=== "Javascript"

    ```javascript
    import { ZepClient } from "zep-js";

    const zep = new ZepClient("https://zepXXXXX.onrender.com"); // Replace with Zep API URL
    ```

Next steps: [Using Zep's Python and Javascript SDKs](/sdk)

#### What this blueprint does

Two services are deployed:

- `zep` - the Zep server
- `zep-postgres` - a Postgres database

The blueprint defaults to the free tier. You can change these settings in the Render web console.