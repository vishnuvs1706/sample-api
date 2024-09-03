# Changelog
### Question 1:
 ### Added
 - `Dockerfile` to build the Docker image for the FastAPI application.
 - `changelog.md` to show what are all the files added and how to run the application in Docker

 ### Instructions on how to build the Docker Image and run it as a container
 
 ### In Docker, run these two commands.
 - `docker build -t sample-api .` to build the Docker Image
 - `docker run -p 8000:8000 sample-api` to run the Docker Container

### Once you run the Docker Container, you can access the API on http://0.0.0.0:8000

### Question 2: 

  ### Instructions on How to Pull and Run Your Image
 - `docker pull ghcr.io/vishnuvs1706/sample-api:latest`
   
  ### Added
  - `.github/workflows/ci-cd-pipeline.yml`: Added GitHub Actions workflow for CI/CD pipeline.
