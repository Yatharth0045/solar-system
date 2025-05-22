# Build stage
FROM node:18-alpine3.17 AS builder

WORKDIR /usr/app

# Copy only package files first to leverage Docker cache
COPY package*.json ./

# Install dependencies with ci for more reliable builds
RUN npm ci --only=production

# Copy source files
COPY . .

# Production stage
FROM node:18-alpine3.17

# Add non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /usr/app

# Copy only necessary files from builder
COPY --from=builder /usr/app/package*.json ./
COPY --from=builder /usr/app/node_modules ./node_modules
COPY --from=builder /usr/app/src ./src
COPY --from=builder /usr/app/public ./public

# Set environment variables
ENV NODE_ENV=production \
    MONGO_URI=uriPlaceholder \
    MONGO_USERNAME=usernamePlaceholder \
    MONGO_PASSWORD=passwordPlaceholder

# Use non-root user
USER appuser

EXPOSE 3000

# Use array syntax and add healthcheck
HEALTHCHECK --interval=30s --timeout=3s \
  CMD wget --no-verbose --tries=1 --spider http://localhost:3000/ || exit 1

CMD ["npm", "start"]