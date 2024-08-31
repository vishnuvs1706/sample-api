# Changelog

### Added
- `Dockerfile` to build the Docker image for the FastAPI application.
- `requirements.txt` to list all the dependencies.
- `changelog.md` to show what are all the files added and how to run the application in Docker

### Instructions on how to build the Docker Image and run it as a container
### In Docker, run these two commands.

- `docker build -t sample-api .` to build the Docker Image
- `docker run -p 80:80 sample-api` to run the Docker Container

### Once you run the Docker Container, you can access the API on http://0.0.0.0:80
