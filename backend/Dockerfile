# Use a lightweight Node.js image
FROM node:18-alpine

# Set working dir
WORKDIR /usr/src/app

# Install only production deps
COPY package*.json ./
RUN npm ci --only=production

# Copy app source
COPY . .

# Allow PORT to be set at build or runtime (Cloud Run will inject PORT=8080)
ARG PORT=8080
ENV PORT=${PORT}

# Expose it (optional; Dockerfile vars are expanded here)
EXPOSE ${PORT}

# Start your server (assumes your package.json "start" runs node index.js,
# which must use process.env.PORT)
CMD ["npm", "start"]
