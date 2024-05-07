resource "aws_instance" "backend" {
  ami           = "ami-07caf09b362be10b8" ## Ver la imagen en aws y reemplazar este campo
  instance_type = "t2.micro"
  tags = {
    "Name" = "XCoin_Backend"
  }
}
