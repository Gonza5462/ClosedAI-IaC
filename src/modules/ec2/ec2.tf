resource "aws_instance" "backend" {
  ami           = "ami-04b70fa74e45c3917"
  instance_type = "t2.micro"
  key_name = data.aws_key_pair.xcoin_mongodb_key.key_name
  subnet_id = "subnet-0bc68bccc25aa8a3f"
  tags = {
    "Name" = "XCoin_MongoDB"
  }
}
