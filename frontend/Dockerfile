# Stage 1: Build environment
FROM node:16-slim AS build

# Set the working directory in the container
WORKDIR /app

# Copy the package.json and install dependencies
COPY package.json /app/
RUN npm install --production

# Copy the application source code (excluding unnecessary files)
COPY ./public /app/public
COPY ./src /app/src

# Stage 2: Runtime environment
FROM node:16-slim

# Add a non-root user to run the application
RUN useradd -m nonrootuser

# Set the working directory in the container
WORKDIR /app

# Copy only the necessary files from the build stage
COPY --chown=nonrootuser:nonrootuser --from=build /app /app

# Switch to the non-root user
USER nonrootuser

# Expose port 3000 to the world outside this container
EXPOSE 3000

# Run npm start when the container launches
CMD ["npm", "start"]
