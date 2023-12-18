# Setting up using an external DNS provider
This setup shows you an example of how to configure the WebRTC Ventures Chime Starter Kit high availability mode using an external DNS provider.

## Requirements
1. A registered domain.
2. Access to manage records in the domain records management console.

## Steps
Read the variable descriptions in the [`variable.tf`](./variables.tf) and supply corresponding variables as shown for your AWS account. 

Once you have configured your variables correclty navigate to the root folder of your setup
1. Setup your backend, you can use local backend as it is the default in this example.
2. Validate your configuration by running 
2. Initialize terraform module by running:
   ```bash
   terraform init --upgrade
   ```
3. 