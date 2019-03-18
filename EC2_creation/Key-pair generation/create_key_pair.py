import boto3
import variables

ec2 = boto3.resource('ec2', region_name="ap-south-1")

#creating the key pair and storing it into a .pem file
outfile = open(variables.file_name,'w')
key_pair = ec2.create_key_pair(KeyName=variables.key_pair_name)
KeyPairOut = str(key_pair.key_material)
outfile.write(KeyPairOut)

