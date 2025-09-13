FROM node:18

WORKDIR /app

COPY package*.json ./
RUN npm install

# Copy everything else (including index.js)
COPY . .

EXPOSE 3000

CMD ["npm", "start"]

