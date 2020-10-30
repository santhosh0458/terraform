resource "aws_dynamodb_table" "EmpList" {
  name           = "EmpList"
  billing_mode   = "PROVISIONED"
  read_capacity  = 10
  write_capacity = 10
  hash_key       = "EmpId"
  range_key      = "EmpName"

  attribute {
    name = "EmpId"
    type = "N"
  }

  attribute {
    name = "EmpName"
    type = "S"
  }

  attribute {
    name = "Dept"
    type = "S"
  }

//  ttl {
//    attribute_name = "TimeToExist"
//    enabled        = false
//  }

  global_secondary_index {
    name               = "EmpName"
    hash_key           = "EmpName"
    range_key          = "Dept"
    write_capacity     = 5
    read_capacity      = 5
    projection_type    = "INCLUDE"
    non_key_attributes = ["EmpId"]
  }

  tags = {
    Name        = "EmpList"
    Environment = "production"
  }
}
