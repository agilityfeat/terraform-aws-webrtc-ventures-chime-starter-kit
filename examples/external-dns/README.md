# Using an external DNS provider
This setup shows you an example of how to configure the [**WebRTC Ventures Chime Starter Kit**](https://aws.amazon.com/marketplace/pp/prodview-5glqwwdijegwe) high availability mode using an **external DNS provider**.

## Requirements
1. A registered domain.
2. Access to manage records in the domain records management console.
3. You must set the default value of the variable `use_route53_hostedzone_for_acm` to `false`.

## Steps
Read the variable descriptions in the [`variable.tf`](./variables.tf) and supply corresponding variables as shown for your AWS account. 

Once you have configured your variables correclty navigate to the root folder of your setup
1. Setup your backend, you can use local backend as it is the default in this example. Then navigate into the root folder with where you have the `main.tf` file.
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
Once Terraform provisions the infrastructure you will get the `lb_dns_value` output value which you will use to create a CNAME record for the application subdomain in your domain management console.

This subdomain has to be similar to the one you used to create your ACM certificate. If you used a wildcard domain to create your ACM certificate. Then this subdomain for the CNAME record must be a valid child domain of the wildcard used in the ACM certificate.

## Example:
You will get similar output from Terraform after successfully creating all the resources:
```bash
Outputs:

lb_dns_value = "chimestarterkitex1-alb-alb-prod-1404XXXXX.us-east-1.elb.amazonaws.com"

```
If you created an ACM certificate based on the subdomain `chimestarter.example.com` where `example.com` is your domain. Then you will have to create a CNAME record with `chimestarter.example.com` as the CNAME's record name and `chimestarterkitex1-alb-alb-prod-1404XXXXX.us-east-1.elb.amazonaws.com` as the CNAME's value.

To learn how to create a CNAME record correctly on your DNS provider, kindly refer to the DNS provider specific documentation.

For further help reach out at: [team@webrtc.ventures](mailto:team@webrtc.ventures).
