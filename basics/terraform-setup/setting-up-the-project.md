---
description: aka configuring the provider
---

# Setting up the project

### [Configuring the provider documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#shared-configuration-and-credentials-files)

### Create the folder of the project

```
mkdir yourProjectName
cd yourProjectName
nano provider.tf
```

### **Copy and paste this file/content (provider.tf) in the project folder**

{% embed url="https://github.com/JustLolo/terraform-basic/blob/main/providers.tf" %}
Configuration file used to config the provider
{% endembed %}

* [Basic Provider Configuration reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#example-usage)
* [Using previously **AWS CLI** configured credentials](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#shared-configuration-and-credentials-files)



### Initialize the project

`terraform init`

`terraform plan`

``

If you get no errors, it means that terraform **is** connected to your aws account properly using the profile you set in provider.tf
