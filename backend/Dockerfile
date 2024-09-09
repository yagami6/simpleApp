# Stage 1: Build environment
FROM python:3.12-slim AS build

# Set the working directory in the container
WORKDIR /code

# Copy the requirements file
COPY requirements.txt .

# Install dependencies into a temporary directory
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# Stage 2: Runtime environment
FROM python:3.12-slim

# Add a non-root user to run the application
RUN useradd -m nonrootuser

# Set the working directory in the container
WORKDIR /code

# Copy the app source code
COPY --chown=nonrootuser:nonrootuser ./app /code/app

# Copy installed Python packages from the build stage
COPY --chown=nonrootuser:nonrootuser --from=build /install /usr/local

# Switch to the non-root user
USER nonrootuser

EXPOSE 4000

# Run app.py when the container launches
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "4000", "--root-path", "/backend"]
