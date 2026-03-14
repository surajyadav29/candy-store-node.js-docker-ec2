# Deploy Docker on AWS EC2 a candy-store project

# Candy Store App Deployment - Complete DevOps Workflow

This project demonstrates **end-to-end containerization and deployment** of a Node.js Candy Store application using **Git, Docker, Docker Hub, and AWS EC2**. It is a perfect showcase for DevOps skills in CI/CD, containerization, and cloud deployment.

---

## Table of Contents

1. [Project Overview](#project-overview)  
2. [Tech Stack](#tech-stack)  
3. [Prerequisites](#prerequisites)  
4. [Step 1: Create GitHub Repository](#step-1-create-github-repository)  
5. [Step 2: Initialize Local Git Repository](#step-2-initialize-local-git-repository)  
6. [Step 3: Add Dockerfile](#step-3-add-dockerfile)  
7. [Step 4: Build Docker Image](#step-4-build-docker-image)  
8. [Step 5: Tag Docker Image for Docker Hub](#step-5-tag-docker-image-for-docker-hub)  
9. [Step 6: Push Image to Docker Hub](#step-6-push-image-to-docker-hub)  
10. [Step 7: Launch AWS EC2 Instance](#step-7-launch-aws-ec2-instance)  
11. [Step 8: Install Docker on EC2](#step-8-install-docker-on-ec2)  
12. [Step 9: Pull Docker Image on EC2](#step-9-pull-docker-image-on-ec2)  
13. [Step 10: Run Container on EC2](#step-10-run-container-on-ec2)  
14. [Step 11: Access Application](#step-11-access-application)  
15. [Notes](#notes)  

---

## Project Overview

Candy Store is a simple Node.js application containerized using Docker. This README walks through creating a GitHub repository, adding Dockerfile, building images, pushing them to Docker Hub, and deploying on AWS EC2.

---

## Tech Stack

- Node.js (Alpine Linux)  
- Docker  
- Docker Hub  
- AWS EC2 (Amazon Linux 2023)  
- Git/GitHub  

---

## Prerequisites

- Git installed on local machine  
- Docker installed locally and on EC2 instance  
- Node.js installed locally for development  
- AWS account with EC2 access  
- Docker Hub account  

---

## Step 1: Create GitHub Repository

1. Go to GitHub and create a new repository, e.g., `candy-store-ec2-docker`.  
2. Initialize it with **no README**, we will add ours later.  

---

## Step 2: Initialize Local Git Repository

```bash
# Navigate to project directory
cd /path/to/candy-store

# Initialize Git
git init

# Stage all files
git add .

# Commit
git commit -m "Initial commit"

# Add remote repository
git remote add origin https://github.com/<your-username>/candy-store-ec2-docker.git

# Push to GitHub
git push -u origin main
```

---

## Step 3: Add Dockerfile

Create a `Dockerfile` in the project root:

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

## Step 4: Build Docker Image

```bash
# Build the Docker image locally
docker build -t candy-store-docker-ec2:01 .
```

Check the image:

```bash
docker images
```

---

## Step 5: Tag Docker Image for Docker Hub

```bash
docker tag candy-store-docker-ec2:01 <your-dockerhub-username>/candy-store-docker-ec2:01
```

Example:

```bash
docker tag candy-store-docker-ec2:01 ajay2929/candy-store-docker-ec2:01
```

---

## Step 6: Push Image to Docker Hub

```bash
# Login to Docker Hub
docker login

# Push the tagged image
docker push ajay2929/candy-store-docker-ec2:01
```

- Verify image exists on Docker Hub: `https://hub.docker.com/r/ajay2929/candy-store-docker-ec2`

---

## Step 7: Launch AWS EC2 Instance

1. Launch **Amazon Linux 2023** instance.  
2. Configure **security group**: allow SSH (22) and app port (3000) inbound.  

---

## Step 8: Install Docker on EC2

```bash
ssh -i "docker-ec2.pem" ec2-user@<EC2_PUBLIC_IP>

# Install Docker
sudo yum install docker
sudo systemctl start docker
sudo systemctl enable docker
docker --version
```

---

## Step 9: Pull Docker Image on EC2

```bash
sudo docker pull ajay2929/candy-store-docker-ec2:01
```

---

## Step 10: Run Container on EC2

```bash
sudo docker run --rm -d -p 3000:3000 ajay2929/candy-store-docker-ec2:01

# Verify running container
sudo docker ps
```

- Container runs on port **3000** and maps to EC2 public IP.

---

## Step 11: Access Application

In your browser:

```
http://<EC2_PUBLIC_IP>:3000
```

You should see the Candy Store app running.

---

## Notes

- Always ensure the Docker image is **tagged with your Docker Hub username** before pushing.  
- EC2 security groups must allow **incoming traffic on the port** your container exposes (3000).  
- Use `--rm -d` to **run containers in detached mode and auto-remove** when stopped.  
- Verify Docker image exists locally with `docker images` before tagging and pushing.  
- Use `docker login` before pushing images to Docker Hub.  
- Always check container logs if the app is not running:  

```bash
sudo docker logs <container_id>
```

- For DevOps interviews, this demonstrates:
  - GitHub workflow  
  - Dockerfile creation and image build  
  - Docker Hub image management  
  - AWS EC2 deployment  

---

**Candy Store App is now fully deployed using Docker and AWS EC2!** 
