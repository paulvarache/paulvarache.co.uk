# paulvarache.co.uk

Sources for my personal resume website https://paulvarache.co.uk

## Structure

This website is designed to fit inside a 14kB initial TCP window to be as fast as possible.

The main content is written in markdown to be protable to other platforms. Styles and icons are inlined at build time to prevent FOUC.

This website is designed to be easily printed or exported to a PDF file.

## Infrastructure

This is deployed to GCP using terraform. It uses a storage bucket, load balancer for HTTP and HTTP (With managed SSL certificate) and manages the DNS settings using the terraform provider for GANDI.net
