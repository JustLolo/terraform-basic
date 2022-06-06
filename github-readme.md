# github readme



based on this course: https://www.youtube.com/playlist?list=PL5\_Rrj9tYQAlgX9bTzlTN0WzU67ZeoSi\_

> > you need to install git

> > You can write outputs you need in the file "outputs.tf" (useful for automation) use "terraform outputs" to get the outputs of the actual state

> > modify terraform.tfvars to change de default variables values

vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

> VARIABLES order of priority < ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> > > (3rd) <<< use: terraform console var.host\_os exit

* to check the what the variable value is

> > > (2nd) <<< use: terraform \[apply|plan|console] -var="host\_os=windows"

* when you want to use this as a variable script, modifiying host\_os variable

> > > (1st) <<< use: terraform apply/plan/console -var-file="dev.tfvar"

* when you want this file takes preference as source of variables values instead of the default file (terraform.tfvars) -useful when you have several EC2 instances you want to handle
