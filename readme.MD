## SimpleTimeService – Deployment & Setup Documentation

 # 1. Prerequisites


    On the EC2 instance

    An Amazon Linux 2 or Ubuntu EC2 instance with:

    Python 3 installed

    Docker installed

    Docker service running

    Port 8080 allowed in the EC2 security group (Inbound rule)

# 2. Install & Configure Docker on EC2

    Install Docker
        dnf -y install dnf-plugins-core
        dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
        dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
        
    Start Docker service
        systemctl start docker
        systemctl enable docker

    Add ec2-user to docker group
        usermod -aG docker ec2-user

    Logout and login again so group changes will apply.

# 3. Project Structure

    Inside your project directory:

    app/
    ├── main.py
    ├── requirements.txt
    └── Dockerfile

# 4. Python Files
    This is the source code of the SimpleTimeService

# 5. requirements.txt
    This file defines the version of the modules
    
# 6. Dockerfile
    The Dockerfile includes the steps to bulid the Docker image for the SimpleTimeService
# 7. Build the Docker Image

    Navigate to the application directory: cd ~/app
    Build the docker image: docker build -t simpletime:latest .

# 8. Run the Docker Container

    Use port mapping so the service is reachable: docker run -d --name simpletime -p 8080:8080 simpletime:latest

    Check running containers: docker ps

# 9. Testing the Microservice
    From EC2 instance
    curl http://localhost:8080/

    From your browser
    Use the EC2 public IP:
    http://<EC2-PUBLIC-IP>:8080/
            
    Example:

    http://13.217.231.160:8080/

# 10. Accessing the Container Shell

    This image uses sh, not bash: docker exec -it simpletime sh

# 11. Stopping or Removing the Service
    Stop
    docker stop simpletime

    Start again
    docker start simpletime

    Remove
    docker rm -f simpletime

Setup Completed

The SimpleTimeService microservice is now fully deployed using Docker on AWS EC2.
