resource "aws_iam_role_policy" "ec2_policy" {
  name = "ec2_policy"
  role = "${aws_iam_role.javahome_ec2_role.id}"

  policy = "${file("ec2-policy.json")}"
  
  
}

resource "aws_iam_role" "javahome_ec2_role" {
  name = "javahome_ec2_role"

  assume_role_policy = "${file("ec2-assume-policy.json")}"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "javahome_ec2_role"
  role = "${aws_iam_role.javahome_ec2_role.name}"
}

