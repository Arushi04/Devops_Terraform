import boto3
import variables

#creating and uploading to S3 bucket
s3 = boto3.resource('s3')
bucket = s3.Bucket(variables.bucket_name)

if(bucket in s3.buckets.all()):
	s3.meta.client.upload_file(variables.file_name, variables.bucket_name, variables.file_name)
else:
	s3.create_bucket(Bucket=variables.bucket_name, CreateBucketConfiguration={'LocationConstraint': 'ap-south-1'})
	s3.meta.client.upload_file(variables.file_name, variables.bucket_name, variables.file_name)
