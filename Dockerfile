# Build stage
FROM node:18.19-alpine3.19 AS builder

WORKDIR /usr/src/app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy source
COPY . .

# Production stage
FROM node:18.19-alpine3.19

# Install dumb-init for proper signal handling
RUN apk add --no-cache dumb-init

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /usr/app

# Copy from builder stage
COPY --from=builder /usr/src/app/package*.json ./
COPY --from=builder /usr/src/app/node_modules ./node_modules
COPY --from=builder /usr/src/app/ .

# Set environment variables
ENV NODE_ENV=production \
    MONGO_URI=uriPlaceholder \
    MONGO_USERNAME=usernamePlaceholder \
    MONGO_PASSWORD=passwordPlaceholder

# Switch to non-root user
USER appuser

EXPOSE 3000

# Use dumb-init as entrypoint
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["npm", "start"]