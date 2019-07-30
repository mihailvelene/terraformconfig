# Configure the AWS Provider
provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
  access_key = "AKIA2SPEWAVFRIZRFNOG"
  secret_key = "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"
}

# Create a VPC
resource "aws_instance" "mytfboxfuse" {
 ami = "ami-0cfee17793b08a293"
 instance_type = "t2.micro"
 key_name = "terraformkey"
  provisioner "remote-exec" {

    inline = [
     "sudo apt-get update",
     "sudo apt-get install -y tomcat8 git default-jdk maven",
     "sudo git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git",
     "cd boxfuse-sample-java-war-hello && sudo mvn package && sudo cp target/hello-1.0.war /var/lib/tomcat8/webapps",
     "sudo systemctl restart tomcat8",
]

    connection {  
      type        = "ssh"
      port        = 22
      user        = "ubuntu"
      private_key = "${file("/workdir/terraformkey.pem")}"
      timeout     = "1m"
      agent       = false
    }

}
}
