
---
- Video Explanation: [FastAPI lab](https://www.youtube.com/watch?v=KReburHqRIQ&list=PLcS4TrUUc53LeKBIyXAaERFKBJ3dvc9GZ&index=4)
- Blog: [FastAPI Lab-1](https://www.mlwithramin.com/blog/fastapi-lab1)

---

## Overview

The code in `assets`, `model`, and `src` are from the starter lab code [`Labs/API_Labs/FastAPI_Labs`](https://github.com/raminmohammadi/MLOps/tree/main/Labs/API_Labs/FastAPI_Labs) on the main repository.

To make this project unique, I chose to implement:
- Containerization using docker which will train the model in a container and then use a multi-stage build to bring that model over to the final serving image. 
- Custom dependency management using `uv` rather than directly with `requirements.txt` since I think that would be cool to experiment with and make the docker process a little different.
- New route for the FastAPI which is `GET /rand`, which returns a random number. 

## Setting up the lab

1. Install [uv](https://docs.astral.sh/uv/)
2. Install dependencies with `uv sync`

### Project structure

Directories and files of note:
-  `.github`: contains the workflow I added 
-  `Dockerfile` contains the dockerization script
-  `pyproject.toml` and `uv.lock`: dependency information from uv
-  `src/main.py`: modified to add the `/rand` route to generate a random number