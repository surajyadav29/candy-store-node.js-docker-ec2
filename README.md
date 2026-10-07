# Deploy Docker on AWS EC2 - Candy Store Project

# Candy Store App Deployment - Complete DevOps Workflow

This project demonstrates **end-to-end containerization and deployment** of a Node.js Candy Store application using **Docker, Docker Hub, and AWS EC2**. It is a perfect showcase for DevOps skills in CI/CD, containerization, and cloud deployment.

---

## Project Overview

Candy Store is a Node.js application containerized using Docker. This README walks through creating a Docker Hub repository, building Docker images, pushing them to Docker Hub, launching an AWS EC2 instance, and deploying the container.

---

## Tech Stack

- Node.js (Alpine Linux)  
- Docker  
- Docker Hub  
- AWS EC2 (Amazon Linux 2023)  

---

## Step 1: Create Docker Hub Repository

1. Go to [Docker Hub](https://hub.docker.com/) and create a new repository.  
2. Name the repository, e.g., `candy-store-docker-ec2`.  
3. Keep it **public** (or private if preferred).  
4. Copy the repository URL, e.g., `<your-dockerhub-username>/candy-store-docker-ec2`.  

---

## Step 2: Add Dockerfile

Create a `Dockerfile` in your project root:

```dockerfile
# Use Node.js Alpine image
FROM node:alpine3.10

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Install dependencies
RUN npm install

# Expose port
EXPOSE 3000

# Start application
CMD ["npm", "start"]
```

---

## Step 3: Build Docker Image

```bash
# Build Docker image locally
docker build -t candy-store-docker-ec2:01 .
```

Check the image:

```bash
docker images
```

---

## Step 4: Tag Docker Image for Docker Hub

```bash
docker run <your-dockerhub-username>/candy-store-docker-ec2:01
```
---

## Step 5: Push Image to Docker Hub

```bash
# Login to Docker Hub
docker login

# Push the tagged image
docker push <your-dockerhub-username>/candy-store-docker-ec2:01
```

- Verify image exists on Docker Hub: `https://hub.docker.com/r/<your-dockerhub-username>/candy-store-docker-ec2`

---

## Step 6: Launch AWS EC2 Instance

1. Go to **AWS EC2 Console → Launch Instance**  
2. Choose **Amazon Linux 2023 AMI**  
3. Select **instance type** (e.g., `t2.micro`)  
4. Configure **security group**:  
   - SSH (port 22)  
   - Custom TCP port 3000 (for the app)  
5. Create or select a **key pair** (`docker-ec2.pem`) to connect via SSH.  
6. Launch the instance.  

---

## Step 7: Install Docker on EC2

```bash
# SSH into EC2
ssh -i "docker-ec2.pem" ec2-user@<EC2_PUBLIC_IP>

# Install Docker
sudo yum install docker
sudo systemctl start docker
sudo systemctl enable docker

# Verify installation
docker --version
```

---

## Step 8: Pull Docker Image on EC2

```bash
sudo docker pull <your-dockerhub-username>/candy-store-docker-ec2:01
```

---

## Step 9: Run Container on EC2

```bash
sudo docker run --rm -d -p 3000:3000 <your-dockerhub-username>/candy-store-docker-ec2:01

# Verify running container
sudo docker ps
```

- Container runs on port **3000** and maps to EC2 public IP.

---

## Step 10: Access Application

In your browser:

```
http://<EC2_PUBLIC_IP>:3000
```

You should see the Candy Store app running.

---

## Notes

- Always ensure the Docker image is **tagged with your Docker Hub username** before pushing.  
- EC2 security groups must allow **incoming traffic on port 3000**.  
- Use `--rm -d` to **run containers in detached mode and auto-remove** when stopped.  
- Verify Docker image exists locally with `docker images` before tagging and pushing.  
- Use `docker login` before pushing images to Docker Hub.  
- Check container logs if the app is not running:  

```bash
sudo docker logs <container_id>
```

**Candy Store App is now fully deployed using Docker and AWS EC2!**
