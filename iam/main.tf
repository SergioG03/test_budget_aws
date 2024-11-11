resource "aws_iam_user" "user1" {
  name = var.user1_name
  path = "/users/"

  tags = {
    nombre = "Sergio Gonzalo"
    iac    = "terraform"
    env    = "Automatización y despliegue"
  }
}

resource "aws_iam_user" "user2" {
  name = var.user2_name
  path = "/users/"

  tags = {
    nombre = "Sergio Gonzalo"
    iac    = "terraform"
    env    = "Automatización y despliegue"
  }
}

import {
  to = aws_iam_user.user1
  id = var.user1_name
}

import {
  to = aws_iam_user.user2
  id = var.user2_name
}


