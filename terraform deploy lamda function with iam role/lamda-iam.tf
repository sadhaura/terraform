resource "aws_iam_role_policy" "lamda_policy" {
  name = "lamda_policy"
  role = "${aws_iam_role.lamda_role.id}"

  policy = "${file("iam/lamda-policy.json")}"
}

resource "aws_iam_role" "lamda_role" {
  name = "lamda_role"

  assume_role_policy = "${file("iam/lamda-assume-policy.json")}"
}
