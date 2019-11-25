# paulvarache.co.uk

Sources for my personal resume website https://paulvarache.co.uk

## Infrastructure

This is deployed to GCP using terraform. It uses a storage bucket, load balancer for HTTP and HTTP (With managed SSL certificate) and manages the DNS settings using the terraform provider for GANDI.net
