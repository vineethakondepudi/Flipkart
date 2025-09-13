FROM node:18

# Set working directory
WORKDIR /app

# Copy only frontend package.json and package-lock.json
COPY frontend/package*.json ./

# Install dependencies
RUN npm install

# Copy frontend source code
COPY frontend/ ./

# Expose port
EXPOSE 3000

# Start app
CMD ["npm", "start"]

