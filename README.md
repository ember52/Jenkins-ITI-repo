# Automated CI/CD for Infrastructure and Application Deployment

## About the Project:
This project embodies a comprehensive DevOps approach, leveraging key tools such as Jenkins, Ansible, Terraform, and AWS to establish an automated pipeline for infrastructure provisioning and application configuration.

## Steps:

1. **Infrastructure Provisioning:**
   - Utilize the Terraform code available in the main branch to provision necessary AWS resources.

2. **Jenkins Configuration:**
   - Configure a Jenkins slave node (EC2 instance or Docker container) equipped with Terraform. An Ansible playbook named 'playbook' in the 'second_branch' facilitates the setup of Terraform and JDK on the public instance.

3. **Pipeline Setup:**
   - Construct the pipeline using the provided Jenkinsfile script from the main branch. This pipeline orchestrates the deployment of the entire infrastructure based on specified parameters.

4. **Private Instance Configuration:**
   - Employ Ansible to configure the private instance. Utilize the 'playbook2' playbook file from the 'second_branch' and specify the private instance's IP in the accompanying inventory file.

5. **Jenkins Configuration Continued:**
   - Retrieve environment variables from the initial pipeline, primarily Terraform outputs. Securely store these variables as Secret Text within Jenkins credentials.

6. **Agent Configuration:**
   - Modify Jenkins configurations under the agents section to select TCP and specify port '50000'. Proceed to create a new slave node with the launch method set to 'launch agent by connecting it to the controller'.

7. **Agent Setup:**
   - Choose the appropriate code snippet based on the slave node's operating system (e.g., Unix/Linux). Execute this code on the private instance to configure it as an agent by fetching the agent.jar file via curl.

8. **Application Deployment:**
   - Establish a new pipeline to deploy the application on a Docker container using the Jenkinsfile provided in the 'second_branch'.

9. **Access Application:**
   - Access the deployed application via the load balancer's DNS, appending '/db' or '/redis' to the URL to interact with specific components.

