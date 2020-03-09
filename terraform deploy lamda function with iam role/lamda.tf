locals{

  lamda_zip_location = "outputs/welcome.zip"

}

data "archive_file" "welcome" {
  type        = "zip"
  source_file = "welcome.py"
  output_path = "${local.lamda_zip_location}"
}



resource "aws_lambda_function" "test_lambda" {
  filename      = "${local.lamda_zip_location}"
  function_name = "welcome"
  role          = "${aws_iam_role.lamda_role.arn}"
  handler       = "welcome.hello"

  
  #source_code_hash = "${filebase64sha256("lambda_function_payload.zip")}"

  runtime = "python3.7"

  
}
