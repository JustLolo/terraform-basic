# AWS Tips/Extras

## Credential/Config Storage

<mark style="color:green;">**Linux**</mark>

* `~/.aws`&#x20;
* `$HOME/.aws`



<mark style="color:green;">**Windows**</mark>

* `%USERPROFILE%/.aws`



## **Autocompletion**

{% embed url="https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-completion.html#cli-command-completion-windows" %}

{% hint style="info" %}
* Using <mark style="color:green;">**Windows:**</mark>** In **<mark style="color:green;">**PowerShell**</mark>** running as admin run:**

`Set-ExecutionPolicy RemoteSigned`

``

* this has to be done because the PowerShell has a <mark style="color:red;">**restricted**</mark> profile for running scripts, and in the command completion guide you has create a initialization script
{% endhint %}

* TAB -> autocompletion
* Ctrl + Space -> list of commands
