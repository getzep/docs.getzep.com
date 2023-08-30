# Configuring Authentication

Zep supports JWT authentication. Carefully follow the instructions below to enable it.

## Using the `zepcli` command line utility

### 1. Download the `zepcli` CLI tool

Download the `zepcli` CLI tool from the [zepcli releases page](https://github.com/getzep/zepcli/releases). 
Ensure that you select the right binary for your platform. 

!!! note

        The `zepcli` CLI tool is intended to be used from the command line. If you are using MacOS, you cannot
        run it from the Finder. You must run it from the Terminal.


### 1. Generate a secret and the JWT token
A cryptographically secure secret is required to sign Zep's JWT tokens. This secret should be kept safe as access to it may allow access to the Zep API.

On Linux or MacOS
```sh
./zepcli -i
```

On Windows
```sh
zepcli.exe -i
```

Carefully copy the secret and JWT token to a safe place. You will need them in the next step.

### 2. Configure Auth environment variables
Set the following environment variables in your Zep server environment:

```sh
ZEP_AUTH_REQUIRED=true
ZEP_AUTH_SECRET=<the secret you generated above>
```

For development purposes, you can do this in your
`.env` file. 

For production, you should set these according to best practices for managing secrets in your deployment environment. 
For example, Render.com has a [environment and secrets management feature](https://render.com/docs/configure-environment-variables) that can be used to set these variables.

### 3. Configure your client SDK to use JWT authentication

You will need to configure your client SDK to use the JWT token you created in Step 1. See the [SDK docs](../sdk/index.md) for details.

!!! Warning "Implement TLS Encryption"

        JWT tokens are not encrypted. Your Zep web service should run behind a TLS terminator such as a load balancer. 
        Many cloud providers offer TLS termination on their load balancers. You should check your cloud providers
        documentation for details on how to configure this.

        Keep your safe. Anyone with access to your JWT token will be able to access your Zep server. 


## Using another tool

If you'd prefer to use another tool to generate your secret and JWT token, you can do so. Below is an example of how to do so using Python and OpenSSL. Please see the instructions above for correctly setting the Zep environment variables.

### 1. Generate a secret
A cryptographically secure secret is required to sign Zep's JWT tokens. This secret should be kept safe as access to it may allow access to the Zep API.

Using OpenSSL (concatenate to remove newlines)
```sh
openssl rand -base64 64
```

or using Python
```python
import secrets
print(secrets.token_urlsafe(64))
```

### 2. Generating a JWT token
Most languages have an ecosystem library that supports generation of JWT tokens. Note that Zep uses the `HS256` JWT signing algorithm and that no Claims are required. 
The token must be signed with the same secret that you set in the `ZEP_AUTH_SECRET` environment variable.




