---
description: https://www.terraform.io/language/files
---

# Files and Directories

## 1 - File Extensions

Code in the Terraform language is stored in plain text files with the `.tf` <mark style="color:green;">**file extension**</mark>. There is also [a JSON-based variant of the language](https://www.terraform.io/language/syntax/json) that is named with the `.tf.json` file extension.



## 2 - Modules

* A _module_ is a collection of `.tf` and/or `.tf.json` files kept together in a directory.
* A Terraform module <mark style="color:green;">**only consists**</mark> of the **top-level configuration files in a directory**;
* <mark style="color:green;">**Nested directories**</mark> are treated as completely separate modules, and are ** **<mark style="color:red;">**not**</mark> automatically included in the configuration.
* <mark style="color:green;">**Separating**</mark> various blocks into <mark style="color:green;">**different files**</mark> is purely for the convenience of readers and maintainers, and **has no effect on the module's behavior.**
* A Terraform module can use [module calls](https://www.terraform.io/language/modules) to explicitly include other modules into the configuration.&#x20;

<mark style="color:green;">****</mark>





