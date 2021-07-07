package terraform

import input as tfplan
deny[reason] {
	r = tfplan.resource_changes[_]
	r.mode == "managed"
	r.type == "aws_s3_bucket"
	r.change.after.acl != "private"

	reason := sprintf("%-10s :: S3 buckets must not be PUBLIC", 
	                    [r.address])
}