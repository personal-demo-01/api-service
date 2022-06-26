#!/bin/bash

CLUSTER=demo-01-ecs-cluster-dev
AWS_ACCOUNT_ID=594914845356
AWS_DEFAULT_REGION=us-east-2
IMAGE_REPO_NAME=demo-01-ecr-dev
TASK_FAMILY=test05

APP_TAG=$(cat version.txt)

ECR_IMAGE="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${APP_TAG}"

cat task-definition.json>output.json
sed -i "s+<family>+${TASK_FAMILY}+g" output.json
sed -i "s+<image>+${ECR_IMAGE}+g" output.json
echo "Task definition json file updated"

cat output.json|xargs -0 aws ecs register-task-definition --cli-input-json
echo "Task definition created"

REVISION=$(aws ecs describe-task-definition --task-definition "$TASK_FAMILY" --region "$AWS_DEFAULT_REGION" | jq '.taskDefinition.revision')

PREVIOUS_DEPLOYMENT_ARN=$(aws ecs list-tasks --cluster $CLUSTER|jq -r .taskArns[0])

if [[ "$PREVIOUS_DEPLOYMENT_ARN" != "null" ]]; then
    aws ecs stop-task --task $PREVIOUS_DEPLOYMENT_ARN --cluster $CLUSTER
    echo "Previous task stopped."
fi

aws ecs run-task --cluster $CLUSTER --task-definition $TASK_FAMILY:$REVISION --count 1
echo "Task deplyed successsfully"
echo "Current revision: $REVISION"

# Remove temporal file
rm output.json
