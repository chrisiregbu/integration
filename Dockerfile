# Step 1:

# Inherit FROM node/alpine image
FROM node:16-alpine3.13 as build-step
RUN apk add --no-cache chromium=86.0.4240.111-r0
RUN apk add --no-cache python3=3.8.10-r0

ENV CHROME_BIN='/usr/bin/chromium-browser'

# Copy the app code in the “app” folder
RUN mkdir -p /app

WORKDIR /app

# Install app dependencies from package.json file 
COPY package.json /app

COPY src  ./src

RUN npm config set legacy-peer-deps true

RUN npm install 

COPY . /app

# Create production build using Node image
RUN  npm run build --prod

# Step 2 - NGINX server

# Base image - use the Ngix server image to create the Nginx server
FROM nginx:1.19.4-alpine

# Copy/deploy the application (static) files to the Nginx server at /usr/share/Nginx/HTML location
COPY --from=build-step /app/dist/DemoApp /usr/share/nginx/html

# expose port
EXPOSE 80

# Run Nginx
CMD ["nginx", "-g", "daemon off;"]
