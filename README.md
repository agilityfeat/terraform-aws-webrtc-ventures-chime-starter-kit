# WebRTC Ventures Chime Starter Kit HA-Setup (Terraform)
This setup helps you configure and provision the [**WebRTC Ventures Chime Starter Kit**](https://aws.amazon.com/marketplace/pp/prodview-5glqwwdijegwe) high availability setup using AWS Infrastructure as Code with Terraform.

> Additional documentation:
> 1. Getting the product AMI ID guide [ObtainAMIID.pdf](https://webrtc-ventures-mkt.s3.amazonaws.com/ObtainAMIID.pdf)
> <br/>

## Prerequisites
The following are the prerequisites needed for this setup:
1. Install Terraform by following the [instructions here](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).
2. Install AWS CLI as [guided here](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).
3. Configure Terraform for your AWS account by following [these instructions](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build). Note: you may also use the AWS CLI to setup your credentials by following the [steps here](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html).

## Setup
To provision the application you have two options as documented here:
1. [Using an external DNS not hosted on Route53](https://github.com/agilityfeat/terraform-aws-webrtc-ventures-chime-starter-kit/blob/main/examples/external-dns/README.md)
2. [Using AWS Route53 DNS Hostedzone](https://github.com/agilityfeat/terraform-aws-webrtc-ventures-chime-starter-kit/blob/main/examples/external-dns/README.md)

## Additional information
1. If you manage your DNS on AWS Route53, then you can take advantage of the ACM module by setting `use_route53_hostedzone` variable to `true`, supplying the route53 hosted zone details under the `route53_hosted` variable and the hostname under `app_domain`. With this option you **MUST** ensure the `acm_cert_arn` is set to `null`.
2. If you manage your DNS in a different DNS provider, you can create an ACM certificate following [this guide](https://docs.aws.amazon.com/acm/latest/userguide/gs-acm-request-public.html) and then copy the certificate ARN and put it under `acm_cert_arn` variable. With this option you must set `use_route53_hostedzone` variable to `false` and `route53_hosted` variable to null for each key within the object.

Provisioning this module successfuly will:
1. Create an Auto Scaling Group with scaling alarms for CPU usage and optional ones for Network (In and Out) metrics.
2. An Application LoadBalancer that will ditribute traffic to your instances.
3. (Optional) If Route53 hosted zone was use, an output of the domain on which you will access your application under `application_domain` output variable.
4. (Optional) If ACM certificate for TLS was manually created, the output will give you the `lb_dns_value` with which you will create a CNAME record in your DNS management console as its value:

    For example if my domain is `example.com` and I want my application to be accessed at `meet.example.com`; then I will create a CNAME record with `meet.example.com` as the record name and `lb_dns_value` output value as its CNAME value.

With your DNS correctly updated you can reach your application on the configured domain.

## Conclusions
Incase you face any difficulty do not hesitate to contact our team at [info@webrtc.ventures](mailto:info@webrtc.ventures). 
We will take you through the setup process step by step and esure your product is ready and accessible.
> Single instance setup is available but it is more technical. For this option kindly reach us via [info@webrtc.ventures](mailto:info@webrtc.ventures)