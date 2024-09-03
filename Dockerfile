# Stage 1: Builder Stage
# Purpose: Install dependencies and build the Python environment
# ---------------------------------------
FROM python:3.12-slim AS builder

# Set the working directory
WORKDIR /app

# Install necessary system packages for building Python dependencies
RUN apt-get update && apt-get install -y \
    curl \
    gcc \
    python3-dev \
    libpq-dev

# Install Poetry for managing Python dependencies
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="/root/.local/bin:$PATH"

# Copy the Poetry configuration files to install dependencies
COPY pyproject.toml poetry.lock ./

# Install all dependencies defined in pyproject.toml without installing the package itself
RUN poetry install --no-root

# Ensure uvicorn and psycopg2-binary are explicitly installed in the virtual environment
RUN poetry run pip install uvicorn psycopg2-binary

# ---------------------------------------
# Stage 2: Production Image
# Purpose: Create a lightweight image for running the FastAPI application
# ---------------------------------------
FROM python:3.12-slim

# Set the working directory
WORKDIR /app

# Install only the runtime dependencies (PostgreSQL client libraries)
RUN apt-get update && apt-get install -y libpq-dev && rm -rf /var/lib/apt/lists/*

# Copy the virtual environment and Poetry installation from the builder stage
COPY --from=builder /root/.local /root/.local
COPY --from=builder /root/.cache/pypoetry /root/.cache/pypoetry

# Set the PATH environment variable to include the Poetry and virtual environment binaries
ENV PATH="/root/.local/bin:$PATH"
ENV VIRTUAL_ENV="/root/.cache/pypoetry/virtualenvs/sample-api-9TtSrW0h-py3.12"
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Copy the entire application source code into the container
COPY . .

# Expose the application port
EXPOSE 8000

# Command to run the FastAPI application with Uvicorn
CMD ["uvicorn", "src.sample_api.main:app", "--host", "0.0.0.0", "--port", "8000"]
