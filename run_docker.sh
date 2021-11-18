#!/usr/bin/env bash

## Complete the following steps to get Docker running locally

# Step 1:
# Build image and add a descriptive tag
docker build -t cicloud-app:latest .

# Step 2: 
# List docker images
docker images ls

# Step 3: 
# Run flask app
docker run -t -i -p 8000:3000 cicloud-app:latest