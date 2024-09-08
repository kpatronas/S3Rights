# S3Rights
A simple bash script that lists rights of a user in a bucket

## Configuration

This tool assumes you have jq installed and aws cli allready configured since is just a wrapper to this, 
next thing you need to do is to give execution rights to the script
```
chmod +x s3rights.sh
```

## Usage
```
./s3rights.sh <username> <bucket>
```

## Example
```
./s3rights.sh user1 kpatronas-test-bucket
s3:ListBucket        arn:aws:s3:::kpatronas-test-bucket    allowed       user_user1_S3kpatronas-test-bucket-RO
s3:ListBucket        arn:aws:s3:::kpatronas-test-bucket/*  allowed       user_user1_S3kpatronas-test-bucket-RO
s3:GetObject         arn:aws:s3:::kpatronas-test-bucket    allowed       user_user1_S3kpatronas-test-bucket-RO
s3:GetObject         arn:aws:s3:::kpatronas-test-bucket/*  allowed       user_user1_S3kpatronas-test-bucket-RO
s3:PutObject         arn:aws:s3:::kpatronas-test-bucket    implicitDeny  null
s3:PutObject         arn:aws:s3:::kpatronas-test-bucket/*  implicitDeny  null
s3:DeleteObject      arn:aws:s3:::kpatronas-test-bucket    implicitDeny  null
s3:DeleteObject      arn:aws:s3:::kpatronas-test-bucket/*  implicitDeny  null
s3:ListAllMyBuckets  arn:aws:s3:::kpatronas-test-bucket    implicitDeny  null
s3:ListAllMyBuckets  arn:aws:s3:::kpatronas-test-bucket/*  implicitDeny  null
s3:CreateBucket      arn:aws:s3:::kpatronas-test-bucket    implicitDeny  null
s3:CreateBucket      arn:aws:s3:::kpatronas-test-bucket/*  implicitDeny  null
s3:DeleteBucket      arn:aws:s3:::kpatronas-test-bucket    implicitDeny  null
s3:DeleteBucket      arn:aws:s3:::kpatronas-test-bucket/*  implicitDeny  null
```
