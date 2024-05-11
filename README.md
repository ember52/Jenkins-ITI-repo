# Automated CI/CD for Infrastructure and Application Deployment

## About the Project:
This project embodies a comprehensive DevOps approach, leveraging key tools such as Jenkins, Ansible, Terraform, and AWS to establish an automated pipeline for infrastructure provisioning and application configuration.

## Steps:

1. **Infrastructure Provisioning:**
   - Utilize the Terraform code available in the main branch to provision necessary AWS resources.

2. **Jenkins Configuration:**
   - Configure a Jenkins slave node (EC2 instance or Docker container) equipped with Terraform. An Ansible playbook named 'playbook' in the 'second_branch' facilitates the setup of Terraform and JDK on the public slave instance.

3. **Pipeline Setup:**
   - Construct the pipeline using the provided Jenkinsfile script from the main branch. This pipeline orchestrates the deployment of the entire infrastructure based on specified parameters.
     
![Screenshot from 2024-05-09 23-08-30](https://github.com/ember52/Jenkins-ITI-repo/assets/117265490/530470b1-096d-49c7-8419-ece5027c7e62)

4. **Private Instance Configuration:**
   - Employ Ansible to configure the private instance. Utilize the 'playbook2' playbook file from the 'second_branch' and specify the private instance's IP in the accompanying inventory file under the 'second_private_slave_node' section.

5. **Jenkins Configuration Continued:**
   - Retrieve environment variables from the initial pipeline, primarily Terraform outputs. Securely store these variables as Secret Text within Jenkins credentials.

6. **Agent Configuration:**
   - Modify Jenkins configurations under the agents section to select TCP and specify port '50000'. Proceed to create a new slave node with the launch method set to 'launch agent by connecting it to the controller'.

7. **Agent Setup:**
   - Choose the appropriate code snippet based on the slave node's operating system (e.g., Unix/Linux). Execute this code on the private instance to configure it as an agent by fetching the agent.jar file via curl.

![Screenshot from 2024-05-09 22-27-53](https://github.com/ember52/Jenkins-ITI-repo/assets/117265490/c7e7c670-f0c3-49e3-95b9-9ff212e3428c)


8. **Application Deployment:**
   - Establish a new pipeline to deploy the application on a Docker container using the Jenkinsfile provided in the 'second_branch'.

![Screenshot from 2024-05-09 22-58-46](https://github.com/ember52/Jenkins-ITI-repo/assets/117265490/21d34e98-8547-4346-b17b-c1e3198c47e8)


9. **Access Application:**
   - Access the deployed application via the load balancer's DNS, appending '/db' or '/redis' to the URL to interact with specific components.
     
![Screenshot from 2024-05-09 22-08-56](https://github.com/ember52/Jenkins-ITI-repo/assets/117265490/65c7ccd9-0544-4871-9fd9-f0d6c7f0a049)


![Screenshot from 2024-05-09 22-11-25](https://github.com/ember52/Jenkins-ITI-repo/assets/117265490/f9a6fd0f-8bb7-45a0-81d0-65a778ceefd5)

