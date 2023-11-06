# Securing Zep

This document describes how to secure Zep in production environments. Given the varying platforms and configurations that Zep can be deployed to, we will describe the general principles of securing Zep. The responsibility for implementing these principles in your deployment environment is left to you.

!!! warning "Zep is not secure out of the box"
    Zep is not secure out of the box. You must configure authentication to secure your deployment. See [Configuring Authentication](auth.md) for details.

    Depending on your deployment environment, you may also need to configure TLS/SSL termination, disable Zep's WebUI, and secure Zep's microservices and database.

## Deploying with Docker Compose

Zep's default Docker Compose deployment is not secure out of the box. You must secure it if you intend to deploy to a production environment.

### Authentication

You must configure authentication to secure your Zep deployment. See [Configuring Authentication](auth.md) for details.

### Disable the Zep WebUI

The Zep WebUI is not secured by JWT security. It is enabled by default on Dokcer Compose deployments and must be disabled for production use. To disable or enable the Zep WebUI, you can set the `ZEP_SERVER_WEB_ENABLED` environment variable or modify your `config.yaml` file. For more details, please refer to [Zep's Web Interface](webui.md).

### Firewall

Zep's docker compose deployment is configured to only accept traffic to the Zep API service. No action is required to enable this. However, you should ensure that you're not relying solely on the Docker service to secure your deployment. Ensure that your deployment environment is configured to only allow traffic to the Zep API service.

!!! note "Earlier versions of Zep's Docker Compose deployment"
    Earlier versions of Zep's Docker Compose deployment were designed for development purposes only and exposed Postgres and Zep's microservices. If you're upgrading from an earlier version of Zep, you should ensure that these are not exposed to the public internet. 
    
    You can modify your `docker-compose.yaml` file to disable the exposed ports. You should also ensure that you're not relying solely on the Docker service to secure your deployment. Use your deployment environment's firewall to ensure that you're only allowing traffic to the Zep API service.

### TLS/SSL Termination
You must configure TLS/SSL termination to secure your Zep deployment. Failing to do so will result in your connections to Zep being sent in plaintext, including your JWT API Key. Please see your provider's documentation for details.

## Deploying with Render.com

Out of the box, Zep can be deployed to Render.com with minimal configuration. However, you must configure authentication to secure your deployment. 

### Authentication

You must configure authentication to secure your Zep deployment. See [Configuring Authentication](auth.md) for details.

### Firewall

The Zep deployment on Render.com is configured to only accept traffic to the Zep API service. No action is required to enable this.

### TLS/SSL Termination
Zep uses Render's built-in TLS/SSL termination to ensure that all traffic to and from Zep is encrypted. No action is required on your part to enable this.

## Custom Deployments

Zep can be deployed to a variety of platforms, including Kubernetes, AWS, GCP, and Azure. The same principles described above apply to these deployments. You must configure authentication, TLS/SSL termination, disable the WebUI, and use firewall rules to secure your deployment.