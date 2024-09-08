#!/bin/bash

colorize_output() {
   GREEN='\x1b[32m'
   RED='\x1b[31m'
   RESET='\x1b[0m'

   while IFS= read -r line; do
     line=$(echo "$line" | sed "s/allowed/${GREEN}&${RESET}/g")
     line=$(echo "$line" | sed "s/Error:/${RED}&${RESET}/g")
     line=$(echo "$line" | sed "s/implicitDeny/${RED}&${RESET}/g")
     echo -e "$line"
   done
 }

usage() {
  echo "Usage: $0 <username> <bucket>"
  exit 1
}

if [ $# -ne 2 ]; then
  usage
fi

username=$1
bucket=$2

# Check if the S3 bucket exists (using AWS CLI)
if ! aws s3 ls "s3://$bucket" &>/dev/null; then
  echo "Error: Bucket '$bucket' does not exist." | colorize_output
  exit 1
fi

# Check if the IAM user exists in AWS
if ! aws iam get-user --user-name "$username" &>/dev/null; then
  echo "Error: User '$username' does not exist in AWS IAM." | colorize_output
  exit 1
fi

aws iam simulate-principal-policy \
    --policy-source-arn $(aws iam get-user --user-name $username | jq -r '.User.Arn') \
    --action-names s3:ListBucket s3:GetObject s3:PutObject s3:DeleteObject s3:ListAllMyBuckets s3:CreateBucket s3:DeleteBucket \
    --resource-arns arn:aws:s3:::$bucket arn:aws:s3:::$bucket/* \
    --query 'EvaluationResults[*].{Action:EvalActionName, Resource:EvalResourceName, Decision:EvalDecision, PolicyId:MatchedStatements[0].SourcePolicyId}' \
    --output=json| jq -r '.[] | "\(.Action) \(.Resource) \(.Decision) \(.PolicyId)"' | column -t | colorize_output
