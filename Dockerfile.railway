# Railway Frontend-only Dockerfile
FROM node:24.5-alpine

# Set working directory
WORKDIR /app

# Copy package files from ui2 directory
COPY ui2/package.json ui2/yarn.lock* ./

# Install dependencies
RUN npm ci --omit=dev

# Copy ui2 source code
COPY ui2/ ./

# Build the application
RUN npm run build

# Install serve globally
RUN npm install -g serve

# Expose port (Railway will set PORT env var)
EXPOSE 3000

# Start the application
CMD sh -c "serve -s dist -l ${PORT:-3000}"
