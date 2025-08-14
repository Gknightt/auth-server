# Frontend Dockerfile for Railway deployment
FROM node:24.5-alpine

# Set working directory
WORKDIR /app

# Copy package files
COPY package.json ./
COPY yarn.lock* ./
COPY package-lock.json* ./

# Install dependencies
RUN npm ci --omit=dev

# Copy source code (excluding files in .dockerignore)
COPY . .

# Build the application
RUN npm run build

# Install serve to serve the static files
RUN npm install -g serve

# Expose port (Railway will override this with PORT env var)
EXPOSE 3000

# Start the application - Railway will set PORT env var
CMD sh -c "serve -s dist -l ${PORT:-3000}"
