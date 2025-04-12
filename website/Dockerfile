FROM softonic/node-prune AS prune

FROM node:16.3-slim AS build
ENV NODE_ENV production
WORKDIR /app
COPY --from=prune /go/bin/node-prune /usr/local/bin/
ADD . .
RUN npm install

FROM node:16.3-slim
ENV NODE_ENV production

# Accept build-time arguments
ARG WEBSITE_TITLE='Blue Parrot'
ARG WEBSITE_IMAGE='parrot-1.jpg'
ARG WEBSITE_VERSION='1.0.0'

# Set them as environment variables inside the container
ENV WEBSITE_TITLE=${WEBSITE_TITLE}
ENV WEBSITE_IMAGE=${WEBSITE_IMAGE}
ENV WEBSITE_VERSION=${WEBSITE_VERSION}

WORKDIR /app
COPY --from=build /app .

# Remove this to avoid overwriting app files with potentially stale source
# ADD . .

EXPOSE 3000
CMD ["node", "server.js"]
