## SSH Over SSH Tunnel

**Scenario:**
LocalPC---[SSH]--->VM1 (Windows) in Cloud Provider1---[Port Forward]--->VM2 (Linux) Cloud Provider2

**Objective:**
SSH VM2 from LocalPC, through an SSH tunnel with VM1

**Configuration:**

Sample entries in ".ssh/config" in LocalPC

    Host VM1
      User <sshuser for VM1>
      Port 22
      Hostname <ip of VM1>
      LocalForward 2222 127.0.0.1:2222
      IdentityFile <ssh pem file for VM1>
    
    Host VM2
      User <sshuser for VM2>
      Port 2222
      HostName 127.0.0.1
      IdentityFile <ssh pem file for VM2>

Run below command in VM1

    netsh interface portproxy add v4tov4 listenaddress=0.0.0.0 listenport=2222 connectaddress=<ip for VM2> connectport=22

Now Connect VM2 from LocalPC

    ssh VM2

