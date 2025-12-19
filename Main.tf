############################
# EXISTING SECURITY GROUP
############################
data "aws_security_group" "my_ec2" {
  id = "sg-0a24d6727126631f8"
}

############################
# EXISTING SUBNET
############################
data "aws_subnet" "my_subnet" {
  id = "subnet-0467b56ebff6602dc"
}

############################
# EC2 INSTANCE
############################
resource "aws_instance" "web" {
  ami                    = "ami-02b8269d5e85954ef" # change your ami name
  instance_type          = "t2.medium"
  key_name               = "kubeadm"

  subnet_id              = data.aws_subnet.my_subnet.id
  vpc_security_group_ids = [data.aws_security_group.my_ec2.id]

  user_data = templatefile("./script.sh", {})

  tags = {
    Name = "swiggy-base-server"
  }

  root_block_device {
    volume_size = 30
  }
}
