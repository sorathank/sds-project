data "template_file" "app_user_data" {
  template = file("./scripts/app_script.sh")
  vars = {
    database_name = var.database_name
    database_user = var.database_user
    database_pass = var.database_pass
    admin_user = var.admin_user
    admin_pass = var.admin_pass
    PUBLIC_IP = aws_eip.public_ip.public_ip
    BUCKET_NAME = aws_s3_bucket.app_s3.bucket
    ACCESS_ID = aws_iam_access_key.app_key.id
    ACCESS_SECRET = aws_iam_access_key.app_key.secret
    BUCKET_DOMAIN = aws_s3_bucket.app_s3.bucket_domain_name
    REGION = var.region
  }
}

resource "aws_instance" "app" {
    ami = var.ami
    instance_type = "t2.micro"
    key_name = aws_key_pair.key.key_name
    
    network_interface {
      network_interface_id = aws_network_interface.app_igw.id
      device_index = 0
    }

    network_interface {
      network_interface_id = aws_network_interface.app_db.id
      device_index = 1
    }

    user_data = data.template_file.app_user_data.rendered

    tags = {
      "Name" = "App"
    }
}

data "template_file" "db_user_data" {
  template = file("./scripts/db_script.sh")
  vars = {
    database_user = var.database_user
    database_pass = var.database_pass
    database_name = var.database_name
  }
}

resource "aws_instance" "database" {
    ami = var.ami
    instance_type = "t2.micro"
    key_name = aws_key_pair.key.key_name
    
    network_interface {
      network_interface_id = aws_network_interface.db_ngw.id
      device_index = 0
    }

    network_interface {
      network_interface_id = aws_network_interface.db_app.id
      device_index = 1
    }

    user_data = data.template_file.db_user_data.rendered

    tags = {
      "Name" = "db"
    }
}
