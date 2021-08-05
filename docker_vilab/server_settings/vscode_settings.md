# Visual Studio Code settings
1. Download Docker on Local PC
2. Download Visual Studio Code Extensions
3. Establish SSH-Key Based Connection to Server
4. Develop on Remote Container with Visual Studio Code
* referenced by https://medium.com/sjk5766/vs-code-local-remote-container-%EA%B0%9C%EB%B0%9C%ED%99%98%EA%B2%BD-ad0b2c2eb472

## 1. Download Docker on Local PC
* https://docs.docker.com/get-docker/
* Execute docker at least once.


## 2. Download Visual Studio Code Extensions
- Remote - SSH
- Remote - Containers
- Remote Development

![vscode_extensions](imgs/vscode_extensions.png "vscode extensions")


## 3. Establish SSH-Key Based Connection to Server
### a) SSH-Keygen
* https://git-scm.com/book/en/v2/Git-on-the-Server-Generating-Your-SSH-Public-Key
* after creating ssh key, there must be id_rsa and id_rsa.pub in \~/.ssh

### b) Edit Config File
1. Ctrl + Shift + P -> Remote-SSH: Open SSH Configuration File
2. Type Alias, HostName, User and IdentityFile

![vscode_config](imgs/vscode_config.png "config file")

### c) Add public key to Authorized_keys in Server
* paste the contents in \~/.ssh/id_rsa.pub (in local) to \~/.ssh/authorized_keys (in server)


## 4. Develop on Remote Container with Visual Studio Code
![vscode_ssh](imgs/vscode_ssh.png "ssh with vscode")
![vscode_workspace](imgs/vscode_workspace.png "access to workspace")
![vscode_container](imgs/vscode_container.png "access to container with vscode")

