resource "aws_instance" "xcoin" {
  ami                                  = "ami-04b70fa74e45c3917"
  instance_type                        = "t2.micro"
  key_name                             = data.aws_key_pair.xcoin_mongodb_key.key_name
  subnet_id = "subnet-0f021f052c2eb5708"
  tags = {
    "Name" = "XCoin_MongoDB"
  }
  vpc_security_group_ids = [
    "sg-03ab2f96caa5f8ddd",
  ]
}

resource "aws_instance" "github_runner" {
  ami                                  = "ami-04b70fa74e45c3917"
  instance_type                        = "t2.micro"
  key_name                             = data.aws_key_pair.github_runner_key.key_name
  subnet_id = "subnet-0f021f052c2eb5708"
  tags = {
    "Name" = "XCoin_GithubRunner_IaC"
  }
  vpc_security_group_ids = [
    "sg-03ab2f96caa5f8ddd",
  ]
}

resource "aws_instance" "github_runner_febe" {
  ami                                  = "ami-04b70fa74e45c3917"
  instance_type                        = "t2.medium"
  key_name                             = data.aws_key_pair.github_runner_key.key_name
  subnet_id = "subnet-0f021f052c2eb5708"
  root_block_device {
    volume_size = 50
    volume_type = "gp2"
    delete_on_termination = true
  }
  tags = {
    "Name" = "XCoin_GithubRunner_febe"
    "demo" = "demo xcoin"
  }
  vpc_security_group_ids = [
    "sg-03ab2f96caa5f8ddd",
  ]
}

resource "aws_eip" "mongodb_eip" {
  instance = aws_instance.xcoin.id
}

resource "aws_eip" "githubrunner_eip" {
  instance = aws_instance.github_runner.id
}

resource "aws_eip" "githubrunner_febe_eip" {
  instance = aws_instance.github_runner_febe.id
}