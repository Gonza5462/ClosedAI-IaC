resource "aws_instance" "backend" {
  ami           = "ami-0dcc1e21636832c5d" ## Ver la imagen en aws y reemplazar este campo
  instance_type = "t2.micro"
  tags = {
    "Name" = "XCoin_Backend"
  }
}
