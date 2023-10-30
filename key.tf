resource "aws_key_pair" "codecraft_keypair" {
  key_name   = "codecraft_keypair"
  public_key = file("~/.ssh/id_rsa.pub")
}
