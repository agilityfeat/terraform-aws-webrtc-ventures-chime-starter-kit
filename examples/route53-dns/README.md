# Using Route53 Hostedzone in the same Account
This setup shows you an example of how to configure the **WebRTC Ventures Chime Starter Kit** high availability mode using a **Rout53 Hostedzone** created in the same account you will be provisioning this application.

## Requirements
1. Access to Route53 with permissions to create and modify DNS records.
2. A created Hostedzone based on your root domain or your subdomain.
3. The default value of the variable `use_route53_hostedzone_for_acm` must be set to true and the corresponding Route53 Hostedzone details entered in the variable named `route53_hosted`. 
4. Set the application domain in the variable named: `app_domain`. This values will be used to create your ACM certificate and a CNAME record in the hosted zone for the application.
5. Set the variable `acm_cert_arn` value to `null` since for this setup the certificate will be created by Terraform and automatically passed to the Loadbalancer.

## Steps
Ensure you have read all the variable descriptions in the [`variable.tf`](./variables.tf) and supply corresponding default variables as shown for your AWS account. You can opt to use a variables.tfvars for supplying your values as described [here](https://developer.hashicorp.com/terraform/language/values/variables) or just use the `variable.tf` file and supply the values as the variables defaults.

Once you have confirmed your variables are set correctly, navigate to the root folder of your setup where you have the `main.tf` and the `backend.tf` files then:
1. Setup your backend, you can use local backend as it is the default in this example.
2. Validate your configuration by running:
   ```bash
   terraform validate
   ```
3. Initialize terraform module(s) by running:
   ```bash
   terraform init --upgrade
   ```
4. Plan and accept changes to provision your app by running the following command and entering `yes` in the prompt after reviewing the planned resources.
   ```bash
   terraform apply
   ```

5. If you prefer to plan first before running apply you can use:
   ```bash
   terraform plan
   ```

   followed by:

   ```bash
   terraform apply
   ```
Once terraform provisions the infrastructure you will get the `application_domain` output value which you can open on your browser to access the application.

## Additional info:
You will get similar output to this from Terraform after successfully creating all the resources:
```bash
Outputs:

application_domain = "video.chimestarter.example.com"

```
Then you can reach the application on: `https://video.chimestarter.example.com`.

For further help reach out at: [info@webrtc.ventures](mailto:info@webrtc.ventures)