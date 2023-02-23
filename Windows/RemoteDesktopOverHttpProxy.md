# Connecting to a Windows2012 Server, through Remote Desktop Client (Windows10), which sits on a Private Network, Having http proxy configured.

## 1. Requirements Windows2012 Server Or Higher

### OpenSSHServer Configured in Windows2012 Server & Password | Key-Based authentication is enabled

    #File: C:\ProgramData\ssh\sshd_config
    StrictModes no
    PasswordAuthentication yes
    PubkeyAuthentication yes    
    AuthorizedKeysFile	.ssh/authorized_keys
    Match Group administrators
           AuthorizedKeysFile __PROGRAMDATA__/ssh/administrators_authorized_keys

## 2. Requirements Windows10 Client

### OpenSSHClient Or Similar available (putty or ssh from Git Installation)
    C:\Windows\System32\OpenSSH\ssh.exe

### Connect Command Or Similar Available

    {Git Install Directory}\mingw64\bin\connect.exe
    
Place Holders

    proxy server : proxy.domain.com:8080
    

## 3. Connect SSH from Client To Server, with Local Port Forwarding (Tunneling RDP Protocol Over SSH)

### Full Command Line to Connect: With Password Authentication

      ssh -L 3389:localhost:3389 user@server -p 22 
      -o "ProxyCommand "{Git Install Directory}\mingw64\bin\connect.exe" 
      -H proxy.domain.com:8080 %h %p
 
 ### Full commandline to Connect: With Keys Authentiation
 
       ssh -L 3389:localhost:3389 user@server  
       -i {User Profile}\.ssh\id_ed25519 -p 22
       -o "ProxyCommand "{Git Install Directory}\mingw64\bin\connect.exe"
       -H proxy.domain.com:8080 %h %p"
       
 ### Or through .ssh configuration ({User Profile}\\.ssh\config) file to Connect
 
     
        #usage: "ssh WindowsServer1"

        #if using {Git Install Directory}\usr\bin\ssh.exe
        #ProxyCommand "/C/Program Files/Git/mingw64/bin/connect.exe" -H proxy.domain.com:8080 %h %p

        #if using ssh.exe (C:\Windows\System32\OpenSSH\ssh.exe)
        ProxyCommand {Git Install Directory}\\mingw64\\bin\\connect.exe -H proxy.domain.com:8080 %h %p

        Host WindowsServer1
          User {username}
          Port 22
          Hostname {server name or fqdn}
          LocalForward 3389 127.0.0.1:3389

Connect through command
    
         ssh WindowsServer1
         
## 3. Connect Remote Desktop from Client To Server, through Local Port 3389

        mstsc /v localhost:3389

