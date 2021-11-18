#!/bin/sh

echo "Pre-Build Steps:"
echo "authenticating with AWS ECR..."
aws ecr get-login-password --region eu-west-2 \
    | docker login --username AWS \
    --password-stdin 471776097205.dkr.ecr.eu-west-2.amazonaws.com

echo "Build Steps:"
echo "building image..."
docker build -t 471776097205.dkr.ecr.eu-west-2.amazonaws.com/awscicd:latest .

echo "Post-Build Steps:"
echo "pushing image to AWS ECR..."
docker push 471776097205.dkr.ecr.eu-west-2.amazonaws.com/awscicd:latest

echo "updating AWS ECS service..."
aws ecs update-service --cluster awscicd-cluster --service angular-svc --force-new-deployment --no-cli-pager

echo "Done!"