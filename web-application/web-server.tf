provider "aws" {
    region = "us-east-1"
    access_key = ACCESSKEY
    secret_key = SECRETKEY
}

resource "aws_instance" "web-server" {
    ami = "ami"
    instance_type = "t2.micro"

    user_data = <<-EOF

    #!/bin/bash
    sudo su
    yum update -y
    yup install httpd -y
    systemctl start httpd
    systemctl enable httpd
    echo "<html>" >> /var/www/html/index.html
    echo "<head>" >> /var/www/html/index.html
    echo "<title>Hello World</title>" >> /var/www/html/index.html
    echo "</head>" >> /var/www/html/index.html
    echo "<body>" >> /var/www/html/index.html
    echo "<h1>Hello World!</h1>" >> /var/www/html/index.html
    echo "</body>" >> /var/www/html/index.html
    echo "</html>" >> /var/www/html/index.html
    EOF

    tags = {
        Name = "web-server"
        Owner = "DevOps"
    }

}