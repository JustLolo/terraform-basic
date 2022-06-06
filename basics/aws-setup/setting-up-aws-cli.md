# Setting up AWS CLI

[Official website](https://docs.aws.amazon.com/cli/index.html) - Just for reference purposes.

## Installing AWS CLI

[Installation process](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) - It doesn't need explanation

<mark style="background-color:orange;">**NOTE:**</mark> Window users have to check the **path variables** opening cmd once AWS CLI is installed, and using the following command for this purpose:

`aws --version`

## [Configuring Credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)

<mark style="color:green;">**Default Profile:**</mark>

In the CLI run `aws configure` and use the info contained in the credential .csv file created [here](creating-an-user.md#creating-a-admin-user):

```
AWS Access Key ID [None]: FILL_THIS_1
AWS Secret Access Key [None]: FILL_THIS_2
Default region name [None]: us-west-2
Default output format [None]: json
```

<mark style="background-color:orange;">**NOTE:**</mark> AWS CLI will use this profile by default



<mark style="color:green;">**Specific Profile:**</mark>

Assuming the IAM user created is named <mark style="color:green;">**test**</mark>:

```
aws configure import --csv file://%USERPROFILE%/SomeDirectory/credentials.csv
aws configure set region us-west-2 --profile test

////////
// Setting the environment variables
$ setx AWS_PROFILE=test                      --> Windows
$ echo export AWS_PROFILE=test >> ~/.bashrc  --> Linux
```

This will create a profile named <mark style="color:green;">**test**</mark> <mark style="color:green;"></mark><mark style="color:green;"></mark> and will be set up by default.
