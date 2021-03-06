#!/bin/bash
# 
# Script using 'aws s3 cp' to copy files from source and destination, which 
# is generally s3 path for source and s3 bucket for destination, but can be 
# 
# Requires:
#     awscli installed such that 'aws' command available in $PATH to be invoked
#     directly
# 
# Args:
#     source_path: Source file on the PC
#     dest_bucket: Destination bucket to sync the folder
#     profile: AWS profile creds to use for syncing files
#     
# 
if [ $# -lt 2 ]; then
    echo "[-] $0 <source_path> <dest_bucket> [profile=default]"
    exit 1
fi
source_path="$1"
dest_bucket="$2"
profile=${3:-"default"}

# Check if destination bucket has s3:// prefix, if not put it in
is_bucket_prefxd=$(echo "$dest_bucket" | grep -iE "^s3://" )
if [ -z "$is_bucket_prefxd" ]; then
    dest_bucket=$(echo "s3://$dest_bucket")
fi

# Start copying file between the destination bucket and folder
echo "[*] Copying files - source: $source_path & dest: $dest_bucket with aws profile: $profile"
/bin/bash -c "aws s3 cp $source_path $dest_bucket --profile=$profile"
