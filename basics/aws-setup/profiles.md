---
description: Multiple profiles
---

# Profiles

****[**Located**](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html#cli-configure-files-where) in **`~/.aws/config`**

It can be configure manually.

## [**Returning the list of profiles**](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html#cli-configure-files-methods)****

`aws configure list-profiles`&#x20;



## [Returning info about the profile being used](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html#cli-configure-files-methods)

`aws configure list`

****

## **Set the** [**environment variable**](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html#envvars-set) **** `AWS_PROFILE`

`setx AWS_PROFILE=test`

{% hint style="info" %}
* <mark style="color:green;">**test**</mark> will be the profile used by all the terminals.
* It takes effect after reopening the terminals.
{% endhint %}



## **- Set the** [**environment variable**](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html#envvars-set) **** `AWS_PROFILE` <mark style="color:red;">**only**</mark>** in the actual CLI**

`set AWS_PROFILE test --> Windows`

``

`export AWS_PROFILE=test --> Linux` (add this line to \~/.bashrc bc this modification in bash is temporary)

**Example of the previous explanation:**

`echo export AWS_PROFILE=test >> ~/.bashrc`



## **Refences**

[https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)

[https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html)

