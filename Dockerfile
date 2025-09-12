FROM node:18

WORKDIR /app

# Copy root package.json
COPY package*.json ./

# Copy server_backend package.json
COPY server_backend/package*.json ./server_backend/

# Install dependencies (root + backend)
RUN npm install && cd server_backend && npm install

# Copy the rest of the code
COPY . .

EXPOSE 3000

CMD ["npm", "start"]

