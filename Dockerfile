# Stage 1: Build environment
FROM node:16-slim AS frontendbuild

# Set the working directory in the container
WORKDIR /app/frontend

# Copy the package.json and install dependencies
COPY frontend/package.json ./
RUN npm install --production

FROM node:16-slim

# Install Python and pip
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    rm -rf /var/lib/apt/lists/*

# Install Uvicorn (and any other Python dependencies you might need)
RUN pip3 install --upgrade pip && \
    pip3 install uvicorn fastapi

#Set the working directory for the production environment
WORKDIR /app/frontend

# Copy the application source code (excluding unnecessary files)
COPY  frontend/ ./

# Copy the built files from the build stage
COPY --from=frontendbuild /app/frontend ./

#Set the working directory for the production environment backend
WORKDIR /app/backend

# Copy the built files from the build stage
COPY  backend/app ./

# Expose port 3000 to the world outside this container
EXPOSE 3000
EXPOSE 4000

# Run npm start when the container launches
#CMD ["npm", "start"]
#CMD ["uvicorn", "main:app", "--host", "0.0.0.0" ,"--port", "4000"]

WORKDIR /app
ADD start.sh /
CMD ["/start.sh"]