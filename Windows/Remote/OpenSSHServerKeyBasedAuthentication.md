## On SSH Client Machine (Windows10)

    ssh-keygen -t ed25519

Copy Public Key File {User Profile}\.ssh\id_ed25519.pub to Server (Windows Server 2012)

## On SSH Server (Windows Server 2012)

Append Public Key File Contents to below files as appropriate

    {Server User Profile}\.ssh\authorized_keys
    C:\ProgramData\ssh\authorized_keys
    C:\ProgramData\ssh\administrators_authorized_keys

OpenSSHServer Configured with Key-Based authentication

    #File: C:\ProgramData\ssh\sshd_config
    StrictModes no
    PubkeyAuthentication yes    
    AuthorizedKeysFile	.ssh/authorized_keys
    Match Group administrators
           AuthorizedKeysFile __PROGRAMDATA__/ssh/administrators_authorized_keys

Restart OpenSSHServer service

## Start SSH Session from SSH Client Machine (Windows10)

 ### Full commandline to Connect: With Keys Authentiation
 
       ssh user@server -i {User Profile}\.ssh\id_ed25519 -p 22
       
 ### Or through .ssh configuration ({User Profile}\\.ssh\config) file to Connect
 
     
        #usage: "ssh WindowsServer1"

        Host WindowsServer1
          User {username}
          Port 22
          Hostname {server name or fqdn}
          IdentityFile {User Profile}\.ssh\id_ed25519

Connect through command
    
         ssh WindowsServer1

[Reference](https://woshub.com/using-ssh-key-based-authentication-on-windows/)
