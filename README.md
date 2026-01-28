
---
- Video Explanation: [FastAPI lab](https://www.youtube.com/watch?v=KReburHqRIQ&list=PLcS4TrUUc53LeKBIyXAaERFKBJ3dvc9GZ&index=4)
- Blog: [FastAPI Lab-1](https://www.mlwithramin.com/blog/fastapi-lab1)

---

## Overview

The code in `assets`, `model`, and `src` are laregly from the starter lab code [`Labs/API_Labs/FastAPI_Labs`](https://github.com/raminmohammadi/MLOps/tree/main/Labs/API_Labs/FastAPI_Labs) on the main repository.

To make this project unique, I chose to implement:
- Containerization using docker which will train the model in a container and then use a multi-stage build to bring that model over to the final serving image. 
- Custom dependency management using `uv` rather than directly with `requirements.txt` since I think that would be cool to experiment with and make the docker process a little different.
- New route for the FastAPI which is `GET /rand`, which returns a random number. Kept the original routes of `/docs` for documentation, `/` for health, and `/predict` for inference.
- CI/CD pipeline with publishes the docker image to a container registry (GHCR). I choose this container registry since I have worked with the GCP and AWS registries in the past, but not this one, so this is a new experiment!

## Setting up the lab

### Run Locally - On Host 
1. Install [uv](https://docs.astral.sh/uv/)
2. Install dependencies with `uv sync`
3. `cd src`
4. `uv run train.py`
4. `uv run uvicorn main:app --reload`

### Run Locally - In Docker

1. run `docker build -t lab1:latest . && (docker rm lab1 2>&1 >> /dev/null || echo 1) &&  docker run --name lab1 -p 80:80 lab1:latest`
    - This command builds the image
    - Deletes an existing container if it exists (prevent name clash)
    - Runs the application on `localhost:80`

### Run Locally - In Docker using my image from container registry

1. `docker pull ghcr.io/alearningcurve/ie7374-mlops-lab1:main && (docker rm lab1 2>&1 >> /dev/null || echo 1) &&  docker run --name lab1 -p 80:80 ghcr.io/alearningcurve/ie7374-mlops-lab1:main`

### Run Locally - Build Image and Push to Container Registry

1. Setup GH actions
    - Go to account setting > developer settings > personal access tokens > create new classic token (give it access to write packages)
    - Copy this token, and set the GitHub Actions secret `GH_PACKAGE_TOKEN` to have this token as a value 
2. Trigger github action to run (`git commit --allow-empty -m "chore: build container" && git push`)
3. Make sure the package is set to public (to repo root in gitub > package > package settings > change visibility ) 
5. Run `docker pull ghcr.io/alearningcurve/ie7374-mlops-lab1:main && (docker rm lab1 2>&1 >> /dev/null || echo 1) &&  docker run --name lab1 -p 80:80 ghcr.io/alearningcurve/ie7374-mlops-lab1:main`, where you replace `alearningcurve` to a reference to your user

### Project structure

Directories and files of note:
-  `.github`: contains the workflow I added 
-  `Dockerfile` contains the dockerization script
-  `pyproject.toml` and `uv.lock`: dependency information from uv
-  `src/main.py`: modified to add the `/rand` route to generate a random number