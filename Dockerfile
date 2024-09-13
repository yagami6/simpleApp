# Stage 1: Build environment
FROM node:16-slim AS frontendbuild

# Set the working directory in the container
WORKDIR /app/frontend

# Copy the package.json and install dependencies
COPY frontend/package.json ./
RUN npm install --production && \
    npm cache clean --force
COPY  frontend/ ./

FROM node:16-alpine

# Install Python and pip
#RUN apt-get update && \
#    apt-get install -y --no-install-recommends python3 python3-pip && \
#    apt-get clean && \
#    rm -rf /var/lib/apt/lists/*
RUN apk add --no-cache python3 py3-pip && \
    pip3 install --no-cache-dir --upgrade pip uvicorn fastapi

# Install Uvicorn (and any other Python dependencies you might need)
#RUN pip3 install --no-cache-dir --upgrade pip && \
#    pip3 install --no-cache-dir uvicorn fastapi

#Set the working directory for the production environment
WORKDIR /app/frontend

# Copy the application source code (excluding unnecessary files)
#COPY  frontend/ ./

# Copy the built files from the build stage
COPY --from=frontendbuild /app/frontend ./

#Set the working directory for the production environment backend
WORKDIR /app/backend

# Copy the built files from the build stage
COPY  backend/app ./

# Expose port 3000 to the world outside this container
EXPOSE 3000
EXPOSE 4000

WORKDIR /app
COPY start.sh ./
RUN chmod +x  /app/start.sh
CMD ["/bin/sh","/app/start.sh"]