import boto3

region = ['mumbai']
key_pair_name = 'testkeypair_'+region[0]
file_name= key_pair_name +'.pem'

ec2 = boto3.resource('ec2', region_name="ap-south-1")

#creating the key pair and storing it into a .pem file
outfile = open(file_name,'w')
key_pair = ec2.create_key_pair(KeyName=key_pair_name)
KeyPairOut = str(key_pair.key_material)
outfile.write(KeyPairOut)

#creates a S3 bucket and stores the generated private key file to the bucket
s3 = boto3.resource('s3')
bucket_name='test-ec2-pem'
bucket = s3.Bucket(bucket_name)

if(bucket in s3.buckets.all()):
	s3.meta.client.upload_file(file_name, bucket_name, file_name)
else:
	s3.create_bucket(Bucket=bucket_name, CreateBucketConfiguration={'LocationConstraint': 'ap-south-1'})
	s3.meta.client.upload_file(file_name, bucket_name, file_name)
