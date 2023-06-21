#Commands Used

## AWS EC2 API - [Retrieve Instance Metadata](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instancedata-data-retrieval.html)

### Get Name of Instance as shown in Console with IMDSv1
**Requires awscli login**
```bash
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
INSTANCE_NAME=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[].Instances[].Tags[?Key==`Name`].Value' --output text)
echo "Instance Name: $INSTANCE_NAME"
```

## IMDSv2
**Does not requires awscli login but displays hostname**
```bash
TOKEN=$(curl -X PUT -H "X-aws-ec2-metadata-token-ttl-seconds: 300" "http://169.254.169.254/latest/api/token")
INSTANCE_NAME=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -H "Accept: application/json" "http://169.254.169.254/latest/meta-data/hostname" | cut -d . -f 1)
echo "Instance Name: $INSTANCE_NAME"
```

### Dockerfile CI/CD using Github Actions
Use CMD/RUN ls folder/file for checking whether files exist or not.
