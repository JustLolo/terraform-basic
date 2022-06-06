# Creating an User

## Creating a Admin user

In order to access AWS terraform needs an account with the required privileges, this section will create a user that will have admin privileges for that purpose. [\[1\]](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-prereqs.html#getting-started-prereqs-keys)



Assuming you have an AWS account and you have full privileges just do the following steps (if you are a visual person use [this](https://youtu.be/9XsnL9n-fJg)):

1. &#x20;Open [https://console.aws.amazon.com/console/home](https://console.aws.amazon.com/console/home)
2. Go to the region [us-west-2](https://us-west-2.console.aws.amazon.com/console/home)
3. Go to [IAM ](https://us-east-2.console.aws.amazon.com/iamv2/home)(just write IAM in the search bar and click on it)
4. Click on <mark style="background-color:blue;">**Users**</mark> located in the navigation bar in the **Access management** section.
5. Click on <mark style="background-color:blue;">**Add Users**</mark>** **<mark style="color:green;">**button**</mark>

**1 - Set user details**

* [ ] Set an user name
* [ ] Check <mark style="background-color:blue;">**Access key - Programmatic access**</mark>
* [ ] Click on <mark style="background-color:blue;">**Next: Permissions**</mark>** **<mark style="color:green;">**button**</mark>

**2 - Permissions**

* [ ] Click on <mark style="background-color:blue;">**Attach existing policies directly**</mark>
* [ ] Check <mark style="background-color:blue;">**AdministratorAccess**</mark>
* [ ] Click on ** **<mark style="background-color:blue;">**Next: Tags**</mark>**  **<mark style="color:green;">**button**</mark>

**3 - Tags (optional)**

* [ ] Set whatever tag you want if you want
* [ ] Click on ** **<mark style="background-color:blue;">**Next: review**</mark>**  **<mark style="color:green;">**button**</mark>

**4 - Review**

* [ ] Click on <mark style="background-color:blue;">**Create User**</mark>**  **<mark style="color:green;">**button**</mark>

**5 - Complete**

* [ ] Click on <mark style="background-color:blue;">**Download .csv**</mark>**  **<mark style="color:green;">**button**</mark>
* [ ] <mark style="color:red;">**Keep this file in a secure place**</mark>, if someone gets access to this file could use your admin credentials to <mark style="color:red;">**burn money**</mark> in AWS <mark style="color:red;">**probably mining crypto.**</mark>
