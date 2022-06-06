# Basics

[https://www.terraform.io/language](https://www.terraform.io/language)

The syntax of the Terraform language consists of only a few basic elements:

```hcl
resource "aws_vpc" "main" {
  cidr_block = var.base_cidr_block
}

<BLOCK TYPE> "<BLOCK LABEL>" "<BLOCK LABEL>" {
  # Block body
  <IDENTIFIER> = <EXPRESSION> # Argument
}
```
